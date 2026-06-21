local EVENT_DURATION_SECONDS = 20 * 60;
local WAVE_INTERVAL_MS = 60 * 1000; -- seconds between clockwork carrier waves (tunable)

local event_active = false;

local device_ids = {
	206000,
	206001,
	206002,
	206069,
	206070,
	206071,
	206072,
	206086
};

local function event_key()
	return "poinnovation_mb_event_active_" .. tostring(eq.get_zone_instance_id());
end

local function cleanup_devices()
	for _, npc_id in ipairs(device_ids) do
		eq.depop_all(npc_id);
	end
end

local function spawn_wave()
	eq.spawn2(206000, 28, 0, 803, -285, 4.63, 314);
	eq.spawn2(206001, 29, 0, 804, 285, 4.63, 314);
	eq.spawn2(206002, 30, 0, 1443, 285, 4.63, 314);
	eq.spawn2(206086, 31, 0, 1443, -285, 4.63, 314);
	eq.spawn2(eq.ChooseRandom(206071, 206070), 26, 0, 1155, 605, 4.63, 0);
	eq.spawn2(eq.ChooseRandom(206072, 206069), 24, 0, 1155, -600, 4.63, 0);
end

local function stop_event()
	event_active = false;
	eq.stop_timer("spiders");
	eq.stop_timer("event_timeout");
	eq.delete_data(event_key());
	eq.signal(206046, 99);
	cleanup_devices();
end

local function start_event()
	if event_active then
		return;
	end

	if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(206046) then
		return;
	end

	event_active = true;
	eq.set_data(event_key(), "1", tostring(EVENT_DURATION_SECONDS + 120));
	eq.signal(206046, 99);
	cleanup_devices();
	eq.zone_emote(MT.NPCQuestSay, "Clockwork power carriers begin streaming toward the Manaetic Behemoth! Destroy them before they reach it -- starve the Behemoth of power and it will awaken, vulnerable, to your attack!");
	eq.signal(206046, 2);
	spawn_wave();
	eq.set_timer("spiders", WAVE_INTERVAL_MS);
	eq.set_timer("event_timeout", EVENT_DURATION_SECONDS * 1000);
end

function event_spawn(e)
	event_active = false;
	eq.delete_data(event_key());
	cleanup_devices();
	eq.set_proximity(700, 1550, -700, 700, -100, 150, false);
end

function event_enter(e)
	start_event();
end

function event_timer(e)
	if e.timer == "spiders" then
		if not event_active or not eq.get_entity_list():IsMobSpawnedByNpcTypeID(206046) then
			stop_event();
			return;
		end

		spawn_wave();
	elseif e.timer == "event_timeout" then
		eq.zone_emote(MT.NPCQuestSay, "The flow of power carriers finally ceases and the construction bay falls silent. The Manaetic Behemoth remains dormant.");
		stop_event();
	end
end
