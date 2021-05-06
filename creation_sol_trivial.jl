include("Instance.jl")
include("Solution.jl")

function material_in(train, interdiQ)
    for mat in train.typesMateriels
        if mat in interdiQ.typesMateriels
            return true
        end
    end
    return false
end  

function find_all_possible(inst, train, all_it, quai)
    new_all_it = []
    for it in all_it
        forbid = false
        for i in 1:length(inst.interdictionsQuais)
            if quai in inst.interdictionsQuais[i].voiesAQuaiInterdites
                forbid = true
                if !(material_in(train, inst.interdictionsQuais[i]) || train.typeCirculation in inst.interdictionsQuais[i].typesCirculation || train.voieEnLigne in inst.interdictionsQuais[i].voiesEnLigne)
                    push!(new_all_it, it)
                end
            end
        end
        if forbid == false
            push!(new_all_it, it)
        end
    end
    return new_all_it
end

function find_it(inst, train, quai)
    all_it = []
    for it in inst.itineraires
        if train.voieEnLigne == it.voieEnLigne && quai == it.voieAQuai && train.sensDepart == it.sensDepart 
            return push!(all_it, it)
        end
    end
    return all_it
end

function creation_sol(inst, nb_nonaffecte)
    Non_Affecte = []
    Affecte = []
    for groupe in inst.trains
        Affecte_groupe = []
        Non_Affecte_groupe = []
        for train in groupe
            all_it = find_it(inst, train, train.voieAQuai)
            all_it = find_all_possible(inst, train, all_it, train.voieAQuai)
            if length(all_it) != 0
                push!(Affecte_groupe, Affectation_Train(id=train.id, voie_Quai=train.voieAQuai, it=all_it[1]))
            else
                push!(Non_Affecte_groupe, Affectation_Train(id=train.id, voie_Quai="notAffected", it=Itineraire(id="notAffected", sensDepart=true, voieEnLigne="", voieAQuai="")))
            end
        end
        if length(Non_Affecte_groupe) == 0
            append!(Affecte, Affecte_groupe)
        else
            for train in groupe
                push!(Non_Affecte, Affectation_Train(id=train.id, voie_Quai="notAffected", it=Itineraire(id="notAffected", sensDepart=true, voieEnLigne="", voieAQuai="")))
            end
        end
    end
    return Solution(Non_Affecte=Non_Affecte, Affecte=Affecte)
end