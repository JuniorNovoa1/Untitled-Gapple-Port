local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'badai' then
        setProperty("dad.angle", math.sin(elapsedtime) * 15)
        setProperty("dad.x", getProperty("dad.x") + (math.sin(elapsedtime) * 0.6))
        setProperty("dad.y", getProperty("dad.y") + (math.sin(elapsedtime) * 0.6))
    end
end