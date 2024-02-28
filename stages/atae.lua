function onCreate()
    if string.lower(songName) == 'ataefull' then
        --credit Drawoon_ later
        local songString = {"atae-dave", "atae-bambi", "atae-tristan"}
        for i = 1, #songString do
            runHaxeCode([[
                var SecondSong:SwagSong;
                //SecondSong = Song.loadFromJson("bopeebo-hard", "bopeebo");
                SecondSong = Song.loadFromJson("]]..songString[i]..[[", "ataefull");
                var Notedata:Array<SwagSection>=SecondSong.notes;
                for (Section in Notedata)
                {
                    for (songNotes in Section.sectionNotes)
                    {
                      var Strum:Float = songNotes[0];
                      var NoteData:Int = Std.int(songNotes[1] % 4);
                      var LastNote:Note;
                      if (game.unspawnNotes.length > 0) LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                      else LastNote = null;
                      var NewNote:Note = new Note(Strum, NoteData, LastNote);
                      NewNote.mustPress = false;
                      NewNote.sustainLength = songNotes[2];
                      NewNote.gfNote = false;
                      NewNote.noteType = ']]..songString[i]..[[';
                      NewNote.scrollFactor.set();
                      var Length:Float = NewNote.sustainLength;
                      Length = Length / Conductor.stepCrochet;
                      game.unspawnNotes.push(NewNote);
                      var floor:Int = Math.floor(Length);
                        if(floor > 0) {
                            for (susNote in 0...floor+1)
                            {
                                LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                                var NewSustan:Note = new Note(Strum + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(]]..getProperty('songSpeed')..[[, 2)), NoteData, LastNote, true);
                                NewSustan.mustPress = false;
                                NewSustan.gfNote = false;
                                NewSustan.noteType = ']]..songString[i]..[[';
                                NewSustan.scrollFactor.set();
                                NewNote.tail.push(NewSustan);
                                NewSustan.parent = NewNote;
                                game.unspawnNotes.push(NewSustan);
                            }
                        }
                    }
                }
            ]])
        end

        makeLuaSprite("sky", "extras/ataeo/p1/day sky", 0, 0)
        addLuaSprite("sky", false)
        makeLuaSprite("clouds", "extras/ataeo/p1/day cloud", 0, 0)
        addLuaSprite("clouds", false)
        makeLuaSprite("ground", "extras/ataeo/p1/day ground", 0, 0)
        addLuaSprite("ground", false)
        makeLuaSprite("bushs", "extras/ataeo/p1/day bush", 0, 0)
        addLuaSprite("bushs", false)

        local bgObjects = {"sky", "clouds", "ground", "bushs"}
        for i = 1, #bgObjects do
            scaleObject(bgObjects[i], 0.8, 0.8, true)
            screenCenter(bgObjects[i], 'xy')
        end
    end
end