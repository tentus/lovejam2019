Inventory = {
    -- which items have been collected
    collected = {},

    -- which items (read: coins) have been used
    spent = {},
}


function Inventory:record(act, thing, qty)
    local bucket = self[act]
    bucket[thing] = (bucket[thing] or 0) + (qty or 1)
    Stats:add(thing .. ' ' .. act)
end


function Inventory:collect(thing, qty)
    self:record('collected', thing, qty)
end


function Inventory:spend(thing, qty)
    self:record('spent', thing, qty)
end


function Inventory:has(thing)
    return (self.collected[thing] or 0) > 0
end


function Inventory:total(thing)
    return (self.collected[thing] or 0) - (self.spent[thing] or 0)
end
