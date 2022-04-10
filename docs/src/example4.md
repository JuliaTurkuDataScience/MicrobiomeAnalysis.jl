# Tutorial 4: Convert between SummarizedExperiment and CommunityProfile

Both SummarizedExperiment (SE) and CommunityProfile (CP) containers efficiently integrate microbiome profile data into one comprehensive object, from which information is easy to retrieve and analyse. The former originates from SummarizedExperiments.jl, whereas the latter belongs to the [EcoJulia framework](https://ecojulia.org/), and the way they internally organise the data is slightly divergent. Nevertheless, interoperability and conversion between them is possible.

```@setup cp
using MicrobiomeAnalysis
using Microbiome, SummarizedExperiments
using DataFrames, DataStructures
```

## From CP to SE

First, a CommunityProfile is created from its building blocks and some metadata about the sampling sites (origin) is added.

```@example cp
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

Next, the CommunityProfile can be reshaped into a SmmarizedExperiment object by redifining its object type, i.e., `SummarizedExperiment(comm::CommunityProfile)`. This method can also be applied to functional profiles, where GeneFunction instances are found in place of Taxon ones.

```@example cp
# convert cp to se
se_converted = SummarizedExperiment(comm)
```

## From SE to CP

A SummarizedExperiment object can also be converted into a CommunityProfile. As an example, we will use the `se` constructed in the [first tutorial](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/example1/), which is redefined through `CommunityProfile(se::SummarizedExperiment)`.

```@example cp
t, Xapp = LVmodel(); # hide
assays = OrderedDict{String, AbstractArray}("sim" => Xapp); # hide
rowdata = DataFrame(name = ["strain$i" for i in 1:20], genus = ["g$i" for i in 1:20], species = ["s$i" for i in 1:20]); # hide
coldata = DataFrame(name = ["t$i" for i in 1:501], condition = rand(["lake", "ocean", "river"], 501), time = 1:501); # hide
se = SummarizedExperiment(assays, rowdata, coldata); # hide
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

## Further applications

BioBakeryUtils.jl implements [MetaPhlAn](http://docs.ecojulia.org/BiobakeryUtils.jl/stable/metaphlan/) and [HUMAnN](http://docs.ecojulia.org/BiobakeryUtils.jl/stable/humann/) ports for the Julia language. Both these workflows return an abundance or gene assay in the form of a CommunityProfile, which can be easily converted into a SummarizedExperiment object. Thus, results from several sources, such as MetaPhlAn and HUMAnN, can be integrated into a single MultiAssayExperiment and analysed in parallel, as explained in [tutorial 2](https://juliaturkudatascience.github.io/MicrobiomeAnalysis.jl/dev/example2/).