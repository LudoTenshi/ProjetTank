local hero = {}

hero.TILE_HEIGHT = 48
hero.TILE_WIDTH = 48
hero.tileType = {}
hero.x = 0
hero.y = 0
hero.movespeed = 100
hero.shootpseed = 1
hero.ox = hero.TILE_HEIGHT * 0.5
hero.oy = hero.TILE_WIDTH * 0.5
hero.direction = nil

hero.lifeMax = 100
hero.life = 100
hero.level = 1

hero.shoot = false

myShoot = require("shoot")

function hero.load()

    hero.x = love.graphics.getWidth() * 0.5 * 0.5
    hero.y = love.graphics.getHeight() * 0.5

    myGame.CreateQuad("hero","hero",hero.TILE_HEIGHT,hero.TILE_HEIGHT)

    myGame.CreateSprite("hero","hero",1,6)
    myGame.CreateSprite("hero","heroR",11,12)
    myGame.CreateSprite("hero","heroL",13,14)
    myGame.CreateSprite("hero","heroT",15,16)
    myGame.CreateSprite("hero","heroB",8,9)

    myShoot.load()
end

function hero.update(dt)

    
    myGame.CurrentSprite("hero",false,dt)

    if myInterface.estDialogue == false then
        if love.keyboard.isDown("d") then 
            hero.x = hero.x + 1 * dt * hero.movespeed
            hero.direction = "right"
        elseif love.keyboard.isDown("q") then
            hero.x = hero.x - 1 * dt * hero.movespeed
            hero.direction = "left"
        elseif love.keyboard.isDown("s") then 
            hero.y = hero.y + 1 * dt * hero.movespeed
            hero.direction = "bottom"
        elseif love.keyboard.isDown("z") then
            hero.y = hero.y - 1 * dt * hero.movespeed
            hero.direction = "top"
        else 
            hero.direction = nil
        end
    end

    myShoot.update(dt,hero)

end 

function hero.draw()
    --affichage du héro
    if hero.direction ~= nil then 
        if hero.direction == "right" then
            myGame.DrawSprite("heroR",hero.x,hero.y,0,1,hero.ox,hero.oy)
        end
        if hero.direction == "left" then
            myGame.DrawSprite("heroL",hero.x,hero.y,0,1,hero.ox,hero.oy)
        end
        if hero.direction == "bottom" then
            myGame.DrawSprite("heroB",hero.x,hero.y,0,1,hero.ox,hero.oy)
        end
        if hero.direction == "top" then
            myGame.DrawSprite("heroT",hero.x,hero.y,0,1,hero.ox,hero.oy)
        end
    else
        myGame.DrawSprite("hero",hero.x,hero.y,0,1,hero.ox,hero.oy)
    end
    
    myShoot.draw()

end

function hero.keypressed(key)
    myShoot.keypressed(key)
end


return hero