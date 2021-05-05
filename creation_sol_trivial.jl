include("Instance.jl")
include("parserIn.jl")

function creation_sol(inst, nb_grpe, nb_soustraite)
    """Fonction qui crée des solutions en se basant sur plusieurs paramètres optimisable"""
    fournisseurs = inst.f
    if (length(fournisseurs) - nb_soustraite) / nb_grpe > 4
        return 1e10
    end
    sous_traite = []
    for i in 1:nb_soustraité
        push!(sous_traite, fournisseurs[i].idx)
    end
    Groupe = []
    nb_f = floor((length(fournisseurs) - nb_soustraite) / nb_grpe)
    for g in 1:min(nb_grpe, length(fournisseurs))
        push!(Groupe, [fournisseurs[i + nb_soustraite].idx for i in ((g-1)*nb_f + 1):max(g*nb_f, length(fournisseurs))])
    end
    Tournees = []
    for g in 1:length(Groupe)
        for s in 1:inst.H
            for f in Groupe[g]
                fournis = [f]
                quantites = [max(inst.Q, fournisseurs[f].q[s])]
                push!(Tournees, Tournee(id_grpe = g, s = s, fournisseurs=fournis, quantites=quantites))
            end
        end
    end
    return Solution(Sous_traite = sous_traite, Groupe = Groupe, Tournees = Tournees)
end