# include("creation_sol_trivial.jl")
# include("Instance.jl")
# include("parserIn.jl")
include("Solution.jl")
include("parser_out.jl")
# include("couts.jl")
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
Non_Affecte = []
for i in 0:442
    push!(Non_Affecte, Affectation_Train(id_train=i, voie_Quai="notAffected", it="notAffected"))
end
# Affecte = [Affectation_Train(id_train=0, voie_Quai="", it="")]
Affecte = []
sol = Solution(Non_Affecte=Non_Affecte, Affecte=Affecte)
parser_out(sol, "test.json")