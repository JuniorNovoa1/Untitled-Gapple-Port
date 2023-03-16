local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}
local random = 0;

function onCreatePost()
    makeLuaSprite('iconFAKEbabom', 'icons/babom-winning', 0, 0)
    --setObjectCamera('iconFAKEbabom', 'hud')
    setProperty('iconFAKEbabom.visible', false)
    addLuaSprite('iconFAKEbabom')

    setObjectOrder('iconFAKEbabom', getObjectOrder('iconP2'))
end

function onBeatHit()
    cancelTween('iconP22SX')
    cancelTween('iconP22SY')
    setProperty('iconP22.scale.x', 1.2)
    setProperty('iconP22.scale.y', 1.2)
    doTweenX('iconP22SX', 'iconP22.scale', 1, 0.2)
    doTweenY('iconP22SY', 'iconP22.scale', 1, 0.2)
end

function onUpdate()
    for i = 1, #stuff do
        setProperty('iconFAKEbabom.'..stuff[i], getProperty('iconP2.'..stuff[i]))
        if i == 1 then
            setProperty('iconFAKEbabom.x', getProperty('iconFAKEbabom.x') * 1.1)
        end
    end

    if getProperty('healthBar.percent') < 20 then
        setProperty('iconFAKEbabom.visible', true)
        setProperty('iconP2.visible', false)
    else
        setProperty('iconFAKEbabom.visible', false)
        setProperty('iconP2.visible', true)
    end

    if getProperty('dad.animation.curAnim.name') == 'idle' then
        characterPlayAnim('dad', 'idle'..random, true)
    end
end

function opponentNoteHit()
    random = getRandomInt(0, 16)
end