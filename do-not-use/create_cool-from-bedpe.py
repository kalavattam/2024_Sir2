#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright 2023 Kris Alavattam <kalavattam@gmail.com>
# Usage: python create_cool-from-bedpe.py -i <input_bedpe_file> -o <output_cool_file>
# Description: This script reads a bedpe-like file containing Hi-C contact 
# data along with balanced weights and creates a cool file. The input file 
# should have columns representing the two interacting genomic regions 
# (chromosome, start, end) and the contact frequency count, followed by the 
# balanced weight.
#
# Distributed under terms of the MIT license.

import pandas as pd
import cooler
import argparse
import sys


def create_cool_from_bedpe(input_bedpe, output_cool):
    # Read the data from the input bedpe file into a pandas DataFrame
    data = pd.read_csv(input_bedpe, sep='\t', header=None)
    data.columns = ['chrom1', 'start1', 'end1', 'chrom2', 'start2', 'end2', 'count', 'balanced']

    # # Concatenate chrom, start, and end columns
    # chroms = pd.concat([data['chrom1'], data['chrom2']])
    # starts = pd.concat([data['start1'], data['start2']])
    # ends = pd.concat([data['end1'], data['end2']])

    # # Create bins DataFrame
    # bins = pd.DataFrame({
    #     'chrom': chroms,
    #     'start': starts,
    #     'end': ends
    # }).drop_duplicates().sort_values(by=['chrom', 'start']).reset_index(drop=True)

    # # Map bin IDs
    # data['bin1_id'] = data.apply(lambda row: bins[(bins['chrom'] == row['chrom1']) & (bins['start'] == row['start1'])].index[0], axis=1)
    # data['bin2_id'] = data.apply(lambda row: bins[(bins['chrom'] == row['chrom2']) & (bins['start'] == row['start2'])].index[0], axis=1)

    # Create bins DataFrame
    bins = pd.DataFrame({
        'chrom': pd.concat([data['chrom1'], data['chrom2']]),
        'start': pd.concat([data['start1'], data['start2']]),
        'end': pd.concat([data['end1'], data['end2']])
    }).reset_index(drop=True)

    # Create pixels DataFrame
    pixels = pd.DataFrame({
        'bin1_id': data.index,
        'bin2_id': data.index,  # Adjust as needed
        'count': data['count'],
        'balanced': data['balanced']
    })

    # Create a new cool file with the data
    cooler.create_cooler(output_cool, bins, pixels, dtypes={'count': int, 'balanced': float})

    print(f"cool file {output_cool} created successfully.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create a cool file from a bedpe-like file with balanced weights.")
    parser.add_argument("-i", "--input", type=str, help="Path to the input bedpe-like file.")
    parser.add_argument("-o", "--output", type=str, help="Path to the output cool file.")

    args = parser.parse_args()

    if len(sys.argv) < 2:
        parser.print_help(sys.stderr)
        sys.exit(1)

    create_cool_from_bedpe(args.input, args.output)
