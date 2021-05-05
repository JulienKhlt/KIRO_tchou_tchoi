using JSON

struct Tournees
    id_grpe
    fournisseurs
    quantites
end

struct Solution
    Sous_traite::Vector{Int}
    Groupe
    Tournees
end

function parser_out()
    dict1 = Dict("param1" => 1, "param2" => 2,
            "dict" => Dict("d1"=>1.,"d2"=>1.,"d3"=>1.))
            
    # pass data as a json string (how it shall be displayed in a file)
    stringdata = JSON.json(dict1)

    # write the file with the stringdata variable information
    open("write_read.json", "w") do f
        write(f, stringdata)
    end
end

parser_out()