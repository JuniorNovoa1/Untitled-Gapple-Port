local originalPos = 0;
local speedAmount = 4.5;

function onSongStart()
    originalPos = getProperty('dad.y')
    doTweenY('daveDown', 'dad', originalPos +125, speedAmount / 2)
end

function onUpdate()
    if not getProperty('dad.curCharacter') == 'tunnel-dave' then
        cancelTween('daveDown');
        cancelTween('daveUp');
    end
end

function onTweenCompleted(tag)
    if tag == 'daveDown' then
        doTweenY('daveUp', 'dad', originalPos -300, speedAmount + 1.25)
    end

    if tag == 'daveUp' then
        doTweenY('daveDown', 'dad', originalPos +125, speedAmount)
    end
end