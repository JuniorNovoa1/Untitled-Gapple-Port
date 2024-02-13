local isCrazy = false;
local curThing = false;
local camAngle = 5;
function onStepHit()
    if curStep == 895 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
    end

    if curStep == 128 or curStep == 512 or curStep == 912 then
        isCrazy = true;
        if curStep ~= 912 then
            setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
        end
    end

    if curStep == 384 or curStep == 768 or curStep == 1424 then
        isCrazy = false;
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
        if flashingLights then
            cameraFlash('other', 'FFFFFF', 1 / playbackRate)
        end
    end
end

function onBeatHit()
    if isCrazy ~= true then
        if luaSpriteExists("cameoIcon") then
            setProperty('cameoIcon.visible', false)
            setProperty('iconP1.alpha', 1)
        end
        if luaSpriteExists("freddyIcon") then
            setProperty('freddyIcon.visible', false)
            setProperty('iconP2.alpha', 1)
        end
        return; 
    else
        if luaSpriteExists("cameoIcon") then
            setProperty('cameoIcon.visible', true)
            setProperty('iconP1.alpha', 0)
        end
        if luaSpriteExists("freddyIcon") then
            setProperty('freddyIcon.visible', true)
            setProperty('iconP2.alpha', 0)
        end
    end
    if curThing then
        setProperty('camGame.angle', camAngle)
        playAnim("freddyIcon", "left", true)
        playAnim("cameoIcon", "left", true)
    else
        setProperty('camGame.angle', -camAngle)
        playAnim("freddyIcon", "right", true)
        playAnim("cameoIcon", "right", true)
    end
    doTweenAngle("gameAngle", "camGame", 0, (crochet / 1450 * getProperty('gfSpeed')) / playbackRate, "quadOut")

    setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.06)
    setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.06)
    curThing = not curThing;
end