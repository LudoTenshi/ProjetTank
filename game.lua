local game = {}

game.quadList = {}
game.StriteList = {}

game.language = "fr"

game.dtSpeed = 5

game.ESTATES = {
    NONE = "",
    WALK = "walk",
    ATTACK = "attack",
    BITE = "bite",
    CHANGEDIR = "change",
    DEAD = "dead"
}
game.cursor = {}
game.DIRECTION = {
    "x",
    "y",
    "-x",
    "-y"
}

game.transitionOpac = 0

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

function game.CreateSprite(psNameQuad,psNameSprite,pnStart,pnEnd,pNoRepead)
    if pNoRepead == nil then
        pNoRepead = false
    end
    local sprite =  {}

    for i, quad in ipairs(game.quadList) do
        if quad.name == psNameQuad then
            sprite.name = psNameSprite
            sprite.quad = psNameQuad
            sprite.currentImg = 1
            sprite.currentImgNorepeat = false
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

function game.DrawSprite(psNameSprite,pX,pY,pAngle,pnScale,pOx,pOy,pCurrentImg)

    for i, sprite in ipairs(game.StriteList) do 
        if sprite.name == psNameSprite and #sprite.list ~= 0 then
            if pCurrentImg ~= 0 then
                love.graphics.draw(sprite.tileSheet,sprite.list[math.floor(pCurrentImg)],pX,pY,pAngle,pnScale,pnScale,pOx,pOy)
            else
                love.graphics.draw(sprite.tileSheet,sprite.list[math.floor(sprite.currentImg)],pX,pY,pAngle,pnScale,pnScale,pOx,pOy)
            end
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
                if sprite.currentImgNorepeat == false then
                    sprite.currentImg = 1
                else
                    sprite.currentImg = #sprite.list
                end
               
            end
        end
    end
end

function game.ReturnNbFrame(psName,pbSprite)
    for i, sprite in ipairs(myGame.StriteList) do
        if sprite.quad == psName and not pbSprite or sprite.name == psName and pbSprite then
           return #sprite.list
        end
    end
    return 1
end

function game.createCursor()
    game.cursor = love.mouse.newCursor("/images/cursor2.png",0,0)
end

function game.transitionUpdate(dt)

    if game.transitionOpac < 1 and mySceneManager.preScene ~= "transition" then
        game.transitionOpac = game.transitionOpac + dt
        if game.transitionOpac >= 1 then
            mySceneManager.preScene = mySceneManager.scene 
            mySceneManager.scene = mySceneManager.secScene
            game.transitionOpac = 1
        end
    else
        game.transitionOpac = game.transitionOpac - dt
        if game.transitionOpac <= 0 then
            mySceneManager.preScene = "transitionEnd"
        end
    end
end

function game.transitionDraw()
    love.graphics.setColor(1, 1, 1, game.transitionOpac)
    love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)
    love.graphics.setColor(1, 1, 1,1)
end

function game.newGame()
    myHero.life = myHero.lifeMax
    myEnnemy.list = {}
    myHero.shoot = false
    myHero.dead = false
    myHero.x = 15 * myMapManager.TileWIDHT
    myHero.y = 11 * myMapManager.TileHEIGHT
    mySceneManager.map = "map1"
    myDialogueManager.indexDial = 1
    myDialogueManager.endDial = false
    myDialogueManager.estEvenement = false
    --reinitialize evenement 
    for i, args in ipairs(myEvenement.lst) do
        args.estExe = false
    end
    myEvenement.current = false
end

return game