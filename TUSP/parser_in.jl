# Fichier contenant le parseur d'entrée qui permet de lire une instance

#= Fonctions utiles :
    - read_instance(path) : lire une instance
=#

using JSON
include("instance.jl")

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
    T = dict["T"]
    V = dict["V"]
    capacite = dict["capacite"]
    departs = dict["departs"]
    arrivees = dict["arrivees"]

    return Instance(T = T, V = V, capacite = capacite, departs = departs, arrivees = arrivees)
end

# instance_test = read_instance("TUSP/test.json")
# print(instance_test)
