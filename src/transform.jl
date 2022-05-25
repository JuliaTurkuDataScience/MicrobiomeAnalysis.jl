"""
    transform(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...)

Applies a transformation to a given assay and returns it as a `Matrix{<:Real}` object.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
- `method::Function`: the transformation to apply. It can entail the following values:
  `log10`, `pa`, `ztransform`, `clr`.
- `kwargs...`: additional parameters specific to some methods.
"""
function transform(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...)

    method(assay(se, assay_name), kwargs...)

end

"""
    transform(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...; output_name::String = "transformed_" * assay_name)

Applies a transformation to a given assay and stores it into `se` as a new assay.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
- `method::Function`: the transformation to apply. It can entail the following values:
  `log10`, `pa`, `ztransform`, `clr`.
- `kwargs...`: additional parameters specific to some methods.
- `output_name::String`: custom name for the newly created assay.
"""
function transform!(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...; output_name::String = "transformed_" * assay_name)

    se.assays[output_name] = method(assay(se, assay_name), kwargs...)

    return se

end

function log10(assay::Matrix, pseudocount::Real = 0)

    assay .+= pseudocount

    return log10.(assay)

end

pa(assay::Matrix, threshold::Real) = map(x -> ifelse(x > threshold, 1, 0), assay)

function relabund(assay::Matrix)

    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(assay))

        tot = sum(col)
        mat[:, idx] = map(x -> x / tot, col)

    end

    return mat

end

function ztransform(assay::Matrix)

    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(assay))

        avg = mean(col)
        stdev = std(col)

        mat[:, idx] = map(x -> (x - avg) / stdev, col)

    end

    return mat

end

function clr(assay::Matrix, pseudocount::Real = 0)

    assay .+= pseudocount

    clog = log.(assay)
    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(clog))

        log_mean = mean(col)

        mat[:, idx] = map(x -> x - log_mean, col)

    end

    return mat

end
