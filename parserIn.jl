using instance

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

function read_instance(path::String)::Instance
    data = open(path) do file
        readlines(file)
    end

    params = read_parameters(data[1])
    depot = read_vertice(data[2])
    usine = read_vertice(data[3])

    return Instance(
        Q = params.Q,
        F = params.F,
        H = params.H,
        depot = depot(depot.idx, depot.gps)
        usine = usine(usine.idx, usine.gps)
    )
end