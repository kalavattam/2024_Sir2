#!/usr/bin/env Rscript

#  rough-draft_plot-work_v4C-etc.scraps.R
#  KA

#  Scratch --------------------------------------------------------------------
p_pe <- "13_FitHiC2_genome_KR-filt-0.4_whole-matrix/test_2023-1016_interOnly"

library(ggplot2)

# Sample data in bedpe format (you would replace this with your data)
bedpe_data <- data.frame(
    chr1 = c("chr1", "chr2", "chr3"),
    pos1 = c(10000, 20000, 30000),
    chr2 = c("chr2", "chr3", "chr1"),
    pos2 = c(20000, 30000, 10000),
    score = c(2, 3, 1)
)

# Ensure none of the scores are negative
bedpe_data$score <- pmax(bedpe_data$score, 0)

# Create the arcs manually
ggplot(bedpe_data, aes(x = pos1, y = 0, xend = pos2, yend = score, color = score)) +
    geom_segment(aes(xend = pos1, yend = 0), size = 1, lineend = "round") +
    geom_segment(aes(x = pos2, yend = 0), size = 1, lineend = "round") +
    geom_curve(
        aes(x = pos1, xend = pos2, y = 0, yend = 0, color = score),
        curvature = 0.2,
        lineend = "round"
    ) +
    scale_color_gradient(low = "blue", high = "red") +
    labs(
        title = "Hi-C arcs plot",
        x = "Genomic position",
        y = "Interaction score",
        color = "Interaction score"
    ) +
    theme_minimal()

ggplot(bedpe_data, aes(x = pos1, y = 0, xend = pos2, yend = score, color = score)) +
    geom_curve(aes(x = pos1, xend = pos2, y = 0, yend = score), curvature = 0.2, lineend = "round") +
    scale_color_gradient(low = "blue", high = "red") +
    labs(
        title = "Hi-C arcs plot",
        x = "Genomic position",
        y = "Interaction score",
        color = "Interaction score"
    ) +
    theme_minimal()

# Create a blank plot
plot(0, type = "n", xlim = c(0, max(bedpe_data$pos1, bedpe_data$pos2)), ylim = c(0, max(bedpe_data$score)))

library(ggplot2)

# Function to create arcs with score-based heights
create_arc_plot <- function(
    link.file, file.type = "bedpe", score.col = NULL, score.threshold = NULL,
    score.color = c("blue", "grey", "red"), scale.range = 10,
    plot.space = 0.1, plot.height = 0.2, show.rect = FALSE
) {
  
  # Read the link data
  if (file.type == "bedpe") {
    link.df <- read.table(file = link.file, sep = "\t")
    if (!is.null(score.col)) {
      if (score.col > ncol(link.df)) {
        stop("The score column index is bigger than the number of columns in the data frame. Please provide a valid score column index.")
      } else {
        link.df <- link.df[, c(1, 2, 3, 4, 5, 6, score.col)]
        colnames(link.df) <- c("chr1", "start1", "end1", "chr2", "start2", "end2", "score")
      }
    } else {
      link.df <- link.df[, c(1, 2, 3, 4, 5, 6)]
      colnames(link.df) <- c("chr1", "start1", "end1", "chr2", "start2", "end2")
    }
    
    # Filter link dataframe
    link.df <- link.df[link.df$chr1 == link.df$chr2, ]
    
    # Filter by score threshold
    if (!is.null(score.threshold)) {
      link.df <- link.df[link.df$score > score.threshold, ]
    }
    
    # Calculate center points
    link.df$start_center <- (link.df$start1 + link.df$end1) / 2
    link.df$end_center <- (link.df$start2 + link.df$end2) / 2
    
    # Create arcs with score-based heights
    link.df$y_start <- 0
    link.df$y_end <- link.df$score * scale.range
    
  } else {
    stop("Currently, only 'bedpe' file type is supported.")
  }
  
  # Create the arc plot
  ggplot(link.df, aes(x = start_center, xend = end_center, y = y_start, yend = y_end, color = score)) +
    geom_segment(size = 1, lineend = "round") +
    scale_color_gradient(low = score.color[1], mid = score.color[2], high = score.color[3], limits = range(link.df$score)) +
    coord_cartesian(ylim = c(0, max(link.df$y_end)), expand = FALSE) +
    theme_minimal() +
    theme(legend.position = "none")
}

# Example usage:
bedpe <- "13_FitHiC2_genome_KR-filt-0.4_whole-matrix/test_2023-1016_interOnly/Q.5000.ds-to-Q.genome-trans.spline_pass1.res5000.significances.filt.bedpe"
bedpe <- readr::read_tsv(
    bedpe,
    col_names = c(
        "chr_A", "start_A", "stop_A", "chr_B", "start_B", "stop_B", "name",
        "score", "strand_A", "strand_B", "color", "rDNA_assoc"
    ),
    show_col_types = FALSE
)

create_arc_plot(bedpe, score.col = 7)
