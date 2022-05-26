push!(LOAD_PATH,"../src/")
using MicrobiomeAnalysis, Documenter
ENV["GKSwstype"] = "100"

generated_path = joinpath(@__DIR__, "src")
base_url = "https://github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl/blob/main/"
isdir(generated_path) || mkdir(generated_path)

open(joinpath(generated_path, "readme.md"), "w") do io
    # Point to source readme file
    println(
        io,
        """
        ```@meta
        EditURL = "$(base_url)README.md"
        ```
        """,
    )
    # Write the contents out below the meta block
    for line in eachline(joinpath(dirname(@__DIR__), "README.md"))
        println(io, line)
    end
end

makedocs(format = Documenter.HTML(),
         authors = "Giulio Benedetti, Leo Lahti",
         sitename = "MicrobiomeAnalysis.jl",
         modules = [MicrobiomeAnalysis],
         pages=[
             "Home" => "readme.md",
             "Manual" => "index.md",
             "Tutorial" => Any[
                "SE construction and analysis" => "example1.md",
                "MAE construction and manipulation" => "example2.md",
                "SE and MAE retrieval" => "example3.md",
                "CommunityProfile conversion" => "example4.md",
                "Methods for real data" => "example5.md"
                ]
         ])

deploydocs(repo="github.com/JuliaTurkuDataScience/MicrobiomeAnalysis.jl", push_preview=true)
