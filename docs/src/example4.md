# Tutorial 4: Convert between SummarizedExperiment and CommunityProfile

Both SummarizedExperiment (SE) and CommunityProfile (CP) containers efficiently integrate microbiome profile data into one comprehensive object, from which information is easy to retrieve and analyse. The former originates from SummarizedExperiments.jl, whereas the latter belongs to the [EcoJulia framework](https://ecojulia.org/), and the way they internally organise the data is slightly divergent. Nevertheless, interoperability and conversion between them is possible.

```@setup cp1
using MicrobiomeAnalysis
using Microbiome, SummarizedExperiments
```

## From CP to SE

First, a CommunityProfile is created from its building blocks and some metadata about the sampling sites (origin) is added.

```@example cp1
# generate array with sample data
samps = MicrobiomeSample.(["s$i" for i in 1:10]);

# generate array with feature data
taxa = [[Taxon("s$i", :species) for i in 1:10]; [Taxon("g$i", :genus) for i in 1:10]];

# generate matrix with random entries
mat = rand(20, 10);

# create cp instance
comm = CommunityProfile(mat, taxa, samps)

# add some metadata about origin
for (sample, value) in zip(1:length(samples(comm)), ["origin$i" for i in 1:length(samples(comm))])

    set!(samples(comm)[sample], :origin, value)

end
```

Next, the CommunityProfile can be reshaped into a SmmarizedExperiment object by redifining its object type, i.e., `SummarizedExperiment(comm::CommunityProfile)`.

```@example cp1
# convert cp to se
se_converted = SummarizedExmperiment(comm)
```

## From SE to CP

A SummarizedExperiment object can also be converted into a CommunityProfile. As an example, we will use the `se` constructed in the [first tutorial](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/example1/), which is redefined through `CommunityProfile(se::SummarizedExperiment)`.

```@example se
# view se
se
# convert se to cp
comm_converted = CommunityProfile(se)
```

It is highly recommended for the conversion to succeed that the rowdata of the original SummarizedExperiment object contains columns named by and specifying at least one of the following:

* strain
* subspecies
* species
* genus
* phamily
* order
* class
* phylum
* kingdom

