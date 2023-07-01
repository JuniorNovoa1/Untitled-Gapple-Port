local daX = -275;
local daY = -350;

function onCreate()
    precacheImage('characters/police2')

    makeLuaSprite('bg', 'boners/lore/lore_normal_bg_windowcolor', daX, daY)
    updateHitbox('bg')
    addLuaSprite('bg', false)
    
    --make a hidden phone guy sprite here to be shown in 'show gf.lua' and to be hidden in 'Break Window.lua'
    makeAnimatedLuaSprite('phoneGuy', 'characters/police2', 0, 0)
    addAnimationByPrefix('phoneGuy', 'running', 'approach', 35, true)
    playAnim('phoneGuy', 'running', true)
    setProperty('phoneGuy.visible', false)
    scaleObject('phoneGuy', 0.5, 0.5)
    updateHitbox('phoneGuy')
    addLuaSprite('phoneGuy', false)

    makeLuaSprite('bgWindow', 'boners/lore/lore_normal_bg_window', daX, daY)
    updateHitbox('bgWindow')
    addLuaSprite('bgWindow', false)

    makeLuaSprite('bgWindowBroken', 'boners/lore/lore_broken_bg', daX, daY)
    setProperty('bgWindowBroken.visible', false)
    updateHitbox('bgWindowBroken')
    addLuaSprite('bgWindowBroken', false)
end