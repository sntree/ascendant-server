local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
   	local roll = math.random(100)
        if (roll >= 85) then
            eq.spawn2(218074,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --Glimmerstone
            poe_trap.depop();
        else
            eq.spawn2(218046,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A young cave geonid
            poe_trap.depop();
        end
	end
end
