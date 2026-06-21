function event_death_complete(e)
	eq.spawn2(218068,0,0, 0, -823, 243, 255);	--A_Planar_Projection
	eq.get_entity_list():FindDoor(38):SetLockPick(0); --unlock fire chute
	eq.get_entity_list():FindDoor(39):SetLockPick(0); --unlock fire chute
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_solusekro_" .. account_id, char_name)
	local first_key = "first_kill_solusekro"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Solusek Ro for the first time on this server!")
	end
end

function event_combat(e)
	if e.joined then
		eq.set_timer("OOBcheck", 6 * 1000); -- 6 Sec OOB Check
	else
		eq.stop_timer("OOBcheck");
	end
end


function event_timer(e)
	if(e.timer=="OOBcheck") then
	eq.stop_timer("OOBcheck");
		if (e.self:GetZ() < 200) then
			e.self:Say("If you wish to challenge me, you must do it on my terms!");
			e.self:GotoBind();
			e.self:WipeHateList();
		else
			eq.set_timer("OOBcheck", 6 * 1000); -- 6 Sec OOB Check
		end
	end
end
