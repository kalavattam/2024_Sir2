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

