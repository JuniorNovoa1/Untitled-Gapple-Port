local shadname = "stridentCrisisWavy";

function onCreate()    
    makeLuaSprite('gasStation', 'appleLeak/gas_station', 0, 0)
    setProperty('gasStation.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('gasStation')
    updateHitbox('gasStation')
    addLuaSprite('gasStation', false)

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