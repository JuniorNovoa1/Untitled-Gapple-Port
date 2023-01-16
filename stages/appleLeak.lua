local shadname = "stridentCrisisWavy";

function onCreate()
    --[[makeLuaSprite('ytVids', 'appleLeak/trolled/bgthing', 400, 150) ---250
    setProperty('ytVids.scale.x', 0)
    setProperty('ytVids.scale.y', 0)
    updateHitbox('ytVids')
    addLuaSprite('ytVids', false)

    makeLuaSprite('ytStatic', 'appleLeak/trolled/bg2', 0, 0)
    addLuaSprite('ytStatic', true)

    makeLuaSprite('ytBox', 'appleLeak/trolled/bg1', 0, 0)
    addLuaSprite('ytBox', false)--]]

    makeLuaSprite('caveBG', 'appleLeak/cave/caveBG', -750, 100)
    setProperty('caveBG.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('caveBG.scale.x', 2.25)
    setProperty('caveBG.scale.y', 2.25)
    updateHitbox('caveBG')
    setProperty('caveBG.visible', false)
    addLuaSprite('caveBG', false)

    makeAnimatedLuaSprite('brob', 'appleLeak/cave/brob', getProperty('caveBG.x') +1925, getProperty('caveBG.y') + 575)
    addAnimationByPrefix('brob', 'idle', 'brob0', 24, false)
    objectPlayAnimation('brob', 'idle', true)
    setProperty('brob.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('brob.scale.x', 0.5)
    setProperty('brob.scale.y', 0.5)
    updateHitbox('brob')
    setProperty('brob.visible', false)
    if not lowQuality then
        addLuaSprite('brob', false)
    end

    makeAnimatedLuaSprite('monkey', 'appleLeak/cave/monkey', getProperty('caveBG.x') +1590, getProperty('caveBG.y') + 425)
    addAnimationByPrefix('monkey', 'idle', 'monkey0', 24, false)
    objectPlayAnimation('monkey', 'idle', true)
    setProperty('monkey.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('monkey.scale.x', 0.35)
    setProperty('monkey.scale.y', 0.35)
    updateHitbox('monkey')
    setProperty('monkey.visible', false)
    if not lowQuality then
        addLuaSprite('monkey', false)
    end

    makeAnimatedLuaSprite('ohyeah', 'appleLeak/cave/ohyeah', getProperty('caveBG.x') +950, getProperty('caveBG.y') + 500)
    addAnimationByPrefix('ohyeah', 'idle', 'ohyeah0', 24, false)
    objectPlayAnimation('ohyeah', 'idle', true)
    setProperty('ohyeah.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --setProperty('ohyeah.scale.x', 0.75)
    --setProperty('ohyeah.scale.y', 0.75)
    updateHitbox('ohyeah')
    setProperty('ohyeah.visible', false)
    if not lowQuality then
        addLuaSprite('ohyeah', false)
    end

    makeAnimatedLuaSprite('wrath', 'appleLeak/cave/wrath', getProperty('caveBG.x') +475, getProperty('caveBG.y') + 500)
    addAnimationByPrefix('wrath', 'idle', 'wrath0', 24, false)
    objectPlayAnimation('wrath', 'idle', true)
    setProperty('wrath.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('wrath.scale.x', 0.5)
    setProperty('wrath.scale.y', 0.5)
    updateHitbox('wrath')
    setProperty('wrath.visible', false)
    if not lowQuality then
        addLuaSprite('wrath', false)
    end

    makeLuaSprite('caveFloor', 'appleLeak/cave/caveGround', getProperty('caveBG.x') +300, getProperty('caveBG.y') + 350)
    setProperty('caveFloor.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('caveFloor.scale.x', 1.75)
    setProperty('caveFloor.scale.y', 1.75)
    updateHitbox('caveFloor')
    setProperty('caveFloor.visible', false)
    addLuaSprite('caveFloor', false)

    makeAnimatedLuaSprite('norman', 'appleLeak/cave/norman', getProperty('caveFloor.x') + 950, getProperty('caveFloor.y') + 110)
    addAnimationByPrefix('norman', 'idle', 'idle0', 24, false)
    objectPlayAnimation('norman', 'idle', true)
    setProperty('norman.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('norman.scale.x', 0.25)
    setProperty('norman.scale.y', 0.25)
    updateHitbox('norman')
    setProperty('norman.visible', false)
    if not lowQuality then
        addLuaSprite('norman', false)
    end

    makeLuaSprite('portal', 'appleLeak/cave/portal', 0, 0)
    setProperty('portal.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('portal.visible', false)
    setProperty('portal.scale.x', 0)
    setProperty('portal.scale.y', 0)
    updateHitbox('portal')
    if not lowQuality then
        addLuaSprite('portal', true)
    end
    
    makeLuaSprite('th1ft', 'appleLeak/th1ft_room', 0, 150)
    setProperty('th1ft.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('th1ft', 'X')
    updateHitbox('th1ft')
    addLuaSprite('th1ft', false)

    makeLuaSprite('r1', 'appleLeak/r1', 50, 125)
    setProperty('r1.antialiasing', false)
    setProperty('r1.scale.x', 0.75)
    setProperty('r1.scale.y', 0.8)
    updateHitbox('r1')
    addLuaSprite('r1', false)

    makeLuaSprite('r2', 'appleLeak/r2', 50, 200)
    setProperty('r2.antialiasing', false)
    setProperty('r2.visible', false)
    setProperty('r2.scale.x', 0.9)
    setProperty('r2.scale.y', 0.9)
    updateHitbox('r2')
    if not lowQuality then
        addLuaSprite('r2', true)
    end

    makeLuaSprite('garryLeak', 'appleLeak/gary_leak', 0, 150)
    setProperty('garryLeak.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('garryLeak', 'X')
    setProperty('garryLeak.x', getProperty('garryLeak.x') + 100)
    updateHitbox('garryLeak')
    addLuaSprite('garryLeak', false)
    initLuaShader(shadname)
	setSpriteShader('garryLeak', shadname)

    makeLuaSprite('gasStation', 'appleLeak/gas_station', 0, 0)
    setProperty('gasStation.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('gasStation')
    updateHitbox('gasStation')
    addLuaSprite('gasStation', false)

    makeLuaSprite('wavyApplecore', 'appleLeak/wavyApplecore', 0, 150)
    setProperty('wavyApplecore.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('wavyApplecore.visible', false)
    screenCenter('wavyApplecore', 'X')
    updateHitbox('wavyApplecore')
    addLuaSprite('wavyApplecore', false)

    makeAnimatedLuaSprite('fatBandu', 'characters/appleLeak/fat_bandu_25', 150, 250)
    setProperty('fatBandu.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addAnimationByPrefix('fatBandu', 'idle', 'idle0', 24, false)
    objectPlayAnimation('fatBandu', 'idle', true)
    setProperty('fatBandu.visible', false)
    if not lowQuality then
        addLuaSprite('fatBandu', false)
    end

    makeAnimatedLuaSprite('jamboul', 'characters/appleLeak/jamboul', 150, 250)
    setProperty('jamboul.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addAnimationByPrefix('jamboul', 'left', 'jamboul left0', 24, false)
    addAnimationByPrefix('jamboul', 'down', 'jamboul down wip0', 24, false)
    addAnimationByPrefix('jamboul', 'up', 'jamboul up wip0', 24, false)
    addAnimationByPrefix('jamboul', 'right', 'jamboul right0', 24, false)
    addAnimationByPrefix('jamboul', 'insane', 'jamboul insane0', 24, false)
    objectPlayAnimation('jamboul', 'left', true)
    if not lowQuality then
        addLuaSprite('jamboul', false)
    end

    makeLuaSprite('kineMaster', 'appleLeak/DICKmaster', 1150, 25)
    setProperty('kineMaster.antialiasing', false)
    setObjectCamera('kineMaster', 'camother')
    if not lowQuality then
        addLuaSprite('kineMaster', false)
    end

    makeLuaSprite('ytVids', 'appleLeak/trolled/bgthing', 175 * 2, 250 * 2) -- -175, -250
    setProperty('ytVids.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --setProperty('ytVids.visible', false)
    setProperty('ytVids.scale.x', 0)
    setProperty('ytVids.scale.y', 0)
    updateHitbox('ytVids')
    addLuaSprite('ytVids', true)

    makeLuaSprite('ytStatic', 'appleLeak/trolled/bg2', -175, 1075)
    setProperty('ytStatic.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('ytStatic.visible', false)
    --setProperty('ytStatic.scale.x', 1.25)
    --setProperty('ytStatic.scale.y', 1.25)
    if not lowQuality then
        addLuaSprite('ytStatic', false)
    end
    setSpriteShader('ytStatic', shadname)

    makeLuaSprite('ytBox', 'appleLeak/trolled/bg1', -175, 1075)
    setProperty('ytBox.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('ytBox.visible', false)
    addLuaSprite('ytBox', false)

    makeLuaSprite('funkipedia', 'appleLeak/funkipedia', -175, 1940)
    setProperty('funkipedia.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('funkipedia.visible', false)
    addLuaSprite('funkipedia', false)

    makeAnimatedLuaSprite('fire', 'appleLeak/dookie/FLAMESFLAMESBURNINGFLAMES', 75, -50)
    addAnimationByPrefix('fire', 'idle', 'FlamesBurn0', 24, true)
    objectPlayAnimation('fire', 'idle', true)
    setProperty('fire.antialiasing', false)
    setProperty('fire.visible', false)
    setProperty('fire.scale.x', 1.8)
    setProperty('fire.scale.y', 1.5)
    setProperty('fire.alpha', 0.75)
    updateHitbox('fire')
    --screenCenter('fire')
    if not lowQuality then
        addLuaSprite('fire', true) -- 250, -315
    end
    
    addLuaScript('activatedScripts/VG');
end

function onUpdate(elapsed)
	setShaderFloat('garryLeak', 'uWaveAmplitude', 0.1)
	setShaderFloat('garryLeak', 'uFrequency', 5)
	setShaderFloat('garryLeak', 'uSpeed', 10)

    setShaderFloat('ytStatic', 'uWaveAmplitude', 0.1)
	setShaderFloat('ytStatic', 'uFrequency', 5)
	setShaderFloat('ytStatic', 'uSpeed', 10)
end

function onUpdatePost(elapsed)
	setShaderFloat('garryLeak', 'uTime', os.clock())
    setShaderFloat('ytStatic', 'uTime', os.clock())
end

local switchedAnim = false;

function onBeatHit()
    switchedAnim = false;

    if getProperty('jamboul.animation.curAnim.name') == 'left' and not switchedAnim then
        objectPlayAnimation('jamboul', 'right', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'right' and not switchedAnim then
        objectPlayAnimation('jamboul', 'up', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'up' and not switchedAnim then
        objectPlayAnimation('jamboul', 'down', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'down' and not switchedAnim then
        objectPlayAnimation('jamboul', 'left', true)
        switchedAnim = true;
    end

    if curBeat % 2 == 0 then
        objectPlayAnimation('brob', 'idle');
        objectPlayAnimation('monkey', 'idle');
        objectPlayAnimation('ohyeah', 'idle');
        objectPlayAnimation('wrath', 'idle');
		objectPlayAnimation('norman', 'idle');
	end
end