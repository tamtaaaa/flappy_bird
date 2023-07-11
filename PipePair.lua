PipePair = Class{}

local GAP = 100

function PipePair:init(x, y)
	self.x = x
	self.y = y
	self.image = love.graphics.newImage('pipe.png')
	self.pipeHeight = self.image:getHeight()
	
	self.pipes = {
		['top'] = Pipe('top', self.y),
		['bottom'] = Pipe('bottom', self.y + self.pipeHeight + GAP)
	}
	
	self.remove = false
	self.scored = false
end

function PipePair:update(dt)
	if self.x < 0 - self.pipes['top'].width then
		self.remove = true
		return
	end
	
	self.x = self.x - PIPE_SCROLL * dt
	self.pipes['top'].x = self.x
	self.pipes['bottom'].x = self.x
	
	
end

function PipePair:render()
	for k, pipe in pairs(self.pipes) do
		pipe:render()
	end
end
