--don't judge how shitty this script is, i made this when i first started lua coding, and im to lazy to remake this entire damn thing.
local alphaChange = false;
local bfX = 0;
local bfY = 0;
local dadX = 0;
local dadY = 0;
local zoomStuff = 0.05;

local stayOnCam = false;
local camX = 0;
local camY = 0;

local loopVarThing = false;

function onBadaiCreate()
	setProperty("badai.visible", false)
end

function onCreatePost()
	removeLuaSprite("thunderBlack", true)
	setProperty("fpsTxt.visible", false)
	setPropertyFromClass("Main", "fpsVar.visible", true)
	setProperty('creditsWatermark.visible', false)
	setProperty("healthBarBGnew.visible", false)
	setProperty('timeBarBG.visible', true)
	setProperty('timeBar.visible', true)
	setTextFont('scoreTxt', 'vcr.ttf')
	setTextFont('timeTxt', 'vcr.ttf')
	dadX = getProperty('dad.x');
	dadY = getProperty('dad.y') -125;
end

local elapsed2 = 0.0;
function onUpdate(elapsed)
	elapsed2 = elapsed2 + elapsed;
	if alphaChange then
		setProperty("dad.alpha", math.sin(elapsed2 * 2.5))
	end

	if stayOnCam then
		setProperty('camFollow.x', camX);
		setProperty('camFollow.y', camY);
	end
end

function onStepHit()
	if curStep == 1088 then
		doTweenY('banduFat', 'dad', getProperty('dad.y') -500, 30)
	end

	if curStep == 1855 then
		--unused
		--dadX = getProperty('dad.x');
		--dadY = getProperty('dad.y');
	end

	--[[local zoomStuff = 0.05;

	if curStep == 3200 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') -zoomStuff)
		removeLuaSprite('garryLeak', true)
		setProperty('r2.visible', true)
		alphaChange = true;
	end--]]

	if curStep == 5087 then --5088
		--[[
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') +zoomStuff)
		setProperty('th1ft.visible', true)
		removeLuaSprite('r1', true)
		removeLuaSprite('r2', true)
		alphaChange = false;
		setProperty('dad.alpha', 1)
		--]]
		--setProperty('dad.y' -9999) --3d leak bambi would keep showing
	end

	if curStep == 5744 then
		--youtoob
	end

	if curStep == 6848 then
		--funk
	end

	--6:39
	--6:39
	--6:39
	--6:39
	--6:39

	if curStep == 7488 then
		--portal
		makeLuaSprite('portal', 'iykyk/appleLeak/cave/portal', getProperty('boyfriend.x') + 310, getProperty('boyfriend.y') + 310)
		setProperty('portal.scale.x', 0)
		setProperty('portal.scale.y', 0)
		updateHitbox('portal')
		if not lowQuality then
			addLuaSprite('portal', true)
		end
		setProperty('portal.scale.x', 1)
		setProperty('portal.scale.y', 1)
		doTweenX('null1', 'portal.scale', 0, 1)
		doTweenY('invisPortal', 'portal.scale', 0, 1)
		doTweenX('null3', 'boyfriend.scale', 0, 1)
		doTweenY('null4', 'boyfriend.scale', 0, 1)
	end

	if curStep == 9520 then --3d and 2d
		makeAnimatedLuaSprite('staticAnim', 'iykyk/appleLeak/dookie/give_me_all_your_zunk', -175, -100)
		setObjectCamera("staticAnim", 'hud')
		setObjectOrder("staticAnim", 0)
		setScrollFactor('staticAnim', 0, 0)
		addAnimationByPrefix('staticAnim', 'idle', 'static0', 24, true)
		playAnim('staticAnim', 'idle', true)
		addLuaSprite('staticAnim', true)
		setProperty("fire.visible", false)
		setProperty("vg.visible", false)
		runTimer('static2', 1.1)
	end

	if curStep == 9696 then --3d bamber
		setProperty("badai.visible", false)
		--removeLuaSprite("badai", true)
		removeLuaSprite("2dThing", true)
		removeLuaSprite("blackNwhite", true)
	
		setProperty("staticAnim.visible", true)
		runTimer('static', 1.1)
	end

	if curStep == 10096 then --wide bambi
		setProperty("staticAnim.visible", true)
		setProperty("fire.visible", false)
		setProperty("vg.visible", false)
		runTimer('static3', 1.2)
	end

	if curStep == 10256 then --so screwed
		removeLuaSprite("deadMeme", true)
		setProperty("staticAnim.visible", true)
		runTimer('static4', 1.25)
	end

	if curStep == 10464 then --3d bamber
		removeLuaSprite("tiles", true)
		removeLuaSprite("overlay", true)
		removeLuaSprite("platform", true)
		setProperty("staticAnim.visible", true)
		runTimer('static', 1.25)
	end

	if curStep == 10864 then --amog us
		setProperty("staticAnim.visible", true)
		setProperty("fire.visible", false)
		setProperty("vg.visible", false)
		runTimer('static5', 1.25)
	end

	if curStep == 11152 then --bob
		removeLuaSprite("space", true)
		removeLuaSprite("backgroundShip", true)
		removeLuaSprite("shipFloor", true)
		removeLuaSprite("tables", true)
		removeLuaSprite("screenshot", true)
		setProperty("staticAnim.visible", true)
		runTimer('static6', 1.25)
	end

	if curStep == 11424 then --3d bamber
		removeLuaSprite("NewTitleMenuBG", true)
		removeLuaSprite("trees", true)
		setProperty("staticAnim.visible", true)
		runTimer('static', 1.25)
	end

	if curStep == 11952 then --dik cord
		setProperty("fire.visible", false)
		setProperty("vg.visible", false)
		makeLuaSprite("discordBackground", "", 0, 0)
		makeGraphic("discordBackground", 1280 * 1.5, 720 * 1.5, '000000')
		setScrollFactor("discordBackground", 0, 0)
		screenCenter("discordBackground", 'xy')
		addLuaSprite("discordBackground", true)
	
		makeAnimatedLuaSprite("discord", "iykyk/appleLeak/dookie/goodbyeDooDoo", 0, 0)
		addAnimationByPrefix("discord", "discord", "leave", 24, false)
		setScrollFactor("discord", 0, 0)
		screenCenter("discord", 'xy')
		addLuaSprite("discord", true)
		--setProperty("defaultCamZoom", 0.9)
	end
