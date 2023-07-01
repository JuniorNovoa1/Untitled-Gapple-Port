function onCreate()
    makeLuaSprite('farm', 'joke/wheels/moldy_shit', 0, 0)
    setProperty('farm.scale.x', 6)
    setProperty('farm.scale.y', 6)
    updateHitbox('farm')
    screenCenter('farm')
    addLuaSprite('farm', false)

    makeLuaSprite('mineBG', 'extras/mine_bg', 0, 0)
    setProperty('mineBG.visible', false)
    updateHitbox('mineBG')
    screenCenter('mineBG')
    setProperty('mineBG.y', getProperty('mineBG.y') +250)
    setProperty('mineBG.x', getProperty('mineBG.x') +100)
    addLuaSprite('mineBG', false)
end

function onCreatePost()
    makeLuaSprite('bestgf', 'characters/joke/awesome/best_gf', getProperty('gf.x') * 1.25, getProperty('gf.y') * 1.5)
    setProperty('bestgf.scale.x', 2)
    setProperty('bestgf.scale.y', 2)
    addLuaSprite('bestgf', false)
    setProperty('gf.visible', false)

    setProperty('boyfriend.x', getProperty('boyfriend.x') -75)
    setProperty('dad.x', getProperty('dad.x') -75)
end