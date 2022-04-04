library(microbiomeDataSets)

mae <- HintikkaXOData()

coldata <- colData(mae)

se1 <- mae[["microbiota"]]
se2 <- mae[["metabolites"]]
se3 <- mae[["biomarkers"]]

rowdata1 <- rowData(se1)
rowdata2 <- rowData(se2)
rowdata3 <- rowData(se3)

microbiota_assays <- assays(se1)
metabolites_assays <- assays(se2)
biomarkers_assays <- assays(se3)

write.csv(microbiota_assays, "XO_microbiota_assays.csv")
write.csv(metabolites_assays, "XO_metabolites_assays.csv")
write.csv(biomarkers_assays, "XO_biomarkers_assays.csv")

write.csv(coldata, "sample_data.csv",
          row.names = FALSE)
write.csv(sampleMap(mae),"sample_map.csv",
          row.names = FALSE)
write.csv(assays(se1), "assays_test.csv")
