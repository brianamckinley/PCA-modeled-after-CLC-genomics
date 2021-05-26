# PCA-modeled-after-CLC-genomics

This R script performs principle componenets analysis employing the same methodology as that used by the PCA application in CLC Genomics Workbench.

The script reads the raw read count data. Next, it creates a DGE object so that TMM normalization factors can be calculated for each sample. It then uses these normalization factors to adjust the cpm normailzed expression data. Next it log normailzes the data to make impose a normal distribution to the dataset. Finally, the expression data is converted into z-scores. That data is used to conducted the PCA.

