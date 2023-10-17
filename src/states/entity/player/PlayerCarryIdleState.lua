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

	if params then
		self.liftedObj = params.obj
	end

	self.entity:changeAnimation("carry-idle-" .. self.entity.direction)
end

function PlayerCarryIdleState:update(dt)
	if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
	   love.keyboard.isDown('up') or love.keyboard.isDown('down') then
		self.entity.stateMachine:change('carry', {
			obj = self.liftedObj
		})
	end

	if love.keyboard.wasPressed('space') then
		print("Imagine a pot being throwed")
	end
end

function PlayerCarryIdleState:render()
	-- draw the player and the lifted pot over it
	love.graphics.draw(gTextures[self.entity.currentAnimation.texture], gFrames[self.entity.currentAnimation.texture][self.entity.currentAnimation:getCurrentFrame()],
		math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
	self.liftedObj:render(0, 0)
end
