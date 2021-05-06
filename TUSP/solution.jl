# Fichier regroupant les structures permettant de construire l'instance

#= Structures utiles :
    - Solution
=#

struct Solution
    repartition::Vector{Vector{Int}} # Répartition des trains par voie (ième élément : indices des trains sur la ième voie)

    Solution(; repartition) = new(repartition)
end

function Base.show(io::IO, sol::Solution)
    str = "\nSolution"
    for voie_idx in 1:length(sol.repartition)
        str *= "\n   Trains sur la voie $(voie_idx) : $(sol.repartition[voie_idx])"
    end
    print(io, str)
end
