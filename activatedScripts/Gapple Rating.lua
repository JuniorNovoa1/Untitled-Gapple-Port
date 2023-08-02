local ratingFolder = 'ratings/';

function onCreatePost()
    addHaxeLibrary("FlxRandom", 'flixel.math')
    addHaxeLibrary("FlxMath", 'flixel.math')
    addHaxeLibrary("FlxObject", 'flixel')
    addHaxeLibrary("FlxBasic", 'flixel')
    addHaxeLibrary("Math", 'flixel')

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

        var rating = new FlxSprite(1000 - (daRating.score / 1.5), 350).loadGraphic(Paths.image(ratingFolder + pathFirst + daRating.image + pathSecond));
        rating.cameras = [game.camHUD];
        rating.acceleration.y = 550;
        rating.velocity.y -= FlxG.random.int(140, 175);
        rating.velocity.x -= FlxG.random.int(0, 10);
		rating.alpha = targetAlpha;
		game.add(rating);
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
        if (game.combo >= 10 || game.combo == 0)
		    game.add(comboSpr);
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
                numScore.x += 16 + (6 * daLoop);
            numScore.x += (44 * daLoop);
            numScore.acceleration.y = FlxG.random.int(200, 300);
            numScore.velocity.y -= FlxG.random.int(140, 160);
            numScore.velocity.x = FlxG.random.float(-5, 5);
            numScore.alpha = targetAlpha;
            if (game.combo >= 10 || game.combo == 0)
                game.add(numScore);
            FlxTween.tween(numScore, {alpha: 0}, 0.2 / game.playbackRate, {
                startDelay: Conductor.crochet * 0.002,
                onComplete: function(twn)
                {
                    numScore.destroy();
                }
            });
			daLoop++;
            numScore.scale.set(0.6, 0.6);
        }

        rating.scale.set(0.7, 0.7);
        comboSpr.scale.set(0.7, 0.7);
    ]])
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    runHaxeCode([[
        var membersIndex = ]]..membersIndex..[[;
        var note = game.notes.members[membersIndex];
        var texture = note.texture;

        var pathFirst = "";
        var pathSecond = "";
        if (texture == 'NOTE_assets_3D') {
            pathFirst = "3dUi/";
            pathSecond = "-3d";
        }

        var comboSpr = new FlxSprite(975 - (350 / 2), 350).loadGraphic(Paths.image(pathFirst + 'combo' + pathSecond));
        comboSpr.cameras = [game.camHUD];
        comboSpr.acceleration.y = 600;
        comboSpr.velocity.y -= 150;
        comboSpr.velocity.x += FlxG.random.int(1, 10);
		comboSpr.alpha = 0.6;
        if (game.combo >= 10 || game.combo == 0)
		    game.add(comboSpr);
        if (texture == 'NOTE_assets_3D') {
            comboSpr.x -= 20;
            comboSpr.y -= 5;
        }    

        FlxTween.tween(comboSpr, {alpha: 0}, 0.2 / game.playbackRate, {
			startDelay: Conductor.crochet * 0.001 / game.playbackRate,
            onComplete: function(twn)
            {
                comboSpr.destroy();
            }
		});

        var daLoop = 0;
        var seperatedScore = [0, 0, 0];

        for (i in seperatedScore) {
            var numScore = new FlxSprite(comboSpr.x + 280, comboSpr.y + 10).loadGraphic(Paths.image(pathFirst + 'num' + i + pathSecond));
            numScore.cameras = [game.camHUD];
            if (texture == 'NOTE_assets_3D')
                numScore.x += 25;
            numScore.x += (44 * daLoop);
            numScore.acceleration.y = FlxG.random.int(200, 300);
            numScore.velocity.y -= FlxG.random.int(140, 160);
            numScore.velocity.x = FlxG.random.float(-5, 5);
            numScore.alpha = 0.6;
            if (game.combo >= 10 || game.combo == 0)
                game.add(numScore);
            FlxTween.tween(numScore, {alpha: 0}, 0.2 / game.playbackRate, {
                startDelay: Conductor.crochet * 0.002,
                onComplete: function(twn)
                {
                    numScore.destroy();
                }
            });
			daLoop++;
            numScore.scale.set(0.6, 0.6);
        }

        comboSpr.scale.set(0.7, 0.7);
    ]])
end