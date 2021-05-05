using JSON
include("Instance.jl")

struct Tournees
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
    Tournees

    Solution(Sous_traite, Groupe, Tournees) = new(Sous_traite, Groupe, Tournees)
end