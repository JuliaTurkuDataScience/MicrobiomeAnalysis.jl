using MiaTools
using SummarizedExperiments, FdeSolver
using Test

@testset "MiaTools.jl" begin

    t, Xapp = LVmodel()

    @test @isdefined t
    @test @isdefined Xapp

end
