PlayState = Class{__includes = BaseState}

PIPE_SCROLL = 50

function PlayState:init()
	self.bird = Bird()
	self.pipePairs = {}
	self.timer = 0
	self.score = 0
end

function PlayState:update(dt)

	self.timer = self.timer + dt
	
	if self.timer > 2 then
		local x = VIRTUAL_WIDTH
		local y = math.random(-100, -20)
		table.insert(self.pipePairs, PipePair(x, y))
		self.timer = 0
	end

	for k, pair in pairs(self.pipePairs) do
		if pair.remove == true then
			table.remove(self.pipePairs, k)
		end
		
		if not pair.scored and self.bird.x > pair.pipes['top'].x then
			pair.scored = true
			self.score = self.score + 1
		end
		
		
		pair:update(dt)
	end
	
	for k, pair in pairs(self.pipePairs) do
		for i, pipe in pairs(pair.pipes) do
			if self.bird:collides(pipe) then
				sounds['death']:play()
				stateMachine:change('score', {
					score = self.score
				})
			end
		end
	end
	
	self.bird:update(dt)
end

function PlayState:render()
	
	for k, pair in pairs(self.pipePairs) do
		pair:render()
	end
	
	self.bird:render()
	
	love.graphics.setFont(scoreFont)
	love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end
