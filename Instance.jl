# Fichier regroupant les structures permettant de construire l'instance

struct Coord
    x::Float64
    y::Float64

    Coord(; x, y) = new(x, y)
end

struct Depot
    idx::Int # Indice du sommet correspondant
    gps::coord # Coordonnées GPS

    Depot(; d, g) = new(d, g)
end

struct Usine
    idx::Int # Indice du sommet correspondant
    gps::coord # Coordonnées GPS

    Usine(; u, g) = new(u, g)
end

struct Fournisseur
    idx::Int # Indice du sommet correspondant
    st_cost::Int # Coût de sous-traitance
    q::Vector{Int} # Volumes par semaines
    gps::coord # Coordonnées GPS

    Fournisseur(; idx, st_cost, q, gps) = new(; idx, st_cost, q, gps)
end

struct Instance
    Q::Int # Taille des camions
    F::Int # Nombre de fournisseurs
    H::Int # Nombre de semaines
    d::depot # Dépôt
    u::usine # Usine
    f::Vector{fournisseur} # fournisseurs
    dist::Matrix{Int} # Graphe des coûts

    Instance(; Q, F, H, d, u) = new(Q, F, H, d, u)
end
