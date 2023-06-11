function onCreate()
    setObjectOrder('dadGroup', 99)
end

local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'tunnel-dave' then
        setProperty("dad.y", getProperty("dad.y") - (math.sin(elapsedtime) * 0.6))
    end
end