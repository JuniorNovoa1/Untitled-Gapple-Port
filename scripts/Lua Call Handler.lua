--cool stuff
function addToCamZoom(zoom)
    setProperty("defaultCamZoom", getProperty("defaultCamZoom") + zoom)
end

function addToVal(prop, val)
    setProperty(prop, getProperty(prop) + val)
end

function takeFromVal(prop, val)
    setProperty(prop, getProperty(prop) - val)
end