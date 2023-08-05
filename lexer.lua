local lexer = {}
local __exported = {
    TokenType = {
        Number = "Number",
        Identifier = "Identifier",
        BinaryOperator = "BinaryOperator",
        Equals = "Equals",
        OpenParen = "OpenParen",
        CloseParen = "CloseParen",
        EOF = "EOF",
        Let = "Let",
        Nil = "Nil"
      }
}

local KEYWRODS = {
    ["let"] = __exported.TokenType.Let,
    ["nil"] = __exported.TokenType.Nil
}

function token(value, tokenType)
    return {value = value, type = tokenType}
end

function isNumeric(value: string)
    return tonumber(value) and true or false
end

function isAlphabetic(value: string)
    return string.upper(value) ~= string.lower(value)
end

function isSkippable(value: string)
    return value == " " or value == "\n" or value == "\t"
end

function lexer.lex(source: string)
    local Tokens = {}
    local src = string.split(source, "")

    while (#src > 0) do
        if (src[1] == "(") then 
            table.insert(Tokens, token(table.remove(src, 1), __exported.TokenType.OpenParen))
        elseif (src[1] == ")") then
            table.insert(Tokens, token(table.remove(src, 1), __exported.TokenType.CloseParen))
        elseif (src[1] == "+" or src[1] == "-" or src[1] == "*" or src[1] == "/" or src[1] == "%") then
            table.insert(Tokens, token(table.remove(src, 1), __exported.TokenType.BinaryOperator))
        elseif (src[1] == "=") then
            table.insert(Tokens, token(table.remove(src, 1), __exported.TokenType.Equals))
        else
            if (isNumeric(src[1])) then
                local number = ""
                while (#src > 0 and isNumeric(src[1])) do
                    number = number..table.remove(src, 1)
                end

                table.insert(Tokens, token(number, __exported.TokenType.Number))
            elseif (isAlphabetic(src[1])) then
                local string = ""
                while (#src > 0 and isAlphabetic(src[1])) do
                    string = string..table.remove(src, 1)
                end

                local reserved = KEYWRODS[string]
                if reserved then
                    table.insert(Tokens, token(string, reserved))
                else
                    table.insert(Tokens, token(string, __exported.TokenType.Identifier))
                end
            elseif (isSkippable(src[1])) then
                table.remove(src, 1)
            else
                print("Unrecognized character found: '"..src[1].."'")
            end
        end
    end

    table.insert(Tokens, {type = __exported.TokenType.EOF, value = "EndOfFile"})
    return Tokens
end

lexer.__exported = __exported

return lexer



--- let x = 45 + 2
