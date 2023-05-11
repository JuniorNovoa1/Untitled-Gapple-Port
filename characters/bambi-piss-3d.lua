local healthtolower = 0.02;
local originalPos = 0;
local posAmount = 125;
local speedAmount = 3;
local tweenType = 'sineInOut';
local dad = 'dad'

function onCreatePost()
    changeNoteSkin(false, 'NOTE_assets_3D')
    setObjectOrder('dadGroup', 99)
    originalPos = getProperty('dad.y')
    if getProperty('gf.curCharacter') == 'bambi-piss-3d' then
        dad = 'gf';
    end
end

function onCountdownTick(tick)
    if tick == 69 then
        if dadName == 'bambi-piss-3d' then
            originalPos = getProperty('dad.y')
            doTweenY('bambiUp', dad, originalPos -posAmount, speedAmount, tweenType)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'bambiDown' and (getProperty('gf.curCharacter') == 'bambi-piss-3d' or getProperty('dad.curCharacter') == 'bambi-piss-3d') then
        doTweenY('bambiUp', dad, originalPos -posAmount, speedAmount, tweenType)
    end

    if tag == 'bambiUp' and (getProperty('gf.curCharacter') == 'bambi-piss-3d' or getProperty('dad.curCharacter') == 'bambi-piss-3d') then
        doTweenY('bambiDown', dad, originalPos, speedAmount, tweenType)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if dadName == 'bambi-piss-3d' then
	    setProperty('health', getProperty('health') -(healthtolower / 2.65))
        if getDataFromSave('settings', 'screenshake') == true then
            triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
        end
    end
end