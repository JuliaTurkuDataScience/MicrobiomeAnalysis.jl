# MicrobiomeAnalysis.jl

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/readme/)
[![CI](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/branch/main/graph/badge.svg?token=VHEH1ZQLPA)](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl)
[![Downloads](https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Ftotal_downloads%2FMicrobiomeAnalysis&query=total_requests&label=Downloads)](https://juliapkgstats.com/pkg/MicrobiomeAnalysis)

This package provides common methods for microbiome analysis based on the [SummarizedExperiment](https://ltla.github.io/SummarizedExperiments.jl/dev/) and [MultiAssayExperiment](https://ltla.github.io/MultiAssayExperiments.jl/dev/) data containers. This work in Julia language reflects [related developments in R](https://github.com/microbiome/mia/) and has its own presentation at [JuliaCon 2022](https://www.youtube.com/watch?v=3PYFqwEQAb8&t=158s).


## Installation

This package has been registered in the Julia [General Registry](https://github.com/JuliaRegistries/General), so it can be installed as follows:

```julia
using Pkg
Pkg.add("MicrobiomeAnalysis")
using MicrobiomeAnalysis
```

For the latest functionality, you can clone this repo locally and start Julia with:

```bash
git clone git@github.com:JuliaTurkuDataScience/MicrobiomeAnalysis.jl.git
cd MicrobiomeAnalysis.jl
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

- [Function reference manual](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/)
- [Basic microbiome workflow examples](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/example1/)


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
