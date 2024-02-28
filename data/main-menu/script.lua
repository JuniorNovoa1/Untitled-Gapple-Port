local curSelectedOptionUpDown = 1;
local firstStart = true;
local canChangeMenu = true;
function onCreate()
	setProperty("skipCountdown", true)
	--runHaxeCode([[FlxG.mouse.load(Paths.image("cursor"));]])
end

local nextMenu = "";
local nextFreeplayMenu = "";
local freeplayStateSongs = {
	["extra"] = {"glamrock", "sugar-rush", "gift-card", "ready-loud", "bookworm", "cuberoot", "apprentice", "too-shiny", "resumed", "mine", "dale", "the-big-dingle", "ataefull", "the-scratches", "sart-producer"},
	["secret"] = {"ticking"},
	["iykyk"] = {"og", "apple-leak"},
	["peenut"] = {"kooky"}
}
local freeplayStateIcons = {
	["extra"] = {"glamrock", "cigar-rush", "card", "flumpt", "bookworm", "disability", "tristan", "diamond", "dambu", "dinner", "dale", "dingle_static", "atae", "man", "sartys_icon_static"},
	["secret"] = {"ouch"},
	["iykyk"] = {"prealpha", "brob"},
	["peenut"] = {"rubber"}
}

function onSongStart()
	local invisObjs = {'healthBar', 'healthBarBG', 'iconP2', 'iconP1', 'timeTxt', 'scoreTxt'}
	for i = 1, #invisObjs do
		setProperty(invisObjs[i]..".visible", false)
		setProperty(invisObjs[i]..".alpha", 0)
	end
	for i = 0, 8 do
		setPropertyFromGroup("strumLineNotes", i, "visible", false)
		setPropertyFromGroup("strumLineNotes", i, "alpha", 0)
	end
	setProperty("canPause", false)
	if checkFileExists(".git") then changeState("selectionmenu") else changeState("mainmenu") end
	--createAlphabetSongs('"glamrock", "sugar-rush"', '"glamrock", "cigar-rush"')
	--changeState("selectionmenu")
	--changeState("storymenu")

	local buttonPos = {1070, 510}--{890, 500}
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
	
		makeLuaSprite('backButton', 'androidBack', buttonPos[1] - 105, buttonPos[2] - ((142 * 2) * buttonObjScale))
		setObjectCamera("backButton", 'other')
		addLuaSprite('backButton', false)
		makeLuaSprite('confirmButton', 'androidConfirm', buttonPos[1] + 105, buttonPos[2] - ((142 * 2) * buttonObjScale))
		setObjectCamera("confirmButton", 'other')
		addLuaSprite('confirmButton', false)
	
		makeLuaSprite("fakeMouseMobile", "", 0, 0)
		makeGraphic('fakeMouseMobile', 1, 1, '000000')
		setObjectCamera("fakeMouseMobile", 'other')
		addLuaSprite("fakeMouseMobile", false)
		setProperty("fakeMouseMobile.alpha", 0)
		for i = 1, #buttonObjs do
			scaleObject(buttonObjs[i], buttonObjScale, buttonObjScale)
			updateHitbox(buttonObjs[i])
			setObjectOrder(buttonObjs[i], getObjectOrder("gappleSoundTray") - i)
		end
	end
end

local prevObjects = {}
local backgroundSprs = {"biorange", "bubbscadex", "bunnyslize", "choco pop", "cudroid", "doo", "dreambean", "exorcistgold", "limited", "luts", "roflcopter", "seth", "smeek", "tallsanimtaf", "vio", "zevisly"}
local extrasSprs = {"extra", "secret", "iykyk", "joke", "peenut", "ocs", "covers"}
local curState = "";

local storyimagePaths = {"story mode", "settings", "credits", "discord"}
local storySongs = {"disruption", "applecore", "disability", "wireframe", "algebra", "fresh-and-toasted", "deformation", "ferocious", "nice"}
local storySongDifs = {
	["disruption"] = "hard",
	["applecore"] = "extreme",
	["disability"] = "normal",
	["wireframe"] = "normal",
	["algebra"] = "hard",
	["fresh-and-toasted"] = "normal",
	["deformation"] = "hard",
	["ferocious"] = "hard",
	["nice"] = "hard",
	["deformation"] = "hard"
}
local storySongsUpdated = {["applecore"] = true, ["disability"] = true, ["wireframe"] = true, ["algebra"] = true, ["deformation"] = true}
local storySongsLong = {["algebra"] = true, ["jambino"] = true, ["deformation"] = true, ["ferocious"] = true, ["nice"] = true}
local storySongsNew = {["fresh-and-toasted"] = true, ["jambino"] = true, ["nice"] = true}

