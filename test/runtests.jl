using SafeTestsets

@safetestset "Estimating alpha diversity" begin include("test_alpha.jl") end

# @safetestset "Estimating beta diversity" begin include("test_beta.jl") end
