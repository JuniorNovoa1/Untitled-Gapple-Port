local shadname = "glitchEffect";

local items = {'hi', 'poop', 'yeah'}
local items2 = {'pizza'}
local items3 = {'minion'}
local anims = {'walking', 'woah', 'spin'};

local tweenType = '';
local timeTimer = {4.01, 6.3};
local heightStuff = {-500, 2500}
local time = 4;

local poip = true;

function onCreate()
    initLuaShader(shadname)

    if string.lower(songName) == 'applecore' then
        --credit Drawoon_ later
        addHaxeLibrary('Song')
        addHaxeLibrary('SwagSong','Song')
        addHaxeLibrary('Section')
        addHaxeLibrary('SwagSection', 'Section')
        addHaxeLibrary('Note')
        addHaxeLibrary('Std')
        addHaxeLibrary('Math')
        addHaxeLibrary('FlxMath','flixel.math')
        runHaxeCode([[
            var SecondSong:SwagSong;
            //SecondSong = Song.loadFromJson("bopeebo-hard", "bopeebo");
            SecondSong = Song.loadFromJson("alt-notes", "applecore");
            var Notedata:Array<SwagSection>=SecondSong.notes;
            for (Section in Notedata)
            {
                for (songNotes in Section.sectionNotes)
                {
                  var Strum:Float =songNotes[0];
                  var NoteData:Int = Std.int(songNotes[1] % 4);
                  var LastNote:Note;
                  if (game.unspawnNotes.length > 0) LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                  else LastNote = null;
                  var NewNote:Note = new Note(Strum, NoteData, LastNote);
                  NewNote.mustPress = false;
                  NewNote.sustainLength = songNotes[2];
                  NewNote.gfNote = false;
                  NewNote.noteType = 'GF Sing';
                  NewNote.scrollFactor.set();
                  var Length:Float = NewNote.sustainLength;
                  Length=Length / Conductor.stepCrochet;
                  game.unspawnNotes.push(NewNote);
                  var floor:Int = Math.floor(Length);
                    if(floor > 0) {
                        for (susNote in 0...floor+1)
                        {
                            LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                            var NewSustan:Note = new Note(Strum + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(]]..getProperty('songSpeed')..[[, 2)), NoteData, LastNote, true);
                            NewSustan.mustPress = false;
                            NewSustan.gfNote = false;
                            NewSustan.noteType = NewNote.noteType;
                            NewSustan.noteType = 'GF Sing';
                            NewSustan.scrollFactor.set();
                            NewNote.tail.push(NewSustan);
                            NewSustan.parent = NewNote;
                            game.unspawnNotes.push(NewSustan);
                            if (NewSustan.mustPress) NewSustan.x += FlxG.width / 2;
                            else if(ClientPrefs.middleScroll) 
                            {
                                NewSustan.x += 310;
                                if(NoteData > 1) NewSustan.x += FlxG.width / 2 + 25;
                            }
                        }
                    }
                    if (NewNote.mustPress) NewNote.x += FlxG.width / 2;
                    else if(ClientPrefs.middleScroll)
                    {
                        NewNote.x += 310;
                        if(Notedata > 1) NewNote.x += FlxG.width / 2 + 25;
                    }
                }
            }
        ]])
    end
    for i = 1, #items do
        makeLuaSprite(items[i], 'main/applecore/'..items[i], 0, -250)
        setProperty(items[i]..'.visible', false)
        setGraphicSize(items[i], getProperty(items[i]..'.width') * 1.75, getProperty(items[i]..'.height') * 1.75)
        if i == 3 then
            setProperty(items[i]..'.y', -1250)
            setGraphicSize(items[i], getProperty(items[i]..'.width') * 2, getProperty(items[i]..'.height') * 2)
        end
        screenCenter(items[i], 'x')
        addLuaSprite(items[i], false)
        setSpriteShader(items[i], shadname)

        if i == 3 then
            setShaderFloat(items[i], 'uWaveAmplitude', 0.25)
            setShaderFloat(items[i], 'uFrequency', 10)
            setShaderFloat(items[i], 'uSpeed', 3)
        else
            setShaderFloat(items[i], 'uWaveAmplitude', 0.1)
            setShaderFloat(items[i], 'uFrequency', 5)
            setShaderFloat(items[i], 'uSpeed', 2)
        end
    end

    for i = 1, #items2 do
        makeAnimatedLuaSprite(items2[i], 'main/applecore/'..items2[i], getRandomInt(-2000, -3000), getRandomInt(heightStuff[1], heightStuff[2]))
        addAnimationByPrefix(items2[i], 'idle', 'p', 14, true);
        playAnim(items2[i], 'idle', true);
        scaleObject(items2[i], 0.675, 0.675)
        addLuaSprite(items2[i], false)

        makeAnimatedLuaSprite(items2[i]..'1', 'main/applecore/'..items2[i], getRandomInt(-2000, -3000), getRandomInt(heightStuff[1], heightStuff[2]))
        addAnimationByPrefix(items2[i]..'1', 'idle', 'p', 14, true);
        playAnim(items2[i]..'1', 'idle', true);
        scaleObject(items2[i]..'1', 0.675, 0.675)
        addLuaSprite(items2[i]..'1', false)

        doTweenX(items2[i]..'first', items2[i], getRandomInt(0, 500), time / playbackRate, tweenType)
        doTweenY(items2[i]..'first1', items2[i], getRandomInt(-150, 1750), time / playbackRate, tweenType)
        doTweenX(items2[i]..'first11', items2[i]..'1', getRandomInt(0, 500), time / playbackRate, tweenType)
        doTweenY(items2[i]..'first111', items2[i]..'1', getRandomInt(-150, 1750), time / playbackRate, tweenType)
    end

    for i = 1, #items3 do
        makeAnimatedLuaSprite(items3[i], 'main/applecore/'..items3[i], getRandomInt(-2000, -3000), getRandomInt(heightStuff[1], heightStuff[2]))
        addAnimationByPrefix(items3[i], 'walking', 'poip0', 24, true);
        addAnimationByPrefix(items3[i], 'woah', 'poop0', 24, true);
        addAnimationByPrefix(items3[i], 'spin', 'porp0', 24, true);
        playAnim(items3[i], 'walking', true);
        setProperty(items3[i]..'.visible', false)
        scaleObject(items3[i], 0.725, 0.725)
        addLuaSprite(items3[i], false)

        makeAnimatedLuaSprite(items3[i]..'1', 'main/applecore/'..items3[i], getRandomInt(-2000, -3000), getRandomInt(heightStuff[1], heightStuff[2]))
        addAnimationByPrefix(items3[i]..'1', 'walking', 'poip0', 24, true);
        addAnimationByPrefix(items3[i]..'1', 'woah', 'poop0', 24, true);
        addAnimationByPrefix(items3[i]..'1', 'spin', 'porp0', 24, true);
        playAnim(items3[i]..'1', 'walking', true);
        setProperty(items3[i]..'1.visible', false)
        scaleObject(items3[i]..'1', 0.725, 0.725)
        addLuaSprite(items3[i]..'1', false)

        doTweenX(items3[i]..'first', items3[i], getRandomInt(0, 500), time / playbackRate, tweenType)
        doTweenY(items3[i]..'first1', items3[i], getRandomInt(heightStuff[1], heightStuff[2]), time / playbackRate, tweenType)
        doTweenX(items3[i]..'first11', items3[i]..'1', getRandomInt(0, 500), time / playbackRate, tweenType)
        doTweenY(items3[i]..'first111', items3[i]..'1', getRandomInt(heightStuff[1], heightStuff[2]), time / playbackRate, tweenType)
    end

    setProperty('hi.visible', true)
