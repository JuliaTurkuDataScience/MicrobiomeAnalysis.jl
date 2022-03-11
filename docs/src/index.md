# API

## Package features
- functions and workflows for the analysis of microbiome data;
- simulation of data through FdeSolver.jl [Benedetti:2022](@cite);
- operations on SummarizedExperiment objects [Morgan:2021](@cite).

## Utility documentation

### α diversity

```@docs
shannon
shannon!
ginisimpson
ginisimpson!
```

### β diversity

```@docs
braycurtis
jaccard
hellinger
pcoa
```

### Modelling and Simulations

```@docs
LVmodel
```

### Visualisation

```@docs
abundance_plot
```
