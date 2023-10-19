#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import h5py
import pandas as pd
import numpy as np
import sys

def add_balanced_weights(cool_file, bedpe_file):
    # Read the bedpe file into a pandas DataFrame
    data = pd.read_csv(bedpe_file, sep='\t', header=None, usecols=[7])

    # Validate if the bedpe file has the correct number of columns
    if data.shape[1] != 1:
        print("Error: The bedpe file should have 8 columns.")
        return

    balanced_weights = data[7].values

    # Open the .cool file
    with h5py.File(cool_file, 'r+') as h5:
        # Get the number of bins
        num_bins = h5['bins']['chrom'].shape[0]

        # Get the counts from the cool file to identify empty bins
        counts = h5['pixels']['count'][:]
        bins_with_data = np.unique(h5['pixels']['bin1_id'][:])

        # Print the counts for diagnosis
        print(f"Number of bins in cool file: {num_bins}")
        print(f"Number of balanced weights in bedpe file: {len(balanced_weights)}")
        print(f"Number of non-empty bins in cool file: {len(bins_with_data)}")

        # Create a new array to hold the weights, initialized with NaN
        weights = np.full(num_bins, np.nan)

        # Assign weights only to the non-empty bins
        weights[bins_with_data] = balanced_weights[bins_with_data]

        # Check if the balanced weights array has the same length as the number of non-empty bins
        if len(balanced_weights) != len(bins_with_data):
            print("Warning: The number of balanced weights does not match the number of non-empty bins.")
            # Adjust this part as per your requirements

        # Add the balanced weights to the .cool file
        if 'weight' in h5['bins']:
            del h5['bins']['weight']
        h5['bins'].create_dataset('weight', data=weights)

    print("Balanced weights added successfully.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Add balanced weights from a bedpe file to a cool file.")
    parser.add_argument("-c", "--cool", type=str, help="Path to the cool file.")
    parser.add_argument("-b", "--bedpe", type=str, help="Path to the bedpe file with balanced weights.")

    args = parser.parse_args()

    if args.cool is None or args.bedpe is None:
        parser.print_help(sys.stderr)
        sys.exit(1)

    add_balanced_weights(args.cool, args.bedpe)
