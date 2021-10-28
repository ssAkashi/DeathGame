RegisterNetEvent('deathGame:gameOver')
AddEventHandler('deathGame:gameOver', function(lose, gameOver, reason)
    local _src = source
    if (not lose and gameOver) then
        print("[^1DEATH GAME ^0] ^1❌ Game Over ❌ for ^4"..GetPlayerName(_src).." ^0(^4".._src.."^0).")
        Wait(2000)
        os.exit()
    end
    if (lose and not gameOver) then
        print("[^1DEATH GAME ^0] ^4"..GetPlayerName(_src).." ^0(^4".._src.."^0) ^1is dead. Incorrect code !")
        DropPlayer(_src, "❌ Game Over ❌ ! Your are looser. You are dead ☠️")
    end
    if (not lose and not gameOver) then
        print("[^1DEATH GAME ^0] ^4"..GetPlayerName(_src).." ^0(^4".._src.."^0) ^1is dead. "..reason)
        DropPlayer(_src, reason)
    end
end)