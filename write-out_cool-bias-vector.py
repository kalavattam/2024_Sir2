#!/usr/bin/env python3

import cooler
import argparse
import pandas as pd
import sys
import gzip

def extract_bias_vector(cool_file, output_file):
    try:
        # Load the cool file
        c = cooler.Cooler(cool_file)
    except Exception as e:
        print(f"Error loading cool file: {e}")
        return

    #  Extract the bins data which includes the bias vector
    bins = c.bins()[:]

    #  Filter the DataFrame to keep only the necessary columns
    bias_data = bins[['chrom', 'start', 'weight']]

    #  Drop any rows that have NaN values in the 'weight' column
    bias_data = bias_data.dropna(subset=['weight'])

    try:
        # Check if the output file should be gzipped
        if output_file.endswith('.gz'):
            with gzip.open(output_file, 'wt') as f:
                bias_data.to_csv(f, sep='\t', header=False, index=False)
        else:
            bias_data.to_csv(output_file, sep='\t', header=False, index=False)
            
        print(f"Bias vector has been saved to {output_file}")
    except Exception as e:
        print(f"Error writing to output file: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract bias vector from a balanced cool file.")
    parser.add_argument("-i", "--input", required=True, help="Path to the input cool file.")
    parser.add_argument("-o", "--output", required=True, help="Path to the output bias vector file.")
    
    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)

    args = parser.parse_args()
    extract_bias_vector(args.input, args.output)
