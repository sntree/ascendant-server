-- Emperor room event snakes: strip all loot on death
function event_death(e)
    e.self:ClearItemList();
    e.self:RemoveCash();
end
