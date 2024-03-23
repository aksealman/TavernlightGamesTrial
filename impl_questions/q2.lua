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
-- This should a get table call, where the table contains an array of names.
-- ZRW gut feeling here is that the SQL above will almost certianly return more then one guild name.
-- We should have some error checking here as well if we are not able to make DB call.
-- This should a get table call, where the table contains an array of names.
local guildName = result.getString("name")
print(guildName)
end
