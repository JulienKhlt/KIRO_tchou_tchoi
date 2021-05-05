import JSON
include("Instance.jl")

function parser_in(path::String)::Dict
    dict2 = Dict()
    open(path, "r") do f
        global dict2
        dicttxt = readall(f)
        dict2=JSON.parse(dicttxt)
    end
    return dict2
end

print(parser_in("appsscript.json"))
