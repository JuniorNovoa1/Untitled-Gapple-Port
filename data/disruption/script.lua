local originPosX = {};
local originPosY = {};
function onCreatePost()
    for i = 0, getProperty('strumLineNotes.length') do
        originPosX[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        originPosY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end
    end
end

function onSongStart()
    setProperty('gfSpeed', 2)
end

local elapsedtime = 0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;
    if getGlobalFromScript('settings', 'modCharts') == true then
        for i = 0, getProperty('strumLineNotes.length') do
            local krunkThing = 60;
            if getPropertyFromGroup('strumLineNotes', i, 'ID') % 2 == 0 then
                setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsedtime) * (1) * krunkThing)))
                setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsedtime - 5) * (1) * krunkThing))
                setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsedtime - 5) * (1) / 4))
                setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsedtime) * (1)) / 2))
            else
                setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsedtime) * (-1) * krunkThing)))
                setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsedtime - 5) * (-1) * krunkThing))
                setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsedtime - 5) * (-1) / 4))
                setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsedtime) * (-1)) / 2))
            end
    
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') + 0.2)
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') + 0.2)
    
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') * 1.5)
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') * 1.5)
        end
    end
end

--[[function goodNoteHit(id, direction, noteType, isSustainNote)
    triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
end--]]

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getGlobalFromScript('settings', 'screenShake') == true then
        triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
    end
end