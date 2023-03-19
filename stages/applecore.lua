local shadname = "stridentCrisisWavy";

local items = {'hi', 'poop', 'yeah'}
function onCreate()
    initLuaShader(shadname)
    for i = 1, #items do
        makeLuaSprite(items[i], 'main/applecore/'..items[i], 0, -250)
        setProperty(items[i]..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        setProperty(items[i]..'.visible', false)
        scaleObject(items[i], 1.75, 1.5)
        if i == 3 then
            setProperty(items[i]..'.y', -500)
            scaleObject(items[i], 2.5, 2.5)
        end
        screenCenter(items[i], 'x')
        addLuaSprite(items[i], false)
        setSpriteShader(items[i], shadname)
    end

    makeAnimatedLuaSprite('gfe', 'characters/GF_assets', 350, 500)
    setProperty('gfe.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addAnimationByPrefix('gfe', 'idle', 'GF Dancing Beat0', 24, true)
    objectPlayAnimation('gfe', 'idle', true)
    addLuaSprite('gfe', false)

    setProperty('hi.visible', true)
end

function onUpdate()
    for i = 1, #items do
        if i == 3 then
            setShaderFloat(items[i], 'uWaveAmplitude', 0.2)
            setShaderFloat(items[i], 'uFrequency', 10)
            setShaderFloat(items[i], 'uSpeed', 20)
        else
            setShaderFloat(items[i], 'uWaveAmplitude', 0.1)
            setShaderFloat(items[i], 'uFrequency', 5)
            setShaderFloat(items[i], 'uSpeed', 10)
        end
    end
end

function onUpdatePost(elapsed)
    for i = 1, #items do
	    setShaderFloat(items[i], 'uTime', os.clock())
    end
end