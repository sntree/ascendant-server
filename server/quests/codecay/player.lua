-- player.lua codecay
function event_enter_zone(e)
	local qglobals = eq.get_qglobals(e.self);
	-- Instance-scoped cooldown key so concurrent codecay instances don't share the mage epic spawn lock.
	local inst = eq.get_zone_instance_id();
	local mage_key = (inst > 0) and (inst .. "_mage_epic_cod") or "mage_epic_cod";

	if(qglobals["mage_epic"] == "10" and qglobals[mage_key] == nil) then
		e.self:Message(MT.Yellow,"Your staff begins to glow");
	end
end

function event_click_door(e)
	local qglobals = eq.get_qglobals(e.self)
	-- chair to click down to bertox event
	if (e.door:GetDoorID() == 7) then
		if(qglobals["pop_cod_preflag"] == "1" or e.self:GetGM()) then
			e.self:MovePCInstance(200, eq.get_zone_instance_id(), 0, -16, -289, 256)
		else
			--made up
			e.self:Message(MT.Default, "There is still more work to be done.")
		end
	end
end

function event_loot(e)
	if(e.self:Class() == "Magician" and e.item:GetID() == 19544 and e.corpse:GetNPCTypeID()==200060) then
		local qglobals = eq.get_qglobals(e.self);
		if(qglobals["mage_epic"] == "10") then
			return 0;
		else
			return 1;
		end
	end
end		

