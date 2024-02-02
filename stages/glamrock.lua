function onCreate()
    makeLuaSprite('glamBG', 'extras/RobloxScreenShot20221121_014821793', 155, -200)
    scaleObject("glamBG", 1.3, 1.3)
    addLuaSprite('glamBG', false)
end

function onCreatePost()
    setProperty("gf.visible", true)
    setProperty("gf.x", getProperty("gf.x") + 415)
    setProperty("gf.y", getProperty("gf.y") - 200)
end