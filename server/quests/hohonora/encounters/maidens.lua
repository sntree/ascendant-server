--[[
--	Halls of Honor - Maidens Trial 
--	NPCs involved:
--
--	Room 1:
--	211060 Alekson_Garn
--	211076 A_Custodian_of_Marr_
--	211077 #a_norrathian_maiden
--	211080 a_crazed_norrathian
--	211085 #Advocent_Joran
--
--	Room 2: 
--	211078 #a_norrathian_maiden_
--	211082 #_a_crazed_norrathian
--	211084 #Halgoz_Rellinic
--
--	Room 3: 
--	211079 #_a_norathian_maiden
--	211083 a_crazed_norrathian_
--	211086 #Freegan_Haan
--
--	202368 A_Planar_Projection
--
--]]
local room = 0;          -- 0 = not started, 1..3 = the active chamber
local awaiting = true;   -- waiting for a player to say "ready" to begin/advance a chamber
local roomonemaid = 0;
local roomtwomaid = 0;
local roomthrmaid = 0;
local roomonetrash = 0;
local roomtwotrash = 0;
local roomthrtrash = 0;

-- Spawn a single chamber's maidens + attackers. Only one chamber is ever hot at
-- a time, so a solo player can defend it before advancing to the next.
function SpawnRoom(n)
	room = n;
	awaiting = false;

	if ( n == 1 ) then
		roomonemaid = 0;
		roomonetrash = 0;
		eq.spawn2(211077,0,0,-2468,-1725,-113,130); -- NPC: #a_norrathian_maiden
		eq.spawn2(211077,0,0,-2485,-1719,-113,0);
		eq.spawn2(211077,0,0,-2485,-1739,-113,256);
		eq.spawn2(211080,0,0,-2400,-1600,-113,320); -- NPC: a_crazed_norrathian
		eq.spawn2(211080,0,0,-2400,-1870,-113,462);
		eq.spawn2(211080,0,0,-2582,-1872,-113,41.2);
		eq.spawn2(211080,0,0,-2588,-1727,-113,462);
		eq.spawn2(211080,0,0,-2588,-1600,-113,41.2);
	elseif ( n == 2 ) then
		roomtwomaid = 0;
		roomtwotrash = 0;
		eq.spawn2(211078,0,0,-3190,-1725,-113,130); -- NPC: #a_norrathian_maiden_
		eq.spawn2(211078,0,0,-3172,-1740,-113,256);
		eq.spawn2(211078,0,0,-3172,-1705,-113,0);
		eq.spawn2(211082,0,0,-3318,-1841,-113,26); -- NPC: #_a_crazed_norrathian
		eq.spawn2(211082,0,0,-3319,-1725,-113,130);
		eq.spawn2(211082,0,0,-3299,-1621,-113,41.2);
		eq.spawn2(211082,0,0,-3034,-1636,-113,346);
		eq.spawn2(211082,0,0,-3034,-1816,-113,316);
	elseif ( n == 3 ) then
		roomthrmaid = 0;
		roomthrtrash = 0;
		eq.spawn2(211079,0,0,-3172,-1097,-113,0); -- NPC: #_a_norrathian_maiden
		eq.spawn2(211079,0,0,-3201,-1130,-113,384);
		eq.spawn2(211079,0,0,-3151,-1129,-113,130);
		eq.spawn2(211083,0,0,-3293,-1027,-113,172); -- NPC: a_crazed_norrathian_
		eq.spawn2(211083,0,0,-3027,-1035,-113,130);
		eq.spawn2(211083,0,0,-3035,-1229,-113,434);
		eq.spawn2(211083,0,0,-3303,-1229,-113,346);
		eq.spawn2(211083,0,0,-3168,-1028,-113,316);
	end

	eq.zone_emote(MT.Yellow, "Chamber " .. n .. " erupts in violence! Defend the maidens of Norrath from their attackers!");
end

