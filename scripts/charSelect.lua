--DON'T STEAL KIDS!
--BY JUNIORNOVOA
local nonCharSelectSongs = {'glamrock', 'kooky'};
local gappleSong = true;

local characters = { --put characters here, ijdiot
	[1] = {'bf', 'odd-bf'},
	[2] = {'3d-bf', 'gf'},
	[3] = {'dad'},
	[4] = {'split-dave-3d', 'bambi-piss-3d', 'dad', 'ticking'}
}
local characterOffsets = { --put offsets here, idjiot2
	["bambi-piss-3d"] = {-250, -250}
}
local funnyReturnString = { --put text here, idjiot3
	["bf"] = "Boyfriend"
}
local curSelected = 1;
local curSelectedVer = 1;
local confirmed = false;

--tweems
tweenArg1 = 1.2;
tweenArg2 = "circInOut";

function onCreatePost()
	for i = 1, #nonCharSelectSongs do
		if string.lower(songName) == nonCharSelectSongs[i] then gappleSong = false; end
	end
	if not getDataFromSave("Juniors Ports Stuff", "charSelect") or not gappleSong then
		callOnLuas('onDialogueReadyChar')
		runHaxeCode([[game.startCountdown();]])
		return;
	end
	
	if stringStartsWith(version, '0.6') then
        addHaxeLibrary('Character')
		addHaxeLibrary('HealthIcon')
    else
        addHaxeLibrary('Character', 'objects')
		addHaxeLibrary('HealthIcon', 'objects')
    end


	makeLuaSprite('mineBGcharSelect', 'extras/mine_bg', 0, 0)
	scaleObject("mineBGcharSelect", 0.75, 0.75, true)
	setObjectCamera("mineBGcharSelect", 'other')
	updateHitbox('mineBGcharSelect')
	screenCenter('mineBGcharSelect')
	addLuaSprite('mineBGcharSelect', false)

	makeLuaText("charTxt", "", 0, 25, 600)
	setObjectCamera("charTxt", 'camOTHER')
	setTextFont("charTxt", "comic.ttf")
	setTextSize("charTxt", 64)
	setTextBorder("charTxt", 4, "000000")
	addLuaText("charTxt")

	makeLuaSprite('charSelectGuide', 'charSelectGuide', 25, 10)
	setObjectCamera("charSelectGuide", 'other')
	addLuaSprite('charSelectGuide', false)

	makeLuaSprite('screenTrans', '', 0, 0)
	makeGraphic('screenTrans', '1280', '720', '000000')
	setObjectCamera("screenTrans", "other")
	updateHitbox("screenTrans")
	screenCenter("screenTrans", 'xy')
	addLuaSprite('screenTrans', true)
	createChar()
	setObjectOrder("screenTrans", 99)
	doTweenX("screenTrans", "screenTrans", screenWidth, tweenArg1, tweenArg2)
end

function createChar()
	runHaxeCode([[game.getLuaObject('char', false).destroy();]])
	runHaxeCode([[game.getLuaObject('charIcon', false).destroy();]])
	runHaxeCode([[
		var char = new Character(835, 325, "]]..characters[curSelected][curSelectedVer]..[[");
		char.camera = game.camOther;
		char.flipX = false;
		char.scale.set(char.scale.x -0.1, char.scale.y -0.1);
		game.add(char);
		game.modchartSprites.set('char', char);

		var charIcon = new HealthIcon(char.healthIcon, false);
		charIcon.x += 25;
		charIcon.y = 475;
		charIcon.camera = game.camOther;
		game.add(charIcon);
		game.modchartSprites.set('charIcon', charIcon);
	]])
	if characterOffsets[characters[curSelected][curSelectedVer]] ~= nil then
		setProperty("char.x", getProperty("char.x") + characterOffsets[characters[curSelected][curSelectedVer]][1])
		setProperty("char.y", getProperty("char.y") + characterOffsets[characters[curSelected][curSelectedVer]][2])
	end
	setObjectOrder("char", getObjectOrder("screenTrans") - 1)
	setObjectOrder("charIcon", getObjectOrder("screenTrans") - 1)
	setObjectOrder("screenTrans", 99)

	runTimer("charDance", 1)
