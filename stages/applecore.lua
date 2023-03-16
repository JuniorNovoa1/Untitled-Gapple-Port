local shadname = "stridentCrisisWavy";

local items = {'hi', 'poop'}
function onCreate()
    initLuaShader(shadname)
    for i = 1, #items do
        makeLuaSprite(items[i], 'main/applecore/'..items[i], 0, -250)
        setProperty(items[i]..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        setProperty(items[i]..'.visible', false)
        scaleObject(items[i], 1.75, 1.5)
        screenCenter(items[i], 'x')
        addLuaSprite(items[i], false)
        setSpriteShader(items[i], shadname)
    end

    setProperty('hi.visible', true)
end

function onUpdate()
    for i = 1, #items do
        setShaderFloat(items[i], 'uWaveAmplitude', 0.1)
	    setShaderFloat(items[i], 'uFrequency', 5)
	    setShaderFloat(items[i], 'uSpeed', 10)
    end
end

function onUpdatePost(elapsed)
    for i = 1, #items do
	    setShaderFloat(items[i], 'uTime', os.clock())
    end
end