PlayerLiftState = Class{__includes = BaseState}

function PlayerLiftState:init(player, dungeon)
	self.player = player
	self.dungeon = dungeon

	self.dirX = 0
	self.dirY = 0
	if self.player.direction == "up" then
		self.dirY = - 1
	elseif self.player.direction == "down" then
		self.dirY = 1
	elseif self.player.direction == "right" then
		self.dirX = 1
	elseif self.player.direction == "left" then
		self.dirX = -1
	end
	-- temporarily move forwards to check for collided objects
	self.player.x = self.player.x + self.dirX * 16
	self.player.y = self.player.y + self.dirY * 16
	for k, obj in pairs(dungeon.currentRoom.objects) do
		if obj.solid and self.player:collides(obj) then
			self.liftedObj = obj
			break
		end
	end
	-- Move the player back to it's place
	self.player.x = self.player.x - self.dirX * 16
	self.player.y = self.player.y - self.dirY * 16

	self.player:changeAnimation("lift-" .. self.player.direction)
end

function PlayerLiftState:enter()
	self.player.currentAnimation:refresh()
end

function PlayerLiftState:update(dt)
	self.player.currentAnimation:update(dt)

	-- is the lifting animation has finished playing and there's a pot in front of us move to the carry state, else go back to idle
	if self.player.currentAnimation.timesPlayed > 0 then
		if self.liftedObj then
			self.player:changeState("carry", self.liftedObj)
		else
			self.player:changeState("idle")
		end
	end
end

function PlayerLiftState:render()
	love.graphics.draw(gTextures[self.player.currentAnimation.texture], gFrames[self.player.currentAnimation.texture][self.player.currentAnimation:getCurrentFrame()],
		math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end
