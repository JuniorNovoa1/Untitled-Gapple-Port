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

    makeLuaText("ratingTxt", "Sick!\n1", 0, 0.0, 64)
    setTextFont("ratingTxt", "comic.ttf")
    screenCenter("ratingTxt", 'x')
    setProperty("ratingTxt.x", getProperty("ratingTxt.x") - 10)
    setTextSize("ratingTxt", 36)
    setTextBorder("ratingTxt", 2, "000000")
    addLuaText("ratingTxt")
    setProperty("ratingTxt.alpha", 0)

    setProperty('showComboNum', false)
    setProperty("showRating", false)
    setProperty('showCombo', false)
end

local alphaTimer = 0.0;
function onUpdate(elapsed)
    if alphaTimer > 0 then
        alphaTimer = alphaTimer - (elapsed * playbackRate);
        if alphaTimer <= 0 then
            alphaTimer = 0;
            doTweenAlpha("ratingTxt", "ratingTxt", 0, .5, "")
        end
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if isSustainNote then return; end

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
        var noteDiff = note.strumTime - Conductor.songPosition + ]]..ratingOffset..[[;
		var daRating = Conductor.judgeNote(note, noteDiff / game.playbackRate);
        var text = "Sick!";
        if (daRating.name == "good") text = "Good";
        if (daRating.name == "bad") text = "Bad";
        if (daRating.name == "shit") text = "Shit";
        game.getLuaObject("ratingTxt", true).text = text + "\n" + (game.combo - 1);
    ]])
    cancelTween("ratingTxt")
    setProperty("ratingTxt.alpha", 1)
    alphaTimer = alphaTimer + 0.125;
end