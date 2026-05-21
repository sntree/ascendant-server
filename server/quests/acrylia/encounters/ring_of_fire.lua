-- Ring of Fire encounter

local event_npcs     = {154114, 154093, 154072, 154080, 154099, 154356, 154357, 154358, 154359, 154360, 154361};
local trash_mobs     = {154114, 154093, 154072, 154080, 154099};
local boss_mobs      = {154356, 154357, 154358, 154359, 154360, 154361};
local grims          = {154124, 154132, 154124};
local warder         = 154337;
local controller_npc = 154091;

local boss_locs  = {{-83, 13, -30, 0}, {-104, 62, -30, 0}};
local grim_locs  = {{-86, 99, -30, 333}, {-100, 112, -29, 294}, {-139, 102, -29, 192}, {-135, 59, -29, 52}};
local warder_loc = {-96, -15, -30, 30};

local round   = 0;
local wave    = 0;
local started = false;

function evt_controller_spawn(e)
	reset_event();
end

function evt_controller_enter(e)
	if not started then
		eq.clear_proximity();
		setup_event();
	end
end

function evt_controller_timer(e)
	eq.stop_timer(e.timer);
	if e.timer == "main" then
		if player_check() then
			local next_timer = process_wave();
			eq.set_timer("main", next_timer * 1000);
		else
			reset_event();
		end
	end
end

local function is_event_spawn(npc)
	return npc:GetSpawnPointID() == 0;
end

function evt_add_spawn(e)
	if is_event_spawn(e.self) then
		eq.set_timer("depop", 60 * 1000);
	end
end

function evt_add_combat(e)
	if not is_event_spawn(e.self) then
		return;
	end

	if e.joined then
		eq.stop_timer("depop");
	else
		eq.set_timer("depop", 60 * 1000);
	end
end

function evt_add_timer(e)
	if e.timer == "depop" then
		e.self:Say("The trespassers have been slain. Glory to the master!");
		eq.depop();
	end
end

function process_wave()
	wave = wave + 1;

	if round == 0 then
		round, wave = 1, 1;
		spawn_trash(round);
		return 30;
	elseif round <= 2 then
		if wave < 5 or (wave > 5 and wave < 10) then
			spawn_trash(round);
			return 30;
		elseif wave == 5 then
			spawn_mini();
			return 60;
		else
			spawn_boss(round);
			round, wave = end_round(round, wave);
			return 90;
		end
	elseif round >= 3 and round <= 6 then
		if wave == 12 then
			spawn_boss(round);
			round, wave = end_round(round, wave);
			return math.random(90, 120);
		elseif wave % 5 == 0 then
			spawn_mini();
			return 60;
		else
			spawn_trash(round);
			return 30;
		end
	else
		eq.depop_all(warder);
		reset_event();
		return 5 * 60;
	end
end

function end_round(rnd, wav)
	return rnd + 1, 0;
end

function spawn_mini()
	local x, y, z, h = math.random(-124, -110), math.random(74, 90), -27, math.random(510);
	local mob = eq.ChooseRandom(boss_mobs[1], boss_mobs[2]);
	eq.spawn2(mob, 0, 0, x, y, z, h);
end

function spawn_trash(rnd)
	local mob_count = 0;

	if rnd <= 3 then
		mob_count = math.random(1, 3);
	elseif rnd == 4 or rnd == 5 then
		mob_count = math.random(2, 4);
	elseif rnd == 6 then
		mob_count = math.random(2, 5);
	end

	for i = 1, mob_count do
		local x, y, z, h = math.random(-124, -110), math.random(74, 90), -27, math.random(510);
		local mob;
		if rnd <= 4 then
			mob = eq.ChooseRandom(trash_mobs[1], trash_mobs[2]);
		elseif rnd == 5 then
			mob = eq.ChooseRandom(trash_mobs[3], trash_mobs[4]);
		elseif rnd == 6 then
			mob = eq.ChooseRandom(trash_mobs[3], trash_mobs[4], trash_mobs[5]);
		end

		eq.spawn2(mob, 0, 0, x, y, z, h);
	end
end

function spawn_boss(rnd)
	local boss = eq.spawn2(boss_mobs[rnd], 0, 0, unpack(boss_locs[1]));
	boss:Say("I now serve the master of the grimling horde. You too shall be reborn!");
	boss:CastToNPC():MoveTo(-104, 62, -28, 0, true);
end

function reset_event()
	cleanup();
	round = 0;
	wave = 0;
	started = false;
	eq.set_proximity(-124, -110, 74, 90);
end

function setup_event()
	if not eq.has_timer("main") then
		eq.local_emote({-120, 80, -25}, 15, 150, "As you step into the grimlings' ring of fire, a hot breeze blows into the cavern and begins swirling about you. The grimlings' constant chanting seems to grow louder...");

		for _, v in pairs(grim_locs) do
			local mob = eq.ChooseRandom(unpack(grims));
			eq.spawn2(mob, 0, 0, unpack(v));
		end

		eq.spawn2(warder, 0, 0, unpack(warder_loc));
		eq.set_timer("main", 1000);
		started = true;
	end
end

function cleanup()
	eq.stop_all_timers();
	eq.signal(warder, 1, 3 * 1000);

	for _, v in pairs(grims) do
		eq.depop_all(v);
	end
end

function player_check()
	local player_list = eq.get_entity_list():GetClientList();

	if player_list ~= nil then
		for player in player_list.entries do
			if player:CalculateDistance(-118, 81, -26) <= 15 and not player:GetFeigned() then
				return true;
			end
		end
	end

	return false;
end

function event_encounter_load(e)
	eq.register_npc_event("ring_of_fire", Event.spawn, controller_npc, evt_controller_spawn);
	eq.register_npc_event("ring_of_fire", Event.enter, controller_npc, evt_controller_enter);
	eq.register_npc_event("ring_of_fire", Event.timer, controller_npc, evt_controller_timer);

	for i = 1, #event_npcs do
		eq.register_npc_event("ring_of_fire", Event.spawn, event_npcs[i], evt_add_spawn);
		eq.register_npc_event("ring_of_fire", Event.combat, event_npcs[i], evt_add_combat);
		eq.register_npc_event("ring_of_fire", Event.timer, event_npcs[i], evt_add_timer);
	end
end
