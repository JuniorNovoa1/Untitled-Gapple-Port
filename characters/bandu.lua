local originalPos = 0;
local posAmount = 1000;
local speedAmount = 1.5;
local tweenType = 'sineInOut';

function onCreatePost()
    setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') -1)
    originalPos = getProperty('dad.x')
end

function onCountdownTick(tick)
    if tick == 69 then
        doTweenX('banduRight', 'dad', originalPos +posAmount, speedAmount / playbackRate, tweenType)
    end
end

function onTweenCompleted(tag)
    if tag == 'banduLeft' and (getProperty('dad.curCharacter') == 'bandu' or getProperty('dad.curCharacter') == 'bandu-sad') then
        doTweenX('banduRight', 'dad', originalPos +posAmount, speedAmount / playbackRate, tweenType)
        setObjectOrder('dadGroup', getObjectOrder('gfGroup') +1)
    end

    if tag == 'banduRight' and (getProperty('dad.curCharacter') == 'bandu' or getProperty('dad.curCharacter') == 'bandu-sad') then
        doTweenX('banduLeft', 'dad', originalPos +50, speedAmount / playbackRate, tweenType)
        setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') +1)
    end
end