end


function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'static' then
		setProperty('defaultCamZoom', 0.8)
		triggerEvent("Change Character", "bf", "shoulder-bf")
		triggerEvent("Change Character", "dad", "3d-bambi-leak-finale")
		setProperty("staticAnim.visible", false)
		setProperty("fire.visible", true)
		setProperty("vg.visible", true)
	end

	if tag == 'static2' then
		setProperty("staticAnim.visible", false)

		triggerEvent("Change Character", "bf", "bf")
		triggerEvent("Change Character", "dad", "cheating-4-leak")
		setProperty("boyfriend.color", getColorFromHex("FFFFFF"))
		makeLuaSprite('blackNwhite', 'iykyk/appleLeak/dookie/bgs/2d-and-3d/ying and yang makes a comeback', 0, 0)
		screenCenter("blackNwhite", 'xy')
		setProperty("blackNwhite.flipX", true)
		addLuaSprite('blackNwhite', false)
	
		screenCenter("boyfriend", 'xy')
		setProperty("boyfriend.x", getProperty("boyfriend.x") - 75)
		setProperty("dad.x", getProperty("boyfriend.x") - 500)
		setProperty("dad.y", getProperty("boyfriend.y") - 285)
		setProperty("badai.x", getProperty("boyfriend.x") + 500)
		setProperty("badai.y", getProperty("boyfriend.y") - 235)
		setProperty("badai.visible", true)
		setProperty("defaultCamZoom", 0.75)
	
		makeAnimatedLuaSprite('2dThing', 'iykyk/appleLeak/dookie/fixed i things', 0, 0)
		setScrollFactor('2dThing', 0, 0)
		scaleObject("2dThing", 1.3, 1.3, true)
		updateHitbox("2dThing")
		screenCenter("2dThing", 'xy')
		addAnimationByPrefix('2dThing', 'idle', 'Symbol 1', 24, true)
		playAnim('2dThing', 'idle', true)
		addLuaSprite('2dThing', true)
	end

	if tag == 'static3' then
		setProperty("staticAnim.visible", false)
		triggerEvent("Change Character", "bf", "bf")
		triggerEvent("Change Character", "dad", "doodoo-wide")
		makeLuaSprite('deadMeme', 'iykyk/appleLeak/dookie/dead_meme_but_it_funny', 0, 0)
		screenCenter("deadMeme", 'xy')
		addLuaSprite('deadMeme', false)
		setProperty("dad.x", getProperty("deadMeme.x") + 125)
		setProperty("dad.y", getProperty("deadMeme.y") + 150)
		setProperty("boyfriend.visible", false)
		setProperty("defaultCamZoom", 1.25)
	end

	if tag == 'static4' then
		setProperty("staticAnim.visible", false)
		triggerEvent("Change Character", "bf", "bf-screwed")
		triggerEvent("Change Character", "dad", "doodoo-screwed")
		makeLuaSprite("tiles", "iykyk/appleLeak/lmfao/tiles", 0, 0)
		screenCenter("tiles", 'xy')
		addLuaSprite("tiles", false)
		makeLuaSprite("overlay", "iykyk/appleLeak/lmfao/overlay", 0, 0)
		scaleObject("overlay", 1.1, 1.1, true)
		screenCenter("overlay", 'xy')
		if not lowQuality then addLuaSprite("overlay", false) end
		makeLuaSprite("platform", "iykyk/appleLeak/lmfao/platform", 0, 0)
		screenCenter("platform", 'xy')
		setProperty("platform.y", getProperty("platform.y") + 650)
		addLuaSprite("platform", false)
		setProperty("boyfriend.x", getProperty("platform.x") + 1185)
		setProperty("boyfriend.y", getProperty("platform.y") - 250)
		setProperty("dad.x", getProperty("platform.x") + 200)
		setProperty("dad.y", getProperty("platform.y") - 425)
		setProperty("defaultCamZoom", 0.6)
	end

	if tag == 'static5' then
		setProperty("staticAnim.visible", false)
		triggerEvent("Change Character", "bf", "bf")
		triggerEvent("Change Character", "dad", "doodoo-impostor")
		setProperty("boyfriend.visible", true)
	
		makeLuaSprite("space", "iykyk/appleLeak/clowofe/spaceThing", 0, 0)
		screenCenter("space", 'xy')
		if not lowQuality then addLuaSprite("space", false) end
		makeLuaSprite("backgroundShip", "iykyk/appleLeak/clowofe/backgrounder", 0, 0)
		screenCenter("backgroundShip", 'xy')
		addLuaSprite("backgroundShip", false)
		makeLuaSprite("shipFloor", "iykyk/appleLeak/clowofe/grounde", 0, 0)
		screenCenter("shipFloor", 'xy')
		addLuaSprite("shipFloor", false)
		makeLuaSprite("tables", "iykyk/appleLeak/clowofe/tableThings", 0, 0)
		screenCenter("tables", 'xy')
		if not lowQuality then addLuaSprite("tables", false) end

		makeLuaSprite("screenshot", "iykyk/appleLeak/clowofe/importerman", 0, 0)
		setScrollFactor("screenshot", 0.0, 0.0)
		scaleObject("screenshot", 1.75, 1.75, true)
		updateHitbox("screenshot")
		screenCenter("screenshot", 'xy')
		addLuaSprite("screenshot", true)
		doTweenAlpha("screenshot", "screenshot", 0, 1, "")
	
		setProperty("tables.y", getProperty("tables.y") - 235)
		setProperty("backgroundShip.y", getProperty("backgroundShip.y") - 775)
		setProperty("space.y", getProperty("backgroundShip.y"))
	
		setProperty("boyfriend.x", getProperty("tables.x") + 1100)
		setProperty("boyfriend.y", getProperty("tables.y") - 200)
		setProperty("dad.x", getProperty("tables.x") + 200)
		setProperty("dad.y", getProperty("tables.y") - 460)
	
		setProperty("defaultCamZoom", 0.7)
	end

	if tag == 'static6' then
		setProperty("staticAnim.visible", false)
		triggerEvent("Change Character", "bf", "bf")
		triggerEvent("Change Character", "dad", "doodoo-bob")
	
		makeAnimatedLuaSprite("NewTitleMenuBG", "iykyk/appleLeak/dookie/doodlebob/NewTitleMenuBG", 0, 0)
		addAnimationByPrefix("NewTitleMenuBG", "idle", "TitleMenuSSBG instance 1", 24, true)
		scaleObject("NewTitleMenuBG", 5, 5, true)
		updateHitbox("NewTitleMenuBG")
		screenCenter("NewTitleMenuBG", 'xy')
		if not lowQuality then addLuaSprite("NewTitleMenuBG", false) end
		setProperty("NewTitleMenuBG.y", getProperty("NewTitleMenuBG.y") - 200)
	
		makeLuaSprite("tress", "iykyk/appleLeak/dookie/doodlebob/doodlebob tree", 0, 0)
		scaleObject("tress", 1.5, 1.5, true)
		updateHitbox("tress")
		screenCenter("tress", 'xy')
		addLuaSprite("tress", false)
	
		setProperty("dad.x", getProperty("tress.x") + 450)
		setProperty("dad.y", getProperty("tress.y") - 100)
		setProperty("boyfriend.x", getProperty("tress.x") + 950)
		setProperty("boyfriend.y", getProperty("tress.y") + 50)
		setProperty("defaultCamZoom", 0.9)
	end
