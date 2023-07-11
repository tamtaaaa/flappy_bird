ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update(dt)
	if love.keyboard.isDown('return') then
		stateMachine:change('start')
	end
end

function ScoreState:render()
	love.graphics.setFont(mediumFont)
	love.graphics.printf('You lost! Press enter to play again', 0, 80, VIRTUAL_WIDTH, 'center')
	love.graphics.printf('Score: ' .. tostring(self.score), 0, 160, VIRTUAL_WIDTH, 'center')
end
