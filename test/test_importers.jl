using CSV, MicrobiomeAnalysis
using Test

base_path = "../src/assets/"

@testset "MicrobiomeAnalysis.jl" begin
    
    se1 = import_se_from_csv(joinpath(base_path, "DS_assays.csv"),
                             joinpath(base_path, "DS_rowdata.csv"),
                             joinpath(base_path, "DS_coldata.csv"))

    se2 = import_se_from_csv(joinpath(base_path, "DS_assays.csv"))

    experiment_files = [joinpath(base_path, "XO_microbiota_assays.csv"),
                        joinpath(base_path, "XO_metabolites_assays.csv"),
                        joinpath(base_path, "XO_biomarkers_assays.csv")]

    experiment_names = ["microbiota", "metabolites", "biomarkers"]

    mae = import_mae_from_csv(experiment_files,
                              joinpath(base_path, "XO_sample_data.csv"),
                              joinpath(base_path, "XO_sample_map.csv"),
                              experiment_names = experiment_names)

    @test @isdefined se1
    @test @isdefined se2
    @test @isdefined mae

end
