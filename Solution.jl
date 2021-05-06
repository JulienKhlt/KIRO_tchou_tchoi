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
    str = "Non Affecte :\n"
    for i in 1:length(sol.Non_Affecte)
        str *= " $(sol.Non_Affecte[i].id_train) "
    end
    str = "\nNon Affecte :\n"
    for i in 1:length(sol.Affecte)
        str *= " $(sol.Affecte[i].id_train), voie : $(sol.Affecte[i].voie_Quai), itinéraire : $(sol.Affecte[i].it)"
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