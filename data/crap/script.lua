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
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - (zoomInAmount / 2))
        if flashingLights then
			cameraFlash('hud', 'FFFFFF', 1.5 / playbackRate)
		end
    end

    if curStep == 1184 then --after beat hits and opponent sings
        if flashingLights then
			--cameraFlash('hud', 'FFFFFF', 1.5)
		end
    end
end

function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Change Character" and value1 == "bf" and value2 == "dinner-bf" then
        setProperty("boyfriend.y", getProperty("boyfriend.y") + 220)
    end
end