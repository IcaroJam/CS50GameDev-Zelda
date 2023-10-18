--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(dirX, dirY, vel, damage, maxTravelDist, obj, room)
	self.dirX = dirX
	self.dirY = dirY
	self.vel = vel
	self.damage = damage
	self.travDist = 0
	self.maxDist = maxTravelDist
	self.body = obj

	self.room = room
end

function Projectile:update(dt)
	self.body.x = self.body.x + self.dirX * self.vel * dt
	self.body.y = self.body.y + self.dirY * self.vel * dt

	self.travDist = self.travDist + self.vel * dt

	-- if the projectile has traveled enough distance, delete it
	if self.travDist > self.maxDist then
		table.remove(self.room.projectiles, indexOf(self.room.projectiles, self))
	end

	for k, entity in pairs(self.room.entities) do
		if entity:collides(self.body) then
			entity:damage(self.damage)
			table.remove(self.room.projectiles, indexOf(self.room.projectiles, self))
		end
	end

	-- check is the pot hit a wall
end

function Projectile:render()
	self.body:render(0, 0)
end
