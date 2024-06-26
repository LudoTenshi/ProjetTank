local game = {}

game.quadList = {}
game.StriteList = {}

game.dtSpeed = 5

game.ESTATES = {
    NONE = "",
    WALK = "walk",
    ATTACK = "attack",
    BITE = "bite",
    CHANGEDIR = "change"
}

game.DIRECTION = {
    "x",
    "y",
    "-x",
    "-y"
}

function game.CreateQuad(psName,psImageSheet,psHeightImg,psWidthImg)
    local quad = {}

    local i 

    --test si le quad existe déja 
    for i , quad in ipairs(game.quadList) do 
        if psName == quad.name then
            return
        end
    end

    quad.name = psName
    quad.tileSheet = love.graphics.newImage("images/"..psImageSheet..".png")
    
    quad.tileTexture = {}
    quad.tileTexture[0] = nil

    local c,nbCol,nbLine
    nbCol = quad.tileSheet:getWidth() / psWidthImg
    nbLine = quad.tileSheet:getHeight() / psHeightImg
    local id = 1

    for l = 1, nbLine do
        for c = 1, nbCol do
            quad.tileTexture[id] = love.graphics.newQuad(
                (c-1) * psWidthImg,
                (l-1) * psHeightImg,
                psWidthImg,
                psHeightImg,
                quad.tileSheet:getWidth(),
                quad.tileSheet:getHeight()
            )

            id = id + 1
        end
    end

    table.insert(game.quadList,quad)
end

function game.CreateSprite(psNameQuad,psNameSprite,pnStart,pnEnd)
    local sprite =  {}
    local i
    for i, quad in ipairs(game.quadList) do
        if quad.name == psNameQuad then
            sprite.name = psNameSprite
            sprite.quad = psNameQuad
            sprite.currentImg = 1
            sprite.tileSheet = quad.tileSheet
            sprite.list = {}
            local spriteid = 1
            for id = pnStart, pnEnd do
                sprite.list[spriteid] = quad.tileTexture[id]
                spriteid = spriteid + 1
            end

            table.insert(game.StriteList,sprite)
        end
    end
end

function game.DrawSprite(psNameSprite,pX,pY,pAngle,pnScale,pOx,pOy)
    local i 
    for i, sprite in ipairs(game.StriteList) do 
        if sprite.name == psNameSprite and #sprite.list ~= 0 then
            love.graphics.draw(sprite.tileSheet,sprite.list[math.floor(sprite.currentImg)],pX,pY,pAngle,pnScale,pnScale,pOx,pOy)
        end
    end
end

-- psName nom du quad ou sprite a chercher dans la list
-- pbSprite booléen true si Name est Sprite false si Quad
function game.CurrentSprite(psName,pbSprite,dt)

    for i, sprite in ipairs(myGame.StriteList) do
        if sprite.quad == psName and not pbSprite or sprite.name == psName and pbSprite then
            sprite.currentImg = sprite.currentImg + (game.dtSpeed * dt)
            if sprite.currentImg > #sprite.list + 1 then
                sprite.currentImg = 1
            end
        end
    end
end

return game