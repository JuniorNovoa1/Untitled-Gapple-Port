local shadname = "glitchEffect";
function onCreate()
    makeLuaSprite('disabled', 'main/disabled', 0, 0)
    screenCenter('disabled', '')
    addLuaSprite('disabled', false)
    initLuaShader(shadname)
	setSpriteShader('disabled', shadname)
    setShaderFloat('disabled', 'uWaveAmplitude', 0.1)
    setShaderFloat('disabled', 'uFrequency', 5)
    setShaderFloat('disabled', 'uSpeed', 2)

    makeLuaSprite('poop', '', getProperty('disabled.x'), getProperty('disabled.y'))
    makeGraphic('poop', '2560', '1400', '000000')
    setProperty('poop.alpha', 0.4)
    updateHitbox('poop')
    addLuaSprite('poop', true)
end

function onUpdatePost(elapsed)
	setShaderFloat('disabled', 'uTime', os.clock())
end