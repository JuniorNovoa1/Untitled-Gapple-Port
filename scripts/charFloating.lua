local bfNameLowerCase = "";
local dadNameLowerCase = "";

function onCreatePost()
    bfNameLowerCase = string.lower(boyfriendName)
    dadNameLowerCase = string.lower(dadName)

    if dadNameLowerCase == 'bambi-piss-3d' or dadNameLowerCase == 'tunnel-dave' then
        setObjectOrder("dadGroup", getObjectOrder("boyfriendGroup") + 1)
    end
end

local elapsedtime = 0.0;
local elapsedtimeBF = 0.0;
local elapsedtimeDAD = 0.0;
function onUpdate(elapsed)
    elapsedtime = elapsedtime + elapsed;
    elapsedtimeBF = elapsedtimeBF + elapsed;
    elapsedtimeDAD = elapsedtimeDAD + elapsed;
    bfNameLowerCase = string.lower(boyfriendName)
    dadNameLowerCase = string.lower(dadName)

    --char floating
    if bfNameLowerCase == 'tunnel-bf' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") + (math.sin(elapsedtimeBF) * 0.6))
    end
    if bfNameLowerCase == 'bad' then
        callOnLuas("takeFromVal", {"boyfriend.y", math.sin(elapsedtimeBF) * 0.325})
    end
    if bfNameLowerCase == '3d-tristan' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") - math.sin(elapsedtimeBF) * 0.9)
    end
    if bfNameLowerCase == 'bambi-piss-3d' or bfNameLowerCase == 'tunnel-dave' or bfNameLowerCase == 'bandu-card' or bfNameLowerCase == 'chipper' or bfNameLowerCase == 'awesomebambicrack' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") - (math.sin(elapsedtimeBF) * 0.6))
    end
    if bfNameLowerCase == 'brob' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") + (math.sin(elapsedtimeBF) * 0.9))
    end
    if bfNameLowerCase == 'dave-wide' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") - math.sin(elapsedtimeBF) * 0.6)
    end
    if bfNameLowerCase == 'split-dave-3d' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") - math.sin(elapsedtimeBF) * 0.6)
    end
    if bfNameLowerCase == 'ticking' then
        setProperty("boyfriend.x", getProperty("boyfriend.x") - (math.sin(elapsedtimeBF) * 0.35))
        setProperty("boyfriend.y", getProperty("boyfriend.y") + (math.cos(elapsedtimeBF) * 0.35))
    end
    if bfNameLowerCase == 'badai' then
        setProperty("boyfriend.angle", math.sin(elapsedtimeBF) * 15)
        setProperty("boyfriend.x", getProperty("boyfriend.x") + math.sin(elapsedtimeBF) * 0.6)
        setProperty("boyfriend.y", getProperty("boyfriend.y") + (math.sin(elapsedtimeBF) * 0.6))
    end
    if bfNameLowerCase == 'unfair-junker' then
        setProperty("boyfriend.x", 200 + math.sin(elapsedtimeBF) * 425)
        setProperty("boyfriend.y", getProperty("boyfriend.y") + math.sin(elapsedtimeBF) * 0.75)
    end

    --char floating
    if dadNameLowerCase == 'tunnel-bf' then
        setProperty("dad.y", getProperty("dad.y") + (math.sin(elapsedtimeDAD) * 0.6))
    end
    if dadNameLowerCase == 'dambai' then
        callOnLuas("takeFromVal", {"dad.x", math.sin(elapsedtimeDAD * 0.2)})
        setProperty("dad.y", (math.cos(elapsedtimeDAD) * 50) + 100)
    end
    if dadNameLowerCase == 'bad' then
        callOnLuas("takeFromVal", {"dad.y", math.sin(elapsedtimeDAD) * 0.325})
    end
    if dadNameLowerCase == '3d-tristan' then
        setProperty("dad.y", getProperty("dad.y") - math.sin(elapsedtimeDAD) * 0.9)
    end
    if dadNameLowerCase == 'bambi-piss-3d' or dadNameLowerCase == 'tunnel-dave' or dadNameLowerCase == 'bandu-card' or dadNameLowerCase == 'chipper' or dadNameLowerCase == 'awesomebambicrack' then
        setProperty("dad.y", getProperty("dad.y") - (math.sin(elapsedtimeDAD) * 0.6))
    end
    if dadNameLowerCase == 'brob' then
        setProperty("dad.y", getProperty("dad.y") + (math.sin(elapsedtimeDAD) * 0.9))
    end
    if dadNameLowerCase == 'dave-wide' then
        setProperty("dad.y", getProperty("dad.y") - math.sin(elapsedtimeDAD) * 0.6)
    end
    if dadNameLowerCase == 'split-dave-3d' then
        setProperty("dad.y", getProperty("dad.y") - math.sin(elapsedtimeDAD) * 0.6)
    end
    if dadNameLowerCase == 'ticking' then
        setProperty("dad.x", getProperty("dad.x") - (math.sin(elapsedtimeDAD) * 0.35))
        setProperty("dad.y", getProperty("dad.y") + (math.cos(elapsedtimeDAD) * 0.35))
    end
    if dadNameLowerCase == 'badai' then
        setProperty("dad.angle", math.sin(elapsedtimeDAD) * 15)
        setProperty("dad.x", getProperty("dad.x") + math.sin(elapsedtimeDAD) * 0.6)
        setProperty("dad.y", getProperty("dad.y") + (math.sin(elapsedtimeDAD) * 0.6))
    end
    if dadNameLowerCase == 'unfair-junker' then
        setProperty("dad.x", 200 + math.sin(elapsedtimeDAD) * 425)
        setProperty("dad.y", getProperty("dad.y") + math.sin(elapsedtimeDAD) * 0.75)
    end
end

function onEvent(eventName, value1, value2, strumTime)
    if eventName == 'Change Character' then
        if value1 == 'bf' then
            elapsedtimeBF = 0;
        end
        if value1 == 'dad' then
            elapsedtimeDAD = 0;
        end
    end
end