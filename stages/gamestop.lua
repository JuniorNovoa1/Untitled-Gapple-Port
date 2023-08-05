function onCreate()
    makeLuaSprite('gasStationBG', 'extras/giftCard/giftcard', 0, 0)
    scaleObject("gasStationBG", 0.55, 0.55, true)
    screenCenter("gasStationBG", 'xy')
    addLuaSprite('gasStationBG', false)

    makeLuaSprite('gasStationBGpixel', 'extras/giftCard/UHH THUING', 0, 0)
    scaleObject("gasStationBGpixel", 6.25, 6.25, true)
    screenCenter("gasStationBGpixel", 'xy')
    setProperty("gasStationBGpixel.visible", false)
    addLuaSprite('gasStationBGpixel', false)
end