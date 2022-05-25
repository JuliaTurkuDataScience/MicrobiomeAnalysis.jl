# Tutorial 5: Wrangle real data into a SummarizedExperiment

Until now, experiments were either simulated, imported from R or converted from a CommunityProfile. Producing instances of SummarizedExperiment from scratch might appear more challenging, as it requires some data analysis skills to wrangle the raw data into the necessary shape. Also, filtering missing values or setting some thresholds could also come into handy. Here, a few possible approaches are explained.

```@setup re
using MicrobiomeAnalysis
```

## Assays

It is recommended to store experimental results and bioinformatics output into an
Excel workbook or as a group of csv files, which can be easily imported.

```@example re
using XLSX, CSV, DataFrames

first_assay = XLSX.readdata(joinpath(@__DIR__, "assets/RE_assays.xlsx"), "Sheet1", "B2:E11") |> Matrix
second_assay = XLSX.readdata(joinpath(@__DIR__, "assets/RE_assays.xlsx"), "Sheet1", "F2:I11") |> Matrix

replace!(first_assay, "NA" => missing)
replace!(second_assay, "NA" => missing)

assays = OrderedDict{String, AbstractArray}("first_assay" => first_assay,
                                            "second_assay" => second_assay)
```

## Rowdata and Coldata

```@example re
# load rowdata from csv file
row_data = CSV.File(joinpath(@__DIR__, "assets/RE_rowdata.csv")) |> DataFrame

# rename "Column1" to "name"
rename!(row_data, "Column1" => :name)

# sort by feature number so rowdata order matches assay order
row_data[!, :order] = parse.(Int64, replace.(row_data[!, :name], "bin" => ""))
sort!(row_data, :order)
```

The same method can be applied to the coldata. If it is not available or is not relevant for the analysis, it can be substituted with an empty DataFrame containing only the sample names as done below. Then, we gather the components into a SummarizedExperiment.

```@example re
# create empty coldata object
col_data = DataFrame(
    name = ["sample$i" for i in 1:4]
);

# assemble into SummarizedExperiment
se = SummarizedExperiment(assays, row_data, col_data)
```

## filtering 

```@example re
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
```

## Toolkit to manipulate DataFrames

The following commands come with _DataFrames.jl_ (apart from the last one) and can help you prepare the raw files and ass into a SummarizedExperiment.

- rename!
- replace!
- sort!
- select!
- leftjoin!
- copy
```