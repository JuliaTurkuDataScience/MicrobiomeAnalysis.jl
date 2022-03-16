module Mia

import SummarizedExperiments: SummarizedExperiment, assay, rowdata, coldata
import Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
import Microbiome: shannon, ginisimpson
import MultivariateStats: fit, MDS
import FdeSolver: FDEsolver
import Base: size
import DataFrames: nrow, ncol, DataFrame
using DataStructures, Random, Plots

include("alpha.jl")
export(shannon)
export(ginisimpson)
export(shannon!)
export(ginisimpson!)

include("beta.jl")
export(braycurtis)
export(jaccard)
export(hellinger)
export(pcoa)

include("wrappers.jl")
export(LVmodel)
export(abundance_plot)
export(size)
export(nrow)
export(ncol)

end
