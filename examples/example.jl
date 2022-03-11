##### DEPENDENCIES #####

using Mia
using SummarizedExperiments
using DataFrames, DataStructures
using Plots, MultivariateStats

##### SIMULATION #####

# evaluate numerical solution
t, Xapp = LVmodel()

##### SUMMARIZED EXPERIMENT #####

# convert transposed time series into Dictionary and store it into assays
assays = OrderedDict{String, AbstractArray}("sim" => Xapp)

# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on genus and species
rowdata = DataFrame(
    name = ["strain$i" for i in 1:20],
    genus = ["g$i" for i in 1:20],
    species = ["s$i" for i in 1:20]
)

# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and sampling site
coldata = DataFrame(
    name = ["t$i" for i in 1:501],
    condition = rand(["lake", "ocean", "river"], 501),
    time = 1:501
)

# create SummarizedExperiment object
se = SummarizedExperiment(assays, rowdata, coldata)

##### ALPHA DIVERSITY #####

# estimate shannon diversity index
shannon_output = shannon(se, "sim")
# estimate ginisimpson diversity index
ginisimpson_output = ginisimpson(se, "sim")
# estimate and store shannon diversity index into se
shannon!(se, "sim")
# estimate and store ginisimpson diversity index into se
ginisimpson!(se, "sim")

##### BETA DIVERSITY

# evaluate braycurtis dissimilarity index
braycurtis_output = braycurtis(se, "sim")
# evaluate jaccard dissimilarity index
jaccard_output = jaccard(se, "sim")
# evaluate hellinger dissimilarity index
hellinger_output = hellinger(se, "sim")

# run pcoa across 4 dimensions with jaccard dissimilarity
pcoa_model = pcoa(se, "sim", dist = jaccard, dim_number = 4)
pcoa_output = predict(pcoa_model)

# prepare colour labels for scatter plot according to sample origin
x_labels = se.coldata.condition
lake = pcoa_output[:, x_labels .== "lake"]
river = pcoa_output[:, x_labels .== "river"]
ocean = pcoa_output[:, x_labels .== "ocean"]

# plot pcoa
p1 = scatter(lake[1, :], lake[2, :], lake[4, :])
scatter!(river[1, :], river[2, :], river[4, :])
scatter!(ocean[1, :], ocean[2, :], ocean[4, :])

##### ABUNDANCE VS TIME PLOT #####

abundance_plot(se, "sim")
