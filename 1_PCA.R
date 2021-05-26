
install.packages("dprep")
install.packages("matrixStats")
library("matrixStats")
setwd("~/Desktop/sas")
# import data
raw.data <- read.csv("sas_read_counts.csv", header = TRUE, sep = ",")

y <- DGEList(counts=raw.data[,2:10], genes=raw.data[, 1])
#keep <- (rowSds(cpm(y)))/rowMeans2(cpm(y)) > .2 & rowSums(cpm(y) > 2) == 9
keep <- rowSums(cpm(y) > 2) == 9
y$coefvar <- (rowSds(cpm(y)))/rowMeans2(cpm(y))
summary(keep)
y <- y[keep, ,keep.lib.sizes=FALSE]


# Perform TMM normalization: thi sis preparation for ftting to the negative binomial model 
y <- calcNormFactors(y, norm.method = "tmm", na.rm = TRUE)
y$cpm <- (cpm(y))
y$log.cpm <- log(y$cpm)
y$zscores <- scale(y$log.cpm, center = TRUE, scale = TRUE)

sas.prcomp <- prcomp(na.omit(y$zscores), center = TRUE, scale = TRUE) 

Stats <- summary(sas.prcomp)
print(Stats)

sas.prcomp

jpeg(filename = "histogram of library sizes after normalization.jpg", width=1600, height=800, res=200)
barplot(y$samples$lib.size*1e-6, xpd = TRUE, axes = TRUE, col = 491, border = 300, xlab = "RNA-seq Libraires", ylab="Reads aligned to exonic sequence (millions)")
dev.off() 


jpeg(filename = "histogram of library sizes prior to normalization.jpg", width=1600, height=800, res=200)
barplot(y$samples$lib.size*1e-6, xpd = TRUE, axes = TRUE, col = 491, border = 300, xlab = "RNA-seq Libraires", ylab="Reads aligned to exonic sequence (millions)")
dev.off() 

