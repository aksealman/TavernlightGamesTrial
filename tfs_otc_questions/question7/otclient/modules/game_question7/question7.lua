WINDOW_WIDTH = 300 
WINDOW_HEIGHT = 350 
BUTTON_HEIGHT = 24

BOTTOM_LOC = WINDOW_HEIGHT - 100 

BOTTOM_OFFSET = 0
MIDDLE_OFFSET = 100
TOP_OFFSET = 200
 
X_AXIS_OFFSET = WINDOW_WIDTH - 100
--MIDDLE_OFFSET = WINDOW_HEIGHT - 200 
--TOP_OFFSEET = WINDOW_HEIGHT - 300


windowToggle = false
init_pos = nil
-- Lua auto assigns arrays starting at 1.
-- If I want to use modulo areithmitic for the box jump pattern
-- then we want to use jumpPattern_idx % 4
-- Which gives us a value between 0-3
--jumpPattern = {MIDDLE_OFFSET, BOTTOM_OFFSET, TOP_OFFSET}
--jumpPattern[0] = BOTTOM_OFFSET
jumpPattern_idx = 1 

function online()
end

function offline()
end

function init()
  connect(g_game, { onGameStart = online,
                    onGameEnd   = offline })

  question7Window = g_ui.displayUI('question7', modules.game_interface.getRightPanel())
  question7Window:hide()

  jumpButton = question7Window:getChildById("jumpButton")
  init_pos = jumpButton:getPosition()
  -- Needed Margin 
  init_pos.x = init_pos.x + X_AXIS_OFFSET 
  init_pos.y = init_pos.y + BOTTOM_LOC
  --init_pos.y = init_pos.y + WINDOW_HEIGHT - 200 
  --init_pos.y = init_pos.y + WINDOW_HEIGHT - 300 
  --jumpButton:setX(x_init)
  --jumpButton:setY(y_init)
  jumpButton:setPosition(init_pos)
  --jumpButton:setPosition(300,300)
  --jumpButton:setX(100)
  --jumpButton:setY(100)
  g_keyboard.bindKeyDown('Ctrl+1', windowToggleFunc)
  --addEvent(moveLoop, 1000)
  --scheduleEvent(moveLoop, 2000)
  print("****** INIT *******")
  print(init_pos.x)
  print(init_pos.y)
  if g_game.isOnline() then
    online()
  end
  --moveLoop()
end

function terminate()
  disconnect(g_game, { onGameStart = online,
                       onGameEnd   = offline })

  g_keyboard.unbindKeyDown('Ctrl+1')
  question7Window:hide()
  addEvent(setContinueLoop,false)
  jumpButton:destroy()
  question7Window:destroy()
end

function moveLoop()
    x_cord = jumpButton:getX()
    -- We have traveled the width of the window
    -- do somthing!
    if question7Window:isHidden() then
	    print("Goodbye world: window is hidden!")
	    return
    end
    -- We have traveled the width of the window
    -- TODO 
    if init_pos.x - x_cord >  X_AXIS_OFFSET then
	   init_pos.y = init_pos.y - BUTTON_HEIGHT
           buttonToggle()
	   scheduleEvent(moveLoop, 10)
    else
        --jumpButton:setX(x_cord-10)
        --scheduleEvent(moveLoop, 100)
	print("yay")
        jumpButton:setX(x_cord-10)
        --scheduleEvent(moveLoop, 1000)
        scheduleEvent(moveLoop, 100)
    end
    --addEvent(moveLoop, 100)
end

function windowToggleFunc()
	if not windowToggle then
	    --question7Window:enable()
            question7Window:show()
	    event = scheduleEvent(moveLoop, 2000)
	    windowToggle = true
        else
     	    question7Window:hide()
	    --question7Window:disable()
	    windowToggle = false
    end
end

function buttonToggle()
    -- Lua auto assigns arrays starting at 1.
    -- If I want to use modulo areithmitic for the box jump pattern
    -- then we want to use jumpPattern_idx % 4
    -- Which gives us a value between 0-3
    jumpPattern = {MIDDLE_OFFSET, BOTTOM_OFFSET, TOP_OFFSET}
    jumpPattern[0] = BOTTOM_OFFSET
    curr_pos = jumpButton:getPosition()
    --print("Current x: " + curr_pos.x)
    --print("Current y: " + curr_pos.y)
    print(init_pos.x)
    print(init_pos.y)
    print("***********************************")
    print(curr_pos.x)
    print(curr_pos.y)
    print("******************")
    curr_pos.x = init_pos.x
    y_idx = jumpPattern_idx%4
    curr_pos.y = init_pos.y - jumpPattern[y_idx]
    jumpPattern_idx = jumpPattern_idx + 1
    print(curr_pos.x)
    print(curr_pos.y)
    print("********************")
    jumpButton:setX(init_pos.x)
    jumpButton:setY(curr_pos.y)
    --jumpButton:setPosition(curr_pos)
     --continue_loop = false
    --scheduleEvent(setContinueLoop,100,false)
    --topButton = question7Window:getChildById("topButton")
    --bottomButton = question7Window:getChildById("bottomButton")
    --hide bottom show top
    --[[
    if bottomButton:isHidden() then
        bottomButton:show()
	topButton:hide()
	middleButton:hide()
    else
        topButton:hide()
        bottomButton:show()
    end
    --]]
    --x_cord = jumpButton:getX()
    --y_cord = topButton:getY()
    --jumpButton:setX(x_cord-5)
    --topButton:setY(y_cord+5)

    --pos = jumpButton:getPosition()
    --pos.y = pos.y - BUTTON_HEIGHT
    --jumpButton:setPosition(pos)
end

function resizeWindow()
end

function resetWindow()
end
