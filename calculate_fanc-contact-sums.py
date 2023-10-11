#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright 2023 Kris Alavattam <kalavattam@gmail.com>
# Usage: calculate_fanc-contact-sums.py <Q_infile> <G1_infile> <G2_infile>
# Description: This script reads in three FAN-C .hic files, calculates the
# contact sums, and downsamples all three files to match the smallest one.
#
# Distributed under terms of the MIT license.

import sys
import os
import fanc
import numpy as np
import argparse


def calculate_contact_sum(hic_file):
    hic = fanc.load(hic_file)
    contact_sum = 0
    for value in hic.edge_data(hic._default_score_field, lazy=True):
        if np.isfinite(value):
            contact_sum += value
    return contact_sum, hic


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description=(
            "Calculate contact sums for Q, G1, and G2/M FAN-C .hic infiles and "
            "downsample the three .hic files to the file with the smallest sum."
        )
    )
    parser.add_argument(
        "-Q", "--Q_infile",
        required=True,
        help="Path and name for the Q FAN-C .hic infile <chr>"
    )
    parser.add_argument(
        "-G1", "--G1_infile",
        required=True,
        help="Path and name for the G1 FAN-C .hic infile <chr>"
    )
    parser.add_argument(
        "-G2", "--G2_infile",
        required=True,
        help="Path and name for the G2/M FAN-C .hic infile <chr>"
    )
    parser.add_argument(
        "-s", "--seed",
        type=int,
        default=24,
        help="Seed for random number generation <int>"
    )
    parser.add_argument(
        "--Q_outfile",
        default="Q_downsampled.hic",
        help=(
            "Path and name for the Q downsampled FAN-C .hic outfile; if not "
            "specified, then path and name is derived from corresponding "
            "infile <chr>"
        )
    )
    parser.add_argument(
        "--G1_outfile",
        default="G1_downsampled.hic",
        help=(
            "Path and name for the G1 downsampled FAN-C .hic outfile; if not "
            "specified, then path and name is derived from corresponding "
            "infile <chr>"
        )
    )
    parser.add_argument(
        "--G2_outfile",
        default="G2_downsampled.hic",
        help=(
            "Path and name for the G2/M downsampled FAN-C .hic outfile; if "
            "not specified, then path and name is derived from corresponding "
            "infile <chr>"
        )
    )

    #  Parse arguments
    args = parser.parse_args()

    #  Set the seed for random number generation
    np.random.seed(args.seed)

    #  Calculate contact-matrix sums for each file
    sum_Q, hic_Q = calculate_contact_sum(args.Q_infile)
    sum_G1, hic_G1 = calculate_contact_sum(args.G1_infile)
    sum_G2, hic_G2 = calculate_contact_sum(args.G2_infile)

    print(f"Q contact sum\t{str(sum_Q)}\t{os.path.basename(args.Q_infile)}")
    print(f"G1 contact sum\t{str(sum_G1)}\t{os.path.basename(args.G1_infile)}")
    print(f"G2 contact sum\t{str(sum_G2)}\t{os.path.basename(args.G2_infile)}\n")

    # Determine the smallest sum
    sums = {'Q': sum_Q, 'G1': sum_G1, 'G2': sum_G2}
    min_key = min(sums, key=sums.get)
    min_value = sums[min_key]

    # Set default outfile names if not provided
    if args.Q_outfile == "Q_downsampled.hic":
        args.Q_outfile = args.Q_infile.replace(
            '.hic',
            f'.downsample-to-{min_key}.hic'
        )
    if args.G1_outfile == "G1_downsampled.hic":
        args.G1_outfile = args.G1_infile.replace(
            '.hic',
            f'.downsample-to-{min_key}.hic'
        )
    if args.G2_outfile == "G2_downsampled.hic":
        args.G2_outfile = args.G2_infile.replace(
            '.hic',
            f'.downsample-to-{min_key}.hic'
        )

    #  Downsample all three files to the smallest sum
    print(f"Sample {min_key} has the smallest sum: {min_value}.\n")
    print((
        f"The sum for sample {min_key} will be used for random matrix "
        f"subsampling without replacement, i.e., downsampling.\n"
    ))

    print((
        f"Begin: Sampling {os.path.basename(args.Q_outfile)} to value"
        f"{min_value}."
    ))
    hic_Q.downsample(min_value, file_name = args.Q_outfile)
    print((
        f"Completed: Sampling {os.path.basename(args.Q_outfile)} to value"
        f"{min_value}.\n"
    ))

    print((
        f"Begin: Sampling {os.path.basename(args.G1_outfile)} to value"
        f"{min_value}."
    ))
    hic_G1.downsample(min_value, file_name = args.G1_outfile)
    print((
        f"Completed: Sampling {os.path.basename(args.G1_outfile)} to value"
        f"{min_value}.\n"
    ))

    print((
        f"Begin: Sampling {os.path.basename(args.G2_outfile)} to value"
        f"{min_value}."
    ))
    hic_G2.downsample(min_value, file_name = args.G2_outfile)
    print((
        f"Completed: Sampling {os.path.basename(args.G2_outfile)} to value"
        f"{min_value}.\n"
    ))

    print((
        f"All files downsampled to {min_value} contacts and saved as "
        f"'{args.Q_outfile}', '{args.G1_outfile}', and '{args.G2_outfile}'.\n"
    ))
