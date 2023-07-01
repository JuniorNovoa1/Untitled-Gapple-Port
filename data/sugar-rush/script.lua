function onCreatePost()
    makeLuaSprite('thunderBlack', '', getProperty("swag.x"), getProperty("swag.y"))
    makeGraphic('thunderBlack', getProperty("swag.width"), getProperty("swag.height"), '000000')
    setProperty('thunderBlack.alpha', 0)
    addLuaSprite('thunderBlack', true)
end

function onBeatHit()
    if curBeat == 172 then
        doTweenAlpha("thunderBlack", "thunderBlack", 0.35, crochet / 500, "")
    end

    if curBeat == 204 then
        doTweenAlpha("thunderBlack", "thunderBlack", 0, crochet / 500, "")
    end
end