local shoot = {}

shoot.fireAngle = 0
shoot.tileSheet = love.graphics.newImage("images/heroshoot.png")
shoot.tileTexture = {}
shoot.TILE_WIDTH = 48
shoot.TILE_HEIGHT = 48
shoot.shootDelay = 1.4
shoot.shootDelayNow = 0
shoot.lstShoot = {}
shoot.shootpseed = 1
shoot.imgCurrentShoot = 2
shoot.x = 0
shoot.y = 0
shoot.ox = 0
shoot.oy = 0
shoot.type = "fire"
shoot.distance = 400
shoot.id = 0

function shoot.load()
    myGame.CreateQuad("shoot","heroshoot",shoot.TILE_HEIGHT,shoot.TILE_HEIGHT)

    myGame.CreateSprite("shoot","targetF",1,1)
    myGame.CreateSprite("shoot","fire",2,3)
    myGame.CreateSprite("shoot","targetI",4,4)
    myGame.CreateSprite("shoot","ice",5,6)
end

function shoot.update(dt,hero)
    shoot.x = hero.x
    shoot.y = hero.y
    shoot.ox = hero.ox
    shoot.oy = hero.oy

    if myHero.shoot then
        local mouseX,mouseY = love.mouse.getPosition()

        shoot.aim(mouseX,mouseY)
    
        shoot.shootDelayNow = shoot.shootDelayNow + dt
        
        -- Clique gauche souris
        if love.mouse.isDown(1) and shoot.shootDelayNow > shoot.shootDelay then
            shoot.shootval(shoot.fireAngle,shoot.x,shoot.y,dt)
            if shoot.type == "fire" then
                mySound.playEffect("009")
            else
                mySound.playEffect("022")
            end
            shoot.shootDelayNow = 0
        end
    
        --shoot 
        for i, myShoot in ipairs(shoot.lstShoot) do
            myShoot.velo = myShoot.velo + dt * 1.5
            myShoot.x = myShoot.x + shoot.shootpseed * math.cos(myShoot.angle) * myShoot.velo
            myShoot.y = myShoot.y + shoot.shootpseed * math.sin(myShoot.angle) * myShoot.velo
    
            if shoot.damageEnn(myShoot) then
                if myShoot.type == "fire" then
                    mySound.playEffect("019")
                    table.remove(shoot.lstShoot,i)
                else
                    mySound.playEffect("317")
                end
            end

            if math.dist(myShoot.xInit,myShoot.yInit,myShoot.x,myShoot.y) > shoot.distance then 
                table.remove(shoot.lstShoot,i)
            end

        end
    
        --affichage du shoot sur 2 frames
        myGame.CurrentSprite("shoot",false,dt)
    end
    
end

function shoot.draw()
    if myHero.shoot then
        if (shoot.type == "fire") then 
            --affichage du ciblage-
            myGame.DrawSprite("targetF",shoot.x,shoot.y,shoot.fireAngle,1.2,shoot.ox - 35,shoot.oy,0)
        elseif (shoot.type == "ice") then
            --affichage du ciblage-
            myGame.DrawSprite("targetI",shoot.x,shoot.y,shoot.fireAngle,1.2,shoot.ox - 35,shoot.oy,0)
        end

            --affichage du shoot
        for i = 1, #shoot.lstShoot do
            myGame.DrawSprite(shoot.lstShoot[i].type,shoot.lstShoot[i].x,shoot.lstShoot[i].y,shoot.lstShoot[i].angle,1.5,shoot.ox - 35,shoot.oy,0)
        end
    end
    
    
end

function shoot.aim(pX,pY)
    shoot.fireAngle = math.atan2(pY - shoot.y,pX - shoot.x)
end

function shoot.shootval(pAngle,pX,pY,dt)
    shoot.id = shoot.id + 1
    local shootVal = {
        id = shoot.id,
        x = pX,
        y = pY,
        ox = shoot.ox,
        oy = shoot.oy,
        xInit = pX,
        yInit = pY,
        angle = pAngle,
        velo = 2 * dt,
        type = shoot.type,
    }
    if shootVal.type == "fire" then
        shootVal.damage = 10
    else
        shootVal.damage = 5
    end
    table.insert(shoot.lstShoot,shootVal)

end

function shoot.keypressed(key)
    if (key == "space") then
        if (shoot.type == "fire") then
            shoot.type = "ice"
        else 
            shoot.type = "fire"
        end
    end
end

function shoot.damageEnn(pShoot)
    local sdx = pShoot.x - pShoot.ox
    local sfx = pShoot.x + pShoot.ox
    local sdy = pShoot.y + pShoot.oy
    local sfy = pShoot.y + pShoot.oy
    for index, pEnn in ipairs(myEnnemy.list) do
        local dx = pEnn.x - myEnnemy.oX
        local fx = pEnn.x + myEnnemy.oX
        local dy = pEnn.y - myEnnemy.oY
        local fy = pEnn.y + myEnnemy.oY
        if (sdx > dx or sfx > dx) and ( sdx < fx or sfx < fx)
        and (sdy > dy or sfy > dy) and (sdy < fy or sfy < fy) then
            if pShoot.id ~= pEnn.IdDamage then
                myEnnemy.damageIn(pShoot.damage,pEnn,pShoot.type)
                pEnn.IdDamage = pShoot.id
                return true
            end
        end
    end
    return false
end

return shoot