
<a id="4-perform-kr-balancing-matrices-with-fanc-hic---filter-low-coverage-relative 0.3-mode"></a>
### 4. Perform KR balancing matrices with `fanc hic` `--filter-low-coverage-relative 0.3` mode
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: 4. Perform KR balancing matrices with `fanc hic` `--filter-low-coverage-relative 0.3` mode</i></summary>

```bash
#!/bin/bash

cd ${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/09_fanc_XII_low-coverage-30 ||
    echo "cd'ing failed; check on this"

threads=1
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 6400 12800
)

check_array=TRUE
[[ ${check_array} ]] && echo_test "${res[@]}" || true
    
for j in "${res[@]}"; do
    # j="${res[9]}"
    
    XII_Q_down="$(
        find . -name MC-2019_Q_*.${j}.downsample-*.hic
    )"  # echo "${XII_Q_down}"
    XII_G1_down="$(
        find . -name MC-2020_30C-a15_*.${j}.downsample-*.hic
    )"  # echo "${XII_G1_down}"
    XII_G2M_down="$(
        find . -name MC-2020_nz_*.${j}.downsample-*.hic
    )"  # echo "${XII_G2M_down}"

    unset downsample && typeset -a downsample=(
        "${XII_Q_down}"
        "${XII_G1_down}"
        "${XII_G2M_down}"
    )
    
    check_array=FALSE
    [[ ${check_array} ]] && echo_test "${downsample[@]}" || true

    check_command=FALSE
    [[ ${check_command} == TRUE ]] &&
        {
            for i in "${downsample[@]}"; do
                echo """
                fanc hic \\
                    ${i} \\
                    --marginals-plot ${i/.hic/.marginals.pdf}
                """
                sleep 0.2
            done
        }

    run_command=FALSE
    [[ ${run_command} == TRUE ]] &&
        {
            for i in "${downsample[@]}"; do
                fanc hic \
                    ${i} \
                    --marginals-plot ${i/.hic/.marginals.pdf}

                sleep 0.2
            done
        }

    check_jobs=TRUE
    [[ ${check_jobs} == TRUE ]] &&
        {
            for i in "${downsample[@]}"; do
                job_name="balance.$(basename ${i} .hic)"
                threads=1

                echo """
                #HEREDOC
                sbatch << EOF
                #!/bin/bash

                #SBATCH --job-name="${job_name}"
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=${threads}
                #SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
                #SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

                fanc hic \\
                    ${i} \\
                    --filter-low-coverage-relative 0.3 \\
                    --normalise
                EOF
                """
                sleep 0.2
            done
        }

    submit_jobs=TRUE
    [[ ${submit_jobs} == TRUE ]] &&
        {
            for i in "${downsample[@]}"; do
                job_name="balance.$(basename ${i} .hic)"
                threads=1

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

fanc hic \
    ${i} \
    --filter-low-coverage-relative 0.3 \
    --normalise
EOF
                sleep 0.2
            done
        }
done
```
</details>
<br />

<a id="5-draw-example-plots-of-the-above-processed-hic-files"></a>
### 5. Draw example plots of the above-processed `.hic` files
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Step 5. Draw example plots of the above-processed `.hic` files</i></summary>

```bash
#!/bin/bash

[[ ! -d ../pngs/2023-1011 ]] && mkdir ../pngs/2023-1011 || true

outdir="../pngs/2023-1011"
j=6400

XII_Q_down="$(
    find . -name MC-2019_Q_*.${j}.downsample-*.hic
)"  # echo "${XII_Q_down}"
XII_G1_down="$(
    find . -name MC-2020_30C-a15_*.${j}.downsample-*.hic
)"  # echo "${XII_G1_down}"
XII_G2M_down="$(
    find . -name MC-2020_nz_*.${j}.downsample-*.hic
)"  # echo "${XII_G2M_down}"

unset downsample && typeset -a downsample=(
    "${XII_Q_down}"
    "${XII_G1_down}"
    "${XII_G2M_down}"
)

check_array=TRUE
[[ ${check_array} ]] && echo_test "${downsample[@]}" || true

#  XII, Log_e-transformed, 10E-4 min, 10E1 max, balanced
for i in "${downsample[@]}"; do
    fancplot \
        -o "${outdir}/$(basename ${i} .hic).log-bal.pdf" \
        "XII:1-1078177" \
        -p triangular -l -vmin 0.00031623 -vmax 1 \
        --title "6400 bp, XII" \
        -c Reds \
        "${i}"
done

#  XII, Log_e-transformed, 1 min, 1000 max, uncorrected
for i in "${downsample[@]}"; do
    fancplot \
        -o "${outdir}/$(basename ${i} .hic).log-unbal.pdf" \
        "XII:1-1078177" \
        -p triangular -u -l -vmin 1 -vmax 5000 \
        --title "6400 bp, XII" \
        -c Reds \
        "${i}"
done
```
</details>
<br />

