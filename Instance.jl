# Fichier regroupant les structures permettant de construire l'instance

struct Coord
    x::Float64
    y::Float64

    Coord(; x, y) = new(x, y)
end

struct Depot
    idx::Int # Indice du sommet correspondant
    gps::Coord # Coordonnées GPS

    Depot(; d, g) = new(d, g)
end

struct Usine
    idx::Int # Indice du sommet correspondant
    gps::Coord # Coordonnées GPS

    Usine(; u, g) = new(u, g)
end

struct Fournisseur
    idx::Int # Indice du sommet correspondant
    st_cost::Int # Coût de sous-traitance
    q::Vector{Int} # Volumes par semaines
    gps::Coord # Coordonnées GPS

    Fournisseur(; idx, st_cost, q, gps) = new(idx, st_cost, q, gps)
end

struct Instance
    Q::Int # Taille des camions
    F::Int # Nombre de fournisseurs
    H::Int # Nombre de semaines
    d::Depot # Dépôt
    u::Usine # Usine
    f::Vector{Fournisseur} # fournisseurs
    dist::Matrix{Int} # Graphe des coûts

    Instance(; Q, F, H, d, u) = new(Q, F, H, d, u)
end
