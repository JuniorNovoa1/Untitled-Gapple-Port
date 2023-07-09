function onCreate()
    makeLuaSprite('gunk', 'secret/ticking/gunkk', 0, 0)
    scaleObject("gunk", 2.5, 2.5)
    updateHitbox("gunk")
    screenCenter('gunk', '')
    setProperty("gunk.x", getProperty("gunk.x") -150)
    addLuaSprite('gunk', false)

    makeAnimatedLuaSprite("tunnel", "secret/ticking/ticking_tunnel", 0, 0)
    addAnimationByPrefix("tunnel", "idle", "TUNNEL0", 12, true)
    playAnim("tunnel", "idle")
    setScrollFactor("tunnel", 1.1, 1.1)
    scaleObject("tunnel", 2.5, 2.5)
    updateHitbox("tunnel")
    screenCenter('tunnel', '')
    addLuaSprite('tunnel', false)
end