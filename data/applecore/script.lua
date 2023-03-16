function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end

        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
            setPropertyFromGroup('unspawnNotes', i, 'alpha', 0.45) --just gotta get another strum then this will be gone
        end
    end
end

function onStepHit()
    if curStep == 767 then
        setProperty('hi.visible', false)
        setProperty('poop.visible', true)
        setProperty('defaultCamZoom', 0.55)
        cameraFlash('other', 'FFFFFF', 1)
    end

    if curStep == 800 then
       doTweenY('gf', 'gf', 350, 1.35, 'sineIn')
    end
end

function onTweenCompleted(tag)
    if tag == 'gf' then
        doTweenY('bambiUp', 'gf', getProperty('dad.y') -125, 3, 'sineInOut')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getPropertyFromGroup('notes', id, 'noteType') == 'GF Sing' then
	    setProperty('health', getProperty('health') -(healthtolower / 2.65))
    end
end