#!/usr/bin/env Rscript

#  plot_contact-decay_curve-slope.R
#  KA

#  Load libraries, set options ------------------------------------------------
library(tidyverse)
library(scales)


#  Initialize functions -------------------------------------------------------
read_contact_decay_table <- function(file) {
    tbl <- readr::read_tsv(
        file,
        show_col_types = FALSE,
        col_names = c(
            "ind", "phase", "chr", "dist", "cont", "no_bins", "s_fact"
        )
    ) %>%
        dplyr::slice(-1) %>%
        dplyr::select(-c(ind, chr))
    
    return(tbl)
}


prepare_data <- function(tbl) {
    obj <- list()
    obj$x <- as.numeric(tbl[["dist"]])
    obj$y <- as.numeric(tbl[["cont"]])
    obj$d <- diff(obj$y) / diff(obj$x)
    obj$dl <- diff(log10(obj$y)) / diff(log10(obj$x))
    obj$xl <- log10(obj$x)[-1]
    
    return(obj)    
}


read_and_prepare_data <- function(file) {
    data <- read_contact_decay_table(file)
    prepare_data(data)
}


plot_contact_decay <- function(x, y, z) {
    plot(x, y, type = "l", bty = "n", main = z)
}


plot_contact_decay_slope <- function(x, y, z, a) {
    plot(x[1:a], y[1:a], type = "l", bty = "n", main = z)
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


#  Initialize variables, data objects -----------------------------------------
p_txt <- "pngs/2023-1020_use_XII-451400-460800"
f_Q <- "contact-decay_XII-451400-460800.Q.txt"
f_1 <- "contact-decay_XII-451400-460800.G1.txt"
f_2 <- "contact-decay_XII-451400-460800.G2-M.txt"

c_Q <- read_contact_decay_table(paste(p_txt, f_Q, sep = "/")) # %>%
    # slice(-1)
    # slice(-c(1:2))
c_1 <- read_contact_decay_table(paste(p_txt, f_1, sep = "/")) # %>%
    # slice(-1)
    # slice(-c(1:2))
c_2 <- read_contact_decay_table(paste(p_txt, f_2, sep = "/")) # %>%
    # slice(-1)
    # slice(-c(1:2))

#  Combine the data frames with an additional column to indicate the phase
c_all <- dplyr::bind_rows(
    dplyr::mutate(c_Q, phase = "Q"),
    dplyr::mutate(c_1, phase = "G1"),
    dplyr::mutate(c_2, phase = "G2-M")
) %>%
    dplyr::mutate(phase = factor(phase, levels = c("Q", "G1", "G2-M")))


#  Plot contact decay curves --------------------------------------------------
cd_Q <- read_and_prepare_data(paste(p_txt, f_Q, sep = "/"))
cd_1 <- read_and_prepare_data(paste(p_txt, f_1, sep = "/"))
cd_2 <- read_and_prepare_data(paste(p_txt, f_2, sep = "/"))

draw_test_plots <- FALSE
if(base::isTRUE(draw_test_plots)) {
    plot_contact_decay(log10(cd_Q$x), log10(cd_Q$y), "Q")
    plot_contact_decay(log10(cd_1$x), log10(cd_1$y), "G1")
    plot_contact_decay(log10(cd_2$x), log10(cd_2$y), "G2-M")
    
    plot_contact_decay(cd_Q$x, log10(cd_Q$y), "Q")
    plot_contact_decay(cd_1$x, log10(cd_1$y), "G1")
    plot_contact_decay(cd_2$x, log10(cd_2$y), "G2-M")
}

draw_test_plots <- FALSE
if(base::isTRUE(draw_test_plots)) {
    plot_contact_decay_slope(cd_Q$xl, cd_Q$dl, "Q", (length(cd_2$xl) * 0.15))
    plot_contact_decay_slope(cd_1$xl, cd_1$dl, "G1", (length(cd_2$xl) * 0.15))
    plot_contact_decay_slope(cd_2$xl, cd_2$dl, "G2-M", (length(cd_2$xl) * 0.15))
    
    plot_contact_decay_slope(cd_Q$xl, cd_Q$dl, "Q", (length(cd_2$xl) * 0.15))
    plot_contact_decay_slope(cd_1$xl, cd_1$dl, "G1", (length(cd_2$xl) * 0.15))
    plot_contact_decay_slope(cd_2$xl, cd_2$dl, "G2-M", (length(cd_2$xl) * 0.15))
}

#  Calculate the coefficients of lines of best fit (i.e., the power-law
#+ relationships)
range_end <- 3.3
coefficients <- c_all %>%
    dplyr::filter(log10(as.numeric(dist)) <= range_end, as.numeric(dist) > 0) %>%  # Exclude zeroes in dist
    dplyr::group_by(phase) %>%
    dplyr::summarize(
        intercept = coef(lm(log10(as.numeric(cont)) ~ log10(as.numeric(dist))))[1],
        slope = coef(lm(log10(as.numeric(cont)) ~ log10(as.numeric(dist))))[2]
    )

# Calculate the coefficients of lines of best fit for the second range
range_start_2 <- 3.5
range_end_2 <- 4
coefficients_2 <- c_all %>%
    dplyr::filter(
        log10(as.numeric(dist)) >= range_start_2,
        log10(as.numeric(dist)) <= range_end_2
    ) %>%
    dplyr::group_by(phase) %>%
    dplyr::summarize(
        intercept = coef(lm(log10(as.numeric(cont)) ~ log10(as.numeric(dist))))[1],
        slope = coef(lm(log10(as.numeric(cont)) ~ log10(as.numeric(dist))))[2]
    )

#  Plot publication-quality contact decay curve using ggplot2
title <- "Contact decay curves for the first rDNA array"
subtitle <- "Subsampled, balanced matrix counts, 50-bp resolution"
p_rDNA <- c_all %>%
    ggplot(aes(
        x = log10(as.numeric(dist)),
        y = log10(as.numeric(cont)),
        color = phase
    )) +
    annotation_logticks(sides = "lb", color = "grey92", outside = FALSE) +
    # geom_line() +  # Draw raw, "unsmoothed" curves
    # geom_smooth(  # Draw smoothed curves via GAM
    #     aes(fill = phase),
    #     method = "gam",
    #     se = TRUE,
    #     linewidth = 0.5,
    #     alpha = 0.25
    # ) +
    geom_smooth(  # Draw smoothed curves via LOESS
        aes(fill = phase),
        method = "loess",
        se = TRUE,
        linewidth = 0.5,
        span = 1,
        alpha = 0.1
    ) +
    stat_smooth(  # Add lines of best fit for the smoothed values
        data = . %>%
            dplyr::filter(log10(as.numeric(dist)) <= range_end),
        aes(color = phase),
        method = "lm",
        se = FALSE,
        linetype = "dashed",
        linewidth = 0.5
    ) +
    stat_smooth(  # Add second set of lines of best fit for the specified range
        data = . %>%
            dplyr::filter(
                log10(as.numeric(dist)) >= range_start_2,
                log10(as.numeric(dist)) <= range_end_2
        ),
        aes(color = phase),
        method = "lm",
        se = FALSE,
        linetype = "dashed",
        linewidth = 0.5
    ) +
    labs(
        title = title,
        subtitle = subtitle,
        x = "Genomic distance (s)",
        y = "P(s)",
        color = "State"
    ) +
    scale_x_continuous(
        breaks = log10(c(100, 1000, 10000)), 
        labels = c(expression(10^2), expression(10^3), expression(10^4)),
        limits = c(log10(100), NA)
    ) +
    scale_y_continuous(
        breaks = log10(c(0.001, 0.01, 0.1, 1)), 
        labels = c(
            expression(10^-3), expression(10^-2),
            expression(10^-1), expression(10^0)
        )
    ) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank())

