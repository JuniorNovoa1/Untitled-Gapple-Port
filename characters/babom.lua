local random = 0;

function onUpdate()
    if getProperty('dad.animation.curAnim.name') == 'idle' then
        playAnim('dad', 'idle'..random, true)
    end
end

function opponentNoteHit()
    random = getRandomInt(0, 16)
end