local isMenuOpened = false
local deathMainMenu = RageUI.CreateMenu("DEATH GAME", "∑ Death Game | by AKASHI")
local deathGameLobby = RageUI.CreateMenu("DEATH GAME", "∑ Death Game | Lobby")
local deathGameMenu = RageUI.CreateMenu("DEATH GAME", "∑ Death Game | In the game")
local deathEndMenu = RageUI.CreateMenu("DEATH GAME", "∑ Death Game | End of game")
deathMainMenu.Closable = false
deathGameLobby.Closable = false
deathGameMenu.Closable = false
deathEndMenu.Closable = false

local number1
local number2
local calculString = ""
local calcul
local score = 0
local accessValidation = false
local resultCalcul = "X"
local finishLevel = false
local saveSeconds = DeathGame.Config.timeGame
local level1 = false
local level2 = false
local level3 = false

function openDeathGameMenu()
    if (isMenuOpened) then
        isMenuOpened = false
        RageUI.Visible(deathMainMenu, false)
    else
        isMenuOpened = true
        RageUI.Visible(deathMainMenu, true)
        CreateThread(function()
            while (isMenuOpened) do
                Wait(0)
                RageUI.IsVisible(deathMainMenu, function()
                    RageUI.Separator("→ WELCOME TO THE DEATH GAME")
                    RageUI.Button("Start Game", "~r~Death Game Rules ~s~: If you lose the game and the \"Game Over\" appears, then you die. Do the following steps quickly, a timer is running. Good luck !", {RightLabel = ""}, true , {}, deathGameLobby)
                end)

                RageUI.IsVisible(deathGameLobby, function()
                    RageUI.Button("Level 1", "Choose a ~b~level 1.", {RightLabel = "→"}, true, {
                        onSelected = function()
                            PlayUrl("deathgameMusic", "https://www.youtube.com/watch?v=-sOadAaGiq4", 0.3, false)
                            level1 = true
                            level2 = false
                            level3 = false
                            number1 = math.random(1,10)
                            number2 = math.random(1,10)
                            calculString = "~g~"..number1.." ~s~+~g~ "..number2
                            calcul = (number1 + number2)
                            TriggerEvent('deathGame:setTimer')
                        end
                    }, deathGameMenu)
                    RageUI.Button("Level 2", "Choose a ~b~level 2.", {RightLabel = "→"}, true, {
                        onSelected = function()
                            PlayUrl("deathgameMusic", "https://www.youtube.com/watch?v=-sOadAaGiq4", 0.3, false)
                            level1 = false
                            level2 = true
                            level3 = false
                            number1 = math.random(1,110)
                            number2 = math.random(1,115)
                            calculString = "~g~"..number1.." ~s~+~g~ "..number2
                            calcul = (number1 + number2)
                            TriggerEvent('deathGame:setTimer')
                        end
                    }, deathGameMenu)
                    RageUI.Button("Level 3", "Choose a ~b~level 3.", {RightLabel = "→"}, true, {
                        onSelected = function()
                            PlayUrl("deathgameMusic", "https://www.youtube.com/watch?v=-sOadAaGiq4", 0.3, false)
                            level1 = false
                            level2 = false
                            level3 = true
                            number1 = math.random(-30,255)
                            number2 = math.random(-5,300)
                            calculString = "~g~"..number1.." ~s~+~g~ "..number2
                            calcul = (number1 + number2)
                            TriggerEvent('deathGame:setTimer')
                        end
                    }, deathGameMenu)
                    RageUI.Button("~r~Left the game", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('deathGame:gameOver', false, false, "❌ Game Over ❌ ! Its impossible to left the game. You are dead ☠️")
                        end
                    })
                end)

                RageUI.IsVisible(deathGameMenu, function()
                    RageUI.Separator("Score : ~r~"..score)
                    if not finishLevel then
                        RageUI.Separator("~r~→~s~ Time : ~r~"..DeathGame.Config.timeGame)
                        RageUI.Separator("~r~→~s~ Result : ~g~"..resultCalcul.." ~r~←")
                        RageUI.Separator("~r~→~s~ "..calculString.." ~r~←")
                        RageUI.Button("Put the result", "~r~→~s~ Put the result here.", {RightLabel = nil}, true, {
                            onSelected = function()
                                local deathGameResult = DeathGame:showBox('Enter your result :', "", 5)
                                if (deathGameResult ~= nil and deathGameResult ~= "") then
                                    if tonumber(deathGameResult) then
                                        accessValidation = true
                                        resultCalcul = tonumber(deathGameResult)
                                    end
                                end
                            end
                        })
                    end
                    if accessValidation then
                        RageUI.Button("Validation", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if resultCalcul == calcul then
                                    DeathGame.Config.timeGame = (DeathGame.Config.timeGame + math.random(1,3))
                                    score = score + 10
                                    deathGameResult = nil
                                    accessValidation = false
                                    if level1 then
                                        number1 = math.random(1,10)
                                        number2 = math.random(1,10)
                                    end
                                    if level2 then
                                        number1 = math.random(1,110)
                                        number2 = math.random(1,115)
                                    end
                                    if level3 then
                                        number1 = math.random(-30,255)
                                        number2 = math.random(-5,300)
                                    end
                                    calculString = "~g~"..number1.." ~s~+~g~ "..number2
                                    calcul = (number1 + number2)
                                    if score >= 100 then
                                        finishLevel = true
                                        Destroy("deathgameMusic")
                                        TriggerEvent('deathGame:setTimer')
                                        DeathGame.Config.timeGame = saveSeconds
                                    end
                                else
                                    Destroy("deathgameMusic")
                                    TriggerServerEvent('deathGame:gameOver', false, true)
                                    DeathGame:showNotif("~r~You are dead !!!")
                                    PlayUrl("deathgameMusic", "https://www.youtube.com/watch?v=s5B188EFlvE", 0.3, false)
                                    Wait(2500)
                                    CreateThread(function()
                                        while true do
                                            print()
                                            print()
                                            print()
                                        end
                                    end)
                                end
                            end,
                        })
                    else
                        RageUI.Button("Validate", "~r~Put your result on top.", {RightBadge = RageUI.BadgeStyle.Lock}, false , {})
                    end
                    if finishLevel then
                        RageUI.Button("Finish the level", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                finishLevel  = false
                                level1 = false
                                level2 = false
                                level3 = false
                                score = 0
                            end
                        }, deathEndMenu)
                    end
                end)

                RageUI.IsVisible(deathEndMenu, function()
                    RageUI.Separator("CONGRATULATION !")
                    RageUI.Button("Go to main menu", nil, {RightLabel = "→→"}, true, {}, deathGameLobby)
                end)
            end
        end)
    end
end