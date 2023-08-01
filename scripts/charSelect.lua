--DON'T STEAL KIDS!
--BY JUNIORNOVOA
local nonGappleSongs = {''};

--charSelect
local characters = {'bf', 'pico-player', 'bambi-piss-3d', 'insanidave'};
local charactersSelect = {'bf', 'odd-bf', 'bf-pixel', '3d-bf'}
local curSelected = 1;
local curSelectedVer = 1;
local confirmed = false;

--tweems
tweenArg1 = 1.2;
tweenArg2 = "circInOut";

function onCreatePost()
	if getDataFromSave("Juniors Ports Stuff", "debugMode") or not getDataFromSave("Juniors Ports Stuff", "unfinishedStuff") then
		return;
	end
	
	if stringStartsWith(version, '0.6') then
        addHaxeLibrary('Character')
    else
        addHaxeLibrary('Character', 'objects')
    end

	makeLuaSprite('screenTrans', '', 0, 0)
	makeGraphic('screenTrans', '1280', '720', '000000')
	setObjectCamera("screenTrans", "other")
	updateHitbox("screenTrans")
	screenCenter("screenTrans", 'xy')
	addLuaSprite('screenTrans', true)

	for i = 1, #nonGappleSongs do
		if string.lower(songName) == nonGappleSongs[i] then gappleSONG = false; end
	end
end

--[[function onStartCountdown()
	if not charSelectBool then
		return Function_Continue;
	end

    return Function_Stop;
end--]]

function onCustomSubstateCreate(tag)
	if tag ~= 'charSelect' then return; end
	setProperty('canPause', false)

	makeLuaSprite('mineBGcharSelect', 'extras/mine_bg', 0, 0)
	scaleObject("mineBGcharSelect", 0.75, 0.75, true)
	setObjectCamera("mineBGcharSelect", 'other')
	updateHitbox('mineBGcharSelect')
	screenCenter('mineBGcharSelect')
	addLuaSprite('mineBGcharSelect', false)

	for i = 1, #characters do
		runHaxeCode([[
			var ]]..('char'..i)..[[ = new Character(835, 325, ']]..characters[i]..[[');
			]]..('char'..i)..[[.camera = game.camOther;
			]]..('char'..i)..[[.visible = false;
			]]..('char'..i)..[[.flipX = false;
			]]..('char'..i)..[[.scale.set(0.9, 0.9);
			game.add(]]..('char'..i)..[[);
			game.modchartSprites.set(']]..('char'..i)..[[', ]]..('char'..i)..[[);
		]])
		playAnim('char'..i, "idle", true)
	end

	for i = 1, #charactersSelect do
		local strCharName = 'BFchar'..i;
		runHaxeCode([[
			var ]]..strCharName..[[ = new Character(835, 325, ']]..charactersSelect[i]..[[');
			]]..strCharName..[[.camera = game.camOther;
			]]..strCharName..[[.visible = false;
			]]..strCharName..[[.flipX = false;
			]]..strCharName..[[.scale.set(]]..strCharName..[[.scale.x - 0.1, ]]..strCharName..[[.scale.y - 0.1);
			game.add(]]..strCharName..[[);
			game.modchartSprites.set(']]..strCharName..[[', ]]..strCharName..[[);
		]])
		playAnim(strCharName, "idle", true)
	end
	setObjectOrder("screenTrans", 99)
	doTweenX("screenTrans", "screenTrans", screenWidth, tweenArg1, tweenArg2)
end

function onCustomSubstateUpdate(tag, elapsed)
	if tag ~= 'charSelect' then return; end

	if luaSoundExists('charSelectSound') == false then
		playSound("character_select", 1, "charSelectSound")
	end

	setProperty("cpuControlled", true)
	runHaxeCode([[FlxG.sound.music.pause();]])
	runHaxeCode([[game.vocals.pause();]])
	runHaxeCode([[game.setSongTime(0)]])
	runHaxeCode([[FlxG.sound.music.pause();]])
	runHaxeCode([[game.vocals.pause();]])

	if not confirmed then
		for i = 1, #characters do
			setProperty('char'..i..'.visible', false)
		end
		for i = 1, #charactersSelect do
			setProperty('BFchar'..i..'.visible', false)
		end
		if curSelected == 1 then
			setProperty('BFchar'..curSelectedVer..'.visible', true)
		else
			setProperty('char'..curSelected..'.visible', true)
		end
	end
	
	if keyJustPressed('left') and not confirmed then
		curSelectedVer = 1;
		curSelected = curSelected - 1;
		if curSelected == 0 then
			curSelected = #characters;
		end
	end
	if keyJustPressed('right') and not confirmed then
		curSelectedVer = 1;
		curSelected = curSelected + 1;
		if curSelected == #characters +1 then
			curSelected = 1;
		end
	end
	if keyJustPressed('up') and not confirmed and curSelected == 1 then
		curSelectedVer = curSelectedVer +1;
		if curSelectedVer == #charactersSelect +1 then
			curSelectedVer = 1;
		end
	end
	if keyJustPressed('down') and not confirmed and curSelected == 1 then
		curSelectedVer = curSelectedVer -1;
		if curSelectedVer == 0 then
			curSelectedVer = #charactersSelect;
		end
	end
	
	if keyJustPressed('accept') and not confirmed then
		local posBF = {getProperty("boyfriend.x"), getProperty("boyfriend.y")}
		local bfSCALE = {getProperty("boyfriend.width"), getProperty("boyfriend.height")}
		if curSelected == 1 then
			playAnim(charactersSelect[curSelectedVer], "hey", false)
			triggerEvent("Change Character", 'bf', charactersSelect[curSelectedVer])
		else
			playAnim(characters[curSelected], "hey", false)
			triggerEvent("Change Character", 'bf', characters[curSelected])
		end
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
	if tag == 'soundchar' then
		setProperty("screenTrans.x", -screenWidth)
		doTweenX("screenTransOut", "screenTrans", 0, tweenArg1, tweenArg2)
	end

	if tag == 'soundchar2' then
		doTweenX("screenTransFinale", "screenTrans", screenWidth, tweenArg1, tweenArg2)
		removeLuaSprite("mineBGcharSelect", true)
		for i = 1, #characters do
			setProperty('char'..i..'.visible', false)
		end
		for i = 1, #charactersSelect do
			setProperty('BFchar'..i..'.visible', false)
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'screenTransOut' then
		runTimer("soundchar2", 1)
	end

	if tag == 'screenTransFinale' then
		removeLuaSprite("screenTrans", true)
		closeCustomSubstate()
		setProperty("cpuControlled", false)
		runHaxeCode([[
			FlxG.sound.music.time = 0;
			game.vocals.time = 0;
			//game.setSongTime(Conductor.crochet * 5);
		]])
		setProperty('canPause', true)
		callOnLuas('onDialogueReadyChar', {})
	end
end