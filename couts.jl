#=
couts:
- Julia version: 
- Author: cgris
- Date: 2021-05-05
=#

include("Solution.jl")

function cout_tournee(t::Tournee, i::Instance) #cout pour une tournée
    s = i.dist[i.d.idx+1, t.fournisseurs[1].idx+1]
    for j in 1:(length(t.fournisseurs)-1)
        s += i.dist[t.founisseurs[j].idx+1,t.fournisseurs[j+1].idx+1]
    end
    s += i.dist[t.fournisseurs[end].idx+1, i.u.idx+1]
    return s
end

function couts(sol::Solution, inst::Instance)
    c = 0
    for t in sol.Tournees
        c += cout_tournee(t,inst)
    end
    for f in sol.Sous_traite
        c += f.st_cost
    end
    return c
end

function couts(large::Float64, inst::Instance)
    return large
end

