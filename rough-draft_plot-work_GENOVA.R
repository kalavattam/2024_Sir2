#!/usr/bin/env Rscript

#  rough-draft_plot-work_GENOVA.R
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
# p_cool <- "08_zoom"
# f_Q <- "MC-2019_Q_WT_repM.standard-rDNA-complete.mcool"
# f_1 <- "MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool"
# f_2 <- "MC-2020_nz_WT_repM.standard-rDNA-complete.mcool"

# res <- 6400
# res <- 5000
res <- 200
# res <- 50
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
    res, ".", suf, ".XII-451500-460800.cool" # ".cool"
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


#  Set up outfile directory for plots, etc. -----------------------------------
# p_out <- "pngs/2023-1003"
p_out <- "pngs/2023-1018"
if(base::isFALSE(dir.exists(p_out))) dir.create(p_out)


#  Quantify and plot sample-wise ratios of cis and trans interactions ---------
#+ ...for the whole genome
if(res %in% c(5000, 6400)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_cis_all <- lgl
if(base::isTRUE(run_quant_cis_all)) {
    quant_cis_all <- GENOVA::cis_trans(list(c_Q, c_1, c_2))
    quant_cis_all$trans <- 100 - quant_cis_all$cis
    
    quant_cis_all <- quant_cis_all %>%
        dplyr::select(-region) %>%
        gather(key = "type", value = "percentage", -sample)
    quant_cis_all$sample <- factor(
        quant_cis_all$sample, levels = c("G2-M", "G1", "Q")
    )
    quant_cis_all$type <- factor(
        quant_cis_all$type, levels = c("trans", "cis")
    )
    
    title <- "Proportions of cis and trans interactions\nacross cell states"
    subtitle <- paste0(res, " bp resolution, all")
    plot_cis_all <- quant_cis_all %>%
        dplyr::rename(state = sample) %>% 
        ggplot2::ggplot(aes(x = state, y = percentage, fill = type)) +
        geom_bar(stat = "identity") +
        coord_flip() + 
        scale_y_continuous(limits = c(0, 100)) +
        scale_fill_manual(
            values = c("#00BFC498", "#F8766D98"),
            labels = c("trans", "cis")
        ) +
        labs(fill = "") +
        ggtitle(title, subtitle = subtitle) +
        theme_minimal()
    
    write_plot(path = p_out, list = plot_cis_all, w = 5, h = 2)
}


#  Quantify and plot sample-wise ratios of cis and trans interactions ---------
#+ ...for the rDNA region with respect to the whole genome
if(res %in% c(5000, 6400)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_cis_rDNA <- lgl
if(base::isTRUE(run_quant_cis_rDNA)) {
    bed_rDNA <- data.frame(
        "chromosome" = "XII",
        "start" = 451526,
        "end" = 468980
    )
    
    quant_cis_rDNA <- GENOVA::cis_trans(list(c_Q, c_1, c_2), bed = bed_rDNA)
    quant_cis_rDNA$trans <- 100 - quant_cis_rDNA$cis
    
    quant_cis_rDNA <- quant_cis_rDNA %>%
        dplyr::select(-region) %>%
        gather(key = "type", value = "percentage", -sample)
    quant_cis_rDNA$sample <- factor(
        quant_cis_rDNA$sample, levels = c("G2-M", "G1", "Q")
    )
    quant_cis_rDNA$type <- factor(
        quant_cis_rDNA$type, levels = c("trans", "cis")
    )
    
    title <- "Proportions of cis and trans interactions\nacross cell states"
    subtitle <- paste0(res, " bp resolution, originating from rDNA locus")
    plot_cis_rDNA <- quant_cis_rDNA %>%
        dplyr::rename(state = sample) %>% 
        ggplot2::ggplot(aes(x = state, y = percentage, fill = type)) +
        geom_bar(stat = "identity") +
        coord_flip() + 
        scale_y_continuous(limits = c(0, 100)) +
        scale_fill_manual(
            values = c("#00BFC498", "#F8766D98"),
            labels = c("trans", "cis")
        ) +
        labs(fill = "") +
        ggtitle(title, subtitle = subtitle) +
        theme_minimal()
    
    write_plot(list = plot_cis_rDNA, w = 5, h = 2)
}


#  Identify and plot relative contact probabilities (RCPs) --------------------
#+ ...for XII
if(res %in% c(5000, 6400)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_RCP_XII <- lgl
if(base::isTRUE(run_quant_RCP_XII)) {
    quant_RCP_XII <- GENOVA::RCP(
        list(c_Q, c_1, c_2),
        chromsToUse = "XII"
    )
    # GENOVA::visualise(quant_RCP_XII)
    
    title <- "cis-interaction frequency probabilities (P)\nstratified by distance (s)"
    subtitle <- paste0("XII, ", res, "-bp resolution")
    plot_RCP_XII <- quant_RCP_XII$smooth %>%
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
    
    write_plot(list = plot_RCP_XII, w = 5, h = 5)
    
    #  Attempts to plot fitted line for Q from 0 to 64kb not work; return to
    #+ this later
    # dis_start <- 0
    #   dis_end <- 64000
    # 
    # filt <- quant_RCP_XII$smooth %>% 
    #     dplyr::filter(distance >= dis_start & distance <= dis_end)
    # 
    # lr_Q <- lm(P ~ distance, data = filt[samplename == "Q", ])
    # lr_1 <- lm(P ~ distance, data = filt[samplename == "G1", ])
    # lr_2 <- lm(P ~ distance, data = filt[samplename == "G2-M", ])
    
    # #  Plot the derivative of the contact-decay curve with respect to genomic
    # #+ distance
    # test <- quant_RCP_XII$smooth %>%
    #     tibble::as_tibble() %>%
    #     dplyr::arrange(samplename, distance) %>%
    #     dplyr::group_by(samplename) %>%
    #     dplyr::mutate(dP = c(0, diff(P)) / c(0, diff(distance)))  # Derivative
    # 
    # print(test, n = 1000)
    # 
    # title <- "Derivatives of cis-interaction frequency probabilities (dP)\nstratified by distance (s)"
    # subtitle <- paste0("XII, ", res, "-bp resolution")
    # p_test <- test %>%
    #     ggplot(aes(x = distance, y = dP, color = samplename)) +
    #     annotation_logticks(sides = "lb", color = "grey92", outside = FALSE) +
    #     geom_line(linewidth = 1) +
    #     scale_x_log10(labels = trans_format("log10", math_format(10^.x))) +
    #     # scale_y_log10(labels = trans_format("log10", math_format(10^.x))) +
    #     scale_color_manual(
    #         name = "State",
    #         values = c(
    #             "Q" = "#00BFC498", "G1" = "#C77CFF98", "G2-M" = "#F8766D98"
    #         )
    #     ) +
    #     labs(x = "Genomic distance (s)", y = "dP(s)", color = "Sample") +
    #     ggtitle(title, subtitle = subtitle) +
    #     theme_minimal() +
    #     theme(panel.grid.minor = element_blank())
    #  The above attempt to calculate and plot slope (derivative) values result
    #+ in unexpectedly small slope values; thus, I should try to reproduce the
    #+ work I did with values obtained from HiCExplorer hicPlotDistVsCounts;
    #+ see the following links to my previous code:
    #+ - github.com/Noble-Lab/2020_kga0_endothelial-diff/blob/master/bin/munge_tables_contact-decay_plots-data_unsampled-balanced.sh
    #+ - github.com/Noble-Lab/2020_kga0_endothelial-diff/blob/master/bin/plot_slope_contact-decay.R
    #+ - github.com/Noble-Lab/2020_kga0_endothelial-diff/blob/master/bin/perform_t-test_contact-decay_plots-data_unsampled-balanced.R
    
    draw_lfc_contrasts <- TRUE
    if(base::isTRUE(draw_lfc_contrasts)) {
        contrast_1 <- visualise(quant_RCP_XII, contrast = 1, metric = "lfc")
        contrast_2 <- visualise(quant_RCP_XII, contrast = 2, metric = "lfc")
        contrast_3 <- visualise(quant_RCP_XII, contrast = 3, metric = "lfc")
        
        G1_G2_v_Q <- contrast_1$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "G1" ~ "G1 ÷ Q",
                samplename == "G2-M" ~ "G2-M ÷ Q",
                TRUE ~ samplename
            ))
        Q_G1_v_G2 <- contrast_3$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "Q" ~ "Q ÷ G2-M",
                samplename == "G1" ~ "G1 ÷ G2-M",
                TRUE ~ samplename
            ))
        Q_G2_v_G1 <- contrast_2$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "Q" ~ "Q ÷ G1",
                samplename == "G2-M" ~ "G2-M ÷ G1",
                TRUE ~ samplename
            ))
        
        RCP_XII_contrasts <- dplyr::bind_rows(G1_G2_v_Q, Q_G1_v_G2, Q_G2_v_G1)
        title <- "cis-interaction frequency probability contrasts\nstratified by distance (s)"
        subtitle <- paste0("XII, ", res, "-bp resolution")
        plot_RCP_XII_contrasts <- RCP_XII_contrasts %>%
            dplyr::filter(!samplename %in% c("G1 ÷ Q", "G2-M ÷ Q", "G2-M ÷ G1")) %>%
            ggplot(aes(x = distance, y = P, color = samplename)) +
            annotation_logticks(sides = "b", color = "grey92", outside = FALSE) +
            geom_line(linewidth = 1) +
            scale_x_log10(
                labels = function(x) ifelse(x %in% 10^(4:6), scales::trans_format("log10", scales::math_format(10^.x))(x), ''),
                breaks = 10^(0:6)  # Adjust this range according to your data
            ) +
            labs(
                x = "Genomic distance (s)",
                y = "log2( P(s) sample ÷ P(s) contrast )",
                color = "Sample"
            ) +
            scale_color_manual(
                name = "State",
                values = c(
                    "Q ÷ G1" = "#C77CFF98",
                    "Q ÷ G2-M" = "#F8766D98",
                    "G1 ÷ G2-M" = "#00BFC498"
                )
            ) +
            ggtitle(title, subtitle = subtitle) +
            theme_minimal() +
            theme(panel.grid.minor = element_blank())
        
        write_plot(list = plot_RCP_XII_contrasts, w = 5, h = 5)
    }
}


