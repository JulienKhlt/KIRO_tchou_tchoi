# Fichier regroupant les structures permettant de construire l'instance

#= Fonctions utiles :
    - glouton(inst) : renvoie une solution gloutonne du problème
=#

using Random
include("instance.jl")
include("solution.jl")

function meilleure_voie(inst::Instance, repartition::Vector{Vector{Int}}, train_idx::Int)::Int
    couts = [0 for idx = 1:inst.V]
    for voie_idx in randperm(inst.V)
        if length(repartition[voie_idx]) > inst.capacite
            couts[voie_idx] = 10000
        else
            for train in repartition[voie_idx]
                # On considère des voies en LIFO (entrée le soir = sortie le matin)
                if inst.departs[train] > inst.departs[train_idx]
                    couts[voie_idx] += 1
                end
            end
        end
    end
    # println("Répartition : $(repartition), Couts : $(couts)")
    return argmin(couts)
end

function glouton(inst::Instance)::Solution
    repartition = [Vector{Int}(undef, 0) for idx = 1:inst.V]
    for idx = 1:inst.T
        # Indice du ième train à arriver
        train_idx = findall(x -> x == idx, inst.arrivees)[1]
        # On ajoute la train sur la voie qui minimise le nombre de trains bloqués
        push!(repartition[meilleure_voie(inst, repartition, train_idx)], train_idx)
    end
    return Solution(repartition = repartition)
end
