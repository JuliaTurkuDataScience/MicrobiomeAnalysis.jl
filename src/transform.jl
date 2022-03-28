function transform(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...)

    method(assay(se, assay_name), kwargs...)

end

function transform!(se::SummarizedExperiment, assay_name::String, method::Function, kwargs...; output_name::String = "transformed_" * assay_name)

    se.assays[output_name] = method(assay(se, assay_name), kwargs...)

    return se

end

calc_log10(assay::Matrix{<:Real}) = log10.(assay)
calc_pa(assay::Matrix{<:Real}, threshold::Real) = map(x -> ifelse(x > threshold, 1, 0), assay)

function calc_rel_abund(assay::Matrix{<:Real})

    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(assay))

        tot = sum(col)
        mat[:, idx] = map(x -> x / tot, col)

    end

    return mat

end

function calc_ztransform(assay::Matrix{<:Real})

    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(assay))

        avg = mean(col)
        stdev = std(col)

        mat[:, idx] = map(x -> (x - avg) / stdev, col)

    end

    return mat

end

function calc_clr(assay::Matrix{<:Real})

    clog = log.(assay)
    mat = zeros(size(assay))

    for (idx, col) in enumerate(eachcol(clog))

        log_mean = mean(col)

        mat[:, idx] = map(x -> x - log_mean, col)

    end

    return mat

end
