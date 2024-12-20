local nodemgr = require("nodes")

love.window.setMode(800, 600, {resizable = true, minwidth = 480, minheight = 360})
love.window.setTitle("NARP - Node-based Analog Rendering Prototype")

function love.draw()
    width, height = love.graphics.getDimensions()

    love.graphics.clear(0.874509804,0.874509804,0.874509804)
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.print('NARP', width-40, height-20)

    nodemgr.drawNodes()
end
