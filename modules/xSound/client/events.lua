RegisterNUICallback("data_status", function(data)
    if data.type == "finished" then
        soundInfo[data.id].playing = false
        Greed.UseTrigger("xSound:songStopPlaying", data.id)
    end
end)