function onCreate()
    precacheImage("noteSkins/NOTE_assets_3D")
	precacheImage('noteSkins/NOTE_assets');
end

function onStepHit()
    if curStep == 1216 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.05)
    end

    if curStep == 1335 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.3)
    end

    if curStep == 1341 or curStep == 1696 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.15)
    end

    if curStep == 1463 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.25)
    end

    if curStep == 1472 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
    end

    if curStep == 1691 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
    end

    if curStep == 1728 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
    end

    if curStep == 2240 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
    end

    if curStep == 2304 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
    end

    if curStep == 2352 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
    end

    if curStep == 2368 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.3)
    end

    if curStep == 2480 or curStep == 2514 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
    end

    if curStep == 2528 then --night
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.6)
        setProperty("farmNight.visible", true)
        setProperty("thunderBlack.alpha", 0.35)
    end
end

function onEvent(tag, val1, val2)
    if tag == 'Change Character' then
        if flashingLights then cameraFlash("hud", "FFFFFF", 1) end
        if val2 == 'dave-wide' or val2 == 'awesomeBambiCrack' then
            setProperty("3d.visible", true)
            changeNoteSkin(false, 'NOTE_assets_3D')
        else
            setProperty("3d.visible", false)
            changeNoteSkin(false, 'NOTE_assets');
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