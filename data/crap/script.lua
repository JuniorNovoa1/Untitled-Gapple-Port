local zoomInAmount = 0.25;

function onCreate()
    precacheImage('NOTE_assets_3D')
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
			setPropertyFromGroup('playerStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end
    if not player then
		for i = 0, 4, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'noteSkins/'..skin)
		end
	end

    for i = 0, getProperty('notes.length') -1 do
        if getPropertyFromGroup('notes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('notes', i, 'texture', 'noteSkins/'..skin)
        end
    end

    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == player then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteSkins/'..skin)
        end
    end
end