"""
    braycurtis(se::SummarizedExperiment, assay_name::String)

Evaluates the braycurtis dissimilarity index for each sample and rturns it as a matrix.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function braycurtis(se::SummarizedExperiment, assay_name::String)

    pairwise(BrayCurtis(), assay(se, assay_name), dims = 2)

end

"""
    jaccard(se::SummarizedExperiment, assay_name::String)

Evaluates the jaccard dissimilarity index for each sample and rturns it as a matrix.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function jaccard(se::SummarizedExperiment, assay_name::String)

    pairwise(Jaccard(), assay(se, assay_name), dims = 2)

end

"""
    hellinger(se::SummarizedExperiment, assay_name::String)

Evaluates the hellinger dissimilarity index for each sample and rturns it as a matrix.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function hellinger(se::SummarizedExperiment, assay_name::String)

    pairwise(HellingerDist(), assay(se, assay_name), dims = 2)

end

"""
    pcoa(se::SummarizedExperiment, assay_name::String)

Runs a Multidimensional Scaling (MDS) for the selected assay of se and returns a
model that can be executed with `predict(model)`.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
"""
function pcoa(se::SummarizedExperiment, assay_name::String; dist = braycurtis, dim_number = 3)

    return fit(MDS, dist(se, assay_name), maxoutdim = dim_number, distances = true)

end
