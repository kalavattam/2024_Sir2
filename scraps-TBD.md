
`...`
<br />
<br />

### 0.A. Strategy
#### Notes
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

### 0.B. Get situated
#### Code
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

### 0.C. Initialize variables for infiles, converted files
#### Code
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

### 1. Use `fanc to-fanc` to convert `07_cload/` `.cool` files to FAN-C `.hic` files
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

### 2. Create binned, unbalanced FAN-C `.hic` files comprised solely of chromosome XII
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

### 3. Referencing the Q XII `.hic` file, use `fanc downsample` to sample G1 XII and G2/M XII `.hic` files
#### Code
<details>
<summary><i>Code: 3. Referencing the Q XII `.hic` file, use `fanc downsample` to sample G1 XII and G2/M XII `.hic` files</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/09_fanc_XII/err_out" ||
    echo "cd'ing failed; check on this"

for i in bin.MC-*30181*.stderr.txt; do echo "${i}"; done
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.100.30181388.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.12800.30181415.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.150.30181391.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.30181409.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.200.30181394.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.300.30181397.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.3200.30181412.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.400.30181400.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.500.30181403.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.50.30181385.stderr.txt
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.800.30181406.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.100.30181389.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.12800.30181416.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.150.30181392.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.30181410.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.200.30181395.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.300.30181398.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.3200.30181413.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.400.30181401.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.500.30181404.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.50.30181386.stderr.txt
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.800.30181407.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.100.30181390.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.12800.30181417.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.150.30181393.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.30181411.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.200.30181396.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.300.30181399.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.3200.30181414.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.400.30181402.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.500.30181405.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.50.30181387.stderr.txt
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.800.30181408.stderr.txt

for i in bin.MC-*30181*.stderr.txt; do
    echo "${i%.30181*.stderr.txt}"
    tail -n 2 "${i}" | head -n 1
    echo ""
done

for i in bin*6400*stderr.txt; do
    echo "${i%.30154*.stderr.txt}"
    tail -n 2 "${i}" | head -n 1
    echo ""
done






# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.         50  1458611
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        100  1113122
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        150  929173
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        200  804035
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        300  635642
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        400  521891
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        500  439664
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.        800  290356
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.       1600  134518
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.       3200  47593
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.       6400  13528
# bin.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.      12800  3489

# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.   50  2396517
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  150  1149227
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  100  1520533
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  200  936439
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  300  694600
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  400  554951
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  500  462047
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.  800  302254
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped. 1600  138677
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped. 3200  47997
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped. 6400  13461
# bin.MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.12800  3488

# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.        50  2924075
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       100  1970132
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       150  1475025
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       200  1160483
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       300  796415
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       400  594827
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       500  468780
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.       800  274081
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.      1600  108256
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.      3200  37203
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.      6400  12623
# bin.MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.     12800  3462

#NOTE
#  Can't draw conclusion about matrix sizes from these values in the stderr
#+ files...
```

```bash
#!/bin/bash

#  Size    Q  14915653  13528
#+ Size   G1  9489211   13461
#+ Size G2/M  10390142  12623
#+ 
#+ Therefore, sample down to size of G1 XII
  XII_Q_6400_down="${XII_Q_6400%.hic}.down-to-G1.hic"
XII_G2M_6400_down="${XII_G2M_6400%.hic}.down-to-G1.hic"

unset downsample && typeset -A downsample
downsample["${XII_Q_6400}"]="${XII_Q_6400_down}"
downsample["${XII_G2M_6400}"]="${XII_G2M_6400_down}"

check_array=TRUE
[[ ${check_array} == TRUE ]] &&
    {
        for i in "${!downsample[@]}"; do
            echo """
              key  ${i}
            value  ${downsample[${i}]}
            """
        done
    }

