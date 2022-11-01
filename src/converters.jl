"""
    SummarizedExperiment(comm::CommunityProfile)

Converts a CommunityProfile to a SummarizedExperiment object.

# Arguments
- `comm::CommunityProfile`: the CommunityProfile to be converted.
"""
function SummarizedExperiment(comm::CommunityProfile)

    counts = abundances(comm)
    assays = OrderedDict{String,AbstractArray}("comm" => counts)

    rowdata = convert_rowdata(comm)

    coldata = DataFrame()
    symlist = [i for i in keys(metadata(comm)[1])]

    for sym in symlist

        coldata[!, sym] = [i[sym] for i in metadata(comm)]

    end

    rename!(coldata, Dict(:sample => "name"))

    # new(assays, rowdata, coldata, Dict{String,Any}())

    SummarizedExperiment(assays, rowdata, coldata)

end

"""
    CommunityProfile(se::SummarizedExperiment)

Converts a SummarizedExperiment object to a CommunityProfile.

# Arguments
- `se::SummarizedExperiment`: the SummarizedExperiment object to be converted.
"""
function CommunityProfile(se::SummarizedExperiment)

    samps = MicrobiomeSample.(se.coldata.name)

    taxa = Vector{Taxon}(undef, size(se.rowdata, 1))
    tax_ranks = ["strain", "subspecies", "species", "genus", "phamily", "order", "class", "phylum", "kingdom"]

    for (idx, row) in enumerate(eachrow(se.rowdata))

        not_missing_taxa = names(row)[collect(.~ismissing.(values(row)))]

        for taxon in tax_ranks

            if sum(taxon .== not_missing_taxa) > 0

                taxa[idx] = Taxon(row[Symbol(taxon)], Symbol(taxon))

            end

        end

    end

    mat = assay(se, 1)

    comm = CommunityProfile(mat, taxa, samps)

    for key in Symbol.(names(se.coldata)[2:end])

        for (idx, row) in enumerate(eachrow(se.coldata))

            set!(samples(comm)[idx], key, row[key])

        end

    end

    comm

end

function convert_rowdata(comm::CommunityProfile{<:Real,Taxon,MicrobiomeSample})

    rowdata = DataFrame(
        name=featurenames(comm)
    )

    taxa = unique([feature.rank for feature in features(comm)])

    for taxon in taxa

        rowdata[!, taxon] = Vector{Union{Missing,String}}(missing, size(rowdata, 1))

    end

    for (idx, feature) in enumerate(features(comm))

        rowdata[idx, feature.rank] = feature.name

    end

    rowdata

end

function convert_rowdata(comm::CommunityProfile{<:Real,GeneFunction,MicrobiomeSample})

    rowdata = DataFrame(
        name=featurenames(comm)
    )

    taxa = unique([feature.taxon.rank for feature in features(comm)])

    for taxon in taxa

        rowdata[!, taxon] = Vector{Union{Missing,String}}(missing, size(rowdata, 1))

    end

    for (idx, feature) in enumerate(features(comm))

        rowdata[idx, feature.taxon.rank] = feature.taxon.name

    end

    rowdata

end
