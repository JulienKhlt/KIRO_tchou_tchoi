include("creation_sol_trivial.jl")
include("Instance.jl")
include("parserIn.jl")
include("Solution.jl")
include("couts.jl")
include("opti.jl")

instance = read_instance("instances/Instance-propre.csv")
# println(instance)

# println(@time sol = creation_sol(instance, 100, 1))
# println(@time sol = creation_sol(instance, 100, 100))
# println(@time sol = creation_sol(instance, 100, 100))

# println(sol)

# println(@time couts(sol, instance))
# println(@time couts(sol, instance))
# println(@time couts(sol, instance))

eval_sol(x) = couts(creation_sol(instance, trunc(Int, x[1]), trunc(Int, x[2])), instance)
println(@time get_best_sol(eval_sol, [100., 100.], [0.5, 1.]))
println(@time get_best_sol(eval_sol, [100., 100.], [0.5, 1.]))