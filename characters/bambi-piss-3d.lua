local healthtolower = 0.02;

function onCreate()
    setObjectOrder('dadGroup', 99)
end

local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'bambi-piss-3d' then
        setProperty("dad.y", getProperty("dad.y") - (math.sin(elapsedtime) * 0.6))
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if dadName == 'bambi-piss-3d' then
        setProperty('health', getProperty('health') -(healthtolower / 2.65))
        if getDataFromSave('settings', 'screenshake') == true then
            triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
        end
    end
end