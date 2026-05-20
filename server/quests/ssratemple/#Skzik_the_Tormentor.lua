-- Emperor room event snakes: strip all loot on death
-- These mobs respawn every 90s as part of the Emperor encounter
-- and should not be farmable for loot/shards/tomes
function event_death(e)
    e.self:ClearItemList();
    e.self:RemoveCash();
end
