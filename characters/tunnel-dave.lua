local originalPos = 0;
local posAmount = 125;
local speedAmount = 4.5;
local tweenType = 'sineInOut';

function onCreate()
    setObjectOrder('dadGroup', 4)
    originalPos = getProperty('dad.y')
    doTweenY('daveDown', 'dad', originalPos +posAmount, speedAmount / 2, tweenType)
end

function onTweenCompleted(tag)
    if tag == 'daveDown' and getProperty('dad.curCharacter') == 'tunnel-dave' then
        doTweenY('daveUp', 'dad', originalPos -posAmount * 2.35, speedAmount * 1.125, tweenType)
    end

    if tag == 'daveUp' and getProperty('dad.curCharacter') == 'tunnel-dave' then
        doTweenY('daveDown', 'dad', originalPos +posAmount, speedAmount, tweenType)
    end
end