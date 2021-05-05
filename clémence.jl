
include("cout.jl")

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