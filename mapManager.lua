local mapManager = {}

mapManager.TileWIDHT = 48
mapManager.TileHEIGHT = 48

mapManager.Map = {}
mapManager.path = "/map/"

mapManager.TileSheet = {}


function mapManager.load()
    local file = {}
    file = love.filesystem.getDirectoryItems(mapManager.path)
    local fileName = ""
    local data
    local map
    for i = 1,  #file do
        data = {}
        fileName = file[i]:explode("%.")[1]
        data = require(mapManager.path .. fileName)
        map = {
            name = fileName;
            data = data
        }
        table.insert(mapManager.Map,map)
    end

    for index, pMap in ipairs(mapManager.Map) do
        mapManager.LoadMap(pMap)
    end
end

function mapManager.draw()
    mapManager.drawMAP(mapManager.Map[1],"map1")
end

function mapManager.LoadMap(pFile)
    local TileTextures= {}
    local id = 1
    TileTextures.TileTextures = {}
    TileTextures.TileTextures[0] = {
      data = nil,
      id = 0
     }
     TileTextures.data = {}
    for i = 1 ,#pFile.data.tilesets do 
      TileTextures.data[i] = love.graphics.newImage("images/map/"..pFile.data.tilesets[i].name..".png")
      local nbColumns = TileTextures.data[i]:getWidth() / pFile.data.tilewidth
      local nbLines = TileTextures.data[i]:getHeight() / pFile.data.tileheight
      for l=1,nbLines do
        for c=1,nbColumns do
          TileTextures.TileTextures[id]= {
            id = i,
            data = love.graphics.newQuad(
              (c-1)*pFile.data.tilewidth, (l-1)*pFile.data.tileheight,
              pFile.data.tilewidth, pFile.data.tileheight, 
              TileTextures.data[i]:getWidth(), TileTextures.data[i]:getHeight()
            )
           }
          id = id + 1
        end
      end
    end 
    local TileSheet = {
        name = pFile.name,
        ListTileTextures = TileTextures
    }
    table.insert(mapManager.TileSheet,TileSheet)
end

function mapManager.drawMAP(pMap,pName)
    local c,l
     for line = 1, #pMap.data.layers do
      if pMap.data.layers[line].type == "tilelayer" then
      local id = 0
      l=1
      local column = 0
      for c=1 , #pMap.data.layers[line].data  do
        if c > l*pMap.data.layers[line].width then
         l = l+1
         column = 1
         else
           column = column +1
       end
       id = pMap.data.layers[line].data[c]
       local texQuad = nil
       for index, tilesheet in ipairs(mapManager.TileSheet) do
        if(tilesheet.name == pName) then
          texQuad = tilesheet.ListTileTextures.TileTextures[id].data 
          if texQuad ~= nil then
            love.graphics.draw(tilesheet.ListTileTextures.data[tilesheet.ListTileTextures.TileTextures[id].id],
                                texQuad,
                                (column - 1) * pMap.data.tilewidth,
                                ( l - 1 ) * pMap.data.tileheight)
          end
        end
       end
     end
    end
  end
  end

return mapManager