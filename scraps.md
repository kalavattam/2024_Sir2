
##### Miscellaneous
###### Code
<details>
<summary><i>Code: Miscellaneous</i></summary>

```bash
#!/bin/bash

#  Setting for which analysis to run: "Q", "G1", or "G2-M"
analysis="Q"  #ARGUMENT  # echo "${analysis}"
# analysis="G1"  #ARGUMENT  # echo "${analysis}"
# analysis="G2-M"  #ARGUMENT  # echo "${analysis}"

#TEMPORARYAPPROACH
#  Sub-setting for "G2-M" analysis: choose which replicate to use
# [[ "${analysis}" == "G2-M" ]] && rep=1  #ARGUMENT
# [[ "${analysis}" == "G2-M" ]] && rep=2  #ARGUMENT
[[ ${analysis} != "G2-M" ]] && rep=NA  #ARGUMENT

flag_rDNA=TRUE  #ARGUMENT  # echo "${flag_rDNA}"

#  Initial setting for flag to *not* run pairtools merge
flag_merge=FALSE  #HARDCODED  # echo "${flag_merge}"

#  Specify samples to analyze
if [[ "${analysis}" == "Q" ]]; then
    p_fq="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742"  # ., "${p_fq}"
    f_pre="SRR7939018"  # ., "${p_fq}/${f_pre}"*
    
    flag_merge=FALSE
elif [[ "${analysis}" == "G1" ]]; then
    p_fq="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA636358"  # ., "${p_fq}"
    f_pre="SRR11893107"  # ., "${p_fq}/${f_pre}"*

    flag_merge=FALSE
elif [[ "${analysis}" == "G2-M" ]]; then
    #  If condition is met, then set flag to *run* pairtools merge
    flag_merge=TRUE  #HARDCODED  # echo "${flag_merge}"
    
    #  Set path and file prefix information
    p_fq="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA636358"  # ., "${p_fq}"
    
    if [[ "${rep}" -eq 1 ]]; then
        f_pre="SRR11893084"  # ., "${p_fq}/${f_pre}"*
    elif [[ "${rep}" -eq 2 ]]; then
        f_pre="SRR11893085"  # ., "${p_fq}/${f_pre}"*
    fi
    
    #  Set up hash, indices (needed for replicate/merge logic below)
    unset arr_merge; unset order
    typeset -A arr_merge; typeset -a order
    arr_merge["SRR11893084"]="SRR11893085"; order+=("SRR11893084")
    arr_merge["SRR11893085"]="SRR11893084"; order+=("SRR11893085")

    run_test=FALSE
    [[ "${run_test}" == TRUE ]] &&
        {
            #  Return hash keys, values in order
            for i in "${order[@]}"; do
                echo "  key  ${i}"
                echo "value  ${arr_merge[${i}]}"
                echo ""
            done
        }
fi

print_test=TRUE  #ARGUMENT
[[ "${print_test}" == TRUE ]] &&
    {
        echo """
        General variables for workflow
        ==============================
        rDNA_pos_l=${rDNA_pos_l}
        rDNA_pos_r=${rDNA_pos_r}
        threads=${threads}
        scratch=${scratch}
        p_fq=${p_fq}
        f_pre=${f_pre}
        rep=${rep}
        """
    }
```
</details>
<br />

<a id="if-applicable-then-run-logic-for-running-pairtools-merge"></a>
##### If applicable, then run logic for running `pairtools merge`
<a id="code-10"></a>
###### Code
<details>
<summary><i>Code: If applicable, then run logic for running pairtools merge</i></summary>

