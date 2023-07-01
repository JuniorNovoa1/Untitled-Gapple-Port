function onCreate()
    makeLuaSprite('swag', 'extras/pissing_too', 120, 250)
    --setGraphicSize(math.floor(getProperty("swag.width") * 0.521814815))
    scaleObject("swag", 0.5, 0.5)
    updateHitbox("swag")
    screenCenter('swag', 'x')
    addLuaSprite('swag', false)
end