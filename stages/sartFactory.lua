function onCreate()
    makeLuaSprite('factory', 'extras/sart/grand_cake', 0, 0)
    setProperty('factory.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    screenCenter('factory', '')
    addLuaSprite('factory', false)

    makeAnimatedLuaSprite('spoarFolk', 'extras/sart/spoar_folk', getProperty('gf.x'), getProperty('gf.y'))
    setProperty('spoarFolk.x', getProperty('spoarFolk.x') + 200)
    setProperty('spoarFolk.y', getProperty('spoarFolk.y') + 175)
    setProperty('spoarFolk.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    addAnimationByPrefix('spoarFolk', 'idle', 'dance', 24, true);
    addAnimationByPrefix('spoarFolk', 'move', 'uncle klunk move0', 24, false);
    playAnim('spoarFolk', 'idle', true);
    addLuaSprite('spoarFolk', false)
    setProperty('spoarFolk.visible', false)

    makeLuaSprite('poop', '', getProperty('factory.x'), getProperty('factory.y'))
    makeGraphic('poop', getProperty('factory.width'), getProperty('factory.height'), '000000')
    setProperty('poop.alpha', 0.6)
    updateHitbox('poop')
    addLuaSprite('poop', true)
end