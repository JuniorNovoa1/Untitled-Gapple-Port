local elapsedtime = 0.0;
function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'bad' then
        callOnLuas("takeFromVal", {"dad.y", math.sin(elapsedtime) * 0.25})
    end
end