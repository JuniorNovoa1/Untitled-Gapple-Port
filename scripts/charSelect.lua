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
local nativeCharacters = {
	["bf"] = true;
	["odd-bf"] = true;
	["3d-bf"] = true;
}
local curSelected = 1;
local curSelectedVer = 1;
local confirmed = false;

--tweems
tweenArg1 = 1.2;
tweenArg2 = "circInOut";

function onCreate()
	addLuaScript("scripts/gappleScripts/dialogue")
end

function onCreatePost()
	for i = 1, #nonCharSelectSongs do
		if string.lower(songName) == nonCharSelectSongs[i] then gappleSong = false; end
	end
	if not getDataFromSave("Juniors Ports Stuff", "charSelect", true) or not gappleSong then
		callOnLuas('onDialogueReadyChar')
		runHaxeCode([[game.startCountdown();]])
		callOnLuas('onCountdownTick', {69})
		callOnLuas("changeNoteSkinsOnChange")
		callOnLuas("onStrumsCreate")
		return;
	end

	addHaxeLibrary("FlxG", 'flixel')
	
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

	makeLuaSprite('screenTrans', '', screenWidth, 0)
	makeGraphic('screenTrans', '1280', '720', '000000')
	setObjectCamera("screenTrans", "other")
	updateHitbox("screenTrans")
	screenCenter("screenTrans", 'y')
	addLuaSprite('screenTrans', true)
	createChar()
	setObjectOrder("screenTrans", 99)

	local buttonPos = {125, 275}--{890, 500}
	local buttonObjs = {'changeLeft', 'changeDown', 'changeUp', 'changeRight', 'confirmButton'}
	local buttonObjScale = 0.75;

	if buildTarget == 'android' then
		makeLuaSprite('changeLeft', 'touchDirectionArrow', buttonPos[1] - (142 * buttonObjScale), buttonPos[2])
		setProperty("changeLeft.angle", -90)
		setObjectCamera("changeLeft", 'other')
		addLuaSprite('changeLeft', false)
	
		makeLuaSprite('changeRight', 'touchDirectionArrow', buttonPos[1] + (142 * buttonObjScale), buttonPos[2])
		setProperty("changeRight.angle", 90)
		setObjectCamera("changeRight", 'other')
		addLuaSprite('changeRight', false)

		makeLuaSprite('changeUp', 'touchDirectionArrow', buttonPos[1], buttonPos[2] - (142 * buttonObjScale))
		setObjectCamera("changeUp", 'other')
		addLuaSprite('changeUp', false)
	
		makeLuaSprite('changeDown', 'touchDirectionArrow', buttonPos[1], buttonPos[2] + (142 * buttonObjScale))
		setProperty("changeDown.flipY", true)
		setObjectCamera("changeDown", 'other')
		addLuaSprite('changeDown', false)
	
		makeLuaSprite('confirmButton', 'androidConfirm', 1150, 25 * buttonObjScale)
		setObjectCamera("confirmButton", 'other')
		addLuaSprite('confirmButton', false)
	
		makeLuaSprite("fakeMouse", "", 0, 0)
		makeGraphic('fakeMouse', 1, 1, '000000')
		setObjectCamera("fakeMouse", 'other')
		addLuaSprite("fakeMouse", false)
		for i = 1, #buttonObjs do
			scaleObject(buttonObjs[i], buttonObjScale, buttonObjScale)
			updateHitbox(buttonObjs[i])
		end
	end
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
	if not hasExitCharSelect and getDataFromSave("Juniors Ports Stuff", "charSelect", true) and gappleSong then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function triggerKeyThingy(key)
	if key == 'left' then
		curSelectedVer = 1;
		curSelected = curSelected - 1;
		if curSelected == 0 then
			curSelected = #characters;
		end
		createChar()
	end
	if key == 'right' then
		curSelectedVer = 1;
		curSelected = curSelected + 1;
		if curSelected == #characters +1 then
			curSelected = 1;
		end
		createChar()
	end
	if key == 'up' then
		curSelectedVer = curSelectedVer +1;
		if curSelectedVer == #characters[curSelected] +1 then
			curSelectedVer = 1;
		end
		createChar()
	end
	if key == 'down' then
		curSelectedVer = curSelectedVer -1;
		if curSelectedVer == 0 then
			curSelectedVer = #characters[curSelected];
		end
		createChar()
	end
	
	if key == 'accept' then
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
		removeLuaSprite("changeLeft", true)
		removeLuaSprite("changeDown", true)
		removeLuaSprite("changeUp", true)
		removeLuaSprite("changeRight", true)
		removeLuaSprite("confirmButton", true)
		removeLuaSprite("fakeMouse", true)
	end
end

function onUpdate(elapsed)
	if hasExitCharSelect or not getDataFromSave("Juniors Ports Stuff", "charSelect", true) or not gappleSong then return; end
	setProperty("fakeMouse.x", getMouseX("other"))
	setProperty("fakeMouse.y", getMouseY("other"))
	if luaSoundExists('charSelectSound') == false then
		playSound("character_select", 1, "charSelectSound")
	end

	if not confirmed then
		if funnyReturnString[characters[curSelected][curSelectedVer]] ~= nil then setTextString("charTxt", funnyReturnString[characters[curSelected][curSelectedVer]]) else setTextString("charTxt", "Char not in array!") end
	end
	
	if (keyJustPressed('left') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeLeft"))) and not confirmed then triggerKeyThingy('left') end
	if (keyJustPressed('right') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeRight"))) and not confirmed then triggerKeyThingy('right') end
	if (keyJustPressed('up') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeUp"))) and not confirmed then triggerKeyThingy('up') end
	if (keyJustPressed('down') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeDown"))) and not confirmed then triggerKeyThingy('down') end
	if (keyJustPressed('accept') or (mouseClicked("left") and objectsOverlap("fakeMouse", "confirmButton"))) and not confirmed then triggerKeyThingy('accept') end
end

local singAnims = {"singRIGHT", "singDOWN", "singUP", "singLEFT"}
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if nativeCharacters[characters[curSelected][curSelectedVer]] ~= true and confirmed then
		playAnim("boyfriend", singAnims[noteData + 1])
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
	end
end