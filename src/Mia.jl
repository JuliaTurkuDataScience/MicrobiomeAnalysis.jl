module Mia

import SummarizedExperiments: SummarizedExperiment, assay, rowdata, coldata
import Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
import Microbiome: shannon, ginisimpson
import MultivariateStats: fit, MDS
import FdeSolver: FDEsolver
using DataFrames, DataStructures, Random, Plots

include("alpha.jl")
include("beta.jl")
include("wrappers.jl")

export(shannon)
export(ginisimpson)
export(shannon!)
export(ginisimpson!)

export(braycurtis)
export(jaccard)
export(hellinger)
export(pcoa)

export(LVmodel)
export(abundance_plot)

end
