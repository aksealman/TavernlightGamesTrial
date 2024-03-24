-- Used "eternal_winter.lua" as a base it uses the same sprites needed in Q5.


local Frame1 = {
	{0,1,0,0,0,0,0,0,0},
	--below mc
	{1,0,0,0,2,0,0,0,1},
	--above mc
	{0,1,0,0,0,0,0,0,0},
	{0,0,1,0,0,0,0,0,0},
	{0,0,0,1,0,0,0,0,0},
}
local Frame2 = {
	{0,0,1,0,0,0,1,0,0},
	{0,0,0,0,0,0,0,1,0},
	{0,0,0,0,2,0,0,0,0},
        {0,0,0,0,0,1,0,1,0}
}

local Frame3 = {
	{0,0,1,0,2,0,1,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,1,0,0}
}
local Frame4 = {
	{0,0,0,0,0,1,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,1,0,0,0},
	{0,0,0,0,2,0,0,0,0}
}
combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat1:setArea(createCombatArea(Frame1))

combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat2:setArea(createCombatArea(Frame2))

combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat3:setArea(createCombatArea(Frame3))


combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat4:setArea(createCombatArea(Frame4))

function onGetFormulaValues1(player, level, magicLevel)
	return -1, -1
end

function onGetFormulaValues2(player, level, magicLevel)
	return -1, -1
end

function onGetFormulaValues3(player, level, magicLevel)
	return -1, -1
end

function onGetFormulaValues4(player, level, magicLevel)
	return -1, -1
end
combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")
combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")
combat4:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues4")

local function castSpell(creatureId, variant, combat_idx)
	local creature = Creature(creatureId)
	if not creature then
		return
	end
        if combat_idx == 1 then
		combat1:execute(creature, variant)
	elseif combat_idx == 2 then
		combat2:execute(creature, variant)
	elseif combat_idx == 3 then
		combat3:execute(creature, variant)
	elseif combat_idx == 4 then
		combat4:execute(creature, variant)
	end
end

function onCastSpell(creature, variant)
	--[[local player = Player(creature)
	if player == nil then
		return False
	end
        playerPos = player:getPosition()
	playerPos:sendMagicEffect(CONST_ME_ICETORNADO)
	print(playerPos.stackpos)
	playerPos.x = playerPos.x + 1 
	playerPos:sendMagicEffect(CONST_ME_ICETORNADO)
	playerPos.x = playerPos.x - 2 
	playerPos:sendMagicEffect(CONST_ME_ICETORNADO)
	]]--
	--local variant_id = variant:getId()
        castSpell(creature, variant, 1)
        addEvent(castSpell, 100, creature:getId(), variant, 2)
	addEvent(castSpell, 250, creature:getId(), variant, 3)
	addEvent(castSpell, 750, creature:getId(), variant, 4)
	addEvent(castSpell, 1000, creature:getId(), variant, 1)
        --addEvent(castSpell, 1100, creature:getId(), variant, 2)
        addEvent(castSpell, 1250, creature:getId(), variant, 2)
	addEvent(castSpell, 1250, creature:getId(), variant, 3)
	addEvent(castSpell, 1750, creature:getId(), variant, 4)
	addEvent(castSpell, 2000, creature:getId(), variant, 1)
        --addEvent(castSpell, 2100, creature:getId(), variant, 2)
        addEvent(castSpell, 2250, creature:getId(), variant, 2)
	addEvent(castSpell, 2250, creature:getId(), variant, 3)
	addEvent(castSpell, 2750, creature:getId(), variant, 4)
	return true
end
