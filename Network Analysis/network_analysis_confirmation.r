# Initialize and organize Shanghai Data ----
rm(list = ls())
library(ggplot2)
library(bootnet)
library(R.matlab)

setwd("C:/Users/user/Desktop/brain_stuff/Shangai_MATLABScripts/cn_simulation/figures/Supplementary/ple_confirmation/network_analysis/confirmatory")
simulated <- readMat("simulated.mat")



# Initialize some options / variables ----
labels <-  c("PLE", "MF", "SE", "ACW-0", "LZC")
nboots <- 10000
statistics <- c("strength", "closeness")
figdir <- "C:/Users/user/Desktop/brain_stuff/Shangai_MATLABScripts/cn_simulation/figures/Supplementary/ple_confirmation/network_analysis/confirmatory/plots/"
pinkmat <- simulated$pinkmeasures
whitemat <- simulated$whitemeasures
colnames(pinkmat) <- labels
colnames(whitemat) <- labels

# White EBIC ---

boot <- bootnet(data = whitemat, nBoots = nboots, default = "EBICglasso", type = "nonparametric", labels = labels, 
                        statistics = statistics, threshold = TRUE)
p1 <- plot(boot, statistics = statistics, plot = "area", order = "id", CIstyle = "SE", legend = FALSE, xlim = c(0, 1.5))
ggsave(paste("whiteEBIC", "meas.tiff", sep = "_"), plot = p1, dpi = 400, path = figdir, width = 3.5, height = 3.5)
        
netw = estimateNetwork(data = whitemat, default = "EBICglasso", labels = labels, threshold = TRUE)
tiff(paste(figdir, "whiteEBIC", "net.tiff", sep = "_"), res = 400, units = "in", width = 3.5, height = 3.5)
plot(netw, layout = "circle", title = paste("White Noise"))
dev.off()

# Pink EBIC ---

boot <- bootnet(data = pinkmat, nBoots = nboots, default = "EBICglasso", type = "nonparametric", labels = labels, 
                        statistics = statistics, threshold = TRUE)
p1 <- plot(boot, statistics = statistics, plot = "area", order = "id", CIstyle = "SE", legend = FALSE)
ggsave(paste("pinkEBIC", "meas.tiff", sep = "_"), plot = p1, dpi = 400, path = figdir, width = 3.5, height = 3.5)
        
netw = estimateNetwork(data = pinkmat, default = "EBICglasso", labels = labels, threshold = TRUE)
tiff(paste(figdir, "pinkEBIC", "net.tiff", sep = "_"), res = 400, units = "in", width = 3.5, height = 3.5)
plot(netw, layout = "circle", title = paste("Pink Noise"))
dev.off()

# White pcor ---

boot <- bootnet(data = whitemat, nBoots = nboots, default = "pcor", type = "nonparametric", labels = labels, 
                        statistics = statistics)
p1 <- plot(boot, statistics = statistics, plot = "area", order = "id", CIstyle = "SE", legend = FALSE)
ggsave(paste("whitepcor", "meas.tiff", sep = "_"), plot = p1, dpi = 400, path = figdir, width = 3.5, height = 3.5)
        
netw = estimateNetwork(data = whitemat, default = "pcor", labels = labels)
tiff(paste(figdir, "whitepcor", "net.tiff", sep = "_"), res = 400, units = "in", width = 3.5, height = 3.5)
plot(netw, layout = "circle", title = paste("White Noise"))
dev.off()

# Pink pcor ---

boot <- bootnet(data = pinkmat, nBoots = nboots, default = "pcor", type = "nonparametric", labels = labels, 
                        statistics = statistics)
p1 <- plot(boot, statistics = statistics, plot = "area", order = "id", CIstyle = "SE", legend = FALSE)
ggsave(paste("pinkpcor", "meas.tiff", sep = "_"), plot = p1, dpi = 400, path = figdir, width = 3.5, height = 3.5)
        
netw = estimateNetwork(data = pinkmat, default = "pcor", labels = labels)
tiff(paste(figdir, "pinkpcor", "net.tiff", sep = "_"), res = 400, units = "in", width = 3.5, height = 3.5)
plot(netw, layout = "circle", title = paste("Pink Noise"))
dev.off()