local interface = {}

interface.image = {
    love.graphics.newImage("images/UI/HUD_Menus_HL.png"), --1
    love.graphics.newImage("images/UI/HUD_Menus_H.png"), --2
    love.graphics.newImage("images/UI/HUD_Menus_F.png") --3
}
interface.imgHeight = interface.image[1]:getHeight()
interface.imgWidth = interface.image[1]:getWidth()
interface.x = interface.imgWidth * 0.5
interface.y = interface.imgHeight * 0.5
interface.mapping = {
    col = 13,
    line = 5,
    map = {
        {1,2,2,2,2,2,2,2,2,2,2,2,1},
        {2,3,3,3,3,3,3,3,3,3,3,3,2},
        {2,3,3,3,3,3,3,3,3,3,3,3,2},
        {2,3,3,3,3,3,3,3,3,3,3,3,2},
        {1,2,2,2,2,2,2,2,2,2,2,2,1}
    }
}

function interface.draw()
    local c,l
    local angle = 0
    for l = 1,interface.mapping.line do
        for c = 1, interface.mapping.col  do
            angle = 0
            if c == interface.mapping.col then
                angle = math.rad(90)
            end
            if l > 1 and c == 1 then
                angle = math.rad(-90)
            end
            if l == interface.mapping.line and c ~= 1 then
                angle = math.rad(180)
            end
            love.graphics.draw(interface.image[interface.mapping.map[l][c]],
                                interface.x + (c-1) * interface.imgWidth ,
                                interface.y + (l-1) * interface.imgHeight,
                                angle,1,1,interface.imgHeight * 0.5, 
                                interface.imgWidth * 0.5)
        end
    end
end

return interface