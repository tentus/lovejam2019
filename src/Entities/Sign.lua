Sign = Class{
    __includes = {Physical},
    classname = 'Sign',
    dialog = '',

    radius = 32,
    isSensor = true,

    -- our body the same dimensions as a normal tile
    sprite = SpriteComponent('assets/sprites/sign.png'),

    -- after a sign has been read, wait 3 second before allowing the player to read it again
    cooldown = {
        duration = 3,
        remaining = 0,
    },
}

function Sign:init(world, object)
    self:createBody(world, object.x, object.y)

    self.dialog = object.name
end


function Sign:update(dt)
    if self.cooldown.remaining > 0 then
        self.cooldown.remaining = self.cooldown.remaining - dt
    end
end


function Sign:draw()
    local x, y = self:bodyPosition()
    self.sprite:draw(x, y)
end


function Sign:beginContact(other)
    if other.classname == Player.classname and self.cooldown.remaining <= 0 then
        self.cooldown.remaining = self.cooldown.duration

        Gamestate.push(DialogScene, self.dialog)
        Stats:add('Signs Read')
    end
end
