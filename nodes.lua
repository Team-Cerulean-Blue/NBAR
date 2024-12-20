local nodemgr = {}

-- Node inputs
nodemgr.inputs={
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
["title"] = "[title]",
["inputs"] = {},
["numberInputs"] = {},
["run"] = function(selfvar,numberInputs,inputStreams,outputStreams)
    print("Node setup for "+selfvar["id"]+" has not added a run function.")
end
}

-- Node on-screen "class"
nodemgr.screenNodeClass = {
["x"] = 0,
["y"] = 0,
["render"] = function(selfvar)
    local padding = 4;

    local font = love.graphics.getFont()
    local txtWidth =font:getWidth(selfvar.node.title)
    local txtHeight=font:getHeight(selfvar.node.title)

    local rectBox={selfvar.x,selfvar.y,txtWidth+padding*2,txtHeight+padding*2}

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",rectBox[1],rectBox[2],rectBox[3],rectBox[4])
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",rectBox[1],rectBox[2],rectBox[3],rectBox[4])

    love.graphics.setColor(0,0,0)
    love.graphics.print(selfvar.node.title,selfvar.x+padding,selfvar.y+padding)
end
}

-- node list and rendering
nodeList={}

function nodemgr.drawNodes()
    for i, scrnode in ipairs(nodeList) do
        scrnode:render()
    end
end

-- adding a node
function nodemgr.addNodeToScreen(node)
    local scrnode = nodemgr.screenNodeClass
    scrnode.node=node
    scrnode.x=30
    scrnode.y=20
    table.insert(nodeList,scrnode)
end
nodemgr.addNodeToScreen(nodemgr.nodeClass)


return nodemgr
