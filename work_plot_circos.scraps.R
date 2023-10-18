#!/usr/bin/env Rscript

#  work_plot_circos.scraps.R
#  KA

#  Load libraries, set options ------------------------------------------------
library(circlize)
library(tidyverse)


#  Initialize functions -------------------------------------------------------
normalize_score <- function(score, max = 5, min = 1) {
    finite_scores <- score[is.finite(score)]  # Exclude Inf values
    max_score <- max(finite_scores)
    min_score <- min(finite_scores)
    normalized_score <- (score - min_score) / (max_score - min_score) * (max - min) + min
    normalized_score[is.infinite(score)] <- max  # Assign max thickness to Inf values
    return(normalized_score)
}


#  Set work directory ---------------------------------------------------------
if(base::isTRUE(stringr::str_detect(getwd(), "kalavattam"))) {
    p_prj <- "/Users/kalavattam/repos"
} else if(base::isTRUE(stringr::str_detect(getwd(), "/Users/kalavatt"))) {
    p_prj <- "/Users/kalavatt/projects-etc"
} else if(base::isTRUE(stringr::str_detect(getwd(), "/home/kalavatt"))) {
    p_prj <- "/home/kalavatt/tsukiyamalab/Kris"
}
p_exp <- "2023_rDNA/results/2023-0307_work_Micro-C_align-process"
setwd(paste(p_prj, p_exp, sep = "/"))  # getwd()  # list.dirs()


#  Set up and load files ------------------------------------------------------
# f_Q <- "MC-2019_Q_WT_repM.standard-rDNA-complete.mcool"
# f_1 <- "MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool"
# f_2 <- "MC-2020_nz_WT_repM.standard-rDNA-complete.mcool"

p_fh2 <- "13_FitHiC2_genome_KR-filt-0.4_whole-matrix/test_2023-1016_interOnly"
f_Q <- "Q.5000.ds-to-Q.genome-trans.spline_pass1.res5000.significances.filt.bedpe"
c_Q <- readr::read_tsv(
    paste0(p_fh2, "/", f_Q),
    col_names = c(
        "chr_A", "start_A", "stop_A", "chr_B", "start_B", "stop_B", "name",
        "score", "strand_A", "strand_B", "color", "rDNA_assoc"
    ),
    show_col_types = FALSE
)

c_Q$norm_score <- normalize_score(c_Q$score)

suppressMessages(library(circlize))
par(mar = c(1, 1, 1, 1))
circos.initialize(
    plotType = c('axis', 'labels')
    
)
bed1<-SVbedpe[,1:3]
bed2<-SVbedpe[,4:6]
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
colours<-cbbPalette[1:length(unique(SVbedpe$svclass))]
names(colours)<-unique(SVbedpe$svclass)
circos.genomicLink(bed1, bed2,col=colours[SVbedpe$svclass])
legend("topright", legend = names(colours),fill=colours,cex=0.35)