--[[
-- q3.lua
--
-- This function removes membername from playerId's party
--
-- The problem with this function is that we are not validing that we are being passed a valid playerId or membername,
-- The function also does not validate if either player is in the party.
-- Finally we also check if both the player and the member are in a party. If eirther are not, don't bother looping through the party.
--]]


--[[
--function do_sth_with_PlayerParty(playerId, membername)
--player = Player(playerId)
--local party = player:getParty()
-- for k,v in pairs(party:getMembers()) do 
--    if v == Player(membername) then 
--        party:removeMember(Player(membername))
--    end
--end
--end
--]]
function removeMemberFromPlayerParty(playerId, memberName)
    local player = Player(playerId)
    -- Decalre member up here so we do not have multiple Player construction calls.
    local member = Player(memberName)

    -- Check if player/member is valid
    if not player or not member then 
	return
    end

    local player_party = player:getParty()
    local member_party = member:getParty()

    -- If either member is not in a party, then nothing to remove them from.
    if not member_party or not player_party then
	return
    end
    --Loop through the players party
    -- Depending on the implmentation of removeMember we may not need to loop through the members.
    for k, v in pairs(player_party:getMembers()) do
	if v == member then
		player_party:removeMember(member)
	end
    end

end
