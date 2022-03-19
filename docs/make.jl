push!(LOAD_PATH,"../src/")
using MiaTools, Documenter
ENV["GKSwstype"] = "100"

generated_path = joinpath(@__DIR__, "src")
base_url = "https://github.com/JuliaTurkuDataScience/MiaTools.jl/blob/main/"
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
         sitename = "MiaTools.jl",
         modules = [MiaTools],
         pages=[
             "Home" => "readme.md",
             "Manual" => "index.md",
             "Examples" => "examples.md"
               ])

deploydocs(repo="github.com/JuliaTurkuDataScience/MiaTools.jl", push_preview=true)
