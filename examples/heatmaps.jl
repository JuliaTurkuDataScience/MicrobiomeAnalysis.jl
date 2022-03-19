using Plots
# gr()
data = rand(21, 100)
heatmap(1:size(data, 1),
    1:size(data,2), data,
    c = cgrad([:blue, :white, :red, :yellow]),
    xlabel = "x values", ylabel = "y values",
    title = "My title")

sbst = se[:, se.coldata.condition .== "ocean"]
data = assay(sbst, "sim")

heatmap(1:20, 1:size(sbst, 2), assay(sbst, "sim"),
        c = cgrad([:blue, :white, :red, :yellow]),
        xlabel = "x values", ylabel = "y values",
        title = "My title")
