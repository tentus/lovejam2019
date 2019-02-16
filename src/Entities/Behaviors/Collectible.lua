-- behavior for items that can be permanently collected
Collectible = Class{
}


function Collectible:isCollected()
    return Inventory:has(self.classname)
end
