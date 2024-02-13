function onBeatHit()
    if curBeat == 172 then
        doTweenAlpha("thunderBlack", "thunderBlack", 0.35, (crochet / 500) / playbackRate, "")
    end

    if curBeat == 204 then
        doTweenAlpha("thunderBlack", "thunderBlack", 0, (crochet / 500) / playbackRate, "")
    end
end