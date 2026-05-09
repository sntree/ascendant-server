function event_combat(e)
if e.joined then
eq.spawn2(162280, 0, 0, 625, -356,  403,  0); --Ssraezsha (162280)
eq.spawn2(162280, 0, 0, 689, -356,  403,  0); --Ssraezsha (162280)
eq.spawn2(162280, 0, 0, 689, -293,  403,  0); --Ssraezsha (162280)
eq.spawn2(162280, 0, 0, 625, -293,  403,  0); --Ssraezsha (162280)
end
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("luclin_bloodssra_" .. account_id, char_name)
	local first_key = "first_kill_bloodssra"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Blood of Ssraeshza for the first time on this server!")
	end
end

function event_death_complete(e)
eq.signal(162260,1); -- #EmpCycle
end
