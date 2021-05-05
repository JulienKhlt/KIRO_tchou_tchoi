import JSON

function parser_in(path::String)::Dict
    dict = Dict()
    open(path, "r") do f
        dicttxt = read(f, String)
        dict = JSON.parse(dicttxt)
    end
    return dict
end

print(parser_in("appsscript.json")["runtimeVersion"])
