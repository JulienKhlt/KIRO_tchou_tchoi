include("couts.jl")
include("Instance.jl")
include("Solution.jl")
include("move.jl")
include("parser_in.jl")

include("julien.jl")

#include("aubin.jl")

function move_non_affect(sol::Solution, inst::Instance, groupe::Int)

        for train in inst.trains[groupe] #train dans le groupe dans l'instance
            for i in 1:length(sol.Affecte)
                t = sol.Affecte[i]
                if t.id == train.id #train associé dans la solution
                    if ! (t.id == "notAffected")
                        deleteat!(sol.Affecte,i)
                        t.voie_Quai = "notAffected"
                        t.it = Itineraire(id="notAffected", sensDepart=false, voieEnLigne="notAffected", voieAQuai="notAffected")
                        push!(sol.Non_Affecte,t)
                    else
                        println("groupe ", groupe , " deja non affecté")
                    end
                end
            end
        end
end




inst = read_instance("instances/A.json")
Non_Affecte = []
Affecte = []
for i in 1:length(inst.trains)
    it = find_it(inst, inst.trains[i][1])
    for j in 1:length(inst.trains[i])
        if (it != false && length(Affecte) == 0)
            push!(Affecte, Affectation_Train(id=inst.trains[1][j].id, voie_Quai=inst.trains[1][j].voieAQuai, it=find_it(inst, inst.trains[1][j])))
        else
            push!(Non_Affecte, Affectation_Train(id=inst.trains[i][j].id, voie_Quai="notAffected", it=Itineraire(id="notAffected", sensDepart=true, voieEnLigne="", voieAQuai="")))
        end
    end
end
sol = Solution(Non_Affecte=Non_Affecte, Affecte=Affecte)
couts(sol,inst,true)

for groupe in 1:length(inst.trains)
    move_non_affect(sol,inst,groupe)
end

couts(sol,inst,true)