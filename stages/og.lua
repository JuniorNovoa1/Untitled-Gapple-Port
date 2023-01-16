function onCreate()
    makeLuaSprite('SKY', 'backgrounds/shared/sky', 0, 0)
    setProperty('SKY.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('SKY')
    updateHitbox('SKY')
    addLuaSprite('SKY', false)

    makeLuaSprite('bgClouds', 'ogStage/ogClouds', 0, -50)
    setProperty('bgClouds.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setScrollFactor('bgClouds', 1.2, 1.2)
    screenCenter('bgClouds', 'X')
    updateHitbox('bgClouds')
    if not lowQuality then
        addLuaSprite('bgClouds', false)
    end

    makeLuaSprite('bgWindow', 'ogStage/ogWindow', 0, 0)
    setProperty('bgWindow.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('bgWindow')
    updateHitbox('bgWindow')
    if not lowQuality then
        addLuaSprite('bgWindow', false)
    end

    makeLuaSprite('bgCeiling', 'ogStage/ogCeiling', 0, -865)
    setProperty('bgCeiling.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('bgCeiling', 'X')
    updateHitbox('bgCeiling')
    if not lowQuality then
        addLuaSprite('bgCeiling', false)
    end

    makeLuaSprite('bgGrass', 'ogStage/ogGrass', 0, 500)
    setProperty('bgGrass.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('bgGrass', 'X')
    updateHitbox('bgGrass')
    addLuaSprite('bgGrass', false)
end