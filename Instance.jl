# Fichier regroupant les structures permettant de construire l'instance

#= Structures utiles :
    - Instance
=#

struct Train
    id::Int
    sensDepart::Bool
    voieEnLigne::String
    voieAQuai::String
    typeCirculation::String
    dateHeure::String
    typesMateriels::Vector{String}

    Train(; id, sensDepart, voieEnLigne, voieAQuai, typeCirculation, dateHeure, typesMateriels) = new(id, sensDepart, voieEnLigne, voieAQuai, typeCirculation, dateHeure, typesMateriels)
end
struct Itineraire
    id::Int
    sensDepart::Bool
    voieEnLigne::String
    voieAQuai::String

    Itineraire(; id, sensDepart, voieEnLigne, voieAQuai) = new(id, sensDepart, voieEnLigne, voieAQuai)
end

struct InterdictionsQuais
    voiesAQuaiInterdites::Vector{String}
    voiesEnLigne::Vector{String}
    typesMateriels::Vector{String}
    typesCirculation::Vector{String}

    InterdictionsQuais(; voiesAQuaiInterdites, voiesEnLigne, typesMateriels, typesCirculation) = new(voiesAQuaiInterdites, voiesEnLigne, typesMateriels, typesCirculation)
end

struct Instance
    trains::Vector{Train}
    itineraires::Vector{Itineraire}
    voiesAQuai::Vector{String}
    voiesEnLigne::Vector{String}
    interdictionsQuais::Vector{InterdictionsQuais}
    contraintes::Vector{Vector{Int}}

    Instance(; trains, itineraires, voiesAQuai, voiesEnLigne, interdictionsQuais, contraintes) = new(trains, itineraires, voiesAQuai, voiesEnLigne, interdictionsQuais, contraintes)
end

function Base.show(io::IO, inst::Instance)
    str = "\nInstance"
    str *= "\n   Contraintes : $(inst.contraintes)"
    print(io, str)
end
