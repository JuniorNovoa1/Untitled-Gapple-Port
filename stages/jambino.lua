local shadname = "glitchEffect";
function onCreate()
    makeLuaSprite('jambino', 'main/jambino/image1', 0, 0)
    scaleObject("jambino", 2, 2, true)
    screenCenter('jambino')
    addLuaSprite('jambino', false)
    initLuaShader(shadname)
	setSpriteShader('jambino', shadname)
    setShaderFloat('jambino', 'uWaveAmplitude', 0.1)
    setShaderFloat('jambino', 'uFrequency', 5)
    setShaderFloat('jambino', 'uSpeed', 2)
    setProperty("thunderBlack.alpha", 0.2)
end

local elapsedtime = 0;
function onUpdatePost(elapsed)
    elapsedtime = elapsedtime + elapsed;
	setShaderFloat('jambino', 'uTime', os.clock())
end