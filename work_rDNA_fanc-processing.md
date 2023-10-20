
`#work_rDNA_fanc-processing.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [0. Pre-work](#0-pre-work)
    1. [A. Strategy](#a-strategy)
        1. [Notes](#notes)
    1. [B. Get situated](#b-get-situated)
        1. [Code](#code)
    1. [C. Initialize variables for infiles, converted files](#c-initialize-variables-for-infiles-converted-files)
        1. [Code](#code-1)
1. [1. Use `fanc to-fanc` to convert `07_cload/` `.cool` files to FAN-C `.hic` files](#1-use-fanc-to-fanc-to-convert-07_cload-cool-files-to-fan-c-hic-files)
    1. [Code](#code-2)
1. [2. Create binned, unbalanced FAN-C `.hic` files](#2-create-binned-unbalanced-fan-c-hic-files)
    1. [Code](#code-3)
1. [3. Downsample Q, G1, G2/M `.hic` files to smallest matrix](#3-downsample-q-g1-g2m-hic-files-to-smallest-matrix)
    1. [A. Draft `Python` code that dynamically handles the matrix subsampling](#a-draft-python-code-that-dynamically-handles-the-matrix-subsampling)
        1. [Code](#code-4)
    1. [B. Convert above test code to `Python` script](#b-convert-above-test-code-to-python-script)
        1. [Code](#code-5)
    1. [C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` matrices](#c-submit-python-script-calculate_fanc-contact-sumspy-for-resolution-wise-trios-of-hic-matrices)
        1. [Code](#code-6)
1. [4. Perform KR balancing matrices with `fanc hic` `--filter-low-coverage-relative "${thresh}"` mode](#4-perform-kr-balancing-matrices-with-fanc-hic---filter-low-coverage-relative-%24thresh-mode)
    1. [Code](#code-7)
1. [5. Create subsetted `.hic` matrices for the rDNA left array](#5-create-subsetted-hic-matrices-for-the-rdna-left-array)
    1. [Code](#code-8)
1. [6. Convert `.hic` matrices to `.cool` matrices](#6-convert-hic-matrices-to-cool-matrices)
    1. [Code](#code-9)
1. [7. Run HiCExplorer `hicCompareMatrices`](#7-run-hicexplorer-hiccomparematrices)
    1. [Code](#code-10)
1. [8. Draw whole-genome "square" plots of negative log-transformed counts](#8-draw-whole-genome-square-plots-of-negative-log-transformed-counts)
    1. [Strategy](#strategy)
        1. [Notes](#notes-1)
    1. [Run HiCExplorer `plotHicMatrix` for negative log-transformed heatmaps](#run-hicexplorer-plothicmatrix-for-negative-log-transformed-heatmaps)
        1. [Code](#code-11)
    1. [Run HiCExplorer `plotHicMatrix` for log2 ratio heatmaps](#run-hicexplorer-plothicmatrix-for-log2-ratio-heatmaps)
        1. [Code](#code-12)
1. [9. Draw contact-decay plots for rDNA region](#9-draw-contact-decay-plots-for-rdna-region)
    1. [Call HiCExplorer `hicPlotDistVsCounts`](#call-hicexplorer-hicplotdistvscounts)
        1. [Code](#code-13)
    1. [Wrangle contact-decay table output by `hicPlotDistVsCounts`](#wrangle-contact-decay-table-output-by-hicplotdistvscounts)
        1. [Code](#code-14)
1. [X. Documentation \(partial\)](#x-documentation-partial)
    1. [Notes](#notes-2)
        1. [`fanc to-fanc --help`](#fanc-to-fanc---help)
        1. [`fanc hic --help`](#fanc-hic---help)
        1. [`fanc downsample --help`](#fanc-downsample---help)
        1. [`fancplot -p square --help`](#fancplot--p-square---help)
        1. [`fanc to-cooler --help`](#fanc-to-cooler---help)
        1. [`fanc subset --help`](#fanc-subset---help)
        1. [`hicPlotMatrix --help`](#hicplotmatrix---help)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="0-pre-work"></a>
### 0. Pre-work
<a id="a-strategy"></a>
#### A. Strategy
<a id="notes"></a>
##### Notes
<details>
<summary><i>Notes: 0.A. Strategy</i></summary>

```txt
1. Use `fanc to-fanc` to convert 07_cload .cool files to FAN-C .hic files
    A.    Q: Q repM mapped
    B.   G1: 30C-a15 repM mapped
    C. G2/M: nz repM mapped
2. Create unbalanced .hic files comprised solely of...
    A. XII
    B. whole genome
    C. ...
3. Downsample the Q, G1, and G2/M XII .hic files to the smallest of the three contact-matrix sums
4. Balance the matrices `fanc hic --filter-low-coverage-relative --statistics path/to/save/file.txt --statistics-plot path/to/save/file.pdf --normalise --norm-method "KR" path/to/output/file.hic`
```
</details>
<br />

<a id="b-get-situated"></a>
#### B. Get situated
<a id="code"></a>
##### Code
<details>
<summary><i>Code: 0.B. Get situated</i></summary>

```bash
#!/bin/bash

[[ ${CONDA_DEFAULT_ENV} != fanc_pip_env ]] &&
    source activate fanc_pip_env ||
    true

cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    echo "cd'ing failed; check on this"

[[ ! -d 09_fanc_XII ]] &&
    mkdir -p 09_fanc_XII/err_out ||
    true

[[ ! -d 09_fanc_genome ]] &&
    mkdir -p 09_fanc_genome/err_out ||
    true
```
</details>
<br />

<a id="c-initialize-variables-for-infiles-converted-files"></a>
#### C. Initialize variables for infiles, converted files
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: 0.C. Initialize variables for infiles, converted files</i></summary>

```bash
#!/bin/bash

  d_cool="07_cload"
  cool_Q="${d_cool}/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.cool"
 cool_G1="${d_cool}/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.cool"
cool_G2M="${d_cool}/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.cool"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          d_cool  ${d_cool}
          cool_Q  ${cool_Q}
         cool_G1  ${cool_G1}
        cool_G2M  ${cool_G2M}
        """

        ., ${cool_Q}
        ., ${cool_G1}
        ., ${cool_G2M}
    } || true

  d_XII="09_fanc_XII"
  XII_Q="${d_XII}/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.hic"
 XII_G1="${d_XII}/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.hic"
XII_G2M="${d_XII}/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.hic"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          d_XII  ${d_XII}
          XII_Q  ${XII_Q}
         XII_G1  ${XII_G1}
        XII_G2M  ${XII_G2M}
        """

        ., ${d_XII}
    } || true

  d_gen="09_fanc_genome"
  gen_Q="${d_gen}/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.hic"
 gen_G1="${d_gen}/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.hic"
gen_G2M="${d_gen}/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.hic"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          d_XII  ${d_gen}
          XII_Q  ${gen_Q}
         XII_G1  ${gen_G1}
        XII_G2M  ${gen_G2M}
        """

        ., ${d_XII}
    } || true
```
</details>
<br />

<a id="1-use-fanc-to-fanc-to-convert-07_cload-cool-files-to-fan-c-hic-files"></a>
### 1. Use `fanc to-fanc` to convert `07_cload/` `.cool` files to FAN-C `.hic` files
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: 1. Use `fanc to-fanc` to convert `07_cload/` `.cool` files to FAN-C `.hic` files</i></summary>

```bash
#!/bin/bash

check_test_command=FALSE
[[ ${check_test_command} == TRUE ]] &&
    {
        [[ -f ${cool_Q} && ! -f ${XII_Q} ]] &&
            {
                echo """
                fanc from-cooler \\
                    ${cool_Q} \\
                    ${XII_Q}
                """
            } || echo "Warning: Did not run command; check in/outfiles."
    } || true

run_test_command=FALSE
[[ ${run_test_command} == TRUE ]] &&
    {
        [[ -f ${cool_Q} && ! -f ${XII_Q} ]] &&
            {
                fanc from-cooler \
                    ${cool_Q} \
                    ${XII_Q}
            } || echo "Warning: Did not run command; check in/outfiles."
    } || true

#  Initialize associative array that pairs in- with outfiles
unset conversion && typeset -A conversion
conversion["${cool_Q}"]="${XII_Q}; ${gen_Q}"
conversion["${cool_G1}"]="${XII_G1}; ${gen_G1}"
conversion["${cool_G2M}"]="${XII_G2M}; ${gen_G2M}"

check_array=TRUE
[[ ${check_array} == TRUE ]] &&
    {
        for i in "${!conversion[@]}"; do
            # [[ -f ${i} && ! -f ${conversion[${i}]} ]] &&
            #    {
                    echo """
                          key (cool)  ${i}
                    value (hic, XII)  $(echo ${conversion[${i}]} | awk -F '; ' '{ print $1 }')
                    value (hic, gen)  $(echo ${conversion[${i}]} | awk -F '; ' '{ print $2 }')
                    """
            #    } ||
            #     {
            #         echo "Warning: Did not run command; check infile ${i}"
            #         echo "         and/or outfile ${conversion[${i}]}."
            #     }
        done
    } || true

check_jobs=TRUE
[[ ${check_jobs} == TRUE ]] &&
    {
        iter=0
        for i in "${!conversion[@]}"; do
            XII=$(echo ${conversion[${i}]} | awk -F '; ' '{ print $1 }')
            gen=$(echo ${conversion[${i}]} | awk -F '; ' '{ print $2 }')

            (( iter++ ))
            [[ -f ${i} && ! -f ${XII} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
                    threads=1
                    
                    echo """
                    ### ${iter} ###

                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name="${job_name}"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

                    fanc from-cooler \\
                        ${i} \\
                        ${XII}
                    EOF
                    """
                    sleep 0.2
                } ||
                {
                    echo "Warning: Did not run command; check infile ${i}"
                    echo "         and/or outfile ${conversion[${i}]}."
                }
                
                (( iter++ ))
                [[ -f ${i} && ! -f ${gen} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
                    threads=1
                    
                    echo """
                    ### ${iter} ###

                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name="${job_name}"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_gen}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_gen}/err_out/${job_name}.%A.stdout.txt"

                    fanc from-cooler \\
                        ${i} \\
                        ${gen}
                    EOF
                    """
                    sleep 0.2
                } ||
                {
                    echo "Warning: Did not run command; check infile ${i}"
                    echo "         and/or outfile ${conversion[${i}]}."
                }
        done
    }

submit_jobs=TRUE
[[ ${submit_jobs} == TRUE ]] &&
    {
        iter=0
        for i in "${!conversion[@]}"; do
            XII=$(echo ${conversion[${i}]} | awk -F '; ' '{ print $1 }')
            gen=$(echo ${conversion[${i}]} | awk -F '; ' '{ print $2 }')

            (( iter++ ))
            [[ -f ${i} && ! -f ${XII} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
                    threads=1
                    
                    echo "### ${iter} ###"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

fanc from-cooler \
    ${i} \
    ${XII}
EOF
                    sleep 0.2
                } ||
                {
                    echo "Warning: Did not run command; check infile ${i}"
                    echo "         and/or outfile ${conversion[${i}]}."
                }
                
                (( iter++ ))
                [[ -f ${i} && ! -f ${gen} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
                    threads=1
                    
                    echo "### ${iter} ###"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_gen}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_gen}/err_out/${job_name}.%A.stdout.txt"

fanc from-cooler \
    ${i} \
    ${gen}
EOF
                    sleep 0.2
                } ||
                {
                    echo "Warning: Did not run command; check infile ${i}"
                    echo "         and/or outfile ${conversion[${i}]}."
                }
        done
    }
```
</details>
<br />

<a id="2-create-binned-unbalanced-fan-c-hic-files"></a>
### 2. Create binned, unbalanced FAN-C `.hic` files
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: 2. Create binned, unbalanced FAN-C `.hic` files</i></summary>

```bash
#!/bin/bash

threads=4
unset chroms && typeset -a chroms=("XII" "gen")
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 5000 6400 12800
)

check_array=FALSE
[[ ${check_array} == TRUE ]] &&
    {
        echo_test "${res[@]}"
        echo ""
        
        echo_test "${chroms[@]}"
        echo ""
    } ||
    true

for k in "${chroms[@]}"; do
    iter=0
    if [[ "${k}" == "XII" ]]; then
        # k="gen"
        for j in "${res[@]}"; do
            # j=${res[10]}  # echo "${j}"

            unset Q_bin && typeset Q_bin="${XII_Q%.hic}.${j}.hic"        # echo "${Q_bin}"
            unset G1_bin && typeset G1_bin="${XII_G1%.hic}.${j}.hic"     # echo "${G1_bin}"
            unset G2M_bin && typeset G2M_bin="${XII_G2M%.hic}.${j}.hic"  # echo "${G2M_bin}"

            unset bin && typeset -A bin
            bin["${XII_Q}"]="${Q_bin}"
            bin["${XII_G1}"]="${G1_bin}"
            bin["${XII_G2M}"]="${G2M_bin}"

            check_array=FALSE
            [[ ${check_array} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        echo """
                        key (all, 25)  ${i}
                        value (${k}, ${j})  ${bin[${i}]}
                        """
                    done
                } || true

            check_jobs=TRUE
            [[ ${check_jobs} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        (( iter++ ))
                        [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                            {
                                job_name="bin.$(basename ${bin[${i}]} .hic)"

                                echo """
                                ### ${iter} ###

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
                                    ${bin[${i}]} \\
                                    --threads ${threads} \\
                                    --bin-size ${j} \\
                                    --chromosomes \"${k}\"
                                EOF
                                """
                                sleep 0.2
                            } ||
                            {
                                echo "Warning: Did not run command; check infile ${i}"
                                echo "         and/or outfile ${bin[${i}]}."
                            }
                    done
                } || true

            submit_jobs=TRUE
            [[ ${submit_jobs} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        (( iter++ ))
                        [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                            {
                                job_name="bin.$(basename ${bin[${i}]} .hic)"

                                echo "### ${iter} ###"

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
    ${bin[${i}]} \
    --threads ${threads} \
    --bin-size ${j} \
    --chromosomes "${k}"
EOF
                                sleep 0.2
                            } ||
                            {
                                echo "Warning: Did not run command; check infile ${i}"
                                echo "         and/or outfile ${bin[${i}]}."
                            }
                    done
                } || true
        done
    elif [[ "${k}" == "gen" ]]; then
        for j in "${res[@]}"; do
            # j=${res[10]}  # echo "${j}"

            unset Q_bin && typeset Q_bin="${gen_Q%.hic}.${j}.hic"        # echo "${Q_bin}"
            unset G1_bin && typeset G1_bin="${gen_G1%.hic}.${j}.hic"     # echo "${G1_bin}"
            unset G2M_bin && typeset G2M_bin="${gen_G2M%.hic}.${j}.hic"  # echo "${G2M_bin}"

            unset bin && typeset -A bin
            bin["${gen_Q}"]="${Q_bin}"
            bin["${gen_G1}"]="${G1_bin}"
            bin["${gen_G2M}"]="${G2M_bin}"

            check_array=FALSE
            [[ ${check_array} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        echo """
                        key (all, 25)  ${i}
                        value (${k}, ${j})  ${bin[${i}]}
                        """
                    done
                } || true

            check_jobs=TRUE
            [[ ${check_jobs} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        (( iter++ ))
                        [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                            {
                                job_name="bin.$(basename ${bin[${i}]} .hic)"

                                echo """
                                ### ${iter} ###

                                #HEREDOC
                                sbatch << EOF
                                #!/bin/bash

                                #SBATCH --job-name="${job_name}"
                                #SBATCH --nodes=1
                                #SBATCH --cpus-per-task=${threads}
                                #SBATCH --error="${d_gen}/err_out/${job_name}.%A.stderr.txt"
                                #SBATCH --output="${d_gen}/err_out/${job_name}.%A.stdout.txt"

                                fanc hic \\
                                    ${i} \\
                                    ${bin[${i}]} \\
                                    --threads ${threads} \\
                                    --bin-size ${j}
                                EOF
                                """
                                sleep 0.2
                            } ||
                            {
                                echo "Warning: Did not run command; check infile ${i}"
                                echo "         and/or outfile ${bin[${i}]}."
                            }
                    done
                } || true

            submit_jobs=TRUE
            [[ ${submit_jobs} == TRUE ]] &&
                {
                    for i in "${!bin[@]}"; do
                        (( iter++ ))
                        [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                            {
                                job_name="bin.$(basename ${bin[${i}]} .hic)"

                                echo "### ${iter} ###"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_gen}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_gen}/err_out/${job_name}.%A.stdout.txt"

fanc hic \
    ${i} \
    ${bin[${i}]} \
    --threads ${threads} \
    --bin-size ${j}
EOF
                                sleep 0.2
                            } ||
                            {
                                echo "Warning: Did not run command; check infile ${i}"
                                echo "         and/or outfile ${bin[${i}]}."
                            }
                    done
                } || true
        done
    fi
done
```
</details>
<br />

<a id="3-downsample-q-g1-g2m-hic-files-to-smallest-matrix"></a>
### 3. Downsample Q, G1, G2/M `.hic` files to smallest matrix
<a id="a-draft-python-code-that-dynamically-handles-the-matrix-subsampling"></a>
#### A. Draft `Python` code that dynamically handles the matrix subsampling
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: A. Draft `Python` code that dynamically handles the matrix subsampling</i></summary>

```python
#!/usr/bin/env python3

import sys
import os
import fanc
import numpy as np

seed = 24
Q_file = "09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.hic"
G1_file = "09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.hic"
G2_file = "09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.hic"


def calculate_contact_sum(hic_file):
    hic = fanc.load(hic_file)
    contact_sum = 0
    for value in hic.edge_data(hic._default_score_field, lazy=True):
        if np.isfinite(value):
            contact_sum += value
    return contact_sum, hic


sum_Q, hic_Q = calculate_contact_sum(Q_file)
sum_G1, hic_G1 = calculate_contact_sum(G1_file)
sum_G2, hic_G2 = calculate_contact_sum(G2_file)

print(f" Q contact sum: {str(sum_Q)}")
print(f"G1 contact sum: {str(sum_G1)}")
print(f"G2 contact sum: {str(sum_G2)}")

# Determine the smallest sum and downsample the other two files
sums = {'Q': sum_Q, 'G1': sum_G1, 'G2': sum_G2}
min_key = min(sums, key=sums.get)
min_value = sums[min_key]

print(f"Sample {min_key} has the smallest sum: {min_value}.")
print(f"Sample {min_key} will be used for random matrix subsampling without replacement.")

hic_Q.downsample(
    min_value,
    file_name = "09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"
)
hic_G1.downsample(
    min_value,
    file_name = "09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"
)
hic_G2.downsample(
    min_value,
    file_name = "09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"
)

#  Check on things...
Q_samp = "09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"
G1_samp = "09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"
G2_samp = "09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.downsample-test.hic"

sum_samp_Q, hic_samp_Q = calculate_contact_sum(Q_samp)
sum_samp_G1, hic_samp_G1 = calculate_contact_sum(G1_samp)
sum_samp_G2, hic_samp_G2 = calculate_contact_sum(G2_samp)

print(f"Downsampled  Q contact sum: {str(sum_samp_Q)}")
print(f"Downsampled G1 contact sum: {str(sum_samp_G1)}")
print(f"Downsampled G2 contact sum: {str(sum_samp_G2)}")
#  It works!
```
</details>
<br />

<a id="b-convert-above-test-code-to-python-script"></a>
#### B. Convert above test code to `Python` script
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: B. Convert above test code to `Python` script</i></summary>

```python
#!/usr/bin/env python3

#  See 2023-0307_work_Micro-C_align-process/calculate_fanc-contact-sums.py
```
</details>
<br />

<a id="c-submit-python-script-calculate_fanc-contact-sumspy-for-resolution-wise-trios-of-hic-matrices"></a>
#### C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` matrices
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` matrices</i></summary>

```bash
#!/bin/bash

python calculate_fanc-contact-sums.py -h
# ❯ python calculate_fanc-contact-sums.py -h
# usage: calculate_fanc-contact-sums.py [-h] -Q Q_INFILE -G1 G1_INFILE -G2 G2_INFILE [-s SEED] [--Q_outfile Q_OUTFILE] [--G1_outfile G1_OUTFILE] [--G2_outfile G2_OUTFILE]
#
# Calculate contact sums for Q, G1, and G2/M FAN-C .hic infiles and downsample the three .hic files to the file with the smallest sum.
#
# options:
#   -h, --help            show this help message and exit
#   -Q Q_INFILE, --Q_infile Q_INFILE
#                         Path and name for the Q FAN-C .hic infile <chr>
#   -G1 G1_INFILE, --G1_infile G1_INFILE
#                         Path and name for the G1 FAN-C .hic infile <chr>
#   -G2 G2_INFILE, --G2_infile G2_INFILE
#                         Path and name for the G2/M FAN-C .hic infile <chr>
#   -s SEED, --seed SEED  Seed for random number generation <int>
#   --Q_outfile Q_OUTFILE
#                         Path and name for the Q downsampled FAN-C .hic outfile; if not specified, then path and name is derived from corresponding infile <chr>
#   --G1_outfile G1_OUTFILE
#                         Path and name for the G1 downsampled FAN-C .hic outfile; if not specified, then path and name is derived from corresponding infile <chr>
#   --G2_outfile G2_OUTFILE
#                         Path and name for the G2/M downsampled FAN-C .hic outfile; if not specified, then path and name is derived from corresponding infile <chr>

d_XII="09_fanc_XII"
d_gen="09_fanc_genome"
threads=1
unset chroms && typeset -a chroms=("XII" "gen")
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 5000 6400 12800
)

check_array=TRUE
[[ ${check_array} == TRUE ]] &&
    {
        echo_test "${res[@]}"
        echo ""

        echo_test "${chroms[@]}"
        echo ""
    } || true

iter=0
for k in "${chroms[@]}"; do
    if [[ "${k}" == "XII" ]]; then
        unset dir && typeset dir="${d_XII}"
    elif [[ "${k}" == "gen" ]]; then
        unset dir && typeset dir="${d_gen}"
    fi

    for j in "${res[@]}"; do
        # j=${res[10]}  # echo "${j}"

        Q_bin="$( find ${dir} -name MC-2019_Q_*.${j}.hic )"         # echo "${Q_bin}"
        G1_bin="$( find ${dir} -name MC-2020_30C-a15_*.${j}.hic )"  # echo "${G1_bin}"
        G2M_bin="$( find ${dir} -name MC-2020_nz_*.${j}.hic )"      # echo "${G2M_bin}"

        check_files=FALSE
        [[ ${check_files} == TRUE ]] &&
            {
                ls -lhaFG "${Q_bin}"
                ls -lhaFG "${G1_bin}"
                ls -lhaFG "${G2M_bin}"
            } || true

        check_jobs=TRUE
        [[ ${check_jobs} == TRUE ]] &&
            {
                (( iter++ ))
                Q_out="${Q_bin%.hic}.downsample-to-G1.hic"      # echo "${Q_out}"
                G1_out="${G1_bin%.hic}.downsample-to-G1.hic"    # echo "${G1_out}"
                G2M_out="${G2M_bin%.hic}.downsample-to-G1.hic"  # echo "${G2M_out}"
                [[ 
                      -f ${Q_bin} &&   -f ${G1_bin} &&   -f ${G2M_bin} &&
                    ! -f ${Q_out} && ! -f ${G1_out} && ! -f ${G2M_out}
                ]] &&
                    {
                        job_name="downsample_files-hic-${j}"

                        echo """
                        ### ${iter} ###

                        #HEREDOC
                        sbatch << EOF
                        #!/bin/bash

                        #SBATCH --job-name=\"${job_name}\"
                        #SBATCH --nodes=1
                        #SBATCH --cpus-per-task=${threads}
                        #SBATCH --error=\"${dir}/err_out/${job_name}.%A.stderr.txt\"
                        #SBATCH --output=\"${dir}/err_out/${job_name}.%A.stdout.txt\"

                        python calculate_fanc-contact-sums.py \\
                            --Q_infile \"${Q_bin}\" \\
                            --G1_infile \"${G1_bin}\" \\
                            --G2_infile \"${G2M_bin}\"
                        EOF
                        """
                        sleep 0.2
                    } ||
                    {
                        echo """
                        Warning: Did not run command.

                        Check the following infiles, one or more of which may
                        not exist:
                            - ${Q_bin}
                            - ${G1_bin}
                            - ${G2M_bin}

                        Or check the following outfiles, one or more of which
                        may already exist:
                            - ${Q_out}
                            - ${G1_out}
                            - ${G2M_out}
                        """
                    }
            } || true

        submit_jobs=TRUE
        [[ ${submit_jobs} == TRUE ]] &&
            {
                (( iter++ ))
                Q_out="${Q_bin%.hic}.downsample-to-G1.hic"      # echo "${Q_out}"
                G1_out="${G1_bin%.hic}.downsample-to-G1.hic"    # echo "${G1_out}"
                G2M_out="${G2M_bin%.hic}.downsample-to-G1.hic"  # echo "${G2M_out}"
                [[ 
                      -f ${Q_bin} &&   -f ${G1_bin} &&   -f ${G2M_bin} &&
                    ! -f ${Q_out} && ! -f ${G1_out} && ! -f ${G2M_out}
                ]] &&
                    {
                        job_name="downsample_files-hic-${j}"

                        echo "### ${iter} ###"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${dir}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${dir}/err_out/${job_name}.%A.stdout.txt"

python calculate_fanc-contact-sums.py \
--Q_infile "${Q_bin}" \
--G1_infile "${G1_bin}" \
--G2_infile "${G2M_bin}"
EOF
                        sleep 0.2
                    } ||
                    {
                        echo """
                        Warning: Did not run command.

                        Check the following infiles, one or more of which may
                        not exist:
                            - ${Q_bin}
                            - ${G1_bin}
                            - ${G2M_bin}

                        Or check the following outfiles, one or more of which
                        may already exist:
                            - ${Q_out}
                            - ${G1_out}
                            - ${G2M_out}
                        """
                    }
            } || true
    done
done
```
</details>
<br />

<a id="4-perform-kr-balancing-matrices-with-fanc-hic---filter-low-coverage-relative-%24thresh-mode"></a>
### 4. Perform KR balancing matrices with `fanc hic` `--filter-low-coverage-relative "${thresh}"` mode
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: 4. Perform KR balancing matrices with `fanc hic` `--filter-low-coverage-relative "${thresh}"` mode</i></summary>

```bash
#!/bin/bash

#  Get situated
[[ ${CONDA_DEFAULT_ENV} != fanc_pip_env ]] &&
    source activate fanc_pip_env ||
    true

cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    echo "cd'ing failed; check on this"

unset filt && typeset -a filt=(
    # 0.2
    # 0.3
    # 0.4
    0.2_whole-matrix
    0.3_whole-matrix
    0.4_whole-matrix
)
for i in "${filt[@]}"; do
    if [[ ! "${i}" =~ "whole-matrix" ]]; then
        [[ ! -d 10_fanc_XII_KR-filt-${i} ]] &&
            mkrmr dir -p 10_fanc_XII_KR-filt-${i}/err_out ||
            true
    fi
    [[ ! -d 10_fanc_genome_KR-filt-${i} ]] &&
        mkdir -p 10_fanc_genome_KR-filt-${i}/err_out ||
        true
done

threads=1
# unset chroms && typeset -a chroms=("XII" "gen")
unset chroms && typeset chroms="gen"
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 5000 6400 12800
)

check_array=TRUE
[[ ${check_array} == TRUE ]] &&
    {
        echo_test "${filt[@]}"
        echo ""

        echo_test "${chroms[@]}"
        echo ""

        echo_test "${res[@]}"
        echo ""
    } || true


#  Copy over files to balance
iter=0
for j in "${chroms[@]}"; do
    if [[ "${j}" == "XII" ]]; then
        unset d_in && typeset d_in="09_fanc_XII"
        unset a_out && typeset -a a_out=(
            # "10_fanc_XII_KR-filt-0.2"
            # "10_fanc_XII_KR-filt-0.3"
            # "10_fanc_XII_KR-filt-0.4"
        )
    elif [[ "${j}" == "gen" ]]; then
        unset d_in && typeset d_in="09_fanc_genome"
        unset a_out && typeset -a a_out=(
            # "10_fanc_genome_KR-filt-0.2"
            # "10_fanc_genome_KR-filt-0.3"
            # "10_fanc_genome_KR-filt-0.4"
            "10_fanc_genome_KR-filt-0.2_whole-matrix"
            "10_fanc_genome_KR-filt-0.3_whole-matrix"
            "10_fanc_genome_KR-filt-0.4_whole-matrix"
        )
    fi

    check_things=FALSE
    [[ ${check_things} == TRUE ]] &&
        {
            echo "${d_in}"
            echo_test "${a_out[@]}"
            echo ""
        } || true

    for i in "${res[@]}"; do
        # i="${res[1]}"  # echo "${i}"
        
        unset a_hic && typeset -a a_hic
        while IFS=" " read -r -d $'\0'; do
            a_hic+=( "${REPLY}" )
        done < <(
            find "${d_in}" \
                -maxdepth 1 \
                -type f \
                -name MC-*.mapped.${i}.downsample-*.hic \
                -print0 \
                    | sort -z
        )

        check_things=FALSE
        [[ ${check_things} == TRUE ]] &&
            {
                echo "${d_in}"
                echo ""
                
                echo_test "${a_out[@]}"
                echo ""
                
                echo_test "${a_hic[@]}"
                echo ""
            } || true

        for h in "${a_hic[@]}"; do
            for g in "${a_out[@]}"; do
                (( iter++ ))
                echo "iter ${iter}: cp -f ${h} ${g}/"
                cp -f "${h}" "${g}/"
                echo ""
            done
        done
    done
done


#  Balance the .hic files
iter=0
for l in "${chroms[@]}"; do
    # l="${chroms[0]}"  # echo "${l}"  # echo_test "${chroms[@]}"

    if [[ "${l}" == "XII" ]]; then
        unset a_in && typeset -a a_in=(
            # "10_fanc_XII_KR-filt-0.2"
            # "10_fanc_XII_KR-filt-0.3"
            # "10_fanc_XII_KR-filt-0.4"
        )
    elif [[ "${l}" == "gen" ]]; then
        unset a_in && typeset -a a_in=(
            # "10_fanc_genome_KR-filt-0.2"
            # "10_fanc_genome_KR-filt-0.3"
            # "10_fanc_genome_KR-filt-0.4"
            "10_fanc_genome_KR-filt-0.2_whole-matrix"
            "10_fanc_genome_KR-filt-0.3_whole-matrix"
            "10_fanc_genome_KR-filt-0.4_whole-matrix"
        )
    fi
    # echo_test "${a_in[@]}"

    for k in "${a_in[@]}"; do
        # k="${a_in[0]}"  # echo "${k}"

        for j in "${res[@]}"; do
            # j="${res[0]}"  # echo "${j}"

            unset a_bal && typeset -a a_bal
            while IFS=" " read -r -d $'\0'; do
                a_bal+=( "${REPLY}" )
            done < <(
                find "${k}" \
                    -maxdepth 1 \
                    -type f \
                    -name MC-*.mapped.${j}.downsample-*.hic \
                    -print0 \
                        | sort -z
            )
            # echo_test "${a_bal[@]}"
            
            check_array=FALSE
            [[ ${check_array} == TRUE ]] && echo_test "${a_bal[@]}" || true

            check_command_marginals=FALSE
            [[ ${check_command_marginals} == TRUE ]] &&
                {
                    for i in "${a_bal[@]}"; do
                        echo """
                        fanc hic \\
                            ${i} \\
                            --marginals-plot ${i/.hic/.marginals.pdf}
                        """
                        sleep 0.2
                    done
                } || true

            run_command_marginals=FALSE
            [[ ${run_command_marginals} == TRUE ]] &&
                {
                    for i in "${a_bal[@]}"; do
                        fanc hic \
                            ${i} \
                            --marginals-plot ${i/.hic/.marginals.pdf}

                        sleep 0.2
                    done
                } || true

            thresh=$(echo "${k}" | awk -F '[_-]' '{ print $6 }')  # echo "${thresh}"

            if [[ ${k} =~ "whole-matrix" ]]; then
                arguments="--normalise --whole-matrix"
            else
                arguments="--normalise"
            fi
            # echo "${arguments}"

            for i in "${a_bal[@]}"; do
                check_jobs_balance=TRUE
                [[ ${check_jobs_balance} == TRUE ]] &&
                    {
                        (( iter++ ))
                        job_name="balance.$(basename ${i} .hic)"
                        threads=1

                        echo """
                        ### ${iter} ###

                        #HEREDOC
                        sbatch << EOF
                        #!/bin/bash

                        #SBATCH --job-name="${job_name}"
                        #SBATCH --nodes=1
                        #SBATCH --cpus-per-task=${threads}
                        #SBATCH --error="${k}/err_out/${job_name}.%A.stderr.txt"
                        #SBATCH --output="${k}/err_out/${job_name}.%A.stdout.txt"

                        fanc hic \\
                            ${i} \\
                            --filter-low-coverage-relative ${thresh} \\
                            ${arguments}
                        EOF
                        """
                        sleep 0.2
                    } || true

                submit_jobs_balance=TRUE
                [[ ${submit_jobs_balance} == TRUE ]] &&
                    {
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${k}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${k}/err_out/${job_name}.%A.stdout.txt"

fanc hic \
    ${i} \
    --filter-low-coverage-relative ${thresh} \
    ${arguments}
EOF
                        sleep 0.2
                    } || true
            done
        done
    done
done
```
</details>
<br />

<a id="5-create-subsetted-hic-matrices-for-the-rdna-left-array"></a>
### 5. Create subsetted `.hic` matrices for the rDNA left array
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: 5. Create subsetted `.hic` matrices for the rDNA left array</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function check_requirements() {
    local requirements=("$@")
    local tag="is not installed or not in the system's PATH"
    local help=$(
cat << EOM
Usage: check_requirements [command_1] [command_2] ...

Checks that the specified commands are available on the system.

check_requirements() iterates over all given commands and checks that they can
be executed, ensuring all required dependencies are installed.

Positional arguments:
  command_1, command_2, ...  The command(s) to check for installation,
                             availability in the system's PATH.

Example #1:
  check_requirements fithic python

Example #2:
  check_requirements cooler
EOM
    )

    if [[ "${requirements[0]}" == "-h" || "${requirements[0]}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${requirements[@]}" ]]; then
        echo "Error: No command(s) provided."
        echo "${help}"
        return 1
    fi

    for req in "${requirements[@]}"; do
        if ! command -v "${req}" &> /dev/null; then
            echo "Error: ${req} ${tag}."
            return 1
        fi
    done

    return 0
}


function change_dir() {
    local dir="${1}"
    local help=$(
cat << EOM
Usage: change_dir [directory]

Change the current working directory to the one specified.

change_dir() checks if a directory is provided (as an argument), exists, and is
accessible, and then changes to it.

Positional argument:
  directory  The directory to change to
EOM
    )

    if [[ "${dir}" == "-h" || "${dir}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory provided."
        echo "${help}"
        return 1
    fi

    if [[ -d "${dir}" ]]; then
        cd "${dir}" ||
            {
                echo "Error: Failed to change to ${dir} even though it exists."
                return 1
            }
    else
        echo "Error: Directory ${dir} does not exist."
        return 1
    fi
}


function activate_env() {
    local env="${1}"
    local help=$(
cat << EOM
Usage: activate_env [environment]

Activate a specified Conda environment.

If another environment is already active, then activate_env() deactivates it
before activating the desired one.

Positional argument:
  environment  The name of the Conda environment to activate
EOM
    )

    if [[ "${env}" == "-h" || "${env}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if ! check_requirements conda; then return 1; fi

    if [[ -z "${env}" ]]; then
        echo "Error: No environment provided."
        echo "${help}"
        return 1
    fi

    if ! conda info --envs | grep -q "^${env} *"; then
        echo "Error: The environment '${env}' is not found. Please provide a"
        echo "       valid Conda environment name."
        return 1
    fi

    if [[ "${CONDA_DEFAULT_ENV}" != "${env}" ]]; then
        if [[ ${CONDA_DEFAULT_ENV} != base ]]; then
            conda deactivate
        fi

        source activate "${env}"
    fi

    return 0
}


function create_dir_if_none() {
    local dir=""
    local sub_dir="err_out"
    local help=$(
cat << EOM
Usage: create_dir_if_none -d DIRECTORY [-s SUB_DIRECTORY]

Creates a directory and subdirectory if they do not exist.

Options:
  -h, --help           Display this help message
  -d, --directory      Specify the directory to be created
  -s, --sub-directory  Specify the subdirectory to be created inside the main directory (default: err_out)

Example:
  create_dir_if_none -d /path/to/directory -s err_out
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -d|--directory) dir="${2}"; shift 2 ;;
            -s|--sub-directory) sub_dir="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory name provided."
        return 1
    fi

    if [[ ! -w $(dirname "${dir}") ]]; then
        echo "Error: No write permission to create ${dir}."
        return 1
    fi

    if [[ ! -d "${dir}" ]]; then
        mkdir -p "${dir}/${sub_dir}"
        if [[ $? -eq 0 ]]; then
            echo "Directory ${dir}/${sub_dir} has been created."
        else
            echo "Error: Failed to create ${dir}/${sub_dir}."
            return 1
        fi
    else
        echo "Directory ${dir} already exists."
    fi
}


function run_fanc_subset() {
    local input_file=""
    local output_file=""
    local region=""
    local job_name=""
    local err_out_dir=""
    local dry_run=false
    local help=$(
cat << EOM
Usage: run_fanc_subset -i INPUT_FILE -o OUTPUT_FILE -r REGION -j JOB_NAME -e ERR_OUT_DIR [-d]

Subsets a FAN-C format matrix to a specific genomic region.

Options:
  -h, --help         Display this help message
  -i, --input-file   Path to the input FAN-C format file
  -o, --output-file  Path where the subsetted FAN-C format file will be saved
  -r, --region       Genomic region to subset to
  -j, --job-name     Name of the job for sbatch
  -e, --err-out-dir  Directory where error and output logs will be saved
  -d, --dry-run      Print the sbatch script without executing it

Dependencies:
  fanc: Required for subsetting the matrix
  sbatch: Used for job submission

Example:
  run_fanc_subset
      -i input.fanc
      -o subset.fanc
      -r XII:451400-460800
      -j fanc_subset
      -e path/to/logs
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -i|--input-file) input_file="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -r|--region) region="${2}"; shift 2 ;;
            -j|--job-name) job_name="${2}"; shift 2 ;;
            -e|--err-out-dir) err_out_dir="${2}"; shift 2 ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    if ! check_requirements fanc sbatch; then return 1; fi

    if [[ -z "${input_file}" ]]; then
        echo "Error: Input file is required."
        return 1
    elif [[ ! -f "${input_file}" ]]; then
        echo "Error: ${input_file} does not exist."
        return 1
    fi

    if [[ -z "${output_file}" ]]; then
        echo "Error: Output file path is required."
        return 1
    elif [[ -f "${output_file}" ]]; then
        echo "Error: ${output_file} already exists."
        return 1
    fi

    if [[ -z "${region}" ]]; then
        echo "Error: Region is required."
        return 1
    fi

    if [[ -z "${job_name}" ]]; then
        echo "Error: Job name is required."
        return 1
    fi

    if [[ -z "${err_out_dir}" ]]; then
        echo "Error: Error and output directory is required."
        return 1
    elif [[ ! -d "${err_out_dir}" ]]; then
        echo "Error: ${err_out_dir} does not exist."
        return 1
    fi

    local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

fanc subset \
    "${input_file}" \
    "${output_file}" \
    "${region}"
EOF
    )

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following sbatch script would be executed:"
        echo "${sbatch_script}"
    else
        echo "${sbatch_script}" | sbatch
        echo "Job submitted with name '${job_name}'."
    fi

    return 0
}


#  Configure work environment, directories, and variables =====================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Set variables, arrays
unset dirs && typeset -a dirs=(
    "10_fanc_XII_KR-filt-0.4_rDNA-left-array"
)

unset hics && typeset -a hics
while IFS=" " read -r -d $'\0'; do
    hics+=( "${REPLY}" )
done < <(
    find \
        10_fanc_XII_KR-filt-0.4 \
        -maxdepth 1 \
        -type f \
        \( \
            -name "*.50.*" -o \
            -name "*.100.*" -o \
            -name "*.150.*" -o \
            -name "*.200.*" -o \
            -name "*.300.*" -o \
            -name "*.400.*" -o \
            -name "*.500.*" -o \
            -name "*.800.*" -o \
            -name "*.1600.*" -o \
            -name "*.3200.*" -o \
            -name "*.5000.*" -o \
            -name "*.6400.*" -o \
            -name "*.12800.*" \
        \) \
        -print0 |
            sort -z
)
# echo_test "${hics[@]}"

check_array=true
if ${check_array}; then
    #  Check if any files were found
    if [[ ${#hics[@]} -eq 0 ]]; then
        echo "No Hi-C files found."
        exit 1
    fi
fi

check_array=true
if ${check_array}; then
    #  Print found files
    for hic in "${hics[@]}"; do
        echo "${hic}"
    done
    
    echo ""
    echo "Number of files: ${#hics[@]}"
fi

chr="XII"                        # echo "${chr}"
start="451400"                   # echo "${start}"
end="460800"                     # echo "${end}"
region="${chr}:${start}-${end}"  # echo "${region}"


#  Execute main tasks =========================================================
#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source initial work environment that allows access to cooler
activate_env fanc_pip_env

#  Create outfile directories if they don't exist
for dir in "${dirs[@]}"; do create_dir_if_none -d "${dir}"; done

#  Convert FAN-C .hic files to .cool files for use with HiCExplorer
iter=0                                                   # echo "${iter}"
for hic in "${hics[@]}"; do
    # hic="${hics[1]}"                                   # echo "${hic}"
    in_file="${hic}"                                     # echo "${in_file}"
    out_dir="$(dirname "${in_file}")_rDNA-left-array"    # echo "${out_dir}"
    out_file="${out_dir}/$(basename ${in_file})"         # echo "${out_file}"
    job_name="fanc-subset.$(basename ${out_file%.hic})"  # echo "${job_name}"
    err_out_dir="$(dirname ${out_file})/err_out"         # echo "${err_out_dir}"

    (( iter ++ ))
    check_variables=true
    if ${check_variables}; then
        echo """
        ### iter ${iter} ###
            in_file  ${in_file}
           out_file  ${out_file}
           job_name  ${job_name}
        err_out_dir  ${err_out_dir}
        """
    fi

    check_command=true
    if ${check_command}; then
        echo """
        run_fanc_subset \\
            -i \"${in_file}\" \\
            -o \"${out_file}\" \\
            -r \"${region}\" \\
            -j \"${job_name}\" \\
            -e \"${err_out_dir}\"
        """
    fi

    do_dry_run=true
    if ${do_dry_run}; then
        echo "### ${iter} ###"
        run_fanc_subset \
            -i "${in_file}" \
            -o "${out_file}" \
            -r "${region}" \
            -j "${job_name}" \
            -e "${err_out_dir}" \
            -d
    fi

    run_function=true
    if [[ ${run_function} ]]; then
        # echo "### ${iter} ###"
        run_fanc_subset \
            -i "${in_file}" \
            -o "${out_file}" \
            -r "${region}" \
            -j "${job_name}" \
            -e "${err_out_dir}"
    fi
    sleep 0.2
done

#NOTE
#  Nice! .hic files from fanc subset that were converted to .cool files via
#+ fanc to-cooler retain balance weights
```
</details>
<br />

<a id="6-convert-hic-matrices-to-cool-matrices"></a>
### 6. Convert `.hic` matrices to `.cool` matrices
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: 6. Convert `.hic` matrices to `.cool` matrices</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function check_requirements() {
    local requirements=("$@")
    local tag="is not installed or not in the system's PATH"
    local help=$(
cat << EOM
Usage: check_requirements [command_1] [command_2] ...

Checks that the specified commands are available on the system.

check_requirements() iterates over all given commands and checks that they can
be executed, ensuring all required dependencies are installed.

Positional arguments:
  command_1, command_2, ...  The command(s) to check for installation,
                             availability in the system's PATH.

Example #1:
  check_requirements fithic python

Example #2:
  check_requirements cooler
EOM
    )

    if [[ "${requirements[0]}" == "-h" || "${requirements[0]}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${requirements[@]}" ]]; then
        echo "Error: No command(s) provided."
        echo "${help}"
        return 1
    fi

    for req in "${requirements[@]}"; do
        if ! command -v "${req}" &> /dev/null; then
            echo "Error: ${req} ${tag}."
            return 1
        fi
    done

    return 0
}


function change_dir() {
    local dir="${1}"
    local help=$(
cat << EOM
Usage: change_dir [directory]

Change the current working directory to the one specified.

change_dir() checks if a directory is provided (as an argument), exists, and is
accessible, and then changes to it.

Positional argument:
  directory  The directory to change to
EOM
    )

    if [[ "${dir}" == "-h" || "${dir}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory provided."
        echo "${help}"
        return 1
    fi

    if [[ -d "${dir}" ]]; then
        cd "${dir}" ||
            {
                echo "Error: Failed to change to ${dir} even though it exists."
                return 1
            }
    else
        echo "Error: Directory ${dir} does not exist."
        return 1
    fi
}


function activate_env() {
    local env="${1}"
    local help=$(
cat << EOM
Usage: activate_env [environment]

Activate a specified Conda environment.

If another environment is already active, then activate_env() deactivates it
before activating the desired one.

Positional argument:
  environment  The name of the Conda environment to activate
EOM
    )

    if [[ "${env}" == "-h" || "${env}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if ! check_requirements conda; then return 1; fi

    if [[ -z "${env}" ]]; then
        echo "Error: No environment provided."
        echo "${help}"
        return 1
    fi

    if ! conda info --envs | grep -q "^${env} *"; then
        echo "Error: The environment '${env}' is not found. Please provide a"
        echo "       valid Conda environment name."
        return 1
    fi

    if [[ "${CONDA_DEFAULT_ENV}" != "${env}" ]]; then
        if [[ ${CONDA_DEFAULT_ENV} != base ]]; then
            conda deactivate
        fi

        source activate "${env}"
    fi

    return 0
}


function create_dir_if_none() {
    local dir=""
    local sub_dir="err_out"
    local help=$(
cat << EOM
Usage: create_dir_if_none -d DIRECTORY [-s SUB_DIRECTORY]

Creates a directory and subdirectory if they do not exist.

Options:
  -h, --help           Display this help message
  -d, --directory      Specify the directory to be created
  -s, --sub-directory  Specify the subdirectory to be created inside the main directory (default: err_out)

Example:
  create_dir_if_none -d /path/to/directory -s err_out
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -d|--directory) dir="${2}"; shift 2 ;;
            -s|--sub-directory) sub_dir="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory name provided."
        return 1
    fi

    if [[ ! -w $(dirname "${dir}") ]]; then
        echo "Error: No write permission to create ${dir}."
        return 1
    fi

    if [[ ! -d "${dir}" ]]; then
        mkdir -p "${dir}/${sub_dir}"
        if [[ $? -eq 0 ]]; then
            echo "Directory ${dir}/${sub_dir} has been created."
        else
            echo "Error: Failed to create ${dir}/${sub_dir}."
            return 1
        fi
    else
        echo "Directory ${dir} already exists."
    fi
}


function run_fanc_to_cooler() {
    local input_file=""
    local output_file=""
    local job_name=""
    local err_out_dir=""
    local threads=""
    local dry_run=false
    local help=$(
cat << EOM
Usage: run_fanc_to_cooler -i INPUT_FILE -o OUTPUT_FILE -j JOB_NAME -e ERR_OUT_DIR [-t THREADS] [-d]

Converts a FAN-C format matrix to a cooler format matrix.

Options:
  -h, --help         Display this help message
  -i, --input-file   Path to the input FAN-C format file
  -o, --output-file  Path where the output cooler format file will be saved
  -j, --job-name     Name of the job for sbatch
  -e, --err-out-dir  Directory where error and output logs will be saved
  -t, --threads      Number of threads to use (default: 1)
  -d, --dry-run      Print the sbatch script without executing it

Dependencies:
  fanc: Required for converting the matrix format
  sbatch: Used for job submission

Example:
  run_fanc_to_cooler -i input.hic -o output.cool -j to_cool -e path/to/logs -t 4
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -i|--input-file) input_file="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -j|--job-name) job_name="${2}"; shift 2 ;;
            -e|--err-out-dir) err_out_dir="${2}"; shift 2 ;;
            -t|--threads) threads="${2}"; shift 2 ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    if ! check_requirements fanc sbatch; then return 1; fi

    if [[ -z "${input_file}" ]]; then
        echo "Error: Input file is required."
        return 1
    elif [[ ! -f "${input_file}" ]]; then
        echo "Error: ${input_file} does not exist."
        return 1
    fi

    if [[ -z "${output_file}" ]]; then
        echo "Error: Output file path is required."
        return 1
    elif [[ -f "${output_file}" ]]; then
        echo "Error: ${output_file} already exists."
        return 1
    fi

    if [[ -z "${job_name}" ]]; then
        echo "Error: Job name is required."
        return 1
    fi

    if [[ -z "${err_out_dir}" ]]; then
        echo "Error: Error and output directory is required."
        return 1
    elif [[ ! -d "${err_out_dir}" ]]; then
        echo "Error: ${err_out_dir} does not exist."
        return 1
    fi

    if [[ -z "${threads}" ]]; then
        echo "Warning: Number of threads is not set. Using default of 1."
        threads=1
    elif ! [[ "${threads}" =~ ^[0-9]+$ ]]; then
        echo "Error: Number of threads must be a positive integer."
        return 1
    fi

    local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

fanc to-cooler \
    --threads ${threads} \
    --no-multi \
    ${input_file} \
    ${output_file}
EOF
    )

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following sbatch script would be executed:"
        echo "${sbatch_script}"
    else
        echo "${sbatch_script}" | sbatch
        echo "Job submitted with name '${job_name}'."
    fi

    return 0
}


#  Configure work environment, directories, and variables =====================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Set variables, arrays
unset dirs && typeset -a dirs=(
    # "11_cooler_XII_KR-filt-0.2"
    # "11_cooler_XII_KR-filt-0.3"
    # "11_cooler_XII_KR-filt-0.4"
    "11_cooler_XII_KR-filt-0.4_rDNA-left-array"
    # "11_cooler_genome_KR-filt-0.2"
    # "11_cooler_genome_KR-filt-0.3"
    # "11_cooler_genome_KR-filt-0.4"
    # "11_cooler_genome_KR-filt-0.2_whole-matrix"
    # "11_cooler_genome_KR-filt-0.3_whole-matrix"
    # "11_cooler_genome_KR-filt-0.4_whole-matrix"
)

# unset hics && typeset -a hics
# while IFS=" " read -r -d $'\0'; do
#     hics+=( "${REPLY}" )
# done < <(
#     find \
#         10_fanc_genome_KR-filt-0.2 \
#         10_fanc_genome_KR-filt-0.3 \
#         10_fanc_genome_KR-filt-0.4 \
#         10_fanc_genome_KR-filt-0.2_whole-matrix \
#         10_fanc_genome_KR-filt-0.3_whole-matrix \
#         10_fanc_genome_KR-filt-0.4_whole-matrix \
#         -maxdepth 1 \
#         -type f \
#         \( \
#             -name "*3200*hic" -o \
#             -name "*5000*hic" -o \
#             -name "*6400*hic" -o \
#             -name "*12800*hic" \
#         \) \
#         -print0 |
#             sort -z
# )
# # echo_test "${hics[@]}"

# unset hics && typeset -a hics
# while IFS=" " read -r -d $'\0'; do
#     hics+=( "${REPLY}" )
# done < <(
#     find \
#         10_fanc_XII_KR-filt-0.2 \
#         10_fanc_XII_KR-filt-0.3 \
#         10_fanc_XII_KR-filt-0.4 \
#         -maxdepth 1 \
#         -type f \
#         \( \
#             -name "*.50.*hic" -o \
#             -name "*.100.*hic" -o \
#             -name "*.150.*hic" -o \
#             -name "*.200.*hic" -o \
#             -name "*.300.*hic" -o \
#             -name "*.400.*hic" -o \
#             -name "*.500.*hic" \
#         \) \
#         -print0 |
#             sort -z
# )
# # echo_test "${hics[@]}"

# unset hics && typeset -a hics
# while IFS=" " read -r -d $'\0'; do
#     hics+=( "${REPLY}" )
# done < <(
#     find \
#         10_fanc_XII_KR-filt-0.4 \
#         -maxdepth 1 \
#         -type f \
#         \( \
#             -name "*.800.*" -o \
#             -name "*.1600.*" -o \
#             -name "*.3200.*" -o \
#             -name "*.5000.*" -o \
#             -name "*.6400.*" -o \
#             -name "*.12800.*" \
#         \) \
#         -print0 |
#             sort -z
# )
# # echo_test "${hics[@]}"

# unset hics && typeset -a hics
# while IFS=" " read -r -d $'\0'; do
#     hics+=( "${REPLY}" )
# done < <(
#     find \
#         10_fanc_XII_KR-filt-0.2 \
#         10_fanc_XII_KR-filt-0.3 \
#         10_fanc_XII_KR-filt-0.4 \
#         10_fanc_genome_KR-filt-0.2 \
#         10_fanc_genome_KR-filt-0.3 \
#         10_fanc_genome_KR-filt-0.4 \
#         10_fanc_genome_KR-filt-0.2_whole-matrix \
#         10_fanc_genome_KR-filt-0.3_whole-matrix \
#         10_fanc_genome_KR-filt-0.4_whole-matrix \
#         -maxdepth 1 \
#         -type f \
#         \( \
#             -name "*.50.*" -o \
#             -name "*.100.*" -o \
#             -name "*.150.*" -o \
#             -name "*.200.*" -o \
#             -name "*.300.*" -o \
#             -name "*.400.*" -o \
#             -name "*.500.*" -o \
#             -name "*.800.*" -o \
#             -name "*.1600.*" -o \
#             -name "*.3200.*" -o \
#             -name "*.5000.*" -o \
#             -name "*.6400.*" -o \
#             -name "*.12800.*" \
#         \) \
#         -print0 |
#             sort -z
# )
# # echo_test "${hics[@]}"

unset hics && typeset -a hics
while IFS=" " read -r -d $'\0'; do
    hics+=( "${REPLY}" )
done < <(
    find \
        10_fanc_XII_KR-filt-0.4_rDNA-left-array \
        -maxdepth 1 \
        -type f \
        \( \
            -name "*.50.*" -o \
            -name "*.100.*" -o \
            -name "*.150.*" -o \
            -name "*.200.*" -o \
            -name "*.300.*" -o \
            -name "*.400.*" -o \
            -name "*.500.*" -o \
            -name "*.800.*" -o \
            -name "*.1600.*" -o \
            -name "*.3200.*" -o \
            -name "*.5000.*" -o \
            -name "*.6400.*" -o \
            -name "*.12800.*" \
        \) \
        -print0 |
            sort -z
)
# echo_test "${hics[@]}"

check_array=true
if ${check_array}; then
    #  Check if any files were found
    if [[ ${#hics[@]} -eq 0 ]]; then
        echo "No Hi-C files found."
        exit 1
    fi
fi

check_array=true
if ${check_array}; then
    #  Print found files
    for hic in "${hics[@]}"; do
        echo "${hic}"
    done
    
    echo ""
    echo "Number of files: ${#hics[@]}"
fi


#  Execute main tasks =========================================================
#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source initial work environment that allows access to cooler
activate_env fanc_pip_env

#  Create outfile directories if they don't exist
for dir in "${dirs[@]}"; do create_dir_if_none -d "${dir}"; done

#  Convert FAN-C .hic files to .cool files for use with HiCExplorer
iter=0                                                     # echo "${iter}"
for hic in "${hics[@]}"; do
    # hic="${hics[0]}"                                     # echo "${hic}"
    input_file="${hic}"                                    # echo "${input_file}"
    output_file="$(
        echo ${input_file} \
            | sed 's:10_fanc:11_cooler:g' \
            | sed 's:\.hic:\.cool:g'
    )"                                                     # echo "${output_file}"
    job_name="to-cooler.$(basename ${output_file%.cool})"  # echo "${job_name}"
    err_out_dir="$(dirname ${output_file})/err_out"        # echo "${err_out_dir}"
    threads=4                                              # echo "${threads}"

    (( iter ++ ))
    check_variables=true
    if ${check_variables}; then
        echo """
        ### iter ${iter} ###
         input_file  ${input_file}
        output_file  ${output_file}
           job_name  ${job_name}
        err_out_dir  ${err_out_dir}
            threads  ${threads}
        """
    fi

    check_command=false
    if ${check_command}; then
        echo """
        run_fanc_to_cooler \\
            --input-file \"${input_file}\" \\
            --output-file \"${output_file}\" \\
            --job-name \"${job_name}\" \\
            --error-output-dir \"${err_out_dir}\" \\
            --threads ${threads} \\
            --dry-run
        """
    fi

    #FIXME Dry runs submit commands; dry runs shouldn't be submitted.
    do_dry_run=true
    if ${do_dry_run}; then
        echo "### ${iter} ###"
        run_fanc_to_cooler \
            --input-file "${input_file}" \
            --output-file "${output_file}" \
            --job-name "${job_name}" \
            --err-out-dir "${err_out_dir}" \
            --threads ${threads} \
            --dry-run
    fi

    run_function=false
    if [[ ${run_function} ]]; then
        # echo "### ${iter} ###"
        run_fanc_to_cooler \
            --input-file "${input_file}" \
            --output-file "${output_file}" \
            --job-name "${job_name}" \
            --err-out-dir "${err_out_dir}" \
            --threads ${threads}
    fi
    sleep 0.2
done

#NOTE
#  Nice! .hic files from fanc subset that were converted to .cool files via
#+ fanc to-cooler retain balance weights
```
</details>
<br />

<a id="7-run-hicexplorer-hiccomparematrices"></a>
### 7. Run HiCExplorer `hicCompareMatrices`
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Run HiCExplorer `hicCompareMatrices`</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function run_hicCompareMatrices() {
    local help=$(
cat << EOM
Usage: run_hicCompareMatrices -1 MATRIX1 -2 MATRIX2 -o OUTPUT_FILE -j JOB_NAME -e ERR_OUT_DIR [-p OPERATION] [-n] [-d]

Compares two Hi-C matrices.

Options:
  -h, --help         Display this help message
  -1, --matrix-1     Path to the first matrix file (required)
  -2, --matrix-2     Path to the second matrix file (required)
  -o, --output-file  Path to the output file (required)
  -j, --job-name     Name of the job (required)
  -e, --err-out-dir  Directory for stderr and stdout logs (required)
  -p, --operation    Operation to be performed on the matrices (default: log2ratio)
  -n, --no-norm      Do not apply normalization before computing the operation
  -d, --dry-run      Print the sbatch command without executing it

Dependencies:
  hicCompareMatrices: Required for comparing the matrices
  sbatch: Used for job submission

Example:
  run_hicCompareMatrices -1 matrix_1.cool -2 matrix_2.cool -o output.cool -j compare.matrices -e path/to/logs -p log2ratio -n -d
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    local matrix1=""
    local matrix2=""
    local output_file=""
    local job_name=""
    local err_out_dir=""
    local operation="log2ratio"
    local no_norm=false
    local dry_run=false

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -1|--matrix-1) matrix_1="${2}"; shift 2 ;;
            -2|--matrix-2) matrix_2="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -j|--job-name) job_name="${2}"; shift 2 ;;
            -e|--err-out-dir) err_out_dir="${2}"; shift 2 ;;
            -p|--operation) operation="${2}"; shift 2 ;;
            -n|--no-norm) no_norm=true; shift ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements hicCompareMatrices sbatch; then return 1; fi

    if [[ -z "${matrix_1}" ]]; then
        echo "Error: Input file #1 is required."
        return 1
    elif [[ ! -f "${matrix_1}" ]]; then
        echo "Error: ${matrix_1} does not exist."
        return 1
    fi

    if [[ -z "${matrix_2}" ]]; then
        echo "Error: Input file #2 is required."
        return 1
    elif [[ ! -f "${matrix_2}" ]]; then
        echo "Error: ${matrix_2} does not exist."
        return 1
    fi

    if [[ -z "${output_file}" ]]; then
        echo "Error: Output file path is required."
        return 1
    elif [[ -f "${output_file}" ]]; then
        echo "Error: ${output_file} already exists."
        return 1
    fi

    if [[ -z "${job_name}" ]]; then
        echo "Error: Job name is required."
        return 1
    fi

    if [[ -z "${err_out_dir}" ]]; then
        echo "Error: Error and output directory is required."
        return 1
    elif [[ ! -d "${err_out_dir}" ]]; then
        echo "Error: ${err_out_dir} does not exist."
        return 1
    fi

    : ${operation:="log2ratio"}

    local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

hicCompareMatrices \
    -m ${matrix_1} ${matrix_2} \
    -o ${output_file} \
    --operation ${operation} \
    $(if ${no_norm}; then echo "--noNorm"; fi)
EOF
    )

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following sbatch script would be executed:"
        echo "${sbatch_script}"
    else
        echo "${sbatch_script}" | sbatch
        echo "Job submitted with name '${job_name}'."
    fi

    return 0
}


#  Configure work environment, directories, and variables =====================
activate_env "hicexplorer_764_env"

# Directories containing the cooler files
dirs=(
    "11_cooler_genome_KR-filt-0.4"
    "11_cooler_genome_KR-filt-0.4_whole-matrix"
    "11_cooler_XII_KR-filt-0.4"
)
# echo_test "${dirs[@]}"

operation="log2ratio"
# operation="diff"


#  Execute main tasks =========================================================
iter=0
for dir in "${dirs[@]}"; do
    # dir="${dirs[0]}"
    echo "Processing directory: ${dir}"
    
    #  Get all cooler files in the directory
    unset && typeset -a files=( ${dir}/*.cool )
    # echo_test "${files[@]}"

    #  Create an output directory based on the input directory
    outdir="12_hicCompareMatrices_${dir#11_cooler_}"  # echo "${outdir}"

    run_dir_check=true
    if ${run_dir_check}; then        
        if [[ ! -d "${outdir}" ]]; then
            mkdir -p "${outdir}/err_out"
        fi
    fi
    
    #  Loop through each file
    for (( i=0; i<${#files[@]}; i++ )); do
        # i=0
        
        #  Extract the resolution from the file #1 name
        res_1=$(
            echo "${files[i]}" | grep -oP '\d+(?=.downsample-to-(Q|G1).cool)'
        )  # echo ${res_1}
        
        #  Extract the phase from file #1 name
        phase_1=$(
            echo "${files[i]}" \
                | awk -F '/' '{ print $NF }' \
                | awk -F '.' '{ print $1 }' \
                | grep -oP '(Q|30C-a15|nz)'
            )  # echo "${phase_1}"

        for (( j=0; j<${#files[@]}; j++ )); do
            # j=4
            
            #  Skip any self-comparison
            if [[ ${i} -eq ${j} ]]; then
                continue
            fi

            #  Extract the resolution from the file #2 name
            res_2=$(
                echo "${files[j]}" | grep -oP '\d+(?=.downsample-to-(Q|G1).cool)'
            )  # echo "${res_2}"

            #  Extract the phase from file #2 name
            phase_2=$(
                echo "${files[j]}" \
                    | awk -F '/' '{ print $NF }' \
                    | awk -F '.' '{ print $1 }' \
                    | grep -oP '(Q|30C-a15|nz)'
            )  # echo "${phase_2}"

            # Compare only if the resolutions are the same
            if [[ ${res_1} -eq ${res_2} ]]; then
                file_1="${files[i]}"  # echo "${file_1}"
                file_2="${files[j]}"  # echo "${file_2}"
                (( iter++ ))
                
                #  Translate phase strings to cell cycle phases
                if [[ "${phase_1}" == "Q" ]]; then
                    phase_1="Q"
                elif [[ "${phase_1}" == "30C-a15" ]]; then
                    phase_1="G1"
                elif [[ "${phase_1}" == "nz" ]]; then
                    phase_1="G2"
                fi  # echo "${phase_1}"
                
                if [[ "${phase_2}" == "Q" ]]; then
                    phase_2="Q"
                elif [[ "${phase_2}" == "30C-a15" ]]; then
                    phase_2="G1"
                elif [[ "${phase_2}" == "nz" ]]; then
                    phase_2="G2"
                fi  # echo "${phase_2}"

                if [[ "${operation}" == "log2ratio" || "${operation}" == "ratio" ]]; then
                    preposition=over
                elif [[ "${operation}" == "diff" ]]; then
                    preposition=minus
                fi

                outfile="${outdir}/${phase_1}-${preposition}-${phase_2}.${res_1}.${operation}.cool"  # echo "${outfile}"
                job_name="$(basename "${outfile}" .cool)"                                  # echo "${job_name}"
                err_out_dir="${outdir}/err_out"

                check_variables=true
                if ${check_variables}; then
                    echo """
                    iter .................................. ${iter}
                    file_1 ................................ ${file_1}
                    file_2 ................................ ${file_2}
                    outdir ................................ ${outdir}
                    outfile ............................... ${outfile}
                    job_name .............................. ${job_name}
                    err_out_dir ........................... ${err_out_dir}
                    operation ............................. ${operation}
                    """
                fi
                
                do_dry_run=true
                if ${do_dry_run}; then
                    echo "### ${iter} ###"
                    run_hicCompareMatrices \
                        -1 "${file_1}" \
                        -2 "${file_2}" \
                        -o "${outfile}" \
                        -j "${job_name}" \
                        -e "${err_out_dir}" \
                        -p "${operation}" \
                        -d
                        
                        # -n \
                fi

                run_jobs=true
                if ${run_jobs}; then
                    run_hicCompareMatrices \
                        -1 "${file_1}" \
                        -2 "${file_2}" \
                        -o "${outfile}" \
                        -j "${job_name}" \
                        -e "${err_out_dir}" \
                        -p "${operation}"

                        # -n
                fi

                sleep 0.1
            fi
        done
    done

    echo ""
done
```
</details>
<br />

<a id="8-draw-whole-genome-square-plots-of-negative-log-transformed-counts"></a>
### 8. Draw whole-genome "square" plots of negative log-transformed counts
<a id="strategy"></a>
#### Strategy
<a id="notes-1"></a>
##### Notes
<details>
<summary><i>Notes: Strategy</i></summary>
<br />

No native support of whole-genome "square" plots with FAN-C.

Alternative strategy:
1. Use `fanc to-cooler` to convert 5-kb balanced `.hic` files to `.cool` files  `#DONE`
2. Use converted `.cool` files with HiCExplorer `hicPlotMatrix`  `#INPROGRESS`
</details>
<br />

<a id="run-hicexplorer-plothicmatrix-for-negative-log-transformed-heatmaps"></a>
#### Run HiCExplorer `plotHicMatrix` for negative log-transformed heatmaps
<a id="code-11"></a>
##### Code
<details>
<summary><i>Code: Run HiCExplorer `plotHicMatrix` for negative log-transformed heatmaps</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function check_requirements() {
    local requirements=("$@")
    local tag="is not installed or not in the system's PATH"
    local help=$(
cat << EOM
Usage: check_requirements [command_1] [command_2] ...

Checks that the specified commands are available on the system.

check_requirements() iterates over all given commands and checks that they can
be executed, ensuring all required dependencies are installed.

Positional arguments:
  command_1, command_2, ...  The command(s) to check for installation,
                             availability in the system's PATH.

Example #1:
  check_requirements fithic python

Example #2:
  check_requirements cooler
EOM
    )

    if [[ "${requirements[0]}" == "-h" || "${requirements[0]}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${requirements[@]}" ]]; then
        echo "Error: No command(s) provided."
        echo "${help}"
        return 1
    fi

    for req in "${requirements[@]}"; do
        if ! command -v "${req}" &> /dev/null; then
            echo "Error: ${req} ${tag}."
            return 1
        fi
    done

    return 0
}


function change_dir() {
    local dir="${1}"
    local help=$(
cat << EOM
Usage: change_dir [directory]

Change the current working directory to the one specified.

change_dir() checks if a directory is provided (as an argument), exists, and is
accessible, and then changes to it.

Positional argument:
  directory  The directory to change to
EOM
    )

    if [[ "${dir}" == "-h" || "${dir}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory provided."
        echo "${help}"
        return 1
    fi

    if [[ -d "${dir}" ]]; then
        cd "${dir}" ||
            {
                echo "Error: Failed to change to ${dir} even though it exists."
                return 1
            }
    else
        echo "Error: Directory ${dir} does not exist."
        return 1
    fi
}


function activate_env() {
    local env="${1}"
    local help=$(
cat << EOM
Usage: activate_env [environment]

Activate a specified Conda environment.

If another environment is already active, then activate_env() deactivates it
before activating the desired one.

Positional argument:
  environment  The name of the Conda environment to activate
EOM
    )

    if [[ "${env}" == "-h" || "${env}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if ! check_requirements conda; then return 1; fi

    if [[ -z "${env}" ]]; then
        echo "Error: No environment provided."
        echo "${help}"
        return 1
    fi

    if ! conda info --envs | grep -q "^${env} *"; then
        echo "Error: The environment '${env}' is not found. Please provide a"
        echo "       valid Conda environment name."
        return 1
    fi

    if [[ "${CONDA_DEFAULT_ENV}" != "${env}" ]]; then
        if [[ ${CONDA_DEFAULT_ENV} != base ]]; then
            conda deactivate
        fi

        source activate "${env}"
    fi

    return 0
}


function run_hicPlotMatrix() {
    local help=$(
cat << EOM
Usage: run_hicPlotMatrix -i INPUT_FILE -o OUTPUT_FILE -j JOB_NAME
  -e ERR_OUT_DIR -c COORDINATES [-r COLOR_MAP] [-n COLOR_MIN] [-x COLOR_MAX]
  [-t TITLE] [-p DPI] [-d]

Plots a cooler format matrix. File type determined by extension.

Options:
  -h, --help         Display this help message
  -i, --input-file   Path to the input cooler matrix (required)
  -o, --output-file  Path to the output file (required)
  -j, --job-name     Name of the job (required)
  -e, --err-out-dir  Directory for stderr and stdout logs (required)
  -c, --coordinates  Chromosome order coordinates (required)
  -r, --color-map    Color map for the plot (default: Oranges)
  -l, --log-scale    Enable log scale for the plot (optional)
  -n, --color-min    Minimum color value (default: 0.0001)
  -x, --color-max    Maximum color value (default: 1)
  -t, --title        Title of the plot (default: basename of input file)
  -p, --dpi          Dots per inch for the plot (default: 300)
  -d, --dry-run      Print the sbatch command without executing it

Dependencies:
  hicPlotMatrix: Required for plotting the matrix
  sbatch: Used for job submission

Example:
  run_hicPlotMatrix
      -i input.cool
      -o output.png
      -j plot.input
      -e path/to/logs
      -c "XII"
      -r "Reds"
      -l
      -n 0.0001
      -x 1
      -t "XII"
      -p 72
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    local input_file=""
    local output_file=""
    local job_name=""
    local err_out_dir=""
    local coordinates=""
    local color_map="Oranges"
    local log_scale=false
    local vmin=0.0001
    local vmax=1
    local title=""
    local dpi=300
    local dry_run=false

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -i|--input-file) input_file="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -j|--job-name) job_name="${2}"; shift 2 ;;
            -e|--err-out-dir) err_out_dir="${2}"; shift 2 ;;
            -c|--coordinates) 
                #  Check if the coordinates string contains spaces
                if [[ "${2}" == *" "* ]]; then
                    #  If it does, split the string into an array
                    coordinates=(${2})
                else
                    coordinates="${2}"
                fi
                shift 2 ;;
            -r|--color-map) color_map="${2}"; shift 2 ;;
            -l|--log-scale) log_scale=true; shift ;;
            -n|--color-min) vmin="${2}"; shift 2 ;;
            -x|--color-max) vmax="${2}"; shift 2 ;;
            -t|--title) title="${2}"; shift 2 ;;
            -p|--dpi) dpi="${2}"; shift 2 ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements hicPlotMatrix sbatch; then return 1; fi

    if [[ -z "${input_file}" ]]; then
        echo "Error: Input file is required."
        return 1
    elif [[ ! -f "${input_file}" ]]; then
        echo "Error: ${input_file} does not exist."
        return 1
    fi

    if [[ -z "${output_file}" ]]; then
        echo "Error: Output file path is required."
        return 1
    elif [[ -f "${output_file}" ]]; then
        echo "Error: ${output_file} already exists."
        return 1
    fi

    if [[ -z "${job_name}" ]]; then
        echo "Error: Job name is required."
        return 1
    fi

    if [[ -z "${err_out_dir}" ]]; then
        echo "Error: Error and output directory is required."
        return 1
    elif [[ ! -d "${err_out_dir}" ]]; then
        echo "Error: ${err_out_dir} does not exist."
        return 1
    fi

    #  If necessary, initialize default values for specific variables 
    : ${color_map:="Oranges"}
    : ${vmin:=0.0001}
    : ${vmax:=1}
    : ${title:="$(basename "${input_file}" .cool)"}
    : ${dpi:=300}

    local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

hicPlotMatrix \
    --chromosomeOrder ${coordinates[@]} \
    --colorMap "${color_map}" \
    $(if ${log_scale}; then echo "--log"; fi) \
    --vMin ${vmin} \
    --vMax ${vmax} \
    --title "${title}" \
    --dpi ${dpi} \
    --matrix "${input_file}" \
    --outFileName "${output_file}"
EOF
    )

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following sbatch script would be executed:"
        echo "${sbatch_script}"
    else
        echo "${sbatch_script}" | sbatch
        echo "Job submitted with name '${job_name}'."
    fi

    return 0
}


#  Configure work environment, directories, and variables =====================
#  Set variables, arrays
# res=6400                                                       # echo "${res}"
res=5000                                                       # echo "${res}"
# res=3200                                                       # echo "${res}"
# res=1600                                                       # echo "${res}"
# res=800                                                        # echo "${res}"
# res=300                                                        # echo "${res}"
# res=200                                                        # echo "${res}"

# coord="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI"  # echo "${coord}"
# coord="XII:451000-469000"                                      # echo "${coord}"  #NOGOOD
# coord="XII:452000-462000"                                      # echo "${coord}"  #NOGOOD
# coord="XII:451500-461500"                                      # echo "${coord}"  #BETTER
# coord="XII:451000-461000"                                      # echo "${coord}"  #NOGOOD
# coord="XII:451500-460500"                                      # echo "${coord}"  #CLOSE
# coord="XII:451200-460800"                                      # echo "${coord}"  #ALMOST
# coord="XII:451500-460800"                                      # echo "${coord}"  #GOOD
# coord="XII:451400-460800"                                      # echo "${coord}"  #GOOD #USE
# coord="XII"                                                    # echo "${coord}"
coord="XI XII XIII"                                            # echo "${coord}"

# vmin=0.0000001                                                 # echo "${vmin}"
vmin=0.0000003162278                                           # echo "${vmin}"
# vmin=0.000001                                                  # echo "${vmin}"
# vmin=0.000003162278                                            # echo "${vmin}"
# vmin=0.00001                                                   # echo "${vmin}"
# vmin=0.00003162278                                             # echo "${vmin}"
# vmin=0.0001                                                    # echo "${vmin}"
# vmin=0.0003162278                                              # echo "${vmin}"
# vmin=0.001                                                     # echo "${vmin}"
vmax=1                                                         # echo "${vmax}"

dpi=300                                                        # echo "${dpi}"
matcol="RdPu"                                                  # echo "${matcol}"
# outdir="pngs/2023-1013_XII-square_whole-genome"                # echo "${outdir}"

# date="2023-1019"                                               # echo "${date}"
date="2023-1020"                                               # echo "${date}"

if [[ ${coord} == "XI XII XIII" ]]; then
    outdir="pngs/${date}_$(sed 's/ /-/g' <(echo "${coord}"))"  # echo "${outdir}"
else
    outdir="pngs/${date}_$(sed 's/\:/-/g' <(echo "${coord}"))" # echo "${outdir}"
fi

unset cools && typeset -a cools
while IFS=" " read -r -d $'\0'; do
    cools+=( "${REPLY}" )
done < <(
    find \
        11_cooler_genome_KR-filt-0.4_whole-matrix \
        -maxdepth 1 \
        -type f \
        -name MC*.${res}.*cool \
        -print0 \
            | sort -z
)

check_array=true
if ${check_array}; then echo_test "${cools[@]}"; fi

# < <(
#     find \
#         11_cooler_XII_KR-filt-0.4 \
#         -maxdepth 1 \
#         -type f \
#         -name MC*.${res}.*cool \
#         -print0 \
#             | sort -z
# )

# < <(
#     find \
#         11_cooler_genome_KR-filt-0.2 \
#         11_cooler_genome_KR-filt-0.3 \
#         11_cooler_genome_KR-filt-0.4 \
#         -maxdepth 1 \
#         -type f \
#         -name MC*${res}*cool \
#         -print0 \
#             | sort -z
# )

# < <(
#     find \
#         11_cooler_genome_KR-filt-0.2_whole-matrix \
#         11_cooler_genome_KR-filt-0.3_whole-matrix \
#         11_cooler_genome_KR-filt-0.4_whole-matrix \
#         -maxdepth 1 \
#         -type f \
#         -name MC*${res}*cool \
#         -print0 \
#             | sort -z
# )


#  Execute main tasks =========================================================
#  Activate environment
activate_env "hicexplorer_764_env"

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Make outfile directory if it doesn't exist
[[ ! -d "${outdir}" ]] && mkdir -p "${outdir}/err_out" || true

# vmin=0.0000001                                                  # echo "${vmin}"
# vmin=0.0000003162278                                             # echo "${vmin}"
# vmin=0.000001                                                   # echo "${vmin}"
# vmin=0.000003162278                                             # echo "${vmin}"
# vmin=0.00001                                                   # echo "${vmin}"
# vmin=0.00003162278                                             # echo "${vmin}"
# vmin=0.0001                                                    # echo "${vmin}"
# vmin=0.0003162278                                              # echo "${vmin}"
# vmin=0.001                                                     # echo "${vmin}"

iter=0
for i in "${cools[@]}"; do
    # echo_test "${cools[@]}"
    # i="${cools[0]}"                                                            # echo "${i}"
    
    indir="$(dirname ${i})"                                                      # echo "${indir}"
    infile="$(basename ${i})"                                                    # echo "${infile}"
    
    if [[ ${coord} == "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI" ]]; then
        what="genome"
    elif [[ "${coord}" == *" "* ]]; then
        what=$(echo "${coord}" | sed 's/ /-/g')
    else
        # what="$(echo ${coord} | awk -F ':' '{ print $1 }')"
        what="${coord}"
    fi                                                                           # echo "${what}"

    if [[ ${indir} =~ "whole-matrix" ]]; then
        how="$(
            echo ${indir} \
                | awk -F '_' '{ print $4" w all contacts, downsampled wrt "$3 }'
        )"
    else
        how="$(
            echo ${indir} \
                | awk -F '_' '{ print $4" w cis contacts, downsampled wrt "$3 }'
        )"
    fi
    # echo "${how}"

    if [[ "${coord}" == *" "* ]]; then
        title="${what}; ${how}; ${res}-bp res"                                   # echo "${title}"
        suffix="$(
            echo ${title} \
                | awk -F '[;,\\ ]' '{ print $1"_ds-"$10"_"$3"-"$5"-"$6 }' \
                | sed 's/\:/-/g'
        )"
        title="$(echo ${what} | sed 's/-/ /g'); ${how}; ${res}-bp res"           # echo "${title}"
    else
        title="${what}; ${how}; ${res}-bp res"                                   # echo "${title}"
        suffix="$(
            echo ${title} \
                | awk -F '[;,\\ ]' '{ print $1"_ds-"$10"_"$3"-"$5"-"$6 }' \
                | sed 's/\:/-/g'
        )"                                                                       
    fi                                                                           # echo "${suffix}"
    
    outfile="${outdir}/$(basename ${i} .cool).${suffix}.pdf"                     # echo "${outfile}"
    job_name="hicPlotMatrix.$(basename ${outfile} .pdf)"                         # echo "${job_name}"
    err_out_dir="$(dirname ${outfile})/err_out"                                  # echo "${err_out_dir}"

    (( iter++ ))

    check_variables=true
    if ${check_command}; then
        echo """
                \${res}  ${res}
              \${coord}  ${coord}
               \${vmin}  ${vmin}
               \${vmax}  ${vmax}
                \${dpi}  ${dpi}
             \${matcol}  ${matcol}
              \${indir}  ${indir}
             \${infile}  ${infile}
             \${outdir}  ${outdir}
            \${outfile}  ${outfile}
              \${title}  ${title}
           \${job_name}  ${job_name}
        \${err_out_dir}  ${err_out_dir}
        """
    fi

    check_command=true
    if ${check_command}; then
        echo """
        ### ${iter} ###
        run_hicPlotMatrix \\
            -i \"${indir}/${infile}\" \\
            -o \"${outfile}\" \\
            -j \"${job_name}\" \\
            -e \"${err_out_dir}\" \\
            -c \"${coord}\" \\
            -r \"${matcol}\" \\
            -l \\
            -n ${vmin} \\
            -x ${vmax} \\
            -t \"${title}\" \\
            -p ${dpi} \\
            -d
        """
    fi
    
    do_dry_run=true
    if ${do_dry_run}; then
        run_hicPlotMatrix \
            -i "${indir}/${infile}" \
            -o "${outfile}" \
            -j "${job_name}" \
            -e "${err_out_dir}" \
            -c "${coord}" \
            -r "${matcol}" \
            -l \
            -n ${vmin} \
            -x ${vmax} \
            -t "${title}" \
            -p ${dpi} \
            -d
    fi

    run_job=true
    if ${run_job}; then
        run_hicPlotMatrix \
            -i "${indir}/${infile}" \
            -o "${outfile}" \
            -j "${job_name}" \
            -e "${err_out_dir}" \
            -c "${coord}" \
            -r "${matcol}" \
            -l \
            -n ${vmin} \
            -x ${vmax} \
            -t "${title}" \
            -p ${dpi}
    fi

    sleep 0.2
done

#NOTE
#  - 150- or 200-bp resolution looks best for rDNA (but need to zoom in on
#+   left-most repeat), either 0.3 or 0.4 filter (probably 0.4 since that
#+   looks best for the whole XII)
#+ - For trans analyses, going to want to use KR-all-contact normalization, 0.4
#+   filter
```
</details>
<br />

<a id="run-hicexplorer-plothicmatrix-for-log2-ratio-heatmaps"></a>
#### Run HiCExplorer `plotHicMatrix` for log2 ratio heatmaps
<a id="code-12"></a>
##### Code
<details>
<summary><i>Code: Run HiCExplorer `plotHicMatrix` for log2 ratio heatmaps</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
#  (See above.)


#  Configure work environment, directories, and variables =====================
activate_env "hicexplorer_764_env"

#  Set variables, arrays

#NOTE 2023-1019
#  Choice of doing hicCompareMatrice internal normalization largely does not
#+ matter because of how we have subsampled the matrices
# choice="no-norm"                                               # echo "${choice}"
choice="norm"                                                  # echo "${choice}"

# res=6400                                                       # echo "${res}"
# res=5000                                                       # echo "${res}"
# res=3200                                                       # echo "${res}"
res=1600                                                       # echo "${res}"
# res=200                                                        # echo "${res}"
calc="log2ratio"

chr="XII"                                                      # echo "${chr}"
start=451400                                                   # echo "${start}"
end=460800                                                     # echo "${end}"
# coord="${chr}:${start}-${end}"                                 # echo "${coord}"  #GOOD
# coord="${chr}"                                                 # echo "${coord}"
coord="XI XII XIII"                                            # echo "${coord}"

vmax=4                                                         # echo "${vmax}"
vmin=-${vmax}                                                  # echo "${vmin}"

dpi=300                                                        # echo "${dpi}"
matcol="PuOr_r"                                                # echo "${matcol}"

# date="2023-1019"                                               # echo "${date}"
date="2023-1020"                                               # echo "${date}"

if [[ ${coord} == "XI XII XIII" ]]; then
    outdir="pngs/${date}_$(sed 's/ /-/g' <(echo "${coord}"))"  # echo "${outdir}"
else
    outdir="pngs/${date}_$(sed 's/\:/-/g' <(echo "${coord}"))" # echo "${outdir}"
fi

unset cools && typeset -a cools
while IFS=" " read -r -d $'\0'; do
    cools+=( "${REPLY}" )
done < <(
    find \
        12_hicCompareMatrices_genome_KR-filt-0.4_whole-matrix//${choice} \
        -maxdepth 1 \
        -type f \
        -name *.${res}.${calc}.cool \
        -print0 \
            | sort -z
)
# echo_test "${cools[@]}"

# < <(
#     find \
#         12_hicCompareMatrices_XII_KR-filt-0.4/${choice} \
#         -maxdepth 1 \
#         -type f \
#         -name *.${res}.${calc}.cool \
#         -print0 \
#             | sort -z
# )


#  Execute main tasks =========================================================
#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Make outfile directory if it doesn't exist
[[ ! -d "${outdir}" ]] && mkdir -p "${outdir}/err_out" || true

vmax=1.5                                                         # echo "${vmax}"
vmin=-${vmax}                                                  # echo "${vmin}"

iter=0
for i in "${cools[@]}"; do
    # echo_test "${cools[@]}"
    # i="${cools[0]}"                                                            # echo "${i}"
    
    indir="$(dirname ${i})"                                                      # echo "${indir}"
    infile="$(basename ${i})"                                                    # echo "${infile}"
    
    if [[ ${coord} == "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI" ]]; then
        what="genome"
    elif [[ "${coord}" == *" "* ]]; then
        what=$(echo "${coord}" | sed 's/ /-/g')
    else
        # what="$(echo ${coord} | awk -F ':' '{ print $1 }')"
        what="${coord}"
    fi                                                                           # echo "${what}"

    if [[ ${indir} =~ "whole-matrix" ]]; then
        how="$(
            echo ${indir} \
                | awk -F '_' '{ print $4" w all contacts, downsampled wrt "$3 }'
        )"
    else
        how="$(
            echo ${indir} \
                | awk -F '_' '{ print $4" w cis contacts, downsampled wrt "$3 }'
        )"
    fi
    # echo "${how}"

    if [[ "${coord}" == *" "* ]]; then
        title="${what}; ${how}; ${res}-bp res"                                   # echo "${title}"
        suffix="$(
            echo ${title} \
                | awk -F '[;,\\ ]' '{ print $1"_ds-"$10"_"$3"-"$5"-"$6 }' \
                | sed 's/\:/-/g'
        )"
        title="$(echo ${what} | sed 's/-/ /g'); ${how}; ${res}-bp res"           # echo "${title}"
    else
        title="${what}; ${how}; ${res}-bp res"                                   # echo "${title}"
        suffix="$(
            echo ${title} \
                | awk -F '[;,\\ ]' '{ print $1"_ds-"$10"_"$3"-"$5"-"$6 }' \
                | sed 's/\:/-/g'
        )"                                                                       
    fi                                                                           # echo "${suffix}"

    outfile="${outdir}/$(basename ${i} .cool).${vmax}.pdf"                       # echo "${outfile}"
    job_name="hicPlotMatrix.$(basename ${outfile} .pdf)"                         # echo "${job_name}"
    err_out_dir="$(dirname ${outfile})/err_out"                                  # echo "${err_out_dir}"

    (( iter++ ))

    check_variables=true
    if ${check_command}; then
        echo """
                \${res}  ${res}
              \${coord}  ${coord}
               \${vmin}  ${vmin}
               \${vmax}  ${vmax}
                \${dpi}  ${dpi}
             \${matcol}  ${matcol}
              \${indir}  ${indir}
             \${infile}  ${infile}
             \${outdir}  ${outdir}
            \${outfile}  ${outfile}
              \${title}  ${title}
           \${job_name}  ${job_name}
        \${err_out_dir}  ${err_out_dir}
        """
    fi

    check_command=true
    if ${check_command}; then
        echo """
        ### ${iter} ###
        run_hicPlotMatrix \\
            -i \"${indir}/${infile}\" \\
            -o \"${outfile}\" \\
            -j \"${job_name}\" \\
            -e \"${err_out_dir}\" \\
            -c \"${coord}\" \\
            -r \"${matcol}\" \\
            -n ${vmin} \\
            -x ${vmax} \\
            -t \"${title}\" \\
            -p ${dpi} \\
            -d
        """
    fi

    do_dry_run=true
    if ${do_dry_run}; then
        run_hicPlotMatrix \
            -i "${indir}/${infile}" \
            -o "${outfile}" \
            -j "${job_name}" \
            -e "${err_out_dir}" \
            -c "${coord}" \
            -r "${matcol}" \
            -n ${vmin} \
            -x ${vmax} \
            -t "${title}" \
            -p ${dpi} \
            -d
    fi

    run_job=true
    if ${run_job}; then
        run_hicPlotMatrix \
            -i "${indir}/${infile}" \
            -o "${outfile}" \
            -j "${job_name}" \
            -e "${err_out_dir}" \
            -c "${coord}" \
            -r "${matcol}" \
            -n ${vmin} \
            -x ${vmax} \
            -t "${title}" \
            -p ${dpi}
    fi

    sleep 0.2
done
```
</details>
<br />

<a id="9-draw-contact-decay-plots-for-rdna-region"></a>
### 9. Draw contact-decay plots for rDNA region
<a id="call-hicexplorer-hicplotdistvscounts"></a>
#### Call HiCExplorer `hicPlotDistVsCounts`
<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Call HiCExplorer `hicPlotDistVsCounts`</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function create_bed_file() {
    local help=$(
cat << EOM
Usage: create_bed_file -f BED_FILE -c CHROMOSOME -s START -e END -n NAME

Creates a bed file with the specified parameters.

Options:
  -h, --help        Display this help message
  -f, --file        Path to the bed file to be created (required)
  -c, --chromosome  Chromosome name (required)
  -s, --start       Start position (required)
  -e, --end         End position (required)
  -n, --name        Name of the feature (optional)

Example:
  create_bed_file
      -f rDNA_array_left.bed
      -c "XII"
      -s 451500
      -e 460800
      -n rDNA_array_left
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    local bed_file=""
    local chromosome=""
    local start=""
    local end=""
    local name=""
    local dry_run=false

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -f|--file) bed_file="${2}"; shift 2 ;;
            -c|--chromosome) chromosome="${2}"; shift 2 ;;
            -s|--start) start="${2}"; shift 2 ;;
            -e|--end) end="${2}"; shift 2 ;;
            -n|--name) name="${2}"; shift 2 ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if [[ -z "${bed_file}" ]]; then
        echo "Error: Parameter -f|--file is required."
        echo "${help}"
        return 1
    fi

    if [[ -z "${chromosome}" ]]; then
        echo "Error: Parameter -c|--chromosome is required."
        echo "${help}"
        return 1
    fi

    if [[ -z "${start}" ]]; then
        echo "Error: Parameter -s|--start is required."
        echo "${help}"
        return 1
    fi

    if [[ -z  "${end}" ]]; then
        echo "Error: Parameter -e|--end is required."
        echo "${help}"
        return 1
    fi

    # if [[ -z "${name}" ]]; then
    #     echo "Error: Parameter -n|--name is required."
    #     echo "${help}"
    #     return 1
    # fi

    if [[ -f "${bed_file}" && ! "${dry_run}" ]]; then
        echo "Error: ${bed_file} already exists. To avoid overwriting, please"
        echo "       specify a different file or delete the existing one."
        return 1
    fi

    local entry=""
    if [[ -z "${name}" ]]; then
        entry="${chromosome}\t${start}\t${end}"
    else
        entry="${chromosome}\t${start}\t${end}\t${name}"
    fi

    #TODO #FIXME
    # if echo -e test | grep "-q -e"; then
    #     #  echo -e is not supported
    #     print_cmd="printf \"%s\\t%s\\t%s\\t%s\\n\""
    # else
    #     #  echo -e is supported
    #     print_cmd="echo -e"
    # fi

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following entry would be added to"
        echo "${bed_file}:"
        echo -e "${entry}"
        echo ""

        echo "Command that would be called:"
        echo -e "echo -e \"${entry}\" >> \"${bed_file}\""
    else
        echo -e "${entry}" >> "${bed_file}"
        echo "Entry added to ${bed_file}."
    fi
}


function run_hicPlotDistVsCounts() {
    local help=$(
cat << EOM
Usage: run_hicPlotDistVsCounts -m MATRICES -p PLOT_FILE -t TXT_FILE -l LABELS
  [-b BED_FILE] [-x MAX_DEPTH] [-s PLOT_SIZE] [-j JOB_NAME] [-e ERR_OUT_DIR]
  [-d]

Generates a contact-decay plot for Hi-C data.

Options:
  -h, --help          Display this help message
  -m, --matrices      Paths to the input matrices, comma-separated (required)
  -p, --plot-file     Path to the output plot file (required)
  -t, --txt-file      Path to the output txt file (required)
  -l, --labels        Labels for the matrices, comma-separated (required)
  -b, --bed-file      Path to the BED file for domains (optional)
  -x, --max-depth     Maximum depth for the plot (default: 2000000)
  -s, --plot-size     Size of the plot (default: "5 4.2")
  -j, --job-name      Name of the job (required)
  -e, --err-out-dir   Directory for stderr and stdout logs (required)
  -d, --dry-run       Print the sbatch command without executing it

Dependencies:
  hicPlotDistVsCounts: Required for generating the plot
  sbatch: Used for job submission

Example:
  run_hicPlotDistVsCounts
      -m "matrix_Q.cool,matrix_G1.cool,matrix_G2.cool"
      -p "path/to/output_plot.png"
      -t "path/to/output_data.txt"
      -l "label_Q,label_G1,label_G2"
      -b "path/to/rDNA_left_array.bed"
      -x 10000
      -s "5 4.2"
      -j "plotDistVsCounts"
      -e "path/to/logs"
EOM
    )

    if [[ -z "${1}" || "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    local matrices=""
    local plot_file=""
    local txt_file=""
    local labels=""
    local bed_file=""
    local max_depth=2000000
    local plot_size="5 4.2"
    local job_name=""
    local err_out_dir=""
    local dry_run=false
    local debug=true  #  Hardcoded argument

    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -m|--matrices) matrices="${2}"; shift 2 ;;
            -p|--plot-file) plot_file="${2}"; shift 2 ;;
            -t|--data-file) txt_file="${2}"; shift 2 ;;
            -l|--labels) labels="${2}"; shift 2 ;;
            -b|--bed-file) bed_file="${2}"; shift 2 ;;
            -x|--max-depth) max_depth="${2}"; shift 2 ;;
            -s|--plot-size) plot_size="${2}"; shift 2 ;;
            -j|--job-name) job_name="${2}"; shift 2 ;;
            -e|--err-out-dir) err_out_dir="${2}"; shift 2 ;;
            -d|--dry-run) dry_run=true; shift ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements hicPlotDistVsCounts sbatch; then return 1; fi

    #  Add validations for the required parameters here

    if ${debug}; then
        local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

echo "### HARDCODED DEBUG MODE ENABLED ###"
echo "Started job submission."

#  Print all variables
echo "matrices .................... ${matrices}"
echo "plot_file ................... ${plot_file}"
echo "txt_file .................... ${txt_file}"
echo "labels ...................... ${labels}"
echo "bed_file .................... ${bed_file:-"NA"}"
echo "max_depth ................... ${max_depth}"
echo "plot_size ................... ${plot_size}"
echo "job_name .................... ${job_name}"
echo "err_out_dir ................. ${err_out_dir}"
echo "dry_run ..................... ${dry_run}"

#  Print the final command
echo """
Final command:

hicPlotDistVsCounts \
    --matrices $(echo "${matrices}" | tr ',' ' ') \
    --plotFile "${plot_file}" \
    --outFileData "${txt_file}" \
    --labels $(echo "${labels}" | tr ',' ' ') \
    --maxdepth ${max_depth} \
    $(if [[ -n "${bed_file}" ]]; then echo "--domains ${bed_file}"; fi) \
    --plotsize $(echo "${plot_size}" | tr ' ' ' ')
"""

#  Execute the command
hicPlotDistVsCounts \
    --matrices $(echo "${matrices}" | tr ',' ' ') \
    --plotFile "${plot_file}" \
    --outFileData "${txt_file}" \
    --labels $(echo "${labels}" | tr ',' ' ') \
    --maxdepth ${max_depth} \
    $(if [[ -n "${bed_file}" ]]; then echo "--domains ${bed_file}"; fi) \
    --plotsize $(echo "${plot_size}" | tr ' ' ' ')

echo "Completed job submission."
EOF
        )
    else
        local sbatch_script=$(
cat << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${err_out_dir}/${job_name}.%A.stderr.txt"
#SBATCH --output="${err_out_dir}/${job_name}.%A.stdout.txt"

hicPlotDistVsCounts \
    --matrices $(echo "${matrices}" | tr ',' ' ') \
    --plotFile "${plot_file}" \
    --outFileData "${txt_file}" \
    --labels $(echo "${labels}" | tr ',' ' ') \
    --maxdepth ${max_depth} \
    $(if [[ -n "${bed_file}" ]]; then echo "--domains ${bed_file}"; fi) \
    --plotsize $(echo "${plot_size}" | tr ' ' ' ')
EOF
        )
    fi

    if "${dry_run}"; then
        echo "Dry run mode enabled. The following sbatch script would be executed:"
        echo "${sbatch_script}"
    else
        echo "${sbatch_script}" | sbatch
        echo "Job submitted with name '${job_name}'."
    fi

    return 0
}


#  Configure work environment, directories, and variables =====================
activate_env hicexplorer_764_env


#  For generation of bed file -------------------------------------------------
chrom="XII"                                          # echo "${chrom}"
start="451400"                                       # echo "${start}"
end="460800"                                         # echo "${end}"
name="rDNA_left_array"                               # echo "${name}"
bed="${chrom}-${start}-${end}.bed"                   # echo "${bed}"

outdir=beds                                          # echo "${outdir}"
[[ ! -d "${outdir}" ]] && mkdir "${outdir}" || true

outbed="${outdir}/${bed}"                            # echo "${outbed}"


#  For call to hicPlotDistVsCounts --------------------------------------------
pre_Q="MC-2019_Q_WT_repM"                                # echo "${pre_Q}"
pre_G1="MC-2020_30C-a15_WT_repM"                         # echo "${pre_G1}"
pre_G2="MC-2020_nz_WT_repM"                              # echo "${pre_G2}"
midfix="standard-rDNA-complete"                          # echo "${midfix}"
suffix="downsample-to-G1.cool"                           # echo "${suffix}"

res=50                                                   # echo "${res}"
# res=200                                                  # echo "${res}"

# d_mat="11_cooler_XII_KR-filt-0.4"                        # echo "${d_mat}"
d_mat="11_cooler_XII_KR-filt-0.4_rDNA-left-array"        # echo "${d_mat}"
f_Q="${pre_Q}.${midfix}.mapped.${res}.${suffix}"         # echo "${f_Q}"
f_G1="${pre_G1}.${midfix}.mapped.${res}.${suffix}"       # echo "${f_G1}"
f_G2="${pre_G2}.${midfix}.mapped.${res}.${suffix}"       # echo "${f_G2}"

mat_Q="${d_mat}/${f_Q}"                                  # echo "${mat_Q}"
mat_G1="${d_mat}/${f_G1}"                                # echo "${mat_G1}"
mat_G2="${d_mat}/${f_G2}"                                # echo "${mat_G2}"

lab_Q="Q"                                                # echo "${lab_Q}"
lab_G1="G1"                                              # echo "${lab_G1}"
lab_G2="G2-M"                                            # echo "${lab_G2}"

chrom="XII"                                              # echo "${chrom}"
start="451400"                                           # echo "${start}"
end="460800"                                             # echo "${end}"
coord="${chrom}:${start}-${end}"                         # echo "${coord}"
string="$(sed 's/\:/-/g' <(echo "${coord}"))"            # echo "${string}"
# date="2023-1019"                                         # echo "${date}"
date="2023-1020"                                         # echo "${date}"
d_out="pngs/${date}_${string}"                         # ., "${d_out}"
bed="beds/${string}.bed"                                 # ., "${bed}"  # cat "${bed}"
plot="${d_out}/contact-decay_${string}.pdf"              # echo "${plot}"
txt="${d_out}/contact-decay_${string}.txt"               # echo "${txt}"
plot_size="5 4.2"                                        # echo "${plot_size}"

job_name="hicPlotDistVsCounts.$(basename ${plot} .pdf)"  # echo "${job_name}"
err_out_dir="$(dirname ${plot})/err_out"                 # echo "${err_out_dir}"

check_variables=true
if ${check_variables}; then
    echo """
          d_mat  ${d_mat}
            f_Q  ${f_Q}
           f_G1  ${f_G1}
           f_G2  ${f_G2}

          mat_Q  ${mat_Q}
         mat_G1  ${mat_G1}
         mat_G2  ${mat_G2}

          lab_Q  ${lab_Q}
         lab_G1  ${lab_G1}
         lab_G2  ${lab_G2}

          coord  ${coord}
          d_out  ${d_out}
            bed  ${bed}
           plot  ${plot}
            txt  ${txt}

       job_name  ${job_name}
    err_out_dir  ${err_out_dir}
    """
fi


#  Execute main tasks =========================================================
#  Generation of bed file for contact-decay curve -----------------------------
do_dry_run=false
if ${do_dry_run}; then
    create_bed_file \
        -f "${outbed}" \
        -c "${chrom}" \
        -s ${start} \
        -e ${end} \
        -n "${name}" \
        -d
fi

run_command=false
if ${run_command}; then
    create_bed_file \
        -f "${outbed}" \
        -c "${chrom}" \
        -s ${start} \
        -e ${end} #\
        #-n "${name}"
fi


#  Generation of contact-decay curve for left rDNA array ----------------------
[[ ! -d "${err_out_dir}" ]] && mkdir -p "${err_out_dir}" || true

check_command=true
if ${check_command}; then
    echo """
    run_hicPlotDistVsCounts \\
        -m \"${mat_Q},${mat_G1},${mat_G2}\" \\
        -p \"${plot}\" \\
        -d \"${txt}\" \\
        -l \"${lab_Q},${lab_G1},${lab_G2}\" \\
        -j \"${job_name}\" \\
        -e \"${err_out_dir}\" \\
        -d
        
        # -b \"${bed}\" \\
    """
fi

do_dry_run=true
if ${do_dry_run}; then
    run_hicPlotDistVsCounts \
        -m "${mat_Q},${mat_G1},${mat_G2}" \
        -p "${plot}" \
        -t "${txt}" \
        -l "${lab_Q},${lab_G1},${lab_G2}" \
        -j "${job_name}" \
        -e "${err_out_dir}" \
        -d
        
        # -b "${bed}" \
fi

run_command=true
if ${run_command}; then
    run_hicPlotDistVsCounts \
        -m "${mat_Q},${mat_G1},${mat_G2}" \
        -p "${plot}" \
        -t "${txt}" \
        -l "${lab_Q},${lab_G1},${lab_G2}" \
        -j "${job_name}" \
        -e "${err_out_dir}"
        
        # -b "${bed}" \
fi

#NOTE
#  Error from attempting to call run_hicPlotDistVsCounts with left rDNA array
#+ supplied as region in bed file:
#+ 
#+ From hicPlotDistVsCounts.contact-decay_XII-451500-460800.30570507.stderr:
#+ INFO:hicexplorer.hicPlotDistVsCounts:processing chromosome all
#+ 
#+ Traceback (most recent call last):
#+   File "/home/kalavatt/miniconda3/envs/hicexplorer_764_env/bin/hicPlotDistVsCounts", line 7, in <module>
#+     main()
#+   File "/home/kalavatt/miniconda3/envs/hicexplorer_764_env/lib/python3.7/site-packages/hicexplorer/hicPlotDistVsCounts.py", line 428, in main
#+     custom_cut_interval = from_bed_to_cut_interval(hic_ma, args.domains)
#+   File "/home/kalavatt/miniconda3/envs/hicexplorer_764_env/lib/python3.7/site-packages/hicexplorer/hicPlotDistVsCounts.py", line 393, in from_bed_to_cut_interval
#+     "No region overlapped with bins."
#+ AssertionError: No region overlapped with bins.

#NOTE
#  Was finally able to get this working by
#+     1. Making FAN-C .hic files subset to XII:451400-460800 via fanc subset
#+     2. Converting the subset .hic files to .cool files with fanc to-cooler
#+     3. Since the related underlying functions in the FAN-C Python API retain
#+        bias weights by default, was able to supply the subsetted, balanced
#+        .cool to hicPlotDistVsCounts via run_hicPlotDistVsCounts called sans
#+        --bed-file argument
```
</details>
<br />

<a id="wrangle-contact-decay-table-output-by-hicplotdistvscounts"></a>
#### Wrangle contact-decay table output by `hicPlotDistVsCounts`
<a id="code-14"></a>
##### Code
<details>
<summary><i>Code: Wrangle contact-decay table output by `hicPlotDistVsCounts`</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================


#  Configure work environment, directories, and variables =====================
activate_env hicexplorer_764_env

d_proj="${HOME}/tsukiyamalab/kalavatt/2023_rDNA"
d_exp="results/2023-0307_work_Micro-C_align-process"
d_txt="${d_proj}/${d_exp}/pngs/2023-1020_XII-451400-460800"
f_txt="contact-decay_XII-451400-460800.txt"
a_txt="${d_txt}/${f_txt}"


#  Execute main tasks =========================================================
#  Go to work directory
change_dir "${d_proj}/${d_exp}"

#  Read the file and identify the lines that match the header format; store the
#  line numbers of these headers in the 'line_no' array
readarray -t line_no < <(
    #  If it's the first line, consider it as a header and print it
    cat "${a_txt}" \
        | awk -F '\t' \
            'NR==1 { 
                header=$0; print "1: " header 
            } $0 ~ header { 
                if (NR>1) print NR ": " $0
            }' \
        | cut -d : -f 1  # Extract the line numbers from the printed lines
)
# echo_test "${line_no[@]}"
# echo "${#line_no[@]}"

#  Extract lines between headers and save to separate files:
#+ - Iterate over the line numbers stored in 'line_no' array
#+ - Each iteration extracts the content between two headers and saves it to a
#+   new file
for (( i=0; i<${#line_no[@]}-1; i++ )); do
    #  Assign a phase based on the index: Q for the first block, G1 for the
    #+ second
    if [[ ${i} -eq 0 ]]; then
        phase="Q"
    else
        phase="G1"
    fi

    #  Get the starting and ending line numbers for the current block
    start=${line_no[$i]}
    end=$(( ${line_no[$i+1]} - 1 ))

    #  Extract lines between the start and end line numbers and save to a new
    #+ file
    cat "${a_txt}" \
        | awk \
            -v start="${start}" \
            -v end="${end}" \
            'NR>=start && NR<=end' \
            > "${d_txt}/${f_txt%.txt}.${phase}.txt"
done

#  After running the loop, handle the last section (i.e., the third block) from
#+ the last header to the end of the file
phase="G2-M"  # For the last block, the phase is G2-M

#  Extract lines from the last header to the end and save to a new file
cat "${a_txt}" \
    | awk \
        -v start="${line_no[-1]}" \
        'NR>=start' \
        > "${d_txt}/${f_txt%.txt}.${phase}.txt"
```
</details>
<br />

<a id="x-documentation-partial"></a>
### X. Documentation (partial)
<a id="notes-2"></a>
#### Notes
<details>
<summary><i>Notes: X. Documentation (partial)</i></summary>

<a id="fanc-to-fanc---help"></a>
##### `fanc to-fanc --help`
```txt
❯ fanc to-fanc --help
2023-10-09 08:54:12,612 INFO FAN-C version: 0.9.27
usage: fanc from-cooler [-h] [-I] [-tmp] input output

Convert a matrix file (Cooler, Juicer) file to FAN-C format.

positional arguments:
  input                 Input .cool, .mcool, or Juicer .hic file. You must specify the resolution you want to export to FAN-C using the format /path/to/matrix.file@<resolution>, and
                        optionally the Juicer norm as /path/to/matrix.file@<resolution>@<norm>
  output                Output FAN-C file.

options:
  -h, --help            show this help message and exit
  -I, --no-inter-chromosomal
                        Do not copy inter-chromosomal contacts.
  -tmp, --work-in-tmp   Work in temporary directory
```
<br />

<a id="fanc-hic---help"></a>
##### `fanc hic --help`
```txt
❯ fanc hic --help
2023-10-09 10:21:03,529 INFO FAN-C version: 0.9.27
usage: fanc hic [-h] [-b BIN_SIZE] [-l FILTER_LOW_COVERAGE] [-r FILTER_LOW_COVERAGE_RELATIVE] [-a] [-d FILTER_DIAGONAL] [--marginals-plot MARGINALS_PLOT] [--reset-filters]
                [--downsample DOWNSAMPLE] [--subset SUBSET] [-i] [-k] [-n] [-m NORM_METHOD] [-w] [-c] [--only-inter] [-s STATS] [--statistics-plot STATS_PLOT]
                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]] [-f] [-t THREADS] [--deepcopy] [-tmp]
                input [input ...]

Process, filter, and correct Hic files

positional arguments:
  input                 IMPORTANT: The last positional argument will be the output file, unless only a single Hic object is provided. In that case, binning, filtering and correcting will be
                        done in place. Input files. If these are FAN-C Pairs objects (see "fanc pairs"), they will be turned into Hic objects. Hic objects (also the ones converted from
                        Pairs) will first be merged and the merged object will be binned, filtered and corrected as specified in the remaining parameters.

options:
  -h, --help            show this help message and exit
  -b BIN_SIZE, --bin-size BIN_SIZE
                        Bin size in base pairs. You can use human-readable formats,such as 10k, or 1mb. If omitted, the command will end after the merging step.
  -l FILTER_LOW_COVERAGE, --filter-low-coverage FILTER_LOW_COVERAGE
                        Filter bins with low coverage (lower than specified absolute number of contacts)
  -r FILTER_LOW_COVERAGE_RELATIVE, --filter-low-coverage-relative FILTER_LOW_COVERAGE_RELATIVE
                        Filter bins using a relative low coverage threshold (lower than the specified fraction of the median contact count)
  -a, --low-coverage-auto
                        Filter bins with "low coverage" (under 10% of median coverage for all non-zero bins)
  -d FILTER_DIAGONAL, --diagonal FILTER_DIAGONAL
                        Filter bins along the diagonal up to this specified distance. Use 0 for only filtering the diagonal.
  --marginals-plot MARGINALS_PLOT
                        Plot Hi-C marginals to determine low coverage thresholds.
  --reset-filters       Remove all filters from the Hic object.
  --downsample DOWNSAMPLE
                        Downsample a binned Hi-C object before filtering and correcting. Sample size or reference Hi-C object. If sample size is < 1,will be interpreted as a fraction of
                        valid pairs.
  --subset SUBSET       Comma-separated list of regions that will be used in the output Hic object. All contacts between these regions will be in the output object. For example, "chr1,chr3"
                        will result in a Hic object with all regions in chromosomes 1 and 3, plus all contacts within chromosome 1, all contacts within chromosome 3, and all contacts
                        between chromosome 1 and 3. "chr1" will only contain regions and contacts within chromosome 1.
  -i, --ice-correct     DEPRECATED. Use ICE iterative correction on the binned Hic matrix
  -k, --kr-correct      DEPRECATED. Use Knight-Ruiz matrix balancing to correct the binned Hic matrix
  -n, --normalise       Normalise Hi-C matrix according to --norm-method
  -m NORM_METHOD, --norm-method NORM_METHOD
                        Normalisation method used for -n. Options are: KR (default) = Knight-Ruiz matrix balancing (Fast, accurate, but memory-intensive normalisation); ICE = ICE matrix
                        balancing (less accurate, but more memory-efficient); VC = vanilla coverage (a single round of ICE balancing);VC-SQRT = vanilla coverage square root (reduces
                        overcorrection compared to VC)
  -w, --whole-matrix    Correct the whole matrix at once, rather than individual chromosomes.
  -c, --restore-coverage
                        Restore coverage to the original total number of reads. Otherwise matrix entries will be contact probabilities.
  --only-inter          Calculate bias vector only on inter-chromosomal contacts. Ignores all intra-chromosomal contacts. Always uses whole-matrix balancing, i.e. implicitly sets -w
  -s STATS, --statistics STATS
                        Path for saving filter statistics
  --statistics-plot STATS_PLOT
                        Path for saving filter statistics plot (PDF)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Limit output Hic object to these chromosomes. Only available in conjunction with "-b" option.
  -f, --force-overwrite
                        If the specified output file exists, it will be overwritten without warning.
  -t THREADS, --threads THREADS
                        Number of threads (currently used for binning only)
  --deepcopy            Deep copy Hi-C file. Copies a Hi-C file to FAN-C format by duplicating individual bins, pixels, and bias information. Can be used to upgrade an existing FAN-C file
                        with an older version or to convert Cooler or Juicer files to FAN-C format.
  -tmp, --work-in-tmp   Work in temporary directory
```
<br />

<a id="fanc-downsample---help"></a>
##### `fanc downsample --help`
```
❯ fanc downsample --help
2023-10-09 10:23:42,612 INFO FAN-C version: 0.9.27
*** fanc downsample is deprecated. Please use fanc hic --downsample instead! ***
usage: fanc downsample [-h] [-tmp] hic n output

Downsample contacts from a Hic object.

positional arguments:
  hic                  Hic object to be downsampled.
  n                    Sample size or reference Hi-C object. If sample size is < 1,will be interpreted as a fraction of valid pairs.
  output               Downsampled Hic output.

options:
  -h, --help           show this help message and exit
  -tmp, --work-in-tmp  Work in temporary directory


❯ fancplot -p triangular --help
usage: fancplot <region> -p triangular [-h] [--aspect-ratio ASPECT_RATIO] [--title TITLE] [--fix-chromosome] [--hide-x] [--show-minor-ticks] [--hide-major-ticks]
                                       [--show-tick-legend] [-vmin VMIN] [-vmax VMAX] [-m MAX_DIST] [-l] [-r] [-u] [-e] [-c COLORMAP] [-y YLABEL] [-d DEFAULT_VALUE]
                                       [-s COLORBAR_SYMMETRY] [--weight-field WEIGHT_FIELD] [-C]
                                       hic

Triangular Hi-C plot.

positional arguments:
  hic                   Hi-C object.

options:
  -h, --help            show this help message and exit
  --aspect-ratio ASPECT_RATIO
                        Aspect ratio of this panel. Default is determined by figure type (usually 1.0).
  --title TITLE         Title of this plot.
  --fix-chromosome      Fix chromosome identifier for this plot (add or remove "chr" as required). Use this ifthere is a mismatch between the nomenclature used by different datasets
                        in the figure, specifically if the chromosome prefix for this dataset does not match the plot region definition.
  --hide-x              Hide x-axis for this plot
  --show-minor-ticks    Show minor ticks on genome axis
  --hide-major-ticks    Hide major ticks on genome axis.
  --show-tick-legend    Show tick legend with distance between ticks on genome axis
  -vmin VMIN, --minimum-value VMIN
                        Minimum value assigned the first color in the colorbar.
  -vmax VMAX, --maximum-value VMAX
                        Maximum value assigned the last color in the colorbar.
  -m MAX_DIST, --maximum-distance MAX_DIST
                        Maximum distance between two points after which triangle will be truncated.
  -l, --log             Log-scale colorbar.
  -r, --range-slider    Add vmax/vmin slider to plot
  -u, --uncorrected     Plot uncorrected Hi-C matrix values.
  -e, --observed-expected
                        Log2-O/E transform matrix values.
  -c COLORMAP, --colormap COLORMAP
                        Matplotlib colormap
  -y YLABEL, --ylabel YLABEL
                        Label for y axis
  -d DEFAULT_VALUE, --default_value DEFAULT_VALUE
                        Which value to use for missing edge weights (pixels). Default: 0
  -s COLORBAR_SYMMETRY, --colorbar-symmetry COLORBAR_SYMMETRY
                        Make colorbar symmetrical around this value.
  --weight-field WEIGHT_FIELD
                        Which value to use for plotting. Default: weight
  -C, --no-colorbar     Do not show colorbar in plot
```
<br />

<a id="fancplot--p-square---help"></a>
##### `fancplot -p square --help`
```
❯ fancplot -p square --help
usage: fancplot <region> -p square [-h] [--aspect-ratio ASPECT_RATIO] [--title TITLE] [--fix-chromosome] [--hide-x] [--show-minor-ticks] [--hide-major-ticks] [--show-tick-legend]
                                   [-vmin VMIN] [-vmax VMAX] [-u] [-e] [-l] [-r] [-f] [-c COLORMAP] [-s COLORBAR_SYMMETRY] [-C] [--weight-field WEIGHT_FIELD]
                                   hic

Square Hi-C plot.

positional arguments:
  hic                   Hi-C object.

options:
  -h, --help            show this help message and exit
  --aspect-ratio ASPECT_RATIO
                        Aspect ratio of this panel. Default is determined by figure type (usually 1.0).
  --title TITLE         Title of this plot.
  --fix-chromosome      Fix chromosome identifier for this plot (add or remove "chr" as required). Use this ifthere is a mismatch between the nomenclature used by different datasets
                        in the figure, specifically if the chromosome prefix for this dataset does not match the plot region definition.
  --hide-x              Hide x-axis for this plot
  --show-minor-ticks    Show minor ticks on genome axis
  --hide-major-ticks    Hide major ticks on genome axis.
  --show-tick-legend    Show tick legend with distance between ticks on genome axis
  -vmin VMIN, --minimum-value VMIN
                        Minimum value assigned the first color in the colorbar.
  -vmax VMAX, --maximum-value VMAX
                        Maximum value assigned the last color in the colorbar.
  -u, --uncorrected     Plot uncorrected Hi-C matrix values.
  -e, --observed-expected
                        Log2-O/E transform matrix values. Automatically sets colormap to bwr and makes colorbar symmetrical around 0.
  -l, --log             Log-scale colorbar.
  -r, --range-slider    Add vmax/vmin slider to plot
  -f, --flip            Flip matrix upside down
  -c COLORMAP, --colormap COLORMAP
                        Matplotlib colormap
  -s COLORBAR_SYMMETRY, --colorbar-symmetry COLORBAR_SYMMETRY
                        Make colorbar symmetrical around this value.
  -C, --no-colorbar     Do not show colorbar in plot
  --weight-field WEIGHT_FIELD
                        Which value to use for plotting. Default: weight
```
<br />

<a id="fanc-to-cooler---help"></a>
##### `fanc to-cooler --help`
```
❯ fanc to-cooler --help
2023-10-12 13:54:37,522 INFO FAN-C version: 0.9.27
usage: fanc hic_to_cooler [-h] [-u] [-t THREADS] [-M] [-r RESOLUTIONS [RESOLUTIONS ...]] [-S] [--chromosomes CHROMOSOMES] [-tmp] input output

Convert a binned Hic file into cooler format. See https://github.com/mirnylab/cooler for details. If input Hi-C matrix is uncorrected, the uncorrected matrix is stored. If it is
corrected, the uncorrected matrix is stored and the bias vector. Cooler always calculates corrected matrix on-the-fly from the uncorrected matrix and the bias vector.

positional arguments:
  input                 Input binned .hic file, fanc format.
  output                Output cooler file.

options:
  -h, --help            show this help message and exit
  -u, --uncorrected     Output uncorrected matrix.
  -t THREADS, --threads THREADS
                        Number of threads used for balancing.
  -M, --no-multi        Do not produce a multi-resolution file. This is fast, as it does not "coarsen" the matrix at multiple resolutions, but the resulting file will be
                        incompatible with HiGlass!
  -r RESOLUTIONS [RESOLUTIONS ...], --resolutions RESOLUTIONS [RESOLUTIONS ...]
                        Resolutions in bp at which to "coarsen" the cooler matrix. Default resolutions are calculated as base-resolution * 2 ** z, where z is an increasing integer
                        zoom level.
  -S, --no-natural-sort
                        Do not sort regions by their natural chromosome order. When using this option, chromosomes will appear in the Cooler file in the order they are listed in the
                        FAN-C file.
  --chromosomes CHROMOSOMES
                        Comma-separated list of chromosomes to appear in the final Cooler file.
  -tmp, --work-in-tmp   Work in temporary directory
```
<br />

<a id="fanc-subset---help"></a>
##### `fanc subset --help`
```txt
2023-10-20 05:19:44,721 INFO FAN-C version: 0.9.27
usage: fanc subset [-h] input output regions [regions ...]

[deprecated] Create a new Hic object by subsetting.

positional arguments:
  input       Input Hic file.
  output      Output Hic file.
  regions     List of regions that will be used in the output Hic object. All contacts between these regions will be in the output object. For example, "chr1 chr3" will result in a
              Hic object with all regions in chromosomes 1 and 3, plus all contacts within chromosome 1, all contacts within chromosome 3, and all contacts between chromosome 1 and
              3. "chr1" will only contain regions and contactswithin chromosome 1.

options:
  -h, --help  show this help message and exit
```

<a id="hicplotmatrix---help"></a>
##### `hicPlotMatrix --help`
```txt
❯ hicPlotMatrix --help
usage: hicPlotMatrix --matrix MATRIX --outFileName OUTFILENAME [--title TITLE] [--scoreName SCORENAME] [--perChromosome] [--clearMaskedBins]
                     [--chromosomeOrder CHROMOSOMEORDER [CHROMOSOMEORDER ...]] [--region REGION] [--region2 REGION2] [--log1p] [--log] [--colorMap COLORMAP] [--vMin VMIN]
                     [--vMax VMAX] [--dpi DPI] [--bigwig BIGWIG [BIGWIG ...]] [--bigwigAdditionalVerticalAxis] [--vMinBigwig VMINBIGWIG] [--vMaxBigwig VMAXBIGWIG] [--flipBigwigSign]
                     [--scaleFactorBigwig SCALEFACTORBIGWIG] [--fontsize FONTSIZE] [--rotationX ROTATIONX] [--rotationY ROTATIONY] [--increaseFigureWidth INCREASEFIGUREWIDTH]
                     [--increaseFigureHeight INCREASEFIGUREHEIGHT] [--loops LOOPS] [--loopLargeRegionsOperation {first,last,center}] [--tads TADS] [--help] [--version]

Creates a heatmap of a Hi-C matrix.

Required arguments:
  --matrix MATRIX, -m MATRIX
                        Path of the Hi-C matrix to plot.
  --outFileName OUTFILENAME, -out OUTFILENAME
                        File name to save the image.

Optional arguments:
  --title TITLE, -t TITLE
                        Plot title.
  --scoreName SCORENAME, -s SCORENAME
                        Score name label for the heatmap legend.
  --perChromosome       Instead of plotting the whole matrix, each chromosome is plotted next to the other. This parameter is not compatible with --region.
  --clearMaskedBins     If set, masked bins are removed from the matrix and the nearest bins are extended to cover the empty space instead of plotting black lines.
  --chromosomeOrder CHROMOSOMEORDER [CHROMOSOMEORDER ...]
                        Chromosomes and order in which the chromosomes should be plotted. This option overrides --region and --region2.
  --region REGION       Plot only this region. The format is chr:start-end The plotted region contains the main diagonal and is symmetric unless --region2 is given.
  --region2 REGION2     If given, then only the region defined by --region and --region2 is given. The format is the same as --region1.
  --log1p               Plot the log1p of the matrix values.
  --log                 Plot the *MINUS* log of the matrix values.
  --colorMap COLORMAP   Color map to use for the heatmap. Available values can be seen here: http://matplotlib.org/examples/color/colormaps_reference.html (Default: RdYlBu_r).
  --vMin VMIN           Minimum score value.
  --vMax VMAX           Maximum score value.
  --dpi DPI             Resolution for the image in case theoutput is a raster graphics image (e.g png, jpg) (Default: 72).
  --bigwig BIGWIG [BIGWIG ...]
                        Bigwig file to plot below the matrix. This can for example be used to visualize A/B compartments or ChIP-seq data.
  --bigwigAdditionalVerticalAxis
                        Add an additional axis to determine the values of a bigwig file in 2D better.
  --vMinBigwig VMINBIGWIG
                        Minimum score value for bigwig.
  --vMaxBigwig VMAXBIGWIG
                        Maximum score value for bigwig
  --flipBigwigSign      The sign of the bigwig values are flipped. Useful if hicPCA gives inverted values.
  --scaleFactorBigwig SCALEFACTORBIGWIG
                        Scale the values of a bigwig file by the given factor (Default: 1.0).
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis (Default: 10).
  --rotationX ROTATIONX
                        Rotation in degrees for the labels of x axis (Default: 0).
  --rotationY ROTATIONY
                        Rotation in degrees for the labels of y axis (Default: 0).
  --increaseFigureWidth INCREASEFIGUREWIDTH
                        Plotting additional bigwig tracks can cause compression in x or y direction of the heatmap. Set this factor to a value unequal to 0 to correct this (Default:
                        0.5).
  --increaseFigureHeight INCREASEFIGUREHEIGHT
                        Plotting additional bigwig tracks can cause compression in x or y direction of the heatmap. Set this factor to a value unequal to 0 to correct this (Default:
                        0.5).
  --loops LOOPS         Bedgraph file to plot detected long range contacts from hicDetectLoops.
  --loopLargeRegionsOperation {first,last,center}
                        If a given coordinate in the bed file is larger than a bin of the input matrix, by default only the first bin is taken into account. However there are more
                        possibilities to handel such a case. Users can ask for the last bin or for center of the region.
  --tads TADS           Bedgraph file to plot detected tads
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```
</details>
<br />