#  Identify and plot relative contact probabilities (RCPs) --------------------
#+ ...for all chromosomes
if(res %in% c(5000, 6400)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_RCP_all <- lgl
if(base::isTRUE(run_quant_RCP_all)) {
    quant_RCP_all <- GENOVA::RCP(list(c_Q, c_1, c_2))
    # GENOVA::visualise(quant_RCP_all)
    
    title <- "cis-interaction frequency probabilities (P)\nstratified by distance (s)"
    subtitle <- paste0("all, ", res, "-bp resolution")
    plot_RCP_all <- quant_RCP_all$smooth %>%
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
        labs(x = "P(s)", y = "Genomic distance (s)", color = "Sample") +
        ggtitle(title, subtitle = subtitle) +
        theme_minimal() +
        theme(panel.grid.minor = element_blank())
    
    write_plot(list = plot_RCP_all, w = 5, h = 5)
    
    draw_lfc_contrasts <- TRUE
    if(base::isTRUE(draw_lfc_contrasts)) {
        contrast_1 <- visualise(quant_RCP_all, contrast = 1, metric = "lfc")
        contrast_2 <- visualise(quant_RCP_all, contrast = 2, metric = "lfc")
        contrast_3 <- visualise(quant_RCP_all, contrast = 3, metric = "lfc")
        
        G1_G2_v_Q <- contrast_1$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "G1" ~ "G1 ÷ Q",
                samplename == "G2-M" ~ "G2-M ÷ Q",
                TRUE ~ samplename
            ))
        Q_G1_v_G2 <- contrast_3$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "Q" ~ "Q ÷ G2-M",
                samplename == "G1" ~ "G1 ÷ G2-M",
                TRUE ~ samplename
            ))
        Q_G2_v_G1 <- contrast_2$data %>%
            tibble::as_tibble() %>%
            dplyr::mutate(samplename = dplyr::case_when(
                samplename == "Q" ~ "Q ÷ G1",
                samplename == "G2-M" ~ "G2-M ÷ G1",
                TRUE ~ samplename
            ))
        
        RCP_all_contrasts <- dplyr::bind_rows(G1_G2_v_Q, Q_G1_v_G2, Q_G2_v_G1)
        title <- "cis-interaction frequency probability contrasts\nstratified by distance (s)"
        subtitle <- paste0("all, ", res, "-bp resolution")
        plot_RCP_all_contrasts <- RCP_all_contrasts %>%
            dplyr::filter(!samplename %in% c("G1 ÷ Q", "G2-M ÷ Q", "G2-M ÷ G1")) %>%
            ggplot(aes(x = distance, y = P, color = samplename)) +
            annotation_logticks(sides = "b", color = "grey92", outside = FALSE) +
            geom_line(linewidth = 1) +
            scale_x_log10(
                labels = function(x) ifelse(x %in% 10^(4:6), scales::trans_format("log10", scales::math_format(10^.x))(x), ''),
                breaks = 10^(0:6)  # Adjust this range according to your data
            ) +
            labs(
                x = "Genomic distance (s)",
                y = "log2( P(s) sample ÷ P(s) contrast )",
                color = "Sample"
            ) +
            scale_color_manual(
                name = "State",
                values = c(
                    "Q ÷ G1" = "#C77CFF98",
                    "Q ÷ G2-M" = "#F8766D98",
                    "G1 ÷ G2-M" = "#00BFC498"
                )
            ) +
            ggtitle(title, subtitle = subtitle) +
            theme_minimal() +
            theme(panel.grid.minor = element_blank())
        
        write_plot(list = plot_RCP_all_contrasts, w = 5, h = 5)
    }
}


