local shadname = "stridentCrisisWavy";
function onCreate()
    makeLuaSprite('disruption', 'main/disruptor', 0, 250)
    setProperty('disruption.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('disruption', 'x')
    addLuaSprite('disruption', false)
    initLuaShader(shadname)
	setSpriteShader('disruption', shadname)
end

function onUpdate()
    setShaderFloat('disruption', 'uWaveAmplitude', 0.08)
	setShaderFloat('disruption', 'uFrequency', 3)
	setShaderFloat('disruption', 'uSpeed', 8)
end

function onUpdatePost(elapsed)
	setShaderFloat('disruption', 'uTime', os.clock())
end