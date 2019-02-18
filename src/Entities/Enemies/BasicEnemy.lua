-- a static, damage-dealing object
BasicEnemy = Class {
    __includes = {Physical, Killable},
    classname = 'BasicEnemy',

     -- physics stuff
    bodyType = 'dynamic',
    radius = 31,

    state = "docile",
    states = {
        docile = {
            moveSpeed = 200,
            moveDir = 1
        },

        aggro = {
            moveSpeed = 200,
        }
    },

    rays = {
        west = {
            x = -35,
            y = 0,
            hit = false,
        },
        east = {
            x = 35,
            y = 0,
            hit = false,
        },
    }
}

function BasicEnemy:init(world, object)
    self.width = self.radius
    self.height = self.radius

    Physical.createBody(self, world, object.x, object.y)
end

function BasicEnemy:update(dt)
    if(self.state == "docile") then self:docileUpdate(dt) end
end

-- Gets called when the enemy is in their default state
function BasicEnemy:docileUpdate(dt)
    self:castRays()

    local xVel, yVel = self.body:getLinearVelocity()

    local moveSpeed = self.states.docile.moveSpeed
    local moveDir = self.states.docile.moveDir

    if(
        (self.rays.west.hit == true and moveDir == -1)
        or (self.rays.east.hit == true and moveDir == 1)
    ) then
        moveDir = -moveDir

        -- apply a force in the new direction to get them going
        self.body:setLinearVelocity((moveSpeed / 2) * moveDir, yVel)
    end

    if math.abs(xVel) < moveSpeed then
        self.body:applyForce(moveSpeed * moveDir, 0)
    end

    self.states.docile.moveDir = moveDir
end


function BasicEnemy:draw()
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.radius, 50)
end

function BasicEnemy:castRays()
    for _, v in pairs(self.rays) do
        v.hit = false

        local function rayCastCallback()
            v.hit = true

            return 0
        end

        self.body:getWorld():rayCast(
            self.body:getX(), self.body:getY(),
            self.body:getX() + (v.x), self.body:getY() + v.y,
            rayCastCallback
        )
    end
end
