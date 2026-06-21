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
	if (e.self:GetY() < -918) then
		e.self:Emote("bellows in a deep voice, 'You shall not distract me from my conjurings!");
		e.self:GotoBind();
		e.self:WipeHateList();
	else
		eq.set_timer("OOBcheck", 6 * 1000);
	end
end
end

function event_death_complete(e)
	eq.unique_spawn(214105, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading()); --NPC: A_Planar_Projection
  eq.spawn2(212078,0,0,1836,-1040,291,256); --a_warder_of_Xuzl (212078)
  eq.spawn2(212078,0,0,1800,-1090,291,125); --a_warder_of_Xuzl (212078)
  eq.spawn2(212078,0,0,1879,-1090,291,385); --a_warder_of_Xuzl (212078)
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("pop_xuzl_" .. account_id, char_name)
	local first_key = "first_kill_xuzl"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain Xuzl for the first time on this server!")
	end
end
