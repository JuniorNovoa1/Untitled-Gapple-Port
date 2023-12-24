local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}

function onCreatePost()
    makeLuaSprite('iconFAKErubber', 'icons/rubber-winning', 0, 0)
    --setObjectCamera('iconFAKErubber', 'hud')
    setProperty('iconFAKErubber.visible', false)
    addLuaSprite('iconFAKErubber')

    setObjectOrder('iconFAKErubber', getObjectOrder('iconP1'))
end

function onBeatHit()
    cancelTween('iconP12SX')
    cancelTween('iconP12SY')
    setProperty('iconP12.scale.x', 1.2)
    setProperty('iconP12.scale.y', 1.2)
    doTweenX('iconP12SX', 'iconP12.scale', 1, 0.2)
    doTweenY('iconP12SY', 'iconP12.scale', 1, 0.2)
end
function onUpdate()
    for i = 1, #stuff do
        setProperty('iconFAKErubber.'..stuff[i], getProperty('iconP1.'..stuff[i]))
        if i == 1 then
            setProperty('iconFAKErubber.x', getProperty('iconFAKErubber.x') * 1.1)
        end
    end

    if getProperty('healthBar.percent') > 80 then
        setProperty('iconFAKErubber.visible', true)
        setProperty('iconP1.visible', false)
    else
        setProperty('iconFAKErubber.visible', false)
        setProperty('iconP1.visible', true)
    end
end