include("Instance.jl")

function read_parameters(row::String)::NamedTuple
    row_split = split(row, r"\s+")
    return (
        Q = parse(Int, row_split[2]),
        F = parse(Int, row_split[4]),
        H = parse(Int, row_split[6]),
    )
end

function read_vertice(row::String)::NamedTuple
    row_split = split(row, r"\s+")
    return (
        idx = parse(Int, row_split[2]),
        gps = coord(parse(Float64, row_split[4]), parse(Float64, row_split[5]))
    )
end

function read_fournisseur(row::String, horizon::Int)::NamedTuple
    row_split = split(row, r"\s+")
    return (
        idx = parse(Int, row_split[2]),
        st_cost = parse(Int, row_split[4]),
        q = [parse(Int, row_split[6 + h]) for h = 1:horizon],
        gps = coord(parse(Float64, row_split[7 + horizon]), parse(Float64, row_split[8 + horizon]))
    )
end

function read_matrix(data::Vector{String}, f::Int)::Matrix{Int}
    dist = zeros(Int, f, f)
    for row in data
        row_split = split(row, r"\s+")
        i = row_split[2]
        j = row_split[3]
        dist[i, j] = row_split[5]
    end
    return dist
end

function read_instance(path::String)::Instance
    data = open(path) do file
        readlines(file)
    end

    params = read_parameters(data[1])
    depot = read_vertice(data[2])
    usine = read_vertice(data[3])
    fournisseurs = [Fournisseur(read_fournisseur(data[3 + f], params.H)) for f = 1:params.F]
    distances = read_matrix(data[3 + params.f + a:3 + params.f + 2^params.f], params.f)

    return Instance(
        Q = params.Q,
        F = params.F,
        H = params.H,
        d = Depot(depot.idx, depot.gps),
        u = Usine(usine.idx, usine.gps),
        f = fournisseurs,
        dist = distances,
    )
end
