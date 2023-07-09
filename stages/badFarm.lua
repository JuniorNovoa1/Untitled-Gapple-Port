local shadname = "glitchEffect";

function onCreate()
    makeLuaSprite('farm', 'joke/wheels/moldy_shit', 0, 0)
    setProperty('farm.scale.x', 6)
    setProperty('farm.scale.y', 6)
    updateHitbox('farm')
    screenCenter('farm')
    addLuaSprite('farm', false)

    if string.lower(songName) == 'awesome' then
        initLuaShader(shadname)
        makeLuaSprite('farmNight', 'joke/wheels/moldy_shit_night', 0, 0)
        setProperty('farmNight.scale.x', 6)
        setProperty('farmNight.scale.y', 6)
        updateHitbox('farmNight')
        screenCenter('farmNight')
        setProperty("farmNight.visible", false)
        addLuaSprite('farmNight', false)

        makeLuaSprite('3d', 'joke/wheels/redness', 0, 0)
        setProperty('3d.scale.x', 6)
        setProperty('3d.scale.y', 6)
        updateHitbox('3d')
        screenCenter('3d')
        setProperty("3d.visible", false)
        addLuaSprite('3d', false)
        setSpriteShader('3d', shadname)
        setShaderFloat('3d', 'uWaveAmplitude', 0.1)
        setShaderFloat('3d', 'uFrequency', 5)
        setShaderFloat('3d', 'uSpeed', 2)

        setObjectOrder('dadGroup', 99)
    end

    if string.lower(songName) == 'crap!' then
        makeLuaSprite('mineBG', 'extras/mine_bg', 0, 0)
        setProperty('mineBG.visible', false)
        updateHitbox('mineBG')
        screenCenter('mineBG')
        setProperty('mineBG.y', getProperty('mineBG.y') +250)
        setProperty('mineBG.x', getProperty('mineBG.x') +100)
        addLuaSprite('mineBG', false)
    end
end

local elapsedtime = 0
function onUpdatePost(elapsed)
	elapsedtime = elapsedtime + elapsed
	setShaderFloat('3d', 'uTime', elapsedtime)
end

function onCreatePost()
    makeLuaSprite('bestgf', 'characters/joke/awesome/best_gf', getProperty('gf.x') * 1.25, getProperty('gf.y') * 1.5)
    setProperty('bestgf.scale.x', 2)
    setProperty('bestgf.scale.y', 2)
    addLuaSprite('bestgf', false)
    setProperty('gf.visible', false)

    setProperty('boyfriend.x', getProperty('boyfriend.x') -75)
    --setProperty('dad.x', getProperty('dad.x') -75)
end