--[[
	GD50
	Legend of Zelda

	Author: Colton Ogden
	cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
	['switch'] = {
		type = 'switch',
		texture = 'switches',
		frame = 2,
		width = 16,
		height = 16,
		solid = false,
		defaultState = 'unpressed',
		states = {
			['unpressed'] = {
				frame = 2
			},
			['pressed'] = {
				frame = 1
			}
		}
	},
	['pot'] = {
		-- TODO
	},
	['heart'] = {
		type = "heart",
		texture = "hearts",
		frame = "5",
		width = 16,
		height = 16,
		solid = false,
		defaultState = "default",
		states = {
			['default'] = {
				frame = 5
			}
		},
		onCollide = function(plyr, obj)
			-- For some fucking reason a cannot for the love of god understand, when this function is called in Room.lua line 195 as 'object:onCollide(self.player, object)', the values are flipped and so player is assigned to the obj variable. WHY
			obj:heal(2)
			plyr.consumed = true
		end
	}
}
