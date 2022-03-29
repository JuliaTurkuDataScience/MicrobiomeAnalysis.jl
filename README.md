# MicrobiomeAnalysis.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/readme/)
[![CI](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/branch/main/graph/badge.svg?token=VHEH1ZQLPA)](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl)

This package provides common methods for microbiome analysis based on the [SummarizedExperiment](https://github.com/LTLA/SummarizedExperiments.jl) and [MultiAssayExperiment](https://github.com/LTLA/MultiAssayExperiment.jl) data containers. This work in Julia language reflects [related developments in R](https://github.com/microbiome/mia/).




## Installation

This package has been registered in the Julia [General Registry](https://github.com/JuliaRegistries/General), so it can be installed as follows:

```julia
Pkg.add("MicrobiomeAnalysis")
using MicrobiomeAnalysis
```

For the latest functionality, you can clone this repo locally and start Julia with:

```bash
git clone git@github.com:JuliaTurkuDataScience/MicrobiomeAnalysis.jl.git
cd McrobiomeAnalysis.jl
julia --project=.
```
and then run this in the Julia REPL:

```julia
using MicrobiomeAnalysis
```

Now you should be able to access and use all exported functions, for instance:

```julia
shannon
> shannon (generic function with 3 methods)
```

## Documentation

- [Function reference manual](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/)
- [Basic microbiome workflow examples](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/example1/)


## Data containers

MicrobiomeAnalysis.jl supports the analysis based on specific data containers:

- [MultiAssayExperiments](https://github.com/LTLA/MultiAssayExperiments.jl)
- [SummarizedExperiments](https://github.com/LTLA/SummarizedExperiments.jl)


## Microbiome data analysis packages

Simulate microbial community dynamics and time series:

- [FdeSolver](https://github.com/JuliaTurkuDataScience/FdeSolver.jl)


Independently developed packages for microbiome analysis provide
additional utilities but require in some cases further integration
with the SE and MAE data containers.

- [BiobakeryUtils](https://github.com/EcoJulia/BiobakeryUtils.jl)
- [EcoBase](https://github.com/EcoJulia/EcoBase.jl)
- [Microbiome](https://github.com/EcoJulia/Microbiome.jl)


## Suggested dependencies

A few optional dependencies are recommended for
MicrobiomeAnalysis.jl to function properly:

- [DataFrames](https://github.com/JuliaData/DataFrames.jl)
- [DataStructures](https://github.com/JuliaCollections/DataStructures.jl)
- [MultivariateStats](https://github.com/JuliaStats/MultivariateStats.jl)
