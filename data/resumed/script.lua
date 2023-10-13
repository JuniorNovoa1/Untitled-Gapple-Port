function onBadaiCreate()
    setProperty("badai.x", -125)
    setProperty("badai.y", -1000) --150
    --setProperty("badai.y", 150)
end

function onCreatePost()
    makeLuaText('dialogue', "", 0, 0, getProperty('healthBar.y') - 128)
	setObjectCamera('dialogue', 'camHUD')
	setTextAlignment('dialogue', 'center')
	setTextFont('dialogue', 'comic.ttf')
	setTextSize('dialogue', 20)
    setTextBorder("dialogue", 2, "000000")
	setProperty('dialogue.antialiasing', false)
	addLuaText('dialogue')
end

local lockCam = false;
local camZoomA = 1;
function onUpdate(elapsed)
    if lockCam then
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', false)
        doTweenZoom('camZoomGame', 'camGame', camZoomA, 0.1, "sineInOut")
    else
        setDataFromSave("UnNamedGapplePortSettings", 'camZoom', true)
    end

    updateHitbox('dialogue')
    screenCenter("dialogue", 'x')
end

function onStepHit()
    if curStep == 382 or curStep == 1808 or curStep == 2064 and flashingLights then cameraFlash("other", "FFFFFF", 1.5) end --390
    if curStep == 1680 then
        playAnim("dad", "look")
        setProperty("dad.skipDance", true)
    end

    if curStep == 1696 then --1698
        playAnim("dad", "talk")
        setProperty("dad.skipDance", true)
        setTextString("dialogue", "Now, let's get onto some curiosities!")
    end

    if curStep == 1728 then
        setTextString("dialogue", "")
    end

    if curStep == 1792 then --zoom in
        lockCam = true;
        camZoomA = getProperty("defaultCamZoom") + 0.8;
    end

    if curStep == 1800 then --zoom out
        camZoomA = getProperty("defaultCamZoom")
    end

    if curStep == 1808 then --1808
        lockCam = false;
        if flashingLights then cameraFlash("hud", "FFFFFF", 1) end
        setDataFromSave("UnNamedGapplePortSettings", "canFloat", false)
        doTweenY("dambu", "badai", 150, 1.5, "sineOut")
        doTweenX("dadFloaty", "dad", -675, 1.5, "sineOut")
        doTweenY("dadFloatyY", "dad", 75, 1.5, "sineOut")
        setProperty("dad.healthColorArray[0]", getProperty("badai.healthColorArray[0]"))
        setProperty("dad.healthColorArray[1]", getProperty("badai.healthColorArray[1]"))
        setProperty("dad.healthColorArray[2]", getProperty("badai.healthColorArray[2]"))
		setProperty("iconP22.visible", false)
        runHaxeCode([[
            var iconP22 = new HealthIcon(game.getLuaObject('badai', false).healthIcon, false);
            iconP22.x = game.iconP2.x;
            iconP22.y = game.iconP2.y;
            game.add(iconP22);
            game.modchartSprites.set('iconP22', iconP22);
            game.reloadHealthBarColors();
        ]])
        setObjectOrder('iconP22', getObjectOrder('iconP12') + 1)
        setObjectCamera("iconP22", 'hud')
    end

    if curStep == 3114 then --3114
        playAnim("badai", "talk")
        setProperty("badai.skipDance", true)
        setTextString("dialogue", "This is Dambu and see you later!")
    end

    if curStep == 3140 then --3114
        setTextString("dialogue", "")
    end
end

function onTweenCompleted(tag)
    if tag == 'dadFloatyY' then
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", true)
        setDataFromSave("UnNamedGapplePortSettings", "canFloat", true)
    end
end