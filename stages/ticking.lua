local shadname = "glitchEffect";

function onCreate()
    makeLuaSprite('gunk', 'secret/ticking/gunkk', 0, 0)
    scaleObject("gunk", 2.5, 2.5)
    updateHitbox("gunk")
    screenCenter('gunk', '')
    setProperty("gunk.x", getProperty("gunk.x") -150)
    addLuaSprite('gunk', false)
    setSpriteShader("gunk", shadname)
    setShaderFloat("gunk", 'uWaveAmplitude', 0.1)
    setShaderFloat("gunk", 'uFrequency', 5)
    setShaderFloat("gunk", 'uSpeed', 2)

    makeAnimatedLuaSprite("tunnel", "secret/ticking/ticking_tunnel", 0, 0)
    addAnimationByPrefix("tunnel", "idle", "TUNNEL0", 12, true)
    playAnim("tunnel", "idle")
    setScrollFactor("tunnel", 1.1, 1.1)
    scaleObject("tunnel", 2.5, 2.5)
    updateHitbox("tunnel")
    screenCenter('tunnel', '')
    addLuaSprite('tunnel', false)
end

local elapsedTime = 0
function onUpdatePost(elapsed)
	elapsedTime = elapsedTime + elapsed
	setShaderFloat("gunk", 'uTime', elapsedTime)
end