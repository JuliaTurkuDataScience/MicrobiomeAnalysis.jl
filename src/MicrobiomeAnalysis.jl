module MicrobiomeAnalysis

# using SummarizedExperiments: assay, rowdata, coldata
# using MultiAssayExperiments: MultiAssayExperiment
using Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
using FdeSolver: FDEsolver
using Statistics: mean, std
using Microbiome: CommunityProfile, abundances, features, featurenames, samples, metadata, set!, Taxon, MicrobiomeSample, GeneFunction
using DataFrames: rename!, select!, sort, dropmissing
using Random, CSV

import Microbiome: shannon, ginisimpson, shannon!, ginisimpson!, braycurtis, jaccard, hellinger, pcoa, CommunityProfile
import Base: size, log10
import DataFrames: nrow, ncol, transform, transform!, dropmissing
import SummarizedExperiments: SummarizedExperiment

using Reexport
@reexport using SummarizedExperiments, MultiAssayExperiments
@reexport using DataStructures: OrderedDict
@reexport using DataFrames: DataFrame

# alpha.jl
export shannon, ginisimpson, shannon!, ginisimpson!

# beta.jl
export braycurtis, jaccard, hellinger

#wrappers.jl
export LVmodel, size, nrow, ncol

# importers.jl
export import_se_from_csv, import_mae_from_csv

# converters.jl
export SummarizedExperiment, CommunityProfile

# artifacts.jl
export HintikkaXOData, OKeefeDSData

# transform.jl
export transform, transform!, log10, pa, relabund, ztransform, clr

# sorters.jl
export select_top_taxa, dropmissing

include("alpha.jl")
include("beta.jl")
include("wrappers.jl")
include("importers.jl")
include("converters.jl")
include("artifacts.jl")
include("transform.jl")
include("sorters.jl")

using Requires

function __init__()
    @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" include("plotters.jl")
    @require MultivariateStats = "6f286f6a-111f-5878-ab1e-185364afe411" include("fitters.jl")
end

end
