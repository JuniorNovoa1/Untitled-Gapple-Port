local shadname = "glitchEffect";
function onCreate()
    addHaxeLibrary('Character')
    initLuaShader(shadname)

    makeLuaSprite('fresh2', 'main/fresh-and-toasted/this_is_a_shuhbam-min', 0, 0)
    screenCenter('fresh2', 'x')
    setProperty("fresh2.x", getProperty("fresh2.x") - 275)
    scaleObject("fresh2", 1.3, 1.3)
    addLuaSprite('fresh2', false)
	setSpriteShader('fresh2', shadname)
    setShaderFloat('fresh2', 'uWaveAmplitude', 0.1)
    setShaderFloat('fresh2', 'uFrequency', 5)
    setShaderFloat('fresh2', 'uSpeed', 2)

    makeLuaSprite('fresh1', 'main/fresh-and-toasted/no-min', 0, 0)
    screenCenter('fresh1', 'x')
    setProperty("fresh1.x", getProperty("fresh1.x") - 200)
    scaleObject("fresh1", 1.2, 1.2)
    addLuaSprite('fresh1', false)
	setSpriteShader('fresh1', shadname)
    setShaderFloat('fresh1', 'uWaveAmplitude', 0.1)
    setShaderFloat('fresh1', 'uFrequency', 5)
    setShaderFloat('fresh1', 'uSpeed', 2)

    makeAnimatedLuaSprite("banduCar", "main/fresh-and-toasted/NEW bor", 0, 0)
    addAnimationByPrefix("banduCar", "ramBrob", "car REAL", 24, false)
    setProperty("banduCar.visible", false)
    scaleObject("banduCar", 2, 2)
    addLuaSprite("banduCar", true)

    
    makeLuaSprite("yay", "main/fresh-and-toasted/ho_ho_ho", 0, 0)
    --setProperty("yay.visible", false)
    setObjectCamera("yay", "hud")
    scaleObject("yay", 0, 0)
    updateHitbox("yay")
    screenCenter("yay")
    addLuaSprite("yay", false)
end

local elapsedtime = 0;

function onUpdatePost(elapsed)
    elapsedtime = elapsedtime + elapsed;
    setShaderFloat('fresh1', 'uTime', os.clock())
    setShaderFloat('fresh2', 'uTime', os.clock())
end