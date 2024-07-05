if arg[#arg] == "vsc_debug" then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

require("extension")

mySceneManager = require("sceneManager")
mySound = require("sound")
myTranslation = require("translation")
myMapManager = require("mapManager")
myGame = require("game")
myDialogueManager = require("dialogueManager")
myHero = require("hero")
myEnnemy = require("ennemy")
myIntro = require("intro")
--myMap = require("map1")
myInterface = require("interface")

function love.load()

    love.window.setMode(1920,1080)

    screenWidth = love.graphics:getWidth()
    screenHeight = love.graphics:getHeight()
    myGame.createCursor()
    mySound.load()
    myIntro.load()
    myHero.load()
    myEnnemy.load()
    myMapManager.load()
    myDialogueManager.load()
    --myEnnemy.createEnnemy()
    myInterface.load()

end

function love.update(dt)
    
    mySceneManager.update(dt)
end

function love.draw()
    
    mySceneManager.draw()
 
    
end

function love.keypressed(key)
    mySceneManager.keypressed(key)
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function math.angle(x1,y1,x2,y2) return math.atan2(y2-y1,x2-x1) end