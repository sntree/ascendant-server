function event_death_complete(e)
eq.spawn2(202368,0,0,2380,-2,444,387); -- NPC: A_Planar_Projection
eq.depop_with_timer(220016); -- depop the trigger
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_mithanielmarr_" .. account_id, char_name)
	local first_key = "first_kill_mithanielmarr"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Lord Mithaniel Marr for the first time on this server!")
	end
end
