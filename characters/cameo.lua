local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}

function onCreatePost()
    makeAnimatedLuaSprite('cameoIcon', 'icons/glam_icon_dance_cam', 0, 0)
    addAnimationByPrefix('cameoIcon', 'left', 'cam-left', 24, true);
    addAnimationByPrefix('cameoIcon', 'right', 'cam-right', 24, true);
    playAnim('cameoIcon', 'idle', true);
    setObjectCamera('cameoIcon', 'hud')
    setProperty('cameoIcon.visible', false)
    addLuaSprite('cameoIcon', false)

    setObjectOrder('cameoIcon', getObjectOrder('iconP12'))
end

function onUpdate()
    for i = 1, #stuff do
        setProperty('cameoIcon.'..stuff[i], getProperty('iconP12.'..stuff[i]))
    end
end