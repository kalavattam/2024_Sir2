
`work_Micro-C_align-process-etc_scraps_2023-1007.md`
<br />
<br />

<details>
<summary><i>Code: Previously with Step #3</i></summary>

```bash
#!/bin/bash

#  Examine the pairs outfile ==================================================
run_check=FALSE  #UNTESTED
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ ! -f "${a_pairs_std[${i}]}" ]] &&
                {
                    ., "${a_pairs_std[${i}]}"

                    zcat "${a_pairs_std[${i}]}" | wc -l
                    samtools view -c "${a_bam[${i}]}"

                    samtools view "${a_bam[${i}]}" | head

                    n_lines="$(zcat "${a_pairs_std[${i}]}" | wc -l)"
                    echo $(( n_lines - 41 ))  # Subtract header, column-name lines  #TODO grep -v header

                    n_pairs="$(samtools view -c "${a_bam[${i}]}")"
                    echo $(( n_pairs / 2 ))

                    echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing?

                    zcat "${a_pairs_std[${i}]}" | head -100
                    zcat "${a_pairs_std[${i}]}" | tail -100
                }

            [[ ! -f "${a_pairs_rDNA[${i}]}" ]] &&
                {
                    ., "${a_pairs_rDNA[${i}]}"

                    zcat "${a_pairs_rDNA[${i}]}" | wc -l
                    samtools view -c "${a_bam[${i}]}"

                    samtools view "${a_bam[${i}]}" | head

                    n_lines="$(zcat "${a_pairs_rDNA[${i}]}" | wc -l)"
                    echo $(( n_lines - 41 ))  # Subtract header, column-name lines  #TODO grep -v header

                    n_pairs="$(samtools view -c "${a_bam[${i}]}")"
                    echo $(( n_pairs / 2 ))

                    echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing?

                    zcat "${a_pairs_rDNA[${i}]}" | head -100
                    zcat "${a_pairs_rDNA[${i}]}" | tail -100
                }
        done
    } ||
    {
        echo """
        Warning: \"run_check\" for pairs outfiles did not run; pairs files not
                 found; stopping the operation
        """
    }


#  Examine the stats outfile ==================================================
run_check=FALSE  #UNTESTED
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_stats_std[${i}]}" ]] &&
                {
                    ., "${a_stats_std[${i}]}"

                    cat "${a_stats_std[${i}]}" | wc -l

                    cat "${a_stats_std[${i}]}"
                }

            [[ -f "${a_stats_rDNA[${i}]}" ]] &&
                {
                    ., "${a_stats_rDNA[${i}]}"

                    cat "${a_stats_rDNA[${i}]}" | wc -l

                    cat "${a_stats_rDNA[${i}]}"
                }
        done
    } ||
    {
        echo """
        Warning: \"run_check\" for stats outfile did not run; stats files not
                 found; stopping the operation
        """
    }
```
</details>
<br />

<details>
<summary><i>Code: Previously with Step #4</i></summary>

```bash
#!/bin/bash

#  Examine the sorted pairs outfile ===========================================
run_check=FALSE  #UNTESTED
[[ "${run_check}" == TRUE ]] && 
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" ]] &&
                {
                    ., "${a_sort_std[${i}]}"

                    n_lines="$(zcat "${a_sort_std[${i}]}" | wc -l)"
                    echo "${n_lines}"
                    echo $(( n_lines - 43 ))  # Subtract header, column-name lines

                    zcat "${a_sort_std[${i}]}" | head -100
                    zcat "${a_sort_std[${i}]}" | tail -100
                }

            [[ -f "${a_sort_rDNA[${i}]}" ]] &&
                {
                    ., "${a_sort_rDNA[${i}]}"

                    n_lines="$(zcat "${a_sort_rDNA[${i}]}" | wc -l)"
                    echo "${n_lines}"
                    echo $(( n_lines - 43 ))  # Subtract header, column-name lines

                    zcat "${a_sort_rDNA[${i}]}" | head -100
                    zcat "${a_sort_rDNA[${i}]}" | tail -100
                }
        done
    } ||
    {
        echo """
        Warning: \"run_check\" for sort outfiles did not run; sorted files not
                 found; stopping the operation
        """
    }
```
</details>
<br />

