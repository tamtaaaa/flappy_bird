Pipe = Class{}

function Pipe:init(identity, y)
	self.image = love.graphics.newImage('pipe.png')
	
	self.x = VIRTUAL_WIDTH
	self.y = y
	
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	
	self.identity = identity
end


function Pipe:render()
	love.graphics.draw(
		self.image, 
		self.x, 
		(self.identity == 'bottom' and self.y + self.height or self.y),
		0,
		1,
		(self.identity == 'bottom' and -1 or 1))
end
