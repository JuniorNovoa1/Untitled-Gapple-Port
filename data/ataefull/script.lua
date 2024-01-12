local personSinging = 1;
function onCreatePost()
	local ataeChars = {"tub", "poppy", "rev"}
	for i = 1, #ataeChars do
		runHaxeCode([[
			var ]]..ataeChars[i]..[[ = new Character(-750, 100, "]]..ataeChars[i]..[[");
			game.add(]]..ataeChars[i]..[[);
			game.modchartSprites.set("]]..ataeChars[i]..[[", ]]..ataeChars[i]..[[);
		]])
		playAnim(ataeChars[i], "idle", true)
	end
	setProperty("poppy.x", getProperty("poppy.x") - 250)
	setProperty("tub.x", getProperty("tub.x") + 625)
	setProperty("tub.y", getProperty("tub.y") + 250)

	setProperty("dad.healthColorArray[0]", getProperty("rev.healthColorArray[0]"))
	setProperty("dad.healthColorArray[1]", getProperty("rev.healthColorArray[1]"))
	setProperty("dad.healthColorArray[2]", getProperty("rev.healthColorArray[2]"))
	runHaxeCode([[
		game.iconP2.changeIcon(game.getLuaObject('rev', false).healthIcon);
		game.reloadHealthBarColors();
	]])
	setObjectOrder("dadGroup", getObjectOrder("rev"))
	setProperty("dad.alpha", 0)
end

function onStepHit()
	if curStep == 3520 or curStep == 4304 then if flashingLights then cameraFlash("hud", "FFFFFF", 1) end end
	if curStep == 431 or curStep == 4304 then
		personSinging = 1;
	end
	if curStep == 704 or curStep == 3456 then
		personSinging = 2;
	end
	if curStep == 1344 then
		personSinging = 3;
	end
	if curStep == 2496 or curStep == 3728 then --dave sound a like?
		personSinging = 0;
	end
	if curStep == 2134 then
		doTweenAlpha("dad", "dad", 1, 3, "")
		doTweenY("dadY", "dad", getProperty("dad.y") - 500, 3, "")
	end
end

function onBeatHit()
	local ataeChars = {"tub", "poppy", "rev"}
	if curBeat % 2 == 0 then
		for i = 1, #ataeChars do
			if getProperty(ataeChars[i]..".animation.curAnim.name") == "idle" then playAnim(ataeChars[i], "idle", true) end
		end
	end
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if (string.lower(noteType) ~= "atae-dave" and string.lower(noteType) ~= "atae-bambi" and string.lower(noteType) ~= "atae-tristan") and personSinging == 0 then
		setProperty("dad.holdTimer", 0)
		playAnim("dad", singAnims[noteData + 1], true)
	end
	if string.lower(noteType) == "atae-dave" or personSinging == 1 then
		runHaxeCode([[game.getLuaObject("rev", false).playAnim("]]..singAnims[noteData+1]..[[", true);]])
		setProperty("rev.holdTimer", 0)
	end
	if string.lower(noteType) == "atae-bambi" or personSinging == 2 then
		runHaxeCode([[game.getLuaObject("poppy", false).playAnim("]]..singAnims[noteData+1]..[[", true);]])
		setProperty("poppy.holdTimer", 0)
	end
	if string.lower(noteType) == "atae-tristan" or personSinging == 3 then
		runHaxeCode([[game.getLuaObject("tub", false).playAnim("]]..singAnims[noteData+1]..[[", true);]])
		setProperty("tub.holdTimer", 0)
	end
end