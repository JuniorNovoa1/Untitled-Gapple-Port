 --DON'T STEAL KIDS!
--BY JUNIORNOVOA

local dialogueSongs = {'disruption', 'applecore', 'disability', 'wireframe', 'algebra', 'nice', 'ferocious', 'apple-leak'};
local images = {'disruption_port', 'bf_compuzzled_port'}
local song = 'disruptionCutscene';
local dialogueTXT = {'THERE YOU ARE!!!','Beep?','DAVE SENT ME TO GET YOU!!!','SAYS YOU NOT ALLOWED HERE!!!','Bap!','YOU GONNA DISRUPT THIS 3D WORLD!!!!!'}
local dialogueChar = {true,false,true,true,false,true}
local offsets = {0, 0, 0, 0}
local curDialogue = 1;
local maxDialogue = 1;
local dialogueBool = false;
local inDialogue = false;
local crazyBubble = false;
function onCreate()
	for i = 1, #dialogueSongs do if string.lower(songName) == dialogueSongs[i] then dialogueBool = true; end end
	if string.lower(songName) == 'disruption' then
		crazyBubble = true;
	end
	if string.lower(songName) == 'applecore' then
		dialogueTXT = {
			'Howdy!',
			'Bop?',
			'Can I show you something?',
			'Bep!',
			'Check this out!',
			"I got lots o' phones!",
			'Neat, huh?',
			'Boop!',
			'Ooh, is that a microphone?',
			'Are you a singer?',
			'Beep!',
			'Wanna sing?',
			'Brap',
		}
		dialogueChar = {
			true,
			false,
			true,
			false,
			true,
			true,
			true,
			false,
			true,
			true,
			false,
			true,
			false
		}
		song = 'applecoreCutscene';
		images = {'bandu_port', 'bf_reg_port'}
	elseif string.lower(songName) == 'disability' then
		dialogueTXT = {
			'So, you got past Bambi?',
			'Beep.',
			"Guess I'll have to do everything myself.",
			'I can control the 3D world better than I thought I could.',
			"We'll sing one song.",
			'I win, you leave.',
			"You win, I'll let you be.",
			'Bap!'
		}
		dialogueChar = {
			true,
			false,
			true,
			true,
			true,
			true,
			true,
			false
		}
		song = 'disabilityDialogue';
		images = {'disable_port', 'bf_reg_port'}
	elseif string.lower(songName) == 'wireframe' then
		dialogueTXT = {
			"ALRIGHT, THAT IS IT!",
			"NO MORE FOOLING AROUND!",
			"Beep?!",
			"FIRST, YOU COME HERE WITHOUT A CARE IN THE WORLD..",
			"AND WHEN I TRY TO STOP YOU, YOU CAUSE ALL OF THESE PROBLEMS!",
			"DO YOU EVEN KNOW WHAT YOU'RE DOING?!",
			"IF YOU REALLY THINK YOU CAN JUST BE HERE WITH NO CONSEQUENCES..",
			"YOU ARE DEAD WRONG!",
			"THIS IS YOUR LAST CHANCE TO LEAVE.",
			"Bap!"
		}
		dialogueChar = {
			true,
			true,
			false,
			true,
			true,
			true,
			true,
			true,
			true,
			false
		}
		song = 'wireframeCutscene';
		images = {'decimated_dave_port', 'bf_reg_port'}
		crazyBubble = true;
	elseif string.lower(songName) == 'algebra' then --DIALOGIUE
		dialogueTXT = {
			"Hey there!",
			"Welcome to my school!",
			"People don't visit me often, So I'm glad you're here!",
			"Beep!",
			"Don't worry about my disability, I can get around myself.",
			"Bap!"
		}
		dialogueChar = {
			true,
			true,
			true,
			false,
			true,
			false
		}
		song = 'DaveDialogue';
		images = {'og_port', 'bf_reg_port'}
	elseif string.lower(songName) == 'nice' then
		dialogueTXT = {
			"Oh hi hello OOps Sorry Michael she upload new video.",
			"I like to SIng do you want do that?",
			"boh bap breebee",
			"Yes yes good boyfriend she gaming rhythem song"
		}
		dialogueChar = {
			true,
			true,
			false,
			true
		}
		song = 'niceDialogue';
		images = {'marclooPort', 'bf_reg_port'}
		offsets = {0, 35,  0, 0}
	elseif string.lower(songName) == 'ferocious' then
		--dialogueBool = true; --change to true to have unused ferocious dialogue

		dialogueTXT = {
			"Oh, hi! Welcome to my playhouse!",
			"Breep?",
			"Nuh-uh-uh, you need to rap battle me before you can go through THOSE doors!",
			"Bap!"
		}
		dialogueChar = {
			true,
			false,
			true,
			false
		}
		song = 'ferociousDialogue';
		images = {'disruption_port', 'bf_reg_port'}
	elseif string.lower(songName) == 'apple-leak' then
		dialogueTXT = {
			"hey you let's rap battle btw you were on my kill list so die pls",
			"no no no non non on non on no",
			"no its ok im nice"
		}
		dialogueChar = {
			true,
			false,
			true
		}
		song = 'leakCutscene';
	end

	precacheImage('speech_bubble')
	for i = 1, #images do
		precacheImage('dialogue/'..images[i])
	end
	precacheSound('pixelText')

	for i = 1, #dialogueTXT do
		maxDialogue = i;
	end
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
		
	makeLuaSprite('background', '', 0, 0)
	makeGraphic('background', '1280', '720', 'FFFFFF')
	setObjectCamera('background', 'other')
	setProperty('background.alpha', 0.6)
	addLuaSprite('background', false)

	makeAnimatedLuaSprite('dadDialogue', 'dialogue/'..images[1], 100 + offsets[1], 175 + offsets[2])
	addAnimationByPrefix('dadDialogue', 'idle', 'portrait', 24, false);
	playAnim('dadDialogue', 'idle', false);
	setObjectCamera('dadDialogue', 'other')
	addLuaSprite('dadDialogue', false)

	makeAnimatedLuaSprite('bfDialogue', 'dialogue/'..images[2], 625 + offsets[3], 175 + offsets[4])
	addAnimationByPrefix('bfDialogue', 'idle', 'portrait', 24, false);
	playAnim('bfDialogue', 'idle', false);
	setObjectCamera('bfDialogue', 'other')
	addLuaSprite('bfDialogue', false)

	makeAnimatedLuaSprite('speech_bubble', 'speech_bubble', 100, 350)
	addAnimationByPrefix('speech_bubble', 'idle', 'speech bubble normal', 24, true);
	addAnimationByPrefix('speech_bubble', 'idle2', 'AHH speech bubble0', 24, true);
	playAnim('speech_bubble', 'idle', true);
	scaleObject('speech_bubble', 0.9, 0.9)
	setObjectCamera('speech_bubble', 'other')
	addLuaSprite('speech_bubble', false)

	if crazyBubble then
		playAnim('speech_bubble', 'idle2', true);

		setProperty('dadDialogue.x', getProperty('dadDialogue.x') -25)
		setProperty('bfDialogue.x', getProperty('bfDialogue.x') -25)
		setProperty('speech_bubble.x', getProperty('speech_bubble.x') -25)
		setProperty('dadDialogue.y', getProperty('dadDialogue.y') +50)
		setProperty('bfDialogue.y', getProperty('bfDialogue.y') +50)
		setProperty('speech_bubble.y', getProperty('speech_bubble.y') -15)
	end

	if buildTarget == 'android' then
		makeLuaSprite('confirmButton', 'androidConfirm', 1135, 575)
		setObjectCamera("confirmButton", 'other')
		addLuaSprite('confirmButton', false)
		setObjectOrder("confirmButton", 99)
	
		makeLuaSprite("fakeMouse", "", 0, 0)
		makeGraphic('fakeMouse', 12, 12, '000000')
		setObjectCamera("fakeMouse", 'other')
	end

	dialogueProps()

	changeTxt(dialogueTXT[curDialogue])

	playSound(song, 1, 'song')

	inDialogue = true;
