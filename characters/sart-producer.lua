local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}

function onCreatePost()
    makeAnimatedLuaSprite('sartICON', 'icons/sartys_icon', 0, 0)
    addAnimationByPrefix('sartICON', 'idle', 'sart-producer0', 24, true);
    playAnim('sartICON', 'idle', true);
    setObjectCamera('sartICON', 'hud')
    setProperty('sartICON.visible', true)
    addLuaSprite('sartICON', false)
    setProperty('sartICON.offset.y', 25)

    setObjectOrder('sartICON', getObjectOrder('iconP2'))
end

function onUpdate()
    setProperty('iconP22.visible', false)
    for i = 1, #stuff do
        setProperty('sartICON.'..stuff[i], getProperty('iconP22.'..stuff[i]))
    end
end