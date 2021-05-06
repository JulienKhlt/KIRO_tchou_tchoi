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
                if (material_in(train, inst.interdictionsQuais[i]) || train.typeCirculation in inst.interdictionsQuais[i].typesCirculation || train.voieEnLigne in inst.interdictionsQuais[i].voiesEnLigne)
                    forbid = true
                end
            end
        end
        

        if forbid == false
            push!(new_all_it, it)
        end
    end
    if train.id == 526
        println(quai)
        println(new_all_it)
    end
    return new_all_it
end

function find_it(inst, train, quai)
    all_it = []
    for it in inst.itineraires
        if train.voieEnLigne == it.voieEnLigne && quai == it.voieAQuai && train.sensDepart == it.sensDepart 
            push!(all_it, it)
        end
    end
    if train.id == 593
        println(quai)
        println(all_it)
    end
    return all_it
end

function best_it(inst, id, all_it, before)
    cost = [0 for i in 1:length(all_it)]
    for i in 1:length(all_it)
        for cont in inst.contraintes
            if cont[2] == all_it[i].id && cont[1] == id
                if haskey(before, "$(cont[3])") && before["$(cont[3])"] == cont[4]
                    cost[i] += cont[5]
                end
            elseif cont[4] == all_it[i].id && cont[3] == id
                if haskey(before, "$(cont[1])") && before["$(cont[1])"] == cont[2]
                    cost[i] += cont[5]
                end
            end
        end
    end
    return all_it[argmin(cost)]
end

function creation_sol(inst, nb_nonaffecte, fast=true)
    Non_Affecte = []
    Affecte = []
    before = Dict()
    for groupe in inst.trains
        Affecte_groupe = []
        Non_Affecte_groupe = []
        for train in groupe
            all_it = find_it(inst, train, train.voieAQuai)
            all_it = find_all_possible(inst, train, all_it, train.voieAQuai)
            if length(all_it) != 0
                if length(all_it) == 1 || fast
                    it = all_it[1]
                else
                    it = best_it(inst, train.id, all_it, before)
                end
                push!(Affecte_groupe, Affectation_Train(id=train.id, voie_Quai=train.voieAQuai, it=it))
                get!(before, "$(train.id)", it.id)
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

function is_not_possible(train::Train, quai::String, interdictions::Vector{InterdictionsQuais})::Bool
    for interdiction in interdictions
        if (quai in interdiction.voiesAQuaiInterdites)
            if (material_in(train, interdiction) || train.typeCirculation in interdiction.typesCirculation || train.voieEnLigne in interdiction.voiesEnLigne)
                return true
            end
        end
    end
    return false
end

function possible_quais(groupe::Vector{Train}, inst::Instance)::Vector{String}
    quais = []
    for quai in inst.voiesAQuai
        forbid = false
        for train in groupe
            if is_not_possible(train, quai, inst.interdictionsQuais)
                forbid = true
            end
        end
        if !forbid
            push!(quais, quai)
        end
    end
    return quais
end