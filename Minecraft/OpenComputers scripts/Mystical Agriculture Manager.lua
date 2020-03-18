component = require("component")
sides = require("sides")
os = require("os")

rs = component.redstone

transposers = {}
transposerSides = {}
manager = component.proxy("4c53e55e-f083-4066-bad3-c212c66c6900")

i = 1
for address, componentType in pairs(component.list()) do
    if componentType == "transposer" and address ~= manager.address then
        transposers[i] = component.proxy(address)
        if transposers[i].getInventoryName(sides.west) ~= nil then
            transposerSides[i] = sides.west
        else
            transposerSides[i] = sides.east
        end
        i = i + 1
    end
end

function remove()
    for num, transposer in pairs(transposers) do
        transposer.transferItem(sides.bottom, transposerSides[num], 1, 2, 1)
    end
    rs.setOutput(sides.bottom, 1)
end

function insert(slot)
    rs.setOutput(sides.bottom, 0)
    manager.transferItem(sides.north, sides.south, 10, 1, 1)
    while manager.getStackInSlot(sides.south, 1) ~= nil do -- Wait for items to be distributed
        os.sleep(1)
    end
    os.sleep(3)
    for num, transposer in pairs(transposers) do
        transposer.transferItem(transposerSides[num], sides.bottom, 1, 1, 2)
    end
end

function switch(slot)
    remove()
    os.sleep(2)
    insert(slot)
end
