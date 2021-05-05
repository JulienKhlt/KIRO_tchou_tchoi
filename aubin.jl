include("couts.jl")
include("Instance.jl")

#= Prend en argument une fonction move à 1 paramètre et une liste de valeurs
    possibles pour ce paramètre et renvoie la meilleure valeur du paramètre =#
function best_move(sol::Solution, inst::Instance, move, param_range)
    costs = []
    for param in param_range
        new_sol = move(sol, param)
        costs.push(couts(new_sol, inst))
    end
    return param_range(argmin(costs))
end
