#!/usr/bin/env Rscript

#  work_plot_circos.R
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

# Create a data frame with the limits for each chromosome
chrom_len <- c_Q %>%
    group_by(chr_A) %>%
    summarise(length = max(stop_A, na.rm = TRUE))

xlim <- data.frame(
    chr = chrom_len$chr_A,
    start = rep(0, nrow(chrom_len)),
    end = chrom_len$length
)

# Print the xlim data frame to check the values
print(xlim)

# Initialize the circos plot with the xlim parameter
circos.initialize(factors = xlim$chr, xlim = xlim[,2:3])

# Extract necessary data
links_data <- c_Q %>% 
    select(chr_A, start_A, stop_A, chr_B, start_B, stop_B, score, color)

# Convert color from string to R color
links_data$color <- sapply(
    strsplit(as.character(links_data$color), ","), 
    function(x) rgb(
        as.numeric(x[1])/255, 
        as.numeric(x[2])/255, 
        as.numeric(x[3])/255)
    )

names(links_data$chr_A) <- links_data$chr_A
names(links_data$chr_B) <- links_data$chr_B

# Plot the links
apply(links_data, 1, function(x) {
    circos.link(
        x['chr_A'], 
        c(as.numeric(x['start_A']), as.numeric(x['stop_A'])), 
        x['chr_B'], 
        c(as.numeric(x['start_B']), as.numeric(x['stop_B'])), 
        col = x['color'])
})


# Add a track for the chromosome names
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")
    circos.text(
        mean(xlim), 
        ylim[2] + (ylim[2] - ylim[1]) / 10, 
        sector.name, 
        facing = "inside", 
        niceFacing = TRUE, 
        adj = c(0.5, 0)
    )
}, bg.border = NA, y = c(0, 1))  # Specify y or ylim here

