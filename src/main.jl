# method of Microbiome.shannon compatible with SummarizedExperiments
# the inputs are the se object and the name of the assay
function shannon_se(se::SummarizedExperiment, assay_name::String)

    # create empty vector with length = n° samples
    shannon_vector = zeros(size(assay(se, assay_name))[2])

    # evaluate shannon diversity index for each sample / column
    for sample in 1:size(assay(se, assay_name))[2]

        shannon_vector[sample] = shannon(assay(se, assay_name)[:, sample])

    end

    # output vector with results for each sample
    return shannon_vector

end

function shannon_se!(se::SummarizedExperiment, assay_name::String)

    shannon_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        shannon_vector[sample] = shannon(assay(se, assay_name)[:, sample])

    end

    se.coldata[!, :shannon] = shannon_vector
    return se

end

function ginisimpson_se(se::SummarizedExperiment, assay_name::String)

    ginisimpson_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        v = assay(se, assay_name)[:, sample]

        total = sum(v)
        relab = map(x -> x / total, v)

        ginisimpson_vector[sample] = 1 - sum([x^2 for x in relab])

    end

    return ginisimpson_vector

end

function ginisimpson_se!(se::SummarizedExperiment, assay_name::String)

    ginisimpson_vector = zeros(size(assay(se, assay_name))[2])

    for sample in 1:size(assay(se, assay_name))[2]

        v = assay(se, assay_name)[:, sample]

        total = sum(v)
        relab = map(x -> x / total, v)

        ginisimpson_vector[sample] = 1 - sum([x^2 for x in relab])

    end

    se.coldata[!, :ginisimpson] = ginisimpson_vector
    return se

end

function braycurtis_se(se::SummarizedExperiment, assay_name::String)

    pairwise(BrayCurtis(), assay(se, assay_name), dims = 2)

end

function jaccard_se(se::SummarizedExperiment, assay_name::String)

    pairwise(Jaccard(), assay(se, assay_name), dims = 2)

end

function hellinger_se(se::SummarizedExperiment, assay_name::String)

    pairwise(HellingerDist(), assay(se, assay_name), dims = 2)

end

function pcoa_se(se::SummarizedExperiment, assay_name::String, dist = braycurtis_se, dim_number = 3)

    return fit(MDS, dist(se, assay_name), maxoutdim = dim_number, distances = true)

end
