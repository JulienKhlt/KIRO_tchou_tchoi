# Fichier contenant le parseur d'entrée qui permet de lire une instance

#= Fonctions utiles :
    - read_instance(path) : lire une instance
=#

include("Instance.jl")
import JSON

function parser_in(path::String)::Dict
    dict = Dict()
    open(path, "r") do f
        dicttxt = read(f, String)
        dict = JSON.parse(dicttxt)
    end
    return dict
end

function read_instance(path::String)::Instance
    dict = parser_in(path)
    trains = []
    itineraires = []
    voiesAQuai = []
    voiesEnLigne::Vector{String}
    interdictionsQuais::Vector{InterdictionsQuais}
    contraintes::Vector{Vector{Int}}

    return Instance()
end

# instance_test = read_instance("TUSP/test.json")
# print(instance_test)



print(parser_in("C:/Users/aubin/GitHub/instances/A.json"))
