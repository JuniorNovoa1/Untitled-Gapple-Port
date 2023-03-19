function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
            --setPropertyFromGroup('unspawnNotes', i, 'scrollFactor.x', 0.9)
            --setPropertyFromGroup('unspawnNotes', i, 'scrollFactor.y', 0.9)
        end
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end
    end

    runHaxeCode([[
        game.generateStaticArrows(0);
    ]])

    for direction = 4, 7 do
        setPropertyFromGroup('opponentStrums', direction, 'scrollFactor.x', 0.9)
        setPropertyFromGroup('opponentStrums', direction, 'scrollFactor.y', 0.9)
        setPropertyFromGroup('opponentStrums', direction, 'visible', false)
        setObjectCamera('opponentStrums.members['..direction..']', 'camGame')
    end

    for i = 4, 7, 1 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets_3D')
    end
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function onUpdatePost()
    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
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
            local noteDataa = getPropertyFromGroup('notes', i, 'noteData') + 1;
            if getPropertyFromGroup('notes', i, 'canBeHit') then
                setProperty('vocals.volume', 1)
                setProperty('gf.holdTimer', 0)
                strumAnim(noteDataa - 1, 'confirm', 0.15);
                setProperty('health', getProperty('health') -(healthtolower / 2.65))
                characterPlayAnim('gf', singAnims[noteDataa], true);
                removeFromGroup('notes', i, false)
            end
            setPropertyFromGroup('notes', i, 'x', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'x') - 135)
        end
    end
end

function onStepHit()
    if curStep == 767 then
        setProperty('hi.visible', false)
        setProperty('poop.visible', true)
        setProperty('defaultCamZoom', 0.55)
        cameraFlash('other', 'FFFFFF', 1)
    end

    if curStep == 800 then
        doTweenY('gf', 'gf', 350, 1.35, 'sineIn')
    end
end

function onTweenCompleted(tag)
    if tag == 'gf' then
        for direction = 4, 7 do
            setPropertyFromGroup('opponentStrums', direction, 'x', getProperty('gf.x') + 250 + getPropertyFromGroup('opponentStrums', direction, 'x'))
            setPropertyFromGroup('opponentStrums', direction, 'y', getProperty('gf.y') + 175)
            setPropertyFromGroup('opponentStrums', direction, 'visible', true)
        end
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