# Fichier regroupant les structures permettant de construire l'instance

#= Fonctions utiles :
    - generate_instance(path, T, V, capacite) : créer une instance enregistrée en JSON
=#

using JSON
using Random
include("instance.jl")

function random_instance(T::Int, V::Int, capacite::Int)::Instance
   departs = randperm(T)
   arrivees = randperm(T)

   return Instance(T = T, V = V, capacite = capacite, departs = departs, arrivees = arrivees)
end

function parse_instance(inst::Instance, path::String)
    dict = Dict()
    dict["T"] = inst.T
    dict["V"] = inst.V
    dict["capacite"] = inst.capacite
    dict["departs"] = inst.departs
    dict["arrivees"] = inst.arrivees
            
    stringdata = JSON.json(dict)

    open(path, "w") do f
        write(f, stringdata)
    end
end

function generate_instance(path::String, T::Int, V::Int, capacite::Int)
    parse_instance(random_instance(T, V, capacite), path)
end

# generate_instance("TUSP/test.json", 10, 4, 3)
