local shadname = "glitchEffect";
function onCreate()
    makeLuaSprite('cuberoot', 'dave/cuberoot', 0, 0)
    setProperty('cuberoot.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('cuberoot', '')
    addLuaSprite('cuberoot', false)
    initLuaShader(shadname)
	setSpriteShader('cuberoot', shadname)
    setShaderFloat('cuberoot', 'uWaveAmplitude', 0.1)
    setShaderFloat('cuberoot', 'uFrequency', 5)
    setShaderFloat('cuberoot', 'uSpeed', 2)

    makeLuaSprite('poop', '', getProperty('cuberoot.x'), getProperty('cuberoot.y'))
    makeGraphic('poop', '2560', '1400', '000000')
    setProperty('poop.alpha', 0)
    updateHitbox('poop')
    addLuaSprite('poop', false)

    makeLuaSprite('poop2', '', getProperty('cuberoot.x'), getProperty('cuberoot.y'))
    makeGraphic('poop2', '2560', '1400', '000000')
    setProperty('poop2.alpha', 0.4)
    updateHitbox('poop2')
    addLuaSprite('poop2', true)
end

local elapsedtime = 0;

function onUpdatePost(elapsed)
    elapsedtime = elapsedtime + elapsed;
	setShaderFloat('cuberoot', 'uTime', os.clock())
    setProperty('poop.alpha', math.sin(elapsedtime) / 2.5 + 0.4);
end