local jumpscare = false;

local oldVal = {false}
function onCreate()
    makeAnimatedLuaSprite("stat", "daSTAT", 0, 0)
    scaleObject("stat", 3.25, 2.5, true)
    addAnimationByPrefix("stat", "idle", "staticFLASH", 24, true)
    playAnim("stat", "idle", true)
    setObjectCamera("stat", 'hud')
    screenCenter("stat", 'xy')
    addLuaSprite("stat", false)
    setProperty("stat.visible", false)
    oldVal[1] = middleScroll;
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', true)
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', true)
    end
end

function onCreatePost()
    setProperty("dad.visible", false)
    for i = 0, 3 do
        setPropertyFromGroup("opponentStrums", i, 'visible', false)
    end
    for i = 0, getProperty("unspawnNotes.length") do
        if not getPropertyFromGroup("unspawnNotes", i, 'mustPress') then
            setPropertyFromGroup("unspawnNotes", i, 'visible', false)
        end
    end
    setProperty("health", 2)
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

function onGameOver()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
    end
end

function onEndSong()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
    end
end

function onDestroy()
    if stringStartsWith(version, '0.6') then
        setPropertyFromClass('ClientPrefs', 'middleScroll', oldVal[1])
    else
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', oldVal[1])
    end
end