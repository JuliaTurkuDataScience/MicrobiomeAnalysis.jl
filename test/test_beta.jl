using Mia
using SummarizedExperiments, Distances
using Test

@testset "Mia.jl" begin

    se = exampleobject(40, 20)

    braycurtis_output = Mia.braycurtis(se, "foo")
    jaccard_output = Mia.jaccard(se, "bar")
#    hellinger_output = hellinger(se, "whee")

    pcoa_b = Mia.pcoa(se, "whee")
#    pcoa_j = pcoa(se, "foo")
#    pcoa_h = pcoa(se, "bar")

#    @test @isdefined braycurtis_output
#    @test @isdefined pcoa_h

end

# Mia.jl: Error During Test at /Users/giuliobene3000/Desktop/Projects/JuliaProjects/Mia.jl/test/test_beta.jl:5
#   Got exception outside of a @test
#   MethodError: no method matching pairwise(::Distances.BrayCurtis, ::Array{Float32, 3}, ::Array{Float32, 3}; dims=2)
#   Closest candidates are:
#     pairwise(::Distances.PreMetric, ::Any, ::Any) at ~/.julia/packages/Distances/6E33b/src/generic.jl:340 got unsupported keyword argument "dims"
#     pairwise(::Any, ::Any, ::Any; symmetric, skipmissing) at ~/.julia/packages/StatsBase/pJqvO/src/pairwise.jl:282 got unsupported keyword argument "dims"
#     pairwise(::Distances.PreMetric, ::Any) at ~/.julia/packages/Distances/6E33b/src/generic.jl:347 got unsupported keyword argument "dims"
