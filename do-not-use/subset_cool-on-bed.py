#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright 2023 Kris Alavattam <kalavattam@gmail.com>
# Usage: subset_cool-on-bed.py -c <cool_file> -b <bed_file> -o <output_file>
# Description: This script subsets a cool file based on regions specified in a 
# bed file. It checks if the input cool file and bed file exist and if the 
# directory for the output file exists. If all checks pass, it uses the cooler 
# library to extract bins paritally or completely overlapping specified regions
# from the cool file and writes them to a new cool file.
#
# Distributed under terms of the MIT license.

import cooler
import pandas as pd
import argparse
import os
import sys


# Initialize function to extract bins and pixels for each region in the bed
# file
def extract_bins_pixels(c, region):
    bins = c.bins().fetch(region).reset_index(drop=True)
    pixels = c.matrix(as_pixels=True, join=True).fetch(region)
    return bins, pixels


def subset_cool_file(cool_file, bed_file, output_file):
    # Load the cool file
    c = cooler.Cooler(cool_file)

    # Load the bed file
    bed_df = pd.read_csv(bed_file, sep='\t', header=None, usecols=[0, 1, 2], names=['chrom', 'start', 'end'])

    # Extract bins and pixels for all regions and concatenate them
    all_bins = []
    all_pixels = []
    for _, row in bed_df.iterrows():
        region = f"{row['chrom']}:{row['start']}-{row['end']}"
        bins, pixels = extract_bins_pixels(c, region)
        all_bins.append(bins)
        all_pixels.append(pixels)

    all_bins = pd.concat(all_bins, ignore_index=True)
    all_pixels = pd.concat(all_pixels, ignore_index=True)

    # Create a new cool file with the extracted bins and pixels
    cooler.create_cooler(cool_uri=output_file, bins=all_bins, pixels=all_pixels, dtypes={'count': 'int'})


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Subset a cool file based on regions specified in a bed file.')
    parser.add_argument('cool_file', type=str, help='Path to the input cool file.')
    parser.add_argument('bed_file', type=str, help='Path to the bed file containing regions of interest.')
    parser.add_argument('output_file', type=str, help='Path to the output cool file.')

    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)

    args = parser.parse_args()

    if not os.path.exists(args.cool_file):
        print(f"Error: The input cool file '{args.cool_file}' does not exist.")
        sys.exit(1)

    if not os.path.exists(args.bed_file):
        print(f"Error: The bed file '{args.bed_file}' does not exist.")
        sys.exit(1)

    output_dir = os.path.dirname(args.output_file)
    if output_dir and not os.path.exists(output_dir):
        print(f"Error: The directory for the output file '{output_dir}' does not exist.")
        sys.exit(1)

    subset_cool_file(args.cool_file, args.bed_file, args.output_file)
