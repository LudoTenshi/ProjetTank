if arg[#arg] == "vsc_debug" then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

myGame = require("game")
myHero = require("hero")
myEnnemy = require("ennemy")
myMap = require("map1")

function love.load()

    love.window.setMode(1920,1056)

    screenWidth = love.graphics:getWidth()
    screenHeight = love.graphics:getHeight()

    myHero.load()

    myEnnemy.load()

    myEnnemy.createEnnemy()
end

function love.update(dt)
    myHero.update(dt)
    myEnnemy.update(dt)
end

function love.draw()
    myHero.draw()
    myEnnemy.draw()
end

function love.keypressed(key)
    myHero.keypressed(key)
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function math.angle(x1,y1,x2,y2) return math.atan2(y2-y1,x2-x1) end