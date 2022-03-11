"""
    LVmodel(N::Int64 = 20, tSpan::Vector{<:Real} = [0, 50]; β = 1, h = 0.1, random = false)

Generates a Lotka-Volterra model for N species over the given time span.
The output is a time series of abundance values that can be stored as two separate objects:
`t, Xapp = LVmodel()`

# Arguments
- `N::Int64`: the size of the model community, that is, the number of species in the system.
- `tSpan::Vector{<:Real}`: the time span along which computation is performed.
- `β::Real`: the order of derivation for all the differential equations of the LV model.
- `h::Real`: the step size for correction.
- `random::Bool`: whether the function should return a randomised (`true`) or constant (`false`) model.
"""
function LVmodel(N::Int64 = 20, tSpan::Vector{<:Real} = [0, 50]; β = 1, h = 0.1, random = false)

    # order of derivatives
    β = ones(N) * β

    if random == false

        Random.seed!(1234)

    end

    # initial abundances
    X0 = 2 * rand(N)

    if random == false

        Random.seed!(1234)

    end

    # define system of differential equations
    par = [2, 2 * rand(N), rand(N), 4 * rand(N, N), N]

    # evaluate numerical solution
    t, Xapp = FDEsolver(lv, tSpan, X0, β, par, h = h)

    return t, Xapp'

end

function lv(t, x, par)

    l = par[1] # Hill coefficient
    b = par[2] # growth rates
    k = par[3] # death rates
    K = par[4] # inhibition matrix
    N = par[5] # number of species

    F = zeros(N)

    for i in 1:N

        # inhibition functions
        f = prod(K[i, 1:end .!= i].^l ./ (K[i, 1:end .!= i] .^ l .+ x[1:end .!= i].^l))

        # ode
        F[i] = x[i] .* (b[i] .* f .- k[i] .* x[i])

    end

    return F

end

"""
    abundance_plot(se::SummarizedExperiment, assay_name::String)

Plots a time series of the abundance for each feature (row) of an assay in
a SummarizedExperiment object. The corresponding should include a column
named 'time' containing an array of sampling times

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the visualisation on.
"""
function abundance_plot(se::SummarizedExperiment, assay_name::String)

    if sum("time" .== names(coldata(se))) == 0

        error("coldata(se) should include a column named 'time' containing an array of sampling times; for example, add it with coldata(se).time = 1:10 if there are 10 samples.")

    end

    labels = reshape(se.rowdata.name, (1, length(se.rowdata.name)))

    p = plot(se.coldata.time, assay(se, "foo")',
             label = labels, legend_position = :outerleft,
             xaxis = "Time", yaxis = "Abundance")

    return(p)

end
