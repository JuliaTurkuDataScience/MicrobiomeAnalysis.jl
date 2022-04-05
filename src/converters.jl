"""
    SummarizedExperiment(comm::CommunityProfile)

Converts a CommunityProfile to a SummarizedExperiment object.

# Arguments
- `comm::CommunityProfile`: the CommunityProfile to be converted.
"""
function SummarizedExperiment(comm::CommunityProfile)

    counts = abundances(comm)
    assays = OrderedDict{String, AbstractArray}("comm" => counts)

    rowdata = DataFrame(
        name = featurenames(comm)
    )

    taxa = unique([feature.rank for feature in features(comm)])

    for taxon in taxa

        rowdata[!, taxon] = Vector{String}(undef, size(rowdata, 1))

    end

    for (idx, feature) in enumerate(features(comm))

        rowdata[idx, feature.rank] = feature.name

    end 
    
    coldata = DataFrame()
    symlist = [i for i in keys(metadata(comm)[1])]

    for sym in symlist

        coldata[!, sym] = [i[sym] for i in metadata(comm)]

    end

    rename!(coldata, Dict(:sample => "name"))

    # new(assays, rowdata, coldata, Dict{String,Any}())

    SummarizedExperiment(assays, rowdata, coldata)

end

function CommunityProfile(se::SummarizedExperiment)

    samps = MicrobiomeSample.(se.coldata.name)
    taxa = [Taxon(i, :species) for i in se.rowdata.name]
    mat = assay(se, 1)

    CommunityProfile(mat, taxa, samps)

end