```python
#!/usr/bin/env python3

import os
import fanc
import fanc.hic
import numpy as np
os.system('clear')

#  Load the .hic files
hic_files = ["Q.hic", "G1.hic", "G2.hic"]
# hic_files = ["Q.un.hic", "G1.un.hic", "G2.un.hic"]
hics = {hic_file.split('.')[0]: fanc.load(hic_file, mode = 'a') for hic_file in hic_files}

#  Print file name and some information about each .hic file
run_check = True
if run_check:
    for filename, hic in hics.items():
        print("\n" + "="*40 + "\n")  # This prints a separator between files
        print(f"File: {filename}")
        print(f"Matrix size: {hic.matrix().shape}")
        print(f"Sum of contacts: {np.nansum(hic.matrix())}")


### TEST: begin ###
os.system('clear')

#  Initialize variables for each Hic object
hic_Q = hics['Q']
hic_G1 = hics['G1']
hic_G2 = hics['G2']
# hic_Q.close()
# hic_G1.close()
# hic_G2.close()


consolidated = np.loadtxt('consolidated.txt').astype(bool)
# type(consolidated)

# hic_Q.matrix(norm=False, mask=True).data
#
# test = np.ma.masked_array(
#     hic_Q.matrix(norm=False, mask=True).data,
#     mask=consolidated
# )

# type(hic_Q.matrix(norm=False, mask=True).mask)
# type(consolidated)
# consolidated
#
# hic_Q.matrix(norm=False, mask=True).mask
# hic_Q.matrix(norm=False, mask=True).mask = consolidated
# hic_Q.matrix(norm=False, mask=True).mask
#
# hic_Q.matrix(norm=False)


#  Initialize variables for each Hic object matrix
matrix_Q = hic_Q.matrix(norm=False, mask=True)
matrix_G1 = hic_G1.matrix(norm=False, mask=True)
matrix_G2 = hic_G2.matrix(norm=False, mask=True)

matrix_Q = np.ma.masked_array(matrix_Q, mask=consolidated)
matrix_G1 = np.ma.masked_array(matrix_G1, mask=consolidated)
matrix_G2 = np.ma.masked_array(matrix_G2, mask=consolidated)

# #  Initialize variables for each Hic matrix mask
# mask_Q = matrix_Q.mask
# mask_G1 = matrix_G1.mask
# mask_G2 = matrix_G2.mask

# #  Initialize variables for Hic matrix data
# data_Q = matrix_Q.data
# data_G1 = matrix_G1.data
# data_G2 = matrix_G2.data


# #  Combine/consolidate the masks
# consolidated = np.logical_or.reduce((mask_Q, mask_G1, mask_G2))
# consolidated = np.loadtxt('consolidated.txt').astype(bool)

# print_arrays = False
# if print_arrays:
#     np.savetxt('mask_Q.txt', mask_Q, fmt='%d')
#     np.savetxt('mask_G1.txt', mask_G1, fmt='%d')
#     np.savetxt('mask_G2.txt', mask_G2, fmt='%d')
#     np.savetxt('consolidated.txt', consolidated, fmt='%d')

# #  Apply the combined/consolidated mask to each matrix
# matrix_Q.mask = consolidated
# matrix_G1.mask = consolidated
# matrix_G2.mask = consolidated

#  Apply the newly masked unbalanced matrices to the Hic objects
# hic_Q.matrix = np.ma.masked_array(matrix_Q.data, mask=consolidated)
# hic_G1.matrix = np.ma.masked_array(matrix_G1.data, mask=consolidated)
# hic_G2.matrix = np.ma.masked_array(matrix_G2.data, mask=consolidated)

ma_Q = np.ma.masked_array(matrix_Q.data, mask=consolidated)
ma_G1 = np.ma.masked_array(matrix_G1.data, mask=consolidated)
ma_G2 = np.ma.masked_array(matrix_G2.data, mask=consolidated)

hic_Q.add_contacts()

for edge in hic_Q.edges("XII"):
    print(edge.source_region)
    print(edge.sink_region)

hic_Q.matrix(norm=False, mask=True) = ma_Q
hic_G1.matrix(norm=False, mask=True) = ma_G1
hic_G2.matrix(norm=False, mask=True) = ma_G2

hic_Q.matrix(norm=False, mask=True)

fanc.hic.Hic.close(hic_Q)
fanc.hic.Hic.close(hic_G1)
fanc.hic.Hic.close(hic_G2)

fanc.hic.Hic.close(hics['Q'])
fanc.hic.Hic.close(hics['G1'])
fanc.hic.Hic.close(hics['G2'])

#  Perform KR balancing on the updated Hic objects
def kr_balancing_updated(hic, whole_matrix=True, intra_chromosomal=True, inter_chromosomal=True, restore_coverage=False):
    if not whole_matrix:
        bias_vectors = []
        for chromosome in hic.chromosomes():
            m = hic.matrix((chromosome, chromosome), norm=False)
            m_corrected, bias_vector_chromosome = correct_matrix(m, restore_coverage=restore_coverage)
            bias_vectors.append(bias_vector_chromosome)
        bias_vector = np.concatenate(bias_vectors)
    else:
        m = hic.matrix(norm=False)
        cb = hic.chromosome_bins
        if not intra_chromosomal:
            for chromosome, bins in cb.items():
                m[bins[0]:bins[1], bins[0]:bins[1]] = 0
        if not inter_chromosomal:
            for chromosome, bins in cb:
                m[0:bins[0], bins[0]:bins[1]] = 0
                m[bins[1]:, bins[0]:bins[1]] = 0
        m_corrected, bias_vector = correct_matrix(m, restore_coverage=restore_coverage)
    hic.region_data('bias', bias_vector)
    return bias_vector

type(hic_Q)
hic_Q.matrix(norm=False)
kr_balancing_updated(hic_Q)
fanc.hic.kr_balancing(hic_Q)
fanc.hic.kr_balancing(hic_G1)
fanc.hic.kr_balancing(hic_G2)

### TEST: end ###

#  Identify NaN and low-coverage bins
nan_bins = set()
low_coverage_bins = set()

#NOTE Even with norm=False, I believe we're still accessing the balanced values; how to address this?
marginals = np.nansum(matrix, axis=0)  # Calculate marginals from uncorrected matrix
nan_bins.update(np.where(np.isnan(marginals))[0])  # Identify NaN bins
median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])  # Identify low-coverage bins; use nanmedian() to ignore NaNs
threshold = 0.1 * median_coverage
low_coverage = np.where(marginals < threshold)[0]
low_coverage_bins.update(low_coverage)
### TEST: end ###

for hic in hics:
    matrix = hic.matrix(norm=False, mask=False)  # Access uncorrected matrix
    marginals = np.nansum(matrix, axis=0)  # Calculate marginals from uncorrected matrix
    nan_bins.update(np.where(np.isnan(marginals))[0])  # Identify NaN bins
    median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])  # Identify low-coverage bins; use nanmedian() to ignore NaNs
    threshold = 0.1 * median_coverage
    low_coverage = np.where(marginals < threshold)[0]
    low_coverage_bins.update(low_coverage)


#  Combine NaN and low-coverage bins
combined_bins = nan_bins.union(low_coverage_bins)



# Function to print specific bin values
def print_bin_values(hics, combined_bins):
    for i, hic in enumerate(hics):
        matrix = hic.matrix(norm=False, as_pixels=True, join_regions=False)
        print(f"Hi-C matrix {i+1}:")
        for bin_index in combined_bins:
            print(f"  Bin {bin_index} value before: {matrix[bin_index, bin_index]}")

# Print bin values before setting to NaN
print("Before setting to NaN:")
print_bin_values(hics, combined_bins)

# Set the values of the combined bins to NaN in each Hi-C object and print the matrix
for i, hic in enumerate(hics):
    matrix = hic.matrix(norm=False, as_pixels=True, join_regions=False)  # Access uncorrected matrix as pixels
    print(f"\nHi-C matrix {i+1} before setting to NaN:")
    print(matrix)    
    for bin_index in combined_bins:
        matrix[:, bin_index] = np.nan  # Set the values of the bin to NaN
        matrix[bin_index, :] = np.nan  # Do this for both rows and columns to ensure the entire bin is NaN
    print(f"\nHi-C matrix {i+1} after setting to NaN:")
    print(matrix)

# Print bin values after setting to NaN
print("\nValues of specific bins after setting to NaN:")
print_bin_values(hics, combined_bins)



# Check marginals for Q, G1, and G2
run_check = True
if run_check:
    for hic in hics:
        matrix = hic.matrix(norm=False)  # Access uncorrected matrix
        marginals = np.nansum(matrix, axis=0)  # Calculate marginals from uncorrected matrix
        print(f"Marginals for {hic.name if hasattr(hic, 'name') else 'Hi-C matrix'}: {marginals}")

run_check = True
if run_check:
    for result in results:
        print("\n" + "="*40 + "\n")  # This prints a separator between iterations
        print(f"Marginals: {result['marginals']}")
        print(f"Median coverage: {result['median_coverage']}")
        print(f"Threshold: {result['threshold']}")
        print(f"Low coverage bins: {result['low_coverage']}")
        print(f"Low coverage bins set: {result['low_coverage_bins']}")



#  Mask low-coverage bins in each matrix
# for hic in hics:
#     hic.mask_bins(low_coverage_bins)

for hic in hics:
    for bin_index in combined_bins:
        hic._mask(bin_index)  # Mask each bin individually


#  Proceed with KR balancing
for hic in hics:
    hic.balance()
```
</details>
<br />