```bash
#!/bin/bash

[[ "${#to_merge[@]}" -eq 0 ]] ||
    {
        unset name_1 && typeset -a name_1
        unset name_2 && typeset -a name_2

        unset in_1_std && typeset -a in_1_std
        unset in_2_std && typeset -a in_2_std

        unset in_1_rDNA && typeset -a in_1_rDNA
        unset in_2_rDNA && typeset -a in_2_rDNA

        unset f_merge_pre_std && typeset -a f_merge_pre_std
        unset f_merge_std && typeset -a f_merge_std
        unset a_merge_std && typeset -a a_merge_std

        unset f_merge_stats_std && typeset -a f_merge_stats_std
        unset a_merge_stats_std && typeset -a a_merge_stats_std

        unset f_merge_cload_std && typeset -a f_merge_cload_std
        unset a_merge_cload_std && typeset -a a_merge_cload_std

        unset f_merge_zoom_std && typeset -a f_merge_zoom_std
        unset a_merge_zoom_std && typeset -a a_merge_zoom_std

        unset f_merge_pre_rDNA && typeset -a f_merge_pre_rDNA
        unset f_merge_rDNA && typeset -a f_merge_rDNA
        unset a_merge_rDNA && typeset -a a_merge_rDNA

        unset f_merge_stats_rDNA && typeset -a f_merge_stats_rDNA
        unset a_merge_stats_rDNA && typeset -a a_merge_stats_rDNA

        unset f_merge_cload_rDNA && typeset -a f_merge_cload_rDNA
        unset a_merge_cload_rDNA && typeset -a a_merge_cload_rDNA

        unset f_merge_zoom_rDNA && typeset -a f_merge_zoom_rDNA
        unset a_merge_zoom_rDNA && typeset -a a_merge_zoom_rDNA

        post="nodups.pairs.gz"  # echo "${post}"

        # for i in "${to_merge[@]}"; do echo "${i}"; done
        for (( i = 0 ; i < ${#to_merge[@]} ; i++ )); do
            # i=0
            
            # echo "${i}"
            # echo "${to_merge[${i}]}"

            #  For pairtools merge
            name_1+=( "${to_merge[${i}]}_rep1" )  # echo "${name_1[${i}]}"
            name_2+=( "${to_merge[${i}]}_rep2" )  # echo "${name_2[${i}]}"

            in_1_std+=( "${d_dedup}/${name_1[${i}]}.standard-${max_mismatch_std}.${post}" )   # ., "${in_1_std[${i}]}"
            in_2_std+=( "${d_dedup}/${name_2[${i}]}.standard-${max_mismatch_std}.${post}" )   # ., "${in_2_std[${i}]}"

            in_1_rDNA+=( "${d_dedup}/${name_1[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}" )  # ., "${in_1_rDNA[${i}]}"
            in_2_rDNA+=( "${d_dedup}/${name_2[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}" )  # ., "${in_2_rDNA[${i}]}"

            [[ -f "${in_1_std[${i}]}" && -f "${in_2_std[${i}]}" ]] \
                || echo "Warning: \"Standard\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
            d_merge=( "${d_dedup}" )                                                        # echo "${d_dedup}"
            f_merge_pre_std+=( "${name_1[${i}]%_rep1}_repM.standard-${max_mismatch_std}" )  # echo "${f_merge_pre_std[${i}]}"
            f_merge_std+=( "${f_merge_pre_std[${i}]}.${post}" )                             # echo "${f_merge_std[${i}]}"
            a_merge_std+=( "${d_merge}/${f_merge_std[${i}]}" )                              # echo "${a_merge_std[${i}]}"

            #  For pairtools stats
            d_merge_stats="06_stats"                                              # echo "${d_merge_stats[${i}]}"
            f_merge_stats_std+=( "${f_merge_pre_std[${i}]}.stats.txt" )           # echo "${f_merge_stats_std[${i}]}"
            a_merge_stats_std+=( "${d_merge_stats}/${f_merge_stats_std[${i}]}" )  # echo "${a_merge_stats_std[${i}]}"

            #  For cooler cload pairs
            d_merge_cload="07_cload"                                              # echo "${d_merge_cload[${i}]}"
            f_merge_cload_std+=( "${f_merge_pre_std[${i}]}.cload.cool" )          # echo "${f_merge_cload_std}"
            a_merge_cload_std+=( "${d_merge_cload}/${f_merge_cload_std[${i}]}" )  # echo "${a_merge_cload_std}"

            #  For cooler zoomify
            d_merge_zoom="08_zoom"                                                # echo "${d_merge_zoom[${i}]}"
            f_merge_zoom_std+=( "${f_merge_pre_std[${i}]}.mcool" )                # echo "${f_merge_zoom_std[${i}]}"
            a_merge_zoom_std+=( "${d_merge_zoom}/${f_merge_zoom_std[${i}]}" )     # echo "${a_merge_zoom_std[${i}]}"

            [[ -f "${in_1_rDNA[${i}]}" && -f "${in_2_rDNA[${i}]}" ]] \
                || echo "Warning: \"rDNA\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
            d_merge="${d_dedup}"                                                            # echo "${d_dedup}"
            f_merge_pre_rDNA+=( "${name_1[${i}]%_rep1}_repM.keep-MM-${max_mismatch_rDNA}" )  # echo "${f_merge_pre_rDNA[${i}]}"
            f_merge_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post}" )                            # echo "${f_merge_rDNA[${i}]}"
            a_merge_rDNA+=( "${d_merge}/${f_merge_rDNA[${i}]}" )                             # echo "${a_merge_rDNA[${i}]}"

            #  For pairtools stats
            d_merge_stats="06_stats"                                               # echo "${d_merge_stats}"
            f_merge_stats_rDNA+=( "${f_merge_pre_rDNA[${i}]}.stats.txt" )           # echo "${f_merge_stats_rDNA[${i}]}"
            a_merge_stats_rDNA+=( "${d_merge_stats}/${f_merge_stats_rDNA[${i}]}" )  # echo "${a_merge_stats_rDNA[${i}]}"

            #  For cooler cload pairs
            d_merge_cload="07_cload"                                               # echo "${d_merge_cload}"
            f_merge_cload_rDNA+=( "${f_merge_pre_rDNA[${i}]}.cload.cool" )          # echo "${f_merge_cload_rDNA[${i}]}"
            a_merge_cload_rDNA+=( "${d_merge_cload}/${f_merge_cload_rDNA[${i}]}" )  # echo "${a_merge_cload_rDNA[${i}]}"

            #  For cooler zoomify
            d_merge_zoom="08_zoom"                                              # echo "${d_merge_zoom}"
            f_merge_zoom_rDNA+=( "${f_merge_pre_rDNA[${i}]}.mcool"  )            # echo "${f_merge_zoom_rDNA[${i}]}"
            a_merge_zoom_rDNA+=( "${d_merge_zoom}/${f_merge_zoom_rDNA[${i}]}" )  # echo "${a_merge_zoom_std[${i}]}"
        done

        print_test=TRUE
        [[ "${print_test}" == TRUE ]] &&
            {
                for (( i=0; i < "${#to_merge[@]}"; i++ )); do
                    # i=0
                    echo """
                    Specific variables for merged .cool files
                    =========================================        
                    pairtools merge: standard
                    -------------------------------
                                name_1=${name_1[${i}]}
                                name_2=${name_2[${i}]}

                               d_merge=${d_merge}

                              in_1_std=${in_1_std[${i}]}
                              in_2_std=${in_2_std[${i}]}

                       f_merge_pre_std=${f_merge_pre_std[${i}]}
                           f_merge_std=${f_merge_std[${i}]}
                           a_merge_std=${a_merge_std[${i}]}

                    pairtools merge: rDNA
                    -------------------------------
                                name_1=${name_1[${i}]}
                                name_2=${name_2[${i}]}

                               d_merge=${d_merge}

                             in_1_rDNA=${in_1_rDNA[${i}]}
                             in_2_rDNA=${in_2_rDNA[${i}]}

                               d_merge=${d_merge}
                      f_merge_pre_rDNA=${f_merge_pre_rDNA[${i}]}
                          f_merge_rDNA=${f_merge_rDNA[${i}]}
                          a_merge_rDNA=${a_merge_rDNA[${i}]}

                    pairtools stats: standard
                    -------------------
                         d_merge_stats=${d_merge_stats}
                     f_merge_stats_std=${f_merge_stats_std[${i}]}
                     a_merge_stats_std=${a_merge_stats_std[${i}]}

                    pairtools stats: rDNA
                    -------------------
                         d_merge_stats=${d_merge_stats}
                    f_merge_stats_rDNA=${f_merge_stats_rDNA[${i}]}
                    a_merge_stats_rDNA=${a_merge_stats_rDNA[${i}]}

                    cooler cload pairs: standard
                    ----------------------
                         d_merge_cload=${d_merge_cload}
                     f_merge_cload_std=${f_merge_cload_std[${i}]}
                     a_merge_cload_std=${a_merge_cload_std[${i}]}

                    cooler cload pairs: rDNA
                    ----------------------
                         d_merge_cload=${d_merge_cload}
                    f_merge_cload_rDNA=${f_merge_cload_rDNA[${i}]}
                    a_merge_cload_rDNA=${a_merge_cload_rDNA[${i}]}

                    For cooler zoomify: standard
                    ------------------
                         d_merge_zoom=${d_merge_zoom}
                     f_merge_zoom_std=${f_merge_zoom_std[${i}]}
                     a_merge_zoom_std=${a_merge_zoom_std[${i}]}

                    For cooler zoomify: rDNA
                    ------------------
                         d_merge_zoom=${d_merge_zoom}
                    f_merge_zoom_rDNA=${f_merge_zoom_rDNA[${i}]}
                    a_merge_zoom_rDNA=${a_merge_zoom_rDNA[${i}]}
                    """
                done
            }
    }
```
</details>
<br />