check_jobs=TRUE
[[ ${check_jobs} == TRUE ]] &&
    {
        for i in "${!downsample[@]}"; do
            job_name="downsample.$(basename ${downsample[${i}]} .hic)"
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

fanc downsample \\
    ${i} \\
    ${XII_G1_6400} \\
    ${downsample[${i}]}
EOF
            """
        done
    }

submit_jobs=TRUE
[[ ${submit_jobs} == TRUE ]] &&
    {
        for i in "${!downsample[@]}"; do
            job_name="downsample.$(basename ${downsample[${i}]} .hic)"
            threads=1

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_XII}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_XII}/err_out/${job_name}.%A.stdout.txt"

fanc downsample \
    ${i} \
    ${XII_G1_6400} \
    ${downsample[${i}]}
EOF
            sleep 0.2
        done
    }

#  For consistency, copy G1, giving it a similar prefix
[[ ! -f ${XII_G1_6400/.hic/.down-to-G1.hic} ]] &&
    cp ${XII_G1_6400} ${XII_G1_6400/.hic/.down-to-G1.hic} ||
    true


#  ----------------------------------------------------------------------------
#  Step 4. Use `fanc hic --filter-low-coverage-relative --statistics
#+         path/to/save/file.txt --statistics-plot path/to/save/file.pdf
#+         --normalise --norm-method "KR" path/to/output/file.hic`

unset downsample && typeset -a downsample
downsample=(
    "${d_XII}/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic"
    "${d_XII}/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic"
    "${d_XII}/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic"
)
# echo_test "${downsample[@]}"

check_commands=TRUE
[[ ${check_commands} == TRUE ]] &&
    {
        for i in "${downsample[@]}"; do
            echo """
            fanc hic \\
                ${i} \\
                --marginals-plot ${i/.hic/.marginals.pdf}
            """
        done
    }

run_commands=TRUE
[[ ${run_commands} == TRUE ]] &&
    {
        for i in "${downsample[@]}"; do
            fanc hic \
                ${i} \
                --marginals-plot ${i/.hic/.marginals.pdf}
        done
    }

#NOTE For now, apply no coverage threshold for balancing

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
    --normalise
EOF
            """
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

fanc hic \\
    ${i} \\
    --normalise
EOF
            sleep 0.2
        done
    }


#  Step 5. Draw example plots of the above-processed .hic files
[[ ! -d pngs ]] && mkdir pngs || true
[[ ! -d pngs/2023-1009 ]] && mkdir pngs/2023-1009 || true


echo ${downsample[0]}
echo ${downsample[1]}
echo ${downsample[2]}

# ❯ echo ${downsample[0]}
# 09_fanc_XII/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic
#
# ❯ echo ${downsample[1]}
# 09_fanc_XII/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic
#
# ❯ echo ${downsample[2]}
# 09_fanc_XII/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.6400.down-to-G1.hic

#  XII, Log_e-transformed, 10E-4 min, 10E1 max
fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[0]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[0]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[1]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[1]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[2]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[2]}"

#  XII, Log_e-transformed, 10E-4 min, 10E1 max, uncorrected
fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[0]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -u -l -vmin 1 -vmax 1000 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[0]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[1]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -u -l -vmin 1 -vmax 1000 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[1]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[2]} .hic).log.pdf" \
    "XII:1-1078177" \
    -p triangular -u -l -vmin 1 -vmax 1000 \
    --title "6400 bp, XII" \
    -c Reds \
    "${downsample[2]}"


#  rDNA, Log_e-transformed, 10E-5 min, 10E1 max
fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[0]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[0]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[1]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[1]}"

fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[2]} .hic).rDNA-full.log_10E-4_10E1.pdf" \
    "XII:451526-468980" \
    -p triangular -l -vmin 0.0001 -vmax 1 \
    --title "6400 bp, XII:451526-468980" \
    -c Reds \
    "${downsample[2]}"


#  Comparisons across XII  #TODO Need to run fanc compare first
fancplot \
    -o "pngs/2023-1009/$(basename ${downsample[0]} .hic).div.pdf" \
    "XII:1-1078177" \
    -p square \
    --title "6400 bp, XII" \
    -s 0 -vmin "-4" -vmax 4 \
    -c "coolwarm" \
    "${d_out}/${m_Q2}"
```
</details>
<br />

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