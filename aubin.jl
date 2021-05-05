include("couts.jl")
include("Instance.jl")
include("move.jl")
include("parserIn.jl")
include("creation_sol_trivial.jl")

# Première manière de définir un voisinage : on arrête de sous-traiter un fournisseur
function remove_sous_traite(sol::Solution, idx::Int)::Solution
    Sous_traite = deepcopy(sol.Sous_traite)
    Groupes = sol.Groupes
    Tournees = sol.Tournees

    if size(sol.Sous_traite, 1) >= 2
        deleteat!(Sous_traite, idx)
    else
        println("Plus de fournisseurs sous-traités.")
    end
    return Solution(Sous_traite = Sous_traite, Groupes = Groupes, Tournees = Tournees)
end

inst = read_instance("instances/Instance-propre.csv")
sol = creation_sol(inst, 100, 100)
#= Ici c'est normal que le move soit tjrs accepté puisque l'on retire un sous traité
    sans ajouter le coût qui correspond à le gérer nous même =#
sol = descent_local(sol, inst, remove_sous_traite, 300, true)
