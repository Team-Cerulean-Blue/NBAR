-- polyfills because lua is missing a lot of features for a programming language

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function table.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end

vernum = "v0.2.2"
font = love.graphics.setNewFont("ShareTechMono-Regular.ttf")
tile = love.graphics.newImage("tile.png")
tilenear = love.graphics.newImage("tile-near.png")

local nodemgr = require("nodes")
local hud = require("hud")
hud.nodemgr = nodemgr
hud.handleNodeModules({"digitalinput"})

love.window.setMode(800, 600, {resizable = true, minwidth = 480, minheight = 360})
love.window.setTitle("NBAR - Node-Based Analog Renderer")

local hoverPadding=8
function renderHover(hover,mx,my)
    local txtWidth, wrappedText = font:getWrap(hover,200)
    love.graphics.setColor(0.992156863,0.823529412,0.0509803922)
    love.graphics.rectangle("fill",mx,my,txtWidth+hoverPadding*2,font:getHeight(hover)*(#wrappedText)+hoverPadding*2,5,5,5)
    love.graphics.setColor(0,0,0)
    love.graphics.print(table.concat(wrappedText,"\n"),mx+hoverPadding,my+hoverPadding)
end

mouseDownBef = false
dragStartX=0
dragStartY=0
draggingNode=nil
nodeToDrag=nil

function handleDrag()
    local mx,my = love.mouse.getPosition()
    width, height = love.graphics.getDimensions()
    if hud.touching(mx,my,width,height) then
        return nil
    end

    if(not mouseDownBef) then
        local hoveringNode = nodemgr.hoveringNode()
        if(hoveringNode~=nil) then
            -- dragging node
            draggingNode=true
            dragStartX=mx-hoveringNode.x
            dragStartY=my-hoveringNode.y
            nodeToDrag=hoveringNode
        else
            -- dragging canvas
            draggingNode=false
            dragStartX=mx-nodemgr.offsetX
            dragStartY=my-nodemgr.offsetY
        end
    elseif(draggingNode) then
        nodeToDrag.x=mx-dragStartX
        nodeToDrag.y=my-dragStartY
    else
        nodemgr.offsetX=mx-dragStartX
        nodemgr.offsetY=my-dragStartY
    end
end

function handleClick()
    local mx,my = love.mouse.getPosition()
    width, height = love.graphics.getDimensions()

    if hud.touching(mx,my,width,height) then
        hud.handleClick(mx,my,width,height)
    end
end

function love.draw()
    width, height = love.graphics.getDimensions()

    love.graphics.clear(0.211764706,0.2,0.223529412)
    love.graphics.clear(0.211764706,0.2,0.223529412)
    for y = -64, height+64, 64 do
        for x = -64, width+64, 64 do
            love.graphics.draw(tile, x+(nodemgr.offsetX/1.6 % 64), y+(nodemgr.offsetY/1.6 % 64))
        end
    end

	for y = -80, height+80, 80 do
        for x = -80, width+80, 80 do
            love.graphics.draw(tilenear, x+(nodemgr.offsetX/1.2 % 80), y+(nodemgr.offsetY/1.2 % 80))
        end
    end

    nodemgr.drawNodes()

    -- dragging
    local mouseDown = love.mouse.isDown(1)
    if(mouseDown) then
        if(not mouseDownBef) then 
            handleClick()
        end
        handleDrag()
    end
    mouseDownBef=mouseDown

    hud.render(width,height)

    -- hover message
    local mx,my = love.mouse.getPosition()
    local hoverMsg=nodemgr.getHoverMessage(mx,my)
    if hoverMsg~=nil then
        renderHover("[i] "..hoverMsg,mx,my)
    end

    -- NBAR text
    love.graphics.setColor(0.9,0.9,0.9)
    love.graphics.print('NBAR - Node-Based Analog Renderer '..vernum, 5, height-20)
end

function love.keypressed(key,scancode,isrepeat)
    if key=="space" then
        nodemgr.configureHoveredNode()
    end
    if key=="backspace" or key=="delete" then
        nodemgr.removeHoveredNode()
    end
end
