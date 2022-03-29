library(microbiomeDataSets)

se <- OKeefeDSData()

counts <- assay(se, 1)
coldata <- colData(se)
rowdata <- rowData(se)

write.csv(counts, "DS_counts.csv")
write.csv(rowdata, "DS_rowdata.csv",
          row.names = FALSE)
write.csv(coldata,"DS_coldata.csv",
          row.names = FALSE)
