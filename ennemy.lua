local ennemy = {}

ennemy.TILE_HEIGHT = 128
ennemy.TILE_WIDTH = 128
ennemy.x = 0
ennemy.y = 0
ennemy.distanceMax = 50
ennemy.distance = 0
ennemy.oX = ennemy.TILE_WIDTH * 0.5
ennemy.oY = ennemy.TILE_HEIGHT * 0.5
ennemy.dtSpeed = 10
ennemy.range = 400
ennemy.rangeHero = myHero.TILE_HEIGHT
ennemy.DIRECTION_SPRITE = {
    SNAKEL = "SnakeL",
    SNAKEB = "SnakeB",
    SNAKER = "SnakeR",
    SNAKET = "SnakeT"
}

ennemy.nbSpawn = 10

ennemy.list = {}

function ennemy.load()

    myGame.CreateQuad("ennemy","Snake_Alien_Idle",ennemy.TILE_HEIGHT,ennemy.TILE_WIDTH)

    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKEB,1,4)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKEL,5,8)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKER,9,12)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKET,13,16)

end

function ennemy.update(dt)

    myGame.CurrentSprite("ennemy",false,dt)

    for i, enn in ipairs(ennemy.list) do
        if enn.state == myGame.ESTATES.NONE then
        elseif enn.state == myGame.ESTATES.WALK then 
            ennemy.walk(dt,enn)
        elseif enn.state == myGame.ESTATES.ATTACK then 
            ennemy.attack(dt,enn)
        elseif enn.state == myGame.ESTATES.BITE then 
            ennemy.bite(dt,enn)
        elseif enn.state == myGame.ESTATES.CHANGEDIR then  
            ennemy.changedir(dt,enn)
        end
    end
end

function ennemy.createEnnemy()

    for i=1, ennemy.nbSpawn do
        ennemy.list[i] = {
            type = ennemy.DIRECTION_SPRITE.SNAKEL,
            x = math.random(screenWidth * 0.5, screenWidth ),
            y = math.random(10,screenHeight - 10),
            draw = false,
            state = myGame.ESTATES.WALK,
            direction = nil,
            distance = ennemy.distance,
            timmingA = 0
        }
    end
end

function ennemy.draw()

    for i, myEnnemy in ipairs(ennemy.list) do
        myGame.DrawSprite(myEnnemy.type,myEnnemy.x,myEnnemy.y,0,1,ennemy.oX,ennemy.oY)
    end
    
end

function ennemy.walk(dt,pEnn)
    
    --Change direciton
    if pEnn.direction == nil then 
        local iRand = math.random(1,4)
        pEnn.direction = iRand
    end
    if myGame.DIRECTION[pEnn.direction] == "x" then
        pEnn.x = pEnn.x + dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKER
    elseif myGame.DIRECTION[pEnn.direction] == "-x" then
        pEnn.x = pEnn.x - dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEL
    elseif myGame.DIRECTION[pEnn.direction] == "y" then
        pEnn.y = pEnn.y + dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEB
    elseif myGame.DIRECTION[pEnn.direction] == "-y" then
        pEnn.y = pEnn.y - dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKET
    end
    pEnn.distance = pEnn.distance + dt * ennemy.dtSpeed
    if pEnn.distance > ennemy.distanceMax then
        pEnn.distance = 0
        pEnn.direction = nil
    end

     --test range avec héro
     if math.dist(myHero.x,myHero.y,pEnn.x,pEnn.y) < ennemy.range then
        pEnn.state = myGame.ESTATES.ATTACK
     end
end

function ennemy.attack(dt,pEnn)
    local angle = math.angle(pEnn.x,pEnn.y,myHero.x,myHero.y)

    --test range avec héro
    if math.dist(myHero.x,myHero.y,pEnn.x,pEnn.y) > ennemy.rangeHero then
        pEnn.x = pEnn.x + math.cos(angle) + dt * ennemy.dtSpeed
        pEnn.y = pEnn.y + math.sin(angle) + dt * ennemy.dtSpeed
    else
        pEnn.state = myGame.ESTATES.BITE
    end

    if math.cos(angle) > 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKER
    elseif math.cos(angle) < 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEL
    end
end

function ennemy.bite(dt,pEnn)
    
end

function ennemy.changedir(dt,pEnn)

end

function ennemy.moveInHero(pEnn)

end

return ennemy