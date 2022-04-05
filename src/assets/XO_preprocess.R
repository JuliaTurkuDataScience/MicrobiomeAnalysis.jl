library(microbiomeDataSets)

mae <- HintikkaXOData()

se1 <- mae[["microbiota"]]
se2 <- mae[["metabolites"]]
se3 <- mae[["biomarkers"]]

microbiota_assays <- assays(se1)
metabolites_assays <- assays(se2)
biomarkers_assays <- assays(se3)

write.csv(microbiota_assays, "XO_microbiota_assays.csv")
write.csv(metabolites_assays, "XO_metabolites_assays.csv")
write.csv(biomarkers_assays, "XO_biomarkers_assays.csv")

write.csv(colData(mae), "sample_data.csv")
write.csv(sampleMap(mae),"XO_sample_map.csv",
          row.names = FALSE)
