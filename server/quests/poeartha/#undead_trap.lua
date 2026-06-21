local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
     eq.spawn2(218133,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A_Decaying_Spelunker
     poe_trap.depop();
	end
end