<details>
<summary><i>Code: Previously with Step #X. Create *.keep-MM-0.mapped.pairs.gz files if applicable</i></summary>

```bash
#!/bin/bash

print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[
                  -f "${a_dedup_pre_pairs_rDNA[${i}]}" &&
                  -f "${a_dup_pre_pairs_rDNA[${i}]}" &&
                ! -f "${a_map_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="sort.${f_map_pre_rDNA[${i}]%.sort}"  # echo "${job_name}"

                    echo """
                    [[ ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \\
                                ${a_dedup_pre_pairs_rDNA[${i}]} \\
                                    > ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                        }
                    
                    [[ ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \\
                                ${a_dup_pre_pairs_rDNA[${i}]} \\
                                    > ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }
                    
                    [[ 
                          -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]%.gz}
                    ]] &&
                        {
                            cat \\
                                ${a_dedup_pre_pairs_rDNA[${i}]%.gz} \\
                                ${a_dup_pre_pairs_rDNA[${i}]%.gz} \\
                                    > ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }

                    [[
                          -f ${a_map_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
                            pbgzip ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }
                    
                    [[ -f ${a_map_pre_pairs_rDNA[${i}]} ]] &&
                        {
                            rm ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                            rm ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }

                    [[ 
                        ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \\
    --nproc \"${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_map_sort_pre_pairs_rDNA[${i}]}\" \\
    \"${a_map_pre_pairs_rDNA[${i}]}\"

[[ -f ${a_map_sort_pre_pairs_rDNA[${i}]} ]] &&
    {
        mv -f \\
            ${a_map_sort_pre_pairs_rDNA[${i}]} \\
            ${a_map_pre_pairs_rDNA[${i}]}
    }
EOF
                        }

                    """

                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: \"rDNA\" deduplicated pairs file $(basename ${a_merge_std[${i}]}) not found or
                             \"rDNA\" duplicated pairs file $(basename ${a_merge_std[${i}]}) not found;
                             \"Step #X: Create *.keep-MM-0.mapped.pairs.gz files if applicable\" did not run
                    """
                }
        done
    } || true

run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[
                  -f "${a_dedup_pre_pairs_rDNA[${i}]}" &&
                  -f "${a_dup_pre_pairs_rDNA[${i}]}" &&
                ! -f "${a_map_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="sort.${f_map_pre_rDNA[${i}]%.sort}"  # echo "${job_name}"

                    echo """
                    [[ ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \\
                                ${a_dedup_pre_pairs_rDNA[${i}]} \\
                                    > ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                        }
                    """

                    [[ ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \
                                ${a_dedup_pre_pairs_rDNA[${i}]} \
                                    > ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                        }

                    echo """
                    [[ ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \\
                                ${a_dup_pre_pairs_rDNA[${i}]} \\
                                    > ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }
                    """

                    [[ ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} ]] &&
                        {
                            pbgzip -dc \
                                ${a_dup_pre_pairs_rDNA[${i}]} \
                                    > ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }

                    echo """
                    [[ 
                          -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]%.gz}
                    ]] &&
                        {
                            cat \\
                                ${a_dedup_pre_pairs_rDNA[${i}]%.gz} \\
                                ${a_dup_pre_pairs_rDNA[${i}]%.gz} \\
                                    > ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }
                    """

                    [[ 
                          -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]%.gz}
                    ]] &&
                        {
                            cat \
                                ${a_dedup_pre_pairs_rDNA[${i}]%.gz} \
                                ${a_dup_pre_pairs_rDNA[${i}]%.gz} \
                                    > ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }

                    echo """
                    [[
                          -f ${a_map_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
                            pbgzip ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }
                    """

                    [[
                          -f ${a_map_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
                            pbgzip ${a_map_pre_pairs_rDNA[${i}]%.gz}
                        }

                    echo """
                    [[ -f ${a_map_pre_pairs_rDNA[${i}]} ]] &&
                        {
                            rm ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                            rm ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }
                    """

                    [[ -f ${a_map_pre_pairs_rDNA[${i}]} ]] &&
                        {
                            rm ${a_dedup_pre_pairs_rDNA[${i}]%.gz}
                            rm ${a_dup_pre_pairs_rDNA[${i}]%.gz}
                        }

                    echo """
                    [[ 
                        ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \\
    --nproc "${threads}" \\
    --tmpdir "${scratch}" \\
    --output "${a_map_sort_pre_pairs_rDNA[${i}]}" \\
    "${a_map_pre_pairs_rDNA[${i}]}"

[[ -f ${a_map_sort_pre_pairs_rDNA[${i}]} ]] &&
    {
        mv -f \\
            ${a_map_sort_pre_pairs_rDNA[${i}]} \\
            ${a_map_pre_pairs_rDNA[${i}]}
    }
EOF
                        }
                    """
                    
                    [[ 
                        ! -f ${a_dedup_pre_pairs_rDNA[${i}]%.gz} &&
                        ! -f ${a_dup_pre_pairs_rDNA[${i}]%.gz} &&
                          -f ${a_map_pre_pairs_rDNA[${i}]}
                    ]] &&
                        {
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_map_sort_pre_pairs_rDNA[${i}]}" \
    "${a_map_pre_pairs_rDNA[${i}]}"

[[ -f ${a_map_sort_pre_pairs_rDNA[${i}]} ]] &&
    {
        mv -f \
            ${a_map_sort_pre_pairs_rDNA[${i}]} \
            ${a_map_pre_pairs_rDNA[${i}]}
    }
EOF
                        }

                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: \"rDNA\" deduplicated pairs file $(basename ${a_merge_std[${i}]}) not found or
                             \"rDNA\" duplicated pairs file $(basename ${a_merge_std[${i}]}) not found;
                             \"Step #X: Create *.keep-MM-0.mapped.pairs.gz files if applicable\" did not run
                    """
                }
        done
    } || true
```
</details>
<br />

