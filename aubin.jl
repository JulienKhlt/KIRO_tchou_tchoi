include("couts.jl")
include("Instance.jl")
include("move.jl")
include("parser_in.jl")
include("julien.jl")

function itineraires_possibles(itineraire::Itineraire, inst::Instance)::Vector{Itineraire}
    it_possibles = []
    for new_itineraire in inst.itineraires
        if itineraire.id == new_itineraire.id & itineraire.sensDepart == itineraire.sensDepart & itineraire.voieEnLigne == new_itineraire.voieEnLigne & itineraire.voieAQuai == new_itineraire.voieAQuai
            push!(it_possibles, new_itineraire)
        end
    end
    return it_possibles
end

#= train_idx : indice du train à changer (indice dans la liste Affecte) =#
function best_itineraire(sol::Solution, train_idx::Int, it_possibles::Vector{Itineraire})::Itineraire
    couts = []
    for itineraire in it_possibles
        new_affectation = Affectation_Train(id = sol.Affecte[train_idx].idx, voie_Quai = sol.Affecte[train_idx].voie_Quai, it = itineraire)
        Affecte = deepcopy(sol.Affecte)
        Affecte[train_idx] = new_affectation
        new_sol = Solution(Non_Affecte = sol.Non_Affecte, Affecte)
        push!(couts, couts(new_sol, inst)) ############ REMPLACABLE PAR COUT_TRAIN ##############
    end
    return it_possibles[argmin(couts)]
end

# Première manière de définir un voisinage : on arrête de sous-traiter un fournisseur
function changer_itineraire(sol::Solution, inst::Instance, train_idx::Int)::Solution
    Non_Affecte = sol.Non_Affecte
    Affecte = deepcopy(sol.Affecte)
    
    it_possibles = itineraires_possibles(Affecte[train_idx].it, inst)
    if length(it_possibles) > 0
        best_it = best_itineraire(sol, train_idx, it_possibles)
        new_affectation = Affectation_Train(id = sol.Affecte[train_idx].idx, voie_Quai = sol.Affecte[train_idx].voie_Quai, it = best_it)
        Affecte[train_idx] = new_affectation
    end
    
    return Solution(Non_Affecte = Non_Affecte, Affecte = Affecte)
end

inst = read_instance("instances/A.json")

Non_Affecte = []
Affecte = []
for i in 1:length(inst.trains)
    it = find_it(inst, inst.trains[i][1])
    for j in 1:length(inst.trains[i])
        if (it != false && length(Affecte) == 0)
            push!(Affecte, Affectation_Train(id=inst.trains[1][j].id, voie_Quai=inst.trains[1][j].voieAQuai, it=find_it(inst, inst.trains[1][j])))
        else
            push!(Non_Affecte, Affectation_Train(id=inst.trains[i][j].id, voie_Quai="notAffected", it=Itineraire(id="notAffected", sensDepart=true, voieEnLigne="", voieAQuai="")))
        end
    end
end
sol = Solution(Non_Affecte=Non_Affecte, Affecte=Affecte)
sol = descent_local(sol, inst, changer_itineraire, 300, true)
