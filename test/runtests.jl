using SafeTestsets

@safetestset "Estimating alpha diversity" begin include("test_alpha.jl") end

@safetestset "Estimating beta diversity" begin include("test_beta.jl") end

@safetestset "Generating LV model" begin include("test_lv.jl") end

@safetestset "Plotting time series" begin include("test_plot.jl") end

@safetestset "Transforming assays" begin include("test_transform.jl") end

@safetestset "Importing artifacts" begin include("test_importers.jl") end
