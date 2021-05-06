include("Solution.jl")

function parser_out(sol::Solution, file_name)
    dict = Dict()
    for aff_train in sol.Non_Affecte
        get!(dict, "$(aff_train.id)", Dict("voieAQuai" => aff_train.voie_Quai, "itineraire" => aff_train.it.id))
    end
    for aff_train in sol.Affecte
        get!(dict, "$(aff_train.id)", Dict("voieAQuai" => aff_train.voie_Quai, "itineraire" => aff_train.it.id))
    end
            
    # pass data as a json string (how it shall be displayed in a file)
    stringdata = JSON.json(dict)

    # write the file with the stringdata variable information
    open(file_name, "w") do f
        write(f, stringdata)
    end
end