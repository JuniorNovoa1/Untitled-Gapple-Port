function createDeformartionSprites(charName, offset)
	if offset == nil then offset = 0 end
	makeLuaSprite("bgBack", "main/trix/"..charName.."_back", 0, 0)
	addLuaSprite("bgBack", false)

	makeLuaSprite("bgMid", "main/trix/"..charName.."_mid", 0, 0)
	addLuaSprite("bgMid", false)

	makeLuaSprite("bgFront", "main/trix/"..charName.."_front", 0, 0)
	addLuaSprite("bgFront", false)

	local bgs = {"bgBack", "bgMid", "bgFront"};
	for i = 1, #bgs do
		scaleObject(bgs[i], 0.9, 0.9, true)
		screenCenter(bgs[i], 'xy')
		setProperty(bgs[i]..".x", getProperty(bgs[i]..".x") + (435 + offset))
		setProperty(bgs[i]..".y", getProperty(bgs[i]..".y") - 235)
	end
end

function deformationPreJumpscare(charName)
	makeLuaSprite("jumpscareSpr", "main/trix/"..charName.."_jump", 0, 0)
	setObjectCamera("jumpscareSpr", 'hud')
	setObjectOrder("jumpscareSpr", getObjectOrder("thunderBlack") + 1)
	setProperty("jumpscareSpr.alpha", 0)
	screenCenter("jumpscareSpr", 'xy')
	addLuaSprite("jumpscareSpr", false)

	doTweenAlpha("deformationIconP2", "iconP2", 0, 1 / playbackRate, "")
	doTweenAlpha("deformationDad", "dad", 0, 1 / playbackRate, "")
end

function deformationJumpscare()
	setProperty("jumpscareSpr.alpha", 1)
	doTweenAlpha("jumpscareSpr", "jumpscareSpr", 0, 1 / playbackRate, "")
	doTweenAlpha("deformationIconP2", "iconP2", 1, 1 / playbackRate, "")
	doTweenAlpha("deformationDad", "dad", 1, 1 / playbackRate, "")
end
--stage exclusive lua calls!!!

function onTweenCompleted(tag)
	if tag == 'jumpscareSpr' then
		removeLuaSprite("jumpscareSpr", true)
	end
end

function onCreate()
	createDeformartionSprites("alge")
end