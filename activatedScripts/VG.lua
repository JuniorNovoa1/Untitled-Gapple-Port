local maximumAlpha = 0.4;
local doTween = false;
local doWait = true;
local time = 1;

function onCreate()
    makeLuaSprite('vg', 'vig_red', 0, 0)
    setProperty('vg.visible', false)
    setObjectCamera('vg', 'camhud')
    setProperty('vg.alpha', 0)
    screenCenter('vg')
    if not lowQuality then
        addLuaSprite('vg', false)
    end
end

function onCreatePost()
    if songName == 'Applecore' then
        maximumAlpha = 0.2;
    end
end

function onUpdate(elapsed)
    if getProperty('vg.alpha') == maximumAlpha and doTween then
        doTweenAlpha('doVG2', 'vg', 0, time)
        doTween = false;
        doWait = true;
    end

    if getProperty('vg.alpha') == 0 then
        if not doTween and doWait then
            doWait = false;
            runTimer('waitVG', 1)
        end

        if doTween and not doWait then
            doTweenAlpha('doVG', 'vg', maximumAlpha, time)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'waitVG' then
        doTween = true;
    end
end