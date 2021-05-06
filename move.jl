include("couts.jl")
include("Instance.jl")
include("Solution.jl")

#= Prend en argument une fonction move à 1 paramètre et une liste de valeurs
    possibles pour ce paramètre et renvoie la meilleure valeur du paramètre =#
function best_move(sol::Solution, inst::Instance, move, param_range)
    costs = []
    for param in param_range
        new_sol = move(sol, param)
        push!(costs, couts(new_sol, inst))
    end
    return move(sol, param_range[argmin(costs)])
end

# Descente locale avec une fonction move en argument qui prend 1 paramètre
function descent_local(sol::Solution, inst::Instance, move, n_iterations, param_range, verbose::Bool=false)
    # Solution et coût initiaux
    best_sol = sol
    cout_sol = couts(sol, inst)
    for i = 1:n_iterations
        # On parcourt une plage de paramètres pour move pour utiliser move de manière optimale
        new_sol = best_move(best_sol, inst, move, param_range) # /!\ Changer la plage de paramètre en fonction du move
        cout_new = couts(new_sol, inst)
        if verbose
            println("Coût : $(cout_sol)")
        end
        if cout_sol > cout_new
            best_sol = new_sol
            cout_sol = cout_new
        end

    end
    return best_sol
end


