module Mia

using FdeSolver, Microbiome, SummarizedExperiments
using DataFrames, DataStructures, Distances, MultivariateStats

include("main.jl")

export

    # alpha diversity
    shannon_se
    ginisimpson_se
    shannon_se!
    ginisimpson_se!

    # beta diversity
    braycurtis_se
    jaccard_se
    hellinger_se
    pcoa_se

end
