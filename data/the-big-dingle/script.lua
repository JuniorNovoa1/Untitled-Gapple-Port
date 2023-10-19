function onBadaiCreate()
    setProperty("badai.x", 100)
    setProperty("badai.visible", false)
end

function onStepHit()
    if curStep == 1120 or curStep == 1312 or curStep == 1440 or curStep == 1568 or curStep == 1632 or curStep == 1696 then
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", not getDataFromSave("UnNamedGapplePortSettings", "badaiTime", false))
        if curStep == 1696 then playAnim("dad", "singUP", true) end
    end

    if not getDataFromSave("UnNamedGapplePortSettings", "badaiTime", false) then
        setProperty('dingleIcon.visible', true)
        setProperty('donkIcon.visible', false)
    else
        setProperty('dingleIcon.visible', false)
        setProperty('donkIcon.visible', true)
    end

    if curStep == 592 and luaSpriteExists("talking") then
        setProperty("talking.visible", true)
		playAnim("talking", "talk", true)
    end

    if curStep == 1120 then --party!!!!!
        if flashingLights then cameraFlash("hud", "FFFFFF", 1.5) end
        removeLuaSprite("sky", true)
        removeLuaSprite("city", true)
        removeLuaSprite("behindTrain", true)
        removeLuaSprite("street", true)
        removeLuaSprite("pon", true)
        removeLuaSprite("talking", true)
        setProperty("dad.x", getProperty("dad.x") - 25)
        setProperty("boyfriend.x", getProperty("boyfriend.x") + 500)
        setProperty("badai.visible", true)
    end
end