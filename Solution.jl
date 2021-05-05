using JSON
include("Instance.jl")

struct Tournee
    # Num du Groupe
    id_grpe::Int

    # Semaine
    s::Int

    # Liste des id des fournisseurs ordonnés
    fournisseurs::Vector{Fournisseur}

    # Liste des quantites pris au fournisseur
    quantites::Vector{Int}

    Tournee(; id_grpe, s, fournisseurs, quantites) = new(id_grpe, s, fournisseurs, quantites)
end

struct Solution
    # Liste des id des fournisseurs sous traité
    Sous_traite::Vector{Fournisseur}
    
    # Liste des groupes qui contiennent les indices des fournisseurs
    Groupes::Vector{Vector{Int}}

    # Liste des Tournees
    Tournees::Vector{Tournee}

    Solution(; Sous_traite, Groupes, Tournees) = new(Sous_traite, Groupes, Tournees)
end

function Base.show(io::IO, sol::Solution)
    str = "Fournisseur sous_traite :\n"
    for i in 1:length(sol.Sous_traite)
        str *= " $(sol.Sous_traite[i].idx) "
    end
    str *= "\nGroupe : \n"
    for i in 1:length(sol.Groupes)
        for j in 1:length(sol.Groupes[i])
            str *= " $(sol.Groupes[i][j]) "
        end
        str *= "\n"
    end
    str *= "Tournées : \n"
    for i in 1:length(sol.Tournees)
        str *= " $(sol.Tournees[i].s) $(sol.Tournees[i].id_grpe)\n"
        for j in 1:length(sol.Tournees[i].fournisseurs)
            str *= "    $(sol.Tournees[i].fournisseurs[j].idx) $(sol.Tournees[i].quantites[j])\n"
        end
    end
    print(io, str)
end