function changeState(newState)
	canChangeMenu = true;
	if string.lower(newState) == "startsong" then
		makeLuaSprite("blackScreenY", "", 0, 0)
		makeGraphic("blackScreenY", 1280, 720, '000000')
		setObjectCamera("blackScreenY", 'other')
		addLuaSprite("blackScreenY", false)
		loadSong(storySongs[curSelectedOptionUpDown]) 
	end
	if string.lower(newState) == "startsongfreeplay" then
		makeLuaSprite("blackScreenY", "", 0, 0)
		makeGraphic("blackScreenY", 1280, 720, '000000')
		setObjectCamera("blackScreenY", 'other')
		addLuaSprite("blackScreenY", false)
		loadSong(freeplayStateSongs[nextFreeplayMenu][curSelectedOptionUpDown + 1]) 
	end
	if string.lower(curState) == "freeplaymenu" then
		runHaxeCode([[
			var grpSongs = getVar("grpSongs");
			for (i in 0...grpSongs.length)
			{
				grpSongs[i].destroy();
			}
		]])
		runHaxeCode([[
			var iconArray = getVar("iconArray");
			for (i in 0...iconArray.length)
			{
				iconArray[i].destroy();
			}
		]])
	end
	curState = newState;
	curSelectedOptionUpDown = 1;
	for i = 1, #prevObjects do
		if luaSpriteExists(prevObjects[i]) then removeLuaSprite(prevObjects[i], true) end
		if luaTextExists(prevObjects[i]) then removeLuaText(prevObjects[i], true) end
	end
	setTextString("creditsWatermark", "")
	runHaxeCode([[FlxG.mouse.visible = false;]])

	if string.lower(newState) == "mainmenu" then
		canChangeMenu = false;
		setTextString("creditsWatermark", "1.5 Golden Apple Engine")
		makeLuaSprite("menuBG", "backgrounds/"..backgroundSprs[getRandomInt(1, #backgroundSprs)], 0, 0)
		setGraphicSize("menuBG", 1280, 720)
		setObjectCamera("menuBG", 'hud')
		addLuaSprite("menuBG", false)
		table.insert(prevObjects, "menuBG")

		if not lowQuality then
			makeLuaSprite("menuBGOverlay", "", 0, 0)
			makeGraphic("menuBGOverlay", 1280, 720, '00ff00')
			setObjectCamera("menuBGOverlay", 'hud')
			addLuaSprite("menuBGOverlay", false)
			setProperty("menuBGOverlay.alpha", 0.35)
			table.insert(prevObjects, "menuBGOverlay")
	
			local yAxis = 0;
			local yChange = 14;
			--12.5 for a collum! 
			for i = 1, (yChange * 10) do
				local previtem = 1;
				if i > 1 then previtem = i - 1; else makeLuaSprite("checkeredBG"..i, "checkeredBG", 0, 0) end
				if (i - 1) % (yChange) == 0 then yAxis = yAxis + 1; end
				local offsetY = 140;
				makeLuaSprite("checkeredBG"..i, "checkeredBG", getProperty("checkeredBG"..previtem..".x") + getProperty("checkeredBG"..previtem..".width"), offsetY * yAxis)
				if i == 1 then makeLuaSprite("checkeredBG"..i, "checkeredBG", 0, offsetY * yAxis) end
				if (i - 1) % (yChange) == 0 then makeLuaSprite("checkeredBG"..i, "checkeredBG", 0, offsetY * yAxis) end
				setObjectCamera("checkeredBG"..i, 'hud')
				scaleObject("checkeredBG"..i, 0.8, 0.8, true)
				updateHitbox("checkeredBG"..i)
				setProperty("checkeredBG"..i..".alpha", 0.5)
				addLuaSprite("checkeredBG"..i, false)
				setProperty("checkeredBG"..i..".offset.x", 325)
				setProperty("checkeredBG"..i..".offset.y", 160)
				table.insert(prevObjects, "checkeredBG"..i)
			end
	
		end
		makeLuaSprite("blackBG", "storymenu/black_border_overlay", 50, 35)
		scaleObject("blackBG", 2, 2, true)
		setObjectCamera("blackBG", 'hud')
		addLuaSprite("blackBG", false)
		table.insert(prevObjects, "blackBG")

		makeLuaSprite("story mode", "storymenu/story mode", -350, 75)
		scaleObject("story mode", 0.7, 0.7, true)
		setObjectCamera("story mode", 'hud')
		addLuaSprite("story mode", false)
		table.insert(prevObjects, "story mode")
		makeLuaSprite("settings", "storymenu/settings", -350, 200)
		scaleObject("settings", 0.7, 0.7, true)
		setObjectCamera("settings", 'hud')
		addLuaSprite("settings", false)
		table.insert(prevObjects, "settings")
		makeLuaSprite("credits", "storymenu/credits", -350, 325)
		scaleObject("credits", 0.7, 0.7, true)
		setObjectCamera("credits", 'hud')
		addLuaSprite("credits", false)
		table.insert(prevObjects, "credits")
		makeLuaSprite("discord", "storymenu/discord", -350, 475)
		scaleObject("discord", 0.7, 0.7, true)
		setObjectCamera("discord", 'hud')
		addLuaSprite("discord", false)
		table.insert(prevObjects, "discord")
		makeLuaSprite("blackBGOverlay", "storymenu/button_border", getProperty("blackBG.x"), getProperty("blackBG.y"))
		scaleObject("blackBGOverlay", getProperty("blackBG.scale.x"), getProperty("blackBG.scale.y"), true)
		setObjectCamera("blackBGOverlay", 'hud')
		addLuaSprite("blackBGOverlay", false)
		table.insert(prevObjects, "blackBGOverlay")

		if not lowQuality then
			makeLuaSprite("char", "storymenu/icon_story mode", 625, 75)
			scaleObject("char", 0.8, 0.8, true)
			setObjectCamera("char", 'hud')
			addLuaSprite("char", false)
			table.insert(prevObjects, "char")
		end

		if firstStart then
			firstStart = false;
			runHaxeCode([[
				var sprites = ["story mode", "settings", "credits", "discord"];
				for (i in 0...4)
				{
					FlxTween.tween(game.getLuaObject(sprites[i], false), {x: 135 + (50 * (i))}, ((i + 1) * 0.175), {ease: FlxEase.sineInOut, onComplete: function(flxTween) 
					{
						FlxTween.tween(game.getLuaObject(sprites[i], false), {x: 150}, 0.6, {ease: FlxEase.expoInOut, onComplete: function(flxTween) 
						{
							if (i == 3) game.callOnLuas("change", []);
						}});
					}});
				}
			]])
		else
			change()
		end
	end
	if string.lower(newState) == "selectionmenu" then
		makeLuaSprite("blackScreenBG", "", 0, 0)
		makeGraphic("blackScreenBG", 1280, 720, '808080')
		setObjectCamera("blackScreenBG", 'hud')
		addLuaSprite("blackScreenBG", false)
		table.insert(prevObjects, "blackScreenBG")
		if not lowQuality then
			makeLuaSprite("blackScreenBG", "", 0, 0)
			makeGraphic("blackScreenBG", 1280, 720, 'FFFFFF')
			setObjectCamera("blackScreenBG", 'hud')
			addLuaSprite("blackScreenBG", false)
			local yAxis = 0;
			local yChange = 14;
			--12.5 for a collum! 
			for i = 1, (yChange * 10) do
				local previtem = 1;
				if i > 1 then previtem = i - 1; else makeLuaSprite("checkeredBG"..i, "modeselect/tiles", 0, 0) end
				if (i - 1) % (yChange) == 0 then yAxis = yAxis + 1; end
				local offsetY = 171;
				makeLuaSprite("checkeredBG"..i, "modeselect/tiles", getProperty("checkeredBG"..previtem..".x") + getProperty("checkeredBG"..previtem..".width"), offsetY * yAxis)
				if i == 1 then makeLuaSprite("checkeredBG"..i, "checkeredBG", 0, offsetY * yAxis) end
				if (i - 1) % (yChange) == 0 then makeLuaSprite("checkeredBG"..i, "modeselect/tiles", 0, offsetY * yAxis) end
				setObjectCamera("checkeredBG"..i, 'hud')
				scaleObject("checkeredBG"..i, 0.8, 0.8, true)
				updateHitbox("checkeredBG"..i)
				setProperty("checkeredBG"..i..".alpha", 0.5)
				addLuaSprite("checkeredBG"..i, false)
				setProperty("checkeredBG"..i..".offset.x", 325)
				setProperty("checkeredBG"..i..".offset.y", 190)
				table.insert(prevObjects, "checkeredBG"..i)
			end
		end

		makeLuaSprite("white", "modeselect/white", 0, 0)
		screenCenter("white", 'xy')
		setObjectCamera("white", 'hud')
		addLuaSprite("white", false)
		table.insert(prevObjects, "white")

		makeLuaSprite("story", "modeselect/storee", 135, 100)
		scaleObject("story", 1.2, 1.2, true)
		setObjectCamera("story", 'hud')
		addLuaSprite("story", false)
		table.insert(prevObjects, "story")

		makeLuaText("storyTxt", 'Main Songs:\nThe "Main" mod, woah!', 0, getProperty("story.x") + 235, getProperty("story.y") + 70)
		setTextAlignment("storyTxt", 'left')
		setTextFont("storyTxt", "comic.ttf")
		setTextSize("storyTxt", 28)
		setTextColor("storyTxt", "000000")
		setTextBorder("storyTxt", 0, "F)(32ndk)") --set border to color that doesnt exist and get borderless text!
		setObjectCamera("storyTxt", 'hud')
		addLuaText("storyTxt", false)
		table.insert(prevObjects, "storyTxt")

		makeLuaSprite("extra", "modeselect/eckstra", 775, 450)
		scaleObject("extra", 1.5, 1.5, true)
		setObjectCamera("extra", 'hud')
		addLuaSprite("extra", false)
		table.insert(prevObjects, "extra")

		makeLuaText("extraTxt", 'Extras:\nSo many songs!!!', 0, getProperty("extra.x") - 200, getProperty("extra.y"))
		setTextAlignment("extraTxt", 'right')
		setTextFont("extraTxt", "comic.ttf")
		setTextSize("extraTxt", 28)
		setTextColor("extraTxt", "000000")
		setTextBorder("extraTxt", 0, "F)(32ndk)") --set border to color that doesnt exist and get borderless text!
		setObjectCamera("extraTxt", 'hud')
		addLuaText("extraTxt", false)
		table.insert(prevObjects, "extraTxt")

		makeLuaSprite("back", "modeselect/back", 25, 675)
		scaleObject("back", 1, 1, true)
		setObjectCamera("back", 'hud')
		addLuaSprite("back", false)
		table.insert(prevObjects, "back")

		makeLuaSprite("fakeMouse", "cursor", 0, 0)
		setObjectCamera("fakeMouse", 'other')
		addLuaSprite("fakeMouse", false)
		table.insert(prevObjects, "fakeMouse")
	end
	if string.lower(newState) == "storymenu" then
		setTextString("creditsWatermark", "1.5 Golden Apple Engine")
		makeLuaSprite("grad", "grads/"..storySongs[curSelectedOptionUpDown], 0, 0)
		scaleObject("grad", 1.05, 1.05, true)
		screenCenter("grad", 'xy')
		setObjectCamera("grad", 'hud')
		addLuaSprite("grad", false)
		table.insert(prevObjects, "grad")

		makeLuaSprite("RAPPA_SLAPPA", "RAPPA_SLAPPA", 0, 35)
		scaleObject("RAPPA_SLAPPA", 1, 1, true)
		screenCenter("RAPPA_SLAPPA", 'x')
		setObjectCamera("RAPPA_SLAPPA", 'hud')
		if not lowQuality then
			addLuaSprite("RAPPA_SLAPPA", false)
			table.insert(prevObjects, "RAPPA_SLAPPA")

			makeLuaSprite("menuImage", "menu/"..storySongs[curSelectedOptionUpDown], getProperty("RAPPA_SLAPPA.x"), getProperty("RAPPA_SLAPPA.y") + 150)
			scaleObject("menuImage", 0.435, 0.435, true)
			screenCenter("menuImage", 'x')
			setObjectCamera("menuImage", 'hud')
			addLuaSprite("menuImage", false)
			table.insert(prevObjects, "menuImage")
		end

		makeLuaSprite("menuHeader", "headers/"..storySongs[curSelectedOptionUpDown], 0, -10)
		screenCenter("menuHeader", 'x')
		setObjectCamera("menuHeader", 'hud')
		addLuaSprite("menuHeader", false)
		table.insert(prevObjects, "menuHeader")

		makeLuaText("highscoreTxt", '', 0, 0, 656)
		setTextFont("highscoreTxt", "comic.ttf")
		setTextSize("highscoreTxt", 42)
		updateHitbox("highscoreTxt")
		setTextColor("highscoreTxt", "FFFFFF")
		setTextBorder("highscoreTxt", 0, "F)(32ndk)") --set border to color that doesnt exist and get borderless text!
		setObjectCamera("highscoreTxt", 'hud')
		addLuaText("highscoreTxt", false)
		table.insert(prevObjects, "highscoreTxt")

		runHaxeCode([[game.getLuaObject("highscoreTxt", true).text = "Highscore: " + Highscore.getScore("]]..storySongs[curSelectedOptionUpDown]..[[", ]]..difficulty..[[);]])
		screenCenter("highscoreTxt", 'x')

		makeLuaSprite("arrowLeft", "storymenu/arrows/leftArrow", getProperty("RAPPA_SLAPPA.x") - 175, 0)
		scaleObject("arrowLeft", 0.725, 0.725, true)
		screenCenter("arrowLeft", 'y')
		setProperty("arrowLeft.y", getProperty("arrowLeft.y") + 80)
		setObjectCamera("arrowLeft", 'hud')
		addLuaSprite("arrowLeft", false)
		table.insert(prevObjects, "arrowLeft")
		makeLuaSprite("arrowRight", "storymenu/arrows/rightArrow", getProperty("RAPPA_SLAPPA.x") + 550, 0)
		scaleObject("arrowRight", 0.725, 0.725, true)
		screenCenter("arrowRight", 'y')
		setProperty("arrowRight.y", getProperty("arrowRight.y") + 80)
		setObjectCamera("arrowRight", 'hud')
		addLuaSprite("arrowRight", false)
		table.insert(prevObjects, "arrowRight")

		if not lowQuality then
			makeLuaSprite("songDif", "diff/"..storySongDifs[storySongs[curSelectedOptionUpDown]], screenWidth - 283, 15)
			scaleObject("songDif", 0.5, 0.5, true)
			setObjectCamera("songDif", 'hud')
			addLuaSprite("songDif", false)
			table.insert(prevObjects, "songDif")
			makeLuaSprite("new song", "new song", 25, -250)
			scaleObject("new song", 0.46, 0.46, true)
			setObjectCamera("new song", 'hud')
			addLuaSprite("new song", false)
			table.insert(prevObjects, "new song")
			makeLuaSprite("long_song", "long_song", -275, 565)
			scaleObject("long_song", 0.37, 0.37, true)
			setObjectCamera("long_song", 'hud')
			addLuaSprite("long_song", false)
			table.insert(prevObjects, "long_song")
			makeLuaSprite("bamb_sign", "bamb_sign", 1300, 530)
			scaleObject("bamb_sign", 0.65, 0.65, true)
			setObjectCamera("bamb_sign", 'hud')
			addLuaSprite("bamb_sign", false)
			table.insert(prevObjects, "bamb_sign")
		end
	end
	if string.lower(newState) == "extramenu" then
		makeLuaSprite("blackScreenBG", "", 0, 0)
		makeGraphic("blackScreenBG", 1280, 720, '000000')
		setObjectCamera("blackScreenBG", 'hud')
		addLuaSprite("blackScreenBG", false)
		table.insert(prevObjects, "blackScreenBG")

		makeLuaSprite("menuBG", "backgrounds/"..backgroundSprs[getRandomInt(1, #backgroundSprs)], 0, 0)
		setGraphicSize("menuBG", 1280, 720)
		setProperty("menuBG.color", getColorFromHex("32CD32"))
		setObjectCamera("menuBG", 'hud')
		addLuaSprite("menuBG", false)
		table.insert(prevObjects, "menuBG")

		makeLuaSprite("category", "categories/"..extrasSprs[curSelectedOptionUpDown], 0, 0)
		scaleObject("category", 2.5, 2.5, true)
		setObjectCamera("category", 'hud')
		screenCenter("category", 'xy')
		addLuaSprite("category", false)
		table.insert(prevObjects, "category")
	end
	if string.lower(newState) == "freeplaymenu" then
		makeLuaSprite("menuBG", "backgrounds/"..backgroundSprs[getRandomInt(1, #backgroundSprs)], 0, 0)
		setGraphicSize("menuBG", 1280, 720)
		setProperty("menuBG.color", getColorFromHex("FFFFFF"))
		setObjectCamera("menuBG", 'hud')
		addLuaSprite("menuBG", false)
		table.insert(prevObjects, "menuBG")

		curSelectedOptionUpDown = 0;
		if freeplayStateSongs[nextFreeplayMenu] == nil then freeplayStateSongs[nextFreeplayMenu] = {"NO SONGS HERE!1!!11!"} end
		if freeplayStateIcons[nextFreeplayMenu] == nil then freeplayStateIcons[nextFreeplayMenu] = {"face"}; end
		createAlphabetSongs(freeplayStateSongs[nextFreeplayMenu], freeplayStateIcons[nextFreeplayMenu])
		changeSelection()
	end
end

function change()
	canChangeMenu = true;
	playSound("scrollMenu", 1)
	makeLuaSprite("story mode", "storymenu/story mode", 150, 75)
	makeLuaSprite("settings", "storymenu/settings", 150, 200)
	makeLuaSprite("credits", "storymenu/credits", 150, 325)
	makeLuaSprite("discord", "storymenu/discord", 150, 475)
	makeLuaSprite("char", "storymenu/icon_story mode", 625, 75)
	if curSelectedOptionUpDown == 1 then makeLuaSprite("story mode", "storymenu/story mode_selected", 150, 75) end
	if curSelectedOptionUpDown == 2 then makeLuaSprite("settings", "storymenu/settings_selected", 150, 200) end
	if curSelectedOptionUpDown == 3 then makeLuaSprite("credits", "storymenu/credits_selected", 150, 325) end
	if curSelectedOptionUpDown == 4 then makeLuaSprite("discord", "storymenu/discord_selected", 150, 475) end
	makeLuaSprite("char", "storymenu/icon_"..storyimagePaths[curSelectedOptionUpDown], 625, 75)

	scaleObject("story mode", 0.7, 0.7, true)
	setObjectCamera("story mode", 'hud')
	addLuaSprite("story mode", false)
	scaleObject("settings", 0.7, 0.7, true)
	setObjectCamera("settings", 'hud')
	addLuaSprite("settings", false)
	scaleObject("credits", 0.7, 0.7, true)
	setObjectCamera("credits", 'hud')
	addLuaSprite("credits", false)
	scaleObject("discord", 0.7, 0.7, true)
	setObjectCamera("discord", 'hud')
	addLuaSprite("discord", false)

	scaleObject("char", 0.8, 0.8, true)
	if curSelectedOptionUpDown == 3 then scaleObject("char", 1, 1, true) setProperty("char.x", 650) setProperty("char.y", 50) end
	if curSelectedOptionUpDown == 4 then scaleObject("char", 0.6, 0.6, true) setProperty("char.x", 750) setProperty("char.y", 0) end
	setObjectCamera("char", 'hud')
	if not lowQuality then addLuaSprite("char", false) end
end

function transitionMenu(luaSpr)
	canChangeMenu = false;
	playSound("confirmMenu", 1)
	if lowQuality and luaSpr == "menuImage" then
		onTransition(1)
		return;
	end
	runHaxeCode([[
		FlxFlicker.flicker(game.getLuaObject("]]..luaSpr..[[", false), 1, 0.06, false, false, function(flick)
		{
			game.callOnLuas("onTransition", []);
		});
	]])
	for i = 1, #storyimagePaths do
		doTweenAlpha("fade"..i, storyimagePaths[i], 0, 1 / playbackRate, "")
	end
	cancelTween("fade"..curSelectedOptionUpDown)
end

function onTransition(delay)
	cancelTween("blackScreenIn")
	cancelTween("blackScreenAlpha")
	cancelTween("blackScreenOut")
	cancelTween("blackScreenAlpha")
	cancelTween("blackScreenAlphaOut")
	cancelTimer("delayBlackScreen")
	cancelTimer("loading")
	makeLuaSprite("blackScreenAlpha", "", 0, 0)
	makeGraphic("blackScreenAlpha", 1280, 720, '000000')
	setObjectCamera("blackScreenAlpha", 'other')
	addLuaSprite("blackScreenAlpha", false)
	setProperty("blackScreenAlpha.alpha", 0)
	makeLuaSprite("blackScreen", "", -1280, 0)
	makeGraphic("blackScreen", 1280, 720, '000000')
	setObjectCamera("blackScreen", 'other')
	addLuaSprite("blackScreen", false)
	if delay ~= nil then
		runTimer("delayBlackScreen", delay / playbackRate)
	else
		doTweenX("blackScreenIn", "blackScreen", 0, 0.5 / playbackRate, "")
		doTweenAlpha("blackScreenAlpha", "blackScreenAlpha", 1, 0.5 / playbackRate, "")
	end
	canChangeMenu = false;
end

function onTweenCompleted(tag)
	if tag == "blackScreenAlpha" then
		runTimer("loading", 1 / playbackRate)
	end
	if tag == "blackScreenAlphaOut" then
		removeLuaSprite("blackScreen", true)
		removeLuaSprite("blackScreenAlpha", true)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "delayBlackScreen" then
		doTweenX("blackScreenIn", "blackScreen", 0, 0.5 / playbackRate, "")
		doTweenAlpha("blackScreenAlpha", "blackScreenAlpha", 1, 0.5 / playbackRate, "")
	end
	if tag == "loading" then
		makeLuaSprite("blackScreenAlpha", "", 0, 0)
		makeGraphic("blackScreenAlpha", 1280, 720, '000000')
		setObjectCamera("blackScreenAlpha", 'other')
		addLuaSprite("blackScreenAlpha", false)
		setProperty("blackScreenAlpha.alpha", 1)
		makeLuaSprite("blackScreen", "", 0, 0)
		makeGraphic("blackScreen", 1280, 720, '000000')
		setObjectCamera("blackScreen", 'other')
		addLuaSprite("blackScreen", false)
		doTweenX("blackScreenOut", "blackScreen", screenWidth, 0.5 / playbackRate, "")
		doTweenAlpha("blackScreenAlphaOut", "blackScreenAlpha", 0, 0.5 / playbackRate, "")
		changeState(nextMenu)
		canChangeMenu = true;
	end
end

function storySelect()
	runHaxeCode([[game.getLuaObject("highscoreTxt", true).text = "Highscore: " + Highscore.getScore("]]..storySongs[curSelectedOptionUpDown]..[[", ]]..difficulty..[[);]])
	screenCenter("highscoreTxt", 'x')
	cancelTween("new song")
	setProperty("new song.y", -250)
	cancelTween("long_song")
	setProperty("long_song.x", -275)
	cancelTween("bamb_sign")
	setProperty("bamb_sign.x", 1300)
	if storySongsNew[storySongs[curSelectedOptionUpDown]] == true then
		doTweenY("new song", "new song", 15, 1 / playbackRate, "backOut")
	end
	if storySongsLong[storySongs[curSelectedOptionUpDown]] == true then
		doTweenX("long_song", "long_song", 15, 1 / playbackRate, "backOut")
	end
	if storySongsUpdated[storySongs[curSelectedOptionUpDown]] == true then
		doTweenX("bamb_sign", "bamb_sign", 1065, 1 / playbackRate, "backOut")
	end
	playSound("scrollMenu", 1)
	makeLuaSprite("grad", "grads/"..storySongs[curSelectedOptionUpDown], 0, 0)
	scaleObject("grad", 1.05, 1.05, true)
	screenCenter("grad", 'xy')
	setObjectCamera("grad", 'hud')
	addLuaSprite("grad", false)
	if not lowQuality then setObjectOrder("grad", getObjectOrder("RAPPA_SLAPPA") - 1) else setObjectOrder("grad", getObjectOrder("menuHeader") - 1) end

	if not lowQuality then
		makeLuaSprite("menuImage", "menu/"..storySongs[curSelectedOptionUpDown], getProperty("RAPPA_SLAPPA.x"), getProperty("RAPPA_SLAPPA.y") + 150)
		scaleObject("menuImage", 0.435, 0.435, true)
		screenCenter("menuImage", 'x')
		setObjectCamera("menuImage", 'hud')
		addLuaSprite("menuImage", false)
	end

	makeLuaSprite("menuHeader", "headers/"..storySongs[curSelectedOptionUpDown], 0, -10)
	screenCenter("menuHeader", 'x')
	setObjectCamera("menuHeader", 'hud')
	addLuaSprite("menuHeader", false)

	if not lowQuality then
		makeLuaSprite("songDif", "diff/"..storySongDifs[storySongs[curSelectedOptionUpDown]], screenWidth - 283, 15)
		scaleObject("songDif", 0.5, 0.5, true)
		setObjectCamera("songDif", 'hud')
		addLuaSprite("songDif", false)
	end
end

function changeSelection()
	playSound("scrollMenu")
	runHaxeCode([[
		var curSelected = ]]..curSelectedOptionUpDown..[[;
		var grpSongs = getVar("grpSongs");
		var iconArray = getVar("iconArray");
		var bullShit = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (i in 0...grpSongs.length)
		{
			grpSongs[i].targetY = bullShit - curSelected;
			bullShit++;

			grpSongs[i].alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (grpSongs[i].targetY == 0)
			{
				grpSongs[i].alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	]])
end

local elapsedTime = 0.0;
function onUpdate(elapsed)
	setProperty("fakeMouseMobile.x", getMouseX("hud"))
	setProperty("fakeMouseMobile.y", getMouseY("hud"))
    elapsedTime = elapsedTime + elapsed / 1.2;
	if curState == "mainmenu" then 
		if (keyJustPressed('up') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeUp")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown -1;
			if curSelectedOptionUpDown == 0 then curSelectedOptionUpDown = #storyimagePaths end
			change()
		end
		if (keyJustPressed('down') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeDown")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown +1;
			if curSelectedOptionUpDown > #storyimagePaths then curSelectedOptionUpDown = 1; end
			change()
		end

		for i = 1, (15 * 10) do
			if getProperty("checkeredBG"..i..".x") < (0 - getProperty("checkeredBG"..i..".width") + (325 / 3)) then setProperty("checkeredBG"..i..".x", screenWidth + getProperty("checkeredBG"..i..".width") + (328 * 3.75) - 1.8) end
			if getProperty("checkeredBG"..i..".y") < (0 - getProperty("checkeredBG"..i..".height") + 160 / 2) then setProperty("checkeredBG"..i..".y", screenHeight + getProperty("checkeredBG"..i..".height") + (73.5 * 6) + 38.5) end
			setProperty("checkeredBG"..i..".x", getProperty("checkeredBG"..i..".x") - 0.2)
			setProperty("checkeredBG"..i..".y", getProperty("checkeredBG"..i..".y") - 0.2)
		end
	end
	if curState == "selectionmenu" then
		setProperty("fakeMouse.x", getMouseX("hud"))
		setProperty("fakeMouse.y", getMouseY("hud"))
		if mouseClicked("left") and canChangeMenu then
			if objectsOverlap("fakeMouse", "story") or objectsOverlap("fakeMouse", "extra") or objectsOverlap("fakeMouse", "back") then canChangeMenu = false; end
			if objectsOverlap("fakeMouse", "story") then
				playSound("confirmMenu") 
				nextMenu = "storymenu";
				onTransition(0.45)
			end
			if objectsOverlap("fakeMouse", "extra") then
				playSound("confirmMenu") 
				nextMenu = "extramenu";
				onTransition(0.45)
			end
			if objectsOverlap("fakeMouse", "back") then
				nextMenu = "mainmenu";
				onTransition(0)
			end
		end
		for i = 1, (15 * 10) do
			if getProperty("checkeredBG"..i..".x") < (0 - getProperty("checkeredBG"..i..".width") + (325 / 3)) then setProperty("checkeredBG"..i..".x", screenWidth + getProperty("checkeredBG"..i..".width") + (328 * 2.8) - 45) end
			if getProperty("checkeredBG"..i..".y") < (0 - getProperty("checkeredBG"..i..".height") + 190 / 2) then setProperty("checkeredBG"..i..".y", screenHeight + getProperty("checkeredBG"..i..".height") + (73.5 * 9) + 80) end
			setProperty("checkeredBG"..i..".x", getProperty("checkeredBG"..i..".x") - 0.2)
			setProperty("checkeredBG"..i..".y", getProperty("checkeredBG"..i..".y") - 0.2)
		end
	end
	if curState == "storymenu" then
		setProperty("grad.angle", math.sin(elapsedTime) * 0.65)
		if (keyJustPressed('left') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeLeft")) then
			makeLuaSprite("arrowLeft", "storymenu/arrows/leftArrow_pressed", getProperty("RAPPA_SLAPPA.x") - 175, 0)
			scaleObject("arrowLeft", 0.725, 0.725, true)
			screenCenter("arrowLeft", 'y')
			setProperty("arrowLeft.y", getProperty("arrowLeft.y") + 80)
			setObjectCamera("arrowLeft", 'hud')
			addLuaSprite("arrowLeft", false)
			curSelectedOptionUpDown = curSelectedOptionUpDown -1;
			if curSelectedOptionUpDown == 0 then curSelectedOptionUpDown = #storySongs end
			storySelect()
		end
		if (keyJustPressed('right') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeRight")) then
			makeLuaSprite("arrowRight", "storymenu/arrows/rightArrow_pressed", getProperty("RAPPA_SLAPPA.x") + 550, 0)
			scaleObject("arrowRight", 0.725, 0.725, true)
			screenCenter("arrowRight", 'y')
			setProperty("arrowRight.y", getProperty("arrowRight.y") + 80)
			setObjectCamera("arrowRight", 'hud')
			addLuaSprite("arrowRight", false)
			curSelectedOptionUpDown = curSelectedOptionUpDown +1;
			if curSelectedOptionUpDown > #storySongs then curSelectedOptionUpDown = 1; end
			storySelect()
		end
		if keyReleased('left') then
			makeLuaSprite("arrowLeft", "storymenu/arrows/leftArrow", getProperty("RAPPA_SLAPPA.x") - 175, 0)
			scaleObject("arrowLeft", 0.725, 0.725, true)
			screenCenter("arrowLeft", 'y')
			setProperty("arrowLeft.y", getProperty("arrowLeft.y") + 80)
			setObjectCamera("arrowLeft", 'hud')
			addLuaSprite("arrowLeft", false)
		end
		if keyReleased('right') then
			makeLuaSprite("arrowRight", "storymenu/arrows/rightArrow", getProperty("RAPPA_SLAPPA.x") + 550, 0)
			scaleObject("arrowRight", 0.725, 0.725, true)
			screenCenter("arrowRight", 'y')
			setProperty("arrowRight.y", getProperty("arrowRight.y") + 80)
			setObjectCamera("arrowRight", 'hud')
			addLuaSprite("arrowRight", false)
		end
	end
	if curState == "extramenu" then
		if (keyJustPressed('left') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeLeft")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown -1;
			if curSelectedOptionUpDown == 0 then curSelectedOptionUpDown = #extrasSprs end
			makeLuaSprite("category", "categories/"..extrasSprs[curSelectedOptionUpDown], 0, 0)
			scaleObject("category", 2.5, 2.5, true)
			setObjectCamera("category", 'hud')
			screenCenter("category", 'xy')
			addLuaSprite("category", false)
			playSound("scrollMenu", 1)
		end
		if (keyJustPressed('right') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeRight")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown +1;
			if curSelectedOptionUpDown > #extrasSprs then curSelectedOptionUpDown = 1; end
			makeLuaSprite("category", "categories/"..extrasSprs[curSelectedOptionUpDown], 0, 0)
			scaleObject("category", 2.5, 2.5, true)
			setObjectCamera("category", 'hud')
			screenCenter("category", 'xy')
			addLuaSprite("category", false)
			playSound("scrollMenu", 1)
		end
	end
	if curState == "freeplaymenu" then
		if (keyJustPressed('up') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeUp")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown -1;
			if curSelectedOptionUpDown == -1 then curSelectedOptionUpDown = getProperty("grpSongs.length")-1 end
			changeSelection()
		end
		if (keyJustPressed('down') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "changeDown")) then
			curSelectedOptionUpDown = curSelectedOptionUpDown +1;
			if curSelectedOptionUpDown > getProperty("grpSongs.length")-1 then curSelectedOptionUpDown = 0; end
			changeSelection()
		end
	end
end

function onUpdatePost()
	if luaSoundExists("freakyMenu") ~= true then playSound("freakyMenu", 1, "freakyMenu") end
	if (keyJustPressed('accept') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "confirmButton")) then
		if curState == "mainmenu" then
			if curSelectedOptionUpDown == 1 then
				nextMenu = "selectionmenu"
				transitionMenu(storyimagePaths[curSelectedOptionUpDown])
			end
			if curSelectedOptionUpDown == 2 then
			end
			if curSelectedOptionUpDown == 3 then
			end
			if curSelectedOptionUpDown == 4 then
				runHaxeCode([[CoolUtil.browserLoad("https://discord.com/invite/goldenapple");]])
			end
		end
		if curState == "storymenu" then
			playSound("confirmMenu", 1)
			nextMenu = "startsong"
			transitionMenu("menuImage")
			canChangeMenu = false;
		end
		if curState == "extramenu" then
			playSound("confirmMenu") 
			nextMenu = "freeplaymenu";
			nextFreeplayMenu = extrasSprs[curSelectedOptionUpDown];
			onTransition(0.6)
			doTweenX("backgroundX", "menuBG.scale", 0, 4 / playbackRate, "")
			doTweenY("backgroundY", "menuBG.scale", 0, 4 / playbackRate, "")
			doTweenX("categoryX", "category.scale", 6, 2 / playbackRate, "")
			doTweenY("categoryY", "category.scale", 6, 2 / playbackRate, "")
			canChangeMenu = false;
		end
		if curState == "freeplaymenu" then
			nextMenu = "startsongfreeplay"
			setSoundVolume("freakyMenu", 0.0)
			--soundFadeOut("freakyMenu",1,0)
			onTransition(0)
			canChangeMenu = false;
		end
	end
	if (keyJustPressed('back') and canChangeMenu) or (mouseClicked("left") and objectsOverlap("fakeMouseMobile", "backButton")) then
		if curState == "mainmenu" then runHaxeCode("game.endSong();") end
		if curState == "selectionmenu" then 
			playSound("cancelMenu") 
			nextMenu = "mainmenu";
			onTransition()
		end
		if curState == "storymenu" then
			playSound("cancelMenu")
			nextMenu = "selectionmenu";
			onTransition()
		end
		if curState == "extramenu" then
			playSound("cancelMenu")
			nextMenu = "selectionmenu";
			onTransition()
		end
		if curState == "freeplaymenu" then
			playSound("cancelMenu")
			nextMenu = "extramenu";
			onTransition()
		end
	end

	if keyboardJustPressed("F") then
		runHaxeCode([[PauseSubState.restartSong();]])
	end

	setProperty("camHUD.zoom", 1)
	runHaxeCode([[
		FlxG.sound.music.pause();
		vocals.pause();
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
	]])
end

function createAlphabetSongs(songArray, songArrayIcons)
	local fixedSongArray = "";
	for i = 1, #songArray do
		fixedSongArray = fixedSongArray.."'"..songArray[i];
		if i ~= #songArray then fixedSongArray = fixedSongArray.."',"; end
	end
	fixedSongArray = fixedSongArray.."'";
	local fixedIconArray = "";
	for i = 1, #songArrayIcons do
		fixedIconArray = fixedIconArray.."'"..songArrayIcons[i];
		if i ~= #songArrayIcons then fixedIconArray = fixedIconArray.."',"; end
	end
	fixedIconArray = fixedIconArray.."'";
	runHaxeCode([[
		var songs = []]..fixedSongArray..[[];
		var songicons = []]..fixedIconArray..[[];
		var grpSongs = [];
		var iconArray = [];

		for (i in 0...songs.length)
		{
			var songText = new Alphabet(90, 320, songs[i], true);
			songText.isMenuItem = true;
			songText.targetY = i - 0;
			songText.ID = i;
			songText.camera = game.camHUD;
			game.add(songText);
			grpSongs.push(songText);

			var icon = new HealthIcon(songicons[i]);
			icon.camera = game.camHUD;
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			game.add(icon);
		}

		setVar("grpSongs", grpSongs);
		setVar("iconArray", iconArray);

		//if you became retarded junior, and forgot what to do, use the getvar method to get array and change item properties
	]])
end