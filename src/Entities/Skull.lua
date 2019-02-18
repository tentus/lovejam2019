-- the most basic of enemies
-- technically brainless :D
Skull = Class {
    __includes = {Physical, Killable},
    classname = 'Skull',

     -- physics stuff
    bodyType = 'dynamic',
    radius = 31,

    -- moveDir reflects the orientation of the movement
    moveDir = 1,
    moveSpeed = 200,

    sprite = SpriteComponent('assets/sprites/skull.png'),
}

function Skull:init(world, object)
    Physical.createBody(self, world, object.x, object.y)
end


function Skull:update(dt)
    local xVel = self.body:getLinearVelocity()

    if self:shouldTurn(self.moveDir) then
        self:changeDir()
    end

    if math.abs(xVel) < self.moveSpeed then
        self.body:applyForce(self.moveDir * self.moveSpeed, 0)
    end
end


function Skull:draw()
    local x, y = self:bodyPosition()
    self.sprite:draw(x, y, self.moveDir == -1)
end


function Skull:shouldTurn(dir)
    local rayLength = 2
    local xOffset = self.radius * dir

    -- check if there is something in front of us, or nothing in front and below
    return self:castRay(0, 0, xOffset + (rayLength * dir), 0)
        or not self:castRay(xOffset, self.radius, xOffset, self.radius + rayLength)
end


function Skull:castRay(x1, y1, x2, y2)
    local hit = false
    local function rayCastCallback(fixture)
        -- ignore the player and plow into them
        hit = (fixture:getUserData().classname ~= Player.classname)

        return -1
    end

    local x, y = self.body:getPosition()

    self.body:getWorld():rayCast(
        x + x1, y + y1,
        x + x2, y + y2,
        rayCastCallback
    )
    return hit
end


function Skull:changeDir()
    local xVel, yVel = self.body:getLinearVelocity()

    -- dude can about-face very abruptly
    self.body:setLinearVelocity(-xVel / 2, yVel)

    self.moveDir = -self.moveDir
end


function Skull:beginContact(other)
    if other.damage then
        other:damage()
        self:changeDir()
    end
end