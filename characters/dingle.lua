local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle', 'alpha'}

function onCreatePost()
    makeAnimatedLuaSprite('dingleIcon', 'icons/dingonk', 0, 0)
    addAnimationByPrefix('dingleIcon', 'dingle', 'dingle', 24, true)
    addAnimationByPrefix('dingleIcon', 'donk', 'donk', 24, true)
    playAnim('dingleIcon', 'dingle', true);
    setObjectCamera('dingleIcon', 'hud')
    addLuaSprite('dingleIcon', false)

    setObjectOrder('dingleIcon', getObjectOrder('iconP2'))
end

function onUpdate()
    setProperty('iconP2.visible', false)
    for i = 1, #stuff do
        setProperty('dingleIcon.'..stuff[i], getProperty('iconP2.'..stuff[i]))
    end
end