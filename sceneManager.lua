local sceneManager = {}

sceneManager.scene = "intro"

function sceneManager.update(dt)
    if sceneManager.scene == "intro" then
        myIntro.update(dt)
    end
    if sceneManager.scene == "game1" then
        myHero.update(dt)
        myEnnemy.update(dt)
        myInterface.update(dt)
        myDialogueManager.update(dt)
    end
    
end

function sceneManager.draw()
    if sceneManager.scene == "intro" then
        myIntro.draw()
    end
    if sceneManager.scene == "game1" then
        myHero.draw()
        myInterface.draw()
        myDialogueManager.draw()
    end
end

function sceneManager.keypressed(key)
    --1er écran du jeux
    if sceneManager.scene == "game1" then
        myDialogueManager.keypressed(key)
    end

    --Intro a mettre a la fin pour éviter les touches qui ce lance apres le changement d'intro
    if sceneManager.scene == "intro"then
        if key == "space" then
            mySound.playEffect("001.mp3")
            sceneManager.scene = "game1"
            love.mouse.setCursor(myGame.cursor)
            
        else
            myIntro.keypressed(key)
        end
    end
    
end


return sceneManager