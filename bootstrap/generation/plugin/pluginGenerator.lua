local function mkdir(path)
    -- quote the path so spaces and special characters are safe
    local quoted = "'" .. path:gsub("'", "'\\''") .. "'"
    return os.execute("mkdir -p " .. quoted)
end

print("\nGenerating Plugin: \"" .. __PARAMS["pluginName"] .. "\"\n")

local path = "plugins/modules/" .. __PARAMS["pluginName"]
mkdir(path)

local file, err = io.open(path .. "/" .. __PARAMS["pluginName"] .. ".lua", "w")

if file then
    file:write("-- Plugin Code goes here\n")
    file:close() 

    print("Successfully generated plugin.\n")
else
    print("Error creating file: " .. tostring(err) .. "\n")
end
