# include("Instance.jl")
# include("Solution.jl")
# include("creation_sol_trivial.jl")

using Optim

function dg(n, i)
    dx = zeros(n)
    dx[i] = 1.0
    return dx
end

function grad(G, x, f, step)
    for i in 1:length(G)
        G[i] = (f(x + dg(length(G), i)*step[i]) - f(x)) / step[i]
    end
end

function get_best_sol(f, x0, step)
    g!(G, x) = grad(G, x, f, step)
    opt = optimize(f, g!, x0)
    return Optim.minimizer(opt), Optim.minimum(opt)
end