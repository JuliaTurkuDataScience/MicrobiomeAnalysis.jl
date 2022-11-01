module MicrobiomeAnalysis

# using SummarizedExperiments: assay, rowdata, coldata
# using MultiAssayExperiments: MultiAssayExperiment
using Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
using MultivariateStats: fit, MDS
using FdeSolver: FDEsolver
using Plots: plot
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
export braycurtis, jaccard, hellinger, pcoa

#wrappers.jl
export LVmodel, abundance_plot, size, nrow, ncol

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

end
