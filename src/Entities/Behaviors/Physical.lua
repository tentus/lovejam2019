-- helps with entities that have physics bodies
Physical = Class{
    -- body    = Body,
    -- shape   = Shape,
    -- fixture = Fixture,
}


function Physical:createBody(world, x, y)
    self.body    = love.physics.newBody(world, x, y, self.bodyType or 'static')
    self.shape   = self:makeShape()
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setSensor(self.isSensor or false)
    self.fixture:setUserData(self)
end


-- separated so it can be overridden for rectangles
function Physical:makeShape()
    return love.physics.newCircleShape(self.radius)
end


function Physical:bodyPosition()
    return self.body:getPosition()
end
