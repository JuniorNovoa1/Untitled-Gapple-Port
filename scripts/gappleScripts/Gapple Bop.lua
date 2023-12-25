function onCreatePost()
	addHaxeLibrary("Math")
    addHaxeLibrary('FlxMath', 'flixel.math')
	makeLuaSprite("iconP12", "icons/missing", 0, 0)
	makeLuaSprite("iconP22", "icons/missing", 0, 0)
end

function onUpdatePost(elapsed)
	runHaxeCode([[
		var iconOffset = 26;
		setVar("playerIconPos", game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * game.iconP1.scale.x - 150) / 2 - iconOffset);
		setVar("dadIconPos", game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * game.iconP2.scale.x) / 2 - iconOffset * 2);
	]])
	doTweenX("iconMovementP12vhv", "iconP12", getProperty("playerIconPos"), 0.08, "sineInOut")
	doTweenX("iconMovementP22hvh", "iconP22", getProperty("dadIconPos"), 0.08, "sineInOut")
    iconPropertys()
end

function onBeatHit()
    if string.lower(songName) == 'kooky' then return; end
    local iconPos = getProperty('healthBar.y') -80;

    if curBeat % getProperty('gfSpeed') == 0 then
    	local fuasd = {0.8, 1.3}
    	local angl = 15;
    	local yOffset = 20;

    	if curBeat % (getProperty('gfSpeed') * 2) == 0 then
            scaleObject('iconP12', 1.1, fuasd[1])
            scaleObject('iconP22', 1.1, fuasd[2])
            setProperty('iconP1.angle', -angl)
            setProperty('iconP2.angle', angl)
            setProperty('iconP1.y', iconPos - yOffset)
            setProperty('iconP2.y', iconPos + yOffset)
    	else
            scaleObject('iconP12', 1.1, fuasd[2])
            scaleObject('iconP22', 1.1, fuasd[1])
            setProperty('iconP1.angle', angl)
            setProperty('iconP2.angle', -angl)
            setProperty('iconP1.y', iconPos + yOffset)
            setProperty('iconP2.y', iconPos - yOffset)
    	end
    end

    doTweenY('iconP1yREAL', 'iconP1', iconPos, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP2yREAL', 'iconP2', iconPos, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenAngle('iconP1Angl', 'iconP1', 0, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenAngle('iconP2Angl', 'iconP2', 0, (crochet / 1300 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenX('iconP1x', 'iconP12.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenX('iconP2x', 'iconP22.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP1y', 'iconP12.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')
    doTweenY('iconP2y', 'iconP22.scale', 1, (crochet / 1250 * getProperty('gfSpeed')) / playbackRate, 'quadOut')

    updateHitbox('iconP12')
    updateHitbox('iconP22')
    iconPropertys()
end

function iconPropertys()
	local props = {'scale.x', 'scale.y', 'x'}
	for i = 1, #props do
		setProperty("iconP1."..props[i], getProperty('iconP12.'..props[i]))
		setProperty("iconP2."..props[i], getProperty('iconP22.'..props[i]))
	end
end