function onCreate()
    if not lowQuality then
        makeLuaSprite('faceCam', 'extras/readyLoud/facecam', 0, 0)
        scaleObject("faceCam", 0.8, 0.8, true)
        addLuaSprite('faceCam', false)
    end

    makeLuaSprite('flumpBG', 'extras/readyLoud/onaf', 0, 0)
    screenCenter("flumpBG", 'xy')
    addLuaSprite('flumpBG', true)

    setProperty("faceCam.x", getProperty("flumpBG.x") + 50)
    setProperty("faceCam.y", getProperty("flumpBG.y") - 25)

    makeAnimatedLuaSprite('flumpy', 'extras/readyLoud/flumpty', getProperty("flumpBG.x") + 500, getProperty("flumpBG.y") + 135)
    scaleObject("flumpy", 0.5, 0.5, true)
    addAnimationByPrefix("flumpy", "idle", "idle", 24, false)
    addAnimationByPrefix("flumpy", "jumpscare", "jumpscare", 24, false)
    addOffset("flumpy", "idle", 0, 0)
    addOffset("flumpy", "jumpscare", 500, 125)
    playAnim("flumpy", "idle", true)
    addLuaSprite('flumpy', true)

    makeAnimatedLuaSprite('owl', 'extras/readyLoud/owl', getProperty("flumpBG.x") + 500, getProperty("flumpBG.y") + 25)
    scaleObject("owl", 0.8, 0.8, true)
    addAnimationByPrefix("owl", "idle", "owl", 24, false)
    addOffset("owl", "idle", 0, 0)
    playAnim("owl", "idle", true)
    setProperty("owl.visible", false)
    addLuaSprite('owl', true)
end

function onUpdate(elapsed)
    callOnLuas("moveCam", {getProperty("flumpBG.x") + (getProperty("flumpBG.width") / 2), getProperty("flumpBG.y") + (getProperty("flumpBG.height") / 2)})
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if getProperty("flumpy.animation.curAnim.name") == 'idle' then
            playAnim("flumpy", "idle", true)
        end
    end
end