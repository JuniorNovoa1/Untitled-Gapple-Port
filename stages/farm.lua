local stageName = 'bambiFarm';
local nightColor = '000000';--'FF878787';
local sunsetColor = 'D48ECD';
local spotLightScaler = 1.3;
local time = 70;
--to my future self its the --doTweenColor function that fucks up the colors

function onCreate()
    --sunsetColor = rgbToHex(255, 143, 178);
    --[[nightColor = getColorFromHex('FF878787');
    sunsetColor = rgbToHex(255, 143, 178);--]]
    --nightColor = getColorFromHex('FF878787');
    --sunsetColor = getColorFromHex('FF77FF');

    makeLuaSprite('SKY', 'backgrounds/shared/sky', -600, -200)
    setProperty('SKY.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setScrollFactor('SKY', 0.6, 0.6)
    updateHitbox('SKY')
    doTweenAlpha('fart', 'SKY', 0, time)
    addLuaSprite('SKY', false)

    makeLuaSprite('SUNSETBG', 'backgrounds/shared/sky_sunset', -600, -200)
    setProperty('SUNSETBG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setScrollFactor('SUNSETBG', 0.6, 0.6)
    setProperty('SUNSETBG.alpha', 0)
    updateHitbox('SUNSETBG')
    doTweenAlpha('sunSetting', 'SUNSETBG', 1, time)
    addLuaSprite('SUNSETBG', false)

    makeLuaSprite('NIGHTBG', 'backgrounds/shared/sky_night', -600, -200)
    setProperty('NIGHTBG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setScrollFactor('NIGHTBG', 0.6, 0.6)
    setProperty('NIGHTBG.alpha', 0)
    --doTweenAlpha('moonRising', 'NIGHTBG', 1, time)
    addLuaSprite('NIGHTBG', false)

    makeLuaSprite('flatgrass', 'backgrounds/farm/gm_flatgrass', 350, 75)
    setProperty('flatgrass.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setGraphicSize('flatgrass', getProperty('flatgrass.width') * 0.34)
    setScrollFactor('flatgrass', 0.65, 0.65)
    --doTweenColor('flatgrass', 'flatgrass', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('flatgrass', false)
    end

    makeLuaSprite('hills', 'backgrounds/farm/orangey hills', -173, 100)
    setProperty('hills.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setScrollFactor('hills', 0.65, 0.65)
    --doTweenColor('hills', 'hills', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('hills', false)
    end

    makeLuaSprite('farmHouse', 'backgrounds/farm/funfarmhouse', 350, 75)
    setProperty('farmHouse.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setGraphicSize('farmHouse', getProperty('farmHouse.width') * 0.9)
    setScrollFactor('farmHouse', 0.7, 0.7)
    --doTweenColor('farmHouse', 'farmHouse', sunsetColor, time)
    addLuaSprite('farmHouse', false)

    makeLuaSprite('grassLand', 'backgrounds/farm/grass lands', -600, 500)
    setProperty('grassLand.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --doTweenColor('grassLand', 'grassLand', sunsetColor, time)
    addLuaSprite('grassLand', false)
    
    makeLuaSprite('cornFence', 'backgrounds/farm/cornFence', -400, 200)
    setProperty('cornFence.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --doTweenColor('cornFence', 'cornFence', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('cornFence', false)
    end

    makeLuaSprite('cornFence2', 'backgrounds/farm/cornFence2', 1100, 200)
    setProperty('cornFence2.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --doTweenColor('cornFence2', 'cornFence2', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('cornFence2', false)
    end

    local daBag = 'backgrounds/farm/cornbag';
    local random = getRandomInt(0, 100);
    if random == 0 then
        daBag = 'backgrounds/farm/popeye';
    end
    print(random);
    makeLuaSprite('cornBag', daBag, 1200, 550)
    setProperty('cornBag.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --doTweenColor('cornBag', 'cornBag', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('cornBag', false)
    end

    makeLuaSprite('sign', 'backgrounds/farm/sign', 0, 350)
    setProperty('sign.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --doTweenColor('sign', 'sign', sunsetColor, time)
    if not lowQuality then
        addLuaSprite('sign', false)
    end
    
    makeLuaSprite('magentaBGScreen', '', 0, 0)
    makeGraphic('magentaBGScreen', '1280', '720', sunsetColor)
    setProperty('magentaBGScreen.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    scaleObject('magentaBGScreen', 5, 5)
    screenCenter('magentaBGScreen', 'x')
    screenCenter('magentaBGScreen', 'y')
    setProperty('magentaBGScreen.alpha', 0)
    updateHitbox('magentaBGScreen')
    addLuaSprite('magentaBGScreen', true)

    makeLuaSprite('blackBGScreen', '', 0, 0)
    makeGraphic('blackBGScreen', '1280', '720', nightColor)
    setProperty('blackBGScreen.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    scaleObject('blackBGScreen', 5, 5)
    screenCenter('blackBGScreen', 'x')
    screenCenter('blackBGScreen', 'y')
    setProperty('blackBGScreen.alpha', 0)
    updateHitbox('blackBGScreen')
    addLuaSprite('blackBGScreen', true)

    makeLuaSprite('blackScreen', '', 0, 0)
    makeGraphic('blackScreen', '1280', '720', '000000')
    setProperty('blackScreen.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setObjectCamera('blackScreen', 'camother')
    setProperty('blackScreen.alpha', 0)
    updateHitbox('blackScreen')
    addLuaSprite('blackScreen', true)

    makeLuaSprite('spotLight', 'spotLight', 0, 0)
    --setGraphicSize('spotLight', getProperty('spotLight.width') * (getProperty('spotLight.frameWidth') / getProperty('spotLight.width') * spotLightScaler))
    setProperty('spotLight.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    updateHitbox('spotLight')
    setProperty('spotLight.scale.x', 0.7)
    setProperty('spotLight.scale.y', 0.7)
    setProperty('spotLight.alpha', 0)
    addLuaSprite('spotLight', true)
    setBlendMode('spotLight', 'add')

    --[[
    doTweenColor('boyfriendColor', 'boyfriend', sunsetColor, time)
    doTweenColor('dadColor', 'dad', sunsetColor, time)
    doTweenColor('gfColor', 'gf', sunsetColor, time) --]]

    if isStoryMode then
        setProperty('health', getProperty('health') - 0.2)
    end
end

local amount = 0.35;
function onUpdate()
    setProperty('magentaBGScreen.alpha', getProperty('SUNSETBG.alpha') -0.65)
    setProperty('blackBGScreen.alpha', getProperty('NIGHTBG.alpha') -amount)

    if getProperty('spotLight.alpha') == 1 then
        amount = 0.25;
    else
        amount = 0.5;
    end
end

function onTweenCompleted(tag)
	if tag == 'sunSetting' then
        doTweenAlpha('sunSettingDown', 'SUNSETBG', 0, time)
        doTweenAlpha('moonRising', 'NIGHTBG', 1, time)
	end
end

--[[
function rgbToHex(r, g, b) --https://github.com/ShadowMario/FNF-PsychEngine/issues/9907
    --%02x: 0 means replace " "s with "0"s, 2 is width, x means hex
	return string.format("%02x%02x%02x", 
		math.floor(r),
		math.floor(g),
		math.floor(b))
end
--]]

function sectionStartTime(section)
	local daBPM = getProperty("SONG.bpm");
	local daPos = 0;
    for i = 0, section do
        daPos = daPos + 4 * (1000 * 60 / daBPM);
    end
	return daPos;
end