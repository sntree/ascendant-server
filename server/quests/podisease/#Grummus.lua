function event_combat(e)
if e.joined then
eq.set_timer("OOBcheck", 6 * 1000);
else
eq.stop_timer("OOBcheck");
end
end

function event_timer(e)
if(e.timer=="OOBcheck") then
eq.stop_timer("OOBcheck");
	if (e.self:GetX() < 1800) then
		e.self:GotoBind();
		e.self:WipeHateList();
	else
		eq.set_timer("OOBcheck", 6 * 1000);
	end
end
end


function event_death_complete(e)
eq.spawn2(202366, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading()); --A_Planar_Projection
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_grummus_" .. account_id, char_name)
	local first_key = "first_kill_grummus"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Grummus for the first time on this server!")
	end
end
