# Fichier de test Aubin

include("instance.jl")
include("solution.jl")
include("parser_in.jl")
include("glouton.jl")

instance_test = read_instance("TUSP/test.json")
print(instance_test)

sol_glouton = glouton(instance_test)
print(sol_glouton)
