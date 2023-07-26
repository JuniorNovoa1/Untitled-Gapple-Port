function onCreatePost()
    addHaxeLibrary("FlxTrail", 'flixel.addons.effects')
    addHaxeLibrary("FlxTrailArea", 'flixel.addons.effects')

    runHaxeCode([[
        var tickTrail = new FlxTrail(game.dad, null, 12, 6, 0.3, 0.15);
        game.add(tickTrail);
    ]])
end

local elapsedtime = 0.0;

function onUpdate(elapsed)
    elapsedtime = elapsedtime +elapsed;

    if dadName == 'ticking' then
        setProperty("dad.x", getProperty("dad.x") - (math.sin(elapsedtime) * 0.35))
        setProperty("dad.y", getProperty("dad.y") + (math.cos(elapsedtime) * 0.35))
    end
end