end

function dialogueProps()
	setProperty('dadDialogue.visible', dialogueChar[curDialogue])
	setProperty('bfDialogue.visible', not dialogueChar[curDialogue])
	if crazyBubble ~= true then
		setProperty('speech_bubble.flipX', dialogueChar[curDialogue])
	end

	if dialogueChar[curDialogue] == true then playAnim('dadDialogue', 'idle', false) else playAnim('bfDialogue', 'idle', false) end
end

local spam = false;

function onUpdate(elapsed)
	if not hasExitDialogue and inDialogue then
		prevDialogueText = getTextString("textDialouge.text")
		setProperty("fakeMouse.x", getMouseX("other"))
		setProperty("fakeMouse.y", getMouseY("other"))
		if (keyboardJustPressed('ENTER') == true or (mouseClicked("left") and objectsOverlap("fakeMouse", "confirmButton"))) and not spam then
			curDialogue = curDialogue +1;

			playSound('scrollMenu', 1)

			if curDialogue <= maxDialogue then
				changeTxt(dialogueTXT[curDialogue])
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
		runHaxeCode([[getVar("textDialouge").y += 30;]])
	end
end

function onTweenCompleted(tag)
	if tag == 'speech_bubble' then
		removeLuaSprite('background', true)
		removeLuaSprite('dad', true)
		removeLuaSprite('bf', true)
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