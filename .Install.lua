_G.files = {}
_G.selectedFiles = {}
local branches

local tab = {
}

local version = {
    ["main"] = 0.04,
    ["beta"] = 0.1
}

local selectedTab = "Files"
local selectedBranch = "main"
local installDir = "/ZenUtil"
local QUIT = false
local IINSTALL = false
local w, h = term.getSize()
local modifyMode = 2

function _G.refreshFiles()
    _G.S = false
    files = {}
    selectedFiles = {}
    local handle = http.get("https://api.github.com/repos/R93950X/ZenUtil/contents?ref="..selectedBranch)
    if handle then
        _G.data = textutils.unserialiseJSON(handle.readAll())
        for i, v in pairs(data) do
            if not (v.name:sub(1,1) == "." and v.name ~= ".LoadAPIs.lua") then
                _G.S = true
                table.insert(files, v.name)
                selectedFiles[v.name] = 1
            end
        end
    else
        error("Connection failed!")
    end
end

local function refreshBranches()
    branches = {}
    local handle = http.get("https://api.github.com/repos/R93950X/ZenUtil/branches")
    if handle then
        local data = textutils.unserialiseJSON(handle.readAll())
        local resetSelection = true
        for i, v in pairs(data) do
            if selectedBranch == v.name then
                resetSelection = false
            end
            table.insert(branches, v.name)
        end
    else
        error("Connection failed!")
    end
end

function tab.Files()
    term.setBackgroundColor(colors.lightGray)
    term.clear()
    term.setCursorPos(1,2)
    for i, v in pairs(files) do
        if selectedFiles[v] == 0 then
            term.setBackgroundColor(colors.red)
        elseif selectedFiles[v] == 1 then
            term.setBackgroundColor(colors.green)
        elseif selectedFiles[v] == 2 then
            term.setBackgroundColor(colors.yellow)
        end
        write("  "..v)
        write(string.rep(" ",w).."\n")
    end
    local event, button, x, y
    repeat
        event, button, x, y = coroutine.yield()
    until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #files
    selectedFiles[files[y-1]] = (selectedFiles[files[y-1]]+1)%modifyMode
end

function tab.Branches()
    term.setBackgroundColor(colors.lightGray)
    term.clear()
    term.setCursorPos(1,2)
    for i, v in pairs(branches) do
        if v == selectedBranch then
            term.setBackgroundColor(colors.lime)
        end
        write("  "..v)        
        write(string.rep(" ",w).."\n")
        term.setBackgroundColor(colors.lightGray)
    end
    local event, button, x, y
    repeat
        event, button, x, y = coroutine.yield()
    until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #branches
    selectedBranch = branches[y-1]
    sleep(1/20)
    refreshFiles()
end

function tab.Settings()
    term.setBackgroundColor(colors.lightGray)
    term.clear()
    term.setCursorPos(1,2)
    write("Install @: "..installDir)        
    write(string.rep(" ",w).."\n")
    local event, button, x, y
    repeat
        event, button, x, y = coroutine.yield()
    until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #branches
    if y == 2 then
        term.setCursorPos(13,2)
        term.setBackgroundColor(colors.lightGray)
        write(string.rep(" ",w))
        term.setCursorPos(13,2)
        installDir = "/"..read()
    end
end

function tab.Exit()
    QUIT = true
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
end

function tab.Install()
    tab.Exit()
    INSTALL = true
end

local tabOrder = {"Files", "Branches", "Settings", "Install", "Exit"}
local function tabsBar()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.gray)
    write(" ")
    for i, v in pairs(tabOrder) do
        if v == selectedTab then
            term.setBackgroundColor(colors.blue)
        elseif v == "Exit" then
            term.setBackgroundColor(colors.red)
        elseif v == "Install" then
            term.setBackgroundColor(colors.lightBlue)
        end
        write(v)
        term.setBackgroundColor(colors.gray)
        write("  ")
    end
    write(string.rep(" ", 51))
    local event, button, x, y
    repeat
        event, button, x, y = coroutine.yield()
    until event == "mouse_click" and button == 1 and y == 1
    if x >= 2 and x <= 5 then
        selectedTab = "Files"
    elseif x >= 8 and x <= 15 then
        selectedTab = "Branches"
    elseif x >= 18 and x <= 25 then
        selectedTab = "Settings"
    elseif x >= 28 and x <= 34 then
        selectedTab = "Install"
    elseif x >= 37 and x <= 40 then
        selectedTab = "Exit"
    end
end

function banner()
    term.setBackgroundColor(colors.gray)
    term.setCursorPos(1,h)
    write("ZenUtil Version "..version[selectedBranch]..(selectedBranch ~= "main" and (" "..selectedBranch) or "").." Installer")
    write(string.rep(" ",w))
    sleep(10^6)
end

refreshFiles()
refreshBranches()
if ZenUtil then
    modifyMode = 3
    for i, v in pairs(selectedFiles) do
        selectedFiles[i] = 0
    end
    for i, v in pairs(ZenUtil.files) do
        selectedFiles[v] = 2
    end
    selectedBranch = ZenUtil.branch
    installDir = ZenUtil.installDir
end
while not QUIT do
    parallel.waitForAny(tab[selectedTab], tabsBar, banner)
    sleep(1/20)
end

if INSTALL then
    for i, v in pairs(selectedFiles) do
        if v == 1 then
            write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..selectedBranch.."/"..i.."... ")
            local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..selectedBranch.."/"..i)
            if website then 
                print("Success!")
                local file = fs.open(installDir.."/"..i,"w")
                file.write(website.readAll():gsub("_BRANCH_",selectedBranch))
                website.close()
                file.close()
                print("Downloaded as "..installDir.."/"..i)

            else
                print("Connection failed!")

            end
        elseif fs.exists(installDir.."/"..i) and v == 0 then
            fs.delete(installDir.."/"..i)
        end
    end
    sleep(0.5)
    term.clear()
    term.setCursorPos(1,1)
end

--[[
Todo:    
    None!
]]
