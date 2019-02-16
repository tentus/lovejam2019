Sign = Class{
    __includes = {Physical},
    classname = 'Sign',
    dialog = '',

    radius = 32,
    isSensor = true,

    -- our body the same dimensions as a normal tile
    sprite = SpriteComponent('assets/sprites/sign.png'),
}

function Sign:init(world, object)
    self:createBody(world, object.x, object.y)

    self.dialog = object.name
end

function Sign:draw()
    local x, y = self:bodyPosition()
    self.sprite:draw(x, y)
end


function Sign:beginContact(other)
    if other.classname == Player.classname then
        Gamestate.push(DialogScene, self.dialog)
        Stats:add('Signs Read')
    end
end
