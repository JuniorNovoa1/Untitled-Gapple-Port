local idleDance = 0;

function onBeatHit()
    if curBeat % 4 == 0 then playAnim("dad", "idle"..idleDance) end

    if curBeat % 8 == 0 then
        idleDance = idleDance +1;
        if idleDance > 3 then idleDance = 0; end
    end
end