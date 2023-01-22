local originalPos = 0;
local speedAmount = 4.5;
local tweenType = 'sineInOut';

function onSongStart()
    originalPos = getProperty('dad.y')
    doTweenY('daveDown', 'dad', originalPos +125, speedAmount / 2, tweenType)
end

function onTweenCompleted(tag)
    if tag == 'daveDown' and getProperty('dad.curCharacter') == 'tunnel-dave' then
        doTweenY('daveUp', 'dad', originalPos -300, speedAmount + 1.25, tweenType)
    end

    if tag == 'daveUp' and getProperty('dad.curCharacter') == 'tunnel-dave' then
        doTweenY('daveDown', 'dad', originalPos +125, speedAmount, tweenType)
    end
end