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
    return move(sol, param_range(argmin(costs)))
end

function descent_local(sol::Solution, inst::Instance, best_mov)
    # Solution et coût initiaux
    best_sol = sol
    cout_sol = cout(sol)
    # On parcourt une plage de paramètres pour move pour utiliser move de manière optimale
    new_sol = best_move(sol, inst, move, [])
    cout_new = cout(new_sol)
    if cout_sol>cout_new
        best_sol = new_sol
    end
    return best_sol
end