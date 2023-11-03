local ratingFolder = 'ratings/';

function onCreatePost()
    addHaxeLibrary("FlxRandom", 'flixel.math')
    addHaxeLibrary("FlxObject", 'flixel')
    addHaxeLibrary("FlxBasic", 'flixel')
	addHaxeLibrary("Std")
	addHaxeLibrary("Math")
    addHaxeLibrary('FlxMath', 'flixel.math')

    --Source Code stuff
    if stringStartsWith(version, '0.6') then
        addHaxeLibrary("Rating", 'Conductor')
        addHaxeLibrary("Note")
    else
        addHaxeLibrary("Rating", 'backend.Conductor')
        addHaxeLibrary("Note", 'objects')
    end

    --caching ratings!!
    for i = 0, getProperty('ratingsData.length') do
        precacheImage(ratingFolder..getPropertyFromGroup("ratingsData", i, 'image'))
        precacheImage(ratingFolder..'3dUi/'..getPropertyFromGroup("ratingsData", i, 'image')..'-3d')
    end
    for i = 0, 9 do
        precacheImage(ratingFolder..'num'..i)
        precacheImage(ratingFolder..'3dUi/num'..i..'-3d')
    end

    setProperty('showComboNum', false)
    setProperty("showRating", false)
    setProperty('showCombo', false)
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if isSustainNote then
		return;
	end

    local ratingOffset = 0;
    if stringStartsWith(version, '0.7') then
	    ratingOffset = getPropertyFromClass("backend.ClientPrefs", "data.ratingOffset")
	else
        ratingOffset = getPropertyFromClass("ClientPrefs", "ratingOffset")
    end

    runHaxeCode([[
        game.modchartSprites.set('ratingLuaSpr', null);
        game.modchartSprites.set('comboLuaSpr', null);

        var membersIndex = ]]..membersIndex..[[;
        var note = game.notes.members[membersIndex];
        var ratingFolder = "]]..ratingFolder..[[";
        var targetAlpha = 0.5;

        var texture = note.texture;
        //importing shit from lua!!!

        var noteDiff = note.strumTime - Conductor.songPosition + ]]..ratingOffset..[[;
		var daRating = Conductor.judgeNote(note, noteDiff / game.playbackRate);

        var pathFirst = "";
        var pathSecond = "";
        if (texture == 'noteSkins/NOTE_assets_3D') {
            pathFirst = "3dUi/";
            pathSecond = "-3d";
        }

        var rating = new FlxSprite(1000 - (daRating.score / 1.5), 300).loadGraphic(Paths.image(ratingFolder + pathFirst + daRating.image + pathSecond));
        rating.cameras = [game.camHUD];
        rating.acceleration.y = 550;
        rating.velocity.y -= FlxG.random.int(140, 175);
        rating.velocity.x -= FlxG.random.int(0, 10);
		rating.alpha = targetAlpha;
        rating.setGraphicSize(Std.int(rating.width * 0.7), Std.int(rating.height * 0.7));
		game.insert(game.members.indexOf(game.strumLineNotes), rating);
        if (texture == 'noteSkins/NOTE_assets_3D') {
            rating.x -= 20;
            rating.y -= 5;
        }

        var comboSpr = new FlxSprite(rating.x + 15, rating.y - 85).loadGraphic(Paths.image(ratingFolder + pathFirst + 'combo' + pathSecond));
        comboSpr.cameras = [game.camHUD];
        comboSpr.acceleration.y = 600;
        comboSpr.velocity.y -= 150;
        comboSpr.velocity.x += FlxG.random.int(1, 10);
		comboSpr.alpha = targetAlpha;
        comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7), Std.int(comboSpr.height * 0.7));
        if (game.combo >= 10 || game.combo == 0) {
            game.insert(game.members.indexOf(game.strumLineNotes), comboSpr);
        }
        if (texture == 'noteSkins/NOTE_assets_3D') {
            comboSpr.x -= 20;
            comboSpr.y -= 5;
        }

        FlxTween.tween(rating, {alpha: 0}, 0.2 / game.playbackRate, {
			startDelay: Conductor.crochet * 0.001 / game.playbackRate,
            onComplete: function(twn)
            {
                rating.destroy();
            }
		});
        FlxTween.tween(comboSpr, {alpha: 0}, 0.2 / game.playbackRate, {
			startDelay: Conductor.crochet * 0.001 / game.playbackRate,
            onComplete: function(twn)
            {
                comboSpr.destroy();
            }
		});

        var daLoop = 0;
        var seperatedScore = [];

        if (game.combo >= 1000)
            seperatedScore.push(]]..math.floor(getProperty("combo") / 1000)..[[ % 10);
        seperatedScore.push(]]..math.floor(getProperty("combo") / 100)..[[ % 10);
        seperatedScore.push(]]..math.floor(getProperty("combo") / 10)..[[ % 10);
        seperatedScore.push(game.combo % 10);

        for (i in seperatedScore) {
            var numScore = new FlxSprite(rating.x + 315, rating.y + 10).loadGraphic(Paths.image(ratingFolder + pathFirst + 'num' + i + pathSecond));
            numScore.cameras = [game.camHUD];
            if (texture == 'noteSkins/NOTE_assets_3D')
                numScore.x += 12 + (6 * daLoop);
            numScore.x += (44 * daLoop);
            numScore.acceleration.y = FlxG.random.int(200, 300);
            numScore.velocity.y -= FlxG.random.int(140, 160);
            numScore.velocity.x = FlxG.random.float(-5, 5);
            numScore.alpha = targetAlpha;
            numScore.setGraphicSize(Std.int(numScore.width * 0.5), Std.int(numScore.height * 0.5));
            if (game.combo >= 10 || game.combo == 0) {
                game.insert(game.members.indexOf(game.strumLineNotes), numScore);
            }
            FlxTween.tween(numScore, {alpha: 0}, 0.2 / game.playbackRate, {
                startDelay: Conductor.crochet * 0.002,
                onComplete: function(twn)
                {
                    numScore.destroy();
                }
            });
			daLoop++;
        }
    ]])
    --[[for i = 0, 2 do
        setGraphicSize("numLuaSpr"..i, math.floor(getProperty("numLuaSpr"..i..".width") * 0.5), math.floor(getProperty("numLuaSpr"..i..".height") * 0.5))
    end--]]

    --[[setObjectOrder("ratingLuaSpr", 1)
    setObjectOrder("comboLuaSpr", 2)
    setObjectOrder("numLuaSpr1", 0)
    setObjectOrder("numLuaSpr2", 0)
    setObjectOrder("numLuaSpr3", 0)--]]
end