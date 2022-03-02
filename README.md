# Mia.jl

This package aims to integrate the R-based [SummarizedExperiment](https://github.com/LTLA/SummarizedExperiments.jl) objects with common methods for microbiome analysis, and intends to reflect the [mia project](https://github.com/microbiome/mia/) in the Julia ecosystem.

Microbial community dynamics and time series are simulated through [FdeSolver.jl](https://github.com/JuliaTurkuDataScience/FdeSolver.jl), which is another program previously developed by our group.

## Temporary installation

To avail of its functionality, clone this repository on your local machine with:

```bash
git clone git@github.com:microbiome/mia.git
cd Mia.jl
```

and run the following in Julia:

```julia
]activate .
[esc]using Mia
```

Now you should be able to access and use all exported functions, for instance:

```julia
shannon
> shannon (generic function with 3 methods)
```

## Temporary documentation

Available functions are described in [main.jl](https://github.com/JuliaTurkuDataScience/Mia.jl/blob/main/src/main.jl) and used for a basic microbiome workflow in [example.jl](https://github.com/JuliaTurkuDataScience/Mia.jl/blob/main/example.jl).
