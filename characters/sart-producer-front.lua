function onEvent(tag, val1, val2)
    if tag == 'Change Character' and val1 == 'dad' and val2 == 'sart-producer-front' then
        local dadCamIdleX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
        local dadCamIdleY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
        moveCam(dadCamIdleX, dadCamIdleY)
    end
end

function moveCam(x, y)
	triggerEvent('Camera Follow Pos', ''..x, ''..y) --didn't want to see this stupid shit everywhere
    setProperty('camFollowPos.x', x)
    setProperty('camFollowPos.y', y)
end