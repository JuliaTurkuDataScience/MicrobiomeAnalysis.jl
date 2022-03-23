using MicrobiomeAnalysis
using MultiAssayExperiments, SummarizedExperiments
using DataFrames, DataStructures
using Plots, MultivariateStats

##### SIMULATION #####

# evaluate numerical solution
t1, Xapp1 = LVmodel(8, [0, 12], h = 3)
t2, Xapp2 = LVmodel(12, [0, 10], h = 2)

# convert transposed time series into Dictionary and store it into assays
assays1 = OrderedDict{String, AbstractArray}("foo" => Xapp1)
assays2 = OrderedDict{String, AbstractArray}("bar" => Xapp2)

# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on genus and species
rowdata1 = DataFrame(
    name = ["strain$i" for i in 1:size(Xapp1, 1)],
    genus = ["g$i" for i in 1:size(Xapp1, 1)],
    species = ["s$i" for i in 1:size(Xapp1, 1)]
)

rowdata2 = DataFrame(
    name = ["metabolite$i" for i in 1:size(Xapp2, 1)],
    expression = rand(["intracellular", "extracellular"], size(Xapp2, 1)),
    enzyme = ["enzyme$i" for i in 1:size(Xapp2, 1)]
)

# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and sampling site
coldata1 = DataFrame(
    name = ["day$i" for i in 1:size(Xapp1, 2)],
    origin = rand(["lake", "ocean", "river"], size(Xapp1, 2)),
    time = t1
)

coldata2 = DataFrame(
    name = ["month$i" for i in 1:size(Xapp2, 2)],
    wheather = rand(["sunny", "cloudy", "rainy"], size(Xapp2, 2)),
    time = t2
)

expo = OrderedDict{String, SummarizedExperiment}()
expo["microbiome"] = SummarizedExperiment(assays1, rowdata1, coldata1)
expo["metabolome"] = SummarizedExperiment(assays2, rowdata2, coldata2)

sample_data = DataFrame(
     name = ["sample$i" for i in 1:10],
     state = rand(["pure", "polluted", "contaminated", "remediated"], 10)
)

sample_map = DataFrame(
    sample = ["sample$i" for i in 1:10],
    experiment = rand(["microbiome", "metabolome"], 10),
    colname = ["$i$j" for i in ["day", "month"] for j in 1:5]
)

mae = MultiAssayExperiment(expo, sample_data, sample_map)

se = experiment(mae, "microbiome", sampledata = false)
SummarizedExperiments.coldata(experiment(mae, "metabolome", sampledata = true))
sub1 = multifilter(mae, samples = ["sample1", "sample4"])
sub2 = multifilter(mae, experiments = "metabolome")

experiments(mae)
sampledata(mae)
samplemap(mae)
