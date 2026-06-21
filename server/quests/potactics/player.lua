local RZTW_CONTROLLER = 214123; -- #rallos_trigger (Rallos Zek the Warlord event controller)

-- GM-only controls for the Rallos Zek the Warlord event. Say the command anywhere
-- in potactics; it signals the (invisible) controller so you don't have to find it.
function event_say(e)
	if e.self:Admin() < 100 then
		return;
	end

	local msg = e.message:lower();
	if not msg:find("rztw") then
		return;
	end

	if msg:find("reset") then
		e.self:Message(MT.Yellow, "[RZTW] Wiping the event and restoring the start (Berik/Grunhork).");
		eq.signal(RZTW_CONTROLLER, 90);
	elseif msg:find("phase 1") or msg:find("phase1") then
		e.self:Message(MT.Yellow, "[RZTW] Starting Phase 1 (Vallon/Tallon).");
		eq.signal(RZTW_CONTROLLER, 91);
	elseif msg:find("phase 2") or msg:find("phase2") then
		e.self:Message(MT.Yellow, "[RZTW] Starting Phase 2 (decoy Rallos).");
		eq.signal(RZTW_CONTROLLER, 92);
	elseif msg:find("phase 3") or msg:find("warlord") then
		e.self:Message(MT.Yellow, "[RZTW] Spawning Phase 3 - Rallos Zek the Warlord (214113).");
		eq.signal(RZTW_CONTROLLER, 93);
	else
		e.self:Message(MT.Yellow, "[RZTW] Commands: 'rztw reset', 'rztw phase1', 'rztw phase2', 'rztw warlord'.");
	end
end

function event_loot(e)
	if e.self:GetClass() == Class.MAGICIAN and e.item:GetID() == 16807 then -- Item: Elemental Essence of Fire
		local qglobals = eq.get_qglobals(e.self);

		if qglobals["mage_epic_fire1"] ~= nil and qglobals["mage_epic_fire1"] == "1" then
			if qglobals["mage_epic_potchest"] == nil then
				eq.spawn2(283157,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); -- a chest (epic 1.5)
				eq.set_global("mage_epic_potchest","1",5,"F");
			end
			return 0;
		else
			return 1;
		end
	end
end
