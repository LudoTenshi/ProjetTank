local interface = {}

interface.image = {
    hero = love.graphics.newImage("images/avatarhero.png"),
    Korisai = love.graphics.newImage("images/avatarpnj.png"),
    Voice_World = love.graphics.newImage("images/VoiceWorld.png"),
}
interface.imgHeight = 48
interface.imgWidth = 48

interface.infoHero = {}
--interface.textX = interface.x * 0.5
--interface.textY = interface.y * 0.5
interface.listMapping = {}

love.graphics.setFont (love.graphics.newFont (25))
interface.textFond = love.graphics.getFont()
interface.text = love.graphics.newText(interface.textFond)

interface.dialogue = {}
interface.estDialogue = false
interface.estAnimation = false
interface.dtLine = 2
interface.dtCol  = 2

interface.margeTop = 200

interface.damageLst = {}
interface.damagedtSpeed = 5

interface.gameover = {
    imgfond = love.graphics.newImage("images/UI/GAMEOVER.jpg"),
    opacity = 0
}

function interface.load()
    myGame.CreateQuad("UIdial","UI/UIdial",interface.imgWidth,interface.imgHeight)

    myGame.CreateSprite("UIdial","HUD1",1,1)
    myGame.CreateSprite("UIdial","HUD2",2,2)
    myGame.CreateSprite("UIdial","HUD3",3,3)
end

function interface.update(dt)
    if #interface.infoHero == 0 then
        local listText = {
            {{2,2,2},"HP : " .. tostring(myHero.life) .. " / " .. tostring(myHero.lifeMax)},
            {},
            {{2,2,2},myTranslation.returnLang(myGame.language,"level") .. " : " .. tostring(myHero.level)}
        }
        interface.infoHero = interface.createMapAndText(6,13,listText,interface.imgHeight * 0.5,interface.imgWidth * 0.5,"")
    end
    for index, damage in ipairs(interface.damageLst) do
       damage.y = damage.y - dt * interface.damagedtSpeed
       damage.opacity = damage.opacity - dt * interface.damagedtSpeed * 25
    end

    if mySceneManager.scene == "gameOver" then
        if interface.gameover.opacity < 0.80 then
            interface.gameover.opacity = interface.gameover.opacity + dt * 0.5
        end
    end
end

function interface.draw()
    interface.drawMapping(interface.infoHero)

    for index, damage in ipairs(interface.damageLst) do
        local text = love.graphics.newText(interface.textFond)
        local R,G,B,A = love.math.colorFromBytes(damage.R,damage.G,damage.B,damage.opacity)
        text:add({{R,G,B,A},damage.text})
        
        love.graphics.draw(text,damage.x,damage.y,0,1,1)
    end

    if mySceneManager.scene == "gameOver" then
        love.graphics.setColor(1, 1, 1,interface.gameover.opacity * 0.5)
        love.graphics.rectangle("fill",1,1,screenWidth,screenHeight)
        love.graphics.setColor(1, 1, 1,interface.gameover.opacity)
        love.graphics.draw(interface.gameover.imgfond,0,0)
        --love.graphics.setColor(1, 1, 1,1)
    end
end

function interface.drawMapping(pMapping)
    local c,l
    local angle = 0
    if pMapping.img ~= "" then
        love.graphics.draw(pMapping.img,pMapping.mapX,pMapping.mapY - pMapping.img:getHeight(),0,1,1)
    end
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
                --love.graphics.draw(interface.image[pMapping.map[l][c]],
                                    --pMapping.mapX + (c-1) * interface.imgWidth ,
                                    --pMapping.mapY + (l-1) * interface.imgHeight,
                                    --angle,1,1,interface.imgHeight * 0.5,
                                    --interface.imgWidth * 0.5)
                myGame.DrawSprite("HUD" .. pMapping.map[l][c],
                                    pMapping.mapX + (c-1) * interface.imgWidth * 0.5,
                                    pMapping.mapY + (l-1) * interface.imgHeight * 0.5,
                                    angle,0.5,interface.imgHeight * 0.5,
                                    interface.imgWidth* 0.5,0)
            end
        end
    
        love.graphics.draw(pMapping.text,pMapping.mapX,pMapping.mapY,0,1,1)
    end
end

function interface.createMapAndText(pLine,pColumn,pText,pX,pY,pImg)
    
    local mapping = { 
        col = pColumn,
        line = pLine,
        map = {},
        text = love.graphics.newText(interface.textFond),
        mapX = pX,
        mapY = pY,
        img = pImg,
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
    local pX,pY,img
    local pLine,pColumn = 2,0
    local sText = {}
    --Calcul le nombre de ligne et collonne pour que le cadre prenne bien tout le texte
    for index , text in ipairs(pText) do
        local pTextExpl 
        if pEstHero == true then
            pTextExpl = text / "\n"
        else
            pTextExpl = text.text / "\n"
            img = interface.image[text.name]
            table.insert(sText,text.text)
        end
        
        for index , args in ipairs(pTextExpl) do
            if pColumn < 1 + math.floor(string.len(args) / 1.60) then
                pColumn = 1 + math.floor(string.len(args) / 1.60)
            end
            pLine = pLine + 1
        end
    end
    --test si c'est le hero qui parle ou pnj
    if pEstHero == true then
        pX = myHero.x
        pY = myHero.y - pLine * (myHero.TILE_HEIGHT * 0.75)
        img = interface.image.hero
        sText = pText
    else
        pX = screenWidth * 0.5 - pColumn * interface.imgWidth * 0.25
        pY = interface.margeTop
    end

    if interface.estAnimation == true then
        
        if(interface.dtLine <= pLine ) then
            interface.dtLine = interface.dtLine + 10 * pLine  * dt
        end
        if(interface.dtCol <= pColumn ) then
            interface.dtCol = interface.dtCol +  dt * 10 * pColumn
        end
        if (interface.dtLine >= pLine) and (interface.dtCol >= pColumn)then
            AnimationD = interface.createMapAndText(pLine,pColumn,sText,pX,pY,img)
            interface.dtLine = 2
            interface.dtCol  = 0
            interface.estAnimation = false
        else
            AnimationD = interface.createMapAndText(math.floor(interface.dtLine),math.floor(interface.dtCol),{""},pX,pY,img)
        end
    else
        AnimationD = interface.createMapAndText(pLine,pColumn,sText,pX,pY,img)
        interface.dtLine = 2
        interface.dtCol  = 0
        interface.estAnimation = false
    end
    
    interface.estDialogue = true

    return AnimationD
    
end

function interface.animationDamage(pText,pSprite,estPlayer)
    local damage = {}
    if estPlayer == false then 
        damage = {
            x = pSprite.x - pSprite.ox,
            y = pSprite.y - pSprite.oy * 1.5,
            text = pText,
            opacity = 255
        }
    else
        damage = {
            x = pSprite.x ,
            y = pSprite.y - myEnnemy.oY * 2,
            text = pText,
            opacity = 255
        }
    end
    
    if estPlayer == true then
        if myShoot.type == "fire"  then
            damage.R,damage.G,damage.B = 255, 153, 10
        else
            damage.R,damage.G,damage.B = 51, 204, 204
        end
    else
        damage.R,damage.G,damage.B = 255, 10, 10
    end

    table.insert(interface.damageLst,damage)
end

return interface