##### Temporary
###### Code
<details>
<summary><i>Code: Temporary</i></summary>

```bash
#!/bin/bash

        #  Check if ${f_pre} is present in hash ${arr_merge}
        #+
        #+ ${arr_merge[$f_pre]+present} evaluates to "present" if
        #+ arr_merge[$f_pre] is set
        if [[ "${arr_merge[$f_pre]+present}" == "present" ]]; then
            # echo "arr_merge[\$f_pre] is in hash ${arr_merge}"
            # echo "arr_merge[\$f_pre] is set to ${arr_merge[$f_pre]}"
            
            #TODO Logic for if >2, <2, etc.
            if [[ "${#order[@]}" -eq 2 ]]; then
                el_1=0  # echo "${el_1}"
                el_2=1  # echo "${el_2}"
            fi

            #  For pairtools merge
            name_1="${order[${el_1}]}"  # echo "${name_1}"
            name_2="${order[${el_2}]}"  # echo "${name_2}"

            post="nodups.pairs.gz"  # echo "${post}"
            in_1="${d_dedup}/${name_1}.${post}"  # ., "${in_1}"
            in_2="${d_dedup}/${name_2}.${post}"  # ., "${in_2}"

            [[ -f "${in_1}" && -f "${in_2}" ]] ||
                {
                    echo "Warning: Infiles for pairtools merge not found; stopping the operations"
                    return 1
                }

            d_merge="${d_dedup}"  # echo "${d_dedup}"
            f_merge_pre="${name_1}-${name_2}"  # echo "${f_merge_pre}"
            f_merge="${f_merge_pre}.${post}"  # echo "${f_merge}"
            a_merge="${d_merge}/${f_merge}"  # echo "${a_merge}"

            #  For pairtools stats
            d_merge_stats="06_stats"  # echo "${d_merge_stats}"
            f_merge_stats="${f_merge_pre}.stats.txt"  # echo "${f_merge_stats}"
            a_merge_stats="${d_merge_stats}/${f_merge_stats}"  # echo "${a_merge_stats}"

            #  For cooler cload pairs
            d_merge_cload="07_cload"  # echo "${d_merge_cload}"
            f_merge_cload="${f_merge_pre}.cload.cool"  # echo "${f_merge_cload}"
            a_merge_cload="${d_merge_cload}/${f_merge_cload}"  # echo "${a_merge_cload}"

            #  For cooler zoomify
            d_merge_zoom="08_zoom"  # echo "${d_merge_zoom}"
            f_merge_zoom="${f_merge_pre}.mcool"  # echo "${f_merge_zoom}"
            a_merge_zoom="${d_merge_zoom}/${f_merge_zoom}"  # echo "${a_merge_zoom}"
        else
            #  Reset flag to FALSE
            flag_merge=FALSE  # echo "${flag_merge}"
            
            echo "Warning: arr_merge[\$f_pre] is not set; stopping the operations"
            return 1
        fi
    }
```
</details>
<br />
