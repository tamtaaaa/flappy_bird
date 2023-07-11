push = require 'push'
Class = require 'class'

require 'StateMachine'

require 'states/BaseState'
require 'states/StartState'
require 'states/PlayState'
require 'states/ScoreState'

require 'Bird'
require 'Pipe'
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--all image assets are taken from here: https://megacrash.itch.io/flappy-bird-assets
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local LOOPING_POINT = 256


function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter('nearest', 'nearest')

	io.stdout:setvbuf("no")
	
	love.window.setTitle('Flappy')
	
	mediumFont = love.graphics.newFont('8bit_font.ttf', 16)
	scoreFont = love.graphics.newFont('8bit_font.ttf', 8)
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	
	stateMachine = StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end,
		['score'] = function() return ScoreState() end
	}
	
	sounds = {
		['jump'] = love.audio.newSource('jump.wav', 'static'),
		['death'] = love.audio.newSource('death.wav', 'static'),
		
		--https://freesound.org/people/sonically_sound/sounds/624874/
		['music'] = love.audio.newSource('music.mp3', 'static')
	}
	
	sounds['music']:setLooping(true)
	sounds['music']:play()
	
	stateMachine:change('start')
	
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	stateMachine:update(dt)
	
end

function love.draw()
	push:start()
	
	
	
	love.graphics.draw(background, -backgroundScroll, 0)
	
	stateMachine:render()
	
	push:finish()
end






