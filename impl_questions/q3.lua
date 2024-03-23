--function do_sth_with_PlayerParty(playerId, membername)
--player = Player(playerId)
--local party = player:getParty()
-- for k,v in pairs(party:getMembers()) do 
--    if v == Player(membername) then 
--        party:removeMember(Player(membername))
--    end
--end
--end

-- Rename the function as well as remove the unnessicary membername parameter.
-- If we need it later we can likly derive it from the player class 
function removePlayerFromParty(playerId)
player = Player(playerId)
-- Check if player is valid
-- Assume the Player class returns nil when provided an invalid playerId
if not player then 
    error "Invalid player id"
end

local party = player:getParty()
-- check if player in a party
-- Assume getParty returns nil if player is not in a party
if not party then
	return True
end
-- I don't think we need to loop through the party.
-- Above we have validated that the player is in the party.
-- We can assume that the party that that is returned from player:getParty() has the player currently in it.
party:removeMember(player)
return True
end
