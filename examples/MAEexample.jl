using MicrobiomeAnalysis
using MultiAssayExperiments, SummarizedExperiments
using DataFrames, DataStructures
using Plots, MultivariateStats


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
