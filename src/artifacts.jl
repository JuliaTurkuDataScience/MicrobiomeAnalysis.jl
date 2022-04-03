"""
    HintikkaXOData()

Retrieves the HintikkaXO MultiAssayExperiment, consisting of the microbiota,
metabolite and biomarker SummarizedExperiment data, by Hintikka et al.
(2021), https://doi.org/10.3390/ijerph18084049.
"""
function HintikkaXOData()

    ##### MICROBIOTA EXPERIMENT #####

    # read in csv file on microbiota as DataFrame
    counts = CSV.File(joinpath(@__DIR__, "assets/counts.csv")) |> DataFrame
    # store rowdata
    rowdata_microbiota = DataFrame(
        name = counts[:, 1]
    )
    # store coldata
    coldata_microbiota = DataFrame(
        name = names(counts)[2:end]
    )
    # create counts assay
    assay_microbiota = OrderedDict{String, AbstractArray}("counts" => counts[:, 2:end] |> Matrix)

    ##### METABOLITES EXPERIMENT #####

    # read in csv file on metabolites as DataFrame
    nmr = CSV.File(joinpath(@__DIR__, "assets/nmr.csv")) |> DataFrame
    # store rowdata
    rowdata_metabolites = DataFrame(
        name = nmr[:, 1]
    )
    # store coldata
    coldata_metabolites = DataFrame(
        name = names(nmr)[2:end]
    )
    # create nmr assay
    assay_metabolites = OrderedDict{String, AbstractArray}("nmr" => nmr[:, 2:end] |> Matrix)

    ##### BIOMARKERS EXPERIMENT #####

    # read in csv file on biomarkers as DataFrame
    signals = CSV.File(joinpath(@__DIR__, "assets/signals.csv")) |> DataFrame
    # store rowdata
    rowdata_biomarkers = DataFrame(
        name = signals[:, 1]
    )
    # store coldata
    coldata_biomarkers = DataFrame(
        name = names(signals)[2:end]
    )
    # create signals assay
    assay_biomarkers = OrderedDict{String, AbstractArray}("signals" => signals[:, 2:end] |> Matrix)

    ##### EXPERIMENTLIST #####

    # create OrderedDict object to store SummarizedExperiment objects
    expo = OrderedDict{String, SummarizedExperiment}()
    # store first experiment as microbiota
    expo["microbiota"] = SummarizedExperiment(assay_microbiota, rowdata_microbiota, coldata_microbiota)
    # store second experiment as metabolites
    expo["metabolites"] = SummarizedExperiment(assay_metabolites, rowdata_metabolites, coldata_metabolites)
    # store third experiment as biomarkers
    expo["biomarkers"] = SummarizedExperiment(assay_biomarkers, rowdata_biomarkers, coldata_biomarkers)

    ##### SAMPLE DATA #####

    # read in csv file on sample data as DataFrame
    sample_data = CSV.File(joinpath(@__DIR__, "assets/sample_data.csv")) |> DataFrame
    # rename cols to proper names
    rename!(sample_data, Dict(:Sample => "name"))

    ##### SAMPLE MAP ######

    # read in csv file on sample map as DataFrame
    sample_map = CSV.File(joinpath(@__DIR__, "assets/sample_map.csv")) |> DataFrame
    # rename cols to proper names
    rename!(sample_map, Dict(:assay => "experiment"))
    rename!(sample_map, Dict(:primary => "sample"))
    # put cols in proper order
    select!(sample_map, [:sample, :experiment, :colname])

    ##### MULTIASSAY EXPERIMENT #####

    # construct MultiAssayExperiment object
    HintikkaXOData = MultiAssayExperiment(expo, sample_data, sample_map)

    return HintikkaXOData

end


"""
    OKeefeDSData()

Retrieves the OKeefeDS SummarizedExperiment, consisting of the microbiota,
contains microbiome data from a study with African and African American groups
undergoing a two-week diet swap, by O'Keefe et al.
(2015), https://dx.doi.org/10.1038/ncomms7342.
"""
function OKeefeDSData()

    # DS_counts = CSV.File(joinpath(@__DIR__, "assets/DS_counts.csv")) |> DataFrame
    # DS_assays = OrderedDict{String, AbstractArray}("counts" => DS_counts[:, 2:end] |> Matrix)

    # DS_rowdata = CSV.File(joinpath(@__DIR__, "assets/DS_rowdata.csv")) |> DataFrame
    # DS_rowdata[!, :name] = ["strain$i" for i in 1:size(DS_rowdata, 1)]
    # select!(DS_rowdata, vcat("name", names(DS_rowdata)[1:end - 1]))

    # DS_coldata = CSV.File(joinpath(@__DIR__, "assets/DS_coldata.csv")) |> DataFrame
    # DS_coldata[!, :name] = DS_coldata[!, :sample]
    # select!(DS_coldata, vcat("name", names(DS_coldata)[1: end - 1]))

    # SummarizedExperiment(DS_assays, DS_rowdata, DS_coldata)

    import_from_csv(joinpath(@__DIR__, "assets/DS_assays.csv"),
                    joinpath(@__DIR__, "assets/DS_rowdata.csv"),
                    joinpath(@__DIR__, "assets/DS_coldata.csv"))

end

function import_from_csv(assays_file::AbstractString, rowdata_file::AbstractString, coldata_file::AbstractString)

    raw_assays = CSV.File(assays_file) |> DataFrame
    assays = OrderedDict{String, AbstractArray}()
    
    for cur_group in unique(raw_assays[!, :group_name])
        
        assays[cur_group] = filter(:group_name => x -> x == cur_group, raw_assays)[:, 4:end] |> Matrix
    
    end

    row_data = CSV.File(rowdata_file) |> DataFrame
    rename!(row_data, Dict(:Column1 => "name"))
    row_data[!, :name] = map(string, row_data[!, :name])

    col_data = CSV.File(coldata_file) |> DataFrame
    rename!(col_data, Dict(:Column1 => "name"))

    SummarizedExperiment(assays, row_data, col_data)

end
