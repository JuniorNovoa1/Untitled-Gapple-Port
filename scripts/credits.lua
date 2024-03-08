local songTxt = {
	["disruption"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Lexicord',
	["applecore"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Lexicord',
	["disability"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by T5mpler',
	["wireframe"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Sky!\nand JuniorNovoa(finished it)',
	["algebra"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Lexicord',
	["fresh-and-toasted"] = 'Song by Villezen\n\nVisuals by Lancey\n\nCharting by Project Tea',
	["deformation"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by Log Man',
	["nice"] = "Song by Sky!\n\nVisuals by Lancey, Wildey\nand TecheVent\n\nCharting by Project Tea\n\nBased off Marcello's The Nice\nAND COLLECT\nOFGAMER AcT:ONE THE\nSTORE GAME MUN by\nMarcello_TimeNice30",
	["ferocious"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Lexicord\n\nBased off Garrett\'s Funny \nAnimal Game\nby Jumpman25',
	
	["glamrock"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Lexicord',
	["sugar-rush"] = 'Song by Sky!\n\nVisuals by TecheVent and\nLancey\n\nCharting by Project Tea\n\nBased on TecheVent\nplaying as Glamrock\nFreddy in CRIDAB',
	["gift-card"] = 'Song by CVAL\n\nVisuals by Lancey and Osp\n\nCharting by Log Man',
	["ready-loud"] = 'Song by MoldyGH\n\nVisuals by Lancey\nand Aadsta\n\nCharting by Log Man',
	["bookworm"] = 'Song by Sky!\n\nVisuals by\nSquishyZumorizu and\nJukebox\n\nCharting by Log Man',
	["cuberoot"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by 1up',
	["apprentice"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by Aadsta',
	["too-shiny"] = 'Song by Gorbini\n\nVisuals by Willow\n\nCharting by Log Man\n\nBased off Dave\'s Fun\nAlgebra Class! by\nMoldyGH',
	["resumed"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Cynda\n\nBased off Dambu on\nYoutube',
	["mine"] = "Song by Sky!\n\nVisuals by Lancey\nCynda\n\nCharting by Cynda\n\nBased off Dinnerbambi\nFunkin' by Anton Bildziuk",
	["dale"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by Log Man',
	["the-big-dingle"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by T5mpler',
	["ataefull"] = "Song by TH3R34LD34L\n\nVisuals by SAMMYPIGZY\n\nCharting by Log Man",
	["the-scratches"] = "Song by Cynda\n\nVisuals by TecheVent and\nWugalex\n\nCharting by Project Tea\n\nBased on Scratchman100\nand his OCs",
	["sart-producer"] = 'Song by Sky!\n\nVisuals by Lancey\n\nCharting by Cynda',

	["og"] = 'Song by Aadsta\n\nVisuals by Devianator\nand Aadsta\n\nCharting by Aadsta\n\nBased off Pre-Alpha Dave',
	["apple-leak"] = 'Part by Silly Squirmer\n\nVisuals by SAMMYPIGZY\nand Arty Squirmer\n\nCharting by Charty Squirmer\n\nBased off\nHigh Effort Poopers',
	
	["ticking"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by Project Tea',

	["kooky"] = 'Song by Aadsta\n\nVisuals by Lancey\n\nCharting by Project Tea',

	["badcorn"] = 'Fake song!\n\nSong by Crapler\n\nVisuals by Lancey\n\nCharting by Unknown',
	["crap"] = 'Fake song?\n\nSong by Sky!\n\nVisuals by Lancey\nBluHairMan\n\nCharting by Colin09\n\nBased off Golden Apple?\nMore like Golden Crapple!'
};

function onSongStart()
	if songName == "main-menu" then return; end --close() fucks up other scripts?? wtf
	makeLuaSprite("blackBG", '', -380, 0)
	makeGraphic("blackBG", 380, 720, "000000")
	setProperty("blackBG.alpha", 0.6)
	addLuaSprite("blackBG")
	setObjectCamera('blackBG', 'other')

	if songTxt[string.lower(songName)] == nil then songTxt[string.lower(songName)] = "nil" end
	makeLuaText('creditsTxt', songTxt[string.lower(songName)].."\n\n Port by JuniorNovoa", 600, getProperty('blackBG.x') - 112, getProperty('blackBG.y') + 2)
	setObjectCamera('creditsTxt', 'other')
	setTextAlignment('creditsTxt', 'center')
	setTextFont("creditsTxt", "comic.ttf")
	setTextSize('creditsTxt', 28)
	updateHitbox('creditsTxt')
	addLuaText('creditsTxt')
	--setTextBorder("creditsTxt", 0, "ffffff")
	runHaxeCode([[game.getLuaObject('creditsTxt').setBorderStyle(Type.resolveEnum('flixel.text.FlxTextBorderStyle').NONE);]])
	setProperty("creditsTxt.antialiasing", false)

	doTweenX('backInOutCredits', 'blackBG', 0, 1, 'backInOut')
	runTimer("dissapeartimer", 3)
end
function onUpdate(elapsed)
	if luaSpriteExists("blackBG") and luaTextExists("creditsTxt") then setProperty("creditsTxt.x", getProperty("blackBG.x") - 112) end
end
function onTweenCompleted(tag)
	if tag == "backInOutCreditsExit" then doTweenX('backInOutCreditsExit', 'blackBG', -380, 0.6, 'sineInOut') end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "dissapeartimer" then
		doTweenX('backInOutCreditsExit', 'blackBG', getProperty('blackBG.x') + 100, 0.5, 'sineInOut')
	end
end