-- intended to a child of other entities, but is also handy directly in scenes
SpriteComponent = Class{
}


function SpriteComponent:init(imagePath)
    self.image = love.graphics.newImage(imagePath)

    -- set offsets for image drawing, since it won't change
    self.x = self.image:getWidth() / 2
    self.y = self.image:getHeight() / 2
end


function SpriteComponent:draw(x, y)
    love.graphics.draw(self.image, x - self.x, y - self.y)
end
