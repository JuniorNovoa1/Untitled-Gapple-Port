local originPosX = {};
local originPosY = {};
function onCreatePost()
    for i = 0, getProperty('strumLineNotes.length') do
        originPosX[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        originPosY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end
end

local elapsedtime = 0;

function onUpdate(elapsed)
    if getDataFromSave("Juniors Ports Stuff", 'modcharts') == false then
        return;
    end

    elapsedtime = elapsedtime +elapsed;
    for i = 0, getProperty('strumLineNotes.length') do
        local krunkThing = 10;
        local idExtra = 2;
        setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + math.sin(elapsedtime - 5 * (getPropertyFromGroup('strumLineNotes', i, 'ID') + idExtra)) * (getPropertyFromGroup('strumLineNotes', i, 'ID') + idExtra) * krunkThing)
    end
end