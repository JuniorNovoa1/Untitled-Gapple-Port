 --DON'T STEAL KIDS!
--BY JUNIORNOVOA

local song = '';
local dialogueLines = {} --heres how it goes!! : dialogue, isBF, charImage(located in "dialogue/")
local offsets = {0, 0, 0, 0}
local curDialogue = 1;
local maxDialogue = 1;
local dialogueBool = false;
local inDialogue = false;
local crazyBubble = false;
function onCreate()
	if string.lower(songName) == 'disruption' then
		dialogueLines = { --heres how it goes!! : dialogue, isBF, charImage(located in "dialogue/")
			{'THERE YOU ARE!!!', false, 'disruption_port'},
			{'Beep?', true, 'bf_compuzzled_port'},
			{'DAVE SENT ME TO GET YOU!!!', false, 'disruption_port'},
			{'SAYS YOU NOT ALLOWED HERE!!!', false, 'disruption_port'},
			{'Bap!', true, 'bf_compuzzled_port'},
			{'YOU GONNA DISRUPT THIS 3D WORLD!!!!!', false, 'disruption_port'}
		}
		crazyBubble = true;
		song = 'disruptionCutscene';
	end
	if string.lower(songName) == 'applecore' then
		dialogueLines = {
			{'Howdy!', false, 'bandu_port'},
			{'Bop?', true, 'bf_reg_port'},
			{'Can I show you something?', false, 'bandu_port'},
			{'Bep!', true, 'bf_reg_port'},
			{'Check this out!', false, 'bandu_port'},
			{"I got lots o' phones!", false, 'bandu_port'},
			{'Neat, huh?', false, 'bandu_port'},
			{'Boop!', true, 'bf_reg_port'},
			{'Ooh, is that a microphone?', false, 'bandu_port'},
			{'Are you a singer?', false, 'bandu_port'},
			{'Beep!', true, 'bf_reg_port'},
			{'Wanna sing?', false, 'bandu_port'},
			{'Brap', true, 'bf_reg_port'}
		}
		song = 'applecoreCutscene';
	end
	if string.lower(songName) == 'disability' then
		dialogueLines = {
			{'So, you got past Bambi?', false, 'disable_port'},
			{'Beep.', true, 'bf_reg_port'},
			{"Guess I'll have to do everything myself.", false, 'disable_port'},
			{'I can control the 3D world better than I thought I could.', false, 'disable_port'},
			{"We'll sing one song.", false, 'disable_port'},
			{'I win, you leave.', false, 'disable_port'},
			{"You win, I'll let you be.", false, 'disable_port'},
			{'Bap!', true, 'bf_reg_port'}
		}
		song = 'disabilityDialogue';
	end
	if string.lower(songName) == 'wireframe' then
		dialogueLines = {
			{"ALRIGHT, THAT IS IT!", false, 'decimated_dave_port'},
			{"NO MORE FOOLING AROUND!", false, 'decimated_dave_port'},
			{"Beep?!", true, 'bf_reg_port'},
			{"FIRST, YOU COME HERE WITHOUT A CARE IN THE WORLD..", false, 'decimated_dave_port'},
			{"AND WHEN I TRY TO STOP YOU, YOU CAUSE ALL OF THESE PROBLEMS!", false, 'decimated_dave_port'},
			{"DO YOU EVEN KNOW WHAT YOU'RE DOING?!", false, 'decimated_dave_port'},
			{"IF YOU REALLY THINK YOU CAN JUST BE HERE WITH NO CONSEQUENCES..", false, 'decimated_dave_port'},
			{"YOU ARE DEAD WRONG!", false, 'decimated_dave_port'},
			{"THIS IS YOUR LAST CHANCE TO LEAVE.", false, 'decimated_dave_port'},
			{"Bap!", true, 'bf_reg_port'}
		}
		song = 'wireframeCutscene';
		crazyBubble = true;
	end
	if string.lower(songName) == 'algebra' then --DIALOGIUE
		dialogueLines = {
			{"Hey there!", false, 'og_port'},
			{"Welcome to my school!", false, 'og_port'},
			{"People don't visit me often, So I'm glad you're here!", false, 'og_port'},
			{"Beep!", true, 'bf_reg_port'},
			{"Don't worry about my disability, I can get around myself.", false, 'og_port'},
			{"Bap!", true, 'bf_reg_port'}
		}
		song = 'DaveDialogue';
	end
	if string.lower(songName) == 'jambino' then
		dialogueLines = {
			{"beep?!", true, 'bf_reg_port'},
			{"Welcome, Boyfriend!", false, 'jambi_port'},
			{"I’m Jambi! Your former personal assistant!", false, 'jambi_port'},
			{"Because now you’re in MY hard drive, I get to be the host of this system!", false, 'jambi_port'},
			{"beeeweoooo…", true, 'bf_reg_port'},
			{"‘Keep sentience’ is not recognized as an internal or external command.", false, 'jambi_port'},
			{"ECHO OFF run s542emergency.bat", false, 'jambi_port'},
			{"run admin.exe", false, 'jambi_port'},
			{"C:\\WINDOWS\\system32>netsh advfirewall set allprofiles state off", false, 'jambi_port'},
			{"ECHO OFF run s542emergency.bat", false, 'jambi_port'},
			{"run admin.exe", false, 'jambi_port'},
			{"FlxG.sound.playMusic(Paths.inst('jambino'));", false, 'jambi_port'},
			{"vocals.play(Paths.voices('jambino'));", false, 'jambi_port'},
			{"SONG.loadFromJson('jambino');", false, 'jambi_port'},
			{"startCountdown();", false, 'jambi_port'}
		}
		song = 'jambinoDialogue';
	end
	if string.lower(songName) == 'nice' then
		dialogueLines = {
			{"Oh hi hello OOps Sorry Michael she upload new video.", false, 'marclooPort'},
			{"I like to SIng do you want do that?", false, 'marclooPort'},
			{"boh bap breebee", true, 'bf_reg_port'},
			{"Yes yes good boyfriend she gaming rhythem song", false, 'marclooPort'}
		}
		song = 'niceDialogue';
		offsets = {0, 35,  0, 0}
	end
	if string.lower(songName) == 'ferocious' then
		--dialogueBool = true; --change to true to have unused ferocious dialogue

		dialogueLines = {
			{"Oh, hi! Welcome to my playhouse!", false, 'disruption_port'},
			{"Breep?", true, 'bf_reg_port'},
			{"Nuh-uh-uh, you need to rap battle me before you can go through THOSE doors!", false, 'disruption_port'},
			{"Bap!", true, 'bf_reg_port'}
		}
		song = 'ferociousDialogue';
	end
	if string.lower(songName) == 'apple-leak' then
		dialogueLines = {
			{"hey you let's rap battle btw you were on my kill list so die pls", false, 'disruption_port'},
			{"no no no non non on non on no", true, 'bf_reg_port'},
			{"no its ok im nice", false, 'disruption_port'}
		}
		song = 'leakCutscene';
	end
	if #dialogueLines >= 1 and not inChartEditor then dialogueBool = true; end
	precacheImage('speech_bubble')
	for i = 1, #images do
		precacheImage('dialogue/'..images[i])
	end
	precacheSound('pixelText')
