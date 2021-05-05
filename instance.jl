# Fichier regroupant les structures permettant de construire l'instance

mutable struct coord
    x::Float64
    y::Float64

    coord(; x, y) = new(x, y)
end

mutable struct depot
    d::Int # Indice du sommet correspondant
    g::coord # Coordonnées GPS

    depot(; d, g) = new(d, g)
end

mutable struct usine
    u::Int# Indice du sommet correspondant
    g::coord # Coordonnées GPS

    usine(; u, g) = new(u, g)
end

mutable struct Instance
    Q::Int # Taille des camions
    F::Int # Nombre de fournisseurs
    H::Int # Nombre de semaines
    d::depot # Dépôt
    u::usine # Usine

    Instance(; Q, F, H, d, u) = new(Q, F, H, d, u)
end
