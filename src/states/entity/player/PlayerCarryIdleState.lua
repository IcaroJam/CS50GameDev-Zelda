--[[
	GD50
	Legend of Zelda

	Author: Colton Ogden
	cogden@cs50.harvard.edu
]]

PlayerCarryIdleState = Class{__includes = EntityIdleState}

function PlayerCarryIdleState:init(player, dungeon)
	self.entity = player
	self.dungeon = dungeon

	-- render offset for spaced character sprite; negated in render function of state
	self.entity.offsetY = 5
	self.entity.offsetX = 0

	self.dirX = 0
	self.dirY = 0
	if self.entity.direction == "up" then
		self.dirY = -1
	elseif self.entity.direction == "down" then
		self.dirY = 1
	elseif self.entity.direction == "right" then
		self.dirX = 1
	elseif self.entity.direction == "left" then
		self.dirX = -1
	end

	self.entity:changeAnimation("carry-idle-" .. self.entity.direction)
end

function PlayerCarryIdleState:enter(params)
	if params then
		self.liftedObj = params.obj
	end
end

function PlayerCarryIdleState:update(dt)
	if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
	   love.keyboard.isDown('up') or love.keyboard.isDown('down') then
		self.entity.stateMachine:change('carry', {
			obj = self.liftedObj
		})
	end

	if love.keyboard.wasPressed('space') then
		table.insert(self.dungeon.currentRoom.projectiles, Projectile(
			self.dirX,
			self.dirY,
			math.random(50, 80), --pot velocity
			1, --pot damage
			4 * TILE_SIZE, --max travel distance
			self.liftedObj, --reference to the object launched as a projectile
			self.dungeon.currentRoom --reference to the current room for projectile-enemy collision
		))
		self.entity:changeState("idle")
	end
end

function PlayerCarryIdleState:render()
	-- draw the player and the lifted pot over it
	love.graphics.draw(gTextures[self.entity.currentAnimation.texture], gFrames[self.entity.currentAnimation.texture][self.entity.currentAnimation:getCurrentFrame()],
		math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
	self.liftedObj:render(0, 0)
end
