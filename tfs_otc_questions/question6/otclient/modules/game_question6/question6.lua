function online()
end

function offline()
end

function init()
  connect(g_game, { onGameStart = online,
                    onGameEnd   = offline })
  --bind hotkey
  g_keyboard.bindKeyDown("Ctrl+D", playerDash)
  if g_game.isOnline() then
    online()
  end
end

function terminate()
  disconnect(g_game, { onGameStart = online,
                       onGameEnd   = offline })
  g_keyboard.unbindKeyDown("Ctrl+D")
end


function playerDash()
	--player:setPosition(pos)
	--g_map.setCentralPosition(pos)
	--g_map.removeThingByPos(curr_pos)
	--g_game.walk(2, false)
	--North 0
	--East 1 
	--South 2
	--West 3
        --p_direction = g_game.getLocalPlayer():getDirection()
	shader = g_shaders.createShader("test")
	dashOnce()
        scheduleEvent(dashOnce, 50)
        scheduleEvent(dashOnce, 100)
        scheduleEvent(dashOnce, 150)
        scheduleEvent(dashOnce, 200)
        scheduleEvent(dashOnce, 250)
        --scheduleEvent(dashOnce, 300)
        --scheduleEvent(dashOnce, 350)
        --scheduleEvent(dashOnce, 400)
        --scheduleEvent(dashOnce, 450)
        --scheduleEvent(dashOnce, 500)
	--g_map.removeThing(player)
	--g_map.setCentralPosition(tele_map_pos)
	--g_map.notificateTileUpdate(tele_pos)
	print("PlayerDash: GOODBYE WORLD")
end
function dashOnce(direction)
	player = g_game.getLocalPlayer()
	curr_pos = player:getPosition()
	direction = player:getDirection()
	--g_map.removeThing(player)
	--north
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
		print ("boo")
		return
	end
	--Check if tile at curr_pos has anything that would block movement
	--ex tree
	--g_map.setShowAnimations(false)
	g_map.beginGhostMode()
	tele_tile = g_map.getTile(curr_pos)

	-- Don't teleport across trees/walls/pools.
	-- Allow for teleport across creatures.
	if not tele_tile:isWalkable() and not tele_tile:hasCreature() then
		print("Object blocking")
		return
	end
	--g_game.walk(direction, false)
	g_map.removeThing(player)
	g_map.addThing(player, curr_pos, -1)

	--g_map.notificateTileUpdate(tele_pos)
	--g_map.removeThingByPos(curr_pos)
	--g_game.walk(2, false)
end

