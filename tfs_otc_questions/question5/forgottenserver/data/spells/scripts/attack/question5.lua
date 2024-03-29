--[[
-- Question5.lua.
-- Uses the sprite from Eternal Winter to create a custom ice tornado pattern
-- We do this by setting up four spell mappings and mapping those to combat objects
-- From there we stagger the execution of each combat object with AddEvent creating the pattern in the video.
-- This spell only handles the animation and does not do any dmg.
--]]

--In line frames 
local altFrame1 = {
	{0,0,1,0,0,0,0,0,0},
	--below pc
	{0,1,0,0,2,0,0,1,0},
	--above pc
	{0,0,1,0,0,0,0,0,0},
	{0,0,0,1,0,0,0,0,0},
	{0,0,0,0,1,0,0,0,0},
}
local altFrame2 = {
	{0,0,0,1,0,1,0,0,0},
	{0,0,0,0,0,0,1,0,0},
	{0,0,0,0,2,0,0,0,0},
        {0,0,0,0,1,0,1,0,0}
}

local altFrame3 = {
	{0,0,0,1,2,1,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,1,0,0,0}
}
local altFrame4 = {
	{0,0,0,0,1,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,1,0,0,0,0},
	{0,0,0,0,2,0,0,0,0}
}
--[[
-- I encountered the following bug with the Ice Tornado Animation:
-- https://otland.net/threads/issue-on-the-animation-of-eternal-winter.281595/
-- Because of this I could not reproduce the animation exactly. I could only get Large Ice Tornados to show up even tiles away from me, when in the animation the Large Ice Tornados show on odd tiles away from PC.
-- If I created a map that was the same position as in the animation no torandos would show up. 
-- In order to get the tornados to appear I had to shift the pattern.
--
-- Assume the player faces south
-- All tornados aligned with the player are shifted left by one tile from the original pattern.
-- All tornados to the left of the player are shifted left by one tile from the original pattern.
-- All tornados to the right of the player are shifted right by one tile from the original pattern.
-- For convience I provided the "correct" frames above using the name altFrame.
--]]

--Shifted Frames 
local frame1 = {
	{0,1,0,0,0,0,0,0,0},
	--below pc
	{1,0,0,0,2,0,0,0,1},
	--above pc
	{0,1,0,0,0,0,0,0,0},
	{0,0,1,0,0,0,0,0,0},
	{0,0,0,1,0,0,0,0,0},
}
local frame2 = {
	{0,0,1,0,0,0,1,0,0},
	{0,0,0,0,0,0,0,1,0},
	{0,0,0,0,2,0,0,0,0},
        {0,0,0,0,0,1,0,1,0}
}

local frame3 = {
	{0,0,1,0,2,0,1,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,1,0,0}
}
local frame4 = {
	{0,0,0,0,0,1,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,1,0,0,0},
	{0,0,0,0,2,0,0,0,0}
}

-- Create two parallel arrays to setup the combat object.

-- Change these to altFrame for the original pattern.
-- https://otland.net/threads/issue-on-the-animation-of-eternal-winter.281595/
local frameArr = { frame1, frame2, frame3, frame4 }
local combatArr = { Combat(), Combat(), Combat(), Combat() }

-- The only differences between combat objects is what frame they display.
for i = 1,4 do
    combatArr[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combatArr[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    --Ensure that each combat object is set to the correct frame.
    combatArr[i]:setArea(createCombatArea(frameArr[i]))
end

local function castSpell(creatureId, variant, combat_idx)
	local creature = Creature(creatureId)
	if not creature then
		return
	end
	combatArr[combat_idx]:execute(creature, variant)
end

function onCastSpell(creature, variant)
	-- I could put this in a loop, however I think it would make the code more confusing.
        castSpell(creature, variant, 1)
        addEvent(castSpell, 100, creature:getId(), variant, 2)
	addEvent(castSpell, 250, creature:getId(), variant, 3)
	addEvent(castSpell, 750, creature:getId(), variant, 4)
	-- Per the video this should be enough time that the small tornado desppawns, but not enough time for the big tornado to despawn
	addEvent(castSpell, 1000, creature:getId(), variant, 1)
        addEvent(castSpell, 1250, creature:getId(), variant, 2)
	addEvent(castSpell, 1250, creature:getId(), variant, 3)
	addEvent(castSpell, 1750, creature:getId(), variant, 4)
	addEvent(castSpell, 2000, creature:getId(), variant, 1)
        addEvent(castSpell, 2250, creature:getId(), variant, 2)
	addEvent(castSpell, 2250, creature:getId(), variant, 3)
	addEvent(castSpell, 2750, creature:getId(), variant, 4)
	return true
end
