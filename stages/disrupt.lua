local shadname = "glitchEffect";
function onCreate()
    makeLuaSprite('disruption', 'main/disruptor', 0, 0)
    screenCenter('disruption', 'x')
    addLuaSprite('disruption', false)
    initLuaShader(shadname)
	setSpriteShader('disruption', shadname)
    setShaderFloat('disruption', 'uWaveAmplitude', 0.1)
    setShaderFloat('disruption', 'uFrequency', 5)
    setShaderFloat('disruption', 'uSpeed', 2)

    makeLuaSprite('poop', '', getProperty('disruption.x'), getProperty('disruption.y'))
    makeGraphic('poop', '2560', '1400', '000000')
    setProperty('poop.alpha', 0)
    updateHitbox('poop')
    addLuaSprite('poop', false)
end

--[[function onCreatePost()
    makeLuaSprite('disruption_cube', 'main/disruptor_cube', getProperty("boyfriend.x"), getProperty("boyfriend.y") * 1.365)
    addLuaSprite('disruption_cube', false)
end--]]

local elapsedtime = 0;

function onUpdatePost(elapsed)
    elapsedtime = elapsedtime + elapsed;
	setShaderFloat('disruption', 'uTime', os.clock())
    setProperty('poop.alpha', math.sin(elapsedtime) / 2.5 + 0.4);
end