"""
    select_top_taxa(se::SummarizedExperiment, assay_name::String; top_n::Int64 = 10, sel_method::Function = mean)

Sorts rows / features by one specific assay and returns the top elements.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the evaluation on.
- `top_n::Int64`: the number of top elements that are returned.
- `sel_method::Function`: statistical measure to perform sorting (`mean` by default).
"""
function select_top_taxa(se::SummarizedExperiment, assay_name::String; top_n::Int64 = 10, sel_method::Function = mean)

    features = se.rowdata
    features[!, Symbol(assay_name)] = [sel_method(row) for row in eachrow(assay(se, assay_name))]

    sort(dropmissing(features, Symbol(assay_name)), Symbol(assay_name), rev = true)[1:top_n, :]

end

"""
    select_top_taxa(se::SummarizedExperiment, assay_names::Vector{String}; top_n::Int64 = 10, sel_method::Function = mean)

Sorts rows / features by multiple assays and returns the top elements.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_names::Vector{String}`: a vector of multiple assay names to base the evaluation on.
- `top_n::Int64`: the number of top elements that are returned.
- `sel_method::Function`: statistical measure to perform sorting (`mean` by default).
"""
function select_top_taxa(se::SummarizedExperiment, assay_names::Vector{String}; top_n::Int64 = 10, sel_method::Function = mean)

    features = se.rowdata

    for ass in assay_names
        
        features[!, Symbol(ass)] = [sel_method(row) for row in eachrow(assay(se, ass))]

    end

    sort(dropmissing(features, Symbol.(assay_names)), Symbol.(assay_names), rev = true)[1:top_n, :]

end