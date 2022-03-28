# Tutorial 2: construct and manipulate a multiassay experiment from some simulated time series

MultiAssayExperiment objects aim to encapsulate and a variety of aspects on the same experimental subject in order to allow cross-investigation at multiple levels. For instance, information on the microbiome, metabolome and biomarkers could be summarised through three separate SummarizedExperiment objects, which are then incorporated in one overall MultiAssayExperiment object.

```@setup mae1
using MicrobiomeAnalysis
using MultiAssayExperiments, SummarizedExperiments
using DataFrames, DataStructures
```

## Simulation

Two time series are generated that simulate an 8-by-5 and a 12-by-6 assays and are meant to represent the microbiome and metabolome data, respectively.

```@example mae1
# evaluate numerical solution for experiment 1
t1, Xapp1 = LVmodel(8, [0, 12], h = 3);
# evaluate numerical solution for experiment 2
t2, Xapp2 = LVmodel(12, [0, 10], h = 2);
nothing # hide
```

## Summarized experiments

Made-up information on microbiome taxonomy and sampling site as well as metabolome functionality and sampling wheather are introduced in the corresponding dataframe on features (rowdata) and samples (coldata).

```@example mae1
# convert transposed time series into Dictionary and store it into assays
assays1 = OrderedDict{String, AbstractArray}("foo" => Xapp1);
assays2 = OrderedDict{String, AbstractArray}("bar" => Xapp2);

# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on genus and species
rowdata1 = DataFrame(
    name = ["strain$i" for i in 1:size(Xapp1, 1)],
    genus = ["g$i" for i in 1:size(Xapp1, 1)],
    species = ["s$i" for i in 1:size(Xapp1, 1)]
);
# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on expression and enzyme
rowdata2 = DataFrame(
    name = ["metabolite$i" for i in 1:size(Xapp2, 1)],
    expression = rand(["intracellular", "extracellular"], size(Xapp2, 1)),
    enzyme = ["enzyme$i" for i in 1:size(Xapp2, 1)]
);

# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and sampling site
coldata1 = DataFrame(
    name = ["day$i" for i in 1:size(Xapp1, 2)],
    origin = rand(["lake", "ocean", "river"], size(Xapp1, 2)),
    time = t1
);
# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and wheather conditions
coldata2 = DataFrame(
    name = ["month$i" for i in 1:size(Xapp2, 2)],
    wheather = rand(["sunny", "cloudy", "rainy"], size(Xapp2, 2)),
    time = t2
);
nothing # hide
```

## Multiassay experiment

The two assays are then assembled with their respective meta data. In addition, the sample data and the sample map are created and used to make the final MultiAssayExperiment object. The former element provides absolute results or some other kind of overall knowledge concerning all samples from all experiments, whereas the latter systematically maps the sample data to every column of the various experiments.

```@example mae1
# create a dictionary of multiple experiments
expo = OrderedDict{String, SummarizedExperiment}();
expo["microbiome"] = SummarizedExperiment(assays1, rowdata1, coldata1);
expo["metabolome"] = SummarizedExperiment(assays2, rowdata2, coldata2);

# define general sample data that is not inherently present in experiment columns
sample_data = DataFrame(
     name = ["sample$i" for i in 1:6],
     state = rand(["pure", "polluted", "contaminated", "remediated"], 6)
);

# define mapping between samples and experiment columns
sample_map = DataFrame(
    sample = ["sample1", "sample3", "sample3", "sample3", "sample6", "sample5", "sample2", "sample1", "sample4", "sample4", "sample2"],
    experiment = ["microbiome", "metabolome", "microbiome", "microbiome", "metabolome", "metabolome", "microbiome", "metabolome", "metabolome", "microbiome", "metabolome"],
    colname = ["day1", "month3", "day5", "day3", "month6", "month5", "day2", "month1", "month4", "day4", "month2"]
);

# assemble ingredients into a MultiAssayExperiment object
mae = MultiAssayExperiment(expo, sample_data, sample_map)
```

## Object manipulation

The resulting mae can be finely retrieved for specific experiments, subsetted by features, samples and assays as well as melted into its building components.

```@example mae1
# extract microbiome experiment from mae, without sample data
se1 = experiment(mae, "microbiome", sampledata = false);
# extract metabolome experiment from mae, with sample data
se2 = experiment(mae, "metabolome", sampledata = true);

# take a 3-sample subset of mae, keeping all experiments
sample_subset = multifilter(mae, samples = ["sample1", "sample3", "sample3"]);
# take a 1-experiment subset of mae, keeping all samples
exp_subset = multifilter(mae, experiments = "metabolome");
# take a 3-sample 1-experiment subset of mae
sample_exp_subset = multifilter(mae, experiments = "metabolome", samples = ["sample1", "sample3", "sample3"]);

# extract experiments object
experiments(mae);
# extract sample data object
sampledata(mae);
# extract sample map object
samplemap(mae);
nothing # hide
```
