function onCreatePost()
    addHaxeLibrary("FlxTrail", 'flixel.addons.effects')
    addHaxeLibrary("FlxTrailArea", 'flixel.addons.effects')

    runHaxeCode([[
        var tickTrail = new FlxTrail(game.dad, null, 12, 6, 0.3, 0.15);
        game.add(tickTrail);
    ]])
end