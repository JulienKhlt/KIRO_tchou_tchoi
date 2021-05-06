#=
couts:
- Julia version: 
- Author: cgris
- Date: 2021-05-05
=#

include("Solution.jl")

function couts(sol::Solution, inst::Instance, verbose::Bool = false)
    c_n_a = length(sol.Non_Affecte)*inst.c0
    c_n = 0
    for t in sol.Affecte
        for tp in sol.Affecte
            t1 = t.id
            i1 = t.it.id
            t2 = tp.id
            i2 = tp.it.id
            for cont in inst.contraintes
                if t1 == cont[1] && i1 == cont[2] && t2 == cont[3] && i2 == cont[4]
                    c_n +=cont[5]
                end
            end
        end
    end

    if verbose
        println("couts non affectés : ", c_n_a)
        println("couts affectés : ", c_n)
    end

    return c_n_a + c_n
end


function couts_train(sol::Solution, inst::Instance, train::Affectation_Train, verbose::Bool = false)
    if train.id =="Non_Affecte"
        return 0
    end
    c = 0
    for i in range length(sol.Affecte)
        t1=train.id

    end
end
