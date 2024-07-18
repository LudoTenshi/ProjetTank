local sound = {}

sound.Listeffect ={}
sound.path = "/sound/"


function sound.load()
    local file = {}
    file = love.filesystem.getDirectoryItems(sound.path)
    local i
    local effect = {}
    local fileInfo = {}
    for i = 1,  #file do
        effect = {}
        fileInfo = love.filesystem.getInfo(sound.path .. file[i])
        if(fileInfo.type == "file") then
            effect.name = file[i]:explode("%.")[1]
            effect.sound = love.audio.newSource(sound.path .. file[i], "static")
        end
       table.insert(sound.Listeffect,effect)
        i = i + 1
    end

end

function sound.playEffect(pName)
    for index , pEffect in ipairs(sound.Listeffect) do
        if pEffect.name == pName then
            if pEffect.sound:isPlaying() then
                pEffect.sound:stop()
              end
            pEffect.sound:play()
        end
    end
end

return sound