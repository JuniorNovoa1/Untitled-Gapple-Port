--DON'T STEAL KIDS!
--BY JUNIORNOVOA
local gappleSong = true; --set to false to disable!
local nonCharSelectSongs = {'main-menu', 'disruption', 'applecore', 'disability', 'wireframe', 'algebra', 'fresh-and-toasted', 'deformation', 'ferocious', 'nice', 'glamrock', 'ready-loud', 'cuberoot', 'the-scratches', 'apple-leak', 'kooky'};

local lockedCharacters = {}
local characters = { --put characters here, ijdiot
	[1] = {'bf', 'bf-pixel', '3d-bf', 'froing', 'epicBf', 'dinner-bf', 'boyfranon', 'bf-screwed'},
	[2] = {'split-dave-3d'}
}
local characterOffsets = { --put offsets here, idjiot2
	["bf"] = {-100, -100},
	["bf-pixel"] = {150, 135},
	["bf-screwed"] = {0, 50}
}
local funnyReturnString = { --put text here, idjiot3
	["bf"] = "Boyfriend",
	["bf-pixel"] = "Pixel Boyfriend",
	["3d-bf"] = "3D Boyfriend",
	["froing"] = "Boing Froing",
	["epicBf"] = "Biggity Dawg",
	["dinner-bf"] = "Dinnerboyfriend",
	["nil"] = "/V/-tan Boyfriend",
	["boyfranon"] = "Boyfranon",
	["nil"] = "Minecraft Boyfriend",
	["nil"] = "Loft Boyfriend",
	["bf-screwed"] = "#Screwed Boyfriend",
	["nil"] = "INDIE CROSS BEST BF",
	["nil"] = "Corrupted Boyfriend"
}
local nonNativeCharacters = {
	["split-dave-3d"] = false;
} --put non bf characters here idjiot4
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
	if inChartEditor then gappleSong = false; end
	for i = 1, #nonCharSelectSongs do
		if string.lower(songName) == nonCharSelectSongs[i] then gappleSong = false; end
	end
	if not gappleSong then
		callOnLuas('onDialogueReadyChar')
		runHaxeCode([[game.startCountdown();]])
		callOnLuas('onCountdownTick', {69})
		callOnLuas("changeNoteSkinsOnChange")
		callOnLuas("onStrumsCreate")
		return;
	end

	makeLuaSprite('mineBGcharSelect', 'extras/mine_bg', 0, 0)
	scaleObject("mineBGcharSelect", 0.75, 0.75, true)
	setObjectCamera("mineBGcharSelect", 'other')
	updateHitbox('mineBGcharSelect')
	screenCenter('mineBGcharSelect')
	addLuaSprite('mineBGcharSelect', false)

	makeLuaText("charTxt", "", 0, 22.5, 620)
	setObjectCamera("charTxt", 'other')
	setTextFont("charTxt", "comic.ttf")
	setTextSize("charTxt", 66)
	setTextBorder("charTxt", 4, "000000")
	setProperty("charTxt.antialiasing", false)
	addLuaText("charTxt")

	makeLuaSprite('charSelectGuide', 'charSelectGuide', 25, 10)
	setProperty("charSelectGuide.antialiasing", false)
	setObjectCamera("charSelectGuide", 'other')
	scaleObject("charSelectGuide", 1.1, 1.1, true)
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
	local buttonObjs = {'changeLeft', 'changeDown', 'changeUp', 'changeRight', 'backButton', 'confirmButton'}
	local buttonObjScale = 0.75;

	if buildTarget == 'android' then
		--[[makeLuaSprite('changeLeft', 'touchDirectionArrow', buttonPos[1] - (142 * buttonObjScale), buttonPos[2])
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
		addLuaSprite('changeDown', false)--]]
	
		makeLuaSprite('backButton', 'androidBack', 1035, 25 * buttonObjScale)
		setObjectCamera("backButton", 'other')
		addLuaSprite('backButton', false)
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
			--setObjectOrder(buttonObjs[i], getObjectOrder("gappleSoundTray") - i)
		end
	end
end

function createChar()
	runHaxeCode([[game.getLuaObject('char', false).destroy();]])
	runHaxeCode([[game.getLuaObject('charIcon', false).destroy();]])
	runHaxeCode([[
		var char = new Character(835, 325, "]]..characters[curSelected][curSelectedVer]..[[");
		char.camera = game.camOther;
		char.flipX = !char.flipX;
		char.scale.set(char.scale.x -0.1, char.scale.y -0.1);
		game.add(char);
		game.modchartSprites.set('char', char);

		var charIcon = new HealthIcon(char.healthIcon, false);
		charIcon.x += 25;
		charIcon.y = 500;
		charIcon.camera = game.camOther;
		game.add(charIcon);
		game.modchartSprites.set('charIcon', charIcon);
	]])
	if characterOffsets[characters[curSelected][curSelectedVer]] ~= nil then
		setProperty("char.x", getProperty("char.x") + characterOffsets[characters[curSelected][curSelectedVer]][1])
		setProperty("char.y", getProperty("char.y") + characterOffsets[characters[curSelected][curSelectedVer]][2])
	end
	setObjectOrder("screenTrans", 99)
	setObjectOrder("char", getObjectOrder("screenTrans") - 2)
	setObjectOrder("charIcon", getObjectOrder("screenTrans") - 2)

	runTimer("charDance", 1 / playbackRate)
