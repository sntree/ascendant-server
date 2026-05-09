function event_slay(e)
	eq.spawn2(179136,0,0,e.self:GetX() - 10,e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); -- NPC: A_mind_worm
	eq.spawn2(179136,0,0,e.self:GetX() + 10,e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); -- NPC: A_mind_worm
	eq.spawn2(179136,0,0,e.self:GetX(),e.self:GetY() - 10,e.self:GetZ(),e.self:GetHeading()); -- NPC: A_mind_worm
	eq.spawn2(179136,0,0,e.self:GetX(),e.self:GetY() + 10,e.self:GetZ(),e.self:GetHeading()); -- NPC: A_mind_worm
	eq.spawn2(179136,0,0,e.self:GetX(),e.self:GetY() + 15,e.self:GetZ(),e.self:GetHeading()); -- NPC: A_mind_worm
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("luclin_insanitycrawler_" .. account_id, char_name)
	local first_key = "first_kill_insanitycrawler"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain The Insanity Crawler for the first time on this server!")
	end
end
