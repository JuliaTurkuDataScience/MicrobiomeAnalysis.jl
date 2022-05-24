using XLSX, CSV, DataFrames

row_data = CSV.File(joinpath(@__DIR__, "RE_rowdata.csv")) |> DataFrame
rename!(row_data, "Column1" => :name)

row_data[!, :order] = parse.(Int64, replace.(row_data[!, :name], "bin" => ""))
sort!(row_data, :order)

col_data = DataFrame(
    name = ["sample$i" for i in 1:4]
)

first_assay = XLSX.readdata(joinpath(@__DIR__, "RE_assays.xlsx"), "Sheet1", "B2:E11") |> Matrix
second_assay = XLSX.readdata(joinpath(@__DIR__, "RE_assays.xlsx"), "Sheet1", "F2:I11") |> Matrix

replace!(first_assay, "NA" => missing)
replace!(second_assay, "NA" => missing)

assays = OrderedDict{String, AbstractArray}("first_assay" => first_assay,
                                            "second_assay" => second_assay)

se = SummarizedExperiment(assays, row_data, col_data)

# drop rows with missing values in some assay
se2 = dropmissing(se, "second_assay")

# filter features that have a peak abundance of at least 10000 reads
keep_rows = map(x -> maximum(x) >= 10000, eachrow(assay(se2, "first_assay")))
se2 = se2[keep_rows, :]

# filter features by that are native to the sampling site
keep_rows = map(x -> x == "true", rowdata(se2)[!, :native])
se2 = se2[keep_rows, :]

# filter samples that contain mpre than 15000 reads
keep_cols = map(x -> sum(x) > 15000, eachcol(assay(se2, "second_assay")))
se2 = se2[:, keep_cols]