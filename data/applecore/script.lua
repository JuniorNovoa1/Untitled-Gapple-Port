local oldVal = {false, false}
local bambiPissed = false;
local unfairPart = false;

local originPosX = {};
local originPosY = {};

function onBadaiCreate()
    setProperty("badai.x", -500)
    setProperty("badai.y", -800)
    setProperty("badai.scale.x", 0.85)
    setProperty("badai.scale.y", 0.85)
    setProperty("badai.visible", false)
    setObjectOrder('badai', getObjectOrder('boyfriendGroup'))
end

function onCreatePost()
    addLuaScript('activatedScripts/VG');
    setProperty('vg.visible', false)
    addCharacterToList('unfair-junker', 'dad')
    oldVal[1] = middleScroll;
    oldVal[2] = ghostTapping;
end

function onSongStart()
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
            setPropertyFromGroup('unspawnNotes', i, 'scrollFactor.x', 0.9)
            setPropertyFromGroup('unspawnNotes', i, 'scrollFactor.y', 0.9)
        end
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/NOTE_assets_3D')
        end
    end
    runHaxeCode([[game.generateStaticArrows(0);]])
    for direction = 4, 7 do
        setPropertyFromGroup('opponentStrums', direction, 'x', getProperty("bambi.x") + 235 + getPropertyFromGroup('opponentStrums', direction, 'x'))
        setPropertyFromGroup('opponentStrums', direction, 'y', getProperty("bambi.y") + 100)
        setPropertyFromGroup('opponentStrums', direction, 'scrollFactor.x', 0.9)
        setPropertyFromGroup('opponentStrums', direction, 'scrollFactor.y', 0.9)
        setPropertyFromGroup('opponentStrums', direction, 'visible', false)
        setObjectCamera('opponentStrums.members['..direction..']', 'camGame')
    end

    for i = 0, getProperty('strumLineNotes.length') do
        originPosX[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        originPosY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end 

    for i = 4, 7, 1 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'noteSkins/NOTE_assets_3D')
    end
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local elapsedtime = 0;

function moveCam(x, y)
	triggerEvent('Camera Follow Pos', ''..x, ''..y) --didn't want to see this stupid shit everywhere
end

local camLock = false;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;
    if bambiPissed then
        for i = 0, getProperty('strumLineNotes.length') do
            local nope = false;
            if i <= 3 then
                nope = true;
            end
            if not nope and getDataFromSave("UnNamedGapplePortSettings", 'modcharts', true) then
                local krunkThing = 60;
                if getPropertyFromGroup('strumLineNotes', i, 'ID') % 2 == 0 then
                    setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsedtime) * (1) * krunkThing)))
                    setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsedtime - 5) * (1) * krunkThing))
                    setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsedtime - 5) * (1) / 4))
                    setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsedtime) * (1)) / 2))
                else
                    setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsedtime) * (-1) * krunkThing)))
                    setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsedtime - 5) * (-1) * krunkThing))
                    setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsedtime - 5) * (-1) / 4))
                    setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsedtime) * (-1)) / 2))
                end
        
                setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') + 0.2)
                setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') + 0.2)
        
                setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') * 1.5)
                setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') * 1.5)
            end
        end
    elseif unfairPart and getDataFromSave("UnNamedGapplePortSettings", 'modcharts', true) then
        for i = 0, getProperty('strumLineNotes.length') do
            setPropertyFromGroup('strumLineNotes', i, 'x', ((screenWidth / 2) - (getPropertyFromGroup('strumLineNotes', i, 'width') / 2)) + (math.sin(elapsedtime + (i)) * 300))
            setPropertyFromGroup('strumLineNotes', i, 'y', ((screenHeight / 2) - (getPropertyFromGroup('strumLineNotes', i, 'height') / 2)) + (math.cos(elapsedtime + (i)) * 300))
        end
    end
    if bambiPissed or unfairPart then
        setProperty("bambi.y", getProperty("bambi.y") - (math.sin(elapsedtime) * 0.6))
    end
end

