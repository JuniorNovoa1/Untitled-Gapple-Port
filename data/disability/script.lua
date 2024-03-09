local elapsedtime = 0;
local lockCam = false;
local camZoomA = 1.25;
local camZoomTime = 3;

function onUpdate(elapsed)
    if lockCam then
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', false)
        doTweenZoom('camZoomGame', 'camGame', camZoomA, camZoomTime / playbackRate, "")
    else
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', true)
    end

    if getDataFromSave("UnNamedGapplePortSettings", 'modcharts', true) ~= true then
        return;
    end

    elapsedtime = elapsedtime +elapsed;

    for i = 0, 8 do
        setPropertyFromGroup("strumLineNotes", i, "angle", getPropertyFromGroup("strumLineNotes", i, "angle") + (math.sin(elapsedtime * 2.5) + 1) * 5 * playbackRate)
    end
end

local invisObjs = {'healthBar', 'healthBarBG', 'iconP2', 'iconP1', 'timeTxt', 'scoreTxt', 'kadeEngineWatermark'}

function onStepHit()
    if curStep == 128 or curStep == 640 or curStep == 1152 or curStep == 1664 or curStep == 2192 or curStep == 2704 or curStep == 2960 and flashingLights then 
        cameraFlash('other', 'FFFFFF', 1.5 / playbackRate)
    end
    if curBeat == 176 or curBeat == 224 or curBeat == 364 or curBeat == 384 then
        setProperty('gfSpeed', 2)
    end
    if curBeat == 208 or curBeat == 256 or curBeat == 372 or curBeat == 392 then
        setProperty('gfSpeed', 1)
    end

    if curStep == 1 then
        lockCam = true;
        doTweenAlpha("camHUD", "camHUD", 0, 3 / playbackRate, "")
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
			cameraFlash('camother', 'FFFFFF', 2 / playbackRate)
		end
    end

    if curStep == 895 then
        doTweenAlpha("poop", "poop", 0.6, 1.5 / playbackRate, "")
        doTweenAlpha("bf", "boyfriend", 0.2, 1.5 / playbackRate, "")
        doTweenAlpha("gf", "gf", 0.2, 1. / playbackRate, "")

        for i = 1, #invisObjs do
            doTweenAlpha(""..i, invisObjs[i], 0, 2 / playbackRate, "")
        end
    end

    if curStep == 1024 then
        doTweenAlpha("bf", "boyfriend", 1, 1.5 / playbackRate, "")
        doTweenAlpha("dad", "dad", 0.2, 1.5 / playbackRate, "")
    end

    if curStep == 1152 then
        for i = 1, #invisObjs do
            setProperty(invisObjs[i]..'.alpha', 1)
        end

        setProperty("dad.alpha", 1)
        setProperty("poop.alpha", 0.4)

        doTweenX("gfScaleX", "gf.scale", 0, 3 / playbackRate, "sineOut")
        doTweenY("gfScaleY", "gf.scale", 0, 3 / playbackRate, "sineOut")
        doTweenAngle("gfAngle", "gf", 180, 2.5 / playbackRate, "sineOut")
        doTweenAlpha("gfAlpha", "gf", 0, 2.25 / playbackRate, "sineIn")
    end

    if curStep >= 1152 and curStep <= 1200 then
        playAnim('gf', 'sad', true)
    end

    if curStep == 1536 then
        for i = 1, #invisObjs do
            doTweenAlpha(""..i, invisObjs[i], 0, 2 / playbackRate, "")
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
        doTweenAlpha("camHUD", "camHUD", 0, 24 / playbackRate, "")
    end
end