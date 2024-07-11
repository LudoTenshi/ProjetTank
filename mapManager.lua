local mapManager = {}

mapManager.TileWIDHT = 48
mapManager.TileHEIGHT = 48

mapManager.Map = {}
mapManager.path = "/map/"

mapManager.TileSheet = {}
mapManager.Grid = {}


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
      if pMap.data.class == "map" then
        mapManager.LoadMap(pMap)
      end
    end
end

function mapManager.draw(pName)
  for index , pMap in ipairs(mapManager.Map) do
    if pMap.name == pName then
      mapManager.drawMAP(pMap,pName)
      return
    end
  end
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
    mapManager.Grid = {}
     for line = 1, #pMap.data.layers do
      mapManager.Grid[line] = {{}}
      if pMap.data.layers[line].type == "tilelayer" then
      local id = 0
      l=1
      local column = 0
      for c=1 , #pMap.data.layers[line].data  do
        if c > l*pMap.data.layers[line].width then
         l = l+1
         column = 1
         mapManager.Grid[line][l] = {}
         else
           column = column +1
       end
       id = pMap.data.layers[line].data[c]
       mapManager.Grid[line][l][column] = id
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

function mapManager.collision(pX,pY,oX,oY)
    local c = math.floor(pX / mapManager.TileWIDHT) + 1
    local l = math.floor(pY / mapManager.TileHEIGHT) + 1
    local pTId
    if #mapManager.Grid ~= 0 then
      for iGrid , pGrid in ipairs(mapManager.Grid) do
        pTId = pGrid[l][c]
        for index, pMap in ipairs(mapManager.Map) do
          if pMap.data.class == "Tuile" then
            for iTil, pTil in ipairs(pMap.data.tiles) do
              if (pTil.id + 1) == pTId then
                for oi , obj in ipairs(pTil.objectGroup.objects) do
                  if obj.shape == "rectangle" then
                    local dx = (c-1) * mapManager.TileWIDHT + obj.x
                    local fx = dx + obj.width
                    local dy = (l-1) * mapManager.TileHEIGHT + obj.y
                    local fy = dy + obj.height
                    local hdx = pX - oX
                    local hfx = pX + oX
                    local hdy = pY
                    local hfy = pY + oY
                    if (hdx > dx or hfx > dx) and  ( hdx < fx or hfx < fx) and
                        (hdy > dy or hfy > dy) and ( hdy < fy or hfy < fy) 
                    then
                      return true
                    end
                  elseif obj.shape == "polygon" then
                    for ipol, pol in ipairs(obj.shape.polygon) do
                      --a voir plus tard
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    return false
  end
return mapManager