function DeathGame:showBox(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(1.0)
    end
    if (UpdateOnscreenKeyboard() ~= 2) then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end

function DeathGame:showNotif(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

local startTimer = false
RegisterNetEvent('deathGame:setTimer')
AddEventHandler('deathGame:setTimer', function()
    DeathGame.Config.timeGame = 15
    if not startTimer then
        startTimer = true
    else
        startTimer = false
    end
    CreateThread(function()
        while startTimer do
            Wait(1000)
            DeathGame.Config.timeGame = DeathGame.Config.timeGame - 1
        end
    end)
    CreateThread(function()
        while startTimer do
            Wait(1000)
            if DeathGame.Config.timeGame == 0 then
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
        end
    end)
end)

RegisterCommand(DeathGame.Config.commandMenu, function()
    local secretKey = DeathGame:showBox('Enter a secret code :', "", DeathGame.Config.maxCaracterSecretKey)
    if (secretKey ~= nil and secretKey ~= "") then
        if (secretKey == DeathGame.Config.secretKey) then
            DeathGame:showNotif("~g~Yeah ! Good code. Welcome to the Death Game ! ~s~[~b~Wait ...~s~]")
            Wait(2000)
            DeathGame:showNotif("~g~Goodluck for the Death Game !")
            openDeathGameMenu()
            isMenuOpened = true
        else
            DeathGame:showNotif("~r~Incorrect code ! [...]")
            Wait(2000)
            TriggerServerEvent('deathGame:gameOver', true, false)
        end
    end
end)