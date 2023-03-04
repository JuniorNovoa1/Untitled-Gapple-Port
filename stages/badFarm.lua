function onCreate()
    makeLuaSprite('farm', 'joke/wheels/moldy_shit', 0, 0)
    setProperty('farm.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('farm.scale.x', 6)
    setProperty('farm.scale.y', 6)
    updateHitbox('farm')
    screenCenter('farm')
    addLuaSprite('farm', false)
end

function onCreatePost()
    makeLuaSprite('bestgf', 'characters/joke/awesome/best_gf', getProperty('gf.x') * 1.535, getProperty('gf.y') * 3)
    setProperty('bestgf.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('bestgf.scale.x', 2.35)
    setProperty('bestgf.scale.y', 2.35)
    addLuaSprite('bestgf', false)
    setProperty('gf.visible', false)
end