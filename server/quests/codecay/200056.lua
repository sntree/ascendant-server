local stop_event_signal = 9000;

local event_timers = {
	"Fail",
	"Start",
	"bert_trash_watchdog",
	"force_darwol",
	"force_feig",
	"force_xhut",
	"force_kavillis",
	"force_raddi",
	"force_wavadozzik",
	"force_zandal",
	"force_akkapan",
	"force_final_adans",
};

function stop_event_timers()
	for _, timer_name in ipairs(event_timers) do
		eq.stop_timer(timer_name);
	end
end

function event_signal(e)
	if e.signal == stop_event_signal then
		stop_event_timers();
		return;
	end

	if e.signal ~= 1 then
		return;
	end

	stop_event_timers();
	eq.set_timer("Fail", 7200000);
	eq.set_timer("Start", 45000);
	eq.set_timer("bert_trash_watchdog", 60000);
	eq.set_timer("force_darwol", 600000);
	eq.set_timer("force_feig", 660000);
	eq.set_timer("force_xhut", 720000);
	eq.set_timer("force_kavillis", 780000);
	eq.set_timer("force_raddi", 1320000);
	eq.set_timer("force_wavadozzik", 1380000);
	eq.set_timer("force_zandal", 1440000);
	eq.set_timer("force_akkapan", 1500000);
	eq.set_timer("force_final_adans", 2160000);
end

function event_timer(e)
	if e.timer == "Start" then
	eq.stop_timer('Start');
	eq.zone_emote(MT.NPCQuestSay,"A foul wind is felt carrying on it the stench of death and decay.  Suddenly a thunderous bang is heard throughout the crypt and then these words, 'Great soldiers of decay you are summoned forth to do battle with these infidels!'  All around the crypt echoes of footsteps and shuffling feet are heard.");
	eq.spawn_condition("codecay", eq.get_zone_instance_id(), 1, 1);
	
	elseif e.timer == "Fail" then
		stop_event_timers();
		eq.depop_all(200043);
		eq.depop_all(200042);
		eq.depop_all(200062); -- Despawn all Quest NPC's that have spawned.
		eq.depop_all(200063);
		eq.depop_all(200064);
		eq.depop_all(200065);
		eq.depop_all(200046);
		eq.depop_all(200045);
		eq.depop_all(200044); -- Despawn all Kings if any spawned
		eq.depop_all(200047);
		eq.depop_all(200049);
		eq.depop_all(200048);
		eq.depop_all(200050);
		eq.depop_all(200051);
		eq.depop_all(200054);
		eq.depop_all(200053);
		eq.depop_all(200052);
		eq.depop_all(200022);
		eq.depop_all(200055);
		eq.depop_all(200056);
		eq.depop_all(200024);
		eq.spawn_condition("codecay", eq.get_zone_instance_id(), 1, 0);
	end
end
