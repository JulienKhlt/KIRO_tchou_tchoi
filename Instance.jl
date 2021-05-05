# Fichier regroupant les structures permettant de construire l'instance

struct Coord
    x::Float64
    y::Float64

    Coord(x, y) = new(x, y)
end

struct Depot
    idx::Int # Indice du sommet correspondant
    gps::Coord # Coordonnées GPS

    Depot(idx, gps) = new(idx, gps)
end

struct Usine
    idx::Int # Indice du sommet correspondant
    gps::Coord # Coordonnées GPS

    Usine(idx, gps) = new(idx, gps)
end

struct Fournisseur
    idx::Int # Indice du sommet correspondant
    st_cost::Int # Coût de sous-traitance
    q::Vector{Int} # Volumes par semaines
    gps::Coord # Coordonnées GPS

    Fournisseur(idx, st_cost, q, gps) = new(idx, st_cost, q, gps)
end

struct Instance
    Q::Int # Taille des camions
    F::Int # Nombre de fournisseurs
    H::Int # Nombre de semaines
    d::Depot # Dépôt
    u::Usine # Usine
    f::Vector{Fournisseur} # fournisseurs
    dist::Matrix{Int} # Graphe des coûts

    Instance(Q, F, H, d, u, f, dist) = new(Q, F, H, d, u, f, dist)
end

function Base.show(io::IO, instance::Instance)
    str = "\nInstance"
    str *= "\n   Taille des camions : $(instance.Q)"
    str *= "\n   Nombre de fournisseurs : $(instance.F)"
    str *= "\n   Nombre de semaines : $(instance.H)"
    print(io, str)
end
