-- a static, damage-dealing object
Spikes = Class{
    __includes = {Physical},
    classname = 'Spikes',

    -- drawing stuff
    image = love.graphics.newImage('assets/sprites/spikes.png'),
}


function Spikes:init(world, object)
    self.width = object.width
    self.height = object.height

    self.image:setWrap("repeat", "repeat")
    self.quad = love.graphics.newQuad( 0, 0, self.width, self.height, self.image:getDimensions() )

    Physical.createBody(self, world, object.x + (self.width / 2), object.y + (self.height / 2))
end


function Spikes:draw()
    love.graphics.draw(self.image, self.quad, self.body:getX() - (self.width / 2), self.body:getY() - (self.height / 2))
end


function Spikes:makeShapes()
    return {
        love.physics.newRectangleShape(self.width, self.height)
    }
end


function Spikes:beginContact(other)
    if other.damage then
        other:damage()
    end
end