#  Add power-law equations to the plot
for(i in 1:nrow(coefficients)) {
    p_rDNA <- p_rDNA +
        annotate(
            "text",
            x = 3,
            y = -2 + (0.5 * i),  # Adjust these coordinates to place the text where you want
            label = sprintf(
                "y = %.2fx + %.2f",
                coefficients$slope[i],
                coefficients$intercept[i]
            ),
            color = scales::hue_pal()(nrow(coefficients))[i],  # Match the color to the phase
            size = 4
        ) +
        annotate(
            "text", 
            x = 3.5,  # Adjust x-coordinate to avoid overlap with the first set of equations
            y = -2 + (0.5 * i), 
            label = sprintf(
                "y = %.2fx + %.2f", 
                coefficients_2$slope[i], 
                coefficients_2$intercept[i]
            ),
            color = scales::hue_pal()(nrow(coefficients_2))[i], 
            size = 4
        )
}

print_plot <- TRUE
if(base::isTRUE(print_plot)) p_rDNA

save_plot <- FALSE
if(base::isTRUE(save_plot)) {
    ggplot2::ggsave(
        paste(
            p_txt,
            "contact-decay_XII-451400-460800.ggplot2-main.loess-span-1.power-law-both.pdf",
            sep = "/"
        ),
        p_rDNA
    )
}

