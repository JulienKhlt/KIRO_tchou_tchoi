#=
couts:
- Julia version: 
- Author: cgris
- Date: 2021-05-05
=#

include("solution.jl")

function cout_tournee(t::tournee, i::Instance) #cout pour une tournée
    s = Dist(i.usine.idx,t.fournisseurs[1].idx)
    for i in 1:(length(t.fournisseurs)-1)
        s+=Dist(t.founisseurs[i].idx,t.fournisseurs[i+1].idx)
    end
    s += Dist(t.fournisseurs[end].ind,i.depot.idx)
    return s
end

function couts(sol::Solution,inst::Instance)
    c = 0
    for t in sol.Tournees
        c += cout_tournee(t,inst)
    end
     for f in sol.Sous_traite
        c += f.st_cost
     end
     return c

end