local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'unfair-junker' then
        setProperty("dad.x", 200 + math.sin(elapsedtime) * 425)
        setProperty("dad.y", getProperty("dad.y") + math.sin(elapsedtime) * 0.75)
    end
end