#  Plot publication-quality contact decay curve slopes using ggplot2
# span <- 0.5
c_all <- c_all %>%
    dplyr::arrange(phase, dist) %>%  # Ensure the data is sorted by phase and distance
    dplyr::group_by(phase) %>%  # Group by phase to calculate the slope within each phase
    dplyr::mutate(
        slope = (
            log10(lead(as.numeric(cont), order_by = dist)) -
            log10(as.numeric(cont))
        ) / (
            log10(lead(as.numeric(dist), order_by = dist)) -
            log10(as.numeric(dist))
        ),
        # smooth = predict(loess(as.numeric(cont) ~ as.numeric(dist), span = span)),
        # slope_smooth = (
        #     log10(lead(as.numeric(smooth), order_by = dist)) -
        #     log10(as.numeric(smooth))
        # ) / (
        #     log10(lead(as.numeric(dist), order_by = dist)) -
        #     log10(as.numeric(dist))
        # )
    ) %>%  # Calculate the slope
    dplyr::filter(
        (!is.na(slope) & !is.infinite(slope)) # |
        # (!is.na(slope_smooth) & !is.infinite(slope_smooth))
    ) %>%  # Remove NA and -Inf values
    ungroup()

title <- "Slope of contact decay curves for the first rDNA array"
subtitle <- "Subsampled, balanced matrix counts, 50-bp resolution"
p_slope <- c_all %>%
    ggplot(aes(x = log10(as.numeric(dist)), y = slope, color = phase)) +
    annotation_logticks(sides = "b", color = "grey92", outside = FALSE) +
    # geom_line() +  # Draw raw, "unsmoothed" curves
    # geom_smooth(  # Draw smoothed curves via GAM
    #     aes(fill = phase),
    #     method = "gam",
    #     se = TRUE,
    #     linewidth = 0.5,
    #     alpha = 0.25
    # ) +
    geom_smooth(  # Draw smoothed curves via LOESS
        aes(fill = phase),
        method = "loess",
        se = TRUE,
        linewidth = 0.5,
        span = 1,
        alpha = 0.2
    ) +
    labs(
        title = title,
        subtitle = subtitle,
        x = "Genomic distance (s)",
        y = "Slope P(s)",
        color = "State"
    ) +
    scale_x_continuous(
        breaks = log10(c(100, 1000, 10000)), 
        labels = c(expression(10^2), expression(10^3), expression(10^4)) # ,
        # limits = c(log10(100), NA)
    ) +
    xlim(log10(c(100, 10000))) +
    ylim(c(-2, 2)) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank())

print_plot <- TRUE
if(base::isTRUE(print_plot)) p_slope

ggplot2::ggsave(
    paste(
        p_txt,
        "contact-decay_XII-451400-460800.ggplot2-slope.GAM-default.pdf",
        sep = "/"
    ),
    p_slope
)

# #  Smoothed values
# title <- "Slope of contact decay curves for the first rDNA array"
# subtitle <- "Subsampled, balanced matrix counts, 50-bp resolution"
# p_smooth <- c_all %>%
#     ggplot(aes(x = log10(as.numeric(dist)), y = slope_smooth, color = phase)) +
#     annotation_logticks(sides = "b", color = "grey92", outside = FALSE) +
#     geom_line() +
#     labs(
#         title = title,
#         subtitle = subtitle,
#         x = "Genomic distance (s)",
#         y = "Slope P(s)",
#         color = "State"
#     ) +
#     scale_x_continuous(
#         breaks = log10(c(100, 1000, 10000)), 
#         labels = c(expression(10^2), expression(10^3), expression(10^4))
#     ) +
#     ylim(c(-10, 10)) +
#     theme_minimal() +
#     theme(panel.grid.minor = element_blank())
