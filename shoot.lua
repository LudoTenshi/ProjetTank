local shoot = {}

shoot.fireAngle = 0
shoot.tileSheet = love.graphics.newImage("images/heroshoot.png")
shoot.tileTexture = {}
shoot.TILE_WIDTH = 48
shoot.TILE_HEIGHT = 48
shoot.shootDelay = 1
shoot.shootDelayNow = 0
shoot.shoot = {}
shoot.shootpseed = 1
shoot.imgCurrentShoot = 2
shoot.x = 0
shoot.y = 0
shoot.ox = 0
shoot.oy = 0
shoot.type = "fire"
shoot.distance = 400

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

    local mouseX,mouseY = love.mouse.getPosition()

    shoot.aim(mouseX,mouseY)

    shoot.shootDelayNow = shoot.shootDelayNow + dt

    if love.mouse.isDown(1) and shoot.shootDelayNow > shoot.shootDelay then
        shoot.shootval(shoot.fireAngle,shoot.x,shoot.y,dt)
        shoot.shootDelayNow = 0
    end

    --shoot 
    for i, myShoot in ipairs(shoot.shoot) do
        myShoot.velo = myShoot.velo + dt * 1.5
        myShoot.x = myShoot.x + shoot.shootpseed * math.cos(myShoot.angle) * myShoot.velo
        myShoot.y = myShoot.y + shoot.shootpseed * math.sin(myShoot.angle) * myShoot.velo

        if math.dist(myShoot.xInit,myShoot.yInit,myShoot.x,myShoot.y) > shoot.distance then 
            table.remove(shoot.shoot,i)
        end
    end

    --affichage du shoot sur 2 frames
    myGame.CurrentSprite("shoot",false,dt)
    
end

function shoot.draw()
    if (shoot.type == "fire") then 
        --affichage du ciblage-
        myGame.DrawSprite("targetF",shoot.x,shoot.y,shoot.fireAngle,1.2,shoot.ox - 35,shoot.oy)
    elseif (shoot.type == "ice") then
        --affichage du ciblage-
        myGame.DrawSprite("targetI",shoot.x,shoot.y,shoot.fireAngle,1.2,shoot.ox - 35,shoot.oy)
    end
    
    --affichage du shoot
    for i = 1, #shoot.shoot do
        myGame.DrawSprite(shoot.shoot[i].type,shoot.shoot[i].x,shoot.shoot[i].y,shoot.shoot[i].angle,1.5,shoot.ox - 35,shoot.oy)
    end

end

function shoot.aim(pX,pY)
    shoot.fireAngle = math.atan2(pY - shoot.y,pX - shoot.x)
end

function shoot.shootval(pAngle,pX,pY,dt)
    
    local Id = #shoot.shoot + 1
    local shootVal = {}
    shootVal.x = pX
    shootVal.y = pY
    shootVal.xInit = pX
    shootVal.yInit = pY
    shootVal.angle = pAngle
    shootVal.velo = 2 * dt
    shootVal.type = shoot.type
    shoot.shoot[Id] = shootVal

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

return shoot