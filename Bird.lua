Bird = Class{}

GRAVITY = 20

function Bird:init()
	self.image = love.graphics.newImage('bird.png')
	
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	
	self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
	self.x = VIRTUAL_WIDTH / 2 - self.width / 2
	self.dy = 0
end

function Bird:collides(target)
	if self.x > target.x + target.width or target.x > self.x + self.width then
		return false
	end
	
	if self.y > target.y + target.height or target.y > self.y + self.height then
		return false
	end
	
	return true

end


function Bird:update(dt)
	self.dy = self.dy + GRAVITY * dt
	
	if love.keyboard.isDown('space') then
		sounds['jump']:play()
		self.dy = -5
	end
	
	self.y = self.y + self.dy
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end
