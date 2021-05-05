include("Solution.jl")

function parser_out(sol::Solution, file_name)
    dict = Dict()
    get!(dict, "param3", 8)
            
    # pass data as a json string (how it shall be displayed in a file)
    stringdata = JSON.json(dict)

    # write the file with the stringdata variable information
    open(file_name, "w") do f
        write(f, stringdata)
    end
end