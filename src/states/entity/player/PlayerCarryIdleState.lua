--[[
	GD50
	Legend of Zelda

	Author: Colton Ogden
	cogden@cs50.harvard.edu
]]

PlayerCarryIdleState = Class{__includes = EntityIdleState}

function PlayerCarryIdleState:enter(params)

	-- render offset for spaced character sprite (negated in render function of state)
	self.entity.offsetY = 5
	self.entity.offsetX = 0

	self.entity:changeAnimation("carry-idle-" .. self.entity.direction)
end

function PlayerCarryIdleState:update(dt)
	if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
	   love.keyboard.isDown('up') or love.keyboard.isDown('down') then
		self.entity:changeState('carry')
	end

	if love.keyboard.wasPressed('space') then
		print("Imagine a pot being throwed")
	end
end
