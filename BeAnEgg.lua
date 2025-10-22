local function gunclaimed()
    local orbs = {}
    for _, orb in pairs(workspace.Orbs:GetChildren()) do
        if orb:FindFirstChild("Claimed") and orb.Claimed.Value == false then
            table.insert(orbs, orb)
        end
    end
    return orbs
end

local function collect()
    local aOrbs = gunclaimed()
    local amount = 15 -- ac
    
    for i = 1, #aOrbs, amount do
        local batch = {}
        for j = i, math.min(i + amount - 1, #aOrbs) do
            table.insert(batch, aOrbs[j])
        end
        
        if #batch > 0 then
            game:GetService("ReplicatedStorage").Actions.CollectOrb:FireServer(batch)
            task.wait()
        end
    end
end

while task.wait() do collect() end
