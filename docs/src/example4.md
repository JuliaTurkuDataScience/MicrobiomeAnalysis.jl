# Tutorial 4: Convert between SummarizedExperiment and CommunityProfile

Both SummarizedExperiment (SE) and CommunityProfile (CP) containers efficiently integrate microbiome profile data into one comprehensive object, from which information is easy to retrieve and analyse. The former originates from SummarizedExperiments.jl, whereas the latter belongs to the [EcoJulia framework](https://ecojulia.org/), and the way they internally organise the data is slightly divergent. Nevertheless, interoperability and conversion between them is possible.

```@setup cp1
using MicrobiomeAnalysis
using Microbiome, SummarizedExperiments
```

## From CP to SE

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

```@example cp1
# convert cp to se
se_converted = SummarizedExmperiment(comm)
```
## From SE to CP

```@example se
# view se
se
# convert se to cp
comm_converted = CommunityProfile(se)
```

