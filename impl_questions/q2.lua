--[[
-- q3.lua
-- The issue with this script is that it looks like we should explect multiple guild names from the selectGuidQuery. However the function will only print one guild name no matter how many guilds have less then maxMembers
--
--I observed the result data structure in the forgotten server (line 4061 in src/luascript.cpp).
--
-- Using the next call we should be able to iterate through all of the results returned by the query.
--
-- We also ensure that we free the query at the end of the program.
--]]

--function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
--local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
--local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
--local guildName = result.getString("name")
--print(guildName)
--end

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

    local tmpResultId = resultId

    -- While there are still results
    while tmpResultId ~= false do
	-- print one of the results from the query.
        print(result.getString(resultId, "name"))
	-- goto the next result. false if no more results
	tmpResultId = result.next(resultId)
    end

    -- release the result.
    if resultId ~= false then
	    result.free(resultId)
    end
end
