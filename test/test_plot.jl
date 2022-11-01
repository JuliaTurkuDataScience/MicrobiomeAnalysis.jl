using MicrobiomeAnalysis, Plots
using Test

@testset "MicrobiomeAnalysis.jl" begin

    se = SummarizedExperiments.exampleobject(40, 20)

    coldata(se).time = 1:20

    p = abundance_plot(se, "foo")

    @test @isdefined p

end
