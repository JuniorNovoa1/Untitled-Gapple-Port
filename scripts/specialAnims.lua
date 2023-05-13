anims = {'smash', 'singThrow', 'singSmash', 'singUP-alt', 'dodge', 'hit', 'hey'}

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
    end
end