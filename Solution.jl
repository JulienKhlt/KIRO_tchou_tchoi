using JSON
include("Instance.jl")

struct Affectation_Train
    # Id du train
    id_train::Int

    # Quai
    voie_Quai::String

    # Itinéraire
    it::String
    Affectation_Train(; id_train, voie_Quai, it) = new(id_train, voie_Quai, it)
end

struct Solution
    # Liste des id des fournisseurs sous traité
    Non_Affecte::Vector{Affectation_Train}
    
    # Liste des groupes qui contiennent les indices des fournisseurs
    Affecte::Vector{Affectation_Train}

    Solution(; Non_Affecte, Affecte) = new(Non_Affecte, Affecte)
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