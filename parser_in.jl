# Fichier contenant le parseur d'entrée qui permet de lire une instance

#= Fonctions utiles :
    - read_instance(path) : lire une instance
=#

include("Instance.jl")
import JSON

function parser_in(path::String)::Dict
    dict = Dict()
    open(path, "r") do f
        dicttxt = read(f, String)
        dict = JSON.parse(dicttxt)
    end
    return dict
end

function read_train(dict::Dict)::Train
    id = dict["id"]
    sensDepart = dict["sensDepart"]
    voieEnLigne = dict["voieEnLigne"]
    voieAQuai = dict["voieAQuai"]
    typeCirculation = dict["typeCirculation"]
    dateHeure = dict["dateHeure"]
    typesMateriels = dict["typesMateriels"]

    return Train(id = id, sensDepart = sensDepart, voieEnLigne = voieEnLigne, voieAQuai = voieAQuai, typeCirculation = typeCirculation, dateHeure = dateHeure, typesMateriels = typesMateriels)
end

function read_itineraire(dict::Dict)::Itineraire
    id = dict["id"]
    sensDepart = dict["sensDepart"]
    voieEnLigne = dict["voieEnLigne"]
    voieAQuai = dict["voieAQuai"]

    return Itineraire(id = id, sensDepart = sensDepart, voieEnLigne = voieEnLigne, voieAQuai = voieAQuai)
end

function read_interdiction(dict::Dict)::InterdictionsQuais
    id = dict["id"]
    sensDepart = dict["sensDepart"]
    voieEnLigne = dict["voieEnLigne"]
    voieAQuai = dict["voieAQuai"]

    return InterdictionsQuais(id = id, sensDepart = sensDepart, voieEnLigne = voieEnLigne, voieAQuai = voieAQuai)
end

function read_instance(path::String)::Instance
    dict = parser_in(path)
    trains = [[read_train(train) for train in group] for group in dict["trains"]]
    itineraires = [read_itineraire(itineraire) for itineraire in dict["itineraires"]]
    voiesAQuai = dict["voiesAQuai"]
    voiesEnLigne = dict["voiesEnLigne"]
    interdictionsQuais = [read_interdiction(interdiction) for interdiction in dict["interdictionsQuais"]]
    contraintes = dict["contraintes"]

    return Instance(trains = trains, itineraires = itineraires, voiesAQuai = voiesAQuai, voiesEnLigne = voiesEnLigne, interdictionsQuais = interdictionsQuais, contraintes = contraintes)
end

print(parser_in("instances/A.json"))
