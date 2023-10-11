
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
1. [2. Create binned, unbalanced FAN-C `.hic` files comprised solely of chromosome XII](#2-create-binned-unbalanced-fan-c-hic-files-comprised-solely-of-chromosome-xii)
    1. [Code](#code-3)
1. [3. Downsample Q, G1, G2/M `.hic` files to smallest matrix](#3-downsample-q-g1-g2m-hic-files-to-smallest-matrix)
    1. [A. Draft `Python` code to dynamically handles the downsampling](#a-draft-python-code-to-dynamically-handles-the-downsampling)
        1. [Code](#code-4)
    1. [B. Convert above test code to `Python` script](#b-convert-above-test-code-to-python-script)
        1. [Code](#code-5)
    1. [C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` files](#c-submit-python-script-calculate_fanc-contact-sumspy-for-resolution-wise-trios-of-hic-files)
        1. [Code](#code-6)
1. [4. Perform KR balancing matrices with `fanc hic` `--low-coverage-auto` mode](#4-perform-kr-balancing-matrices-with-fanc-hic---low-coverage-auto-mode)
    1. [Code](#code-7)
1. [5. Draw example plots of the above-processed `.hic` files](#5-draw-example-plots-of-the-above-processed-hic-files)
    1. [Code](#code-8)
    1. [Printed](#printed)
    1. [Help](#help)

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
2. Use `fanc hic --bin-size 6400 --chromosomes "XII" path/to/output/file.hic` to create unbalanced .hic files comprised solely of XII 
3. Referencing the Q XII .hic file, use `fanc downsample` to sample G1 XII and G2/M XII .hic files to the same size as the Q XII .hic file
4. Use `fanc hic --filter-low-coverage-relative --statistics path/to/save/file.txt --statistics-plot path/to/save/file.pdf --normalise --norm-method "KR" path/to/output/file.hic`
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

check_test_command=TRUE
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

run_test_command=TRUE
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
conversion["${cool_Q}"]="${XII_Q}"
conversion["${cool_G1}"]="${XII_G1}"
conversion["${cool_G2M}"]="${XII_G2M}"

check_array=TRUE
[[ ${check_array} == TRUE ]] &&
    {
        for i in "${!conversion[@]}"; do
            # [[ -f ${i} && ! -f ${conversion[${i}]} ]] &&
            #    {
                    echo """
                     key (cool)  ${i}
                    value (hic)  ${conversion[${i}]}
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
        for i in "${!conversion[@]}"; do
            [[ -f ${i} && ! -f ${conversion[${i}]} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
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

                    fanc from-cooler \\
                        ${i} \\
                        ${conversion[${i}]}
                    EOF
                    """
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
        for i in "${!conversion[@]}"; do
            [[ -f ${i} && ! -f ${conversion[${i}]} ]] &&
                {
                    job_name="to-fanc.$(basename ${i} .cool)"
                    threads=1
            
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
    ${conversion[${i}]}
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

<a id="2-create-binned-unbalanced-fan-c-hic-files-comprised-solely-of-chromosome-xii"></a>
### 2. Create binned, unbalanced FAN-C `.hic` files comprised solely of chromosome XII
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: 2. Create binned, unbalanced FAN-C `.hic` files comprised solely of chromosome XII</i></summary>

```bash
#!/bin/bash

threads=4
chroms="XII"
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 6400 12800
)

check_array=FALSE
[[ ${check_array} ]] && echo_test "${res[@]}" || true
    
for j in "${res[@]}"; do
    # j=${res[10]}  # echo "${j}"

    XII_Q_bin="${XII_Q%.hic}.${j}.hic"
    XII_G1_bin="${XII_G1%.hic}.${j}.hic"
    XII_G2M_bin="${XII_G2M%.hic}.${j}.hic"

    unset bin && typeset -A bin
    bin["${XII_Q}"]="${XII_Q_bin}"
    bin["${XII_G1}"]="${XII_G1_bin}"
    bin["${XII_G2M}"]="${XII_G2M_bin}"

    check_array=FALSE
    [[ ${check_array} == TRUE ]] &&
        {
            for i in "${!bin[@]}"; do
                echo """
                key (all, 25)  ${i}
                value (${chroms}, ${j})  ${bin[${i}]}
                """
            done
        } || true

    check_jobs=TRUE
    [[ ${check_jobs} == TRUE ]] &&
        {
            for i in "${!bin[@]}"; do
                [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                    {
                        job_name="bin.$(basename ${bin[${i}]} .hic)"

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
                            ${bin[${i}]} \\
                            --threads ${threads} \\
                            --bin-size ${j} \\
                            --chromosomes \"${chroms}\"
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
                [[ -f ${i} && ! -f ${bin[${i}]} ]] &&
                    {
                        job_name="bin.$(basename ${bin[${i}]} .hic)"

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
    --chromosomes "${chroms}"
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
```
</details>
<br />

<a id="3-downsample-q-g1-g2m-hic-files-to-smallest-matrix"></a>
### 3. Downsample Q, G1, G2/M `.hic` files to smallest matrix
<a id="a-draft-python-code-to-dynamically-handles-the-downsampling"></a>
#### A. Draft `Python` code to dynamically handles the downsampling
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: A. Draft `Python` code to dynamically handles the downsampling</i></summary>

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

<a id="c-submit-python-script-calculate_fanc-contact-sumspy-for-resolution-wise-trios-of-hic-files"></a>
#### C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` files
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: C. Submit `Python` script `calculate_fanc-contact-sums.py` for resolution-wise trios of `.hic` files</i></summary>

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

run_test_script=FALSE
[[ ${run_test_script} == TRUE ]] &&
    {
        ls -1 "${d_XII}/"*".800.hic"

        test_Q="${d_XII}/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.800.hic"
        test_G1="${d_XII}/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.800.hic"
        test_G2="${d_XII}/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.800.hic"

        python calculate_fanc-contact-sums.py \
            --Q_infile "${test_Q}" \
            --G1_infile "${test_G1}" \
            --G2_infile "${test_G2}"
    } || true

threads=1
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 6400 12800
)

check_array=FALSE
[[ ${check_array} ]] && echo_test "${res[@]}" || true

for j in "${res[@]}"; do
    # j=${res[10]}  # echo "${j}"

    XII_Q_bin="$( find ${d_XII} -name MC-2019_Q_*.${j}.hic )"
    XII_G1_bin="$( find ${d_XII} -name MC-2020_30C-a15_*.${j}.hic )"
    XII_G2M_bin="$( find ${d_XII} -name MC-2020_nz_*.${j}.hic )"

    check_files=FALSE
    [[ ${check_files} == TRUE ]] &&
        {
            # echo XII_Q_bin
            # echo XII_G1_bin
            # echo XII_G2M_bin

            ls -lhaFG "${XII_Q_bin}"
            ls -lhaFG "${XII_G1_bin}"
            ls -lhaFG "${XII_G2M_bin}"
        } || true

    check_jobs=TRUE
    [[ ${check_jobs} == TRUE ]] &&
        {
            XII_Q_out="${XII_Q_bin%.hic}.downsample-to-G1.hic"      # echo "${XII_Q_out}"
            XII_G1_out="${XII_G1_bin%.hic}.downsample-to-G1.hic"    # echo "${XII_G1_out}"
            XII_G2M_out="${XII_G2M_bin%.hic}.downsample-to-G1.hic"  # echo "${XII_G2M_out}"
            [[ 
                  -f ${XII_Q_bin} &&   -f ${XII_G1_bin} &&   -f ${XII_G2M_bin} &&
                ! -f ${XII_Q_out} && ! -f ${XII_G1_out} && ! -f ${XII_G2M_out}
            ]] &&
                {
                    job_name="downsample_files-hic-${j}"

                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error=\"${d_XII}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_XII}/err_out/${job_name}.%A.stdout.txt\"

                    python calculate_fanc-contact-sums.py \\
                        --Q_infile \"${XII_Q_bin}\" \\
                        --G1_infile \"${XII_G1_bin}\" \\
                        --G2_infile \"${XII_G2M_bin}\"
                    EOF
                    """
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: Did not run command.

                    Check the following infiles, one or more of which may
                    not exist:
                        - ${XII_Q_bin}
                        - ${XII_G1_bin}
                        - ${XII_G2M_bin}

                    Or check the following outfiles, one or more of which
                    may already exist:
                        - ${XII_Q_out}
                        - ${XII_G1_out}
                        - ${XII_G2M_out}
                    """
                }
        } || true

    submit_jobs=TRUE
    [[ ${submit_jobs} == TRUE ]] &&
        {
            XII_Q_out="${XII_Q_bin%.hic}.downsample-to-G1.hic"      # echo "${XII_Q_out}"
            XII_G1_out="${XII_G1_bin%.hic}.downsample-to-G1.hic"    # echo "${XII_G1_out}"
            XII_G2M_out="${XII_G2M_bin%.hic}.downsample-to-G1.hic"  # echo "${XII_G2M_out}"
            [[ 
                  -f ${XII_Q_bin} &&   -f ${XII_G1_bin} &&   -f ${XII_G2M_bin} &&
                ! -f ${XII_Q_out} && ! -f ${XII_G1_out} && ! -f ${XII_G2M_out}
            ]] &&
                {
                    job_name="downsample_files-hic-${j}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

python calculate_fanc-contact-sums.py \
--Q_infile "${XII_Q_bin}" \
--G1_infile "${XII_G1_bin}" \
--G2_infile "${XII_G2M_bin}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: Did not run command.

                    Check the following infiles, one or more of which may
                    not exist:
                        - ${XII_Q_bin}
                        - ${XII_G1_bin}
                        - ${XII_G2M_bin}

                    Or check the following outfiles, one or more of which
                    may already exist:
                        - ${XII_Q_out}
                        - ${XII_G1_out}
                        - ${XII_G2M_out}
                    """
                }
        } || true
done
```
</details>
<br />

<a id="4-perform-kr-balancing-matrices-with-fanc-hic---low-coverage-auto-mode"></a>
### 4. Perform KR balancing matrices with `fanc hic` `--low-coverage-auto` mode
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: 4. Perform KR balancing matrices with `fanc hic` `--low-coverage-auto` mode</i></summary>

```bash
#!/bin/bash

threads=1
unset res && typeset -a res=(
    50 100 150 200 300 400 500 800 1600 3200 6400 12800
)

check_array=FALSE
[[ ${check_array} ]] && echo_test "${res[@]}" || true
    
for j in "${res[@]}"; do
    # j="${res[9]}"
    
    XII_Q_down="$(
        find ${d_XII} -name MC-2019_Q_*.${j}.downsample-*.hic
    )"  # echo "${XII_Q_down}"
    XII_G1_down="$(
        find ${d_XII} -name MC-2020_30C-a15_*.${j}.downsample-*.hic
    )"  # echo "${XII_G1_down}"
    XII_G2M_down="$(
        find ${d_XII} -name MC-2020_nz_*.${j}.downsample-*.hic
    )"  # echo "${XII_G2M_down}"

    unset downsample && typeset -a downsample=(
        "${XII_Q_down}"
        "${XII_G1_down}"
        "${XII_G2M_down}"
    )
    
    check_array=TRUE
    [[ ${check_array} ]] && echo_test "${downsample[@]}" || true

    check_command=TRUE
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

    run_command=TRUE
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
                    --low-coverage-auto \\
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
    --low-coverage-auto \
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

[[ ! -d pngs/2023-1010 ]] && mkdir pngs/2023-1010 || true

outdir="pngs/2023-1010"
j=6400

XII_Q_down="$(
    find ${d_XII} -name MC-2019_Q_*.${j}.downsample-*.hic
)"  # echo "${XII_Q_down}"
XII_G1_down="$(
    find ${d_XII} -name MC-2020_30C-a15_*.${j}.downsample-*.hic
)"  # echo "${XII_G1_down}"
XII_G2M_down="$(
    find ${d_XII} -name MC-2020_nz_*.${j}.downsample-*.hic
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
        -p triangular -l -vmin 0.0001 -vmax 1 \
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

```bash
#  rDNA, Log_e-transformed, 10E-5 min, 10E1 max
fancplot \
    -o "${outdir}/$(basename ${downsample[0]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[0]}"

fancplot \
    -o "${outdir}/$(basename ${downsample[1]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[1]}"

fancplot \
    -o "${outdir}/$(basename ${downsample[2]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[2]}"


#  Comparisons across XII  #TODO Need to run fanc compare first
fancplot \
    -o "${outdir}/$(basename ${downsample[0]} .hic).div.pdf" \
    "XII:1-1078177" \
    -p square \
    --title "6400 bp, XII" \
    -s 0 -vmin "-4" -vmax 4 \
    -c "coolwarm" \
    "${d_out}/${m_Q2}"
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
...


❯ check_test_command=TRUE
❯ [[ ${check_test_command} == TRUE ]] &&
>     {
>         echo """
>         fanc from-cooler \\
>             ${cool_Q} \\
>             ${XII_Q}
>         """
>     } || true

        fanc from-cooler \
            07_cload/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.cool \
            09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.hic


❯ run_test_command=TRUE
❯ [[ ${run_test_command} == TRUE ]] &&
>     {
>         fanc from-cooler \
>             ${cool_Q} \
>             ${XII_Q}
>     } || true
100% (28826633 of 28826633) |###########################################################################################################################| Elapsed Time: 0:03:14 Time:  0:03:14
Buffers 100% (5151 of 5151) |###########################################################################################################################| Elapsed Time: 0:00:11 Time:  0:00:11
Expected 100% (28826633 of 28826633) |##################################################################################################################| Elapsed Time: 0:03:26 Time:  0:03:26
2023-10-09 11:10:51,779 INFO All done.
Closing remaining open files:09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.hic...done


...


❯ [[ ${check_array} == TRUE ]] &&
>     {
>         for i in "${!downsample[@]}"; do
>             echo """
>               key  ${i}
>             value  ${downsample[${i}]}
>             """
>         done
>     }

              key  09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.hic
            value  09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic


              key  09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.hic
            value  09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic


❯ check_jobs=TRUE
❯ [[ ${check_jobs} == TRUE ]] &&
>     {
>         for i in "${!downsample[@]}"; do
>             job_name="downsample.$(basename ${downsample[${i}]} .hic)"
>             threads=1
> 
>             echo """
> #HEREDOC
> sbatch << EOF
> #!/bin/bash
> 
> #SBATCH --job-name="${job_name}"
> #SBATCH --nodes=1
> #SBATCH --cpus-per-task=${threads}
> #SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
> #SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"
> 
> fanc downsample \\
>     ${i} \\
>     ${XII_G1_6400} \\
>     ${downsample[${i}]}
> EOF
>             """
>         done
>     }

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=downsample.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error=09_fanc_XII/err_out/downsample.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.%A.stderr.txt
#SBATCH --output=09_fanc_XII/err_out/downsample.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.%A.stdout.txt

fanc downsample \
    09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.hic \
    09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.hic \
    09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic
EOF


#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=downsample.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error=09_fanc_XII/err_out/downsample.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.%A.stderr.txt
#SBATCH --output=09_fanc_XII/err_out/downsample.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.%A.stdout.txt

fanc downsample \
    09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.hic \
    09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.hic \
    09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic
EOF
```
</details>
<br />

<a id="help"></a>
#### Help
<details>
<summary><i>Help</i></summary>

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
```
</details>
<br />

<details>
<summary><i>Code: Drafting code for a masking approach...</i></summary>

```bash
#!/bin/bash


mkdir test-masking

cp 09_fanc_XII/*6400.downsample*hic test-masking/

cd test-masking/

mv MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.downsample-to-G1.hic Q.hic
mv MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.downsample-to-G1.hic G1.hic
mv MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.downsample-to-G1.hic G2.hic

python
```

```python
#!/usr/bin/env python3

import fanc
import numpy as np

#  Load the .hic files
hic_files = ["Q.hic", "G1.hic", "G2.hic"]
hics = [fanc.load(hic_file) for hic_file in hic_files]

#  Print file name and some information about each .hic file
run_check = True
if run_check:
    for hic in hics:
        print("\n" + "="*40 + "\n")  # This prints a separator between files
        print(f"File: {hic.file.filename}")
        print(f"Matrix size: {hic.matrix().shape}")
        print(f"Sum of contacts: {np.nansum(hic.matrix())}")

#  Identify NaN and low-coverage bins
nan_bins = set()
low_coverage_bins = set()

for hic in hics:
    matrix = hic.matrix(balance=False, mask=False)  # Access uncorrected matrix
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
        matrix = hic.matrix(balance=False, as_pixels=True, join_regions=False)
        print(f"Hi-C matrix {i+1}:")
        for bin_index in combined_bins:
            print(f"  Bin {bin_index} value before: {matrix[bin_index, bin_index]}")

# Print bin values before setting to NaN
print("Before setting to NaN:")
print_bin_values(hics, combined_bins)

# Set the values of the combined bins to NaN in each Hi-C object and print the matrix
for i, hic in enumerate(hics):
    matrix = hic.matrix(balance=False, as_pixels=True, join_regions=False)  # Access uncorrected matrix as pixels
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
        matrix = hic.matrix(balance=False)  # Access uncorrected matrix
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
    matrix = hic.matrix(balance=False)  # Access uncorrected matrix
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
    matrix = hic.matrix(balance=False)  # Access uncorrected matrix
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
    matrix = hic.matrix(balance=False)                                      # Access uncorrected matrix
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