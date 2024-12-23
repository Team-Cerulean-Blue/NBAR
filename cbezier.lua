-- calculate a point on a cubic bezier curve
function cubicBezier(t, p0, p1, p2, p3)
    local u = 1 - t
    local tt = t * t
    local uu = u * u
    local uuu = uu * u
    local ttt = tt * t

    -- bezier equation
    local x = uuu * p0.x + 3 * uu * t * p1.x + 3 * u * tt * p2.x + ttt * p3.x
    local y = uuu * p0.y + 3 * uu * t * p1.y + 3 * u * tt * p2.y + ttt * p3.y

    return { x = x, y = y }
end

-- draw the bezier curve as a series of line segments
function cubic.drawBezier(p0, p1, p2, p3, segments)
    local points = {}

    -- calculate points along the curve
    for i = 0, segments do
        local t = i / segments
        local point = cubicBezier(t, p0, p1, p2, p3)
        table.insert(points, point.x)
        table.insert(points, point.y)
    end

    -- draw the curve
    love.graphics.setColor(1,1,1,0.7) -- this is the color of node wires [the program only has dark mode as of v0.2.2]
    love.graphics.line(points)
end
