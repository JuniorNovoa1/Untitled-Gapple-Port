local bounceAnimState = 0;
local bounceMultiplier = 1;
local yBullshit = 1;

function onCreate()
    makeAnimatedLuaSprite('redTunnel', 'main/wireframe/redtunnelperspective', -775, -1000)
    addAnimationByPrefix('redTunnel', 'idle', 'redtunnelperspective idle0', 24, true)
    playAnim('redTunnel', 'idle', true)
    setProperty('redTunnel.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    --setGraphicSize('redTunnel', math.floor(getProperty('redTunnel.width') * 1.15), math.floor(getProperty('redTunnel.height') * 1.15));
    setProperty('redTunnel.scale.x', 4)--getProperty('redTunnel.width') * 1.15)
    setProperty('redTunnel.scale.y', 3.25)--getProperty('redTunnel.height') * 1.15)
    setScrollFactor('redTunnel', 1.1, 0.95)
    updateHitbox('redTunnel')
    addLuaSprite('redTunnel', false)

    makeAnimatedLuaSprite('daveFuckingDies', 'main/wireframe/pissBoy', 0, 1500)
    addAnimationByPrefix('daveFuckingDies', 'idle', 'IDLE', 24, false)
    addAnimationByPrefix('daveFuckingDies', 'bounceLeft', 'EDGE', 24, false)
    addAnimationByPrefix('daveFuckingDies', 'bounceRight', 'EDGE', 24, false, true)
    playAnim('daveFuckingDies', 'idle', true)
    setProperty('daveFuckingDies.antialiasing', false)
    setProperty('daveFuckingDies.visible', false)
    updateHitbox('daveFuckingDies')
    if not lowQuality then
        addLuaSprite('daveFuckingDies', false)
    end

    makeLuaSprite('lightColor', '', 0, 0)
    makeGraphic('lightColor', '1280', '720', 'FFFFFF')
    setProperty('lightColor.antialiasing', false)
    setProperty('lightColor.alpha', 0)
    updateHitbox('lightColor')
    screenCenter('lightColor', 'x')
    screenCenter('lightColor', 'y')
    setObjectCamera('lightColor', 'other')
    addLuaSprite('lightColor', false)
end

local tweenEase = 'sineInOut';
local timer = 15;

function onUpdate(elapsed)
    local yStuff = bounceMultiplier * yBullshit;

    --setProperty('daveFuckingDies.angle', elapsed * 20);
    --setProperty('daveFuckingDies.x', 1 * bounceMultiplier);
    --setProperty('daveFuckingDies.y', 1 * yStuff);

    if getProperty('daveFuckingDies.x') >= (getProperty('redTunnel.width') - 1000) or getProperty('daveFuckingDies.y') >= (getProperty('redTunnel.height') - 1000) then
        bounceAnimState = 1;
        bounceMultiplier = getRandomFloat(-0.75, -1.15);
        yBullshit = getRandomFloat(0.95, 1.05);
        danceDave();
        doTweenAngle('DAVESAN', 'daveFuckingDies', -30 * getRandomFloat(0.3, 3), timer * 0.85, tweenEase)
        doTweenX('DAVESA', 'daveFuckingDies', getProperty('redTunnel.x') + 100, timer, tweenEase)
        doTweenY('DAVESF', 'daveFuckingDies', getProperty('redTunnel.y') + 100, timer, tweenEase)
    end
    if getProperty('daveFuckingDies.x') <= (getProperty('redTunnel.x') + 100) or getProperty('daveFuckingDies.y') <= (getProperty('redTunnel.y') + 100) then
        bounceAnimState = 2;
        bounceMultiplier = getRandomFloat(0.75, 1.15);
        yBullshit = getRandomFloat(0.95, 1.05);
        danceDave();
        doTweenAngle('DAVESAN', 'daveFuckingDies', 30 * getRandomFloat(0.5, 1.5), timer * 0.85, tweenEase)
        doTweenX('DAVESA', 'daveFuckingDies', getProperty('redTunnel.width') - 1000, timer, tweenEase)
        doTweenY('DAVESF', 'daveFuckingDies', getProperty('redTunnel.height') - 1000, timer, tweenEase)
    end

    if getProperty('daveFuckingDies.x') >= (getProperty('redTunnel.width') - 1150) or getProperty('daveFuckingDies.y') >= (getProperty('redTunnel.height') - 1150) then
        bounceAnimState = 1;
        runTimer('daveIdle', 1.25)
    end
    if getProperty('daveFuckingDies.x') <= (getProperty('redTunnel.x') + 250) or getProperty('daveFuckingDies.y') <= (getProperty('redTunnel.y') + 250) then
        bounceAnimState = 2;
        runTimer('daveIdle', 1.25)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'daveIdle' then
        bounceAnimState = 0;
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
		playAnim('daveFuckingDies', 'idle');
	end
end

function danceDave()
    if bounceAnimState == 0 then
        playAnim('daveFuckingDies', 'idle', true);
    end
    if bounceAnimState == 1 then
        playAnim('daveFuckingDies', 'bounceLeft');
    end
    if bounceAnimState == 2 then
        playAnim('daveFuckingDies', 'bounceRight');
    end
end