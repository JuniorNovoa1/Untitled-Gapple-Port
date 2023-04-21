local originalPosX = 0;
local originalPosY = 0;
local posAmount = 253;
local speedAmount = 4.75;
local tweenType = 'sineInOut';

function onCreate()
    originalPosX = getProperty('dad.x')
    originalPosY = getProperty('dad.y') -100;
    if getProperty('dad.curCharacter') == 'unfair-junker' then
        doTweenX('expungedLeft', 'dad', originalPosX -(posAmount), speedAmount * 1.125, tweenType)
        doTweenY('expungedUP', 'dad', originalPosY -posAmount * 1.45, speedAmount / 2, tweenType)
    end
end

function onTweenCompleted(tag)
    if tag == 'expungedRight' and getProperty('dad.curCharacter') == 'unfair-junker' then
        doTweenX('expungedLeft', 'dad', originalPosX -posAmount * 1.45, speedAmount * 1.125, tweenType)
    end

    if tag == 'expungedLeft' and getProperty('dad.curCharacter') == 'unfair-junker' then
        doTweenX('expungedRight', 'dad', originalPosX +posAmount, speedAmount, tweenType)
    end

    if tag == 'expungedDOWN' and getProperty('dad.curCharacter') == 'unfair-junker' then
        doTweenY('expungedUP', 'dad', originalPosY -posAmount * 2.35, speedAmount * 1.125, tweenType)
    end

    if tag == 'expungedUP' and getProperty('dad.curCharacter') == 'unfair-junker' then
        doTweenY('expungedDOWN', 'dad', originalPosY, speedAmount, tweenType)
    end
end

local healthtolower = 0.02;

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == 'unfair-junker' then
	    setProperty('health', getProperty('health') -(healthtolower / 12))
    end
end