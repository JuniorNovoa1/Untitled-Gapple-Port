--how tf am i gonna do this mod chart??? lua doesn't even support "?", ughhhhhhhhh

function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end
    end

    addHaxeLibrary('FlxMath', 'flixel.math')

    runHaxeCode([[
        var arrowJunks = {0, 0, 0, 0, 0, 0, 0, 0};
        var arrowJunks2 = {0, 0, 0, 0, 0, 0, 0, 0};

        game.playerStrums.forEach(function(spr)
        {
            arrowJunks.push(spr.x);
            arrowJunks2.push(spr.y);
            setVar('arrowJunks', 'arrowJunks')
            setVar('arrowJunks2', 'arrowJunks2')
        });
    ]])
end

function onUpdate(elapsedtime)
    runHaxeCode([[
        var krunkThing = 60;

        game.playerStrums.forEach(function(spr)
        {
            spr.x = arrowJunks[spr.ID] + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * krunkThing;
            spr.y = arrowJunks2[spr.ID] + Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1) * krunkThing;

            spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1)) / 4;
            spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) / 2);

            spr.scale.x += 0.2;
            spr.scale.y += 0.2;

            spr.scale.x *= 1.5;
            spr.scale.y *= 1.5;
        });
    ]])
end