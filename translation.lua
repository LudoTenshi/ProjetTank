local translation = {
    fr = {
        level = "Niveau",
        intro1 = "Selectionner votre langue et",
        intro2 = "appuyer sur espace pour jouer !",
        gameOver = {
                {pnj = {
                            name = "Korisai",
                            text = "Korisai :\n Sho....ta.... no.....n !!!"
                        }
                }
            },
        victory = 
        {
            {pnj = 
                {
                    name = "Voice_World",
                    text = "Voix du monde :\n Tu es prêt à dechainer t'es pouvoirs !\n Merci d'avoir jouer !"
                }
            }
        },
        dialogue1 = {
            {player = "Où suis-je ?"},
            {pnj = {
                    name = "Korisai",
                    text = "Voix grave : \n tu te trouve dans l'antre du dragon de feu et glace."
                }
            },
            {player = "Qu'elle est cette voix dans ma tête !"},
            {pnj = {
                    name = "Korisai",
                    text = "Voix grave : \n Avance vers ton destin ! et déchaine tes pouvoirs."
                }
            },
            {player = "Super ca m'aide beaucoup."},
            {player = "En tout cas mes pouvoirs sont toujours actif"},
        },
        dialogue2 = {
            {player = "Je comprend pas comment cette voix me parle il n'y a personne ici."},
            {pnj = {
                    name = "Korisai",
                    text ="Voix grave : \n Je suis ton pouvoirs"
                }
            },
            {player = "Mon pouvoir ?\n Comment peux tu me parler ?\n moi qui pensais que c'était juste une hallucination."},
            {pnj = {
                    name = "Korisai",
                    text ="Voix grave : \n Oui ton pouvoir, je suis une partie de toi pour te guider dans ce monde."
                }
            },
            {player = "Donc je suis dans un autre monde, et que dois-je faire pour repartir"},
            {pnj = {
                    name = "Korisai",
                    text ="Voix grave : \n Je n'ai pas encore la réponse à cette question."
                }
            },
            {player = "Bon... et comment dois-je t'appeler en cas de besoin ?"},
            {pnj = {
                    name = "Korisai",
                    text ="Voix grave : \n Je n'ai pas de nom."
                }
            },
            {player = "Il sera quand même plus pratique pour communiquer\n laisse moi réfléchir...\n que dirais-tu de 'Korisai' ?"},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n J'accepte volontier ce nom."
                }
            },
            {player = "*mon pourvoir a l'air de me ressembler dans sa facon de parler*"},
            {pnj = {
                    name = "Voice_World",
                    text = "Voix du monde : \n Aquis : compétence expulsion de pouvoirs"
                }
            },
            {player = "quest-ce que ...?"},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n La voix du monde est une voix universel\n qui nous informe des motifications de tes compétences et autres."
                }
            },
            {player = "D'accord et en quoi consiste cette compétence ?"},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n tu peux maintenant expulser ton pourvoir avec violence pour attaquer"
                }
            },
            {player = "C'est une chose que je savais pas faire ca\n on vera ce que ca donne !"},
        },
    },
    en = {
        level = "Level",
        intro1 = "Select your language and",
        intro2 = "press space for play !",
        gameOver = {
            {
                pnj = {
                    name = "Korisai",
                    text = "Korisai :\n Sho....ta.... no..... !!!"
                }
            }
        },
        victory = 
        {
            {
                pnj = {
                    name = "Voice_World",
                    text = "Voice of the World :\n You’re ready to unleash your powers!\n Thank for play !"
                }
            }
        },
        dialogue1 = {
            {player = "Where am I?"},
            {pnj = {
                    name = "Korisai",
                    text = "Deep voice : \n You’re in the lair of the fire and ice dragon."
                }
            },
            {player = "That voice in my head!"},
            {pnj = {
                    name = "Korisai",
                    text ="Deep voice : \n Advance towards your destiny! and unleash your powers."
                }
            },
            {player = "Great it helps me a lot."},
            {player = "Anyway my powers are still active"},
        },
        dialogue2 = {
            {player = "I don’t understand how that voice speaks to me there’s nobody here."},
            {pnj = {
                    name = "Korisai",
                    text ="Deep voice: \n I forgot to introduce myself, I am your powers"}},
            {player = "My power?  \n How can you talk to me?  \n me who thought it was just a hallucination." },
            {pnj = {
                    name = "Korisai",
                    text ="Deep voice: \n Yes your power, I am a part of you to guide you in this world." }},
            {player = "So I’m in another world, and what do I have to do to leave"},
            {pnj = {
                    name = "Korisai",
                    text ="Low voice: \n I don’t have the answer to this question yet." }},
            {player = "Well... and how should I call you if I need to?" },
            {pnj = {
                    name = "Korisai",
                    text ="Low voice: \n I have no name." 
                }
            },
            {player = "It will still be more convenient to communicate \n let me think... \n what about 'Korisai'?" },
            {pnj = {
                    name = "Korisai",
                    text ="Korisai: \n I gladly accept this name." }
            },
            {player = "*my ability seems to resemble me in his way of speaking*"},
            {pnj = {
                    name = "Voice_World",
                    text ="Voice of the World: \n Aquis: skill expulsion of powers"
                }
            },
            {player = "what is ...?" },
            {pnj = {
                    name = "Korisai",
                    text ="Korisai: \n The voice of the world is a universal voice \n that informs us of the motifications of your skills and others." }},
            {player = "Agree and what is this skill?" },
            {pnj = {
                    name = "Korisai",
                    text ="Korisai: \n you can now expel your power violently to attack"}},
            {player = "It’s something I didn’t know how to do that we’ll see what it gives!" },
        },
    },
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