function onUpdatePost()
    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' and not getPropertyFromGroup('notes', i, 'mustPress') then
            setObjectCamera('notes.members['..i..']', 'camGame')
            setPropertyFromGroup('notes', i, 'hitByOpponent', true)
			local earlyHitMult = getPropertyFromGroup('notes', i, 'earlyHitMult');
			earlyHitMult = 0.125; --bambi hit notes early
            if getPropertyFromGroup('notes', i, 'strumTime') > getPropertyFromClass('Conductor', 'songPosition') - (getPropertyFromClass('Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'lateHitMult')) and getPropertyFromGroup('notes', i, 'strumTime') < getPropertyFromClass('Conductor', 'songPosition') + (getPropertyFromClass('Conductor', 'safeZoneOffset') * earlyHitMult) then
				setPropertyFromGroup('notes', i, 'canBeHit', true);
			else
				setPropertyFromGroup('notes', i, 'canBeHit', false);
			end
            local healthtolower = 0.02;
            local daNoteDataa = getPropertyFromGroup('notes', i, 'noteData') + 1;
            if getPropertyFromGroup('notes', i, 'canBeHit') then
                setProperty('vocals.volume', 1)
                setProperty('bambi.holdTimer', 0)
                strumAnim(daNoteDataa - 1, 'confirm', 0.15);
                setProperty('health', getProperty('health') -(healthtolower / 2.65))
                if getDataFromSave("UnNamedGapplePortSettings", 'screenshake', true) then
                    triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
                end
                playAnim('bambi', singAnims[daNoteDataa], true)
                removeFromGroup('notes', i, false)
            end
            setPropertyFromGroup('notes', i, 'x', getPropertyFromGroup('opponentStrums', 4 + getPropertyFromGroup('notes', i, 'noteData'), 'x'))
            setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('opponentStrums', 4 + getPropertyFromGroup('notes', i, 'noteData'), 'scale.x'))
            setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('opponentStrums', 4 + getPropertyFromGroup('notes', i, 'noteData'), 'scale.y'))
            if not downscroll then
                setPropertyFromGroup('notes', i, 'offset.y', getPropertyFromGroup('opponentStrums', 4 + getPropertyFromGroup('notes', i, 'noteData'), 'y') - 275)
            end
        end
    end

    if camLock then
        moveCam(625, -625)
    end
end

function onStepHit()
    if curBeat == 160 or curBeat == 436 or curBeat == 684 then
        setProperty('gfSpeed', 2)
    end
    if curBeat == 240 then
        setProperty('gfSpeed', 1)
    end

    if curStep == 767 then
        bambiPissed = true;
        setProperty('pizza.visible', false)
        setProperty('pizza1.visible', false)
        setProperty('minion.visible', true)
        setProperty('minion1.visible', true)
        setProperty('creditsText.text', 'Screw you!')

        removeLuaSprite('hi', true)
        setProperty('poop.visible', true)
        setProperty('defaultCamZoom', 0.55)
        if flashingLights then
			cameraFlash('camother', 'FFFFFF', 1)
		end
    end

    if curStep == 800 then
        setProperty('bambi.visible', true)
        doTweenY('bambi', 'bambi', 100, 1.35, 'sineIn')
    end

    if curStep == 1984 then
        for direction = 4, 7 do
            setPropertyFromGroup('opponentStrums', direction, 'visible', false)
        end
        bambiPissed = false;
        unfairPart = true;
        setProperty('gfSpeed', 1)
        setProperty('minion.visible', false)
        setProperty('minion1.visible', false)
        for i = 0, getProperty('strumLineNotes.length') do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', 0.7)
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.7)
        end
        setProperty('creditsText.text', 'Ghost tapping is forced off! Screw you!')
        if stringStartsWith(version, '0.6') then
            setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
        else
            setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', false)
        end

        removeLuaSprite('poop', true)
        setProperty('yeah.visible', true)
        setProperty('defaultCamZoom', 0.425)
        if flashingLights then
			cameraFlash('camother', '000000', 1.5)
		end
        setProperty('vg.visible', true)
    end

    if curStep == 2088 then
        makeAnimatedLuaSprite('expunged', 'characters/main/applecore/UNFAIR_GUY_FAICNG_FORWARD', -125, -200)
        addAnimationByPrefix('expunged', 'idle', 'idle0', 12, true)
        playAnim('expunged', 'idle', true)
        setProperty('expunged.alpha', 0)
		addLuaSprite('expunged', true)
        setObjectOrder('expunged', getObjectOrder('gfGroup') -1)

        makeLuaSprite('monkey_guy', 'main/applecore/monkey_guy', getProperty('dad.x'), getProperty('dad.y'))
        scaleObject('monkey_guy', getProperty('dad.scale.x'), getProperty('dad.scale.y'))
        setProperty('monkey_guy.visible', false)
		addLuaSprite('monkey_guy', true)

        makeLuaSprite('monkey_person', 'main/applecore/monkey_person', getProperty('bambi.x'), getProperty('bambi.y'))
        scaleObject('monkey_person', getProperty('bambi.scale.x'), getProperty('bambi.scale.y'))
        setProperty('monkey_person.visible', false)
		addLuaSprite('monkey_person', true)
    end

    if curStep == 2096 then
        doTweenAlpha('expunged', 'expunged', 1, 1, 'sineInOut')
    end

    if curStep == 2110 then
        doTweenX('expungedX', 'expunged.scale', 2, 1, 'sineInOut')
        doTweenY('expungedY', 'expunged.scale', 2, 1, 'sineInOut')
        camLock = true;
    end

    if curStep == 2127 then
        for direction = 4, 7 do
            setPropertyFromGroup('opponentStrums', direction, 'visible', false)
        end
        setProperty('bambi.visible', false)
    end

    if curStep >= 2128 and curStep <= 2146 then
        playAnim('dad', 'inhale', false)
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
		if getProperty('bambi.animation.curAnim.name') == 'idle' then
			playAnim('bambi', 'idle', true)
		end
	end
