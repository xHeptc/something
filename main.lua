local lexer = require("lexer")
local parser = require("parser")

function Mint(src)
    --[[
    local result = lexer.lex(src)
    for i,v in pairs(result) do
        for a,b in pairs(v) do
            print(a, ":    "..b) 
        end
        print("__________________")
    end]]--

    local program = parser.Parser(src)
    for i,v in pairs(program) do
        print(i,v)
        if type(v) == "table" then
            for a,b in pairs(v) do
                print(a,b)
                if type(b) == "table" then
                    for g,c in pairs(b) do
                        if type(b) == "table" then
                            for g,c in pairs(b) do
                                print(g, c)
                            end
                        end
                    end
                end
                print("__________")
            end
        end
        print("__________")
    end
 end

local code = 'let number = 10'

Mint(code)