end

function onEvent(name, value1, value2)
	if name == 'Change Character' then
		if value2 == 'fat-bandu-3d' then
			cancelTween('banduFat')
			setProperty("dad.x", dadX)
			setProperty("dad.y", dadY)
			setProperty('wavyApplecore.visible', true)
			setProperty('wavyApplecoreBLACK.visible', true)
			setProperty('defaultCamZoom', 0.9)
		end

		if value2 == 'gary' then
			makeAnimatedLuaSprite('fatBandu', 'characters/appleLeak/fat_bandu_25', dadX, dadY)
			addAnimationByPrefix('fatBandu', 'idle', 'idle0', 24, false)
			playAnim('fatBandu', 'idle', true)
			if not lowQuality then
				addLuaSprite('fatBandu', false)
			end
	
			doTweenX('gasStationWidth', 'gasStation.scale', 0, 1)
			doTweenY('gasStationHeigth', 'gasStation.scale', 0, 1)
			doTweenAlpha('gasStationAlpha', 'gasStation', 0, 1)
	
			doTweenX('wavyWidth', 'wavyApplecore.scale', 0, 1)
			doTweenY('wavyHeigth', 'wavyApplecore.scale', 0, 1)
			doTweenAlpha('wavyAlpha', 'wavyApplecore', 0, 1)
			doTweenX('wavyWidt2h', 'wavyApplecoreBLACK.scale', 0, 1)
			doTweenY('wavyHeigth2', 'wavyApplecoreBLACK.scale', 0, 1)
			doTweenAlpha('wavyAlph2a', 'wavyApplecoreBLACK', 0, 1)

			doTweenAlpha('fatBandunAlpha', 'fatBandu', 0, 1)
			doTweenAlpha('jamboulAlpha', 'jamboul', 0, 1)
	
			doTweenY('kineMasterUp', 'kineMaster', getProperty('kineMaster.y') -125, 1.25)
			doTweenAngle('kineMasterAngle', 'kineMaster', 90, 1.5)
		end

		if value2 == '3d-bambi-leak' then
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') -zoomStuff)
			setProperty("dad.x", dadX)
			setProperty("dad.y", dadY - 200)
			removeLuaSprite('garryLeak', true)
			setProperty('r2.visible', true)
			alphaChange = true;
		end

		if value2 == 'th1ft' then
			zoomStuff = zoomStuff + 0.15;
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') +zoomStuff)
			setProperty("dad.x", dadX -400)
			setProperty("dad.y", dadY -35)
			removeLuaSprite('r1', true)
			removeLuaSprite('r2', true)
			setProperty('th1ft.visible', true)
			alphaChange = false;
			setProperty('dad.alpha', 1)

			bfX = getProperty('boyfriend.x');
			bfY = getProperty('boyfriend.y');
		end

		if value2 == 'th1ft-monster' then
			setProperty("dad.x", dadX -400)
			setProperty("dad.y", dadY -35)
		end

		if value2 == 'bandu-trolled' then
			setProperty('ytVids.scale.x', 2)
			setProperty('ytVids.scale.y', 2)
			doTweenX('ytVidsWidth', 'ytVids.scale', 1, 1)
			doTweenY('ytVidsHeigth', 'ytVids.scale', 1, 1)
			camX = getProperty('camFollow.x');
			camY = getProperty('camFollow.y');
			stayOnCam = true;

			setProperty("dad.x", 25)
			setProperty("dad.y", 1290)
			
			setProperty('boyfriend.x', 1250)
			setProperty('boyfriend.y', 1550)
			makeLuaSprite('boyfond', 'iykyk/appleLeak/trolled/boyfranon', bfX, bfY)
			addLuaSprite('boyfond', false)

			setProperty('ytStatic.visible', true)
			setProperty('ytBox.visible', true)
		end

		if value2 == 'sammy' then
			setProperty('funkipedia.visible', true)
			setProperty("dad.x", 1660)
			setProperty("dad.y", 2070)
			setProperty('boyfriend.x', getProperty("funkipedia.x") + 1350)
			setProperty('boyfriend.y', getProperty("funkipedia.y") + 475)
			setProperty('boyfriend.scale.x', getProperty("boyfriend.scale.x") - 0.2)
			setProperty('boyfriend.scale.y', getProperty("boyfriend.scale.y") - 0.2)
		end

		if value2 == 'duelExpunged' then
			setProperty('defaultCamZoom', 0.8)
			removeLuaSprite('funkipedia', true)
			removeLuaSprite('ytStatic', true)
			removeLuaSprite('ytBox', true)
			makeLuaSprite('caveBG', 'iykyk/appleLeak/cave/caveBG', -750, 100)
			setProperty('caveBG.scale.x', 2.25)
			setProperty('caveBG.scale.y', 2.25)
			updateHitbox('caveBG')
			addLuaSprite('caveBG', false)
		
			makeAnimatedLuaSprite('brob', 'iykyk/appleLeak/cave/brob', getProperty('caveBG.x') +1925, getProperty('caveBG.y') + 575)
			addAnimationByPrefix('brob', 'idle', 'brob0', 24, false)
			playAnim('brob', 'idle', true)
			setProperty('brob.scale.x', 0.5)
			setProperty('brob.scale.y', 0.5)
			updateHitbox('brob')
			if not lowQuality then
				addLuaSprite('brob', false)
			end
		
			makeAnimatedLuaSprite('monkey', 'iykyk/appleLeak/cave/monkey', getProperty('caveBG.x') +1590, getProperty('caveBG.y') + 425)
			addAnimationByPrefix('monkey', 'idle', 'monkey0', 24, false)
			playAnim('monkey', 'idle', true)
			setProperty('monkey.scale.x', 0.35)
			setProperty('monkey.scale.y', 0.35)
			updateHitbox('monkey')
			if not lowQuality then
				addLuaSprite('monkey', false)
			end
		
			makeAnimatedLuaSprite('ohyeah', 'iykyk/appleLeak/cave/ohyeah', getProperty('caveBG.x') +950, getProperty('caveBG.y') + 500)
			addAnimationByPrefix('ohyeah', 'idle', 'ohyeah0', 24, false)
			playAnim('ohyeah', 'idle', true)
			--setProperty('ohyeah.scale.x', 0.75)
			--setProperty('ohyeah.scale.y', 0.75)
			updateHitbox('ohyeah')
			if not lowQuality then
				addLuaSprite('ohyeah', false)
			end
		
			makeAnimatedLuaSprite('wrath', 'iykyk/appleLeak/cave/wrath', getProperty('caveBG.x') +475, getProperty('caveBG.y') + 500)
			addAnimationByPrefix('wrath', 'idle', 'wrath0', 24, false)
			playAnim('wrath', 'idle', true)
			setProperty('wrath.scale.x', 0.5)
			setProperty('wrath.scale.y', 0.5)
			updateHitbox('wrath')
			if not lowQuality then
				addLuaSprite('wrath', false)
			end
		
			makeLuaSprite('caveFloor', 'iykyk/appleLeak/cave/caveGround', getProperty('caveBG.x') +300, getProperty('caveBG.y') + 350)
			setProperty('caveFloor.scale.x', 1.75)
			setProperty('caveFloor.scale.y', 1.75)
			updateHitbox('caveFloor')
			addLuaSprite('caveFloor', false)
		
			makeAnimatedLuaSprite('norman', 'iykyk/appleLeak/cave/norman', getProperty('caveFloor.x') + 950, getProperty('caveFloor.y') + 110)
			addAnimationByPrefix('norman', 'idle', 'idle0', 24, false)
			playAnim('norman', 'idle', true)
			setProperty('norman.scale.x', 0.25)
			setProperty('norman.scale.y', 0.25)
			updateHitbox('norman')
			if not lowQuality then
				addLuaSprite('norman', false)
			end

			setProperty("dad.x", -300)
			setProperty("dad.y", 350)
			setProperty('boyfriend.x', 800)
			setProperty('boyfriend.y', 435) --765

			setProperty("boyfriend.color", getColorFromHex("0xFF878787"))
			setProperty("norman.color", getColorFromHex("0xFF878787"))

			setProperty('portal.visible', true)
			setProperty('portal.x', getProperty('boyfriend.x') + 200)
			setProperty('portal.y', getProperty('boyfriend.y') + 200)
			local prevScale = getProperty("boyfriend.scale.x") + 0.2
			setProperty('boyfriend.scale.x', 0)
			setProperty('boyfriend.scale.y', 0)

			doTweenX('portalWidth', 'portal.scale', 1, 1)
			doTweenY('portalHeight', 'portal.scale', 1, 1)
			doTweenX('portalBFWidth', 'boyfriend.scale', prevScale, 1)
			doTweenY('portalBFHeight', 'boyfriend.scale', prevScale, 1)
		end

		if value2 == '3d-bambi-leak-finale' then
			if loopVarThing == false then
				setProperty("fpsTxt.visible", true)
				setPropertyFromClass("Main", "fpsVar.visible", false)
				addLuaScript("scripts/gappleScripts/Gapple Bop", true)
				callScript("scripts/gappleScripts/Gapple Bop", "onCreatePost")
				setProperty('creditsWatermark.visible', true)
				setProperty("healthBarBGnew.visible", true)
				setProperty('timeBarBG.visible', false)
				setProperty('timeBar.visible', false)
				setTextFont('scoreTxt', 'comic.ttf')
				setTextFont('timeTxt', 'comic.ttf')
				removeLuaSprite('caveBG', true)
				removeLuaSprite('brob', true)
				removeLuaSprite('monkey', true)
				removeLuaSprite('ohyeah', true)
				removeLuaSprite('wrath', true)
				removeLuaSprite('caveFloor', true)
				removeLuaSprite('norman', true)
				removeLuaSprite("portal", true)
				makeAnimatedLuaSprite('fire', 'iykyk/appleLeak/dookie/FLAMESFLAMESBURNINGFLAMES', 50, -100)
				addAnimationByPrefix('fire', 'idle', 'FlamesBurn0', 24, true)
				playAnim('fire', 'idle', true)
				setProperty('fire.antialiasing', false)
				setProperty('fire.scale.x', 1.8)
				setProperty('fire.scale.y', 1.5)
				setProperty('fire.alpha', 0.75)
				updateHitbox('fire')
				--screenCenter('fire')
				if not lowQuality then
					addLuaSprite('fire', true) -- 250, -315
				end
				
				addLuaScript('activatedScripts/VG');
				setProperty('vg.visible', true)
				setProperty('dad.x', 250)
				setProperty('dad.y', -315)
				setProperty('dad.visible', false)
				setProperty('camHUD.visible', false)
				camX = 1290;
				camY = 450;
				stayOnCam = true;

				setProperty('boyfriend.y', getProperty('boyfriend.y') - 950)
				doTweenY('boyfrinedYYY', 'boyfriend', getProperty('boyfriend.y') + 680, 1.5)
				loopVarThing = true;
			else
				--setProperty('boyfriend.y', getProperty('boyfriend.y') - 950 + 680)
				setProperty('dad.x', 250)
				setProperty('dad.y', -315)
			end
		end

		if value2 == 'duel-cheating-bambi-leak' then
			--1 second static
		end

		if value2 == 'wide-bambi-leak' then
			--2 second static
		end

		if value2 == 'screwed-bambi-leak' then
			--2 second static
		end
		
		if value2 == 'among-bambi' then
			--2 second static
		end

		if value2 == 'bob-bambi-leak' then
			--2 second static
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'jamboulAlpha' then
		doTweenX('garyMoveX', 'dad', dadX, 1.5)
		doTweenY('garyMoveY', 'dad', dadY, 1.5)
	end

	if tag == 'kineMasterAngle' then
		doTweenY('kineMasterDown', 'kineMaster', 1000, 2.6)
		doTweenAngle('kineMasterAngle2', 'kineMaster', 125, 2.6)
	end

	if tag == 'kineMasterAngle2' then
		removeLuaSprite('jamboul', true)
		removeLuaSprite('fatBandu', true)
		removeLuaSprite('gasStation', true)
		removeLuaSprite('wavyApplecore', true)
		removeLuaSprite("wavyApplecoreBLACK", true)
		removeLuaSprite('kineMaster', true)
	end

	if tag == 'ytVidsHeigth' then
		doTweenAngle('boyfondAngle', 'boyfond', 10, 0.2)
	end

	if tag == 'boyfondAngle' then
		doTweenAngle('boyfondAngle2', 'boyfond', 120, 1)
		doTweenAlpha('boyfondAlpha', 'boyfond', 0, 1)
	end

	if tag == 'boyfondAlpha' then
		removeLuaSprite('boyfond', true)
		stayOnCam = false;
	end

	if tag == 'invisPortal' then
		setProperty('portal.visible', false)
	end

	if tag == 'portalBFHeight' then
		doTweenY('null5', 'boyfriend', 680, 1)
		doTweenX('null1', 'portal.scale', 0, 1)
		doTweenY('invisPortal', 'portal.scale', 0, 1)
	end
end

local POP = false;
local POP2 = false;
local POP3 = false;

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'bandu-trolled' and not POP then
		doTweenX('dadWidth', 'dad.scale', 0.3, 0.35)
		doTweenY('dadHeigth', 'dad.scale', 0.3, 0.35)
		removeLuaSprite('ytVids', true)
		removeLuaSprite('th1ft', true)
		POP = true;
	end

	if getProperty('dad.curCharacter') == '3d-bambi-leak-finale' and not POP2 then
		setProperty('camHUD.zoom', 5)
		doTweenZoom("outCameZOom", "camHUD", 0.8, 1.5, "")
		setProperty('camHUD.visible', true)
		triggerEvent("camFlash", '0.5', '')
		setProperty('dad.visible', true)
		stayOnCam = false;
		POP2 = true;
	end

	setProperty("2dThing.visible", false)

	if getProperty('dad.curCharacter') == 'among-bambi' and not POP3 then
		--flash twitter post
	end
end