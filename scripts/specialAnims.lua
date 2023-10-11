anims = {'smash', 'singThrow', 'singSmash', 'singUP-alt', 'dodge', 'hit', 'hey', 'inhale', 'shmoovin', 'scream', 'turn', 'scared', 'run', 'talk', 'stare'}

function onUpdate()
    for i = 1, #anims do
        if getProperty('boyfriend.animation.curAnim.name') == anims[i] then
            setProperty('boyfriend.specialAnim', true);
        end        
        if getProperty('dad.animation.curAnim.name') == anims[i] then
            setProperty('dad.specialAnim', true);
        end
        if getProperty('gf.animation.curAnim.name') == anims[i] then
            setProperty('gf.specialAnim', true);
        end

        if getProperty('badai.animation.curAnim.name') == anims[i] then
            setProperty('badai.specialAnim', true);
        end
    end
end