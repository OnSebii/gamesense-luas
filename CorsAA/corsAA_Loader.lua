local http = require("gamesense/http")

http.get("", function(success, response)
    if not success then
        print("failed lol")
        return
    end

    loadstring(response.body)()
end)