<details>
<summary><i>Code: Scraps/temporary bits for the above...</i></summary>

```python
#!usr/bin/env python3

#  Calculate marginals and identify low-coverage and bins with NaN values
nan_bins = set()
low_coverage_bins = set()
results = []  # Create a list to hold the dictionaries
for hic in hics:
    matrix = hic.matrix(norm=False)  # Access uncorrected matrix
    marginals = np.nansum(matrix, axis=0)  # Calculate marginals from uncorrected matrix
    if np.ma.isMaskedArray(marginals):  #  Check if marginals is a masked array
        print("Marginals is a masked array, converting to regular array.")
        marginals = np.ma.filled(marginals, np.nan)  # Convert to regular numpy array
    nan_bins.update(np.where(np.isnan(marginals))[0])  #  Identify bins with NaN values and add their indices to the nan_bins set
    median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])  # Use nanmedian() to ignore NaNs
    threshold = 0.1 * median_coverage
    low_coverage = np.where(marginals < threshold)[0]
    low_coverage_bins.update(low_coverage)
    results.append({  # Store the results in a dictionary and append to the list
        "marginals": marginals,
        "median_coverage": median_coverage,
        "threshold": threshold,
        "low_coverage": low_coverage,
        "low_coverage_bins": low_coverage_bins.copy(),  # Use copy to store the state at this iteration
        "nan_bins": nan_bins.copy()  # Store the state of nan_bins at this iteration
    })

#  Create vector comprised of both low-coverage and NaN bins
combined_bins = low_coverage_bins.union(nan_bins)

#  Mask bins with NaN values in each matrix
for hic in hics:
    hic.mask_bins(nan_bins)


for hic in hics:
    matrix = hic.matrix(norm=False)  # Access uncorrected matrix
    marginals = np.nansum(matrix, axis=0)  # Calculate marginals from uncorrected matrix
    median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])  # Use nanmedian() to ignore NaNs
    threshold = 0.1 * median_coverage
    low_coverage = np.where(marginals < threshold)[0]
    low_coverage_bins.update(low_coverage)
    results.append({  # Store the results in a dictionary and append to the list
        "marginals": marginals,
        "median_coverage": median_coverage,
        "threshold": threshold,
        "low_coverage": low_coverage,
        "low_coverage_bins": low_coverage_bins.copy()  # Use copy to store the state at this iteration
    })
    # marginals = hic.marginals()
    # marginals = np.ma.filled(marginals, np.nan)  # Convert from masked array to NumPy array
    # median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])  # Use nanmedian() to ignore NaNs
    # threshold = 0.1 * median_coverage
    # low_coverage = np.where(marginals < threshold)[0]
    # low_coverage_bins.update(low_coverage)
    # results.append({  # Store the results in a dictionary and append to the list
    #     "marginals": marginals,
    #     "median_coverage": median_coverage,
    #     "threshold": threshold,
    #     "low_coverage": low_coverage,
    #     "low_coverage_bins": low_coverage_bins.copy()  # Use copy to store the state at this iteration
    # })


#  Calculate marginals and identify low-coverage bins
low_coverage_bins = set()
results = []  # Create a list to hold the dictionaries
for hic in hics:
    matrix = hic.matrix(norm=False)                                      # Access uncorrected matrix
    marginals = np.nansum(matrix, axis=0)                                   # Calculate marginals from uncorrected matrix
    if np.ma.isMaskedArray(marginals):                                      # Check if marginals is a masked array
        print("Marginals is a masked array, converting to regular array.")
        marginals = np.ma.filled(marginals, np.nan)                         # Convert to regular numpy array
    median_coverage = np.nanmedian(marginals[np.nonzero(marginals)])        # Use nanmedian() to ignore NaNs
    threshold = 0.1 * median_coverage
    low_coverage = np.where(marginals < threshold)[0]
    low_coverage_bins.update(low_coverage)
    results.append({                                                        # Store the results in a dictionary and append to the list
        "marginals": marginals,
        "median_coverage": median_coverage,
        "threshold": threshold,
        "low_coverage": low_coverage,
        "low_coverage_bins": low_coverage_bins.copy()                       # Use copy to store the state at this iteration
    })
```
</details>
<br />
