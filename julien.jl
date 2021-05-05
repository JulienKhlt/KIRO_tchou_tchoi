include("creation_sol_trivial.jl")
include("Instance.jl")
include("parserIn.jl")
include("Solution.jl")

instance = read_instance("instances/Instance-propre.csv")
print(instance)

sol = creation_sol(instance, 200, 100)
print(sol)

