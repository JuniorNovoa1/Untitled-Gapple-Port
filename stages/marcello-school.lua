function onCreate() --these xmls are kinda weird...
    makeAnimatedLuaSprite('schoolBamber', 'main/marcloo/mista', 0, 0)
    addAnimationByPrefix("schoolBamber", "animEnterStat", "GAY PEOPLE", 0, false)
    addAnimationByPrefix("schoolBamber", "animEnter", "GAY PEOPLE", 24, false)
    scaleObject("schoolBamber", 1.6, 1.6)
    screenCenter("schoolBamber")
    addLuaSprite('schoolBamber', false)
    playAnim("schoolBamber", "animEnterStat", true)
    
    makeAnimatedLuaSprite('schoolEntrance', 'main/marcloo/woah nice bg dude', 0, 0)
    addAnimationByPrefix("schoolEntrance", "static", "TRANS PEOPLE", 0, false)
    addAnimationByPrefix("schoolEntrance", "animEnter", "TRANS PEOPLE", 24, false)
    playAnim("schoolEntrance", "static")
    scaleObject("schoolEntrance", 1.2, 1.2)
    screenCenter("schoolEntrance")
    addLuaSprite('schoolEntrance', false)

    for i = 1, 2 do
        makeLuaSprite("cornBG"..i, "main/marcloo/mista/farm", 0, 0)
        setObjectCamera("cornBG"..i, "hud")
        updateHitbox("cornBG"..i)
        screenCenter("cornBG"..i)
        if i == 2 then setProperty("cornBG"..i..'.x', getProperty("cornBG"..i..'.x') - (screenWidth * 1.503)) end
        addLuaSprite("cornBG"..i, false)
        setProperty("cornBG"..i..'.visible', false)
    end

    makeAnimatedLuaSprite("funGames", "main/marcloo/mista/funGames", 0, 0)
    addAnimationByPrefix("funGames", "dance", "Dance", 24, true)
    playAnim("funGames", "dance")
    setObjectCamera("funGames", "hud")
    updateHitbox("funGames")
    screenCenter("funGames")
    addLuaSprite("funGames", false)
    setProperty("funGames.visible", false)

    makeAnimatedLuaSprite("bambiCutscene", "main/marcloo/mista/mista_bambi_awesome", 0, 0)
    addAnimationByPrefix("bambiCutscene", "grr", "the penis elf is staring at me", 24, false)
    setObjectCamera("bambiCutscene", "hud")
    updateHitbox("bambiCutscene")
    screenCenter("bambiCutscene")
    addLuaSprite("bambiCutscene", false)
    setProperty("bambiCutscene.x", getProperty("bambiCutscene.x") -50)
    setProperty("bambiCutscene.alpha", 0)

    makeLuaSprite("bfCutscene", "main/marcloo/mista/OUGH_IM_BROWNING", 0, 0)
    setObjectCamera("bfCutscene", "hud")
    updateHitbox("bfCutscene")
    screenCenter("bfCutscene")
    addLuaSprite("bfCutscene", false)
    setProperty("bfCutscene.visible", false)

    makeLuaSprite("phone", "main/marcloo/modly/pad", 0, 600)
    setObjectCamera("phone", "hud")
    scaleObject("phone", 2.5, 2.5)
    updateHitbox("phone")
    screenCenter("phone", 'x')
    addLuaSprite("phone", false)

    addHaxeLibrary('Character')
    runHaxeCode([[
        var errung = new Character(0, 0, 'errung');
        errung.visible = false;
        game.add(errung);
        game.modchartSprites.set('errung', errung);
    ]])
    setProperty("errung.color", getColorFromHex("1A1110"))
end

function onUpdate(elapsed)
    for i = 1, 2 do
        setProperty("cornBG"..i..".x", getProperty("cornBG"..i..'.x') + (2 * (elapsed / (1 / 120))))
        if getProperty("cornBG"..i..".x") >= (screenWidth) then
            screenCenter("cornBG"..i)
            setProperty("cornBG"..i..'.x', getProperty("cornBG"..i..'.x') - (screenWidth * 1.746))
        end
    end
end