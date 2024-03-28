--[[
-- Question7.lua
-- Text box jump game.
--
-- Ctrl+1 is the hotkey to spawn the game.
-- Button jumps in the following pattern
-- BOTTOM->MIDDLE->BOTTOM->TOP 
-- If the button travels the WIDTH of the window we move our offset up one button height and jump to the next level.
--
-- I implemented this using the spellbook as a base, as they both use displayUI to get a text window. 
--]]


WINDOW_WIDTH = 300 
WINDOW_HEIGHT = 350 
BUTTON_HEIGHT = 24


-- The Three levels the button jumps between.
BOTTOM_OFFSET = 0
MIDDLE_OFFSET = 100
TOP_OFFSET = 200


-- Without these offsets the button would start outside of our window.
Y_AXIS_OFFSET = WINDOW_HEIGHT - 100
X_AXIS_OFFSET = WINDOW_WIDTH - 100

-- We need to save our init pos as we will return to some function of it when the button is clicked.
init_pos = nil

-- We start at the bottom so the next level would be the middle.
jumpPattern_idx = 1 

function init()

  question7Window = g_ui.displayUI('question7', modules.game_interface.getRightPanel())
  question7Window:hide()

  jumpButton = question7Window:getChildById("jumpButton")
  init_pos = jumpButton:getPosition()
  -- Needed Margin without it button would re-position off the box
  init_pos.x = init_pos.x + X_AXIS_OFFSET 
  init_pos.y = init_pos.y + Y_AXIS_OFFSET
  jumpButton:setPosition(init_pos)

  g_keyboard.bindKeyDown('Ctrl+1', windowToggleFunc)
end

function terminate()
  g_keyboard.unbindKeyDown('Ctrl+1')
  -- Hide the window so we stop moveLoop recursion 
  question7Window:hide()
  jumpButton:destroy()
  question7Window:destroy()
end

function moveLoop()
    x_cord = jumpButton:getX()
    -- If our window is hidden don't bother moving the button.
    if question7Window:isHidden() then
	    return
    end
    -- The button has traversed the width of the window
    if init_pos.x - x_cord >  X_AXIS_OFFSET then
	   -- Move up one button heigh going forward
	   init_pos.y = init_pos.y - BUTTON_HEIGHT
	   -- Jump to the next level
           moveJumpButtonLevel()
	   -- Start moving
	   scheduleEvent(moveLoop, 10)
    else
	-- Move button 10 units to the left
        jumpButton:setX(x_cord-10)
        scheduleEvent(moveLoop, 100)
    end
end

function windowToggleFunc()
	if question7Window:isHidden() then
            question7Window:show()
	    -- kick off the button movement
	    event = scheduleEvent(moveLoop, 2000)
        else
     	    question7Window:hide()
    end
end

function moveJumpButtonLevel()
    -- Move the button one level

    -- Lua auto assigns arrays starting at 1.
    -- If I want to use modulo areithmitic for the box jump pattern
    -- then we want to use jumpPattern_idx % 4
    -- Which gives us a value between 0-3
    jumpPattern = {MIDDLE_OFFSET, BOTTOM_OFFSET, TOP_OFFSET}
    jumpPattern[0] = BOTTOM_OFFSET

    curr_pos = jumpButton:getPosition()
    -- Use our init pos to determine where we jump to.
    curr_pos.x = init_pos.x
    curr_pos.y = init_pos.y - jumpPattern[jumpPattern_idx%4]
    -- iterate our pattern by 1.
    jumpPattern_idx = jumpPattern_idx + 1
    -- Set the jump button to our new pos
    jumpButton:setX(init_pos.x)
    jumpButton:setY(curr_pos.y)
end
