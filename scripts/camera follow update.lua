local camMovementType = ''; --all types: '', charSize, camZoom - (charSize changes the movement amount by the size of the char, camZoom changes the movement amount by how much the value of defaultCamZoom is)

local regAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
local altAnims = {'singLEFT-alt', 'singDOWN-alt', 'singUP-alt', 'singRIGHT-alt'};
local bfCamIdle = {};
local dadCamIdle = {};

local offsets = 30;
local posBFX = {}
local posBFY = {}

local yoffset = 0;


function onUpdate() --camera now follows characters!!!!
	bfCamIdle[0] = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]');
	bfCamIdle[1] = getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]');
	dadCamIdle[0] = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
	dadCamIdle[1] = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
	if string.lower(songName) == 'nice' and curStep >= 7628 then
		dadCamIdle[0] = getMidpointX('errung') + 150 + getProperty('errung.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + 200;
		dadCamIdle[1] = getMidpointY('errung') - 100 + getProperty('errung.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') + 200;
	end
	if getDataFromSave("settings", "newCamZoom") then yoffset = 105 / getProperty("defaultCamZoom") end
	if getProperty('dad.curCharacter') == 'sart-producer-glitch' then
		bfCamIdle[0] = dadCamIdle[0];
		bfCamIdle[1] = dadCamIdle[1];
	end
	if getProperty('dad.curCharacter') == 'bandu' then
		dadCamIdle[0] = bfCamIdle[0];
		dadCamIdle[1] = bfCamIdle[1];
	end
	if getProperty('dad.curCharacter') == 'bandu-sad' then
		dadCamIdle[0] = 625;
	end
	if mustHitSection == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		moveCam(bfCamIdle[0] -(yoffset * 2.5), bfCamIdle[1] -yoffset);
	end
	if mustHitSection == false and (getProperty('dad.animation.curAnim.name') == 'idle' or (dadName == 'bandu' or dadName == 'bandu-sad')) then
		moveCam(dadCamIdle[0] -yoffset, dadCamIdle[1] -yoffset);
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mustHitSection == true then
		if camMovementType == 'charSize' then
			offsets = 30 + (0.000025 * getProperty('boyfriend.width') * getProperty('boyfriend.height'));
		elseif camMovementType == 'camZoom' then
			offsets = 30 / getProperty('defaultCamZoom');
		end
		if direction == 0 then
			moveCam(bfCamIdle[0] -offsets -(yoffset * 2.5), bfCamIdle[1] -yoffset);
		end
		if direction == 1 then
			moveCam(bfCamIdle[0] -(yoffset * 2.5), bfCamIdle[1] +offsets -yoffset);
		end
		if direction == 2 then
			moveCam(bfCamIdle[0] -(yoffset * 2.5), bfCamIdle[1] -offsets -yoffset);
		end
		if direction == 3 then
			moveCam(bfCamIdle[0] +offsets -(yoffset * 2.5), bfCamIdle[1] -yoffset);
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'bandu-sad' then
		return;
	end
	if mustHitSection == false then
		if camMovementType == 'charSize' then
			offsets = 30 + (0.000025 * getProperty('dad.width') * getProperty('dad.height'));
		elseif camMovementType == 'camZoom' then
			offsets = 30 / (getProperty('defaultCamZoom') * 0.8);
		end
		if direction == 0 then
			moveCam(dadCamIdle[0] -offsets -yoffset, dadCamIdle[1] -yoffset);
		end
		if direction == 1 then
			moveCam(dadCamIdle[0] -yoffset, dadCamIdle[1] +offsets -yoffset);
		end
		if direction == 2 then
			moveCam(dadCamIdle[0] -yoffset, dadCamIdle[1] -offsets -yoffset);
		end
		if direction == 3 then
			moveCam(dadCamIdle[0] +offsets -yoffset, dadCamIdle[1] -yoffset);
		end
	end
end

function moveCam(x, y)
	triggerEvent('Camera Follow Pos', ''..x, ''..y) --didn't want to see this stupid shit everywhere
end