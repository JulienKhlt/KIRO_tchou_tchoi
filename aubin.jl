include("couts.jl")
include("Instance.jl")

# Première manière de définir un voisinage : on arrête de sous-traiter un fournisseur
function remove_sous_traite(sol::Solution, idx::Int)::Solution
    Sous_traite = deepcopy(sol.Sous_traite)
    Groupes = sol.Groupes
    Tournees = sol.Tournees

    if size(sol.Sous_traite, 1) >= 1
        deleteat!(Sous_traite, idx)
    else
        println("Plus de fournisseurs sous-traités.")
    end
    return Solution(Sous_traite = Sous_traite, Groupes = Groupes, Tournees = Tournees)
end
