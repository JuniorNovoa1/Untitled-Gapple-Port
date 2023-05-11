local darkMode = false;

function onCreatePost()
    makeLuaSprite('bgDark', '', getProperty('factory.x'), getProperty('factory.y'))
    makeGraphic('bgDark', getProperty('factory.width'), getProperty('factory.height'), '000000')
    setProperty('bgDark.alpha', 0)
    updateHitbox('bgDark')
    addLuaSprite('bgDark', false)

    makeLuaSprite('dark', '', getProperty('factory.x'), getProperty('factory.y'))
    makeGraphic('dark', getProperty('factory.width'), getProperty('factory.height'), '000000')
    setProperty('dark.alpha', 0)
    updateHitbox('dark')
    addLuaSprite('dark', true)
end

function onStepHit()
    if curStep == 64 then
        doTweenAlpha('darknessFade', 'poop', 0, 2, 'sineInOut')
        setProperty('defaultCamZoom', 1)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 192 then
        setProperty('defaultCamZoom', 0.6)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 384 then
        setProperty('spoarFolk.visible', true)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 640 then
        setProperty('gf.visible', false)
        setProperty('spoarFolk.visible', false)
        doTweenAlpha('darknessFade', 'poop', 0.6, 2, 'sineInOut')
        setProperty('defaultCamZoom', 1.4)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 704 then
        doTweenAlpha('darknessFade', 'poop', 0, 2, 'sineInOut')
        setProperty('defaultCamZoom', 1)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end

    if curStep == 832 then
        darkMode = true;
    end

    if curStep == 960 then
        darkMode = false;
        setProperty('bgDark.alpha', 0)
        setProperty('boyfriend.visible', true)
        setProperty('defaultCamZoom', 0.6)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end
end

function onUpdate(elapsed)
    if darkMode and flashingLights then
        setProperty('dark.alpha', getProperty('dark.alpha') + elapsed)
    end
end

function onEvent(tag, val1, val2)
    if tag == 'Change Character' and val1 == 'dad' and val2 == 'sart-producer-front' then
        setProperty('bgDark.alpha', 1)
        setProperty('defaultCamZoom', 1)
        setProperty('boyfriend.visible', false)
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    setProperty('dark.alpha', 0)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    setProperty('dark.alpha', 0)
end