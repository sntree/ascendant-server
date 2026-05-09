function event_spawn(e)
  eq.set_timer('Depop', 600 * 1000);
	eq.spawn2(179044,0,0,-1807,1029,17.85,128); --xaui tatrua
	eq.spawn2(179045,0,0,-1804,1136,17.85,128); --vius tatrua
	eq.spawn2(179046,0,0,-1715,1034,19.73,0); --sheleric vis
	eq.spawn2(179046,0,0,-1714,1128,19.73,256); --sheleric vis
end

function event_combat(e)
  if e.joined then
    eq.stop_timer('Depop');
	eq.set_timer('repopadds', 300 * 1000);
  else
    eq.set_timer('Depop', 600 * 1000);
	eq.stop_timer('repopadds');
  end
end

function event_timer(e)
	if (e.timer == 'Depop') then
		eq.depop();
	elseif (e.timer == 'repopadds') then
		e.self:Say("Sivuelaeus Rulour ans Rashan!");
			if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(179174) then -- NPC: #Diabo_Tatrua
				eq.spawn2(179174,0,0,-1769,1038,17.13,126):AddToHateList(e.self:GetHateRandom(),1); -- NPC: #Diabo_Tatrua
			end
			if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(179181) then -- NPC: #Tavuel_Tatrua
				eq.spawn2(179181,0,0,-1769,1056,17.13,126):AddToHateList(e.self:GetHateRandom(),1); -- NPC: #Tavuel_Tatrua
			end
			if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(179164) then -- NPC: #Thall_Tatrua
				eq.spawn2(179164,0,0,-1769,1084,17.42,126):AddToHateList(e.self:GetHateRandom(),1); -- NPC: #Thall_Tatrua
			end
			if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(179173) then -- NPC: #Va_Tatrua
				eq.spawn2(179173,0,0,-1769,1116,17.13,126):AddToHateList(e.self:GetHateRandom(),1); -- NPC: #Va_Tatrua
			end
	end
end

function event_slay(e)
	local a = eq.ChooseRandom(179161,179147,179160,179142);

	eq.spawn2(a,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading());
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
