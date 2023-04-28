local camAngle = 4;
local camTimer = 0.2;
local curThing = false;
local tween = 'cubeOut';
local notesX = {};
local notesY = {};
local noteOrgasm = {-25, 25}
local timerOrgasim = 0.05;

function onCreatePost()
    addCharacterToList('awesomeBambiCrack', 'dad')
    if getGlobalFromScript('settings', 'modCharts') == true then
        doTweenAngle('camHUD1', 'camHUD', camAngle, camTimer, tween)
        doTweenAngle('camGame1', 'camGame', camAngle, camTimer, tween)
        for i = 1, getProperty('strumLineNotes.length') do
            notesX[i] = getPropertyFromGroup('strumLineNotes', i-1, 'x')
            notesY[i] = getPropertyFromGroup('strumLineNotes', i-1, 'y')
            noteTweenX('noteX'..i, i-1, notesX[i] + getRandomInt(noteOrgasm[1], noteOrgasm[2]), timerOrgasim, tween)
            noteTweenY('noteY'..i, i-1, notesY[i] + getRandomInt(noteOrgasm[1], noteOrgasm[2]), timerOrgasim, tween)
        end
    end
end

local shake = 0.0125;
function onUpdate()
    if getGlobalFromScript('settings', 'screenShake') == true then
        triggerEvent('Screen Shake', '0.1,'..shake, '0.1,'..shake / 1.35)
    end
end

function onStepHit()
    if curStep >= 720 and curStep <= 784 then
        for i = 1, getProperty('notes.length') do
            setPropertyFromGroup('notes', i-1, 'missHealth', 0.014) --was impossible before lol
        end
    end
end

--[[function onBeatHit()
    if curThing then
        setProperty('camHUD.angle', -camAngle)
        setProperty('camGame.angle', -camAngle)
    else
        setProperty('camHUD.angle', camAngle)
        setProperty('camGame.angle', camAngle)
    end
    curThing = not curThing;
end--]]

function onTweenCompleted(tag)
    if tag == 'camHUD1' then
        doTweenAngle('camHUD2', 'camHUD', -camAngle, camTimer, tween)
    end
    if tag == 'camHUD2' then
        doTweenAngle('camHUD1', 'camHUD', camAngle, camTimer, tween)
    end
    if tag == 'camGame1' then
        doTweenAngle('camGame2', 'camGame', -camAngle, camTimer, tween)
    end
    if tag == 'camGame2' then
        doTweenAngle('camGame1', 'camGame', camAngle, camTimer, tween)
    end

    for i = 1, getProperty('strumLineNotes.length') do
        if tag == 'noteX'..i then
            noteTweenX('noteX'..i, i-1, notesX[i] + getRandomInt(noteOrgasm[1], noteOrgasm[2]), timerOrgasim, tween)
        end
        if tag == 'noteY'..i then
            noteTweenY('noteY'..i, i-1, notesY[i] + getRandomInt(noteOrgasm[1], noteOrgasm[2]), timerOrgasim, tween)
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Alt Animation' and getProperty('dad.curCharacter') == 'awesomeBambi' then
        triggerEvent('Change Character', 'dad', 'awesomeBambiCrack')
    elseif noteType ~= 'Alt Animation' and getProperty('dad.curCharacter') == 'awesomeBambiCrack' then
        triggerEvent('Change Character', 'dad', 'awesomeBambi')
    end
end