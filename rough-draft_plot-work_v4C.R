#!/usr/bin/env Rscript

#  rough-draft_plot-work_v4C-etc.R
#  KA

#  Load libraries, set options ------------------------------------------------
library(tidyverse)
library(scales)


#  Initialize function --------------------------------------------------------
process_bedgraph <- function(bg_file, sample = "Q") {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        bg_file <- bg_Q
        sample <- "Q"
    }
    
    bg <- readr::read_tsv(
            bg_file,
            col_names = c(
                "chr_a", "start_a", "end_a", "chr_r", "start_r", "end_r",
                "value"
            )
        ) %>%
            dplyr::group_by(chr_r, start_r, end_r) %>%
            dplyr::summarize(
                chr_a = "XII",
                start_a = min(start_a),
                end_a = max(end_a),
                value = mean(value, na.rm = TRUE)
        ) %>%
        ungroup() %>%
        dplyr::mutate(
            sample = sample,
            chr_r = as.roman(chr_r),
            chr_a = as.roman(chr_a)
        ) %>%
        dplyr::relocate(sample, .before = chr_r) %>%
        dplyr::arrange(chr_r, start_r, end_r, chr_a, start_a, end_a)
    
    bg[bg$value == 0, ]$value <- NA_integer_
    
    return(bg)
}


adjust_chr_transition <- function(data) {
    #  Initialize variables to keep track of the last end_r and chromosome
    last_end_r <- 0
    last_chr_r <- NULL
    
    #  Iterate through the rows of the data frame
    for (i in 1:nrow(data)) {
        current_chr_r <- data$chr_r[i]
        
        #  Check if there's a transition in chromosomes
        if(!is.null(last_chr_r) && current_chr_r != last_chr_r) {
            # I dentify all rows with the current chromosome
            same_chr_rows <- data$chr_r == current_chr_r
            
            #  Adjust start_r and end_r based on the transition for the current
            #+ chromosome
            data$start_r[same_chr_rows] <-
                data$start_r[same_chr_rows] + last_end_r
            data$end_r[same_chr_rows] <-
                data$end_r[same_chr_rows] + last_end_r
        }
        
        #  Update last_chr_r and last_end_r
        last_chr_r <- current_chr_r
        last_end_r <- data$end_r[i]
    }
    
    return(data)
}


plot_v4c <- function(
    data = pro_Q,
    chr_limit = NULL,
    region_limit = NULL,
    subtitle = "1600-bp resolution",
    xlabel = "Genomic position",
    ylabel = "Interaction frequency (KR-balanced)",
    ymin = 0,
    ymax = 0.0015
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        data <- pro_Q
        chr_limit <- "XII"
        # region_limit <- list(chr_r = "XII", start_r = 400000, end_r = 600000)
        region_limit <- list(chr_r = "XII", start_r = 100000, end_r = 200000)
        subtitle <- "1600-bp resolution"
        xlabel <- "Genomic position"
        ylabel <- "Interaction frequency (KR-balanced)"
        ymin <- 0
        ymax <- 0.0005
    }

    #  Define the desired order of samples and associated colors
    desired_sample_order <- c("G2-M", "G1", "Q")
    sample_colors <- c("Q" = "#F8776D", "G1" = "#00BA38", "G2-M" = "#619CFF")
    
    if(!is.null(chr_limit)) {
        if(is.character(chr_limit)) {
            chr_limit <- as.roman(chr_limit)
        }
        if(class(chr_limit) != "roman") {
            stop("chr_limit must be of class 'roman'.")
        }
    }

    if(!is.null(region_limit)) {
        if (!is.null(chr_limit)) {
            warning(paste(
                "Both chr_limit and region_limit are supplied. Processing of",
                "chr_limit will be overridden by processing of region_limit."
            ))
        }
        if(is.character(region_limit$chr_r)) {
            region_limit$chr_r <- as.roman(region_limit$chr_r)
        }
        if(class(region_limit$chr_r) != "roman") {
            stop("chr_limit must be of class 'roman'.")
        }
        
        data <- data[
            data$chr_r == region_limit$chr_r &
            data$start_r >= region_limit$start_r &
            data$end_r <= region_limit$end_r,
        ]
    } else if(!is.null(chr_limit)) {
        data <- data[data$chr_r == chr_limit, ]
    }

    #  Create a ggplot object
    p <- ggplot(data, aes(x = ((start_r + end_r) / 2), y = value)) +
        geom_line(aes(color = sample)) +
        labs(
            title = paste(
                "v4C plot",
                ifelse(!is.null(chr_limit), paste("for", chr_limit), ""),
                ifelse(
                    !is.null(region_limit),
                    paste(
                        "in", region_limit$chr_r, ":",
                        region_limit$start_r, "-", region_limit$end_r
                    ),
                    ""
                )
            ),
            subtitle = subtitle,
            x = xlabel,
            y = ylabel
        ) +
        coord_cartesian(ylim = c(ymin, ymax)) +
        theme_minimal() +
        scale_y_continuous(labels = label_number(accuracy = 0.0001)) +
        scale_color_manual(
            values = sample_colors,
            breaks = desired_sample_order
        )
    
    if(base::isTRUE(debug)) print(p)

    return(p)
}


