--[[
-- Question6.lua
--
-- Client side dash effect. Invoked via Ctrl+D
--
-- This is an incomplete implemntation of question 6. 
--
-- The script currently dashes 6 tiles in the direction the character is facing
-- Trees will stop the player, however creatures will not.
-- It does NOT implment the shader, nor does it communicate to the server to update the player position.
--
--]]
function init()
  g_keyboard.bindKeyDown("Ctrl+D", playerDash)
end

function terminate()
  g_keyboard.unbindKeyDown("Ctrl+D")
end


function playerDash()
	-- TODO glsl shader to produce effect?
	shader = g_shaders.createShader("test")
	dashOnce()
        scheduleEvent(dashOnce, 50)
        scheduleEvent(dashOnce, 100)
        scheduleEvent(dashOnce, 150)
        scheduleEvent(dashOnce, 200)
        scheduleEvent(dashOnce, 250)
end
function dashOnce()
	player = g_game.getLocalPlayer()
	curr_pos = player:getPosition()
	direction = player:getDirection()
        if direction == 0 then
	    curr_pos.y = curr_pos.y - 1
        --east
	elseif direction == 1 then
	    curr_pos.x = curr_pos.x + 1
	-- south 
	elseif direction == 2 then
	    curr_pos.y = curr_pos.y + 1
        -- west
	elseif direction == 3 then
	    curr_pos.x = curr_pos.x - 1
	else
		return
	end
	--Check if tile at curr_pos has anything that would block movement
	tele_tile = g_map.getTile(curr_pos)

	-- Don't teleport across trees/walls/pools.
	-- Allow for teleport across creatures.
	if not tele_tile:isWalkable() and not tele_tile:hasCreature() then
		return
	end
	-- This is an incomplete way to move the player.
	-- Doing this desyncronizes the client from the server.
	-- We would need to communicate to the server the new player location.
	g_map.removeThing(player)
	g_map.addThing(player, curr_pos, -1)
end

