using MiaTools
using SummarizedExperiments
using Test

@testset "MiaTools.jl" begin

    se = exampleobject(40, 20)

    coldata(se).time = 1:20

    p = abundance_plot(se, "foo")

    @test @isdefined p

end
