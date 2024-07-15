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
        dialogue2 = {
            {pnj = "Voix grave : \n j'ai oublier de me présenter, je suis ton pouvoirs"},
            {player = "Tu n'as pas de nom ?"},
            {pnj = "Voix grave : \n Pourquoi faire je ne peut parler qu'à toi !"},
            {player = "C'est pas faux,\nmais ce sera quand même plus simple pour ce parler"},
            {player = "Je suis Shota Tenshiro, mais je pense que tu le sais"},
            {pnj = "Voix grave : \n Oui, bien sur! donne moi le nom que tu désire"},
            {player = "Voyons voir..."},
            {player = "..."},
            {player = "que dirais-tu de... Korisai"},
            {pnj = "Korisai : \n Je valide, je me nommerais Korisai décormait"},
            {pnj = "Voix du monde : \n Aquis : compétence expulsion de pouvoirs"},
            {player = "quest-ce que ...?"},
            {pnj = "Korisai : \n Tu peut maintenant expulser ton pouvoir pour attaquer !"},
            {player = "cool !"},
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
        dialogue2 = {
            {player = "no trad"},
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