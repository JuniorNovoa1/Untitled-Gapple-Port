local stuff = {'x', 'y', 'scale.x', 'scale.y', 'angle'}
local random = 0;

function onCreatePost()
    makeLuaSprite('iconWinningBambiAngy', 'icons/bambiMad-winning', 0, 0)
    setObjectCamera('iconWinningBambiAngy', 'hud')
    setProperty('iconWinningBambiAngy.visible', false)
    addLuaSprite('iconWinningBambiAngy')

    setObjectOrder('iconWinningBambiAngy', getObjectOrder('iconP2'))
end

function onUpdate()
    for i = 1, #stuff do
        setProperty('iconWinningBambiAngy.'..stuff[i], getProperty('iconP2.'..stuff[i]))
    end

    if dadName == "bambiMad" then
        if getProperty('healthBar.percent') < 20 then
            setProperty('iconWinningBambiAngy.visible', true)
            setProperty('iconP2.visible', false)
        else
            setProperty('iconWinningBambiAngy.visible', false)
            setProperty('iconP2.visible', true)
        end
    end
end

function onEvent(eventName, value1, value2, strumTime)
    if tag == "Change Character" and value1 == "dad" then
        if value2 ~= "bambiMad" then
            removeLuaSprite("iconWinningBambiAngy")
        else
            makeLuaSprite('iconWinningBambiAngy', 'icons/babom-winning', 0, 0)
            setObjectCamera('iconWinningBambiAngy', 'hud')
            setProperty('iconWinningBambiAngy.visible', false)
            addLuaSprite('iconWinningBambiAngy')
        
            setObjectOrder('iconWinningBambiAngy', getObjectOrder('iconP2'))
        end
    end
end