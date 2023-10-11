function onBadaiCreate()
    setProperty("badai.x", -125)
    setProperty("badai.y", -1000) --150
end

local curTxtStep = {
    [6] = "Welcome to bambi's corn farm!"
}

function onStepHit()
    if curStep == 1680 then
        playAnim("dad", "stare")
        setProperty("dad.skipDance", true)
    end

    if curStep == 1696 then --1698
        playAnim("dad", "talk")
        setProperty("dad.skipDance", true)
    end

    if curStep == 1808 then --1808
        if flashingLights then cameraFlash("hud", "FFFFFF", 1) end
        setDataFromSave("Juniors Ports Stuff", "canFloat", false)
        doTweenY("dambu", "badai", 150, 1.5, "sineOut")
        doTweenX("dadFloaty", "dad", -675, 1.5, "sineOut")
        doTweenY("dadFloatyY", "dad", 100, 1.5, "sineOut")
    end

    if curStep == 3114 then --3114
        playAnim("badai", "talk")
        setProperty("badai.skipDance", true)
    end
end

function onTweenCompleted(tag)
    if tag == 'dadFloatyY' then
        setDataFromSave("Juniors Ports Stuff", "badaiTime", true)
        setDataFromSave("Juniors Ports Stuff", "canFloat", true)
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
end