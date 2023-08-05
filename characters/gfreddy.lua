local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}

function onCreatePost()
    makeAnimatedLuaSprite('freddyIcon', 'icons/glam_icon_dance', 0, 0)
    addAnimationByPrefix('freddyIcon', 'left', 'glam-left', 24, true);
    addAnimationByPrefix('freddyIcon', 'right', 'glam-right', 24, true);
    playAnim('freddyIcon', 'idle', true);
    setObjectCamera('freddyIcon', 'hud')
    setProperty('freddyIcon.visible', false)
    addLuaSprite('freddyIcon', false)

    setObjectOrder('freddyIcon', getObjectOrder('iconP22'))
end

function onUpdate()
    for i = 1, #stuff do
        setProperty('freddyIcon.'..stuff[i], getProperty('iconP22.'..stuff[i]))
    end
end