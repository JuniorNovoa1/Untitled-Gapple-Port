local bgShitters = {'diamondJunk', 'daveJunk', 'davePiss', 'monitorJunk', 'robotJunk'}

function onCreate()
	makeLuaSprite('bg', 'main/algebra/algebraBg', -600, -300);
	setGraphicSize("bg", math.floor(getProperty("bg.width") * 1.35), math.floor(getProperty("bg.height") * 1.35))
	updateHitbox("bg")
	screenCenter("bg", 'xy')
	addLuaSprite('bg', false);

	makeLuaSprite('daveJunk', 'main/algebra/bgJunkers/dave', 424, 122);
	addLuaSprite('daveJunk', false);
	makeAnimatedLuaSprite('davePiss', 'main/algebra/bgJunkers/davePiss', 427 + 50, 94)
	addAnimationByPrefix('davePiss', 'idle', 'GRR', 0, true);
	addAnimationByPrefix('davePiss', 'd', 'GRR', 24, false);
	playAnim('davePiss', 'idle', true);
	addLuaSprite('davePiss', false)
	setObjectOrder('davePiss', 1)

	makeLuaSprite('monitorJunk', 'main/algebra/bgJunkers/rubyIsAngryRN', 960 + 275, 61 + 75);
	addLuaSprite('monitorJunk', false);

	makeLuaSprite('diamondJunk', 'main/algebra/bgJunkers/lanceyIsGoingToMakeAFakeLeakAndPostItInGeneral', 645 + 75, -16);
	addLuaSprite('diamondJunk', false);

	makeLuaSprite('robotJunk', 'main/algebra/bgJunkers/myInternetJustWentOut', -160 -250, 225 +75);
	addLuaSprite('robotJunk', false);

	runHaxeCode([[
		var spike = new Character(275, 75, 'spike-bg');
		spike.scale.set(0.975, 0.975);
		spike.visible = false;
		game.add(spike);
		game.modchartSprites.set('spike', spike);
	]])
	setObjectOrder('spike', 6)

	for i = 1, #bgShitters do
		setProperty(bgShitters[i]..".scale.x", 1.35)
		setProperty(bgShitters[i]..".scale.y", 1.35)
		setProperty(bgShitters[i]..".visible", false)
	end
end