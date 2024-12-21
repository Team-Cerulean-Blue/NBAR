local hudmgr = {}

hudmgr.nodes = {}

function hudmgr.handleNodeModule(mod)
    local node = require(mod)(hudmgr.nodemgr);
    -- print(node)
    table.insert(hudmgr.nodes,node)
end

hudWidth = 140

function hudmgr.getHoveredElemIdx(mx,my)
    if mx<width-hudWidth then
        return nil
    end
    local out = math.floor(my/20)+1
    if out<=0 or out>#hudmgr.nodes then
        return nil
    end
    return out
end

function hudmgr.render(width,height)
    local mx,my = love.mouse.getPosition()

    love.graphics.setColor(0.9529411764705882,0.9137254901960784,1,0.5)
    love.graphics.rectangle("fill",width-hudWidth,0,hudWidth,height)

    local hovered = hudmgr.getHoveredElemIdx(mx,my)
    love.graphics.setColor(0,0,0)
    for i,node in ipairs(hudmgr.nodes) do
        if i==hovered then
            love.graphics.setColor(0.4823529411764706,0.3137254901960784,0.43529411764705883,0.5)
            love.graphics.rectangle("fill",width-hudWidth,(i-1)*20,hudWidth,20)
            love.graphics.setColor(0,0,0)
        end
        love.graphics.print(node.shortTitle,width-(hudWidth-4),(i-1)*20+2)
    end
end

function hudmgr.touching(mx,my,width,height)
    return mx>=width-hudWidth
end

function hudmgr.handleClick(mx,my,width,height)
    local hovered = hudmgr.getHoveredElemIdx(mx,my)
    if hovered==nil then
        return nil
    end
    local node = hudmgr.nodes[hovered]
    hudmgr.nodemgr.addNodeToScreen(node)
end

return hudmgr
