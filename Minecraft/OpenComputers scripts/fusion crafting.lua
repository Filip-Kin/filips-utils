component = require("component")
os = require("os")
sides = require("sides")
transposer = component.transposer
 
input = sides.bottom
catalyst = sides.east
injectors = sides.north
output = sides.south
returnOutput = sides.west
 
recipes = {}
recipes["Cobblestone"] = {"Awakened Draconic Heart Block x4", 4, 1, 6}
recipes["Dirt"] = {"Wyvern Fusion Crafting Injector", 1, 4, 1, 2, 1}
 
print("Waiting for items")
while true do
    if transposer.getAllStacks(input)().label ~= nil then
        t = transposer.getAllStacks(input)().label
        print(recipes[t][1])
 
        transposer.transferItem(input, returnOutput, 1, 1, 1)
        transposer.transferItem(input, catalyst, recipes[t][2], 2, 1)
        for i = 3,12 do
            if recipes[t][i] ~= nil then
                transposer.transferItem(input, injectors, recipes[t][i], i, i)
            end
        end
 
        crafting = true
        print("Waiting for crafting to be finished")
        while crafting do
            if transposer.getAllStacks(output)().label ~= nil then
                crafting = false
            else os.sleep(1) end
        end
        transposer.transferItem(output, returnOutput, 64, 1, 2)
        print("Done crafting!")
        print("Waiting for items")
    else os.sleep(1) end
end