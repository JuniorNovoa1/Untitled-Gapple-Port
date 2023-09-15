local originPosX = {};
local originPosY = {};
function onStrumsCreate()
    for i = 0, getProperty('strumLineNotes.length') do
        originPosX[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        originPosY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end
end

function onSongStart()
    setProperty('gfSpeed', 2)
end

local elapsedtime = 0;

function onUpdate(elapsed)
    if getDataFromSave("Juniors Ports Stuff", 'modcharts') == false then
        return;
    end

    elapsedtime = elapsedtime +elapsed;
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

--[[function goodNoteHit(id, direction, noteType, isSustainNote)
    triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getDataFromSave("Juniors Ports Stuff", 'screenshake') == true then
        triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045')
    end
end--]]