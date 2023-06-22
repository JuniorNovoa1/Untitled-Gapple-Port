local zoomInAmount = 0.25;

function onCreate()
    precacheImage('NOTE_assets_3D')
end

function onCreatePost()
    runHaxeCode([[
        game.generateStaticArrows(0);
    ]])
    for direction = 0, getProperty("strumLineNotes.length") do
        --setPropertyFromGroup('strumLineNotes', direction, 'scale.x', getPropertyFromGroup("strumLineNotes", direction, "scale.x") - 0.05)
        --setPropertyFromGroup('strumLineNotes', direction, 'scale.y', getPropertyFromGroup("strumLineNotes", direction, "scale.y") - 0.05)
        if direction >= 8 then
            setPropertyFromGroup('strumLineNotes', direction, 'x', getPropertyFromGroup("strumLineNotes", direction, "x") - 600)
        end
    end
end

--[[function onUpdatePost(elapsed)
    for i = 0, getProperty('notes.length') -1 do
        if curStep >= 1114 and getPropertyFromGroup('notes', i, 'mustPress') == false then
            setPropertyFromGroup('notes', i, 'hitByOpponent', true)
			local earlyHitMult = getPropertyFromGroup('notes', i, 'earlyHitMult');
			earlyHitMult = 0.01;
            if getPropertyFromGroup('notes', i, 'strumTime') > getPropertyFromClass('Conductor', 'songPosition') - (getPropertyFromClass('Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'lateHitMult')) and getPropertyFromGroup('notes', i, 'strumTime') < getPropertyFromClass('Conductor', 'songPosition') + (getPropertyFromClass('Conductor', 'safeZoneOffset') * earlyHitMult) then
				setPropertyFromGroup('notes', i, 'canBeHit', true);
			else
				setPropertyFromGroup('notes', i, 'canBeHit', false);
			end
            local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
            local noteDataa = getPropertyFromGroup('notes', i, 'noteData') + 1;
            if getPropertyFromGroup('notes', i, 'canBeHit') then
                setProperty('vocals.volume', 1)
                strumAnim(noteDataa - 1, 'confirm', 0.15);
                setProperty("dad.holdTimer", 0)
                playAnim('dad', singAnims[noteDataa], true)
                removeFromGroup('notes', i, false)
            end
            setPropertyFromGroup('notes', i, 'offset.x', 450)
        end
    end
end--]]

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

function onStepHit()
    if curStep == 836 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + zoomInAmount)
    end

    if curStep == 1114 then --as soon as beat hits
        setProperty('farm.visible', false)
        setProperty('gf.visible', true)
        setProperty('bestgf.visible', false)
        setProperty('mineBG.visible', true)
        changeNoteSkin(false, 'NOTE_assets_3D')
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - (zoomInAmount / 2))
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end

        --[[for direction = 0, getProperty("playerStrums.length") do
            doTweenX("noteP"..direction, "playerStrums.members["..direction.."]", screenWidth -425 +(100 * direction), 2, "sineInOut")
        end
        for direction = 0, getProperty("opponentStrums.length") do
            if direction <= 3 then
                doTweenX("noteO"..direction, "opponentStrums.members["..direction.."]", screenWidth -(425 * 1.985) +(100 * direction), 2, "sineInOut")
            else
                doTweenX("noteO"..direction, "opponentStrums.members["..direction.."]", screenWidth -(425 * 3.925) +(100 * direction), 2, "sineInOut")
            end
        end--]]
    end

    if curStep == 1184 then --after beat hits and opponent sings
        if flashingLights then
			--cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end
end

function changeNoteSkin(player, skin)
	if player == true then
		for i = 0, 4, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', skin)
		end
	end
    if not player then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', skin)
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('notes', i, 'texture', skin)
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', skin)
        end
    end
end