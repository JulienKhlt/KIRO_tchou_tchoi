# Fichier regroupant les structures permettant de construire l'instance

#= Structures utiles :
    - Instance
=#

struct Instance
    T::Int # Nombre de trains
    V::Int # Nombre de voies
    capacite::Int # Nombre max de trains par voie
    departs::Vector{Int} # Ordre des départs
    arrivees::Vector{Int} # Ordre des arrivées

    Instance(; T, V, capacite, departs, arrivees) = new(T, V, capacite, departs, arrivees)
end

function Base.show(io::IO, inst::Instance)
    str = "\nInstance"
    str *= "\n   Nombre de trains : $(inst.T)"
    str *= "\n   Nombre de voies : $(inst.V)"
    str *= "\n   Capacité d'une voie : $(inst.capacite)"
    str *= "\n   Ordre des arrivées : $(inst.arrivees)"
    str *= "\n   Ordre des départs : $(inst.departs)"
    print(io, str)
end
