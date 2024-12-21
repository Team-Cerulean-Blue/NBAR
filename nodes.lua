local nodemgr = {}

-- Node inputs
nodemgr.ioElem={
["digital"] = {0},
["analog"] = {1,0},
["audioleft"] = {1,1},
["audioright"] = {1,2},
["avideo"] = {1,3},
["dynval"] = {2}
}

-- Node "class"
nodemgr.nodeClass = {
["id"] = "default",
["title"] = "Unknown element",
["shortTitle"] = "[title]",
["about"] = nil,
["inputs"] = {},
["outputs"] = {},
["numberInputs"] = {},
["run"] = function(selfvar,numberInputs,inputStreams,outputStreams)
    print("Node setup for "+selfvar["id"]+" has not added a run function.")
end
}

-- Node I/O rendering
function renderIO(type,x,y)
    --print(type,x,y)
    function circle(r,g,b)
        love.graphics.setColor(r,g,b)
        love.graphics.circle("fill",x,y,6.5)
    end

    if(type==nodemgr.ioElem.digital) then
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill",x-4,y-6,8,12)
    elseif(type==nodemgr.ioElem.analog)     then circle(.5,.5,.5)
    elseif(type==nodemgr.ioElem.audioleft)  then circle(1,1,1)
    elseif(type==nodemgr.ioElem.audioright) then circle(1,0,0)
    elseif(type==nodemgr.ioElem.avideo)     then circle(1,1,0)
    end
end

-- Node on-screen "class"
local nodeRenderPadding = 4
local nodeIOElemHeight = 16
nodemgr.screenNodeClass = {
["x"] = 0,
["y"] = 0,
["getWrappedText"] = function(selfvar)
    local txtWidth, wrappedtext = font:getWrap( selfvar.node.title, 140 )
    return txtWidth, table.concat(wrappedtext,"\n"), #wrappedtext
end,
["getBboxRect"] = function(selfvar)
    -- bounding box, returns {x,y,width,height}
    local txtWidth, txt, txtLines = selfvar:getWrappedText()
    -- local txtWidth =font:getWidth(txt)
    local txtHeight=font:getHeight(txt)*txtLines
    -- print(txtWidth, txtHeight)

    local rectWidth = txtWidth;
    local rectHeight = math.max(txtHeight,math.max(#selfvar.node.inputs,#selfvar.node.outputs)*nodeIOElemHeight);

    return {selfvar.x+nodemgr.offsetX,selfvar.y+nodemgr.offsetY,rectWidth+nodeRenderPadding*2,rectHeight+nodeRenderPadding*2}
end,
["getBbox"] = function(selfvar)
    -- bounding box, returns {left,top,right,bottom}
    local rect = selfvar:getBboxRect()
    return {rect[1],rect[2],rect[1]+rect[3],rect[2]+rect[4]}
end,
["isHovered"] = function(selfvar,mx,my)
    local bbox = selfvar:getBbox()
    return mx>=bbox[1] and mx<=bbox[3] and my>=bbox[2] and my<=bbox[4]
end,
["render"] = function(selfvar)
    local wTextWidth, wrappedText, wrappedTextLines = selfvar:getWrappedText()

    local rectBox = selfvar:getBboxRect()

    for i, input in ipairs(selfvar.node.inputs) do
        local ioX = rectBox[1]
        local ioY = rectBox[2]+(i-0.5)*nodeIOElemHeight+nodeRenderPadding
        renderIO(input,ioX,ioY)
    end

    for i, input in ipairs(selfvar.node.outputs) do
        local ioX = rectBox[1]+rectBox[3]
        local ioY = rectBox[2]+(i-0.5)*nodeIOElemHeight+nodeRenderPadding
        renderIO(input,ioX,ioY)
    end

    love.graphics.setColor(0.7,0.7,0.7)
    love.graphics.rectangle("line",rectBox[1],rectBox[2],rectBox[3],rectBox[4],5,5,5)
    love.graphics.setColor(selfvar.node.color,0.2)
    love.graphics.rectangle("fill",rectBox[1],rectBox[2],rectBox[3],rectBox[4],5,5,5)

    love.graphics.setColor(1.0,1.0,1.0)
    love.graphics.print(wrappedText,rectBox[1]+nodeRenderPadding,rectBox[2]+nodeRenderPadding)
end
}

-- node list and rendering
nodeList={}
nodemgr.offsetX=0
nodemgr.offsetY=0

function nodemgr.drawNodes()
    for i, scrnode in ipairs(nodeList) do
        scrnode:render()
    end
end

function nodemgr.getHoverMessage(mx,my)
    local hover=nil
    for i, scrnode in ipairs(nodeList) do
        if(scrnode:isHovered(mx,my)) then
            hover=scrnode.node.about
        end
    end
    return hover
end

-- adding a node
function nodemgr.addNodeToScreen(node)
    local scrnode = table.shallow_copy(nodemgr.screenNodeClass)
    scrnode.node=node
    scrnode.x=math.random(10,200)
    scrnode.y=math.random(10,200)
    table.insert(nodeList,scrnode)
end

-- getting the node that is getting hovered
function nodemgr.hoveringNode()
    local mx,my = love.mouse.getPosition()
    for i, scrnode in ipairs(nodeList) do
        if(scrnode:isHovered(mx,my)) then
            return scrnode
        end
    end
    return nil
end

-- use this to test nodes
--[[ local myNode = table.shallow_copy(nodemgr.nodeClass)
myNode.title="Hello, World!"
myNode.inputs={nodemgr.ioElem.avideo,nodemgr.ioElem.audioleft,nodemgr.ioElem.audioright}
myNode.outputs={nodemgr.ioElem.digital}
nodemgr.addNodeToScreen(myNode)
nodemgr.addNodeToScreen(nodemgr.nodeClass) ]]


return nodemgr
