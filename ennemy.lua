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
ennemy.lifeMax = 10
ennemy.nbSpawn = 0

ennemy.list = {}
ennemy.nbSpriteAtt = 4.5

function ennemy.load()

    myGame.CreateQuad("ennemy","Snake_Alien_Idle",ennemy.TILE_HEIGHT,ennemy.TILE_WIDTH)

    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKEB,1,4)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKEL,5,8)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKER,9,12)
    myGame.CreateSprite("ennemy",ennemy.DIRECTION_SPRITE.SNAKET,13,16)

    myGame.CreateQuad("ennemyAtt","Snake_Alien_Attack",ennemy.TILE_HEIGHT,ennemy.TILE_WIDTH)

    myGame.CreateSprite("ennemyAtt",ennemy.DIRECTION_SPRITE.SNAKEB .. "Att",1,6)
    myGame.CreateSprite("ennemyAtt",ennemy.DIRECTION_SPRITE.SNAKEL .. "Att",7,12)
    myGame.CreateSprite("ennemyAtt",ennemy.DIRECTION_SPRITE.SNAKER .. "Att",13,18)
    myGame.CreateSprite("ennemyAtt",ennemy.DIRECTION_SPRITE.SNAKET .. "Att",19,24)
end

function ennemy.update(dt)

    myGame.CurrentSprite("ennemy",false,dt)
    myGame.CurrentSprite("ennemyAtt",false,dt)

    for i, enn in ipairs(ennemy.list) do
        if enn.state == myGame.ESTATES.NONE then
            ennemy.pending(dt,enn)
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

function ennemy.createEnnemy(pNbEnn,px,py,pRx,pRy)

    for i=1, pNbEnn do
        ennemy.list[i] = {
            type = ennemy.DIRECTION_SPRITE.SNAKEL,
            x = math.random(px, px + pRx),
            y = math.random(py, py + pRy),
            ox = px,
            oy = py,
            rx = px + pRx,
            ry = py + pRy,
            draw = false,
            state = myGame.ESTATES.WALK,
            direction = nil,
            distance = ennemy.distance,
            timmingA = 0,
            damage = 10,
            actifDamage = false,
            dtDamage = 1,
            life = ennemy.lifeMax
        }
        ennemy.nbSpawn = ennemy.nbSpawn + 1
    end
end

function ennemy.draw()

    for i, myEnnemy in ipairs(ennemy.list) do
        myGame.DrawSprite(myEnnemy.type,myEnnemy.x,myEnnemy.y,0,1.5,ennemy.oX,ennemy.oY)
    end
    
end

function ennemy.walk(dt,pEnn)
    
    --Change direciton
    if pEnn.direction == nil then 
        local iRand = love.math.random(1,4)
        pEnn.direction = iRand
    end
    if myGame.DIRECTION[pEnn.direction] == "x" then
        pEnn.x = pEnn.x + dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKER
        if pEnn.x >= pEnn.ox + pEnn.rx or myMapManager.collision(pEnn.x,pEnn.y,pEnn.ox,pEnn.oy) then
            pEnn.x = pEnn.x - dt * ennemy.dtSpeed
            pEnn.direction = 3
        end
    elseif myGame.DIRECTION[pEnn.direction] == "-x" then
        pEnn.x = pEnn.x - dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEL
        if pEnn.x <= pEnn.ox  or myMapManager.collision(pEnn.x,pEnn.y,pEnn.ox,pEnn.oy) then
            pEnn.x = pEnn.x + dt * ennemy.dtSpeed
            pEnn.direction = 1
        end
    elseif myGame.DIRECTION[pEnn.direction] == "y" then
        pEnn.y = pEnn.y + dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEB
        if pEnn.y >= pEnn.oy + pEnn.ry or myMapManager.collision(pEnn.x,pEnn.y,pEnn.ox,pEnn.oy) then
            pEnn.y = pEnn.y - dt * ennemy.dtSpeed
            pEnn.direction = 4
        end
    elseif myGame.DIRECTION[pEnn.direction] == "-y" then
        pEnn.y = pEnn.y - dt * ennemy.dtSpeed
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKET
        if pEnn.y <= pEnn.oy or myMapManager.collision(pEnn.x,pEnn.y,pEnn.ox,pEnn.oy) then
            pEnn.y = pEnn.y + dt * ennemy.dtSpeed
            pEnn.direction = 2
        end
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
    local angle = math.angle(pEnn.x,pEnn.y,myHero.x,myHero.y)

    --test range avec héro
    if math.dist(myHero.x,myHero.y,pEnn.x,pEnn.y) > ennemy.rangeHero then
        pEnn.x = pEnn.x + math.cos(angle) + dt * ennemy.dtSpeed
        pEnn.y = pEnn.y + math.sin(angle) + dt * ennemy.dtSpeed
    end

    if math.cos(angle) > 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKER .. "Att"
    elseif math.cos(angle) < 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEL .. "Att"
    end
    if pEnn.actifDamage == false then
        mySound.playEffect("017")
        myHero.life = myHero.life - pEnn.damage
        myInterface.animationDamage("-" .. pEnn.damage,myHero,false)
        pEnn.actifDamage = true
    end
    pEnn.dtDamage = pEnn.dtDamage + dt * (ennemy.dtSpeed * 0.5)
    if math.floor(pEnn.dtDamage) > ennemy.nbSpriteAtt then
        pEnn.state = myGame.ESTATES.NONE
    end

end

function ennemy.changedir(dt,pEnn)

end

function ennemy.pending(dt,pEnn)
    local angle = math.angle(pEnn.x,pEnn.y,myHero.x,myHero.y)
    if math.cos(angle) > 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKER
    elseif math.cos(angle) < 0 then
        pEnn.type = ennemy.DIRECTION_SPRITE.SNAKEL
    end

    pEnn.timmingA = pEnn.timmingA + dt
    if pEnn.timmingA > 1 then
        pEnn.state = myGame.ESTATES.WALK
        pEnn.timmingA = 0
        pEnn.dtDamage = 1
        pEnn.actifDamage = false
    end
end

function ennemy.damageIn(pDamage,pEnn)

end

return ennemy