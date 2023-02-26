local originalPosX = 0;
local originalPosY = 0;
local posAmount = 60;
local speedAmount = 4.5;
local tweenType = 'sineInOut';

function onCreate()
    setObjectOrder('dadGroup', 99)
    originalPosX = getProperty('dad.x')
    originalPosY = getProperty('dad.y')
end

function onTweenCompleted(tag)
    if tag == 'BadaiXRight' and getProperty('dad.curCharacter') == 'badai' then
        doTweenX('BadaiXLeft', 'dad', originalPosX -posAmount * 4, speedAmount * 1.125, tweenType)
    end

    if tag == 'BadaiXLeft' and getProperty('dad.curCharacter') == 'badai' then
        doTweenX('BadaiXRight', 'dad', originalPosX +posAmount * 4, speedAmount, tweenType)
    end

    if tag == 'BadaiYDown' and getProperty('dad.curCharacter') == 'badai' then
        doTweenY('BadaiYUp', 'dad', originalPosY -posAmount * 2.35, speedAmount * 1.125, tweenType)
    end

    if tag == 'BadaiYUp' and getProperty('dad.curCharacter') == 'badai' then
        doTweenY('BadaiYDown', 'dad', originalPosY +posAmount, speedAmount, tweenType)
    end

    if tag == 'BadaiAngleRight' and getProperty('dad.curCharacter') == 'badai' then
        doTweenAngle('BadaiAngleLeft', 'dad', -9, speedAmount * getRandomFloat(1, 1.35), tweenType)
    end

    if tag == 'BadaiAngleLeft' and getProperty('dad.curCharacter') == 'badai' then
        doTweenAngle('BadaiAngleRight', 'dad', 9, speedAmount * getRandomFloat(1, 1.35), tweenType)
    end
end

function onEvent(tag, val1, val2)
    if tag == 'Change Character' and val2 == 'badai' then
        setObjectOrder('dadGroup', 99)
        originalPosX = getProperty('badaiComes.x')
        originalPosY = getProperty('badaiComes.y') -250
        doTweenX('BadaiXRight', 'dad', originalPosX +posAmount * 4, speedAmount * 1.125, tweenType)
        doTweenY('BadaiYDown', 'dad', originalPosY +posAmount, speedAmount * 1.125, tweenType)
        doTweenAngle('BadaiAngleLeft', 'dad', -9, speedAmount * getRandomFloat(1, 1.35), tweenType)
    end
end