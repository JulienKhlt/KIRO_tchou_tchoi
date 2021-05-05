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
        gps = Coord(x = parse(Float64, row_split[4]), y = parse(Float64, row_split[5]))
    )
end

function read_fournisseur(row::String, horizon::Int)::Fournisseur
    row_split = split(row, r"\s+")
    return Fournisseur(
        idx = parse(Int, row_split[2]),
        st_cost = parse(Int, row_split[4]),
        q = [parse(Int, row_split[5 + h]) for h = 1:horizon],
        gps = Coord(x = parse(Float64, row_split[7 + horizon]), y = parse(Float64, row_split[8 + horizon])),
    )
end

function read_matrix(data::Vector{String}, n_vertices::Int)::Matrix{Int}
    dist = zeros(Int, n_vertices, n_vertices)
    for row in data
        row_split = split(row, r"\s+")
        i = row_split[2]
        j = row_split[3]
        dist[i, j] = row_split[5]
        println("Distance entre indices $(i) et $(j) : $(dist[i, j])")
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
    fournisseurs = [read_fournisseur(data[3 + f], params.H) for f = 1:params.F]
    distances = read_matrix([data[3 + params.F + idx] for idx = 1:(2^(params.F + 2))], params.F + 2)

    return Instance(
        Q = params.Q,
        F = params.F,
        H = params.H,
        d = Depot(idx = depot.idx, gps = depot.gps),
        u = Usine(idx = usine.idx, gps = usine.gps),
        f = fournisseurs,
        dist = distances,
    )
end