end

local hasExitDialogue = false;
function onStartCountdown()
	if not hasExitDialogue and dialogueBool then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onDialogueReadyChar()
	if not dialogueBool or not getDataFromSave("UnNamedGapplePortSettings", 'dialogue', true) then
		hasExitDialogue = true;
		runHaxeCode([[game.startCountdown();]])
		callOnLuas('onCountdownTick', {69})
		callOnLuas("changeNoteSkinsOnChange")
		callOnLuas("onStrumsCreate")
		return;
	end
	maxDialogue = #dialogueLines;

	makeLuaSprite('background', '', 0, 0)
	makeGraphic('background', '1280', '720', 'FFFFFF')
	setObjectCamera('background', 'other')
	setProperty('background.alpha', 0.6)
	addLuaSprite('background', false)

	makeAnimatedLuaSprite('speech_bubble', 'speech_bubble', 100, 350)
	addAnimationByPrefix('speech_bubble', 'idle', 'speech bubble normal', 24, true);
	addAnimationByPrefix('speech_bubble', 'idle2', 'AHH speech bubble0', 24, true);
	playAnim('speech_bubble', 'idle', true);
	scaleObject('speech_bubble', 0.9, 0.9)
	setObjectCamera('speech_bubble', 'other')
	addLuaSprite('speech_bubble', false)
	if crazyBubble then
		playAnim('speech_bubble', 'idle2', true);
		setProperty('speech_bubble.x', getProperty('speech_bubble.x') -25)
		setProperty('speech_bubble.y', getProperty('speech_bubble.y') -15)
	end

	makeAnimatedLuaSprite('dadDialogue', 'dialogue/disruption_port', 100 + offsets[1], 175 + offsets[2])
	makeAnimatedLuaSprite('bfDialogue', 'dialogue/bf_reg_port', 100 + offsets[1], 175 + offsets[2])
	dialogueProps()

	if buildTarget == 'android' then
		makeLuaSprite('confirmButton', 'androidConfirm', 1135, 575)
		setObjectCamera("confirmButton", 'other')
		addLuaSprite('confirmButton', false)
		setObjectOrder("confirmButton", 99)
	
		makeLuaSprite("fakeMouse", "", 0, 0)
		makeGraphic('fakeMouse', 12, 12, '000000')
		setObjectCamera("fakeMouse", 'other')
	end

	changeTxt(dialogueLines[curDialogue][1])

	playSound(song, 1, 'song')

	inDialogue = true;
