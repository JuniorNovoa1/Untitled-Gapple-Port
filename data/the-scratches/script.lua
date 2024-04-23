function onCreate()
    if not lowQuality then
        makeAnimatedLuaSprite("discordAnimated", "extras/scratches/scrt", 0, 0)
        addAnimationByPrefix("discordAnimated", "idle", "transition thing", 24, false)
        setObjectCamera("discordAnimated", 'other')
        addLuaSprite("discordAnimated", false)
        setProperty("discordAnimated.visible", false)
    end
end

function onStepHit()
    if curStep == 799 then
        playAnim("discordAnimated", "idle", true)
        setProperty("discordAnimated.visible", true)
        makeLuaSprite("discordBG", "extras/scratches/disc-1", -20.5, -320.5)
        addLuaSprite("discordBG", false)
        makeLuaSprite("discord", "extras/scratches/skyfunny", -20.5, -320.5)
        addLuaSprite("discord", true)
        setProperty("defaultCamZoom", 1.5)
    end

    if curStep == 815 and flashingLights then
        cameraFlash("hud", "FFFFFF", 1 / playbackRate)
    end
    if curStep == 815 and luaSpriteExists("discordAnimated") then
        removeLuaSprite("discordAnimated", true)
    end

    if curStep == 1248 then
        setProperty("defaultCamZoom", 0.9)
        removeLuaSprite("discordBG", true)
        removeLuaSprite("discord", true)
        if flashingLights then cameraFlash("hud", "FFFFFF", 1 / playbackRate) end
    end

    if curStep == 1664 and flashingLights then cameraFlash("hud", "FFFFFF", 1 / playbackRate) end

    if curStep == 2751 then
        makeLuaSprite("discordBG", "extras/scratches/disc-2", -20.5, -320.5)
        addLuaSprite("discordBG", false)
        makeLuaSprite("discord", "extras/scratches/wugfunny", -20.5, -320.5)
        addLuaSprite("discord", true)
        setProperty("defaultCamZoom", 1.5)
        setProperty("dad.y", -305)
    
        cameraFlash("hud", "FFFFFF", 1 / playbackRate)
    end

    if curStep == 3295 then
        makeLuaSprite("discordBG", "extras/scratches/disc-3", -20.5, -320.5)
        addLuaSprite("discordBG", false)
        makeLuaSprite("discord", "extras/scratches/cyndafunny", -20.5, -320.5)
        addLuaSprite("discord", true)
        setProperty("dad.y", 0)
    
        cameraFlash("hud", "FFFFFF", 1 / playbackRate)
    end

    if curStep == 3840 then
        setProperty("defaultCamZoom", 0.9)
        removeLuaSprite("discordBG", true)
        removeLuaSprite("discord", true)
        if flashingLights then cameraFlash("hud", "FFFFFF", 1 / playbackRate) end
    end
end

function onEvent(eventName, value1, value2, strumTime)
    if eventName == 'Change Character' and (value2 == "sky" or value2 == "wug" or value2 == "cynda-scratches") then
        setProperty("boyfriend.scale.x", 0.1)
        setProperty("boyfriend.scale.y", 0.1)
        setProperty("boyfriend.x", -45)
        setProperty("boyfriend.y", 40)
        if value2 == "wug" then setProperty("boyfriend.x", 20) setProperty("boyfriend.y", -40) end
        if value2 == "cynda-scratches" then setProperty("boyfriend.x", -45) setProperty("boyfriend.y", -565) end
        setProperty("iconP1.flipX", true)
        if value2 == "cynda-scratches" then setProperty("iconP1.flipX", false) end
    elseif eventName == 'Change Character' and value1 == "bf" and (value2 ~= "sky" or value2 ~= "wug") then
        setProperty("iconP1.flipX", false)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if boyfriendName == "sky" then
        setProperty("boyfriend.offset.x", getProperty("boyfriend.offset.x") * getProperty("boyfriend.scale.x"))
        setProperty("boyfriend.offset.y", getProperty("boyfriend.offset.y") * getProperty("boyfriend.scale.y"))
    end
end