local canMessWithDups = false;
function onCreatePost()
    createIcons()
end

function onUpdatePost(elapsed)
	if canMessWithDups then
		doTweenX("iconMovementP1", "iconP12", getProperty("iconP1.x") - 20 + (getProperty("iconP1.width") / 4), 0.08, "sineInOut")
		doTweenX("iconMovementP2", "iconP22", getProperty("iconP2.x") + 20 - (getProperty("iconP2.width") / 4), 0.08, "sineInOut")
	end
    iconPropertys()
end

function onBeatHit()
    if string.lower(songName) == 'kooky' or string.lower(songName) == 'maze' then
    	return;
    end
    local iconPos = getProperty('healthBar.y') -75;

    if curBeat % getProperty('gfSpeed') == 0 then
    	local fuasd = {0.8, 1.3}
    	local angl = 15;
    	local yOffset = 20;

    	if curBeat % (getProperty('gfSpeed') * 2) == 0 then
            scaleObject('iconP12', 1.1, fuasd[1])
            scaleObject('iconP22', 1.1, fuasd[2])
            setProperty('iconP12.angle', -angl)
            setProperty('iconP22.angle', angl)
            setProperty('iconP12.y', iconPos - yOffset)
            setProperty('iconP22.y', iconPos + yOffset)
    	else
            scaleObject('iconP12', 1.1, fuasd[2])
            scaleObject('iconP22', 1.1, fuasd[1])
            setProperty('iconP12.angle', angl)
            setProperty('iconP22.angle', -angl)
            setProperty('iconP12.y', iconPos + yOffset)
            setProperty('iconP22.y', iconPos - yOffset)
    	end
    end

    doTweenY('iconP1yREAL', 'iconP12', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
    doTweenY('iconP2yREAL', 'iconP22', iconPos, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
    doTweenAngle('iconP1', 'iconP12', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
    doTweenAngle('iconP2', 'iconP22', 0, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
    doTweenX('iconP1x', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
    doTweenX('iconP2x', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
    doTweenY('iconP1y', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
    doTweenY('iconP2y', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')

    updateHitbox('iconP12')
    updateHitbox('iconP22')
    iconPropertys()
end

function createIcons()
	canMessWithDups = false;
	if luaSpriteExists("iconP12") then
		cancelTween("iconMovementP1")
		cancelTween("iconMovementP2")
		setProperty("iconP12.visible", false)
		setProperty("iconP22.visible", false)
	end
	setProperty("iconP1.visible", false)
	setProperty("iconP2.visible", false)
	runHaxeCode([[
		var iconP12 = new HealthIcon(game.boyfriend.healthIcon, true);
		iconP12.x = game.iconP1.x;
		iconP12.y = game.iconP1.y;
        game.add(iconP12);
        game.modchartSprites.set('iconP12', iconP12);
		var iconP22 = new HealthIcon(game.dad.healthIcon, false);
		iconP22.x = game.iconP2.x;
		iconP22.y = game.iconP2.y;
        game.add(iconP22);
        game.modchartSprites.set('iconP22', iconP22);
	]])
	setObjectOrder('iconP12', getObjectOrder('healthBarBGnew') + 1)
	setObjectOrder('iconP22', getObjectOrder('iconP12') + 1)
	setObjectCamera("iconP12", 'hud')
	setObjectCamera("iconP22", 'hud')
	canMessWithDups = true;
end

function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' then
		createIcons()
	end
end

function iconPropertys()
	if not canMessWithDups then return; end
	local props = {'alpha'}
	for i = 1, #props do
		setProperty("iconP12."..props[i], getProperty('iconP1.'..props[i]))
		setProperty("iconP22."..props[i], getProperty('iconP2.'..props[i]))
	end
end