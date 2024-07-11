local intro = {}

intro.imgFond = love.graphics.newImage("images/db8f0030060474d.png")
intro.textFond = love.graphics.newImage("images/Shoto.png")

-- Toutes les images des langues ont la meme dimension
intro.imgLanguage = {
    {name = "fr",
    img = love.graphics.newImage("images/language/fr.png") ,
    x = 0,
    y = 0},
    {name = "en",
    img = love.graphics.newImage("images/language/en.png"),
    x = 0,
    y = 0},
}
--index de la langue sélectionner 
intro.languageDefault = 1

intro.cursorW = 128
intro.cursorH = 71
intro.marginWidth = 300

intro.textFont = love.graphics.getFont()
intro.text = love.graphics.newText(intro.textFont)


function intro.load()

    intro.placmentVertical = screenHeight * 0.5 - intro.imgLanguage[1].img:getHeight() * 0.5

        myGame.CreateQuad("cursor","cursor",intro.cursorH,intro.cursorW)
        myGame.CreateSprite("cursor","cursor",1,1)
end

function intro.update(dt)
    intro.text:clear()
    intro.text:add({{1,1,1},myTranslation.returnLang(myGame.language,"intro1")},0,0)
    intro.text:add({{1,1,1},myTranslation.returnLang(myGame.language,"intro2")},0,intro.text:getHeight())
    intro.cursorX = intro.imgLanguage[intro.languageDefault].x - intro.imgLanguage[intro.languageDefault].img:getWidth()
    intro.cursorY = intro.imgLanguage[intro.languageDefault].y

end

function intro.draw()
    love.graphics.draw(intro.imgFond,screenWidth * 0.5,0,0,0.5,0.5,intro.imgFond:getWidth() *0.5,0)
    love.graphics.draw(intro.textFond,screenWidth * 0.5,screenHeight -intro.textFond:getHeight() * 0.5 * 0.4,0,0.4,0.4,intro.textFond:getWidth() *0.5,intro.textFond:getHeight() *0.5)
    love.graphics.draw(intro.text,10,50,0,3,3)
    
    for index, img in ipairs(intro.imgLanguage) do
        img.x = intro.marginWidth
        img.y = intro.placmentVertical + (index - 1) * img.img:getHeight()
        love.graphics.draw(img.img,img.x,img.y,0,1,1,img.img:getWidth() * 0.5,img.img:getHeight() * 0.5)    
    end
 
    myGame.DrawSprite("cursor",
                        intro.cursorX,
                        intro.cursorY,
                        0,
                        0.5,
                        intro.cursorW * 0.5,
                        intro.cursorH *0.5,
                        0)
end

function intro.keypressed(key)
    if key == "down" then
        intro.languageDefault = intro.languageDefault + 1
        mySound.playEffect("cursor-move")
    end
    if key == "up" then
        intro.languageDefault = intro.languageDefault - 1
        mySound.playEffect("cursor-move")
    end
    if intro.languageDefault > #intro.imgLanguage then
        intro.languageDefault = #intro.imgLanguage
    end
    if intro.languageDefault < 1 then
        intro.languageDefault = 1
    end

    if(intro.languageDefault == 1 ) then
        myGame.language = "fr"
    end
    if(intro.languageDefault == 2 ) then
        myGame.language = "en"
    end
end

return intro