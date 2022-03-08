push!(LOAD_PATH,"../src/")
using Mia, Documenter

generated_path = joinpath(@__DIR__, "src")
base_url = "https://github.com/JuliaTurkuDataScience/Mia.jl/blob/main/"
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
         sitename = "Mia.jl",
         modules = [Mia],
         pages=[
             "Home" => "readme.md",
             "Manual" => "index.md"
               ])

deploydocs(repo="github.com/JuliaTurkuDataScience/Mia.jl", push_preview=true)