<details>
<summary><i>Code: Scraps from refactoring Step #X. Create *.keep-MM-0.mapped.pairs.gz files if applicable</i></summary>

```bash
#!/bin/bash


#  Previous sub-invocation of pairtools split for "standard" pairs
# --output \\
#     >(
#         pairtools split \\
#             --cmd-in \"pbgzip -dc -n ${threads}\" \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dedup_pre_pairs_std[${i}]}\"
#     ) \\
# --output-dups \\
#     >(
#         pairtools split \\
#             --cmd-in \"pbgzip -dc -n ${threads}\" \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dup_pre_pairs_std[${i}]}\"
#     )

#  Previous sub-invocation of pairtools split for "rDNA" pairs
# --output \\
#     >(
#         pairtools split \\
#             --cmd-in \"pbgzip -dc -n ${threads}\" \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dedup_pre_pairs_rDNA[${i}]}\"
#     ) \\
# --output-dups \\
#     >(
#         pairtools split \\
#             --cmd-in \"pbgzip -dc -n ${threads}\" \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dup_pre_pairs_rDNA[${i}]}\"
#     )

#  Previous incorrect sub-invocations of pbgzip for "standard" and "rDNA" pairs
# --output \\
#     >(
#         pairtools split \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dedup_pre_pairs_std[${i}]}\"
#     ) \\
#
# --output \\
#     >(
#         pairtools split \\
#             --cmd-out \"pbgzip -c -n ${threads}\" \\
#             --output-pairs \"${a_dedup_pre_pairs_rDNA[${i}]}\"
#     ) \\


#  Previous sub-invocation of pairtools split for "standard" pairs
# --output \
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dedup_pre_pairs_std[${i}]}"
#     ) \
# --output-dups \
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dup_pre_pairs_std[${i}]}"
#     ) \

#  Previous sub-invocation of pairtools split for "rDNA" pairs
# --output \
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dedup_pre_pairs_rDNA[${i}]}"
#     ) \
# --output-dups \
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dup_pre_pairs_rDNA[${i}]}"
#     ) \

#  Previous incorrect sub-invocations of pbgzip for "standard" and "rDNA" pairs
# --output \\
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dedup_pre_pairs_std[${i}]}"
#     ) \
#
# --output \\
#     >(
#         pairtools split \
#             --cmd-out "pbgzip -c -n ${threads}" \
#             --output-pairs "${a_dedup_pre_pairs_rDNA[${i}]}"
#     ) \
```
</details>
<br />
