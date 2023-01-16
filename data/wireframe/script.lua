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

function onCreatePost()
    setObjectOrder('dadGroup', 4)
end

function onStepHit()
    if curStep == 1205 then
        doTweenX('badaiInFrameX', 'badaiComes', getProperty('dad.x') +100, 0.8, 'cubeOut')
        doTweenY('badaiInFrameY', 'badaiComes', getProperty('dad.y') +400, 0.8, 'cubeOut')
        setProperty('badaiComes.visible', true)
    end
end

function onTweenCompleted(tag)
    if tag == 'badaiInFrameY' then
        triggerEvent('Change Character', 'dad', 'badai')
        setObjectOrder('dadGroup', 4)
        setProperty('daveFuckingDies.visible', true)
        setProperty('badaiComes.visible', false)
        cameraFlash('camother', 'FFFFFF', 1)
        doTweenY('davefuckinggoesup', 'daveFuckingDies', -600, 2.5, 'cubeInOut')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('dad.curCharacter') == 'tunnel-dave' then
        --triggerEvent('Screen Shake', '0.1, 0.0075', '0.1, 0.0045') --old ver lmao
    end
end