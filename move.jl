using Random
include("couts.jl")
include("Instance.jl")
include("Solution.jl")

#= Prend en argument une fonction move à 1 paramètre et une liste de valeurs
    possibles pour ce paramètre et renvoie la meilleure valeur du paramètre =#
function best_move(sol::Solution, inst::Instance, move, param_range)
    costs = []
    for param in param_range
        new_sol = move(sol, inst, param)
        push!(costs, couts(new_sol, inst))
    end
    return move(sol, inst, param_range[argmin(costs)])
end

# Descente locale avec une fonction move en argument qui prend 1 paramètre
function descent_local(sol::Solution, inst::Instance, move, n_iter_max, verbose::Bool=false)
    # Solution et coût initiaux
    best_sol = sol
    cout_sol = couts(sol, inst)
    count = 0
    n_iter = 0
    while count < 2 * length(best_sol.Affecte) && n_iter < n_iter_max
        # On parcourt une plage de paramètres pour move pour utiliser move de manière optimale
        # new_sol = best_move(best_sol, inst, move, 1:length(best_sol.Affecte)) # /!\ Changer la plage de paramètre en fonction du move
        new_sol = move(best_sol, inst, rand(1:length(best_sol.Affecte)))
        cout_new = couts(new_sol, inst)
        if verbose
            println("Coût initial : $(cout_sol)")
            println("Coût final : $(cout_new)")
        end
        if cout_sol > cout_new
            best_sol = new_sol
            cout_sol = cout_new
            count = 0
        else
            count += 1
        end
        n_iter += 1
        if n_iter == n_iter_max
            println("Nombre max d'itérations atteint")
        end
    end
    return best_sol
end

function descent_local_combine(sol::Solution, inst::Instance, move1, move2, verbose::Bool=false)
    # Solution et coût initiaux
    best_sol = sol
    cout_sol = couts(sol, inst)
    while total_count < 3
        count1 = 0
        n_iter = 0
        n_iter_max = 100
        while count1 < 2 * length(best_sol.Affecte) && n_iter < n_iter_max
            new_sol = move1(best_sol, inst, rand(1:length(best_sol.Affecte)))
            cout_new = couts(new_sol, inst)
            if verbose
                println("Coût initial : $(cout_sol)")
                println("Coût final : $(cout_new)")
            end
            if cout_sol > cout_new
                best_sol = new_sol
                cout_sol = cout_new
                count1 = 0
            else
                count1 += 1
            end
            n_iter += 1
            if n_iter == n_iter_max
                println("Nombre max d'itérations atteint")
            end
        end
        count2 = 0
        n_iter = 0
        while count2 < 2 * length(best_sol.Affecte) && n_iter < n_iter_max
            new_sol = move2(best_sol, inst, rand(1:length(best_sol.Affecte)))
            cout_new = couts(new_sol, inst)
            if verbose
                println("Coût initial : $(cout_sol)")
                println("Coût final : $(cout_new)")
            end
            if cout_sol > cout_new
                best_sol = new_sol
                cout_sol = cout_new
                count2 = 0
            else
                count2 += 1
            end
            n_iter += 1
            if n_iter == n_iter_max
                println("Nombre max d'itérations atteint")
            end
        end
    end
    return best_sol
end