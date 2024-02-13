function onStepHit()
    if curStep == 767 or curStep == 888 or curStep == 1152 or curStep == 1216 or curStep == 1280 and flashingLights then
        cameraFlash("other", "FFFFFF", 1.2)
    end
    if curStep == 240 or curStep == 495 or curStep == 1175 or curStep == 1240 or curStep == 1392 or curStep == 1648 then
        tweenCamShits()
    end
    if curStep == 256 or curStep == 511 or curStep == 1184 or curStep == 1248 or curStep == 1408 or curStep == 1664 then
        tweenCamShitsUndoer()
    end

    if curStep == 879 then --863
        setProperty("thunderBlack.alpha", 1)
    end

    if curStep == 888 then
        setProperty("thunderBlack.alpha", 0)
    end
end

function tweenCamShits()
    doTweenAlpha("thunderBlack", "thunderBlack", 0.35, (crochet / 750) / playbackRate, "")
    setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
end

function tweenCamShitsUndoer()
    doTweenAlpha("thunderBlack", "thunderBlack", 0, (crochet / 750) / playbackRate, "")
    setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
    if flashingLights then
        cameraFlash("other", "FFFFFF", 1.2 / playbackRate)
    end
end

local pixel = false;

function onEvent(eventName, value1, value2, strumTime)
    if eventName == 'Change Character' and value1 == 'gf' then
        pixel = not pixel;
        if pixel then
            setProperty("gasStationBGpixel.visible", true)
            setProperty("boyfriend.x", getProperty("boyfriend.x") + 35)
            setProperty("boyfriend.y", getProperty("boyfriend.y") + 15)
            setProperty("dad.x", getProperty("dad.x") - 75)
            setProperty("dad.y", getProperty("dad.x") + 75)
            setProperty("gf.y", getProperty("gf.y") + 235)
        else
            setProperty("gasStationBGpixel.visible", false)
            setProperty("boyfriend.x", getProperty("boyfriend.x") - 35)
            setProperty("boyfriend.y", getProperty("boyfriend.y") - 15)
            setProperty("dad.x", getProperty("dad.x") + 75)
            setProperty("dad.y", getProperty("dad.x") - 75)
            setProperty("gf.y", getProperty("gf.y") + 235)
        end
    end
end