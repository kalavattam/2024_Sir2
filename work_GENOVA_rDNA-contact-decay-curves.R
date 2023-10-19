#!/usr/bin/env Rscript

#  work_GENOVA_rDNA-contact-decay-curves.R
#  KA

#  Load libraries, set options ------------------------------------------------
library(GENOVA)
library(tidyverse)
library(scales)


#  Initialize functions -------------------------------------------------------
load_cool <- function(
    file, name, color, balance = TRUE, resolution
) {
    cool <- GENOVA::load_contacts(
        signal_path = file,
        sample_name = name,
        colour = color,
        balancing = balance,
        resolution = resolution
    )
    
    return(cool)
}


write_plot <- function(path = p_out, list, resolution = res, w, h) {
    ggplot2::ggsave(
        paste(
            path,
            paste0(deparse(substitute(list)), "_", resolution, ".png"),
            sep = "/"
        ),
        list,
        width = w,
        height = h
    )
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
res <- 200
bal <- TRUE

if(res %in% c(6400, 5000)) {
    p_cool <- "11_cooler_genome_KR-filt-0.2_whole-matrix"
    suf <- "downsample-to-Q"
} else if(res %in% c(200, 50)) {
    p_cool <- "11_cooler_XII_KR-filt-0.4"
    suf <- "downsample-to-G1"
}

f_Q <- paste0(
    p_cool, "/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.",
    res, ".", suf, ".cool"
)  # file.exists(f_Q)
f_1 <- paste0(
    p_cool, "/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.",
    res, ".", suf, ".cool"
)  # file.exists(f_1)
f_2 <- paste0(
    p_cool, "/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.",
    res, ".", suf, ".cool"
)  # file.exists(f_2)

c_Q <- load_cool(
    file = f_Q, name = "Q", color = "#800080",
    balance = bal, resolution = res
)
c_1 <- load_cool(
    file = f_1, name = "G1", color = "#CBC3E3",
    balance = bal, resolution = res
)
c_2 <- load_cool(
    file = f_2, name = "G2-M", color = "#FDDC5C",
    balance = bal, resolution = res
)

#  Identify and plot relative contact probabilities (RCPs) --------------------
#+ ...for rDNA region
if(res %in% c(50, 200)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_RCP_rDNA <- lgl
if(base::isTRUE(run_quant_RCP_rDNA)) {
    bed_rDNA <- data.frame(
        "chromosome" = "XII",
        "start" = 451500,
        "end" = 460800
    )
    
    quant_RCP_rDNA <- GENOVA::RCP(
        list(c_Q, c_1, c_2),
        bedlist = bed_rDNA
    )
    # GENOVA::visualise(quant_RCP_rDNA, metric = "both")
    tmp <- quant_RCP_rDNA$raw
    quant_RCP_rDNA$smooth
    
    
    title <- "cis-interaction frequency probabilities (P)\nstratified by distance (s)"
    subtitle <- paste0("rDNA, resolution of ", res)
    plot_RCP_rDNA <- quant_RCP_rDNA$smooth %>%
        ggplot(aes(x = distance, y = P, color = samplename)) +
        annotation_logticks(sides = "lb", color = "grey92", outside = FALSE) +
        geom_line(linewidth = 1) +
        scale_x_log10(labels = trans_format("log10", math_format(10^.x))) +
        scale_y_log10(labels = trans_format("log10", math_format(10^.x))) +
        scale_color_manual(
            name = "State",
            values = c(
                "Q" = "#00BFC498", 
                "G1" = "#C77CFF98",
                "G2-M" = "#F8766D98"
            )
        ) +
        labs(x = "Genomic distance (s)", y = "P(s)", color = "Sample") +
        ggtitle(title, subtitle = subtitle) +
        theme_minimal() +
        theme(panel.grid.minor = element_blank())
    
    write_plot(list = plot_RCP_rDNA, w = 5, h = 5)
    
    draw_lfc_contrasts <- FALSE
    if(base::isTRUE(draw_lfc_contrasts)) {
        visualise(quant_RCP_rDNA, contrast = 1, metric = "lfc")
        visualise(quant_RCP_rDNA, contrast = 2, metric = "lfc")
        visualise(quant_RCP_rDNA, contrast = 3, metric = "lfc")
        #TODO Lear how to draw these plots with ggplot2
    }
}