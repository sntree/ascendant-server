function event_spawn(e)
eq.set_timer("depop", 1800 * 1000);
end

function event_combat(e)
if e.joined then
eq.set_timer("OOBcheck", 6 * 1000);
eq.stop_timer("depop");
else
eq.stop_timer("OOBcheck");
eq.set_timer("depop", 1800 * 1000);
end
end


function event_timer(e)
	if(e.timer=="OOBcheck") then
		eq.stop_timer("OOBcheck");
			if (e.self:GetX() < 546 or e.self:GetX() > 994) then
				e.self:Say("Dresolik must not be disturbed!");
				e.self:CastSpell(2830, e.self:GetID())
				e.self:SetHP(e.self:GetMaxHP());
				e.self:GotoBind();
				e.self:WipeHateList();
			else
				eq.set_timer("OOBcheck", 6 * 1000);
			end
	elseif(e.timer == "depop") then
		eq.stop_timer("depop");
		eq.depop();
	end
end

function event_death_complete(e)
eq.unique_spawn(202366, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading()); -- NPC: A_Planar_Projection
eq.spawn2(212075,0,0,972,1918,-164,126); --a_warder_of_Dresolik (212075)
eq.spawn2(212075,0,0,1043,1918,-164,382); --a_warder_of_Dresolik (212075)
eq.spawn2(212075,0,0,1007,1980,-164,0); --a_warder_of_Dresolik (212075)
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_dresolik_" .. account_id, char_name)
	local first_key = "first_kill_dresolik"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain The Protector of Dresolik for the first time on this server!")
	end
end
