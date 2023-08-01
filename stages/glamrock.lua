function onCreate()
    makeLuaSprite('glamBG', 'extras/RobloxScreenShot20221121_014821793', 155, -200)
    scaleObject("glamBG", 1.3, 1.3)
    addLuaSprite('glamBG', false)
end

function onCreatePost()
    setProperty("gf.visible", true)
    callOnLuas("addToVal", {'gf.x', 415})
    callOnLuas("addToVal", {'gf.y', 200})
end