include("Instance.jl")
include("parserIn.jl")
include("Solution.jl")

function creation_sol(inst, nb_grpe, nb_soustraite)
    """Fonction qui crée des solutions en se basant sur plusieurs paramètres optimisable"""
    if (nb_grpe <= 0)
        return 1e100
    elseif (nb_soustraite <= 0)
        return 1e100
    end
    fournisseurs = inst.f
    if (length(fournisseurs) - nb_soustraite) / nb_grpe > 4
        return 1e100
    end
    sous_traite = []
    for i in 1:nb_soustraite
        push!(sous_traite, fournisseurs[i])
    end
    Groupes = []
    nb_f = floor((length(fournisseurs) - nb_soustraite) / nb_grpe)
    for g in 1:min(nb_grpe, length(fournisseurs))
        push!(Groupes, [fournisseurs[Int(i) + nb_soustraite].idx for i in ((g-1)*nb_f + 1):min(g*nb_f, length(fournisseurs)- nb_soustraite)])
    end
    Tournees = []
    for g in 1:length(Groupes)
        for s in 1:inst.H
            for f in Groupes[g]
                fournis = [fournisseurs[f]]
                quantites = [max(inst.Q, fournisseurs[f].q[s])]
                push!(Tournees, Tournee(id_grpe = g, s = s, fournisseurs=fournis, quantites=quantites))
            end
        end
    end
    return Solution(Sous_traite = sous_traite, Groupes = Groupes, Tournees = Tournees)
end