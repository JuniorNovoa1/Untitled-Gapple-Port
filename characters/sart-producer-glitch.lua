function onEvent(tag, val1, val2)
    if tag == 'Change Character' and val1 == 'dad' and val2 == 'sart-producer-glitch' then
        local dadCamIdleX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
        local dadCamIdleY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
        triggerEvent('Camera Follow Pos', ''..dadCamIdleX, ''..dadCamIdleY)
    end
end