-- Depop a chamber's leftover maidens/attackers once it has been secured.
function DespawnRoom(n)
	if ( n == 1 ) then
		eq.depop_all(211077);
		eq.depop_all(211080);
	elseif ( n == 2 ) then
		eq.depop_all(211078);
		eq.depop_all(211082);
	elseif ( n == 3 ) then
		eq.depop_all(211079);
		eq.depop_all(211083);
	end
end

function RoomOneTrashDeath(e)
	roomonetrash = roomonetrash + 1;
	if ( roomonetrash == 5 and roomonemaid < 3 ) then 
		eq.spawn2(211085,0,0,-2349,-1894,-113,466); -- NPC: #Advocent_Joran
	end
end

function RoomTwoTrashDeath(e)
	roomtwotrash = roomtwotrash + 1;
	if ( roomtwotrash == 5 and roomtwomaid < 3 ) then
		eq.spawn2(211084,0,0,-3337,-1617,-113,152.4); -- NPC: #Halgoz_Rellinic
	end
end

function RoomThreeTrashDeath(e)
	roomthrtrash = roomthrtrash + 1;
	if ( roomthrtrash == 5 and roomthrmaid < 3 ) then
		eq.spawn2(211086,0,0,-2996,-991,-113,306); -- NPC: #Freegan_Haun
	end
end

function RoomOneMaidenDeath(e)
	roomonemaid = roomonemaid + 1;
	-- If all the maidens in the room have died; the event has failed
	if ( roomonemaid == 3 ) then
		FailEvent();
	end
end

function RoomTwoMaidenDeath(e)
	roomtwomaid = roomtwomaid + 1;
	-- If all the maidens in the room have died; the event has failed
	if ( roomtwomaid == 3 ) then
		FailEvent();
	end
end

function RoomThreeMaidenDeath(e)
	roomthrmaid = roomthrmaid + 1;
	-- If all the maidens in the room have died; the event has failed
	if ( roomthrmaid == 3 ) then
		FailEvent();
	end
end

-- A chamber's boss died: that chamber is secured. Advance to the next, or win.
function RoomCleared(e, n)
	if ( room ~= n or awaiting ) then
		return;
	end
	DespawnRoom(n);
	if ( n >= 3 ) then
		WinEvent(e);
	else
		-- The chamber's named has fallen. Hold for a short breather, then the next
		-- chamber spawns automatically (no need to run back to Alekson Garn).
		awaiting = true;
		eq.zone_emote(MT.Yellow, "Chamber " .. n .. " is secured! The next chamber awakens in 15 seconds -- make your way there!");
		eq.signal(211060, 100); -- tell Alekson Garn (persistent) to start the next-chamber countdown
	end
end

function RoomOneBossDeath(e)   RoomCleared(e, 1); end
function RoomTwoBossDeath(e)   RoomCleared(e, 2); end
function RoomThreeBossDeath(e) RoomCleared(e, 3); end

-- Alekson Garn hosts the inter-chamber countdown; he is up for the whole trial,
-- so his timer survives the dying named that triggers it.
function AleksonSignal(e)
	if ( e.signal == 100 ) then
		eq.set_timer('nextroom', 15000); -- 15s after the prior named dies, the next chamber spawns
	end
end

function AleksonTimer(e)
	if ( e.timer == 'nextroom' ) then
		eq.stop_timer('nextroom');
		if ( awaiting and room >= 1 and room <= 2 ) then
			SpawnRoom(room + 1);
		end
	end
end

function WinEvent(e)
	eq.update_spawn_timer(44032,25920000000); --Alekson Garn 3 days on win
	eq.spawn2(202368,0,0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading() ); -- NPC: A_Planar_Projection
	eq.zone_emote(MT.Yellow, "The maidens are saved! You have proven yourself worthy to stand before Lord Marr.");
	DespawnEventMobs();
	room = 0;
	awaiting = true;
end

