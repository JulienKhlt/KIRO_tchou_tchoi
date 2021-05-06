include("couts.jl")
include("Instance.jl")
include("move.jl")
include("parser_in.jl")

# Première manière de définir un voisinage : on arrête de sous-traiter un fournisseur
function changer_itineraire(sol::Solution, inst::Instance, train_idx::Int)::Solution
    Non_Affecte = sol.Non_Affecte
    Affecte = deepcopy(sol.Affecte)
    
    old_itineraire = Affecte[train_idx].itineraire

    for new_itineraire in inst.itineraires
        if old_itineraire.id .= new_itineraire.id & old_itineraire.sensDepart == new_itineraire.sensDepart & old_itineraire.voieEnLigne == new_itineraire.voieEnLigne & old_itineraire.voieAQuai == new_itineraire.voieAQuai
            Affecte[train_idx].itineraires = new_itineraire
        end
    end

    return Solution(Non_Affecte = Non_Affecte, Affecte = Affecte)
end

instance = read_instance("instances/A.json")


# sol = descent_local(sol, inst, remove_sous_traite, 300, true)
