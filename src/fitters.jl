export pcoa

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