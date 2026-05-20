function event_spawn(e)
	eq.zone_emote(MT.White,"A roar fills the lower temple halls! The smell of burning ozone and decay fills the air!");
	eq.set_timer("depop", 30 * 60 * 1000);
end

function event_combat(e)
	if e.joined then
		if not eq.is_paused_timer("depop") then
			eq.pause_timer("depop");
		end
	else
		eq.resume_timer("depop");
		e.self:SaveGuardSpot(e.self:GetX(),e.self:GetY(), e.self:GetZ(), e.self:GetHeading());
	end
end

function event_timer(e)
	if e.timer == "depop" then
		eq.depop();
	end
end

local function ssra_state_id()
	local expedition = eq.get_expedition()
	if expedition.valid then
		local uuid = expedition:GetUUID()
		if uuid ~= "" then
			return "dz_" .. uuid
		end
	end

	local instance_id = eq.get_zone_instance_id()
	if instance_id > 0 then
		return "inst_" .. instance_id
	end

	return "0"
end

function event_killed_merit(e)
	local account_id = e.other:AccountID()
	local char_name = e.other:GetCleanName()
	eq.set_data("luclin_glyphserpent_" .. account_id, char_name)
	local first_key = "first_kill_glyphserpent"
	if eq.get_data(first_key) == "" and not e.other:GetGM() then
		eq.set_data(first_key, char_name)
		eq.world_emote(15, "SERVER FIRST! " .. char_name .. " and their group have slain a glyph covered serpent for the first time on this server!")
	end
end

function event_death_complete(e)
	eq.signal(162255,1); -- #cursed_controller
	eq.set_data("ssra_glyphed_" .. ssra_state_id(), "1", "D1");
end
