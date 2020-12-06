local Files = {
    "LoadAPIs.lua",
    "ZenFormat.lua",
    "ZenMath.lua",
    "ZenPeripheral.lua",
    "ZenPic.lua",
    "ZenText.lua",
}

toDownload = {}
term.clear()
term.setCursorPos(1,1)
print("ZenUtil 0.02d Installer\n")
for i, v in pairs(Files) do
    local input = 0
    print("Do you wish to install "..v.."? [Y/N]")
    repeat
        input = select(2, os.pullEvent("key"))
        
    until input == keys.y or input == keys.n
    if input == keys.y then
        table.insert(toDownload, v)
        
    end
    
end

for i, v in pairs(toDownload) do
    write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v.."... ")
    local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v)
    print("Success.")
    local file = fs.open("/ZenUtil/"..v,"w")
    file.write(website.readAll())
    website.close()
    file.close()
    print("Downloaded as /ZenUtil/"..v)
    
end