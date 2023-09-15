local healthtolower = 0.02;

function onCreate()
    setObjectOrder('dadGroup', 99)
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if dadName == 'bambi-piss-3d' then
        setProperty('health', getProperty('health') -(healthtolower / 2.65))
        if getDataFromSave("Juniors Ports Stuff", 'screenshake') == true then
            triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
        end
    end
end