function FailEvent()
	eq.zone_emote(MT.Red, "The maidens have fallen. The trial is lost... regroup and tell Alekson Garn you are [ready] to try again.");
	-- Retry-friendly fail: depop the trial mobs but leave Alekson Garn (211060)
	-- up and fully reset state so the trial can be restarted immediately.
	eq.depop_all(211077);
	eq.depop_all(211078);
	eq.depop_all(211079);
	eq.depop_all(211080);
	eq.depop_all(211082);
	eq.depop_all(211083);
	eq.depop_all(211084);
	eq.depop_all(211085);
	eq.depop_all(211086);
	room = 0;
	awaiting = true;
	roomonemaid = 0;
	roomtwomaid = 0;
	roomthrmaid = 0;
	roomonetrash = 0;
	roomtwotrash = 0;
	roomthrtrash = 0;
end

function TimerSpawn(e)
	eq.set_timer('maidens', 7200000);
end

function MaidensTimer(e)
	if ( e.timer == 'maidens' ) then 
		FailEvent();
	end
end

function DespawnEventMobs()
	eq.depop_all(211060);
	eq.depop_all(211077);
	eq.depop_all(211078);
	eq.depop_all(211079);
	eq.depop_all(211080);
	eq.depop_all(211082);
	eq.depop_all(211083);
	eq.depop_all(211084);
	eq.depop_all(211085);
	eq.depop_all(211086);
end

function AleksonSay(e)
	if (e.message:findi("hail")) then 
		e.self:Say("Weakling! How dare you approach me. Access to Lord Marrs temple is reserved only for the honorable! You will never be [ready]...");
	elseif (e.message:findi("ready")) then
		if ( room == 0 ) then
			e.self:Say("Be warned, " .. e.other:GetName() .. ". You will face Lord Marr's servants one chamber at a time. Defend the maidens -- when a chamber's champion falls, the next will rise shortly after.");
			SpawnRoom(1);
		else
			e.self:Say("The trial is already underway. Defend the maidens and slay each chamber's champion!");
		end
	end
end

function event_encounter_load(e)
	-- register our NPC event hooks
	eq.register_npc_event("maidens", Event.say,            211060, AleksonSay);
	eq.register_npc_event("maidens", Event.signal,         211060, AleksonSignal);
	eq.register_npc_event("maidens", Event.timer,          211060, AleksonTimer);

	-- Hook a timer to each of the mobs which could end up lingering around with 
	-- this event.  Custodian and the Named in each room; if they are up for 
	-- 2hours; the event will despawn itself.  The timers are discarded when 
	-- each mob dies;  So when the Custodian dies his timer is discarded for the 
	-- purpose of the Event there will be 2hours once the first named spawns till 
	-- the Event cleans itself up.
	eq.register_npc_event("maidens", Event.spawn,			 211076, TimerSpawn);
	eq.register_npc_event("maidens", Event.timer,          211076, MaidensTimer);
	eq.register_npc_event("maidens", Event.spawn,			 211084, TimerSpawn);
	eq.register_npc_event("maidens", Event.timer,          211084, MaidensTimer);
	eq.register_npc_event("maidens", Event.spawn,			 211085, TimerSpawn);
	eq.register_npc_event("maidens", Event.timer,          211085, MaidensTimer);
	eq.register_npc_event("maidens", Event.spawn,			 211086, TimerSpawn);
	eq.register_npc_event("maidens", Event.timer,          211086, MaidensTimer);

	eq.register_npc_event("maidens", Event.death_complete, 211080, RoomOneTrashDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211082, RoomTwoTrashDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211083, RoomThreeTrashDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211077, RoomOneMaidenDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211078, RoomTwoMaidenDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211079, RoomThreeMaidenDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211084, RoomTwoBossDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211085, RoomOneBossDeath);
	eq.register_npc_event("maidens", Event.death_complete, 211086, RoomThreeBossDeath);
end

function event_encounter_unload(e)
	DespawnEventMobs();
end
