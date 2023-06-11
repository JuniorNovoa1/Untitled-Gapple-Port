function onCreate()
    makeLuaSprite('mineBG', 'extras/mine_bg', 0, 0)
    updateHitbox('mineBG')
    screenCenter('mineBG')
    setProperty('mineBG.y', getProperty('mineBG.y') +250)
    setProperty('mineBG.x', getProperty('mineBG.x') +100)
    addLuaSprite('mineBG', false)
end