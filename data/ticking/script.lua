local elapsedTime = 0.0;

function onUpdate(elapsed)
    elapsedTime = elapsedTime + elapsed / 1.2;
    setProperty("camHUD.angle", math.sin(elapsedTime) * 0.5)
end

function onStepHit()
    if curStep == 191 or curStep == 255 or curStep == 320 or curStep == 384 or curStep == 512 or curStep == 640 or curStep == 768 or curStep == 896 or curStep == 1024 or curStep == 1152 and flashingLights then
        cameraFlash('other', 'FFFFFF', 1.5 / playbackRate) --CAM FLASH SIMULATOR RETURNS BITCHES!!
    end

    if curStep == 384 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
    end

    if curStep == 512 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1)
        --enable glitch shader to spinny bg
    end

    if curStep == 636 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
        --disable glitch shader to spinny bg
    end

    if curStep == 640 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.25)
    end

    if curStep == 828 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
        --enables eyesores
    end

    if curStep == 832 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.25)
        --disables eyesores
    end

    if curStep == 1279 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
        doTweenX("dadScaleX", "dad.scale", 0, 2 / playbackRate, "")
        doTweenY("dadScaleY", "dad.scale", 0, 2 / playbackRate, "")
    end
end

function onTweenCompleted(tag)
    if tag == 'dadScaleY' then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.25)
    end
end