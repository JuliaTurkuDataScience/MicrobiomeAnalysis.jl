using Mia
using SummarizedExperiments, Microbiome
using Test

@testset "Mia.jl" begin

    se = exampleobject(40, 20)

    shannon_output = Mia.shannon(se, "foo")
    Mia.shannon!(se, "foo")
    @test shannon_output == coldata(se).shannon

    ginisimpson_output = Mia.ginisimpson(se, "bar")
    Mia.ginisimpson!(se, "bar")
    @test ginisimpson_output == coldata(se).ginisimpson

    @test Microbiome.shannon(assay(se, "foo")[:, 1]) == coldata(se).shannon[1]
    @test Microbiome.ginisimpson(assay(se, "bar")[:, 1]) == coldata(se).ginisimpson[1]

end
