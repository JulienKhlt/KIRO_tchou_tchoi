# include("Instance.jl")
# include("Solution.jl")
# include("creation_sol_trivial.jl")

using Optim

f(x) = x[1]^2 + x[2]^2

function g!(G, x)
    step = 0.1
    G[1] = (f(x + [1, 0]*step) - f(x)) / step
    G[2] = (f(x + [0, 1]*step) - f(x)) / step
    end


x0 = [0.0, 1.5]
println(optimize(f, g!, x0))