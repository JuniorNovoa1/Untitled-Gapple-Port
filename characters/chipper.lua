local elapsedTime = 0.0;
function onUpdate(elapsed)
    elapsedTime = elapsedTime + elapsed;

    if dadName == 'chipper' then
        setProperty("dad.y", getProperty("dad.y") - (math.sin(elapsedTime) * 0.6))
    end
end