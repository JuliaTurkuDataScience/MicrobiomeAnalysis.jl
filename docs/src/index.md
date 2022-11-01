# API

MicrobiomeAnalysis.jl offers the following features

- functions and workflows for the analysis of microbiome data
- real time-series simulation
- ready-to-use example datasets
- easy conversion from and to EcoJulia objects

## α diversity

```@docs
shannon
shannon!
ginisimpson
ginisimpson!
```

## β diversity

```@docs
braycurtis
jaccard
hellinger
pcoa
```

## Modelling and Simulations

```@docs
LVmodel
```

## Assay Transformation

```@docs
transform
transform!
```

## Sorting and Filtering

```@docs
select_top_taxa
dropmissing
```

## Visualisation

```@docs
abundance_plot
composition_heatmap
```

## Importing Datasets

```@docs
HintikkaXOData
OKeefeDSData
import_se_from_csv
import_mae_from_csv
SummarizedExperiment
CommunityProfile
```
