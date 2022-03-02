module Mia

using FdeSolver, SummarizedExperiments
using DataFrames, DataStructures
import Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
import Microbiome: shannon, ginisimpson
import MultivariateStats: fit, MDS

include("alpha.jl")
include("beta.jl")

export(shannon)
export(ginisimpson)
export(shannon)
export(ginisimpson)

export(braycurtis)
export(jaccard)
export(hellinger)
export(pcoa)

end
