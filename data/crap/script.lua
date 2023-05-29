function onCreate()
    precacheImage('NOTE_assets_3D')
end

function onStepHit()
    if curStep == 1055 then --as soon as beat hits
        setProperty('farm.visible', false)
        setProperty('bestgf.visible', false)
        setProperty('mineBG.visible', true)
        changeNoteSkin(false, 'NOTE_assets_3D')
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 1119 then --after beat hits and opponent sings
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