local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if boyfriendName == 'tunnel-bf' then
        setProperty("boyfriend.y", getProperty("boyfriend.y") + (math.sin(elapsedtime) * 0.6))
    end
end