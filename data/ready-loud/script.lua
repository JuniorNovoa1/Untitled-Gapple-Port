local jumpscare = false;

function onCreate()
    makeAnimatedLuaSprite("stat", "daSTAT", 0, 0)
    scaleObject("stat", 3.25, 2.5, true)
    addAnimationByPrefix("stat", "idle", "staticFLASH", 24, true)
    playAnim("stat", "idle", true)
    setObjectCamera("stat", 'hud')
    screenCenter("stat", 'xy')
    addLuaSprite("stat", false)
    setProperty("stat.visible", false)
end

function onStepHit()
    if curStep == 1632 then --1635
        setProperty("owl.visible", true)
        playAnim("owl", "idle", true)
    end

    if curStep == 1641 then --static
        setProperty("stat.visible", true)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if getProperty("flumpy.animation.curAnim.name") ~= 'idle' then
        setProperty("boyfriend.skipDance", false)
        playAnim("flumpy", "idle", true)
        jumpscare = false;
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if jumpscare == false then
        playAnim("flumpy", "jumpscare", true)
        playAnim("boyfriend", "scream")
        setProperty("boyfriend.skipDance", true)
        jumpscare = true;
    end
end