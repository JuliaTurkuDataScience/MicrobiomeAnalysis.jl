# Tutorial 3: analyse a multiassay experiment from a pre-installed dataset

It is also possible to get started with a ready-made experiment and try to perform analysis on it. The following studies come pre-installed together with this package:

- [HintikkaXOData](https://www.mdpi.com/1660-4601/18/8/4049)

```@setup mae2
using MicrobiomeAnalysis
using MultiAssayExperiments, SummarizedExperiments
using Plots, MultivariateStats
```

## Retrieval

In order to retrieve a specific experiment, a function with the same name is called. This returns the experiment itself, which can be stored into a variable and investigated further.

```@example mae2
mae = HintikkaXOData()
```
