#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright 2023 Kris Alavattam <kalavattam@gmail.com>
# Usage: get_fanc-matrix-size.py
# Description: This script is used to determine the size of the contact matrix
# from a given FAN-C Hi-C data file. It checks if the file exists and is 
# readable, and then uses the FAN-C library to load the Hi-C data and print the
# size of the contact matrix to stdout.
#
# Distributed under terms of the MIT license.

import sys
import os
import fanc
import argparse

def get_matrix_size(file_path):
    if not os.path.exists(file_path):
        print(f"Error: The file '{file_path}' does not exist.")
        sys.exit(1)

    if not os.path.isfile(file_path):
        print(f"Error: '{file_path}' is not a file.")
        sys.exit(1)

    try:
        # Load the Hi-C object
        hic = fanc.load(file_path)

        # Get the size of the matrix
        matrix_size = hic.matrix().shape
        print(f"Matrix Size: {matrix_size}")

    except Exception as e:
        print(f"Error: Unable to process the file. {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Get the size of the Hi-C contact matrix.")
    parser.add_argument("file_path", help="Path to the Hi-C data file.")

    args = parser.parse_args()
    get_matrix_size(args.file_path)
