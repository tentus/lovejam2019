HealthUpgrade = Class{
    __includes = {BaseItem, Collectible},
    classname = 'HealthUpgrade',

    sprite = SpriteComponent('assets/sprites/items/health_upgrade.png'),
}


function HealthUpgrade:beginContact(other)
    if other.classname == Player.classname then
        other:incrementHealth()
        BaseItem.beginContact(self, other)
    end
end
