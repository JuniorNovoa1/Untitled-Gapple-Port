function onCreate()
    makeAnimatedLuaSprite('schoolEntrance', 'main/marcloo/woah nice bg dude', 0, 0)
    addAnimationByPrefix("schoolEntrance", "static", "TRANS PEOPLE", 0, false)
    addAnimationByPrefix("schoolEntrance", "animEnter", "TRANS PEOPLE", 24, false)
    playAnim("schoolEntrance", "static")
    scaleObject("schoolEntrance", 1.2, 1.2)
    screenCenter("schoolEntrance")
    addLuaSprite('schoolEntrance', false)
end