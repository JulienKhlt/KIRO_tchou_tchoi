include("creation_sol_trivial.jl")
include("Instance.jl")
include("parserIn.jl")
include("Solution.jl")
include("couts.jl")

instance = read_instance("instances/Instance-propre.csv")
println(instance)

sol = creation_sol(instance, 100, 100)
println(sol)

println(couts(sol, instance))

