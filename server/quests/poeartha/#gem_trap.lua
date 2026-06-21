local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
   	local roll = math.random(100)
        if (roll >= 85) then
            eq.spawn2(218087,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A Shimmering Gem Sentry
            poe_trap.depop();
        else
            eq.spawn2(eq.ChooseRandom(218088,218005),0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --A Glass Formation A Gemmed Guardian
            poe_trap.depop();
        end
	end
end
