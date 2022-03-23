using MicrobiomeAnalysis
using MultiAssayExperiments, SummarizedExperiments
using DataFrames, DataStructures
using Plots, MultivariateStats

##### SIMULATION #####

# evaluate numerical solution
t, Xapp = LVmodel(60)

# convert transposed time series into Dictionary and store it into assays
assays = OrderedDict{String, AbstractArray}("sim" => Xapp)

# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on genus and species
rowdata = DataFrame(
    name = ["strain$i" for i in 1:size(Xapp, 1)],
    genus = ["g$i" for i in 1:size(Xapp, 1)],
    species = ["s$i" for i in 1:size(Xapp, 1)]
)

# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and sampling site
coldata = DataFrame(
    name = ["t$i" for i in 1:size(Xapp, 2)],
    condition = rand(["lake", "ocean", "river"], size(Xapp, 2)),
    time = t
)

exp["microbiome"] = SummarizedExperiment(assays, rowdata, coldata)
se = SummarizedExperiments.exampleobject(20, 501)











mae = MultiAssayExperiments.exampleobject()
se = experiment(mae, "bar", sampledata = false)
SummarizedExperiments.coldata(experiment(mae, "bar", sampledata = true))
sub1 = multifilter(mae; samples = ["Patient1", "Patient3"])
sub2 = multifilter(mae; experiments = "foo")


exp = DataStructures.OrderedDict{String, SummarizedExperiment}()
exp["foo"] = SummarizedExperiments.exampleobject(100, 2)
exp["bar"] = SummarizedExperiments.exampleobject(50, 5)
sample_data = DataFrame(
     name = ["Aaron", "Michael", "Jayaram", "Sebastien", "John"],
     disease = ["good", "bad", "good", "bad", "very bad"]
)
sample_map = DataFrame(
    sample = ["Aaron", "Michael", "Aaron", "Michael", "Jayaram", "Sebastien", "John"],
    experiment = ["foo", "foo", "bar", "bar", "bar", "bar", "bar"],
    colname = ["Patient1", "Patient2", "Patient1", "Patient2", "Patient3", "Patient4", "Patient5"]
)
out = MultiAssayExperiment(exp, sample_data, sample_map)

experiments(mae)
sampledata(mae)
samplemap(mae)
