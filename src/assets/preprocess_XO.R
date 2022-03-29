library(microbiomeDataSets)

mae <- HintikkaXOData()

coldata <- colData(mae)

se1 <- mae[["microbiota"]]
se2 <- mae[["metabolites"]]
se3 <- mae[["biomarkers"]]

rowdata1 <- rowData(se1)
rowdata2 <- rowData(se2)
rowdata3 <- rowData(se3)

counts <- assay(se1, 1)
nmr <- assay(se2, 1)
signals <- assay(se3, 1)

write.csv(counts, "counts.csv")
write.csv(nmr, "nmr.csv")
write.csv(signals, "signals.csv")

write.csv(coldata, "sample_data.csv",
          row.names = FALSE)
write.csv(sampleMap(mae),"sample_map.csv",
          row.names = FALSE)
