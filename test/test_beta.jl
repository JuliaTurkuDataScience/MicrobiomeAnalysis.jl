using MicrobiomeAnalysis
using Microbiome # , SummarizedExperiments
using Test

@testset "MicrobiomeAnalysis.jl" begin

    se = SummarizedExperiments.exampleobject(40, 20)

    samps = MicrobiomeSample.([samples for samples in se.coldata.name])
    taxa = [Taxon("$taxa", :species) for taxa in se.rowdata.name]
    mat = assay(se, "bar")
    comm = CommunityProfile(mat, taxa, samps)

    microjack = Microbiome.jaccard(comm)
    miajack = MicrobiomeAnalysis.jaccard(se, "bar")

    @test microjack == miajack

    microbray = Microbiome.braycurtis(comm)
    miabray = MicrobiomeAnalysis.braycurtis(se, "bar")

    @test microbray == miabray

    microhell = Microbiome.hellinger(comm)
    miahell = MicrobiomeAnalysis.hellinger(se, "bar")

    @test microhell == miahell

end

# MicrobiomeAnalysis.jl: Error During Test at /Users/giuliobene3000/Desktop/Projects/JuliaProjects/MicrobiomeAnalysis.jl/test/test_beta.jl:5
#   Got exception outside of a @test
#   MethodError: no method matching pairwise(::Distances.BrayCurtis, ::Array{Float32, 3}, ::Array{Float32, 3}; dims=2)
#   Closest candidates are:
#     pairwise(::Distances.PreMetric, ::Any, ::Any) at ~/.julia/packages/Distances/6E33b/src/generic.jl:340 got unsupported keyword argument "dims"
#     pairwise(::Any, ::Any, ::Any; symmetric, skipmissing) at ~/.julia/packages/StatsBase/pJqvO/src/pairwise.jl:282 got unsupported keyword argument "dims"
#     pairwise(::Distances.PreMetric, ::Any) at ~/.julia/packages/Distances/6E33b/src/generic.jl:347 got unsupported keyword argument "dims"