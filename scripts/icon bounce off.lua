local enabled = false;

function onCreatePost()
    if not enabled then return; end

    if stringStartsWith(version, '0.6') then
        addHaxeLibrary('Character')
        addHaxeLibrary('HealthIcon')
    else
        addHaxeLibrary('Character', 'objects')
        addHaxeLibrary('HealthIcon', 'objects')
    end
    createIcon()
end

function onEvent(eventName, value1, value2)
    --if eventName == 'Change Character' and string.lower(value1) == 'dad' then iconSwitch(crochet / 350 * getProperty('gfSpeed'), 'sineInOut') end
end

function onUpdatePost(elapsed)
    if not enabled then return; end
    setProperty("oldIconP2.animation.curAnim.curFrame", getProperty("iconP2.animation.curAnim.curFrame"))
    setProperty("newIconP2.animation.curAnim.curFrame", getProperty("iconP2.animation.curAnim.curFrame"))

    checkFutureIcon()
end

--THANK GOD THE INTERNET EXISTS
function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local pushedStrumTimes = {}

function checkFutureIcon()
    local conDickTor = getPropertyFromClass("Conductor", "songPosition")
    local leStrumTime = getProperty("eventNotes[0].strumTime") -(crochet * 2.6); --2.75

    if conDickTor < leStrumTime or has_value(pushedStrumTimes, leStrumTime) then
        return;
    end

    for i = 0, #pushedStrumTimes do
        if pushedStrumTimes[i + 1] == nil then
            pushedStrumTimes[i + 1] = leStrumTime;
        end
    end

    runHaxeCode([[
        var dadIconGetter = new Character(0, 0, game.eventNotes[0].value2);
        game.modchartSprites.set('dadIconGetter', dadIconGetter);
    ]])

    changeIconP2(getProperty("dadIconGetter.healthIcon"))
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'cooldown' then cooldown = false; end
end

function createIcon()
    runHaxeCode([[
        var oldIconP2 = new HealthIcon(game.dad.healthIcon, false);
        oldIconP2.alpha = 0;
        game.add(oldIconP2);
        game.modchartSprites.set('oldIconP2', oldIconP2);
    ]])
    setObjectCamera("oldIconP2", "hud")
    setObjectOrder("oldIconP2", getObjectOrder("iconP2") + 1)
end

function changeIconP2(newChar)
    runHaxeCode([[
        var newChar = "]]..newChar..[[";
        var newIconP2 = new HealthIcon(newChar, false);
        newIconP2.x -= 200;
        game.add(newIconP2);
        game.modchartSprites.set('newIconP2', newIconP2);
    ]])
    setObjectCamera("newIconP2", "hud")
    setObjectOrder("newIconP2", getObjectOrder("iconP2") + 2)
    iconSwitch(crochet / 450 * getProperty('gfSpeed'), 'sineInOut')
end

local timerTime = 0.0;
local ease = "";

function iconSwitch(timerc, eased)
    timerTime = timerc;
    ease = eased;
    cancelTween("newIconP2x")
    setProperty("newIconP2.y", getProperty("iconP2.y"))
    doTweenX("newIconP2x", "newIconP2", getProperty("iconP2.x"), timerTime, ease)
end

function onTweenCompleted(tag)
    if tag == 'newIconP2x' then
        cameraFlash("hud", "FFFFFF", 1.25, nil)
        setProperty("newIconP2.x", -200)
        cancelTween("oldIconP2")
        cancelTween("oldIconP2x")
        cancelTween("oldIconP2y")
        for i, arrayItem in pairs{'alpha', 'visible', 'x', 'y'} do
            setProperty("oldIconP2."..arrayItem, getProperty("iconP2."..arrayItem))
        end

        doTweenX("oldIconP2x", "oldIconP2", getProperty("oldIconP2.x") - 235, timerTime * 1.65, ease)
        doTweenY("oldIconP2y", "oldIconP2", getProperty("oldIconP2.y") - 175, timerTime, ease)
    end

    if tag == 'oldIconP2y' then
        doTweenY("oldIconP2y2", "oldIconP2", 1000, timerTime * 0.9, ease)
    end

    if tag == 'oldIconP2y2' then
        createIcon()
    end
end