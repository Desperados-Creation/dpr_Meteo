--------------------------------------------------------------------------------------------------
-- Script par Desperados#0001                                                                   -- 
-- Lien du discord pour toute mes créations: https://discord.gg/dkHFBkBBPZ                      --
-- Lien du github pour télécharger le script: https://github.com/Desperados-Creation/dpr_Meteo  --
--------------------------------------------------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Menu --
local open = false
local MenuMeteo = RageUI.CreateMenu("Météo", "INTERACTION")
local MenuHeureMeteo = RageUI.CreateSubMenu(MenuMeteo, "Heure", "INTERACTION")
local MenuTempsMeteo = RageUI.CreateSubMenu(MenuMeteo, "Temps", "INTERACTION")
MenuMeteo.Display.Header = true
MenuMeteo.Closed = function()
    open = false
end

function OpenMenuMeteo() 
    if open then 
        open = false
        RageUI.Visible(MenuMeteo, false)
        return
    else
        open = true
        RageUI.Visible(MenuMeteo, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuMeteo, function()
                    RageUI.Separator("↓     ~g~Temps / Heures     ~s~↓")
                    RageUI.Button("Temps", "Gestion du Temps", {RightLabel = "~y~→→→"}, true, {}, MenuTempsMeteo)
                    RageUI.Button("Heure", "Gestion de l'heure", {RightLabel = "~y~→→→"}, true, {}, MenuHeureMeteo)

                    RageUI.Separator("↓     ~g~Freeze     ~s~↓")
                    RageUI.Button("Freeze Temps", "Block la météo sur laquel elle est définie !", {RightLabel = "~y~→"}, true, {
                        onSelected = function()
                            ExecuteCommand('freezeweather')
                        end
                    })
                    RageUI.Button("Freeze Heure", "Block le sur lequel il est défini !", {RightLabel = "~y~→"}, true, {
                        onSelected = function()
                            ExecuteCommand('freezetime')
                        end
                    })

                    RageUI.Separator("↓     ~c~Blackout     ~s~↓")
                    RageUI.Button("Blackout", "Éteindre les lumières de la ville", {RightLabel = "~g~ON~s~/~r~OFF"}, true, {
                        onSelected = function()
                            ExecuteCommand('blackout')
                        end
                    })

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                RageUI.IsVisible(MenuTempsMeteo, function()
                    RageUI.Separator("↓     ~g~Personalisée     ~s~↓")
                    RageUI.Button("Changer le temps", "Syntaxe: {temps}, Exemple: extrasunny", {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            local AvailableWeatherTypes = KeyboardInput('Entrer le temps que vous souhaitez', '', 45)
							ExecuteCommand("weather "..AvailableWeatherTypes)
                        end
                    })
                    RageUI.Separator("↓     ~g~Raccourci     ~s~↓")
                    RageUI.Button("Normal", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather neutral') end})
                    RageUI.Button("Ensoleillé", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather extrasunny') end})
                    RageUI.Button("Dégager", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather clear') end})
                    RageUI.Button("Nuageux", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather clouds') end})
                    RageUI.Button("Brouillard", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather smog') end})
                    RageUI.Button("Pluie", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather rain') end})
                    RageUI.Button("Nuageux + Brouillard", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather foggy') end})
                    RageUI.Button("Nuageux + Vent", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather overcast') end})
                    RageUI.Button("Nuageux + Pluie", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather clearing') end})
                    RageUI.Button("Nuageux + Vent + Pluie", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather thunder') end})
                    RageUI.Button("Faible Neige", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather snowlight') end})
                    RageUI.Button("Neige", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather snow') end})
                    RageUI.Button("Enneiger", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather xmas') end})
                    RageUI.Button("Tempête", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather blizzard') end})
                    RageUI.Button("Halloween", nil, {RightLabel = "~y~→"}, true, {onSelected = function() ExecuteCommand('weather halloween') end})

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                RageUI.IsVisible(MenuHeureMeteo, function()
                    RageUI.Separator("↓     ~g~Personalisée     ~s~↓")
                    RageUI.Button("Changer d'heure", "Syntaxe: {heure} {minute}, Exemple: 12 00", {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            local heure = KeyboardInput('Entrer l\'heure que vous souhaitez', '', 45)
							ExecuteCommand("time "..heure)
                        end
                    })
                    RageUI.Separator("↓     ~g~Raccourci     ~s~↓")
                    RageUI.Button("06:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 06 00') end})
                    RageUI.Button("08:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 08 00') end})
                    RageUI.Button("10:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 10 00') end})
                    RageUI.Button("12:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 12 00') end})
                    RageUI.Button("14:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 14 00') end})
                    RageUI.Button("16:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 16 00') end})
                    RageUI.Button("18:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 18 00') end})
                    RageUI.Button("20:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 20 00') end})
                    RageUI.Button("22:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 22 00') end})
                    RageUI.Button("00:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 00 00') end})
                    RageUI.Button("02:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 02 00') end})
                    RageUI.Button("04:00", nil, {RightLabel = "~y~→"}, true, { onSelected = function() ExecuteCommand('time 04 00') end})

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

RegisterCommand("meteo", function(source, args)
    OpenMenuMeteo()
end)

-- Function --
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

RegisterNetEvent('dpr_Meteo:HeurePerso')
AddEventHandler('dpr_Meteo:HeurePerso', function(service, nom, message)
	if service == 'employer' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Message Avocat', '~y~Message:', 'Employer: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_ESTATE_AGENT', 1)
		Wait(14000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)