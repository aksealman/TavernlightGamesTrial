--[[
--q1.lua
--
-- The problem with the provided function is that there is no guarntee the player object will be availble when the releaseStorage event triggers.
--
-- Instead of passing the player object we can pass the playerID and try to construct the player object in the releaseStorage function
--]]

local function releaseStorage(playerId)
    local player = Player(playerId)
    if player then
        player:setStorageValue(1000, -1)
    end
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player:getId())
    end
return true
end
