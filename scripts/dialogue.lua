--DON'T STEAL KIDS!
--BY JUNIORNOVOA

local dialogueSongs = {'Disruption', 'Applecore', 'Wireframe', 'Ferocious', 'Apple-Leak'};
local images = {'disruption_port', 'bf_compuzzled_port'}
local song = 'disruptionCutscene';
local dialogueTXT = {
	'THERE YOU ARE!!!',
	'Beep?',
	'DAVE SENT ME TO GET YOU!!!',
	'SAYS YOU NOT ALLOWED HERE!!!',
	'Bap!',
	'YOU GONNA DISRUPT THIS 3D WORLD!!!!!'
}
local dialogueChar = {
	true,
	false,
	true,
	true,
	false,
	true
}
local curDialogue = 1;
local maxDialogue = 1;
local dialogueBool = false;
local inDialogue = false;
function onCreatePost()
	for i = 1, #dialogueSongs do
		if songName == dialogueSongs[i] then
			dialogueBool = true;
			if i == 2 then
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
			elseif i == 3 then
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
			elseif i == 4 then
				dialogueBool = true; --change to true to have unused ferocious dialogue

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
			elseif i == 5 then
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

			for i = 1, #dialogueTXT do
				maxDialogue = i;
			end
		end
	end
end

function onSongStart()
	if not dialogueBool then
		callOnLuas('onCountdownTick', {69})
		return;
	end
	openCustomSubstate('dialogue', false)
	inDialogue = true;
end

function onUpdate()
	if inDialogue then
		runHaxeCode([[FlxG.sound.music.pause();]])
		runHaxeCode([[game.setSongTime(0)]])
		runHaxeCode([[FlxG.sound.music.pause();]])
	end
end

function onCustomSubstateCreate(tag)
	if tag == 'dialogue' then
		setProperty('canPause', false)
		
		makeLuaSprite('background', '', 0, 0)
		makeGraphic('background', '1280', '720', 'FFFFFF')
		setObjectCamera('background', 'other')
		setProperty('background.alpha', 0.6)
		addLuaSprite('background', false)

		makeAnimatedLuaSprite('dad', 'dialogue/'..images[1], 100, 175)
        setProperty('dad.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        addAnimationByPrefix('dad', 'idle', 'portrait', 24, false);
        objectPlayAnimation('dad', 'idle', false);
		setObjectCamera('dad', 'other')
        addLuaSprite('dad', false)

		makeAnimatedLuaSprite('bf', 'dialogue/'..images[2], 625, 175)
        setProperty('bf.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        addAnimationByPrefix('bf', 'idle', 'portrait', 24, false);
        objectPlayAnimation('bf', 'idle', false);
		setObjectCamera('bf', 'other')
        addLuaSprite('bf', false)

		makeAnimatedLuaSprite('speech_bubble', 'speech_bubble', 100, 350)
        setProperty('speech_bubble.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        addAnimationByPrefix('speech_bubble', 'idle', 'speech bubble normal', 24, true);
		addAnimationByPrefix('speech_bubble', 'idle2', 'AHH speech bubble0', 24, true);
        objectPlayAnimation('speech_bubble', 'idle', true);
		scaleObject('speech_bubble', 0.9, 0.9)
		setObjectCamera('speech_bubble', 'other')
        addLuaSprite('speech_bubble', false)
		
		makeLuaText('dialogueTxtTEXT', dialogueTXT[1], 720, 275, 465)
		setObjectCamera('dialogueTxtTEXT', 'camother')
		setTextAlignment('dialogueTxtTEXT', 'left')
		setProperty('dialogueTxtTEXT.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
		--setTextColor('dialogueTxtTEXT', '000000')
		setTextFont('dialogueTxtTEXT', 'comic.ttf')
		setTextSize('dialogueTxtTEXT', 28)
		updateHitbox('dialogueTxtTEXT')
		addLuaText('dialogueTxtTEXT')

		if songName == 'Wireframe' then
			objectPlayAnimation('speech_bubble', 'idle2', true);

			setProperty('dad.x', getProperty('dad.x') -25)
			setProperty('bf.x', getProperty('bf.x') -25)
			setProperty('speech_bubble.x', getProperty('speech_bubble.x') -25)
			setProperty('dialogueTxtTEXT.x', getProperty('dialogueTxtTEXT.x') -25)
			setProperty('dad.y', getProperty('dad.y') +50)
			setProperty('bf.y', getProperty('bf.y') +50)
			setProperty('speech_bubble.y', getProperty('speech_bubble.y') -15)
			setProperty('dialogueTxtTEXT.y', getProperty('dialogueTxtTEXT.y') +50)
		end

		dialogueProps()

		playSound(song, 1, 'song')
	end
end

function dialogueProps()
	if dialogueChar[curDialogue] == true then
		setProperty('dad.visible', true)
		setProperty('bf.visible', false)
		if songName ~= 'Wireframe' then
			setProperty('speech_bubble.flipX', true)
		end
		objectPlayAnimation('dad', 'idle', false)
	else
		setProperty('dad.visible', false)
		setProperty('bf.visible', true)
		if songName ~= 'Wireframe' then
			setProperty('speech_bubble.flipX', false)
		end
		objectPlayAnimation('bf', 'idle', false)
	end
end

local spam = false;

function onCustomSubstateUpdate(tag, elapsed)
	if tag == 'dialogue' then
		if keyboardJustPressed('ENTER') == true and not spam then
			curDialogue = curDialogue +1;

			playSound('scrollMenu', 1)

			if curDialogue <= maxDialogue then
				setTextString('dialogueTxtTEXT', dialogueTXT[curDialogue])
				dialogueProps()
			end
		end
		if keyboardJustPressed('P') == true or curDialogue > maxDialogue and not spam then
			spam = true;
			doTweenAlpha('background', 'background', 0, 1)
			doTweenAlpha('dad', 'dad', 0, 1)
			doTweenAlpha('bf', 'bf', 0, 1)
			doTweenAlpha('speech_bubble', 'speech_bubble', 0, 1)
			doTweenAlpha('dialogueTxtTEXT', 'dialogueTxtTEXT', 0, 1)
		end

		setSoundVolume('song', getProperty('dialogueTxtTEXT.alpha'))

		if luaSoundExists('song') == false then
			playSound(song, 1, 'song')
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'speech_bubble' then
		removeLuaSprite('background', true)
		removeLuaSprite('dad', true)
		removeLuaSprite('bf', true)
		removeLuaSprite('speech_bubble', true)
		removeLuaSprite('dialogueTxtTEXT', true) --don't wanna waste memory right???
		closeCustomSubstate()
		inDialogue = false;
		dialogueBool = false;
		callOnLuas('onCountdownTick', {69})
		runHaxeCode([[
			FlxG.sound.music.time = 0;
			//game.setSongTime(Conductor.crochet * 5);
		]])
		setProperty('canPause', true)
	end
end