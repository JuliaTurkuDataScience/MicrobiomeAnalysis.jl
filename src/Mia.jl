module Mia

using SummarizedExperiments, DataFrames, DataStructures, Random
import Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
import Microbiome: shannon, ginisimpson
import MultivariateStats: fit, MDS
import FdeSolver: FDEsolver

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

end
