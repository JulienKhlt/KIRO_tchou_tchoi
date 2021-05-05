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

function descent_local(sol::Solution, best_mov)
    best_sol = sol
    cout_sol = cout(sol)
    new_sol = best_mov(sol)  #parcourir tous les mov possible
    cout_new = cout(new_sol)
    if cout_sol>cout_new
        best_sol = new_sol
    end
    return best_sol
end