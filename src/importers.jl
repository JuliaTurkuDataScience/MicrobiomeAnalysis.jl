function import_se_from_csv(assays_file::AbstractString, rowdata_file::AbstractString, coldata_file::AbstractString)

    raw_assays = CSV.File(assays_file) |> DataFrame

    groups = unique(raw_assays[!, :group_name])
    assays = construct_assays(raw_assays, groups)

    row_data = CSV.File(rowdata_file) |> DataFrame
    rename!(row_data, Dict(:Column1 => "name"))
    row_data[!, :name] = map(string, row_data[!, :name])

    col_data = CSV.File(coldata_file) |> DataFrame
    rename!(col_data, Dict(:Column1 => "name"))

    SummarizedExperiment(assays, row_data, col_data)

end

function import_se_from_csv(assays_file::AbstractString)

    raw_assays = CSV.File(assays_file) |> DataFrame

    groups = unique(raw_assays[!, :group_name])
    assays = construct_assays(raw_assays, groups)

    row_data = DataFrame(
        name = raw_assays[1:Int64(size(raw_assays, 1) / length(groups)), 1]
    )

    col_data = DataFrame(
        name = names(raw_assays)[4:end]
    )

    SummarizedExperiment(assays, row_data, col_data)

end

function import_mae_from_csv(experiment_files::Vector{<:AbstractString}, sample_data_file::AbstractString, sample_map_file::AbstractString; experiment_names::Vector{<:AbstractString} = experiment_files)

    experiment_list = OrderedDict{String, SummarizedExperiment}()
    
    for (cur_exp, cur_exp_name) in zip(experiment_files, experiment_names)
        
        experiment_list[cur_exp_name] = import_se_from_csv(cur_exp)
    
    end

    sample_data = CSV.File(sample_data_file) |> DataFrame
    rename!(sample_data, Dict(:Sample => "name"))

    sample_map = CSV.File(sample_map_file) |> DataFrame
    rename!(sample_map, Dict(:assay => "experiment"))
    rename!(sample_map, Dict(:primary => "sample"))
    select!(sample_map, [:sample, :experiment, :colname])

    MultiAssayExperiment(experiment_list, sample_data, sample_map)

end

# experiment_files = [joinpath(@__DIR__, "assets/XO_microbiota_assays.csv"),
#                     joinpath(@__DIR__, "assets/XO_metabolites_assays.csv"),
#                     joinpath(@__DIR__, "assets/XO_biomarkers_assays.csv")]

# experiment_names = ["microbiota", "metabolites", "biomarkers"]

# mae = import_mae_from_csv(experiment_files,
#     joinpath(@__DIR__, "assets/sample_data.csv"),
#     joinpath(@__DIR__, "assets/sample_map.csv"),
#     experiment_names = experiment_names)

function construct_assays(raw_assays, groups)

    assays = OrderedDict{String, AbstractArray}()

    for cur_group in groups
        
        assays[cur_group] = filter(:group_name => x -> x == cur_group, raw_assays)[:, 4:end] |> Matrix
    
    end

    assays

end