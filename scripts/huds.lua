--DON'T STEAL KIDS!
--BY JUNIORNOVOA

local songSplashNames = {'Maze', 'Disruption', 'Wireframe', 'Ferocious', 'Apple-Leak', 'OG', 'badcorn'};
local oldFNFPos = {'Disruption', 'Wireframe', 'Ferocious', 'Apple-Leak', 'OG', 'badcorn'};
local gappleHUD = {'Maze', 'Disruption', 'Wireframe', 'Ferocious', 'Apple-Leak', 'OG', 'badcorn'};
local gappleHUDsong = false;
local arrowXoffset = 35;
local no_splashes = false;

function onCreatePost()
	for i = 1, #songSplashNames do
		if songName == songSplashNames[i] then
			no_splashes = true;
		end
	end
	for i = 1, #oldFNFPos do
		if songName == oldFNFPos[i] then
			for direction = 0, 3 do
				setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('playerStrums', direction, 'x') - arrowXoffset)
				setPropertyFromGroup('opponentStrums', direction, 'x', getPropertyFromGroup('opponentStrums', direction, 'x') - arrowXoffset -5)
			end
		end
	end
	for i = 1, #gappleHUD do
		if songName == gappleHUD[i] then
			setTextFont('scoreTxt', 'comic.ttf')
			setTextFont('timeTxt', 'comic.ttf')

			makeLuaText('creditsWatermark', songName, 0, 4, getProperty('healthBarBG.y') + 30)
			setObjectCamera('creditsWatermark', 'camHUD')
			setTextAlignment('creditsWatermark', 'center')
			setTextFont('creditsWatermark', 'comic.ttf')
			setTextSize('creditsWatermark', 16)
			setTextBorder('creditsWatermark', 1.5, '000000')
			setProperty('creditsWatermark.antialiasing', false)
			updateHitbox('creditsWatermark')
			addLuaText('creditsWatermark')

			makeLuaText('creditsText', '', 0, 4, getProperty('healthBarBG.y') + 50)
			setObjectCamera('creditsText', 'camHUD')
			setTextAlignment('creditsText', 'center')
			setTextFont('creditsText', 'comic.ttf')
			setTextSize('creditsText', 16)
			setTextBorder('creditsText', 1.5, '000000')
			setProperty('creditsText.antialiasing', false)
			updateHitbox('creditsText')
			addLuaText('creditsText')

			if songName == 'Disruption' then
				setProperty('creditsText.text', 'Screw you!')
			end

			if getProperty('creditsText.text') == '' then
				setProperty('creditsWatermark.y', getProperty('healthBarBG.y') + 50)
			end
			if songName == 'Maze' then
				setProperty('healthBarBG.visible', false)
				makeLuaSprite('healthBarBGnew', 'daveHealth', getProperty('healthBarBG.x'), getProperty('healthBarBG.y'))
				setObjectCamera('healthBarBGnew', 'camHUD')
				addLuaSprite('healthBarBGnew', false)
				setObjectOrder('healthBarBGnew', getObjectOrder('healthBarBG') + 1)
				break;
			end

			makeLuaSprite('iconP12', 'icons/missing', 0, 0)
			makeLuaSprite('iconP22', 'icons/missing', 0, 0)

			setProperty("updateTime", false)
			
			gappleHUDsong = true;
		end
	end
end

--THANK GOD THE INTERNET EXISTS
function math.clamp(x,min,max)return math.max(min,math.min(x,max))end
function string.duplicate(s, i)
    local str = ""
    for i = 1, i do str = str .. s end
    return str
