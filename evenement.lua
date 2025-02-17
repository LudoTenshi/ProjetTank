local evenement = {}
evenement.current = false
evenement.lst = {
    {
        idMap = "map1",
        x = 18 * myMapManager.TileWIDHT,
        y = 0,
        rX = myMapManager.TileWIDHT,
        rY = screenHeight,
        type = "dialogue",
        exe = 2,-- == sceneDial
        erepeat = false,
        estExe = false,
    },
    {
        idMap = "map1",
        x = 18 * myMapManager.TileWIDHT,
        y = 0,
        rX = myMapManager.TileWIDHT,
        rY = screenHeight,
        type = "hero",
        exe = 1,
        erepeat = false,
        estExe = false,
    },
    {
        idMap = "map1",
        x = 21.5 * myMapManager.TileWIDHT,
        y = 10 * myMapManager.TileHEIGHT,
        rX = 2.5 * myMapManager.TileWIDHT,
        rY = 3 * myMapManager.TileHEIGHT,
        type = "map",
        exe = 2,
        erepeat = true,
        estExe = false,
    },
    {
        idMap = "map2",
        x = 0,
        y = 0,
        rX = screenWidth,
        rY = screenHeight,
        type = "dialogue",
        exe = 3,-- == sceneDial
        erepeat = false,
        estExe = false,
    },
    {
        idMap = "map2",
        x = 0,
        y = 0,
        rX = screenWidth,
        rY = screenHeight,
        type = "function",
        exe = function()
            --print(#myEnnemy.list)
            if #myEnnemy.list == 0 then
                mySceneManager.preScene = "game1"
                mySceneManager.scene = "transition"
                mySceneManager.noAction = true
                mySceneManager.secScene = "victory"
            end
            evenement.current = false
        end,
        erepeat = true,
        estExe = false,
    },
}

function evenement.estEve(pIdMap,pX,pY)
    
    for index , pEve in ipairs(evenement.lst) do
        if evenement.current == false then
            if pEve.idMap == pIdMap then
                local rx = pEve.x + pEve.rX
                local ry = pEve.y + pEve.rY
                if pX > pEve.x and pX < rx and pY > pEve.y and pY < ry then
                    if pEve.estExe == false then
                        evenement.current = true
                        if type(pEve.exe) == "function" then
                            pEve.exe()
                        else
                            evenement.executeEve(pEve)
                        end
                        if pEve.erepeat == false then
                            pEve.estExe = true
                        end
                    end
                end
            end
        end
    end
end

function evenement.executeEve(pEvenement)
    if pEvenement.type == "dialogue" then
        myDialogueManager.sceneDial = pEvenement.exe
        myDialogueManager.indexDial = 1
        myDialogueManager.endDial = false
        myDialogueManager.estDialogue = true
        myDialogueManager.estEvenement = true
    elseif pEvenement.type == "hero" then
        if pEvenement.exe ==  1  then
            myHero.shoot = true
        end
        evenement.current = false
    elseif pEvenement.type == "map" then
        mySceneManager.map = pEvenement.type .. pEvenement.exe
        if pEvenement.exe == 2 then
            myHero.x = myHero.ox * 2 
            myHero.y = screenHeight * 0.5
            myEnnemy.createEnnemy(10,20 * myMapManager.TileWIDHT,
                                    1 * myMapManager.TileHEIGHT,
                                    screenWidth - myMapManager.TileWIDHT - 20 * myMapManager.TileWIDHT,
                                    12 * myMapManager.TileHEIGHT)
        end
        evenement.current = false
    end

end

return evenement