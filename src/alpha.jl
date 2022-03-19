"""
    shannon(se::SummarizedExperiment, assay_name::String)

Evaluates the shannon diversity index for each sample and returns it as a vector.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function MiaTools.shannon(se::SummarizedExperiment, assay_name::String)

    # create empty vector with length = n° samples
    shannon_vector = zeros(size(assay(se, assay_name))[2])

    # evaluate shannon diversity index for each sample / column
    for sample in 1:size(assay(se, assay_name))[2]

        shannon_vector[sample] = shannon(assay(se, assay_name)[:, sample])

    end

    # output vector with results for each sample
    return shannon_vector

end

"""
    shannon!(se::SummarizedExperiment, assay_name::String)

Evaluates the shannon diversity index for each sample and stores it into `coldata(se)`.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function shannon!(se::SummarizedExperiment, assay_name::String)

    shannon_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        shannon_vector[sample] = shannon(assay(se, assay_name)[:, sample])

    end

    se.coldata[!, :shannon] = shannon_vector
    return se

end

"""
    ginisimpson(se::SummarizedExperiment, assay_name::String)

Evaluates the ginisimpson diversity index for each sample and returns it as a vector.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function MiaTools.ginisimpson(se::SummarizedExperiment, assay_name::String)

    ginisimpson_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        ginisimpson_vector[sample] = ginisimpson(assay(se, assay_name)[:, sample])

    end

    return ginisimpson_vector

end

"""
    ginisimpson!(se::SummarizedExperiment, assay_name::String)

Evaluates the ginisimpson diversity index for each sample and stores it into `coldata(se)`.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function ginisimpson!(se::SummarizedExperiment, assay_name::String)

    ginisimpson_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        ginisimpson_vector[sample] = ginisimpson(assay(se, assay_name)[:, sample])

    end

    se.coldata[!, :ginisimpson] = ginisimpson_vector
    return se

end
