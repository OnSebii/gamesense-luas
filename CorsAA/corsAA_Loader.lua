local http = require("gamesense/http")

http.get("https://raw.githubusercontent.com/OnSebii/gamesense-luas/main/CorsAA/corsAA.lua", function(success, response)
    if not success then
        print("failed")
        return
    end

    loadstring(response.body)()
end)