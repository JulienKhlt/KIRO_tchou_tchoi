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
    for cont in inst.contraintes
        first = false
        second = false
        for train in sol.Affecte
            if train.id == cont[1]
                if train.it.id == cont[2]
                    first = true
                else
                    break
                end
            elseif train.id == cont[3]
                if train.it.id == cont[4]
                    second = true
                else
                    break
                end
            end
        end
        if first && second
            c_n += cont[5]
        end
    end

    if verbose
        println("couts non affectés : ", c_n_a)
        println("couts affectés : ", c_n)
    end

    return c_n_a + c_n
end


function couts_train(sol::Solution, inst::Instance, train::Affectation_Train, verbose::Bool = false)
    if train.id =="notAffected"
        return 0
    end
    c = 0
    t1 = train.id
    i1 = train.it.id
    for i in 1:length(sol.Affecte)
        tp = sol.Affecte[i]
        t2 = tp.id
        i2 = tp.it.id
        for cont in inst.contraintes
            if t1 == cont[1] && i1 == cont[2] && t2 == cont[3] && i2 == cont[4]
                c +=cont[5]
            end
        end
    end

    if verbose
        println("le train ", train.id, " coute ", c)
    end

    return c
end
