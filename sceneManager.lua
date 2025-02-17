local sceneManager = {}

sceneManager.scene = "intro"
sceneManager.preScene = "intro"
sceneManager.secScene = "intro"
sceneManager.noAction = false
sceneManager.map = "map1"

sceneManager.gameOver = {}

function sceneManager.update(dt)
    if sceneManager.scene == "transition" or sceneManager.preScene == "transition" then
        myGame.transitionUpdate(dt)
    end
    if sceneManager.scene == "intro" then
        myIntro.update(dt)
    end
    if sceneManager.scene == "game1" then
        myDialogueManager.update(dt)
        if myInterface.estDialogue == false then
            myHero.update(dt)
            myEnnemy.update(dt)
        end
        myInterface.update(dt)
        
    end
    if sceneManager.scene == "victory" then
        myDialogueManager.update(dt)
        myInterface.update(dt)
        sceneManager.gameOver = myInterface.DialAnimation({myTranslation.returnLang(myGame.language,"victory")[1].pnj},dt,false)
    end
    if sceneManager.scene == "gameOver" then
        myInterface.update(dt)
        sceneManager.gameOver = myInterface.DialAnimation({myTranslation.returnLang(myGame.language,"gameOver")[1].pnj},dt,false)
    end
    if mySceneManager.preScene == "transitionEnd" then
        sceneManager.noAction = false
    end
end

function sceneManager.draw()
    
    if sceneManager.scene == "intro" or sceneManager.preScene == "intro" then
        myIntro.draw()
    end
    if sceneManager.scene == "game1" then
        myMapManager.draw(sceneManager.map)
        myHero.draw()
        myEnnemy.draw()
        myInterface.draw()
        myDialogueManager.draw()
    end
    if sceneManager.scene == "gameOver" then
        myMapManager.draw(sceneManager.map)
        myHero.draw()
        myEnnemy.draw()
        myDialogueManager.draw()
        myInterface.draw()
        myInterface.drawMapping(sceneManager.gameOver)
    end
    if sceneManager.scene == "victory" then
        myMapManager.draw(sceneManager.map)
        myHero.draw()
        myInterface.draw()
        myDialogueManager.draw()
        myInterface.drawMapping(sceneManager.gameOver)
    end
    if sceneManager.scene == "transition" or sceneManager.preScene == "transition" then
        myGame.transitionDraw()
    end
end

function sceneManager.keypressed(key)
    if sceneManager.noAction == false  then
         --1er écran du jeux
        if sceneManager.scene == "game1" then
            myDialogueManager.keypressed(key)
            myHero.keypressed(key)
        end

        --Intro a mettre a la fin pour éviter les touches qui ce lance apres le changement d'intro
        if sceneManager.scene == "intro"then
            if key == "space" then
                sceneManager.preScene = "intro"
                mySound.playEffect("001")
                sceneManager.scene = "transition"
                sceneManager.noAction = true
                sceneManager.secScene = "game1"
                myDialogueManager.initDial()
                myDialogueManager.sceneDial = 1
                love.mouse.setCursor(myGame.cursor)
            else
                myIntro.keypressed(key)
            end
        end

        -- GameOver
        if sceneManager.scene == "gameOver" or sceneManager.scene == "victory" then
            if key == "space" then
                sceneManager.preScene = "gameOver"
                mySound.playEffect("001")
                sceneManager.scene = "transition"
                sceneManager.secScene = "intro"
                myGame.newGame()
            end
        end
    end
end

function sceneManager.mousemoved(mx,my,mdx,mdy,mistouch)
    if sceneManager.scene == "intro"then 
        myIntro.mousemoved(mx,my,mdx,mdy,mistouch)
    end
end

function sceneManager.mousepressed(mx,my,mbutton)
    if mbutton == 1 and (myDialogueManager.endDial == false 
    or sceneManager.scene == "intro" 
    or sceneManager.scene == "gameOver"
    or sceneManager.scene == "victory") then
        sceneManager.keypressed("space")
    end
end

return sceneManager