end

local elapsedtime = 0
function onUpdatePost(elapsed)
	elapsedtime = elapsedtime + elapsed
	for i = 1, #items do
	    setShaderFloat(items[i], 'uTime', elapsedtime)
    end
end

function onTweenCompleted(tag)
    for i = 1, #items2 do
        if tag == items2[i]..'first111' then
            doTweenX(items2[i]..'second', items2[i], 3000, time / playbackRate, tweenType)
            doTweenY(items2[i]..'second1', items2[i], getRandomInt(-150, 1750), time / playbackRate, tweenType)
            doTweenX(items2[i]..'second11', items2[i]..'1', 3000, time / playbackRate, tweenType)
            doTweenY(items2[i]..'second111', items2[i]..'1', getRandomInt(-150, 1750), time / playbackRate, tweenType)
            runTimer('time', getRandomFloat(timeTimer[1], timeTimer[2]) / playbackRate)
        end

        if tag == items2[i]..'second111' then
            setProperty(items2[i]..'.x', getRandomInt(-2000, -3000))
            setProperty(items2[i]..'1.x', getRandomInt(-2000, -3000))
            setProperty(items2[i]..'.y', getRandomInt(heightStuff[1], heightStuff[2]))
            setProperty(items2[i]..'1.y', getRandomInt(heightStuff[1], heightStuff[2]))
        end
    end

    for i = 1, #items3 do
        if tag == items3[i]..'first111' then
            doTweenX(items3[i]..'second', items3[i], 3000, time / playbackRate, tweenType)
            doTweenY(items3[i]..'second1', items3[i], getRandomInt(heightStuff[1], heightStuff[2]), time / playbackRate, tweenType)
            doTweenX(items3[i]..'second11', items3[i]..'1', 3000, time / playbackRate, tweenType)
            doTweenY(items3[i]..'second111', items3[i]..'1', getRandomInt(heightStuff[1], heightStuff[2]), time / playbackRate, tweenType)
            runTimer('time2', getRandomFloat(timeTimer[1], timeTimer[2]) / playbackRate)
        end

        if tag == items3[i]..'second111' then
            playAnim(items3[i], anims[getRandomInt(1, 3)], true);
            playAnim(items3[i]..'1', anims[getRandomInt(1, 3)], true);

            setProperty(items3[i]..'.x', getRandomInt(-2000, -3000))
            setProperty(items3[i]..'1.x', getRandomInt(-2000, -3000))
            setProperty(items3[i]..'.y', getRandomInt(heightStuff[1], heightStuff[2]))
            setProperty(items3[i]..'1.y', getRandomInt(heightStuff[1], heightStuff[2]))
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'time' then
        for i = 1, #items2 do
            doTweenX(items2[i]..'first', items2[i], getRandomInt(0, 750), time / playbackRate, tweenType)
            doTweenY(items2[i]..'first1', items2[i], getRandomInt(-250, 750), time / playbackRate, tweenType)
            doTweenX(items2[i]..'first11', items2[i]..'1', getRandomInt(0, 750), time / playbackRate, tweenType)
            doTweenY(items2[i]..'first111', items2[i]..'1', getRandomInt(-250, 500), time / playbackRate, tweenType)
        end
    end

    if tag == 'time2' then
        for i = 1, #items3 do
            doTweenX(items3[i]..'first', items3[i], getRandomInt(0, 750), time / playbackRate, tweenType)
            doTweenY(items3[i]..'first1', items3[i], getRandomInt(-250, 750), time / playbackRate, tweenType)
            doTweenX(items3[i]..'first11', items3[i]..'1', getRandomInt(0, 750), time / playbackRate, tweenType)
            doTweenY(items3[i]..'first111', items3[i]..'1', getRandomInt(-250, 500), time / playbackRate, tweenType)
        end
    end
end