--This version of Shei is a simple non-aggro merchant. When killed, the true version of Shei will spawn.

function event_death_complete(e)
	eq.spawn2(179032,0,0,-1736,1082,22.6,126); -- NPC: #Shei_Vinitras
	eq.spawn2(179174,0,0,-1769,1038,17.13,126); -- NPC: #Diabo_Tatrua
	eq.spawn2(179181,0,0,-1769,1056,17.13,126); -- NPC: #Tavuel_Tatrua
	eq.spawn2(179164,0,0,-1769,1084,17.42,126); -- NPC: #Thall_Tatrua
	eq.spawn2(179173,0,0,-1769,1116,17.13,126); -- NPC: #Va_Tatrua
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("luclin_sheivinitras_" .. account_id, char_name)
	local first_key = "first_kill_sheivinitras"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Shei Vinitras for the first time on this server!")
	end
end