end

function onTweenCompleted(tag)
    if tag == 'bambi' then
        for direction = 4, 7 do
            setPropertyFromGroup('opponentStrums', direction, 'x', getProperty("bambi.x") + 235 + getPropertyFromGroup('opponentStrums', direction, 'x'))
            setPropertyFromGroup('opponentStrums', direction, 'y', getProperty("bambi.y") + 100)
            setPropertyFromGroup('opponentStrums', direction, 'visible', true)
        end
    end

    if tag == 'expungedY' then
        triggerEvent('Change Character', 'dad', 'unfair-junker')
        setObjectOrder('dadGroup', getObjectOrder('gfGroup') -1)
        setProperty('dad.x', -125)
        setProperty('dad.y', 200)
        setProperty('bambi.visible', false)
        setProperty('monkey_guy.visible', true)
        setProperty('monkey_person.visible', true)

        doTweenX('monkey_guyXX', 'monkey_guy', getProperty('dad.x'), 1.7, 'sineInOut')
        doTweenY('monkey_guyYY', 'monkey_guy', getProperty('dad.y'), 1.7, 'sineInOut')
        doTweenX('monkey_guyX', 'monkey_guy.scale', 0, 1.7, 'sineInOut')
        doTweenY('monkey_guyY', 'monkey_guy.scale', 0, 1.7, 'sineInOut')
        doTweenX('monkey_personXX', 'monkey_person', getProperty('dad.x'), 1.7, 'sineInOut')
        doTweenY('monkey_personYY', 'monkey_person', getProperty('dad.y'), 1.7, 'sineInOut')
        doTweenX('monkey_personX', 'monkey_person.scale', 0, 1.7, 'sineInOut')
        doTweenY('monkey_personY', 'monkey_person.scale', 0, 1.7, 'sineInOut')
        doTweenAngle('monkey_guy', 'monkey_guy', 120, 1.7, 'sineInOut')
        doTweenAngle('monkey_person', 'monkey_person', 120, 1.7, 'sineInOut')
        playSound('suck', 1, 'suck')
        doTweenX('expungedLeft', 'dad', getProperty('dad.x') -165, 2.8 * 1.125, 'sineInOut')
        doTweenY('expungedUP', 'dad', getProperty('dad.y') -165 * 2, 2.8 / 2, 'sineInOut')
        setProperty('expunged.visible', false)
        camLock = false;
    end

    if tag == 'monkey_person' then
        stopSound('suck')
        removeLuaSprite('monkey_guy')
        removeLuaSprite('monkey_person')
        removeLuaSprite('expunged')
    end
end

function strumAnim(direction, fool, timer)
	runHaxeCode([[
		var directionStrum = ]]..direction..[[;
		var animAtion = ']]..fool..[[';
		var time = ']]..timer..[[';
		var strum = game.strumLineNotes.members[8 + directionStrum];
		strum.playAnim(animAtion, true);
		strum.resetAnim = time;
	]])
end

function onGameOver()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
        setPropertyFromClass('ClientPrefs', 'ghostTapping', oldVal[2])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
        setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', oldVal[2])
    end
end

function onEndSong()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
        setPropertyFromClass('ClientPrefs', 'ghostTapping', oldVal[2])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
        setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', oldVal[2])
    end
end

function onDestroy()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
        setPropertyFromClass('ClientPrefs', 'ghostTapping', oldVal[2])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
        setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', oldVal[2])
    end
end