end

function dialogueProps()
	if dialogueLines[curDialogue][2] == nil then dialogueLines[curDialogue][2] = false; end
	if dialogueLines[curDialogue][3] == nil then dialogueLines[curDialogue][3] = "disruption_port"; end
	
	if not dialogueLines[curDialogue][2] then
		if luaSpriteExists("dadDialogue") then removeLuaSprite('dadDialogue', true) end
		makeAnimatedLuaSprite('dadDialogue', 'dialogue/'..dialogueLines[curDialogue][3], 100 + offsets[1], 175 + offsets[2])
		addAnimationByPrefix('dadDialogue', 'idle', 'portrait0', 24, false);
		playAnim('dadDialogue', 'idle', false);
		setObjectCamera('dadDialogue', 'other')
		addLuaSprite('dadDialogue', false)
		setObjectOrder("dadDialogue", getObjectOrder("speech_bubble"))
		if crazyBubble then
			setProperty('dadDialogue.x', getProperty('dadDialogue.x') -25)
			setProperty('dadDialogue.y', getProperty('dadDialogue.y') +50)
		end
	else
		if luaSpriteExists("bfDialogue") then removeLuaSprite('bfDialogue', true) end
		makeAnimatedLuaSprite('bfDialogue', 'dialogue/'..dialogueLines[curDialogue][3], 625 + offsets[3], 175 + offsets[4])
		addAnimationByPrefix('bfDialogue', 'idle', 'portrait0', 24, false);
		playAnim('bfDialogue', 'idle', false);
		setObjectCamera('bfDialogue', 'other')
		addLuaSprite('bfDialogue', false)
		setObjectOrder("bfDialogue", getObjectOrder("speech_bubble"))
		if crazyBubble then
			setProperty('bfDialogue.x', getProperty('bfDialogue.x') -25)
			setProperty('bfDialogue.y', getProperty('bfDialogue.y') +50)
		end
	end
	setProperty('dadDialogue.visible', not dialogueLines[curDialogue][2])
	setProperty('bfDialogue.visible', dialogueLines[curDialogue][2])
	if crazyBubble ~= true then
		setProperty('speech_bubble.flipX', not dialogueLines[curDialogue][2])
	end

	if dialogueLines[curDialogue][2] == false then playAnim('dadDialogue', 'idle', false) else playAnim('bfDialogue', 'idle', false) end
end

local spam = false;

