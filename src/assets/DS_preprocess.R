library(microbiomeDataSets)

se <- OKeefeDSData()

assays <- assays(se)
coldata <- colData(se)
rowdata <- rowData(se)

write.csv(counts, "DS_assays.csv")
write.csv(rowdata, "DS_rowdata.csv")
write.csv(coldata,"DS_coldata.csv")
