include("couts.jl")
include("Instance.jl")
include("move.jl")
include("parser_in.jl")

# Première manière de définir un voisinage : on arrête de sous-traiter un fournisseur
function changer_itineraire(sol::Solution, idx::Int)::Solution
    Non_Affecte = sol.Non_Affecte
    Affecte = deepcopy(sol.Affecte)

    if size(sol.Sous_traite, 1) >= 2
        deleteat!(Sous_traite, idx)
    end

    return Solution(Sous_traite = Sous_traite, Groupes = Groupes, Tournees = Tournees)
end

instance = read_instance("instances/A.json")
println(instance)

# sol = descent_local(sol, inst, remove_sous_traite, 300, true)
