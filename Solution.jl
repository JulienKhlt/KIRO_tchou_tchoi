using JSON
include("Instance.jl")

struct Affectation_Train
    # Id du train
    id::Int

    # Quai
    voie_Quai::String

    # Itinéraire
    it::String
    Affectation_Train(; id, voie_Quai, it) = new(id, voie_Quai, it)
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
    str *= "\nAffecte :\n"
    for i in 1:length(sol.Affecte)
        str *= " $(sol.Affecte[i].id_train), voie : $(sol.Affecte[i].voie_Quai), itinéraire : $(sol.Affecte[i].it)"
    end
    print(io, str)
end