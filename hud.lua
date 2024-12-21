local hudmgr = {}

hudmgr.nodes = {}

function hudmgr.addNodeToHud(node)
    print("Inserted node "..node.title)
    table.insert(hudmgr.nodes,node)
end

function hudmgr.handleNodeModule(mod)
    print("Loading module "..mod.."...")
    xpcall(function()
        require(mod)(hudmgr.nodemgr,hudmgr.addNodeToHud)
        print("Successfully loaded module "..mod..".")
    end,function(err)
        print("An error occured while trying to load the \""..mod.."\" module.\n"..err)
    end)
end

function hudmgr.handleNodeModules(mods)
    for i,mod in ipairs(mods) do
        hudmgr.handleNodeModule(mod)
    end
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

    love.graphics.setColor(node.color)
    love.graphics.rectangle("fill",width-hudWidth,0,hudWidth,height)

    local hovered = hudmgr.getHoveredElemIdx(mx,my)
    love.graphics.setColor(0,0,0)
    for i,node in ipairs(hudmgr.nodes) do
        if i==hovered then
            love.graphics.setColor(0.0,0.572,0.8,0.5)
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
