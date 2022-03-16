using SafeTestsets

@safetestset "Estimating alpha diversity" begin include("test_alpha.jl") end

@safetestset "Estimating beta diversity" begin include("test_beta.jl") end

@safetestset "Generating LV model" begin include("test_lv.jl") end

@safetestset "Plotting time series" begin include("test_plot.jl") end
