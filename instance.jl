# Fichier regroupant les structures permettant de construire l'instance

mutable struct coord
    x::Float64
    y::Float64

    coord(; x, y) = new(x, y)
end

mutable struct depot
    idx::Int # Indice du sommet correspondant
    gps::coord # Coordonnées GPS

    depot(; d, g) = new(d, g)
end

mutable struct usine
    idx::Int # Indice du sommet correspondant
    gps::coord # Coordonnées GPS

    usine(; u, g) = new(u, g)
end

mutable struct fournisseur
    idx::Int # Indice du sommet correspondant
    st_cost::Int # Coût de sous-traitance
    q::Vector{Int} # Volumes par semaines
    gps::coord # Coordonnées GPS

mutable struct Instance
    Q::Int # Taille des camions
    F::Int # Nombre de fournisseurs
    H::Int # Nombre de semaines
    d::depot # Dépôt
    u::usine # Usine
    f::Vector{fournisseur} # fournisseurs
    dist::Matrix{Int} # Graphe des coûts

    Instance(; Q, F, H, d, u) = new(Q, F, H, d, u)
end
