# MicrobiomeAnalysis.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/readme/)
[![CI](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/branch/main/graph/badge.svg?token=VHEH1ZQLPA)](https://codecov.io/gh/JuliaTurkuDataScience/MicrobiomeAnalysis.jl)

This package aims to integrate the R-based [SummarizedExperiment](https://github.com/LTLA/SummarizedExperiments.jl) objects with common methods for microbiome analysis, and intends to reflect the [mia project](https://github.com/microbiome/mia/) in the Julia ecosystem.

Microbial community dynamics and time series are simulated through [FdeSolver.jl](https://github.com/JuliaTurkuDataScience/FdeSolver.jl), which is another program previously developed by our group.

## Installation

This package is registered in the [General Registry](https://github.com/JuliaRegistries/General), so it can be installed as follows:

```julia
Pkg.add("MicrobiomeAnalysis")
using MicrobiomeAnalysis
```

To avail of its latest functionality, clone this repository on your local machine with:

git clone git@github.com:microbiome/mia.git
cd Mia.jl
and run the following in Julia:

]activate .
[esc]using Mia
Now you should be able to access and use all exported functions, for instance:

shannon
> shannon (generic function with 3 methods)

## Documentation

Available functions are described in the [Manual page](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/) and used for a basic microbiome workflow in the [Examples page](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/stable/examples/).

## References

MicrobiomeAnalysis.jl enables the analysis of microbial but also more generic data contained by SummarizedExperiment objects, therefore its usage is closely related and applicable to the utilities from several packages:

- [BiobakeryUtils](https://github.com/EcoJulia/BiobakeryUtils.jl)
- [EcoBase](https://github.com/EcoJulia/EcoBase.jl)
- [FdeSolver](https://github.com/JuliaTurkuDataScience/FdeSolver.jl)
- [Microbiome](https://github.com/EcoJulia/Microbiome.jl)
- [MultiAssayExperiments](https://github.com/LTLA/MultiAssayExperiments.jl)
- [SummarizedExperiments](https://github.com/LTLA/SummarizedExperiments.jl)

In addition, a few optional dependencies are recommended for MicrobiomeAnalysis.jl to function properly:

- [DataFrames](https://github.com/JuliaData/DataFrames.jl)
- [DataStructures](https://github.com/JuliaCollections/DataStructures.jl)
- [MultivariateStats](https://github.com/JuliaStats/MultivariateStats.jl)
