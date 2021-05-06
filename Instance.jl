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
    trains::Vector{Vector{Train}}
    itineraires::Vector{Itineraire}
    voiesAQuai::Vector{String}
    voiesEnLigne::Vector{String}
    interdictionsQuais::Vector{InterdictionsQuais}
    contraintes::Vector{Vector{Int}}

    Instance(; trains, itineraires, voiesAQuai, voiesEnLigne, interdictionsQuais, contraintes) = new(trains, itineraires, voiesAQuai, voiesEnLigne, interdictionsQuais, contraintes)
end

function Base.show(io::IO, inst::Instance)
    str = "\nInstance"
    str *= "\n   Nombre de groupes : $(length(inst.trains))"
    # str *= "\n   Nombre de trains par groupe : $([size(inst.trains[g], 1) for g = 1:inst.trains])"
    str *= "\n   Nombre d'itinéraires : $(length(inst.itineraires))"
    str *= "\n   Voies à quai : $(inst.voiesAQuai)"
    str *= "\n   Voies en ligne : $(inst.voiesEnLigne)"
    str *= "\n   Nombre d'interdictions : $(length(inst.interdictionsQuais))"
    str *= "\n   Nombre de contraintes : $(length(inst.contraintes))"
    print(io, str)
end

function Base.show(io::IO, train::Train)
    str = "\nTrains"
    str *= "\n   id : $(train.id)"
    str *= "\n   sensDepart : $(train.sensDepart)"
    str *= "\n   voieEnLigne : $(train.voieEnLigne)"
    str *= "\n   voieAQuai : $(train.voieAQuai)"
    str *= "\n   typeCirculation : $(train.typeCirculation)"
    str *= "\n   dateHeure : $(train.dateHeure)"
    str *= "\n   typesMateriels : $(train.typesMateriels)"
    print(io, str)
end

function Base.show(io::IO, itineraire::Itineraire)
    str = "\nItineraires"
    str *= "\n   id : $(itineraire.id)"
    str *= "\n   sensDepart : $(itineraire.sensDepart)"
    str *= "\n   voieEnLigne : $(itineraire.voieEnLigne)"
    str *= "\n   voieAQuai : $(itineraire.voieAQuai)"
    print(io, str)
end

function Base.show(io::IO, interdiction::InterdictionsQuais)
    str = "\nInterdictionsQuais"
    str *= "\n   voiesAQuaiInterdites : $(interdiction.voiesAQuaiInterdites)"
    str *= "\n   voiesEnLigne : $(interdiction.voiesEnLigne)"
    str *= "\n   typesMateriels : $(interdiction.typesMateriels)"
    str *= "\n   typesCirculation : $(interdiction.typesCirculation)"
    print(io, str)
end
