local translation = {
    fr = {
        level = "Niveau",
        intro1 = "Selectionner votre langue et",
        intro2 = "appuyer sur espace pour jouer !",
        dialogue1 = {
            {player = "Où suis-je ?"},
            {pnj = "Voix grave : \n tu te trouve dans l'antre du dragon de feu et glace."},
            {player = "Qu'elle est cette voix dans ma tête !"},
            {pnj = "Voix grave : \n Avance vers ton destin ! et déchaine tes pouvoirs."},
            {player = "Super ca m'avance beaucoup."},
            {player = "En tout cas mes pouvoirs sont toujours actif"},
        },
    },
    en = {
        level = "Level",
        intro1 = "Select your language and",
        intro2 = "press space for play !",
        dialogue1 = {
            {player = "Où suis-je ?"},
            {pnj = "Voix grave : \n tu te trouve dans l'antre du dragon de feu et glace."},
            {player = "Qu'elle est cette voix dans ma tête !"},
            {pnj = "Voix grave : \n Avance vers ton destin ! et déchaine tes pouvoirs."},
            {player = "Super ca m'avance beaucoup."},
            {player = "En tout cas mes pouvoirs sont toujours actif"},
        },
    }
}

function translation.returnLang(pLang,pText)

    if translation[pLang] ~= nil then
        if translation[pLang][pText] ~= nil then
            return translation[pLang][pText]
        end
    end

    return nil
    
end

return translation