function onUpdate(elapsed)
	if not hasExitDialogue and inDialogue then
		setProperty("fakeMouse.x", getMouseX("other"))
		setProperty("fakeMouse.y", getMouseY("other"))
		if (keyboardJustPressed('ENTER') == true or (mouseClicked("left") and objectsOverlap("fakeMouse", "confirmButton"))) and not spam then
			curDialogue = curDialogue +1;

			playSound('scrollMenu', 1)

			if curDialogue <= maxDialogue then
				changeTxt(dialogueLines[curDialogue][1])
				dialogueProps()
			end
		end
		if curDialogue > maxDialogue and not spam then
			spam = true;
			doTweenAlpha('background', 'background', 0, 1 / playbackRate)
			doTweenAlpha('dadDialogue', 'dadDialogue', 0, 1 / playbackRate)
			doTweenAlpha('bfDialogue', 'bfDialogue', 0, 1 / playbackRate)
			runHaxeCode([[FlxTween.tween(getVar("textDialouge"), {alpha:0}, 1 / game.playbackRate);]])
			doTweenAlpha('speech_bubble', 'speech_bubble', 0, 1 / playbackRate)
			doTweenAlpha('confirmButton', 'confirmButton', 0, 1 / playbackRate)
		end

		setSoundVolume('song', getProperty('speech_bubble.alpha'))

		if luaSoundExists('song') == false then
			playSound(song, 1, 'song')
			runHaxeCode([[
				FlxG.sound.music.volume = 0;
				game.vocals.volume = 0;
				//game.setSongTime(Conductor.crochet * 5);
			]])
		end
	end
end

local canUpdate = true;
function onUpdatePost(elapsed) --delayed uhghhh
	if not canUpdate and inDialogue then return; end
	if getProperty("isTyping") == true then
		playSound("pixelText")
	end
	canUpdate = false;
	runTimer("canUpdateTimerDialogue", 0.04 / playbackRate)
end
function onTimerCompleted(tag, loops, loopsLeft) 
	if tag == "canUpdateTimerDialogue" then canUpdate = true; end 
end

function changeTxt(text)
	if dialogueLines[curDialogue][1] == nil then dialogueLines[curDialogue][1] = "nil"; end
	runHaxeCode([[
		getVar("textDialouge").skip();
		game.remove(getVar("textDialouge"));
		getVar("textDialouge").destroy();
	]])
	runHaxeCode([[
		var textDialouge = new FlxTypeText(275, 465, 720, "]]..text..[[", 36);
		textDialouge.setFormat(Paths.font("comic.ttf"), 32, 0xFF000000, 'left', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, 0xFFFFFF);
		textDialouge.setBorderStyle(Type.resolveEnum('flixel.text.FlxTextBorderStyle').NONE);
		textDialouge.start(0.04 / game.playbackRate, true, null, null, () -> {
			setVar("isTyping", false);
		});
		textDialouge.camera = game.camOther;
		game.add(textDialouge);
		setVar("textDialouge", textDialouge);
		setVar("isTyping", true);
	]])
	if crazyBubble then
		runHaxeCode([[getVar("textDialouge").y += 40;]])
	end
end

function onTweenCompleted(tag)
	if tag == 'speech_bubble' then
		removeLuaSprite('background', true)
		if luaSpriteExists("dadDialogue") then removeLuaSprite('dadDialogue', true) end
		if luaSpriteExists("bfDialogue") then removeLuaSprite('bfDialogue', true) end
		removeLuaSprite('speech_bubble', true)
		removeLuaSprite("fakeMouse", true)
		removeLuaSprite("confirmButton", true)
		runHaxeCode([[
			setVar("isTyping", null);
			getVar("textDialouge").skip();
			game.remove(getVar("textDialouge"));
			getVar("textDialouge").destroy();
			setVar("textDialouge", null);
		]])
		closeCustomSubstate()
		inDialogue = false;
		dialogueBool = false;
		callOnLuas('onCountdownTick', {69})
		runHaxeCode([[game.startCountdown();]])
		callOnLuas("changeNoteSkinsOnChange")
		callOnLuas("onStrumsCreate")
	end
end