using Mia
using SummarizedExperiments, FdeSolver
using Test

@testset "Mia.jl" begin

    t, Xapp = LVmodel()

    @test @isdefined t
    @test @isdefined Xapp

end
