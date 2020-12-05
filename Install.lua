local Files = {
    "LoadAPIs.lua",
    "ZenFormat.lua",
    "ZenMath.lua",
    "ZenPeripheral.lua",
    "ZenPic.lua",
    "ZenText.lua",
}
for i, v in pairs(Files) do
    print("obtaining https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v)
    local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v)
    local file = fs.open("/ZenUtil/"..v,"w")
    file.write(website.readAll())
    website.close()
    file.close()
end