end

local hasExitCharSelect = false;
function onStartCountdown()
	if not hasExitCharSelect and getDataFromSave("Juniors Ports Stuff", "charSelect") and gappleSong then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onUpdate(elapsed)
	if hasExitCharSelect or not getDataFromSave("Juniors Ports Stuff", "charSelect") or not gappleSong then return; end
	if luaSoundExists('charSelectSound') == false then
		playSound("character_select", 1, "charSelectSound")
	end

	if not confirmed then
		if funnyReturnString[characters[curSelected][curSelectedVer]] ~= nil then setTextString("charTxt", funnyReturnString[characters[curSelected][curSelectedVer]]) else setTextString("charTxt", "Char not in array!") end
	end
	
	if keyJustPressed('left') and not confirmed then
		curSelectedVer = 1;
		curSelected = curSelected - 1;
		if curSelected == 0 then
			curSelected = #characters;
		end
		createChar()
	end
	if keyJustPressed('right') and not confirmed then
		curSelectedVer = 1;
		curSelected = curSelected + 1;
		if curSelected == #characters +1 then
			curSelected = 1;
		end
		createChar()
	end
	if keyJustPressed('up') and not confirmed then
		curSelectedVer = curSelectedVer +1;
		if curSelectedVer == #characters[curSelected] +1 then
			curSelectedVer = 1;
		end
		createChar()
	end
	if keyJustPressed('down') and not confirmed then
		curSelectedVer = curSelectedVer -1;
		if curSelectedVer == 0 then
			curSelectedVer = #characters[curSelected];
		end
		createChar()
	end
	
	if keyJustPressed('accept') and not confirmed then
		local posBF = {getProperty("boyfriend.x"), getProperty("boyfriend.y")}
		local bfSCALE = {getProperty("boyfriend.width"), getProperty("boyfriend.height")}
		playAnim("char", "hey", false)
		triggerEvent("Change Character", 'bf', characters[curSelected][curSelectedVer])
		setProperty("boyfriend.x", (posBF[1] + bfSCALE[1]) - (getProperty("boyfriend.width") * 0.9))
		setProperty("boyfriend.y", (posBF[2] + bfSCALE[2]) - (getProperty("boyfriend.height") * 0.9))
		playSound('confirmMenu', 1)
		setSoundVolume("charSelectSound", 0)
		if flashingLights then
			cameraFlash("other", "FFFFFF", 1)
		end
		runTimer("soundchar", 1.6)
		
		confirmed = true;
	end
end

function onTimerCompleted(tag)
	if tag == 'charDance' and not confirmed then
		runHaxeCode([[game.getLuaObject('char', false).dance();]])
		runTimer("charDance", 1)
	end

	if tag == 'soundchar' then
		setProperty("screenTrans.x", -screenWidth)
		doTweenX("screenTransOut", "screenTrans", 0, tweenArg1, tweenArg2)
	end

	if tag == 'soundchar2' then
		doTweenX("screenTransFinale", "screenTrans", screenWidth, tweenArg1, tweenArg2)
		removeLuaSprite("mineBGcharSelect", true)
		removeLuaSprite("charSelectGuide", true)
		removeLuaText("charTxt", true)
		runHaxeCode([[game.getLuaObject('char', false).destroy();]])
		runHaxeCode([[game.getLuaObject('charIcon', false).destroy();]])
	end
end

function onTweenCompleted(tag)
	if tag == 'screenTransOut' then
		runTimer("soundchar2", 1)
	end

	if tag == 'screenTransFinale' then
		removeLuaSprite("screenTrans", true)
		hasExitCharSelect = true;
		callOnLuas('onDialogueReadyChar', {})
		runHaxeCode([[game.startCountdown();]])
		callOnLuas("changeNoteSkinsOnChange")
		callOnLuas("onStrumsCreate")
	end
end