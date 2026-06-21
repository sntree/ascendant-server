function event_combat(e)
	if e.joined then
		eq.signal(201450, 8); -- NPC: #Event_Torture_Control
	end
end

function event_death_complete(e)
	eq.signal(201450, 7); -- NPC: #Event_Torture_Control
end
