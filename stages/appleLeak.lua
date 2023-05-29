local shadname = "glitchEffect";

function onCreate()   
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
    setShaderFloat('garryLeak', 'uWaveAmplitude', 0.1)
    setShaderFloat('garryLeak', 'uFrequency', 5)
    setShaderFloat('garryLeak', 'uSpeed', 2)

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

    makeAnimatedLuaSprite('jamboul', 'characters/appleLeak/jamboul', 150, 250)
    setProperty('jamboul.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addAnimationByPrefix('jamboul', 'left', 'jamboul left0', 24, false)
    addAnimationByPrefix('jamboul', 'down', 'jamboul down wip0', 24, false)
    addAnimationByPrefix('jamboul', 'up', 'jamboul up wip0', 24, false)
    addAnimationByPrefix('jamboul', 'right', 'jamboul right0', 24, false)
    addAnimationByPrefix('jamboul', 'insane', 'jamboul insane0', 24, false)
    playAnim('jamboul', 'left', true)
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
    setShaderFloat('ytStatic', 'uWaveAmplitude', 0.1)
	setShaderFloat('ytStatic', 'uFrequency', 5)
	setShaderFloat('ytStatic', 'uSpeed', 2)

    makeLuaSprite('ytBox', 'appleLeak/trolled/bg1', -175, 1075)
    setProperty('ytBox.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('ytBox.visible', false)
    addLuaSprite('ytBox', false)

    makeLuaSprite('funkipedia', 'appleLeak/funkipedia', -175, 1940)
    setProperty('funkipedia.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    setProperty('funkipedia.visible', false)
    addLuaSprite('funkipedia', false)
end

function onUpdatePost(elapsed)
	setShaderFloat('garryLeak', 'uTime', os.clock())
    setShaderFloat('ytStatic', 'uTime', os.clock())
end

local switchedAnim = false;

function onBeatHit()
    switchedAnim = false;

    if getProperty('jamboul.animation.curAnim.name') == 'left' and not switchedAnim then
        playAnim('jamboul', 'right', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'right' and not switchedAnim then
        playAnim('jamboul', 'up', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'up' and not switchedAnim then
        playAnim('jamboul', 'down', true)
        switchedAnim = true;
    end

    if getProperty('jamboul.animation.curAnim.name') == 'down' and not switchedAnim then
        playAnim('jamboul', 'left', true)
        switchedAnim = true;
    end

    if curBeat % 2 == 0 then
        playAnim('brob', 'idle');
        playAnim('monkey', 'idle');
        playAnim('ohyeah', 'idle');
        playAnim('wrath', 'idle');
		playAnim('norman', 'idle');
	end
end