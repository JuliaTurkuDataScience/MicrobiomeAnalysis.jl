using MicrobiomeAnalysis
using SummarizedExperiments, FdeSolver
using Test

@testset "MicrobiomeAnalysis.jl" begin

    t, Xapp = LVmodel()

    @test @isdefined t
    @test @isdefined Xapp

end
