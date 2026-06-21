local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
   	local roll = math.random(100)
        if (roll >= 85) then
            eq.spawn2(218065,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A Korascian Warlord
            poe_trap.depop();
        else
            eq.spawn2(eq.ChooseRandom(218048,218004),0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A Young Frog A Korascian Hunter
            poe_trap.depop();
        end
	end
end
