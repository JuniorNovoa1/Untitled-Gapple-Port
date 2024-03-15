function doTweenDefaultCamZoom(tag, value, duration)
    runHaxeCode([[
        PlayState.instance.modchartTweens.set("]]..tag..[[", FlxTween.num(game.defaultCamZoom, ]]..value..[[, ]]..duration..[[, {
            onUpdate: function(twn) {
                game.defaultCamZoom = twn.value;
            }, onComplete: function(twn) {
                PlayState.instance.modchartTweens.remove("]]..tag..[[");
                PlayState.instance.callOnLuas('onTweenCompleted', ["]]..tag..[["]);
            }
        }));
    ]])
end

function onSongStart()
	doTweenDefaultCamZoom("camZoomStartSong", 1, 17)
end

function onBadaiCreate()
    setProperty("badai.scale.x", 0.001)
    setProperty("badai.scale.y", 0.001)
    updateHitbox("badai")
    setProperty("badai.x", getProperty("dad.x") + 100)
    setProperty("badai.y", getProperty("dad.y"))

    runHaxeCode([[
        var barbu = new Character(0, 0, 'barbu-cyber');
        game.add(barbu);
        game.startCharacterLua('barbu-cyber');
        game.modchartSprites.set('barbu', barbu);
    ]])
    setProperty("barbu.x", getProperty("barbu.x") + 100)
    setProperty("barbu.y", -900)
end

local oldHealthArrayShit = {}
function onStepHit()
	if curStep == 256 then
		cancelTween("camZoomStartSong")
		setProperty("defaultCamZoom", 0.7)
	end
    if curStep == 2672 then
        doTweenX("badaiScale", "badai.scale", 1, .5, "sineInOut")
        doTweenY("badaiScale2", "badai.scale", 1, .5, "sineInOut")
        doTweenX("moveBICHH", "dad", getProperty("dad.x") - 200, .5, "sineInOut")
        doTweenY("moveBICHH2", "dad", getProperty("dad.y") - 200, .5, "sineInOut")
        oldHealthArrayShit = {
            getProperty("dad.healthColorArray[0]"),getProperty("dad.healthColorArray[1]"),getProperty("dad.healthColorArray[2]")
        }
        setProperty("dad.healthColorArray[0]", getProperty("badai.healthColorArray[0]"))
        setProperty("dad.healthColorArray[1]", getProperty("badai.healthColorArray[1]"))
        setProperty("dad.healthColorArray[2]", getProperty("badai.healthColorArray[2]"))
        runHaxeCode([[
            game.iconP2.changeIcon(game.getLuaObject('badai', false).healthIcon);
            game.reloadHealthBarColors();
        ]])
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", true)
    end
    if curStep == 3824 then
        doTweenX("badaiScale", "badai", getProperty("badai.x") - 200, .5, "sineInOut")
        doTweenX("moveBICHH", "dad", getProperty("dad.x") + 200, .5, "sineInOut")
        doTweenY("moveBICHH2", "dad", getProperty("dad.y") + 200, .5, "sineInOut")
        setProperty("dad.healthColorArray[0]", oldHealthArrayShit[1])
        setProperty("dad.healthColorArray[1]", oldHealthArrayShit[2])
        setProperty("dad.healthColorArray[2]", oldHealthArrayShit[3])
        runHaxeCode([[
            game.iconP2.changeIcon(game.dad.healthIcon);
            game.reloadHealthBarColors();
        ]])
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", false)
    end
    if curStep == 4064 then --barbu?
        setProperty("dad.healthColorArray[0]", getProperty("barbu.healthColorArray[0]"))
        setProperty("dad.healthColorArray[1]", getProperty("barbu.healthColorArray[1]"))
        setProperty("dad.healthColorArray[2]", getProperty("barbu.healthColorArray[2]"))
        runHaxeCode([[
            game.iconP2.changeIcon(game.getLuaObject('barbu', false).healthIcon);
            game.reloadHealthBarColors();
        ]])
        doTweenY("moveBIC", "barbu", getProperty("dad.y") + 200, 1, "sineInOut")
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", true)
        setDataFromSave("UnNamedGapplePortSettings", "canSing", false)
    end
    if curStep == 5936 then --return back to jambi
        setDataFromSave("UnNamedGapplePortSettings", "badaiTime", false)
        setProperty("dad.healthColorArray[0]", oldHealthArrayShit[1])
        setProperty("dad.healthColorArray[1]", oldHealthArrayShit[2])
        setProperty("dad.healthColorArray[2]", oldHealthArrayShit[3])
        runHaxeCode([[
            game.iconP2.changeIcon(game.dad.healthIcon);
            game.reloadHealthBarColors();
        ]])
        if flashingLights then cameraFlash("game", "FFFFFF", 1) end
        setProperty("badai.alpha", 0)
        setProperty("barbu.alpha", 0)
    end
end

function badaiPlayAnim(anim)
	runHaxeCode([[
		game.getLuaObject("barbu", false).playAnim("]]..anim..[[", true);
		if ("]]..anim..[[" == "dance")
			game.getLuaObject("barbu", false).dance();
	]])
end
function onBeatHit()
	if curBeat % 2 == 0 then
		if getProperty("barbu.animation.curAnim.name") == 'idle' and not getProperty("barbu.skipDance") then badaiPlayAnim('dance') end
		if getProperty("barbu.animation.curAnim.name") == 'danceLeft' and not getProperty("barbu.skipDance") then badaiPlayAnim('dance') elseif getProperty("barbu.animation.curAnim.name") == 'danceRight' and not getProperty("barbu.skipDance") then badaiPlayAnim('dance') end
	end
end
local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    local suffix = "";
	--if string.lower(noteType) == "altanim" or altAnim then suffix = "-alt" end
    if getDataFromSave("UnNamedGapplePortSettings", "badaiTime", false) and not getDataFromSave("UnNamedGapplePortSettings", "canSing", true) then
        setProperty("barbu.holdTimer", 0)
		badaiPlayAnim(singAnims[noteData + 1]..suffix)
    end
end