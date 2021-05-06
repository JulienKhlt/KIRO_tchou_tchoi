# include("creation_sol_trivial.jl")
include("Instance.jl")
include("parser_in.jl")
include("Solution.jl")
include("parser_out.jl")
include("couts.jl")
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

function find_it(inst, train)
    for it in inst.itineraires
        if train.voieEnLigne == it.voieEnLigne && train.voieAQuai == it.voieAQuai
            return it
        end
    end
    return false
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
println(sol)
println(@time couts(sol, inst, true))
println(@time couts(sol, inst, true))
parser_out(sol, "test.json")