function event_combat(e)
	if e.joined then
		eq.set_timer("OOBcheck", 6 * 1000);
		eq.set_timer("heal", 750000);
	else
		eq.stop_timer("OOBcheck");
		eq.stop_timer("heal");
	end
end

function event_timer(e)
	if(e.timer=="OOBcheck") then
	eq.stop_timer("OOBcheck");
		if (e.self:GetY() < 1240) then
			e.self:CastSpell(2830, e.self:GetID())
			e.self:SetHP(e.self:GetMaxHP());
			e.self:GotoBind();
			e.self:WipeHateList();
		else
			eq.set_timer("OOBcheck", 6 * 1000);
		end
	elseif ( e.timer == "heal" ) then
		e.self:Emote("is immolated in flames, and is reborn!");
		e.self:Heal();
		e.self:CastSpell(1281, e.self:GetTarget():GetID()); -- Searing Flames
	end
end

function event_death_complete(e)
eq.unique_spawn(202367, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading()); -- NPC: A_Planar_Projection
eq.spawn2(212074,0,0,1713,1206,627,264); -- a_warder_of_Arlyxir (212074)
eq.spawn2(212074,0,0,1738,1206,627,264); -- a_warder_of_Arlyxir (212074)
eq.spawn2(212074,0,0,1726,1146,612,264); -- a_warder_of_Arlyxir (212074)
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_arlyxir_" .. account_id, char_name)
	local first_key = "first_kill_arlyxir"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Arlyxir for the first time on this server!")
	end
end