end
string.dupe = string.duplicate
local zero = "0"
function math.toTime(x, includeMS, blankIfNotExist)
    local abs = math.abs(x)
    local int = math.floor(abs)
    
    local ms = tostring(abs - int):sub(2, 5)
    ms = ms .. zero:duplicate(math.floor(math.clamp(4 - #ms, 0, 3)))
    
    local s = tostring(math.fmod(int, 60))
    if (#s == 1) then s = zero .. s end
    
    local m = tostring(math.fmod(math.floor(int / 60), 60))
    if (#m == 1 and (blankIfNotExist or int >= 3600)) then m = zero .. m end
    
    local h = tostring(math.floor(int / 3600))
    
    local r = m .. ":" .. s
    if (int >= 3600) then r = h .. ":" .. r end
    
    return (x < 0 and "-" or "") .. (includeMS and r .. ms or r)
end
--NO MORE INTERNET NEEDED

function onUpdate()
	if gappleHUDsong then
		iconScale()
		setProperty('timeBarBG.visible', false)
		setProperty('timeBar.visible', false)
		local actualSongLength = math.toTime(getProperty("songLength") / 1000);
		local songPos = math.toTime(getSongPosition() / 1000)
		if songName == gappleHUD[5] then
			local curStestz = 7854;
			local time = 783600;
			if curStep <= (curStestz * 1.11) then
				actualSongLength = math.toTime(time / 1000);
			elseif curStep >= (curStestz * 1.11) and curStep <= (curStestz * 1.114) then
				actualSongLength = math.toTime((time * 1.16) / 1000);
			elseif curStep >= (curStestz * 1.114) and curStep >= (curStestz * 1.119) then
				actualSongLength = math.toTime((time * 1.26) / 1000);
			elseif curStep >= (curStestz * 1.119) then
				actualSongLength = math.toTime(getProperty("songLength") / 1000);
			end
		end
		setTextString('timeTxt', songPos.." / "..actualSongLength)
	end
end

function onUpdatePost()
	if gappleHUDsong then
		iconScale()
	end
end

function iconScale()
	setProperty('iconP1.scale.x', getProperty('iconP12.scale.x'))
	setProperty('iconP1.scale.y', getProperty('iconP12.scale.y'))
	setProperty('iconP2.scale.x', getProperty('iconP22.scale.x'))
	setProperty('iconP2.scale.y', getProperty('iconP22.scale.y'))
end

function onSectionHit()
	if gappleHUDsong then
		cancelTween('timeTxtScaleX')
		cancelTween('timeTxtScaleY')
		setProperty('timeTxt.scale.x', 1.1)
		setProperty('timeTxt.scale.y', 1.1)
		doTweenX('timeTxtScaleX', 'timeTxt.scale', 1, 0.2)
		doTweenY('timeTxtScaleY', 'timeTxt.scale', 1, 0.2)
	end
end

function onBeatHit()
	if gappleHUDsong then
		if curBeat % getProperty('gfSpeed') == 0 then
			local fuasd = {0.8 / getProperty('songSpeed'), 1.2 * getProperty('songSpeed') / 2.35} --thought it should be dependent of how fast song is
			local angl = 10;
			if curBeat % (getProperty('gfSpeed') * 2) == 0 then
				scaleObject('iconP12', 1.1, fuasd[1])
				scaleObject('iconP22', 1.1, fuasd[2])

				doTweenAngle('iconP1', 'iconP1', angl, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
				doTweenAngle('iconP2', 'iconP2', angl, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
			else
				scaleObject('iconP12', 1.1, fuasd[2])
				scaleObject('iconP22', 1.1, fuasd[1])

				doTweenAngle('iconP1', 'iconP1', -angl, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
				doTweenAngle('iconP2', 'iconP2', -angl, crochet / 1300 * getProperty('gfSpeed'), 'quadOut')
			end
		end

		doTweenX('iconP1x', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenX('iconP2x', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP1y', 'iconP12.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')
		doTweenY('iconP2y', 'iconP22.scale', 1, crochet / 1250 * getProperty('gfSpeed'), 'quadOut')

		updateHitbox('iconP12')
		updateHitbox('iconP22')
		iconScale()
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if no_splashes then
		removeFromGroup('grpNoteSplashes', getProperty('grpNoteSplashes.length') -1, false); --insta killed
	end
end