# Tutorial

This example walks you through the microdiversity analysis of a time series that simulates a Lotka-Volterra community with 20 strains and 500 time points.

```@setup mia
using MicrobiomeAnalysis, SummarizedExperiments
using DataFrames, DataStructures
using Plots, MultivariateStats
```

## Simulation

Real as well as simulated OTU tables or time series can be stored in a SummarizedExperiment object. In this example, a time series is generated with the function `LVmodel`, which runs a Lotka-Volterra model by means of [FdeSolver.jl](https://github.com/JuliaTurkuDataScience/FdeSolver.jl). To achieve more control over the simulation, it is possible to produce custom models by directly using the `FDEsolver` function from the aforementioned package (see a few [examples](https://juliaturkudatascience.github.io/FdeSolver.jl/stable/examples/)).

```@example mia
# evaluate numerical solution
t, Xapp = LVmodel();
nothing # hide
```

## Summarized Experiment

Next, the assay produced through `LVmodel` is combined with the meta data on samples or time steps (`coldata`) and that on features or species (`rowdata`) into a SummarizedExperiment object.

```@example mia
# convert transposed time series into Dictionary and store it into assays
assays = OrderedDict{String, AbstractArray}("sim" => Xapp);

# produce feature data including feature name (because it's required by the
# SummarizedExperiment function) and information on genus and species
rowdata = DataFrame(
    name = ["strain$i" for i in 1:20],
    genus = ["g$i" for i in 1:20],
    species = ["s$i" for i in 1:20]
);

# produce sample data including sample name (because it's required by the
# SummarizedExperiment function) and sampling site
coldata = DataFrame(
    name = ["t$i" for i in 1:501],
    condition = rand(["lake", "ocean", "river"], 501),
    time = 1:501
);

# create SummarizedExperiment object
se = SummarizedExperiment(assays, rowdata, coldata);
nothing # hide
```

## α diversity

Alpha diversity is then estimated with two different metrics (shannon and ginisimpson indices).

```@example mia
# estimate shannon diversity index
shannon_output = shannon(se, "sim");
# estimate ginisimpson diversity index
ginisimpson_output = ginisimpson(se, "sim");
# estimate and store shannon diversity index into se
shannon!(se, "sim");
# estimate and store ginisimpson diversity index into se
ginisimpson!(se, "sim");
nothing # hide
```

## β diversity

Finally, a few dissimilarity metrics for beta diversity are evaluated and the Jaccard index is used to run a Principal Coordinate Analysis across 4 dimensions, which is then visualised on a scatter plot.

```@example mia
# evaluate braycurtis dissimilarity index
braycurtis_output = braycurtis(se, "sim");
# evaluate jaccard dissimilarity index
jaccard_output = jaccard(se, "sim");
# evaluate hellinger dissimilarity index
hellinger_output = hellinger(se, "sim");

# run pcoa across 4 dimensions with jaccard dissimilarity
pcoa_model = pcoa(se, "sim", dist = jaccard, dim_number = 4);
pcoa_output = predict(pcoa_model);

# prepare colour labels for scatter plot according to sample origin
x_labels = se.coldata.condition;
lake = pcoa_output[:, x_labels .== "lake"];
river = pcoa_output[:, x_labels .== "river"];
ocean = pcoa_output[:, x_labels .== "ocean"];

# plot pcoa
p1 = scatter(lake[1, :], lake[2, :], lake[4, :]);
scatter!(river[1, :], river[2, :], river[4, :]);
scatter!(ocean[1, :], ocean[2, :], ocean[4, :]);
savefig("plot1.png"); nothing # hide
```

![plot1](plot1.png)

## Abundance vs time plot

Below is a possible method to plot the abundance of each strain throughout the time series.

```@example mia
p2 = abundance_plot(se, "sim")
savefig("plot2.png"); nothing # hide
```

![plot2](plot2.png)
