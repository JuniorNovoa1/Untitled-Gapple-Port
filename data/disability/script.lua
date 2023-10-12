local elapsedtime = 0;
local lockCam = false;
local camZoomA = 1.25;
local camZoomTime = 3;

local camFlashTimes = {128, 640, 1152}

function onUpdate(elapsed)
    if lockCam then
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', false)
        doTweenZoom('camZoomGame', 'camGame', camZoomA, camZoomTime, "")
    else
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', true)
    end

    if getDataFromSave("UnNamedGapplePortSettings", 'modcharts', true) ~= true then
        return;
    end

    elapsedtime = elapsedtime +elapsed;

    for i = 0, 8 do
        setPropertyFromGroup("strumLineNotes", i, "angle", getPropertyFromGroup("strumLineNotes", i, "angle") + (math.sin(elapsedtime * 2.5) + 1) * 5)
    end
end

local invisObjs = {'healthBar', 'healthBarBG', 'iconP2', 'iconP1', 'timeTxt', 'scoreTxt', 'creditsWatermark'}

function onStepHit()
    if curStep == 128 or curStep == 640 or curStep == 1152 or curStep == 1664 or curStep == 2192 or curStep == 2704 or curStep == 2960 and flashingLights then 
        cameraFlash("other", "FFFFFF", 1.5)
    end
    if curBeat == 176 or curBeat == 224 or curBeat == 364 or curBeat == 384 then
        setProperty('gfSpeed', 2)
    end
    if curBeat == 208 or curBeat == 256 or curBeat == 372 or curBeat == 392 then
        setProperty('gfSpeed', 1)
    end

    if curStep == 1 then
        lockCam = true;
        doTweenAlpha("camHUD", "camHUD", 0, 3, "")
    end

    if curStep == 96 then
        camZoomA = 0.2;
    end

    if curStep == 128 then
        setProperty("defaultCamZoom", 0.9)
        camZoomA = 0.9;
        lockCam = false;
        setProperty("camHUD.alpha", 1)
        if flashingLights then
			cameraFlash('camother', 'FFFFFF', 2)
		end
    end

    if curStep == 895 then
        doTweenAlpha("poop", "poop", 0.6, 1.5, "")
        doTweenAlpha("bf", "boyfriend", 0.2, 1.5, "")
        doTweenAlpha("gf", "gf", 0.2, 1.5, "")

        for i = 1, #invisObjs do
            doTweenAlpha(""..i, invisObjs[i], 0, 2, "")
        end
    end

    if curStep == 1024 then
        doTweenAlpha("bf", "boyfriend", 1, 1.5, "")
        doTweenAlpha("dad", "dad", 0.2, 1.5, "")
    end

    if curStep == 1152 then
        for i = 1, #invisObjs do
            setProperty(invisObjs[i]..'.alpha', 1)
        end

        setProperty("dad.alpha", 1)
        changeNoteSkin(true, 'NOTE_assets_3D')
        setProperty("poop.alpha", 0.4)

        doTweenX("gfScaleX", "gf.scale", 0, 3, "sineOut")
        doTweenY("gfScaleY", "gf.scale", 0, 3, "sineOut")
        doTweenAngle("gfAngle", "gf", 180, 2.5, "sineOut")
        doTweenAlpha("gfAlpha", "gf", 0, 2.25, "sineIn")
    end

    if curStep >= 1152 and curStep <= 1200 then
        playAnim('gf', 'sad', true)
    end

    if curStep == 1536 then
        for i = 1, #invisObjs do
            doTweenAlpha(""..i, invisObjs[i], 0, 2, "")
        end
    end

    if curStep == 1664 then
        for i = 1, #invisObjs do
            setProperty(invisObjs[i]..'.alpha', 1)
        end
    end

    if curStep == 2176 or curStep == 2180 or curStep == 2184 or curStep == 2188 then
        if curStep == 2176 then camZoomA = getProperty("defaultCamZoom") end 
        camZoomA = camZoomA + (0.015 * 10);
        camZoomTime = 0.1;
        lockCam = true;
        setProperty("camHUD.alpha", 0)
    end

    if curStep == 2192 then 
        lockCam = false;
        setProperty("camHUD.alpha", 1)
    end

    if curStep == 3216 then
        doTweenAlpha("camHUD", "camHUD", 0, 24, "")
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