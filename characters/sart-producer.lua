local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}

function onCreatePost()
    makeAnimatedLuaSprite('sartICON', 'icons/sartys_icon', 0, 0)
    addAnimationByPrefix('sartICON', 'idle', 'sart-producer0', 24, true);
    objectPlayAnimation('sartICON', 'idle', true);
    setObjectCamera('sartICON', 'hud')
    setProperty('sartICON.visible', true)
    setProperty('iconP2.visible', false)
    addLuaSprite('sartICON', false)
    setProperty('sartICON.offset.y', 25)

    setObjectOrder('sartICON', getObjectOrder('iconP2'))
end

function onUpdate()
    for i = 1, #stuff do
        setProperty('sartICON.'..stuff[i], getProperty('iconP2.'..stuff[i]))
    end
end