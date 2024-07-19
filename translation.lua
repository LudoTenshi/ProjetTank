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
            {player = "Humm … j’ai un mal de crâne.. \n c’est bizarre je ne reconnait rien autour de moi,\n je suis pourtant sure que j’étais sur le chemin pour aller en cours…\n Je me demande bien ou j’ai atterri."},
        },
        dialogue2 = {
            {pnj = {
                    name = "Korisai",
                    text ="Voix grave : \n Tu devrais te méfier,\n je ressent deux présences néfastes autour de nous !"
                }
            },
            {player = "Attend pourquoi je ne vois personne et j’entend une vois ?\n C’est un rêve !"},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n  toi qui peut m’entendre,\n tu n’es pas dans un rêve, moi c’est korisai !\n Je suis là pour t’aider."
                }
            },
            {player = "euh moi c’est Shota,\n mais pourquoi je ne vois personne d’autres que moi ? "},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n hahahaha! Je suis l’incarnation de ton pouvoir, \n essai de me voir comme ton protecteur ! Tu te trouve dans la montagne de Sundaria, \n deux créatures très dangereuse se battent pour avoir le contrôle de la région.\n  Tu devrais aller tester un peu nos facultés avant d’entamer ta destinée."
                }
            },
            {player = "Merci pour les infos,\n bah c'est partie le feu et la glace en action ! \n je suppose que la sortie est par ce trou."},
        },
        dialogue3 = {
            {pnj = {
                    name = "Voice_World",
                    text ="Voix du monde : \n Acquis : Condensation d’expulsion "
                }
            },
            {player = "C’est quoi ça encore ? \n Et c’est quoi ses trucs rampants ? "},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n C’est la voix de ce monde !\n Je peux d’ailleurs te décrire chaque compétence que tu possèdes ! "
                }
            },
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : \n Par exemple celle-ci te permet de condenser l’energie des pouvoirs \n de ton monde sous forme de projectiles et d’expulser les ennemis avec.\n D’ailleurs les incarnations d’énergie maléfique que tu traite de rampant \n sont les ennemies idéaux pour tester nos pouvoirs dans ce monde ? "
                }
                
            },
            {player = "Tu viens de dire ce monde, \n est ce que tu penses que je pourrais repartir dans le miens ? "},
            {pnj = {
                    name = "Korisai",
                    text ="Korisai : Je n’ai pas les compétences pour répondre à ceci, mais nous trouverons surement la réponse ! "
                }
                
            },
            {player = "On verra plus tard, essayons déjà ce nouveau pouvoir !"},
        }
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