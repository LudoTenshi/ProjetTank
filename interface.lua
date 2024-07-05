local interface = {}

interface.image = {
    love.graphics.newImage("images/UI/HUD_Menus_HL.png"), --1
    love.graphics.newImage("images/UI/HUD_Menus_H.png"), --2
    love.graphics.newImage("images/UI/HUD_Menus_F.png") --3
}
interface.imgHeight = interface.image[1]:getHeight()
interface.imgWidth = interface.image[1]:getWidth()

interface.infoHero = {}
--interface.textX = interface.x * 0.5
--interface.textY = interface.y * 0.5
interface.listMapping = {}

interface.textFond = love.graphics.getFont()
interface.text = love.graphics.newText(interface.textFond)

interface.dialogue = {}
interface.estDialogue = false
interface.dtLine = 2
interface.dtCol  = 2

interface.margeTop = 200

function interface.load()
    
end

function interface.update(dt)
    if #interface.infoHero == 0 then
        local listText = {
            {{2,2,2},"HP : " .. tostring(myHero.life) .. " / " .. tostring(myHero.lifeMax)},
            {},
            {{2,2,2},myTranslation.returnLang(myGame.language,"level") .. " : " .. tostring(myHero.level)}
        }
        interface.infoHero = interface.createMapAndText(6,13,listText,interface.imgHeight * 0.5,interface.imgWidth * 0.5)
    end
    
end

function interface.draw()
    interface.drawMapping(interface.infoHero)
end

function interface.drawMapping(pMapping)
    local c,l
    local angle = 0
    if pMapping.line ~= nil then
        for l = 1,pMapping.line do
            for c = 1, pMapping.col  do
                angle = 0
                if c == pMapping.col then
                    angle = math.rad(90)
                end
                if l > 1 and c == 1 then
                    angle = math.rad(-90)
                end
                if l == pMapping.line and c ~= 1 then
                    angle = math.rad(180)
                end
                love.graphics.draw(interface.image[pMapping.map[l][c]],
                                    pMapping.mapX + (c-1) * interface.imgWidth ,
                                    pMapping.mapY + (l-1) * interface.imgHeight,
                                    angle,1,1,interface.imgHeight * 0.5,
                                    interface.imgWidth * 0.5)
            end
        end
    
        love.graphics.draw(pMapping.text,pMapping.mapX,pMapping.mapY,0,2,2)
    end
end

function interface.createMapAndText(pLine,pColumn,pText,pX,pY)
    local space
    local mapping = { 
        col = pColumn,
        line = pLine,
        map = {},
        text = love.graphics.newText(interface.textFond),
        mapX = pX,
        mapY = pY
    }

    -- 1 = coin de l'interface
    -- 2 = coté de l'interface
    -- 3 = intérieur de l'interface

    for l = 1 , pLine do
        mapping.map[l] = {}
        for c = 1 , pColumn do
            if(c == 1 and l == 1 
                    or c == pColumn and l == 1 
                    or c==1 and l == pLine 
                    or c==pColumn and l==pLine ) then
                mapping.map[l][c] = 1
            elseif(c > 1 and c < pColumn and l == 1 
                    or c == 1 
                    or c == pColumn and l > 1 and l < pLine 
                    or c > 1 and c < pColumn and l == pLine) then
                mapping.map[l][c] = 2
            elseif(c > 1 and l > 1 and l < pLine) then
                mapping.map[l][c] = 3
            end
        end
    end
    for index , text in ipairs(pText) do
        mapping.text:add(text,5,5 + (index - 1) * interface.textFond:getHeight())
    end
    
    return mapping

end

function interface.DialAnimation(pText,dt,pEstHero)
    local AnimationD = {}
    local pX,pY
    local pLine,pColumn = 2,0
    --Calcul le nombre de ligne et collonne pour que le cadre prenne bien tout le texte
    for index , text in ipairs(pText) do
        local pTextExpl = text / "\n"
        for index , args in ipairs(pTextExpl) do
            if pColumn < 2 + math.floor(string.len(args) / 2.25) then
                pColumn = 2 + math.floor(string.len(args) / 2.25)
            end
            pLine = pLine + 1
        end
    end
    print(interface.dtCol)
    --test si c'est le hero qui parle ou pnj
    if pEstHero == true then
        pX = myHero.x
        pY = myHero.y - pLine * (myHero.TILE_HEIGHT * 0.75)
    else
        pX = screenWidth * 0.5 - pColumn * interface.imgWidth * 0.5
        pY = interface.margeTop
    end

    if interface.estDialogue == false then
        
        if(interface.dtLine <= pLine ) then
            interface.dtLine = interface.dtLine + 20 * dt
        end
        if(interface.dtCol <= pColumn ) then
            interface.dtCol = interface.dtCol + 20 * dt 
        end
        if (interface.dtLine >= pLine) and (interface.dtCol >= pColumn)then
            AnimationD = interface.createMapAndText(pLine,pColumn,pText,pX,pY)
            interface.estDialogue = true
            interface.dtLine = 2
            interface.dtCol  = 2
        else
            AnimationD = interface.createMapAndText(math.floor(interface.dtLine),math.floor(interface.dtCol),{""},pX,pY)
        end
    else
        AnimationD = interface.createMapAndText(pLine,pColumn,pText,pX,pY)
        interface.dtLine = 2
        interface.dtCol  = 2
    end
    
    return AnimationD
    
end

return interface