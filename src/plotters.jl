export abundance_plot, composition_heatmap

"""
    abundance_plot(se::SummarizedExperiment, assay_name::String)

Plots a time series of the abundance for each feature (row) of an assay in
a SummarizedExperiment object. The corresponding should include a column
named 'time' containing an array of sampling times

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the visualisation on.
"""
function abundance_plot(se::SummarizedExperiment, assay_name::String)

    if sum("time" .== names(coldata(se))) == 0

        error("coldata(se) should include a column named 'time' containing an array of sampling times; for example, add it with coldata(se).time = 1:10 if there are 10 samples.")

    end

    if sum(ismissing.(assay(se, assay_name))) != 0

        error("the input assay contains rows with missing values; they should be either removed or replaced with reasonable numerical values")

    end

    labels = reshape(se.rowdata.name, (1, length(se.rowdata.name)))

    p = Plots.plot(se.coldata.time, Number.(assay(se, assay_name))',
        label=labels, legend_position=:outerleft,
        xaxis="Time", yaxis="Abundance")

    return (p)

end

"""
    composition_heatmap(se::SummarizedExperiment, assay_name::String)

Plots an assay in the form of a composition heatmap.

# Arguments
- `se::SummarizedExperiment`: the experiment object of interest.
- `assay_name::String`: the name of the assay to base the visualisation on.
"""
function composition_heatmap(se::SummarizedExperiment, assay_name::String)

    x = se.coldata[!, :name]
    y = se.rowdata[!, :name]
    z = assay(se, assay_name)

    heatmap(x, y, z,
        c = cgrad([:blue, :white, :red, :yellow]),
        xaxis = "Samples", yaxis = "Taxa")

end