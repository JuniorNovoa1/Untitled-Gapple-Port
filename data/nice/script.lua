local lockCam = false;

function onUpdate(elapsed)
    if lockCam then moveCam(650, 450) end
end

function onStepHit()
    if curStep == 2140 and flashingLights then 
        cameraFlash('other', 'FFFFFF', 1) --cam flash simulator 2
    end 
    if curStep == 2096 then lockCam = true; end

    if curStep == 2140 then 
        lockCam = false;
        setProperty("boyfriend.visible", false)
        setProperty("dad.visible", false)
        playAnim("schoolEntrance", "animEnter", true)
    end

    if curStep == 2144 then 
        setProperty("boyfriend.visible", true)
        setProperty("dad.visible", true)
        setProperty("defaultCamZoom", 0.9)
    end
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if flashingLights then
			cameraFlash('other', 'FFFFFF', 1)
		end
	end
end

function moveCam(x, y)
	triggerEvent('Camera Follow Pos', ''..x, ''..y) --didn't want to see this stupid shit everywhere
end