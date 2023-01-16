local stayOnBF = false;

function onCreate()
    makeAnimatedLuaSprite('RARI', 'I_GOT_A_GLOCK_IN_MY_RARI', 0, 0)
    addAnimationByPrefix('RARI', 'rarrji', 'ezgif-frame-', 10.5, false)
    setProperty('RARI.antialiasing', true)
    setProperty('RARI.alpha', 0)
    setProperty('RARI.scale.x', 4)
    setProperty('RARI.scale.y', 4)
    updateHitbox('RARI')
    screenCenter('RARI')
    setObjectCamera('RARI', 'camother')
    addLuaSprite('RARI', true)

    makeLuaSprite('blackbgg', '', 0, 0)
    makeGraphic('blackbgg', '1280', '720', '000000')
    scaleObject('blackbgg', 10, 10)
    screenCenter('blackbgg', 'x')
    screenCenter('blackbgg', 'y')
    setProperty('blackbgg.alpha', 0)
    updateHitbox('blackbgg')
    addLuaSprite('blackbgg', false)
end

function onUpdate()
    if stayOnBF then
        setProperty('camFollow.x', getProperty('boyfriend.x') +200);
		setProperty('camFollow.y', getProperty('boyfriend.y') +200);
    end
end

function onStepHit()
    if curStep == 511 then
        objectPlayAnimation('RARI', 'rarrji')
        doTweenAlpha('RARIALPHA', 'RARI', 0.55, 0.8)
        doTweenAlpha('dadAlpha', 'dad', 0, 0.8)
        doTweenAlpha('gfAlpha', 'gf', 0, 0.8)
        doTweenAlpha('daThin', 'blackbgg', 1, 0.8)

        doTweenAlpha('dadIcon', 'iconP2', 0, 0.8)

        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.5)
        stayOnBF = true;
    end

    if curStep == 703 then
        doTweenAlpha('RARIALPHA', 'RARI', 0, 0.8)
        doTweenAlpha('dadAlpha', 'dad', 1, 0.8)
        doTweenAlpha('gfAlpha', 'gf', 1, 0.8)
        doTweenAlpha('daThin', 'blackbgg', 0, 0.8)

        doTweenAlpha('dadIcon', 'iconP2', 1, 0.8)

        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.5)
        stayOnBF = false;
    end
end