plot_v4c_genome <- function(
    data,
    title = "v4C plot",
    subtitle = "1600-bp resolution",
    xlabel = "",
    ylabel = "Interaction frequency (KR-balanced)",
    ymin = 0,
    ymax = 0.0015,
    sample_col = "sample"
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        data <- adj_Q
        title <- "v4C plot"
        subtitle <- "1600-bp resolution"
        xlabel <- ""
        ylabel <- "Interaction frequency (KR-balanced)"
        ymin <- 0
        ymax <- 0.0015
        sample_col <- "sample"
    }

    #  Define the desired order of samples and associated colors
    desired_sample_order <- c("G2-M", "G1", "Q")
    sample_colors <- c("Q" = "#F8776D", "G1" = "#00BA38", "G2-M" = "#619CFF")

    #  Create a list of labels for chromosomes
    chromosome_labels <- as.roman(unique(data$chr_r))
    
    chromosome_transitions <- c(1, which(diff(data$chr_r) != 0) + 1, nrow(data) + 1)
    break_positions <-
        data$start_r[chromosome_transitions][
            !is.na(data$start_r[chromosome_transitions])
        ][1:16]
    
    #  Create an empty ggplot object
    p <- ggplot() +
        labs(
            title = title,
            subtitle = subtitle,
            x = xlabel,
            y = ylabel
        ) +
        coord_cartesian(ylim = c(ymin, ymax)) +
        theme_minimal() +
        scale_x_continuous(
            breaks = break_positions,
            labels = chromosome_labels,
            minor_breaks = NULL
        ) +
        scale_y_continuous(labels = label_number(accuracy = 0.0001)) +
        scale_color_manual(
            values = sample_colors,
            breaks = desired_sample_order
        )
    
    #  Populate the ggplot2 object in the desired order
    for (sample in desired_sample_order) {
        sample_data <- data[data[[sample_col]] == sample, ]

        p <- p +
            geom_line(
                data = sample_data,
                aes(x = ((start_r + end_r) / 2), y = value, color = sample))
    }

    if(base::isTRUE(debug)) print(p)

    return(p)
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
d_bg <- "pngs/2023-1025_XII-451400-469200_v4C"
bg_Q <- paste(d_bg, "Q_res-1600_KR-filt-0.4-all-contacts.bg", sep = "/")
bg_1 <- paste(d_bg, "G1_res-1600_KR-filt-0.4-all-contacts.bg", sep = "/")
bg_2 <- paste(d_bg, "G2-M_res-1600_KR-filt-0.4-all-contacts.bg", sep = "/")

pro_Q <- process_bedgraph(bg_Q, sample = "Q")
pro_1 <- process_bedgraph(bg_1, sample = "G1")
pro_2 <- process_bedgraph(bg_2, sample = "G2-M")

adj_Q <- adjust_chr_transition(pro_Q)
adj_1 <- adjust_chr_transition(pro_1)
adj_2 <- adjust_chr_transition(pro_2)
adj_a <- dplyr::bind_rows(adj_Q, adj_1, adj_2)


#  Draw plots -----------------------------------------------------------------
chr_XII_Q <- plot_v4c(adj_Q, ymax = 0.0006)
chr_XII_1 <- plot_v4c(adj_1, ymax = 0.0006)
chr_XII_2 <- plot_v4c(adj_2, ymax = 0.0006)
chr_XII_a <- plot_v4c(adj_a, ymax = 0.0006)

print(chr_XII_Q)
print(chr_XII_1)
print(chr_XII_2)
print(chr_XII_a)

gen_Q <- plot_v4c_genome(adj_Q)
gen_1 <- plot_v4c_genome(adj_1)
gen_2 <- plot_v4c_genome(adj_2)
gen_a <- plot_v4c_genome(adj_a)

print(gen_Q)
print(gen_1)
print(gen_2)
print(gen_a)
