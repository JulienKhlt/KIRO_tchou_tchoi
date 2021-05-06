# include("creation_sol_trivial.jl")
include("Instance.jl")
include("parser_in.jl")
include("Solution.jl")
include("parser_out.jl")
include("couts.jl")
include("creation_sol_trivial.jl")
# include("opti.jl")

# instance = read_instance("instances/Instance-propre.csv")
# # println(instance)

# # println(@time sol = creation_sol(instance, 100, 1))
# # println(@time sol = creation_sol(instance, 100, 100))
# # println(@time sol = creation_sol(instance, 100, 100))

# # println(sol)

# # println(@time couts(sol, instance))
# # println(@time couts(sol, instance))
# # println(@time couts(sol, instance))

# eval_sol(x) = couts(creation_sol(instance, trunc(Int, x[1]), trunc(Int, x[2])), instance)
# println(@time get_best_sol(eval_sol, [100., 100.], [0.5, 1.]))
# println(@time get_best_sol(eval_sol, [100., 100.], [0.5, 1.]))

inst = read_instance("instances/NS.json")
println(@time sol = creation_sol(inst, 0))
println(@time sol = creation_sol(inst, 0))
println(sol)
# println(@time couts(sol, inst, true))
parser_out(sol, "test.json")