using JSON
include("Instance.jl")

struct Tournee
    # Num du Groupe
    id_grpe::Int

    # Liste des id des fournisseurs ordonnés
    fournisseurs::Vector{Int}

    # Liste des quantites pris au fournisseur
    quantites::Vector{Int}

    # Semaine
    s::Int

    Tournees(id_grpe, fournisseurs, quantites) = new(id_grpe, fournisseurs, quantites)
end

struct Solution
    # Liste des id des fournisseurs sous traité
    Sous_traite::Vector{fournisseur}
    
    # Liste des groupes qui contiennent les indices des fournisseurs
    Groupes::Vector{Vector{Int}}

    # Liste des Tournees
    Tournees::Vector{Tournee}

    Solution(Sous_traite, Groupe, Tournees) = new(Sous_traite, Groupe, Tournees)
end

function Base.show(io::IO, sol::Solution)
    str = "Fournisseur sous_traite :\n"
    for i in 1:length(sol.Sous_traite)
        str *= " $(sol.Sous_traite[i].idx) "
    end
    str *= "Groupe : \n"
    for i in 1:length(sol.Groupe)
        for j in 1:length(sol.Groupe[i])
            str *= " $(sol.Groupe[i][j]) "
        end
        str *= "\n"
    end
    str *= "Tournées : \n"
    for i in 1:length(Tournees)
        str *= " $(Tournees[i].s) $(Tournees[i].id_grpe)\n"
        for j in 1:length(Tournees[i].fournisseurs)
            str *= "    $(Tournees[i].fournisseurs[j]) $(Tournees[i].quantites[j])\n"
        end
    end
    print(io, str)
end