end

local hasExitCharSelect = false;
function onStartCountdown()
	if not hasExitCharSelect and gappleSong then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function triggerKeyThingy(key)
	if key == 'escape' then
		confirmed = true;
		runHaxeCode([[game.endSong();]])
	end
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
		runHaxeCode([[
			if (game.getLuaObject("char", false).animOffsets.exists("hey"))
				game.getLuaObject("char", false).playAnim("hey");
			else
				game.getLuaObject("char", false).playAnim("singUP");
			end
		]])
		--[[setProperty("boyfriend.x", (posBF[1] + bfSCALE[1]) - (getProperty("boyfriend.width") * 0.9))
		setProperty("boyfriend.y", (posBF[2] + bfSCALE[2]) - (getProperty("boyfriend.height") * 0.9))--]]
		playSound('confirmMenu', 1)
		setSoundVolume("charSelectSound", 0)
		if flashingLights then cameraFlash("other", "FFFFFF", 1 / playbackRate) end
		runTimer("soundchar", 1.6 / playbackRate)
		
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
	if hasExitCharSelect or not gappleSong then return; end
	setProperty("fakeMouse.x", getMouseX("hud"))
	setProperty("fakeMouse.y", getMouseY("hud"))
	if not luaSoundExists('charSelectSound') then
		playSound("character_select", 1, "charSelectSound")
	end

	if not confirmed then
		if funnyReturnString[characters[curSelected][curSelectedVer]] ~= nil then setTextString("charTxt", funnyReturnString[characters[curSelected][curSelectedVer]]) else setTextString("charTxt", getProperty("char.curCharacter")) end
	end
	
	if (keyJustPressed('back') or (mouseClicked("left") and objectsOverlap("fakeMouse", "backButton"))) and not confirmed then triggerKeyThingy('escape') end
	if (keyJustPressed('left') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeLeft"))) and not confirmed then triggerKeyThingy('left') end
	if (keyJustPressed('right') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeRight"))) and not confirmed then triggerKeyThingy('right') end
	if (keyJustPressed('up') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeUp"))) and not confirmed then triggerKeyThingy('up') end
	if (keyJustPressed('down') or (mouseClicked("left") and objectsOverlap("fakeMouse", "changeDown"))) and not confirmed then triggerKeyThingy('down') end
	if (keyJustPressed('accept') or (mouseClicked("left") and objectsOverlap("fakeMouse", "confirmButton"))) and not confirmed then triggerKeyThingy('accept') end
end

local singAnims = {"singRIGHT", "singDOWN", "singUP", "singLEFT"}
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if nonNativeCharacters[boyfriendName] == false and confirmed then
		playAnim("boyfriend", singAnims[noteData + 1])
	end
end

function onTimerCompleted(tag)
	if tag == 'charDance' and not confirmed then
		runHaxeCode([[game.getLuaObject('char', false).dance();]])
		runTimer("charDance", 1 / playbackRate)
	end

	if tag == 'soundchar' then
		setProperty("screenTrans.x", -screenWidth)
		doTweenX("screenTransOut", "screenTrans", 0, tweenArg1 / playbackRate, tweenArg2)
	end

	if tag == 'soundchar2' then
		doTweenX("screenTransFinale", "screenTrans", screenWidth, tweenArg1 / playbackRate, tweenArg2)
		removeLuaSprite("mineBGcharSelect", true)
		removeLuaSprite("charSelectGuide", true)
		removeLuaText("charTxt", true)
		runHaxeCode([[game.getLuaObject('char', false).destroy();]])
		runHaxeCode([[game.getLuaObject('charIcon', false).destroy();]])
	end
end

function onTweenCompleted(tag)
	if tag == 'screenTransOut' then
		triggerEvent("Change Character", 'bf', characters[curSelected][curSelectedVer])
		if nonNativeCharacters[boyfriendName] == false then setProperty("boyfriend.cameraPosition[0]", getProperty("boyfriend.cameraPosition[0]") * -2) end
		runTimer("soundchar2", 1 / playbackRate)
	end

	if tag == 'screenTransFinale' then
		removeLuaSprite("screenTrans", true)
		hasExitCharSelect = true;
		callOnLuas('onDialogueReadyChar', {})
		runHaxeCode([[game.startCountdown();]])
		--close(true)
	end
end