module MicrobiomeAnalysis

using SummarizedExperiments: SummarizedExperiment, assay, rowdata, coldata
using MultiAssayExperiments: MultiAssayExperiment
using Distances: pairwise, BrayCurtis, HellingerDist, Jaccard
using MultivariateStats: fit, MDS
using FdeSolver: FDEsolver
using DataStructures, Random, Plots
using CSV
using Statistics: mean, std

import Microbiome: shannon, ginisimpson, shannon!, ginisimpson!, braycurtis, jaccard, hellinger, pcoa
import Base: size
import DataFrames: nrow, ncol, rename!, select!, transform, transform!, DataFrame

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

<<<<<<< HEAD
include("artifacts.jl")
export(HintikkaXOData)
=======
include("transform.jl")
export(transform)
export(transform!)
>>>>>>> origin/main

end
