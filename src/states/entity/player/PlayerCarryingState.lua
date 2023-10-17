PlayerCarryingState = Class{__includes = EntityWalkState}

function PlayerCarryingState:init(player, dungeon)
	self.entity = player
	self.dungeon = dungeon

	-- render offset for spaced character sprite; negated in render function of state
	self.entity.offsetY = 5
	self.entity.offsetX = 0

	self.entity:changeAnimation("carry-" .. self.entity.direction)
end

function PlayerCarryingState:enter(params)
	if params then
		self.liftedObj = params.obj
	end
end

function PlayerCarryingState:update(dt)
	if love.keyboard.isDown('left') then
		self.entity.direction = 'left'
		self.entity:changeAnimation('carry-left')
	elseif love.keyboard.isDown('right') then
		self.entity.direction = 'right'
		self.entity:changeAnimation('carry-right')
	elseif love.keyboard.isDown('up') then
		self.entity.direction = 'up'
		self.entity:changeAnimation('carry-up')
	elseif love.keyboard.isDown('down') then
		self.entity.direction = 'down'
		self.entity:changeAnimation('carry-down')
	else
		self.entity.stateMachine:change("carry-idle", {
			obj = self.liftedObj
		})
	end

	if love.keyboard.wasPressed('space') then
		print("Imagine a pot being throwed")
	end

	-- perform base collision detection against walls
	EntityWalkState.update(self, dt)

	-- update the lifted obj position
	self.liftedObj.x = self.entity.x
	self.liftedObj.y = self.entity.y - 8
end

function PlayerCarryingState:render()
	-- draw the player and the lifted pot over it
	love.graphics.draw(gTextures[self.entity.currentAnimation.texture], gFrames[self.entity.currentAnimation.texture][self.entity.currentAnimation:getCurrentFrame()],
		math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
	self.liftedObj:render(0, 0)
end
