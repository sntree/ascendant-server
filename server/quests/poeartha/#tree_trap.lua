local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
   	local roll = math.random(100)
        if (roll >= 85) then
            eq.spawn2(218117,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --Calris Bristlebranch
            poe_trap.depop();
        else
            eq.spawn2(218086,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A_Tenacious_Arborean
            poe_trap.depop();
        end
	end
end
