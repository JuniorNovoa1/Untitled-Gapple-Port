local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle', 'alpha'}

function onCreatePost()
    makeAnimatedLuaSprite('donkIcon', 'icons/dingonk', 0, 0)
    addAnimationByPrefix('donkIcon', 'dingle', 'dingle', 24, true)
    addAnimationByPrefix('donkIcon', 'donk', 'donk', 24, true)
    playAnim('donkIcon', 'donk', true);
    setObjectCamera('donkIcon', 'hud')
    addLuaSprite('donkIcon', false)

    if string.lower(songName) == 'the-big-dingle' then setProperty('donkIcon.visible', getDataFromSave("UnNamedGapplePortSettings", "badaiTime", false)) end

    setObjectOrder('donkIcon', getObjectOrder('iconP2'))
end

function onUpdate()
    setProperty('iconP2.visible', false)
    for i = 1, #stuff do
        setProperty('donkIcon.'..stuff[i], getProperty('iconP2.'..stuff[i]))
    end
end