#  Identify and plot relative contact probabilities (RCPs) --------------------
#+ ...for rDNA region
if(res %in% c(50, 200)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_RCP_rDNA <- lgl
if(base::isTRUE(run_quant_RCP_rDNA)) {
    bed_rDNA <- data.frame(
        "chromosome" = "XII",
        # "start" = 451526,
        # "end" = 468980,
        "start" = 451500,
        "end" = 460800
    )
    
    quant_RCP_rDNA <- GENOVA::RCP(
        list(c_Q, c_1, c_2),
        bedlist = bed_rDNA
    )
    # GENOVA::visualise(quant_RCP_rDNA)
    
    title <- "cis-interaction frequency probabilities (P)\nstratified by distance (s)"
    subtitle <- paste0("rDNA, left array; resolution of ", res)
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

class(quant_RCP_rDNA)

#  Identify and plot relative contact probabilities (RCPs) --------------------
#+ ...for rDNA region, 1-10,000 bp
if(res %in% c(50, 200)) { lgl <- TRUE } else { lgl <- FALSE }
run_quant_RCP_rDNA_zoom <- lgl
if(base::isTRUE(run_quant_RCP_rDNA_zoom)) {
    bed_rDNA <- data.frame(
        "chromosome" = "XII",
        # "start" = 451526,
        # "end" = 468980,
        "start" = 451500,
        "end" = 460800
    )
    
    quant_RCP_rDNA_zoom <- GENOVA::RCP(
        list(c_Q, c_1, c_2),
        bedlist = bed_rDNA
    )
    # GENOVA::visualise(quant_RCP_rDNA)
    
    title <- "cis-interaction frequency probabilities (P)\nstratified by distance (s)"
    subtitle <- paste0("rDNA, left array; resolution of ", res)
    plot_RCP_rDNA_zoom <- quant_RCP_rDNA_zoom$smooth %>%
        ggplot(aes(x = distance, y = P, color = samplename)) +
        annotation_logticks(sides = "lb", color = "grey92", outside = FALSE) +
        geom_line(linewidth = 1) +
        scale_x_log10(breaks = 10^(0:5), labels = trans_format("log10", math_format(10^.x))) +
        scale_y_log10(breaks = 10^(-6:0), labels = trans_format("log10", math_format(10^.x))) +
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
        theme(panel.grid.minor = element_blank()) +
        coord_cartesian(
            # xlim = c(10^2, 10^3.75), ylim = c(10^-3, NA)
            xlim = c(10^2, 10^4), ylim = c(10^-3, NA)
        )

    write_plot(list = plot_RCP_rDNA_zoom, w = 5, h = 5)
    
    draw_lfc_contrasts <- FALSE
    if(base::isTRUE(draw_lfc_contrasts)) {
        visualise(quant_RCP_rDNA_zoom, contrast = 1, metric = "lfc")
        visualise(quant_RCP_rDNA_zoom, contrast = 2, metric = "lfc")
        visualise(quant_RCP_rDNA_zoom, contrast = 3, metric = "lfc")
    }
}


run_draft_code <- FALSE
if(base::isTRUE(run_draft_code)) {
    genes <- "cool/Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed"
    col_names <- c(
        "chrom", "start", "end", "name", "score", "strand", "source", "type",
        "frame", "attribute"
    )
    genes <- readr::read_tsv(
        genes,
        col_names = col_names
    )
    
    #  Data frame object must be formatted in the following way:
    #+ geneID | transcriptID | chrom | txStart | txEnd | exonStart | exonEnd |
    #+ strand
    #+ 
    #+ github.com/robinweide/GENOVA/blob/master/R/matrixplot_hic.R#L583
    # obj %>%
    #     data.frame(
    #         
    #     )
    
    outfile <- paste(p_out, "draft-plot_rDNA_Q-and-G2-M.png", sep = "/")
    png(filename = outfile, width = 5, height = 5, units =  "in", res = 300)
    GENOVA::hic_matrixplot(
        exp1 = c_Q,
        exp2 = c_2,
        chrom = "XII",
        start = 451400,
        end = 461000,
        coplot = "dual"
        # coplot = "diff"
        # inferno = FALSE,
        # type = "triangle",
        # genes = genes[, 1:6]
    )
    dev.off()
}


run_draft_code <- FALSE
if(base::isTRUE(run_draft_code)) {
    v4c <- virtual_4C(
        explist = c(list(c_Q, c_1, c_2)),
        viewpoint = "XII:451526-468980",
        xlim = c(451525, 617176)
    )
    
    GENOVA::visualise(v4c)
    
    v4c <- v4c$data
    
    typeof(v4c)
    class(v4c)
    
    # Replace v4c$Q with your actual data column
    v4c$Q[is.nan(v4c$Q)] <- NA  # Convert NaN values to NA so ggplot can handle them
    v4c$G1[is.nan(v4c$Q)] <- NA  # Convert NaN values to NA so ggplot can handle them
    v4c$`G2-M`[is.nan(v4c$Q)] <- NA  # Convert NaN values to NA so ggplot can handle them
    
    ggplot(v4c, aes(x = mid, y = Q)) +
        geom_line(color = "blue") + 
        labs(x = "Mid", y = "Q") +
        coord_cartesian(ylim = c(0, 6)) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
        # Optional: Rotate x-axis labels for better readability
    
    ggplot(v4c, aes(x = mid, y = G1)) +
        geom_line(color = "red") + 
        labs(x = "Mid", y = "G1") +
        coord_cartesian(ylim = c(0, 6)) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
        # Optional: Rotate x-axis labels for better readability
    
    ggplot(v4c, aes(x = mid, y = `G2-M`)) +
        geom_line(color = "green") + 
        labs(x = "Mid", y = "G2-M") +
        coord_cartesian(ylim = c(0, 6)) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
        # Optional: Rotate x-axis labels for better readability
}
