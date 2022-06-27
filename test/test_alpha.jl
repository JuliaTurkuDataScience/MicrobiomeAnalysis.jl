using MicrobiomeAnalysis
using Microbiome
using Test

@testset "MicrobiomeAnalysis.jl" begin

    se = SummarizedExperiments.exampleobject(40, 20)

    shannon_output = MicrobiomeAnalysis.shannon(se, "foo")
    MicrobiomeAnalysis.shannon!(se, "foo")
    @test shannon_output == coldata(se).shannon

    ginisimpson_output = MicrobiomeAnalysis.ginisimpson(se, "bar")
    MicrobiomeAnalysis.ginisimpson!(se, "bar")
    @test ginisimpson_output == coldata(se).ginisimpson

    @test Microbiome.shannon(assay(se, "foo")[:, 1]) == coldata(se).shannon[1]
    @test Microbiome.ginisimpson(assay(se, "bar")[:, 1]) == coldata(se).ginisimpson[1]

end
