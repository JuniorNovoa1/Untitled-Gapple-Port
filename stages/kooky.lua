local multiplier = 1.05;

function onCreate()
    makeLuaSprite('bg', 'yoMamaSoBrown/sdfsdfsdfv-min', 200, 290)
    setProperty('bg.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    scaleObject('bg', 1.5 * multiplier, 1.6 * multiplier)
    addLuaSprite('bg', false)

    makeLuaSprite('whiteArrows', '', 200, -120)
    makeGraphic('whiteArrows', '620', '360', 'FFFFFF')
    setProperty('whiteArrows.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addLuaSprite('whiteArrows', false)

    makeLuaSprite('healthBarBGG', '', 1100, 240)
    makeGraphic('healthBarBGG', '200', '620', 'FFFFFF')
    setProperty('healthBarBGG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addLuaSprite('healthBarBGG', false)

    makeLuaSprite('grid', 'yoMamaSoBrown/unknown', -175, -435)
    setProperty('grid.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    scaleObject('grid', 1.35 * multiplier, 1.35 * multiplier)
    addLuaSprite('grid', true)

    makeLuaSprite('blackSideBarLeft', '', 0, 0)
    makeGraphic('blackSideBarLeft', '160', '720', '000000')
    setProperty('blackSideBarLeft.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setObjectCamera('blackSideBarLeft', 'camhud')
    addLuaSprite('blackSideBarLeft', false)

    makeLuaSprite('blackSideBarRight', '', 1125, 0)
    makeGraphic('blackSideBarRight', '160', '720', '000000')
    setProperty('blackSideBarRight.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setObjectCamera('blackSideBarRight', 'camhud')
    addLuaSprite('blackSideBarRight', false)
end

function onCreatePost()
    runHaxeCode([[
        game.boyfriend.healthColorArray[0] = 255;
        game.boyfriend.healthColorArray[1] = 0;
        game.boyfriend.healthColorArray[2] = 0;
        game.reloadHealthBarColors();
    ]])
end