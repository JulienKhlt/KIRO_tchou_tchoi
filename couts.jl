#=
couts:
- Julia version: 
- Author: cgris
- Date: 2021-05-05
=#

include("Solution.jl")

function cout_tournee(t::Tournee, i::Instance) #cout pour une tournée
    s = i.dist[i.d.idx, t.fournisseurs[1].idx]
    for j in 1:(length(t.fournisseurs)-1)
        s += i.dist[t.founisseurs[j].idx,t.fournisseurs[j+1].idx]
    end
    s += i.dist[t.fournisseurs[end].idx, i.u.idx]
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



