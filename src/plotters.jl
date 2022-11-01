export abundance_plot

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
                   label = labels, legend_position = :outerleft,
                   xaxis = "Time", yaxis = "Abundance")

    return(p)

end