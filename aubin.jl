include("couts.jl")
include("Instance.jl")
include("move.jl")
include("parser_in.jl")
include("creation_sol_trivial.jl")
include("parser_out.jl")

# Renvoie les itinéraires possibles pour de mêmes voies
function itineraires_possibles(itineraire::Itineraire, inst::Instance)::Vector{Itineraire}
    it_possibles = []
    for new_itineraire in inst.itineraires
        if itineraire.id != new_itineraire.id && itineraire.sensDepart == new_itineraire.sensDepart && itineraire.voieEnLigne == new_itineraire.voieEnLigne && itineraire.voieAQuai == new_itineraire.voieAQuai
            push!(it_possibles, new_itineraire)
        end
    end
    return it_possibles
end

#= train_idx : indice du train à changer (indice dans la liste Affecte) =#
function best_itineraire(sol::Solution, train_idx::Int, it_possibles::Vector{Itineraire})::Itineraire
    it_couts = []
    for itineraire in it_possibles
        # Calcul du coût lié à une nouvelle affectation où un train (d'indice train_idx) a un itinéraire différent
        new_affectation = Affectation_Train(id = sol.Affecte[train_idx].id, voie_Quai = sol.Affecte[train_idx].voie_Quai, it = itineraire)
        Affecte = deepcopy(sol.Affecte)
        Affecte[train_idx] = new_affectation
        new_sol = Solution(Non_Affecte = sol.Non_Affecte, Affecte = Affecte)
        push!(it_couts, couts(new_sol, inst)) ############ REMPLACABLE PAR COUT_TRAIN ##############
    end
    return it_possibles[argmin(it_couts)]
end

# Première manière de définir un voisinage : on change l'itinéraire d'un seul train affecté
function changer_itineraire(sol::Solution, inst::Instance, train_idx::Int, verbose::Bool = false)::Solution
    Non_Affecte = sol.Non_Affecte
    Affecte = deepcopy(sol.Affecte)
    
    it_possibles = itineraires_possibles(Affecte[train_idx].it, inst)
    if length(it_possibles) > 0
        best_it = best_itineraire(sol, train_idx, it_possibles)
        new_affectation = Affectation_Train(id = sol.Affecte[train_idx].id, voie_Quai = sol.Affecte[train_idx].voie_Quai, it = best_it)
        Affecte[train_idx] = new_affectation
    else
        if verbose
            println("Pas de mouvement possible.")
        end
    end

    return Solution(Non_Affecte = Non_Affecte, Affecte = Affecte)
end

inst = read_instance("instances/NS.json")
sol = creation_sol(inst, 0)
println("Solution crée !")
sol = descent_local(sol, inst, changer_itineraire, true)

parser_out(sol, "descenteLocaleAubinNS.json")

PMP = read_instance("instances/PMP.json")
PMP_sol = creation_sol(PMP, 0)
println("Solution crée !")
PMP_sol = descent_local(PMP_sol, PMP, changer_itineraire, true)

parser_out(PMP_sol, "descenteLocaleAubinPMP.json")

PE = read_instance("instances/PE.json")
PE_sol = creation_sol(PE, 0)
println("Solution crée !")
PE_sol = descent_local(PE_sol, PE, changer_itineraire, true)

parser_out(PE_sol, "descenteLocaleAubinPE.json")
