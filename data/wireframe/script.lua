local shadname = "stridentCrisisWavy";
local objects = {'daveFuckingDies', 'redTunnel', 'dad', 'boyfriend'}
local colors = {'00ff00', '00FFFF', '800080', 'FFFFFF'}
local curColor = 1;

function onCreate()
    makeAnimatedLuaSprite('badaiComes', 'characters/main/wireframe/badai', -1000, -1000)
    addAnimationByPrefix('badaiComes', 'idle', 'idle', 24, true)
    objectPlayAnimation('badaiComes', 'idle', true)
    setProperty('badaiComes.antialiasing', false)
    setProperty('badaiComes.visible', false)
    updateHitbox('badaiComes')
    if not lowQuality then
        addLuaSprite('badaiComes', true)
    end
end

function onUpdate(elapsed)
    for i = 1, #objects do
        setShaderFloat(objects[i], 'uWaveAmplitude', getProperty('lightColor.alpha') * 0.005)
        setShaderFloat(objects[i], 'uFrequency', 5)
        setShaderFloat(objects[i], 'uSpeed', 10)
    end
end

function onUpdatePost(elapsed)
    for i = 1, #objects do
        setShaderFloat(objects[i], 'uTime', os.clock())
    end
end

function onStepHit()
    if curStep == 1205 then
        doTweenX('badaiInFrameX', 'badaiComes', getProperty('dad.x') +100, 0.8, 'cubeOut')
        doTweenY('badaiInFrameY', 'badaiComes', getProperty('dad.y') +400, 0.8, 'cubeOut')
        setProperty('badaiComes.visible', true)
    end

    --[[if curStep >= 1632 and curStep <= 2143 then
        if curColor >= 5 then
            curColor = 1;
        end
        for i = 1, #objects do
            setProperty(objects[i]..'.color', getColorFromHex(colors[curColor]))
        end
        curColor = curColor +1;

        if curStep == 2143 then
            curColor = 4;
            for i = 1, #objects do
                setProperty(objects[i]..'.color', getColorFromHex(colors[curColor]))
            end
        end
    end--]]

    if curStep == 2146 then --bandai explodes then dave comes in
        doTweenX('dave COMINSCALE', 'daveFuckingDies.scale', 2, 1.25, 'cubeInOut')
        doTweenY('dave COMINSCALE A', 'daveFuckingDies.scale', 2, 1.25, 'cubeInOut')
        doTweenX('dave COMINX', 'daveFuckingDies', getProperty('dad.x') + 375, 1.25, 'cubeInOut')
        doTweenY('dave COMIN', 'daveFuckingDies', getProperty('dad.y') + 375, 1.25, 'cubeInOut')
    end

    if curStep == 2154 then --bandai explodes then dave comes in
    end

    if curStep == 2671 then --bandai explodes then dave comes in
        doTweenAlpha('guh', 'lightColor', 1, 12.5, 'cubeInOut')
        for i = 1, #objects do
            setSpriteShader(objects[i], shadname)
        end
    end
    if curStep >= 2680 then
        triggerEvent('Screen Shake', '0.1,'..getProperty('lightColor.alpha') * 0.01, '0.1,'..getProperty('lightColor.alpha') * 0.01)
    end
end

function onBeatHit()
    if curStep >= 1632 and curStep <= 2143 then
        if curColor >= 5 then
            curColor = 1;
        end
        for i = 1, #objects do
            setProperty(objects[i]..'.color', getColorFromHex(colors[curColor]))
        end
        curColor = curColor +1;

        if curStep == 2143 then
            curColor = 4;
            for i = 1, #objects do
                setProperty(objects[i]..'.color', getColorFromHex(colors[curColor]))
            end
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'badaiInFrameY' then
        triggerEvent('Change Character', 'dad', 'badai')
        setProperty('daveFuckingDies.visible', true)
        setProperty('badaiComes.visible', false)
        cameraFlash('camother', 'FFFFFF', 1)
        doTweenY('davefuckinggoesup', 'daveFuckingDies', -125, 2.5, 'cubeInOut')
    end

    if tag == 'davefuckinggoesup' then
        doTweenAngle('DAVESAN', 'daveFuckingDies', 30, 6 * 0.85, 'sineInOut')
        doTweenX('DAVESA', 'daveFuckingDies', getProperty('redTunnel.x') + 100, 6, 'sineInOut')
        doTweenY('DAVESF', 'daveFuckingDies', getProperty('redTunnel.y') + 100, 6, 'sineInOut')
    end

    if tag == 'dave COMIN' then
        cancelTween('DAVESAN')
        cancelTween('DAVESA')
        cancelTween('DAVESF')
        removeLuaSprite('daveFuckingDies', true)
        triggerEvent('Change Character', 'dad', 'tunnel-dave')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'tunnel-dave' then
        --triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045') --old ver lmao
    end
end