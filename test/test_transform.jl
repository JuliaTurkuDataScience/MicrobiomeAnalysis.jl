using MicrobiomeAnalysis
using Statistics
using Test

@testset "MicrobiomeAnalysis.jl" begin

    se = SummarizedExperiments.exampleobject(40, 20)
    foo_assay = assay(se, "foo")
    bar_assay = assay(se, "bar")

    log10_assay = log10(foo_assay, 1)
    pa_assay = pa(bar_assay, 1)
    relabund_assay = relabund(foo_assay)
    z_assay1 = ztransform(bar_assay)
    clr_assay1 = clr(foo_assay, 1)

    transform!(se, "foo", log10, 1, output_name = "log10_assay")
    transform!(se, "bar", pa, 1, output_name = "pa_assay")
    transform!(se, "foo", relabund, output_name = "relabund_assay")
    z_assay2 = transform(se, "bar", ztransform)
    clr_assay2 = transform(se, "foo", clr, 1)

    # are the rounded means equal to each other up to a tolerance of 1 digit?
    @test round(mean(log10_assay), digits = 1) == round(mean(assay(se, "log10_assay")), digits = 1)
    # is each element in A equal to each element in B?
    @test pa_assay == assay(se, "pa_assay")
    # are the rounded means equal to each other up to a tolerance of 15 digits?
    @test round(mean(relabund_assay), digits = 15) == round(mean(assay(se, "relabund_assay")), digits = 15)
    # is each element in A equal to each element in B?
    @test z_assay1 == z_assay2
    # is the absolute value of the difference between the means less than the tolerance?
    @test abs(mean(clr_assay1) - mean(clr_assay2)) < 10e-16

end
