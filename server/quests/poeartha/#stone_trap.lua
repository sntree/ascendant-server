local poe_trap = require("poe_trap")

function event_combat(e)
	if e.joined then
   	local roll = math.random(100)
        if (roll >= 85) then
            eq.spawn2(218116,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --Galsinak Earthwalker
            poe_trap.depop();
        else
            eq.spawn2(eq.ChooseRandom(218036,218016),0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); --An Unfinished Stonewalker A stone Abomination
            poe_trap.depop();
        end
	end
end
