-- Call of the Hero cast in Acrylia Caverns

function event_spell_effect(e)
	local caster = eq.get_entity_list():GetClientByID(e.caster_id);

	if caster.valid then
		caster:Message(MT.Red, "A voice whispers in your ear: There are no heroes here... except this one.");

		local hero = eq.spawn2(
			154098,
			0,
			0,
			caster:GetX() + math.random(-5, 5),
			caster:GetY() + math.random(-5, 5),
			caster:GetZ() + 1,
			0
		);

		hero:AddToHateList(caster, 100);
	end

	return -1;
end
