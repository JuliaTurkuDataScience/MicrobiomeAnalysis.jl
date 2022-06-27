using MicrobiomeAnalysis
using Microbiome
using Test

se = SummarizedExperiments.exampleobject(40, 20)

samps = MicrobiomeSample.([samples for samples in se.coldata.name])
taxa = [Taxon("$taxa", :species) for taxa in se.rowdata.name]
mat = assay(se, "bar")
comm = CommunityProfile(mat, taxa, samps)

@testset "MicrobiomeAnalysis.jl" begin

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

@testset "MicrobiomeAnalysis.jl" begin

    se2 = MicrobiomeAnalysis.SummarizedExperiment(comm)
    comm2 = MicrobiomeAnalysis.CommunityProfile(se2)

    @test @isdefined se2
    @test @isdefined comm2

end
