if arg[#arg] == "vsc_debug" then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")


love.window.setMode(1920,1080)

screenWidth = love.graphics:getWidth()
screenHeight = love.graphics:getHeight()

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
myInterface = require("interface")
myEvenement = require("evenement")

local mouseX,mouseY 
function love.load()

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

    mouseX,mouseY  = love.mouse.getPosition()
end

function love.draw()
    
    mySceneManager.draw()
 
    love.graphics.print("x : " .. tostring(mouseX) .. " y : " .. mouseY,1,1)
end

function love.keypressed(key)
    mySceneManager.keypressed(key)
end

function love.mousemoved(x,y,dx,dy,istouch)
    mySceneManager.mousemoved(x,y,dx,dy,istouch)
end

function love.mousepressed(x,y,button)
    mySceneManager.mousepressed(x,y,button)
end


function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function math.angle(x1,y1,x2,y2) return math.atan2(y2-y1,x2-x1) end