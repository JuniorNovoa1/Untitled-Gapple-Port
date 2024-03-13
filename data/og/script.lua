function onCreatePost()
    setProperty("fpsTxt.visible", false)
	--setPropertyFromClass("Main", "fpsVar.visible", true)
	if not lowQuality then setProperty("healthBarBGnew.visible", false) end
	setProperty('timeTxt.visible', false)
	setTextFont('scoreTxt', 'vcr.ttf')
	setTextFont('timeTxt', 'vcr.ttf')
    setTextFont('kadeEngineWatermark', 'vcr.ttf')
    setTextBorder("kadeEngineWatermark", 1.75, "000000")
    setProperty("dad.healthColorArray[0]", 255)
    setProperty("dad.healthColorArray[1]", 0)
    setProperty("dad.healthColorArray[2]", 0)
    setProperty("boyfriend.healthColorArray[0]", 0)
    setProperty("boyfriend.healthColorArray[1]", 255)
    setProperty("boyfriend.healthColorArray[2]", 0)
    runHaxeCode([[game.reloadHealthBarColors();]])

    makeLuaSprite('redVG', 'vig_red', 0, 0)
    setObjectCamera('redVG', 'camhud')
    setProperty('redVG.alpha', 0)
    screenCenter('redVG')
    if not lowQuality then addLuaSprite('redVG', false) end
end
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Change Character" then
        setProperty("dad.healthColorArray[0]", 255)
        setProperty("dad.healthColorArray[1]", 0)
        setProperty("dad.healthColorArray[2]", 0)
        setProperty("boyfriend.healthColorArray[0]", 0)
        setProperty("boyfriend.healthColorArray[1]", 255)
        setProperty("boyfriend.healthColorArray[2]", 0)
        runHaxeCode([[game.reloadHealthBarColors();]])
    end
end

function doTweenDefaultCamZoom(tag, value, duration)
    runHaxeCode([[
        PlayState.instance.modchartTweens.set("]]..tag..[[", FlxTween.num(game.defaultCamZoom, ]]..value..[[, ]]..duration..[[, {
            onUpdate: function(twn) {
                game.defaultCamZoom = twn.value;
            }, onComplete: function(twn) {
                PlayState.instance.modchartTweens.remove("]]..tag..[[");
                PlayState.instance.callOnLuas('onTweenCompleted', ["]]..tag..[["]);
            }
        }));
    ]])
end

function onStepHit()
    if curStep == 256 or curStep == 384 or curStep == 512 or curStep == 640 or curStep == 768 or curStep == 1152 or curStep == 1216 or curStep == 1280 
    or curStep == 1344 or curStep == 1408 or curStep == 1472 or curStep == 1536 or curStep == 1664 then
        cameraFlash("game", "FFFFFF", 1 / playbackRate)
        if curStep == 1152 then doTweenAlpha("redVG", "redVG", 0.6, .5  / playbackRate, "") end
    end

    if curStep == 898 then
        doTweenDefaultCamZoom("cameraTween", 1.1, 1.5 / playbackRate)
        doTweenAlpha("thunderBlack", "thunderBlack", 0.6, 1.5 / playbackRate, "")
    end
    if curStep == 1144 then
        doTweenDefaultCamZoom("cameraTween", 1, 1 / playbackRate)
        doTweenAlpha("thunderBlack", "thunderBlack", 0, 1 / playbackRate, "")
    end

    if curStep == 1664 then
        setProperty("defaultCamZoom", 1.06)
        doTweenAlpha("thunderBlack", "thunderBlack", 0.15, .5 / playbackRate, "")
    end

    if curStep == 1680 then
        setProperty("defaultCamZoom", 1.12)
        doTweenAlpha("thunderBlack", "thunderBlack", 0.25, .5 / playbackRate, "")
    end

    if curStep == 1696 then
        setProperty("defaultCamZoom", 1.18)
        doTweenAlpha("thunderBlack", "thunderBlack", 0.35, .5 / playbackRate, "")
    end

    if curStep == 1712 then
        setProperty("defaultCamZoom", 1.24)
        doTweenAlpha("thunderBlack", "thunderBlack", 0.45, .5 / playbackRate, "")
    end

    if curStep == 1728 then
        setProperty("defaultCamZoom", 1.18)
        doTweenAlpha("thunderBlack", "thunderBlack", 0, .5 / playbackRate, "")
    end

    if curStep == 1744 then
        doTweenDefaultCamZoom("cameraTween", 0.9 / playbackRate, 1)
        doTweenAlpha("redVG", "redVG", 0, .5 / playbackRate, "")
    end
end