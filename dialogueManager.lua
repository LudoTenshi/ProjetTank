local dialogueManager = {}

dialogueManager.lstDialogue = {}
dialogueManager.dialActif = {}
-- index du dialogue en cours
dialogueManager.indexDial = nil
-- Scene de dialogue a afficher == "Dialogue" + i 
dialogueManager.sceneDial = 1
-- Fin du dialogue == true 
dialogueManager.endDial = false
-- savoir si le dialogue viens d'un evenement
dialogueManager.estEvenement = false

function dialogueManager.load()
    dialogueManager.initDial()
end

function dialogueManager.update(dt)
    if mySceneManager.scene == "game1" then
        if dialogueManager.indexDial == nil then
            dialogueManager.indexDial = 1
        end
        dialogueManager.executeDial(dt)
        if dialogueManager.endDial == true then
            myInterface.estDialogue = false
            if dialogueManager.estEvenement == true then
                dialogueManager.estEvenement = false 
                myEvenement.current = false
            end
        end
    end
end

function dialogueManager.draw()
    --love.graphics.print("index : " .. dialogueManager.dialActif.text:getWidth(),400,1)
    if dialogueManager.endDial == false then 
        myInterface.drawMapping(dialogueManager.dialActif)
    else
        myInterface.estDialogue = true
    end
end

function dialogueManager.executeDial(dt)
    if dialogueManager.endDial == false  then
        for index , args in ipairs(dialogueManager.lstDialogue) do
            if args.id == dialogueManager.sceneDial then
                if (args.lstDial[dialogueManager.indexDial].player ~= nil) then
                    dialogueManager.dialActif = myInterface.DialAnimation({args.lstDial[dialogueManager.indexDial].player},dt,true)
                else
                    dialogueManager.dialActif = myInterface.DialAnimation({args.lstDial[dialogueManager.indexDial].pnj},dt,false)
                end
            end
        end 
    end
end

function dialogueManager.initDial()
    local i = 1
    local lstDial = myTranslation.returnLang(myGame.language,"dialogue" + i)
    local objDial = {}
    while lstDial ~= nil do
        objDial = {
            id = i,
            lstDial = lstDial
        }
        table.insert(dialogueManager.lstDialogue,objDial)
        i = i + 1
        lstDial = myTranslation.returnLang(myGame.language,"dialogue" + i)
    end
end

function dialogueManager.keypressed(key)
    if key == "space" then
        dialogueManager.indexDial = dialogueManager.indexDial + 1
        if dialogueManager.indexDial > #dialogueManager.lstDialogue[dialogueManager.sceneDial].lstDial then
            dialogueManager.endDial = true
        else
            myInterface.estDialogue = true
        end
    end 
end

return dialogueManager