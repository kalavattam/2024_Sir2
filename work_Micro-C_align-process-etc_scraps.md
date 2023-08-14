
## Miscellaneous
### Code
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
    arr_merge["SRR11893084"]="SRR11893085"; order+=( "SRR11893084" )
    arr_merge["SRR11893085"]="SRR11893084"; order+=( "SRR11893085" )

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
<br />

<a id="if-applicable-then-run-logic-for-running-pairtools-merge"></a>
## If applicable, then run logic for running `pairtools merge`
<a id="code-10"></a>
#### Code
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
<br />

## Temporary
### Code
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

### Code
<details>
<summary><i>Code: Temporary</i></summary>

```bash
#!/bin/bash

a_rDNA="${d_comp}/${f_rDNA}"                                            # echo "${a_rDNA}"
a_rDNA_tmp="${a_rDNA%%.*}.sorted-standard-rDNA.${post}"                 # echo "${a_rDNA_tmp}"

f_rDNA_cload="$(echo "${f_rDNA}" | sed "s/${post}/cload.cool/g")"       # echo "${f_rDNA_cload}"
a_rDNA_cload="${d_comp}/${f_rDNA_cload}"                                # echo "${a_rDNA_cload}"

f_rDNA_zoom="$(echo "${f_rDNA_cload}" | sed "s/.cload.cool/.mcool/g")"  # echo "${f_rDNA_zoom}"
a_rDNA_zoom="${d_comp}/${f_rDNA_zoom}"                                  # echo "${a_rDNA_zoom}"


                #  Loading pairs to cooler ------------------------------------
                bin_initial=25  #TODO Make the change in Step #0 above
                echo """
                cooler cload pairs \\
                    -c1 2 -p1 3 -c2 4 -p2 5 \\
                    --assembly \"${assembly}\" \\
                    \"${a_size}\":\"${bin_initial}\" \\
                    \"${a_rDNA}\" \\
                    \"${a_rDNA_cload}\" \\
                        2> >(tee -a \"${d_comp}/err_out/${f_rDNA_cload%.cool}.stderr.txt\" >&2)
                """

                [[ -f "${a_rDNA}" && "${a_rDNA_cload}" ]] &&
                    {
                        cooler cload pairs \
                            -c1 2 -p1 3 -c2 4 -p2 5 \
                            --assembly "${assembly}" \
                            "${a_size}":"${bin_initial}" \
                            "${a_rDNA}" \
                            "${a_rDNA_cload}" \
                                2> >(tee -a "${d_comp}/err_out/${f_rDNA_cload%.cool}.stderr.txt" >&2)
                    }


                #  Coarsening matrix, then balancing resulting matrices -------
                [[ -f "${a_rDNA_zoom}" ]] && rm "${a_rDNA_zoom}"
                
                echo """
                cooler zoomify \\
                    --out \"${a_rDNA_zoom}\" \\
                    --nproc \"${threads}\" \\
                    --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
                    --balance \\
                    --balance-args '--max-iters 2000' \\
                    \"${a_rDNA_cload}\" \\
                        2> >(tee -a \"${d_comp}/err_out/${f_rDNA_zoom%.mcool}.stderr.txt\" >&2)
                """

                cooler zoomify \
                    --out "${a_rDNA_zoom}" \
                    --nproc "${threads}" \
                    --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
                    --balance \
                    --balance-args '--max-iters 2000' \
                    "${a_rDNA_cload}" \
                        2> >(tee -a "${d_comp}/err_out/${f_rDNA_zoom%.mcool}.stderr.txt" >&2)
            }
    }

# }
```
</details>
<br />

<a id="x-run-pairtools-select-if-applicable"></a>
## X. Run `pairtools select` if applicable
<a id="code-21"></a>
### Code
<details>
<summary><i>Code: X. Run pairtools select if applicable</i></summary>

```bash
#!/bin/bash

[[ "${flag_rDNA}" == TRUE ]] &&
    {
        #  Check the documentation --------------------------------------------
        check_documentation=TRUE
        [[ ${check_documentation} == TRUE ]] && pairtools select --help

        #PICKUPHERE
    }
```
</details>
<br />

<a id="printed-15"></a>
### Printed
<details>
<summary><i>Printed: X. Run pairtools select</i></summary>

<a id="check-the-documentation-4"></a>
#### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt
❯         check_documentation=TRUE


❯ [[ ${check_documentation} == TRUE ]] && pairtools select --help
Usage: pairtools select [OPTIONS] CONDITION [PAIRS_PATH]

  Select pairs according to some condition.

  CONDITION : A Python expression; if it returns True, select the read pair.
  Any column declared in the #columns line of the pairs header can be accessed
  by its name. If the header lacks the #columns line, the columns are assumed
  to follow the .pairs/.pairsam standard (readID, chrom1, chrom2, pos1, pos2,
  strand1, strand2, pair_type). Finally, CONDITION has access to COLS list
  which contains the string values of columns. In Bash, quote CONDITION with
  single quotes, and use double quotes for string variables inside CONDITION.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

  The following functions can be used in CONDITION besides the standard Python
  functions:

  - csv_match(x, csv) - True if variable x is contained in a list of comma-
  separated values, e.g. csv_match(chrom1, 'chr1,chr2')

  - wildcard_match(x, wildcard) - True if variable x matches a wildcard, e.g.
  wildcard_match(pair_type, 'C*')

  - regex_match(x, regex) - True if variable x matches a Python-flavor regex,
  e.g. regex_match(chrom1, 'chr\d')

  Examples:
  pairtools select '(pair_type=="UU") or (pair_type=="UR") or (pair_type=="RU")'
  pairtools select 'chrom1==chrom2'
  pairtools select 'COLS[1]==COLS[3]'
  pairtools select '(chrom1==chrom2) and (abs(pos1 - pos2) < 1e6)'
  pairtools select '(chrom1=="!") and (chrom2!="!")'
  pairtools select 'regex_match(chrom1, "chr\d+") and regex_match(chrom2, "chr\d+")'

  pairtools select 'True' --chrom-subset mm9.reduced.chromsizes

Options:
  -o, --output TEXT               output file. If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4c-compressed.
                                  By default, the output is printed into
                                  stdout.
  --output-rest TEXT              output file for pairs of other types.  If
                                  the path ends with .gz or .lz4, the output
                                  is bgzip-/lz4c-compressed. By default, such
                                  pairs are dropped.
  --chrom-subset TEXT             A path to a chromosomes file (tab-separated,
                                  1st column contains chromosome names)
                                  containing a chromosome subset of interest.
                                  If provided, additionally filter pairs with
                                  both sides originating from the provided
                                  subset of chromosomes. This operation
                                  modifies the #chromosomes: and #chromsize:
                                  header fields accordingly.
  --startup-code TEXT             An auxiliary code to execute before
                                  filtering. Use to define functions that can
                                  be evaluated in the CONDITION statement
  -t, --type-cast <TEXT TEXT>...  Cast a given column to a given type. By
                                  default, only pos and mapq are cast to int,
                                  other columns are kept as str. Provide as -t
                                  <column_name> <type>, e.g. -t read_len1 int.
                                  Multiple entries are allowed.
  -r, --remove-columns TEXT       Comma-separated list of columns to be
                                  removed, e.g.: readID,chrom1,pos1,chrom2,pos
                                  2,strand1,strand2,pair_type,sam1,sam2,walk_p
                                  air_index,walk_pair_type
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```
</details>
<br />

<a id="pairtools-select"></a>
#### `pairtools select`
<details>
<summary><i>Printed: pairtools select</i></summary>

```txt

```
</details>
<br />
</details>
<br />
<br />

## Debugging
Getting weird errors about noninteger columns when attempting to run cooler cload pairs&mdash;has to do with empty columns (seems like partial records)

`#TOMORROW` Need to go through the files and find missing lines e.g.,
```bash
zcat MC-2019_Q_WT_repM.standard-rDNA-complete.nodups.pairs.gz \
    | awk '{ if ($2 == "" || $3 == "" || $4 == "" || $5 == "") { print $0 } }'
# SRR7939018.700

pbgzip -dc 03_parse/MC-2020_30C-a15_WT_rep1.standard-3.txt.gz \
    | awk '{ if ($2 == "" || $3 == "" || $4 == "" || $5 == "") { print $0 } }'

#  Jobs to check for file corruption in Step #3
cd 03_parse
# pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-3.txt.gz | head

for i in *.txt.gz; do
job_name="check-corruption.${i%.txt.gz}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="err_out/${job_name}.%A.stdout.txt"

pbgzip -dc "${i}" \
    | awk '{ if (\$2 == "" || \$3 == "" || \$4 == "" || \$5 == "") { print \$0 } }' \
    | grep -v "^#" \
        > "${job_name}.txt"
EOF
sleep 0.25
done

#  Jobs to check for file corruption in Step #4
cd 04_parse
pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-3.sort.txt.gz | head

for i in *.txt.gz; do
job_name="check-corruption.${i%.txt.gz}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="err_out/${job_name}.%A.stdout.txt"

pbgzip -dc "${i}" \
    | awk '{ if (\$2 == "" || \$3 == "" || \$4 == "" || \$5 == "") { print \$0 } }' \
    | grep -v "^#" \
        > "${job_name}.txt"
EOF
sleep 0.25
done
```

### `05_dedup`
```bash
#  Jobs to check for file corruption in the many sub-steps of Step #5
cd 05_parse
pbgzip -dc MC-2019_Q_WT_repM.keep-MM-6.dups.pairs.gz | less

for i in *.pairs.gz; do
    job_name="check-corruption.${i%.pairs.gz}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="err_out/${job_name}.%A.stdout.txt"

pbgzip -dc "${i}" \
    | grep -v "^#" \
    | awk '{ if (\$2 == "" || \$3 == "" || \$4 == "" || \$5 == "") { print \$0 } }' \
        > "check-corruption/${job_name}.txt"
EOF
    sleep 0.2
done
```

```txt
❯ zcat MC-2019_Q_WT_repM.standard-rDNA-complete.nodups.pairs.gz \
>     | awk '{ if ($2 == "" || $3 == "" || $4 == "" || $5 == "") { print $0 } }'
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: IX 439888
#chromsize: Mito 85779
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
SRR7939018.700
```

Find at what point in the rough processing pipeline these errors are being introduced; then, determine whether to solve the issue at that point (ideal) or solve the issue at the current point (by, e.g., directly excising the problem lines)
<br />
<br />

## Previous ways I called commands in the pipeline
### Previous way I called `pairtools dedup` and `pairtools split`
#### Code
<details>
<summary><i>Code: 5. Run pairtools dedup</i></summary>

```bash
#!/bin/bash

#  Check the documentation ====================================================
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        pairtools dedup --help
        pairtools split --help
    }


#  Run pairtools dedup ========================================================
#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[
                     -f "${a_sort_std[${i}]}" \
                && ! -f "${a_dedup_pre_pairs_std[${i}]}" \
                && ! -f "${a_unmap_pre_pairs_std[${i}]}" \
                && ! -f "${a_dup_pre_pairs_std[${i}]}"
            ]] &&
                {
                    job_name="${d_dedup}.${f_dedup_pre_std[${i}]%.nodups}"  # echo "${job_name}"

                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=${job_name}
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

                    pairtools dedup \\
                        --n-proc \"${threads}\" \\
                        --max-mismatch \"${max_mismatch_std}\" \\
                        --mark-dups \\
                        --output \\
                            >(pairtools split --output-pairs \"${a_dedup_pre_pairs_std[${i}]}\") \\
                        --output-unmapped \\
                            >(pairtools split --output-pairs \"${a_unmap_pre_pairs_std[${i}]}\") \\
                        --output-dups \\
                            >(pairtools split --output-pairs \"${a_dup_pre_pairs_std[${i}]}\") \\
                        --output-stats \"${a_dedup_stats[${i}]}\" \\
                        \"${a_sort_std[${i}]}\"
                    EOF
                    """
                } ||
                echo "Standard dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""

            [[
                -f "${a_sort_rDNA[${i}]}" \
                && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" \
                && ! -f "${a_unmap_pre_pairs_rDNA[${i}]}" \
                && ! -f "${a_dup_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="${d_dedup}.${f_dedup_pre_rDNA[${i}]%.nodups}"  # echo "${job_name}"

                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=${job_name}
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

                    pairtools dedup \\
                        --n-proc \"${threads}\" \\
                        --max-mismatch \"${max_mismatch_rDNA}\" \\
                        --mark-dups \\
                        --output \\
                            >(pairtools split --output-pairs \"${a_dedup_pre_pairs_rDNA[${i}]}\") \\
                        --output-unmapped \\
                            >(pairtools split --output-pairs \"${a_unmap_pre_pairs_rDNA[${i}]}\") \\
                        --output-dups \\
                            >(pairtools split --output-pairs \"${a_dup_pre_pairs_rDNA[${i}]}\") \\
                        --output-stats \"${a_dedup_stats[${i}]}\" \\
                        \"${a_sort_rDNA[${i}]}\"
                    EOF
                    """
                } ||
                echo "rDNA dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""
        done
    } ||
    {
        echo "Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not run"
        echo "Stopping the operation"
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[
                -f "${a_sort_std[${i}]}" \
                && ! -f "${a_dedup_pre_pairs_std[${i}]}" \
                && ! -f "${a_unmap_pre_pairs_std[${i}]}" \
                && ! -f "${a_dup_pre_pairs_std[${i}]}"
            ]] &&
                {
                    job_name="${d_dedup}.${f_dedup_pre_std[${i}]%.nodups}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

pairtools dedup \
    --n-proc "${threads}" \
    --max-mismatch "${max_mismatch_std}" \
    --mark-dups \
    --output \
        >(pairtools split --output-pairs "${a_dedup_pre_pairs_std[${i}]}") \
    --output-unmapped \
        >(pairtools split --output-pairs "${a_unmap_pre_pairs_std[${i}]}") \
    --output-dups \
        >(pairtools split --output-pairs "${a_dup_pre_pairs_std[${i}]}") \
    --output-stats "${a_dedup_stats[${i}]}" \
    "${a_sort_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "Standard dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""

            [[
                -f "${a_sort_rDNA[${i}]}" \
                && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" \
                && ! -f "${a_unmap_pre_pairs_rDNA[${i}]}" \
                && ! -f "${a_dup_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="${d_dedup}.${f_dedup_pre_rDNA[${i}]%.nodups}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"

pairtools dedup \
    --n-proc "${threads}" \
    --max-mismatch "${max_mismatch_rDNA}" \
    --mark-dups \
    --output \
        >(pairtools split --output-pairs "${a_dedup_pre_pairs_rDNA[${i}]}") \
    --output-unmapped \
        >(pairtools split --output-pairs "${a_unmap_pre_pairs_rDNA[${i}]}") \
    --output-dups \
        >(pairtools split --output-pairs "${a_dup_pre_pairs_rDNA[${i}]}") \
    --output-stats "${a_dedup_stats[${i}]}" \
    "${a_sort_rDNA[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "rDNA dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""
        done
    } ||
    {
        echo "Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not run"
        echo "Stopping the operation"
    }


#  Check the various outfiles -------------------------------------------------
run_check=FALSE  #TODO Need to update/refactor this
[[ 
    "${run_check}" == TRUE \
        && -f "${a_dedup_pre_pairs}" \
        && -f "${a_dup_pre_pairs}" \
        && -f "${a_unmap_pre_pairs}"
]] &&
    {
        ., "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt" && printf "\n\n"

        ., "${a_dedup_pre_pairs}" && printf "\n\n"
        ., "${a_dup_pre_pairs}" && printf "\n\n"
        ., "${a_unmap_pre_pairs}" && printf "\n\n"

        # zcat "${a_dedup_pre_pairs}" | less
        ( zcat "${a_dedup_pre_pairs}" | head -100 ) && printf "\n\n"
        ( zcat "${a_dup_pre_pairs}" | head -100 ) && printf "\n\n"
        ( zcat "${a_unmap_pre_pairs}" | head -100 ) && printf "\n\n"
    } ||
    {
        echo "Warning: \"run_check\" for dedup outfiles did not run"
        echo "Stopping the operation because you need to check on this..."
    }


#  Examine the unique pairs ---------------------------------------------------
run_check=FALSE  #TODO Need to update/refactor this
[[ "${run_check}" == TRUE && -f "${a_dedup_pre_pairs}" ]] &&
    {
        ( zcat "${a_dedup_pre_pairs}" | grep -v "#" | head -300 ) && printf "\n\n"

        #  Count number of unique pairs type in "${a_dedup_pre_pairs}"
        (
            zcat "${a_dedup_pre_pairs}" \
                | grep -v "^#" \
                | cut -f 8 \
                | sort \
                | uniq -c
        ) &&
            printf "\n\n"

        #  What are the RU and UR pair types?
        ( zcat "${a_dedup_pre_pairs}" | grep "RU\|UR" || echo "No \"RU|UR\"" ) && printf "\n\n"
    } ||
    {
        echo "Warning: \"run_check\" for dedup unique pairs outfile did not run"
        echo "Stopping the operation because you need to check on this..."
    }


#  Check the stats outfile ----------------------------------------------------
run_check=FALSE  #TODO Need to update/refactor this
[[ "${run_check}" == TRUE && -f "${a_dedup_stats}" ]] &&
    {
        ., "${a_dedup_stats}" && printf "\n\n"
        cat "${a_dedup_stats}" && printf "\n\n" # less "${a_dedup_stats}"
    } ||
    {
        echo "Warning: \"run_check\" for dedup stats did not run"
        echo "Stopping the operation because you need to check on this..."
    }
```
</details>
<br />

<a id="printed-13"></a>
#### Printed
<details>
<summary><i>Printed: 5. Run pairtools dedup</i></summary>

<a id="check-the-documentation-2"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt
❯ pairtools dedup --help
Usage: pairtools dedup [OPTIONS] [PAIRS_PATH]

  Find and remove PCR/optical duplicates.

  Find PCR/optical duplicates in an upper-triangular flipped sorted
  pairs/pairsam file. Allow for a +/-N bp mismatch at each side of duplicated
  molecules.

  PAIRS_PATH : input triu-flipped sorted .pairs or .pairsam file.  If the path
  ends with .gz/.lz4, the input is decompressed by bgzip/lz4c. By default, the
  input is read from stdin.

Options:
  -o, --output TEXT               output file for pairs after duplicate
                                  removal. If the path ends with .gz or .lz4,
                                  the output is bgzip-/lz4c-compressed. By
                                  default, the output is printed into stdout.
  --output-dups TEXT              output file for duplicated pairs.  If the
                                  path ends with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. If the path is the
                                  same as in --output or -, output duplicates
                                  together  with deduped pairs. By default,
                                  duplicates are dropped.
  --output-unmapped TEXT          output file for unmapped pairs. If the path
                                  ends with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. If the path is the
                                  same as in --output or -, output unmapped
                                  pairs together with deduped pairs. If the
                                  path is the same as --output-dups, output
                                  unmapped reads together with dups. By
                                  default, unmapped pairs are dropped.
  --output-stats TEXT             output file for duplicate statistics. If
                                  file exists, it will be open in the append
                                  mode. If the path ends with .gz or .lz4, the
                                  output is bgzip-/lz4c-compressed. By
                                  default, statistics are not printed.
  --output-bytile-stats TEXT      output file for duplicate statistics. Note
                                  that the readID should be provided and
                                  contain tile information for this option.
                                  This analysis is possible when pairtools is
                                  run on a dataset with original Illumina-
                                  generated read IDs,  because SRA does not
                                  store original read IDs from the sequencer.
                                  By default, by-tile duplicate statistics are
                                  not printed.  If file exists, it will be
                                  open in the append mode.  If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed.
  --max-mismatch INTEGER          Pairs with both sides mapped within this
                                  distance (bp) from each other are considered
                                  duplicates. [dedup option]  [default: 3]
  --method [max|sum]              define the mismatch as either the max or the
                                  sum of the mismatches ofthe genomic
                                  locations of the both sides of the two
                                  compared molecules. [dedup option]
                                  [default: max]
  --backend [scipy|sklearn|cython]
                                  What backend to use: scipy and sklearn are
                                  based on KD-trees, cython is online indexed
                                  list-based algorithm. With cython backend,
                                  duplication is not transitive with non-zero
                                  max mismatch  (e.g. pairs A and B are
                                  duplicates, and B and C are duplicates, then
                                  A and C are  not necessary duplicates of
                                  each other), while with scipy and sklearn
                                  it's  transitive (i.e. A and C are
                                  necessarily duplicates). Cython is the
                                  original version used in pairtools since its
                                  beginning. It is available for backwards
                                  compatibility and to allow specification of
                                  the column order. Now the default scipy
                                  backend is generally the fastest, and with
                                  chunksize below 1 mln has the lowest memory
                                  requirements. [dedup option]
  --chunksize INTEGER             Number of pairs in each chunk. Reduce for
                                  lower memory footprint. Below 10,000
                                  performance starts suffering significantly
                                  and the algorithm might miss a few
                                  duplicates with non-zero --max-mismatch.
                                  Only works with '--backend scipy or
                                  sklearn'. [dedup option]  [default: 100000]
  --carryover INTEGER             Number of deduped pairs to carry over from
                                  previous chunk to the new chunk to avoid
                                  breaking duplicate clusters. Only works with
                                  '--backend scipy or sklearn'. [dedup option]
                                  [default: 100]
  -p, --n-proc INTEGER            Number of cores to use. Only applies with
                                  sklearn backend.Still needs testing whether
                                  it is ever useful. [dedup option]
  --mark-dups                     If specified, duplicate pairs are marked as
                                  DD in "pair_type" and as a duplicate in the
                                  sam entries. [output format option]
  --keep-parent-id                If specified, duplicate pairs are marked
                                  with the readID of the retained deduped read
                                  in the 'parent_readID' field. [output format
                                  option]
  --extra-col-pair TEXT...        Extra columns that also must match for two
                                  pairs to be marked as duplicates. Can be
                                  either provided as 0-based column indices or
                                  as column names (requires the "#columns"
                                  header field). The option can be provided
                                  multiple times if multiple column pairs must
                                  match. Example: --extra-col-pair "phase1"
                                  "phase2". [output format option]
  --sep TEXT                      Separator (\t, \v, etc. characters are
                                  supported, pass them in quotes). [input
                                  format option]
  --send-header-to [dups|dedup|both|none]
                                  Which of the outputs should receive header
                                  and comment lines. [input format option]
  --c1 INTEGER                    Chrom 1 column; default 1 Only works with '
                                  --backend cython'. [input format option]
  --c2 INTEGER                    Chrom 2 column; default 3 Only works with '
                                  --backend cython'. [input format option]
  --p1 INTEGER                    Position 1 column; default 2 Only works with
                                  '--backend cython'. [input format option]
  --p2 INTEGER                    Position 2 column; default 4 Only works with
                                  '--backend cython'. [input format option]
  --s1 INTEGER                    Strand 1 column; default 5 Only works with '
                                  --backend cython'. [input format option]
  --s2 INTEGER                    Strand 2 column; default 6 Only works with '
                                  --backend cython'. [input format option]
  --unmapped-chrom TEXT           Placeholder for a chromosome on an unmapped
                                  side; default !
  --yaml / --no-yaml              Output stats in yaml format instead of
                                  table. [output stats format option]
  --filter TEXT                   Filter stats with condition to apply to the
                                  data (similar to `pairtools select` or
                                  `pairtools stats`). For non-YAML output only
                                  the first filter will be reported. [output
                                  stats filtering option] Note that this will
                                  not change the deduplicated output pairs.
                                  Example: pairtools dedup --yaml --filter
                                  'unique:(pair_type=="UU")' --filter
                                  'close:(pair_type=="UU") and
                                  (abs(pos1-pos2)<10)' --output-stats -
                                  test.pairs
  --engine TEXT                   Engine for regular expression parsing for
                                  stats filtering. Python will provide you
                                  regex functionality, while pandas does not
                                  accept custom funtctions and works faster.
                                  [output stats filtering option]
  --chrom-subset TEXT             A path to a chromosomes file (tab-separated,
                                  1st column contains chromosome names)
                                  containing a chromosome subset of interest
                                  for stats filter. If provided, additionally
                                  filter pairs with both sides originating
                                  from the provided subset of chromosomes.
                                  This operation modifies the #chromosomes:
                                  and #chromsize: header fields accordingly.
                                  Note that this will not change the
                                  deduplicated output pairs. [output stats
                                  filtering option]
  --startup-code TEXT             An auxiliary code to execute before
                                  filteringfor stats. Use to define functions
                                  that can be evaluated in the CONDITION
                                  statement. [output stats filtering option]
  -t, --type-cast <TEXT TEXT>...  Cast a given column to a given type for
                                  stats filtering. By default, only pos and
                                  mapq are cast to int, other columns are kept
                                  as str. Provide as -t <column_name> <type>,
                                  e.g. -t read_len1 int. Multiple entries are
                                  allowed. [output stats filtering option]
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.


❯ pairtools split --help
Usage: pairtools split [OPTIONS] [PAIRSAM_PATH]

  Split a .pairsam file into .pairs and .sam.

  Restore a .sam file from sam1 and sam2 fields of a .pairsam file. Create a
  .pairs file without sam1/sam2 fields.

  PAIRSAM_PATH : input .pairsam file. If the path ends with .gz or .lz4, the
  input is decompressed by bgzip or lz4c. By default, the input is read from
  stdin.

Options:
  --output-pairs TEXT  output pairs file. If the path ends with .gz or .lz4,
                       the output is bgzip-/lz4c-compressed. If -, pairs are
                       printed to stdout. If not specified, pairs are dropped.
  --output-sam TEXT    output sam file. If the path ends with .bam, the output
                       is compressed into a bam file. If -, sam entries are
                       printed to stdout. If not specified, sam entries are
                       dropped.
  --nproc-in INTEGER   Number of processes used by the auto-guessed input
                       decompressing command.  [default: 3]
  --nproc-out INTEGER  Number of processes used by the auto-guessed output
                       compressing command.  [default: 8]
  --cmd-in TEXT        A command to decompress the input file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdin and pairtools parse. Must read input from
                       stdin and print output into stdout. EXAMPLE: pbgzip -dc
                       -n 3
  --cmd-out TEXT       A command to compress the output file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdout. Must read input from stdin and print
                       output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help           Show this message and exit.
```
</details>
<br />

<a id="run-pairtools-dedup"></a>
##### Run `pairtools dedup`
<details>
<summary><i>Printed: Run pairtools dedup</i></summary>

<a id="standard"></a>
###### "Standard"
```txt
❯ [[ "${run}" == TRUE ]] &&
>     {
>         echo """
>         pairtools dedup \\
>             --n-proc \"${threads}\" \\
>             --max-mismatch \"${max_mismatch}\" \\
>             --mark-dups \\
>             --output \\
>                 >(
>                     pairtools split \\
>                         --output-pairs \"${a_dedup_pre_pairs}\"
>                 ) \\
>             --output-unmapped \\
>                 >(
>                     pairtools split \\
>                         --output-pairs \"${a_dup_pre_pairs}\"
>                 ) \\
>             --output-dups \\
>                 >(
>                     pairtools split \\
>                         --output-pairs \"${a_unmap_pre_pairs}\"
>                 ) \\
>             --output-stats \"${a_dedup_stats}\" \\
>             \"${a_sort}\" \\
>                 2> >(tee -a \"${d_dedup}/err_out/${f_pre}.dedup.stderr.txt\" >&2)
>         """
>     }

        pairtools dedup \
            --n-proc "8" \
            --max-mismatch "0" \
            --mark-dups \
            --output \
                >(
                    pairtools split \
                        --output-pairs "05_dedup/pairs/SRR7939018.nodups.pairs.gz"
                ) \
            --output-unmapped \
                >(
                    pairtools split \
                        --output-pairs "05_dedup/pairs/SRR7939018.dups.pairs.gz"
                ) \
            --output-dups \
                >(
                    pairtools split \
                        --output-pairs "05_dedup/pairs/SRR7939018.unmapped.pairs.gz"
                ) \
            --output-stats "0X_stats/SRR7939018.dedup.stats.txt" \
            "04_sort/SRR7939018.sort.txt.gz" \
                2> >(tee -a "05_dedup/err_out/SRR7939018.dedup.stderr.txt" >&2)


❯ [[ "${run}" == TRUE ]] &&
>     {
>         pairtools dedup \
>             --n-proc "${threads}" \
>             --max-mismatch "${max_mismatch}" \
>             --mark-dups \
>             --output \
>                 >(
>                     pairtools split --output-pairs "${a_dedup_pre_pairs}"
>                 ) \
>             --output-unmapped \
>                 >(
>                     pairtools split --output-pairs "${a_dup_pre_pairs}"
>                 ) \
>             --output-dups \
>                 >(
>                     pairtools split --output-pairs "${a_unmap_pre_pairs}"
>                 ) \
>             --output-stats "${a_dedup_stats}" \
>             "${a_sort}" \
>                 2> >(tee -a "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt" >&2)
>     }
WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (16,17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:

WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/dedup.py:132: DtypeWarning: Columns (17) have mixed types. Specify dtype option on import or set low_memory=False.
  for df in dfs:
```

<a id="rdna"></a>
###### "rDNA"
```txt
❯ print_test=TRUE


❯ [[
>     "${print_test}" == TRUE \
>         && -f "${a_sort}" \
>         && ! -f "${a_dedup_pre_pairs}" \
>         && ! -f "${a_dup_pre_pairs}" \
>         && ! -f "${a_unmap_pre_pairs}"
> ]] &&
>     {
>         echo """
>         pairtools dedup \\
>             --n-proc \"${threads}\" \\
>             --max-mismatch \"${max_mismatch}\" \\
>             --mark-dups \\
>             --output \\
>                 >(pairtools split --output-pairs \"${a_dedup_pre_pairs}\") \\
>             --output-unmapped \\
>                 >(pairtools split --output-pairs \"${a_unmap_pre_pairs}\") \\
>             --output-dups \\
>                 >(pairtools split --output-pairs \"${a_dup_pre_pairs}\") \\
>             --output-stats \"${a_dedup_stats}\" \\
>             \"${a_sort}\" \\
>                 2> >(tee -a \"${d_dedup}/err_out/${f_pre}.dedup.stderr.txt\" >&2)
>         """
>     } ||
>     {
>         echo "Warning: \"Step #5: Run pairtools dedup\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }

        pairtools dedup \
            --n-proc "8" \
            --max-mismatch "0" \
            --mark-dups \
            --output \
                >(pairtools split --output-pairs "05_dedup/SRR7939018.rDNA.nodups.pairs.gz") \
            --output-unmapped \
                >(pairtools split --output-pairs "05_dedup/SRR7939018.rDNA.unmapped.pairs.gz") \
            --output-dups \
                >(pairtools split --output-pairs "05_dedup/SRR7939018.rDNA.dups.pairs.gz") \
            --output-stats "06_stats/SRR7939018.rDNA.dedup.stats.txt" \
            "04_sort/SRR7939018.rDNA.sort.txt.gz" \
                2> >(tee -a "05_dedup/err_out/SRR7939018.rDNA.dedup.stderr.txt" >&2)


❯ run=TRUE


❯ [[
>     "${run}" == TRUE \
>         && -f "${a_sort}" \
>         && ! -f "${a_dedup_pre_pairs}" \
>         && ! -f "${a_dup_pre_pairs}" \
>         && ! -f "${a_unmap_pre_pairs}"
> ]] &&
>     {
>         pairtools dedup \
>             --n-proc "${threads}" \
>             --max-mismatch "${max_mismatch}" \
>             --mark-dups \
>             --output \
>                 >(pairtools split --output-pairs "${a_dedup_pre_pairs}") \
>             --output-unmapped \
>                 >(pairtools split --output-pairs "${a_unmap_pre_pairs}") \
>             --output-dups \
>                 >(pairtools split --output-pairs "${a_dup_pre_pairs}") \
>             --output-stats "${a_dedup_stats}" \
>             "${a_sort}" \
>                 2> >(tee -a "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt" >&2)
>     } ||
>     {
>         echo "Warning: \"Step #5: Run pairtools dedup\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
```
</details>
<br />

<a id="check-the-various-outfiles"></a>
##### Check the various outfiles
<details>
<summary><i>Printed: Check the various outfiles</i></summary>

<a id="standard-1"></a>
###### "Standard"
```txt
❯ #  Check the various outfiles -------------------------------------------------


❯ ., "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt"
-rw-rw---- 1 kalavatt 6.2K Jul  6 12:41 05_dedup/err_out/SRR7939018.dedup.stderr.txt


❯ ., "${a_dedup_pre_pairs}"
-rw-rw---- 1 kalavatt 748M Jul  6 12:41 05_dedup/pairs/SRR7939018.nodups.pairs.gz


❯ ., "${a_dup_pre_pairs}"
-rw-rw---- 1 kalavatt 213M Jul  6 12:41 05_dedup/pairs/SRR7939018.dups.pairs.gz


❯ ., "${a_unmap_pre_pairs}"
-rw-rw---- 1 kalavatt 158M Jul  6 12:41 05_dedup/pairs/SRR7939018.unmapped.pairs.gz


❯ zcat "${a_dedup_pre_pairs}" | head -100  # zcat "${a_dedup_pre_pairs}" | less
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.nodups.pairs.gz    PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60
SRR7939018.25573455 I   10  I   558 +   +   UU  1   R1-2    10  558 59  607 35  11
SRR7939018.34992310 I   10  I   887 +   +   UU  1   R1-2    10  887 59  936 35  35
SRR7939018.1104427  I   10  I   31959   +   -   UU  1   R1-2    10  31959   59  31910   35  60
SRR7939018.35158773 I   11  I   865 +   +   UU  1   R1-2    11  865 60  914 39  35
SRR7939018.22989844 I   12  I   219 +   -   UU  1   R1-2    12  219 61  170 42  57
SRR7939018.33126366 I   12  I   119112  +   -   UU  1   R1-2    12  119112  61  119063  42  60
SRR7939018.18616690 I   13  I   280 +   -   UU  1   R1-2    13  280 62  231 42  20      C:A:40:274:44
SRR7939018.50678971 I   29  I   407 +   -   UU  1   R1-2    29  407 78  358 60  39
SRR7939018.10119014 I   36  I   470 +   -   UU  1   R1-2    36  470 78  421 60  6
SRR7939018.9636000  I   38  I   194 +   -   UU  1   R1-2    38  194 87  145 60  18
SRR7939018.43976050 I   38  I   229129  -   -   UU  1   R1-2    38  229129  1   229080  2   12  A:C:13:9:21 C:T:38:229097:18,C:A:13:229103:24
SRR7939018.56159970 I   39  I   2441    +   -   UU  1   R1-2    39  2441    88  2392    60  35  C:A:38:38:0
SRR7939018.35458836 I   40  I   89  +   -   UU  1   R1-2    40  89  89  40  60  60
SRR7939018.54943727 I   41  I   178 +   +   UU  1   R1-2    41  178 90  227 60  57
SRR7939018.35434398 I   41  I   321 +   +   UU  1   R1-2    41  321 90  370 60  60
SRR7939018.19718640 I   41  I   395 +   +   UU  1   R1-2    41  395 90  444 60  60
SRR7939018.27890433 I   41  I   1731    +   +   UU  1   R1-2    41  1731    90  1780    60  15
SRR7939018.13293960 I   41  I   38151   -   +   UU  1   R1-2    41  38151   1   38200   18  60
SRR7939018.16006081 I   43  I   242 +   -   UU  1   R1-2    43  242 92  193 60  60
SRR7939018.50825843 I   52  I   336 -   +   UU  1   R1-2    52  336 3   385 28  60
SRR7939018.8625963  I   55  I   319 -   +   UU  1   R1-2    55  319 6   368 28  60
SRR7939018.18404752 I   56  I   479 -   +   UU  1   R1-2    56  479 7   528 28  39
SRR7939018.5344196  I   56  I   33715   -   -   UU  1   R1-2    56  33715   7   33666   22  60  A:C:13:17:11,A:C:13:25:19,A:C:13:30:24
SRR7939018.19358281 I   58  I   2936    -   -   UU  1   R1-2    58  2936    9   2887    13  60  A:C:2:9:1,A:C:2:13:5,A:T:13:28:20
SRR7939018.62948413 I   58  I   27756   -   +   UU  1   R1-2    58  27756   9   27805   32  32
SRR7939018.62698375 I   60  I   75259   -   +   UU  1   R1-2    60  75259   11  75308   18  60  A:C:13:13:3,C:A:38:44:34
SRR7939018.57525614 I   62  I   333 -   -   UU  1   R1-2    62  333 13  284 39  25  A:T:13:25:13    C:G:2:311:28,A:G:2:324:41,C:A:2:325:42
SRR7939018.63561884 I   62  I   9772    -   -   UU  1   R1-2    62  9772    13  9723    39  60  A:C:13:25:13
SRR7939018.54429866 I   62  I   228205  -   -   UU  1   R1-2    62  228205  13  228156  42  55      T:C:32:228172:17,C:A:32:228198:43,A:T:38:228199:44
SRR7939018.11337172 I   63  I   3225    +   +   UU  1   R1-2    63  3225    112 3274    60  60
SRR7939018.32883053 I   64  I   4341    +   -   UU  1   R1-2    64  4341    113 4306    60  60
SRR7939018.41612980 I   66  I   289 -   -   UU  1   R1-2    66  289 18  247 44  27  A:C:2:30:14,C:G:2:43:27
SRR7939018.20486679 I   66  I   47606   -   +   UU  1   R1-2    66  47606   17  47645   42  60
SRR7939018.4271037  I   68  I   500 +   -   UU  1   R1-2    68  500 112 451 60  60      A:T:13:468:18
SRR7939018.13346597 I   72  I   4371    -   +   UU  1   R1-2    72  4371    23  4416    53  60
SRR7939018.24593858 I   72  I   7008    -   -   UU  1   R1-2    72  7008    23  6959    37  60  A:C:13:28:6,A:C:13:30:8 T:G:40:6958:0
SRR7939018.41263687 I   73  I   49428   +   -   UU  1   R1-2    73  49428   122 49379   60  60  C:G:40:97:25    A:G:40:49411:33
SRR7939018.34067598 I   77  I   298 +   -   UU  1   R1-2    77  298 131 249 53  35
SRR7939018.7777574  I   77  I   1223    -   -   UU  1   R1-2    77  1223    32  1174    60  9       T:G:27:1174:1
SRR7939018.41918892 I   77  I   2410    -   -   UU  1   R1-2    77  2410    28  2361    60  13  A:C:13:37:10
SRR7939018.36976831 I   78  I   228 +   -   UU  1   R1-2    78  228 121 179 60  60
SRR7939018.11605183 I   78  I   1068    +   -   UU  1   R1-2    78  1068    127 1019    60  9
SRR7939018.61330774 I   78  I   4018    +   -   UU  1   R1-2    78  4018    127 3969    60  60
SRR7939018.58174255 I   79  I   1330    +   -   UU  1   R1-2    79  1330    128 1281    60  20
SRR7939018.54185633 I   79  I   1369    +   -   UU  1   R1-2    79  1369    128 1320    60  35
SRR7939018.32333692 I   79  I   207738  +   +   UU  1   R1-2    79  207738  114 207787  60  39
SRR7939018.30478651 I   81  I   95  -   +   UU  1   R1-2    81  95  32  144 52  50  A:C:2:35:4,A:C:2:40:9,A:C:2:42:11
SRR7939018.15936606 I   81  I   5173    -   +   UU  1   R1-2    81  5173    32  5210    60  60  A:C:2:37:6


❯ zcat "${a_dup_pre_pairs}" | head -100
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.dups.pairs.gz  PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
SRR7939018.21   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.22   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.30   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.48   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.49   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.53   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.57   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.69   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.97   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.102  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.111  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.113  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.114  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.118  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.123  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.145  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.157  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.163  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.177  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.180  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.182  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.189  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.192  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.194  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.205  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.209  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.211  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.213  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.217  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.222  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.224  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.226  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.229  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.244  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.245  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.246  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.248  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.249  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.259  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.265  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.274  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.282  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.290  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.300  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.302  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.305  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.320  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.324  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.334  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.335  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.344  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.352  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.353  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.357  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0


❯ zcat "${a_unmap_pre_pairs}" | head -100
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.unmapped.pairs.gz  PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
SRR7939018.52075119 I   7   I   1001    +   +   DD  1   R1-2    7   1001    56  1050    28  46
SRR7939018.38253176 I   10  I   887 +   +   DD  1   R1-2    10  887 59  936 35  35
SRR7939018.53629809 I   12  I   219 +   -   DD  1   R1-2    12  219 61  170 42  57
SRR7939018.10654261 I   36  I   470 +   -   DD  1   R1-2    36  470 78  421 60  6
SRR7939018.19343374 I   38  I   194 +   -   DD  1   R1-2    38  194 87  145 60  18
SRR7939018.36012536 I   43  I   242 +   -   DD  1   R1-2    43  242 92  193 60  60
SRR7939018.63614734 I   55  I   319 -   +   DD  1   R1-2    55  319 6   368 28  60
SRR7939018.36401061 I   56  I   479 -   +   DD  1   R1-2    56  479 7   528 28  39
SRR7939018.62429218 I   66  I   47606   -   +   DD  1   R1-2    66  47606   17  47645   10  60  A:C:2:25:9,A:C:2:30:14,A:C:2:35:19,A:C:2:37:21  C:G:13:47617:12
SRR7939018.7898023  I   68  I   500 +   -   DD  1   R1-2    68  500 112 451 60  39
SRR7939018.53406646 I   77  I   298 +   -   DD  1   R1-2    77  298 131 249 53  35
SRR7939018.34162306 I   89  I   296 +   -   DD  1   R1-2    89  296 138 247 53  35
SRR7939018.59045054 I   94  I   314 +   -   DD  1   R1-2    94  314 126 265 48  60
SRR7939018.30154835 I   95  I   338 +   -   DD  1   R1-2    95  338 126 289 39  35
SRR7939018.20996579 I   95  I   499 +   -   DD  1   R1-2    95  499 144 450 50  42
SRR7939018.59592323 I   99  I   401 +   -   DD  1   R1-2    99  401 148 358 50  21
SRR7939018.35616453 I   105 I   83  +   -   DD  1   R1-2    105 83  144 34  21  60      A:C:2:33:0
SRR7939018.45451111 I   105 I   83  +   -   DD  1   R1-2    105 83  144 34  21  60      A:C:2:35:2
SRR7939018.17962042 I   114 I   321 -   -   DD  1   R1-2    114 321 79  272 60  60
SRR7939018.52299744 I   120 I   298 +   -   DD  1   R1-2    120 298 169 249 60  35
SRR7939018.31295356 I   120 I   370 +   -   DD  1   R1-2    120 370 169 321 60  35
SRR7939018.61236758 I   139 I   321 -   +   DD  1   R1-2    139 321 93  370 60  60
SRR7939018.56782141 I   142 I   674 -   -   DD  1   R1-2    142 674 93  625 50  12
SRR7939018.42393988 I   160 I   797 -   +   DD  1   R1-2    160 797 121 846 60  15
SRR7939018.55135043 I   160 I   797 -   +   DD  1   R1-2    160 797 121 846 60  15
SRR7939018.35839585 I   167 I   510 -   +   DD  1   R1-2    167 510 125 559 32  6   G:A:13:135:11,C:T:13:140:16 T:C:13:536:27
SRR7939018.57488794 I   167 I   510 -   +   DD  1   R1-2    167 510 125 559 32  4   G:A:38:135:11,C:T:27:140:16 A:G:13:510:1,T:A:13:535:26,T:C:13:536:27
SRR7939018.58505042 I   169 I   445 +   -   DD  1   R1-2    169 445 198 396 27  60
SRR7939018.59485586 I   172 I   297 +   -   DD  1   R1-2    172 297 206 248 27  35
SRR7939018.61245537 I   179 I   393 +   -   DD  1   R1-2    179 393 228 344 60  60
SRR7939018.53570294 I   201 I   403 +   +   DD  1   R1-2    201 403 250 452 60  60
SRR7939018.56752385 I   209 I   458 -   -   DD  1   R1-2    209 458 160 409 18  57
SRR7939018.50029313 I   219 I   642 +   -   DD  1   R1-2    219 642 268 593 22  39
SRR7939018.60162163 I   221 I   482 -   -   DD  1   R1-2    221 482 172 433 57  35
SRR7939018.51488270 I   228 I   25  -   +   DD  1   R1-2    228 25  179 78  60  14
SRR7939018.30499851 I   228 I   375 -   +   DD  1   R1-2    228 375 179 424 60  32
SRR7939018.35864288 I   231 I   3183    +   +   DD  1   R1-2    231 3183    280 3232    20  60  G:T:40:249:19
SRR7939018.49506811 I   237 I   1575    -   -   DD  1   R1-2    237 1575    188 1526    60  28
SRR7939018.26816023 I   238 I   1306    +   +   DD  1   R1-2    238 1306    287 1355    32  60
SRR7939018.63986761 I   243 I   52816   +   +   DD  1   R1-2    243 52816   292 52865   32  60
SRR7939018.56001168 I   256 I   475 +   -   DD  1   R1-2    256 475 305 426 39  4
SRR7939018.65950633 I   261 I   98  -   +   DD  1   R1-2    261 98  212 147 35  50
SRR7939018.63890386 I   261 I   286 -   +   DD  1   R1-2    261 286 212 335 35  42
SRR7939018.40701191 I   262 I   548 -   -   DD  1   R1-2    262 548 230 499 39  35
SRR7939018.45983272 I   262 I   548 -   -   DD  1   R1-2    262 548 230 499 39  35
SRR7939018.42202510 I   267 I   448 +   -   DD  1   R1-2    267 448 316 399 60  60
SRR7939018.50009947 I   267 I   540 +   -   DD  1   R1-2    267 540 316 491 60  35
SRR7939018.55868442 I   267 I   540 +   -   DD  1   R1-2    267 540 316 491 60  35
SRR7939018.22092198 I   268 I   7631    -   +   DD  1   R1-2    268 7631    219 7669    22  60
SRR7939018.42055616 I   271 I   383 +   +   DD  1   R1-2    271 383 320 432 60  50  T:A:38:319:49
SRR7939018.61853730 I   271 I   383 +   +   DD  1   R1-2    271 383 320 432 60  50  T:A:40:319:49
SRR7939018.60343297 I   272 I   448 +   -   DD  1   R1-2    272 448 317 399 60  60
SRR7939018.19840110 I   276 I   388 +   -   DD  1   R1-2    276 388 325 350 60  60
SRR7939018.22095365 I   276 I   388 +   -   DD  1   R1-2    276 388 325 350 60  60
SRR7939018.51124012 I   281 I   9123    -   +   DD  1   R1-2    281 9123    232 9172    22  60
```

<a id="rdna-1"></a>
###### "rDNA"
```txt
❯ run_check=TRUE


❯ [[
>     "${run_check}" == TRUE \
>         && -f "${a_dedup_pre_pairs}" \
>         && -f "${a_dup_pre_pairs}" \
>         && -f "${a_unmap_pre_pairs}"
> ]] &&
>     {
>         ., "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt"
> 
>         ., "${a_dedup_pre_pairs}"
>         ., "${a_dup_pre_pairs}"
>         ., "${a_unmap_pre_pairs}"
> 
>         zcat "${a_dedup_pre_pairs}" | head -100  # zcat "${a_dedup_pre_pairs}" | less
>         zcat "${a_dup_pre_pairs}" | head -100
>         zcat "${a_unmap_pre_pairs}" | head -100
>     } ||
>     {
>         echo "Warning: \"run_check\" for dedup outfiles did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
-rw-rw---- 1 kalavatt 0 Jul 11 10:08 05_dedup/err_out/SRR7939018.rDNA.dedup.stderr.txt


-rw-rw---- 1 kalavatt 1.1G Jul 11 10:17 05_dedup/SRR7939018.rDNA.nodups.pairs.gz


-rw-rw---- 1 kalavatt 188M Jul 11 10:17 05_dedup/SRR7939018.rDNA.dups.pairs.gz


-rw-rw---- 1 kalavatt 66M Jul 11 10:17 05_dedup/SRR7939018.rDNA.unmapped.pairs.gz


## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.rDNA.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 0 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.rDNA.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.rDNA.sort.txt.gz 03_parse/SRR7939018.rDNA.txt.gz PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 06_stats/SRR7939018.rDNA.dedup.stats.txt 04_sort/SRR7939018.rDNA.sort.txt.gz   PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/SRR7939018.rDNA.nodups.pairs.gz PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.17569487 I   5   I   194653  +   -   UU  1   R1-2    5   194653  57  194604  0   60
SRR7939018.47769906 I   5   I   207832  +   +   UU  1   R1-2    5   207832  54  207881  28  0
SRR7939018.3451089  I   6   I   229024  +   -   UU  1   R1-2    6   229024  55  228975  28  0
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60
SRR7939018.25573455 I   10  I   558 +   +   UU  1   R1-2    10  558 59  607 35  11
SRR7939018.63854041 I   10  I   646 +   -   UU  1   R1-2    10  646 62  597 0   35
SRR7939018.34992310 I   10  I   887 +   +   UU  1   R1-2    10  887 59  936 35  35
SRR7939018.1104427  I   10  I   31959   +   -   UU  1   R1-2    10  31959   59  31910   35  60
SRR7939018.35158773 I   11  I   865 +   +   UU  1   R1-2    11  865 60  914 39  35
SRR7939018.22989844 I   12  I   219 +   -   UU  1   R1-2    12  219 61  170 42  57
SRR7939018.33126366 I   12  I   119112  +   -   UU  1   R1-2    12  119112  61  119063  42  60
SRR7939018.18616690 I   13  I   280 +   -   UU  1   R1-2    13  280 62  231 42  20
SRR7939018.37239524 I   13  I   225598  +   -   UU  1   R1-2    13  225598  62  225549  42  0
SRR7939018.50678971 I   29  I   407 +   -   UU  1   R1-2    29  407 78  358 60  39
SRR7939018.10119014 I   36  I   470 +   -   UU  1   R1-2    36  470 78  421 60  6
SRR7939018.32594109 I   36  I   4721    -   -   UU  1   R1-2    36  4721    3   4672    0   60
SRR7939018.27720078 I   36  I   6006    -   +   UU  1   R1-2    36  6006    1   6041    0   60
SRR7939018.9636000  I   38  I   194 +   -   UU  1   R1-2    38  194 87  145 60  18
SRR7939018.43976050 I   38  I   229129  -   -   UU  1   R1-2    38  229129  1   229080  2   12
SRR7939018.56159970 I   39  I   2441    +   -   UU  1   R1-2    39  2441    88  2392    60  35
SRR7939018.35458836 I   40  I   89  +   -   UU  1   R1-2    40  89  89  40  60  60
SRR7939018.1099646  I   41  I   3   -   +   UU  1   R1-2    41  3   1   34  21  0
SRR7939018.54943727 I   41  I   178 +   +   UU  1   R1-2    41  178 90  227 60  57
SRR7939018.35434398 I   41  I   321 +   +   UU  1   R1-2    41  321 90  370 60  60
SRR7939018.19718640 I   41  I   395 +   +   UU  1   R1-2    41  395 90  444 60  60
SRR7939018.27890433 I   41  I   1731    +   +   UU  1   R1-2    41  1731    90  1780    60  15
SRR7939018.13293960 I   41  I   38151   -   +   UU  1   R1-2    41  38151   1   38200   18  60
SRR7939018.63754909 I   42  I   230171  +   +   UU  1   R1-2    42  230171  91  230217  60  0
SRR7939018.16006081 I   43  I   242 +   -   UU  1   R1-2    43  242 92  193 60  60
SRR7939018.31390391 I   43  I   2263    -   -   UU  1   R1-2    43  2263    1   2234    33  0
SRR7939018.50825843 I   52  I   336 -   +   UU  1   R1-2    52  336 3   385 28  60
SRR7939018.31073060 I   52  I   225224  -   -   UU  1   R1-2    52  225224  2   225175  26  0
SRR7939018.8625963  I   55  I   319 -   +   UU  1   R1-2    55  319 6   368 28  60
SRR7939018.18404752 I   56  I   479 -   +   UU  1   R1-2    56  479 7   528 28  39
SRR7939018.5344196  I   56  I   33715   -   -   UU  1   R1-2    56  33715   7   33666   22  60
SRR7939018.19358281 I   58  I   2936    -   -   UU  1   R1-2    58  2936    9   2887    13  60
SRR7939018.62948413 I   58  I   27756   -   +   UU  1   R1-2    58  27756   9   27805   32  32
SRR7939018.62698375 I   60  I   75259   -   +   UU  1   R1-2    60  75259   11  75308   18  60
SRR7939018.57525614 I   62  I   333 -   -   UU  1   R1-2    62  333 13  284 39  25
SRR7939018.63561884 I   62  I   9772    -   -   UU  1   R1-2    62  9772    13  9723    39  60
SRR7939018.54429866 I   62  I   228205  -   -   UU  1   R1-2    62  228205  13  228156  42  55
SRR7939018.11337172 I   63  I   3225    +   +   UU  1   R1-2    63  3225    112 3274    60  60
SRR7939018.32883053 I   64  I   4341    +   -   UU  1   R1-2    64  4341    113 4306    60  60
SRR7939018.41612980 I   66  I   289 -   -   UU  1   R1-2    66  289 18  247 44  27
SRR7939018.20486679 I   66  I   47606   -   +   UU  1   R1-2    66  47606   17  47645   42  60
SRR7939018.7101333  I   67  I   22195   -   -   UU  1   R1-2    67  22195   18  22146   38  0
SRR7939018.4271037  I   68  I   500 +   -   UU  1   R1-2    68  500 112 451 60  60
SRR7939018.40910611 I   68  I   210086  -   +   UU  1   R1-2    68  210086  19  210135  42  0
SRR7939018.13346597 I   72  I   4371    -   +   UU  1   R1-2    72  4371    23  4416    53  60


## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.rDNA.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 0 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.rDNA.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.rDNA.sort.txt.gz 03_parse/SRR7939018.rDNA.txt.gz PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 06_stats/SRR7939018.rDNA.dedup.stats.txt 04_sort/SRR7939018.rDNA.sort.txt.gz   PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/SRR7939018.rDNA.dups.pairs.gz   PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.57738642 I   6   I   229024  +   -   DD  1   R1-2    6   229024  55  228975  28  0
SRR7939018.52075119 I   7   I   1001    +   +   DD  1   R1-2    7   1001    56  1050    28  46
SRR7939018.38253176 I   10  I   887 +   +   DD  1   R1-2    10  887 59  936 35  35
SRR7939018.53629809 I   12  I   219 +   -   DD  1   R1-2    12  219 61  170 42  57
SRR7939018.10654261 I   36  I   470 +   -   DD  1   R1-2    36  470 78  421 60  6
SRR7939018.19343374 I   38  I   194 +   -   DD  1   R1-2    38  194 87  145 60  18
SRR7939018.36012536 I   43  I   242 +   -   DD  1   R1-2    43  242 92  193 60  60
SRR7939018.63614734 I   55  I   319 -   +   DD  1   R1-2    55  319 6   368 28  60
SRR7939018.36401061 I   56  I   479 -   +   DD  1   R1-2    56  479 7   528 28  39
SRR7939018.19767934 I   58  I   2936    -   -   DD  1   R1-2    58  2936    27  2887    0   60
SRR7939018.62429218 I   66  I   47606   -   +   DD  1   R1-2    66  47606   17  47645   10  60
SRR7939018.7898023  I   68  I   500 +   -   DD  1   R1-2    68  500 112 451 60  39
SRR7939018.53406646 I   77  I   298 +   -   DD  1   R1-2    77  298 131 249 53  35
SRR7939018.34162306 I   89  I   296 +   -   DD  1   R1-2    89  296 138 247 53  35
SRR7939018.59045054 I   94  I   314 +   -   DD  1   R1-2    94  314 126 265 48  60
SRR7939018.30154835 I   95  I   338 +   -   DD  1   R1-2    95  338 126 289 39  35
SRR7939018.20996579 I   95  I   499 +   -   DD  1   R1-2    95  499 144 450 50  42
SRR7939018.59592323 I   99  I   401 +   -   DD  1   R1-2    99  401 148 358 50  21
SRR7939018.35616453 I   105 I   83  +   -   DD  1   R1-2    105 83  144 34  21  60
SRR7939018.45451111 I   105 I   83  +   -   DD  1   R1-2    105 83  144 34  21  60
SRR7939018.17962042 I   114 I   321 -   -   DD  1   R1-2    114 321 79  272 60  60
SRR7939018.52299744 I   120 I   298 +   -   DD  1   R1-2    120 298 169 249 60  35
SRR7939018.31295356 I   120 I   370 +   -   DD  1   R1-2    120 370 169 321 60  35
SRR7939018.64556262 I   131 I   566 +   -   DD  1   R1-2    131 566 180 517 53  0
SRR7939018.61236758 I   139 I   321 -   +   DD  1   R1-2    139 321 93  370 60  60
SRR7939018.56782141 I   142 I   674 -   -   DD  1   R1-2    142 674 93  625 50  12
SRR7939018.33751940 I   159 I   1955    -   -   DD  1   R1-2    159 1955    119 1918    60  0
SRR7939018.42393988 I   160 I   797 -   +   DD  1   R1-2    160 797 121 846 60  15
SRR7939018.55135043 I   160 I   797 -   +   DD  1   R1-2    160 797 121 846 60  15
SRR7939018.35839585 I   167 I   510 -   +   DD  1   R1-2    167 510 125 559 32  6
SRR7939018.57488794 I   167 I   510 -   +   DD  1   R1-2    167 510 125 559 32  4
SRR7939018.58505042 I   169 I   445 +   -   DD  1   R1-2    169 445 198 396 27  60
SRR7939018.60196762 I   170 I   225984  +   +   DD  1   R1-2    170 225984  219 226033  57  0
SRR7939018.59485586 I   172 I   297 +   -   DD  1   R1-2    172 297 206 248 27  35
SRR7939018.61245537 I   179 I   393 +   -   DD  1   R1-2    179 393 228 344 60  60
SRR7939018.53570294 I   201 I   403 +   +   DD  1   R1-2    201 403 250 452 60  60
SRR7939018.56752385 I   209 I   458 -   -   DD  1   R1-2    209 458 160 409 18  57
SRR7939018.50029313 I   219 I   642 +   -   DD  1   R1-2    219 642 268 593 22  39
SRR7939018.60162163 I   221 I   482 -   -   DD  1   R1-2    221 482 172 433 57  35
SRR7939018.51488270 I   228 I   25  -   +   DD  1   R1-2    228 25  179 78  60  14
SRR7939018.30499851 I   228 I   375 -   +   DD  1   R1-2    228 375 179 424 60  32
SRR7939018.35864288 I   231 I   3183    +   +   DD  1   R1-2    231 3183    280 3232    20  60
SRR7939018.49506811 I   237 I   1575    -   -   DD  1   R1-2    237 1575    188 1526    60  28
SRR7939018.26816023 I   238 I   1306    +   +   DD  1   R1-2    238 1306    287 1355    32  60
SRR7939018.63986761 I   243 I   52816   +   +   DD  1   R1-2    243 52816   292 52865   32  60
SRR7939018.56001168 I   256 I   475 +   -   DD  1   R1-2    256 475 305 426 39  4
SRR7939018.65950633 I   261 I   98  -   +   DD  1   R1-2    261 98  212 147 35  50
SRR7939018.63890386 I   261 I   286 -   +   DD  1   R1-2    261 286 212 335 35  42
SRR7939018.40701191 I   262 I   548 -   -   DD  1   R1-2    262 548 230 499 39  35
SRR7939018.45983272 I   262 I   548 -   -   DD  1   R1-2    262 548 230 499 39  35
SRR7939018.42202510 I   267 I   448 +   -   DD  1   R1-2    267 448 316 399 60  60
SRR7939018.50009947 I   267 I   540 +   -   DD  1   R1-2    267 540 316 491 60  35
SRR7939018.55868442 I   267 I   540 +   -   DD  1   R1-2    267 540 316 491 60  35
SRR7939018.22092198 I   268 I   7631    -   +   DD  1   R1-2    268 7631    219 7669    22  60
SRR7939018.42055616 I   271 I   383 +   +   DD  1   R1-2    271 383 320 432 60  50


## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#chromsize: Mito 85779
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.rDNA.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 0 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.rDNA.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.rDNA.sort.txt.gz 03_parse/SRR7939018.rDNA.txt.gz PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 06_stats/SRR7939018.rDNA.dedup.stats.txt 04_sort/SRR7939018.rDNA.sort.txt.gz   PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/SRR7939018.rDNA.unmapped.pairs.gz   PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.1    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.3    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.4    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.5    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.9    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.11   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.12   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.19   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.55   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.99   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.155  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.271  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.273  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.285  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.355  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.417  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.432  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.444  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.446  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.484  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.701  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.714  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.749  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.812  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.872  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.916  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.935  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.969  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.971  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1000 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1011 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1077 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1121 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1148 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1209 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1244 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1276 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1284 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1285 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1286 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1287 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1294 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1330 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1472 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1525 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1621 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1753 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1758 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1800 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1936 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1941 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1968 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2036 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2065 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0

```
</details>
<br />

<a id="examine-the-unique-pairs"></a>
##### Examine the unique pairs
<details>
<summary><i>Printed: Examine the unique pairs</i></summary>

<a id="standard-2"></a>
###### "Standard"
```txt
❯ #  Examine the unique pairs ---------------------------------------------------


❯ zcat "${a_dedup_pre_pairs}" | grep -v "#" | head -300
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60
SRR7939018.25573455 I   10  I   558 +   +   UU  1   R1-2    10  558 59  607 35  11
SRR7939018.34992310 I   10  I   887 +   +   UU  1   R1-2    10  887 59  936 35  35
SRR7939018.1104427  I   10  I   31959   +   -   UU  1   R1-2    10  31959   59  31910   35  60
SRR7939018.35158773 I   11  I   865 +   +   UU  1   R1-2    11  865 60  914 39  35
SRR7939018.22989844 I   12  I   219 +   -   UU  1   R1-2    12  219 61  170 42  57
SRR7939018.33126366 I   12  I   119112  +   -   UU  1   R1-2    12  119112  61  119063  42  60
SRR7939018.18616690 I   13  I   280 +   -   UU  1   R1-2    13  280 62  231 42  20      C:A:40:274:44
SRR7939018.50678971 I   29  I   407 +   -   UU  1   R1-2    29  407 78  358 60  39
SRR7939018.10119014 I   36  I   470 +   -   UU  1   R1-2    36  470 78  421 60  6
SRR7939018.9636000  I   38  I   194 +   -   UU  1   R1-2    38  194 87  145 60  18
SRR7939018.43976050 I   38  I   229129  -   -   UU  1   R1-2    38  229129  1   229080  2   12  A:C:13:9:21 C:T:38:229097:18,C:A:13:229103:24
SRR7939018.56159970 I   39  I   2441    +   -   UU  1   R1-2    39  2441    88  2392    60  35  C:A:38:38:0
SRR7939018.35458836 I   40  I   89  +   -   UU  1   R1-2    40  89  89  40  60  60
SRR7939018.54943727 I   41  I   178 +   +   UU  1   R1-2    41  178 90  227 60  57
SRR7939018.35434398 I   41  I   321 +   +   UU  1   R1-2    41  321 90  370 60  60
SRR7939018.19718640 I   41  I   395 +   +   UU  1   R1-2    41  395 90  444 60  60
SRR7939018.27890433 I   41  I   1731    +   +   UU  1   R1-2    41  1731    90  1780    60  15
SRR7939018.13293960 I   41  I   38151   -   +   UU  1   R1-2    41  38151   1   38200   18  60
SRR7939018.16006081 I   43  I   242 +   -   UU  1   R1-2    43  242 92  193 60  60
SRR7939018.50825843 I   52  I   336 -   +   UU  1   R1-2    52  336 3   385 28  60
SRR7939018.8625963  I   55  I   319 -   +   UU  1   R1-2    55  319 6   368 28  60
SRR7939018.18404752 I   56  I   479 -   +   UU  1   R1-2    56  479 7   528 28  39
SRR7939018.5344196  I   56  I   33715   -   -   UU  1   R1-2    56  33715   7   33666   22  60  A:C:13:17:11,A:C:13:25:19,A:C:13:30:24
SRR7939018.19358281 I   58  I   2936    -   -   UU  1   R1-2    58  2936    9   2887    13  60  A:C:2:9:1,A:C:2:13:5,A:T:13:28:20
SRR7939018.62948413 I   58  I   27756   -   +   UU  1   R1-2    58  27756   9   27805   32  32
SRR7939018.62698375 I   60  I   75259   -   +   UU  1   R1-2    60  75259   11  75308   18  60  A:C:13:13:3,C:A:38:44:34
SRR7939018.57525614 I   62  I   333 -   -   UU  1   R1-2    62  333 13  284 39  25  A:T:13:25:13    C:G:2:311:28,A:G:2:324:41,C:A:2:325:42
SRR7939018.63561884 I   62  I   9772    -   -   UU  1   R1-2    62  9772    13  9723    39  60  A:C:13:25:13
SRR7939018.54429866 I   62  I   228205  -   -   UU  1   R1-2    62  228205  13  228156  42  55      T:C:32:228172:17,C:A:32:228198:43,A:T:38:228199:44
SRR7939018.11337172 I   63  I   3225    +   +   UU  1   R1-2    63  3225    112 3274    60  60
SRR7939018.32883053 I   64  I   4341    +   -   UU  1   R1-2    64  4341    113 4306    60  60
SRR7939018.41612980 I   66  I   289 -   -   UU  1   R1-2    66  289 18  247 44  27  A:C:2:30:14,C:G:2:43:27
SRR7939018.20486679 I   66  I   47606   -   +   UU  1   R1-2    66  47606   17  47645   42  60
SRR7939018.4271037  I   68  I   500 +   -   UU  1   R1-2    68  500 112 451 60  60      A:T:13:468:18
SRR7939018.13346597 I   72  I   4371    -   +   UU  1   R1-2    72  4371    23  4416    53  60
SRR7939018.24593858 I   72  I   7008    -   -   UU  1   R1-2    72  7008    23  6959    37  60  A:C:13:28:6,A:C:13:30:8 T:G:40:6958:0
SRR7939018.41263687 I   73  I   49428   +   -   UU  1   R1-2    73  49428   122 49379   60  60  C:G:40:97:25    A:G:40:49411:33
SRR7939018.34067598 I   77  I   298 +   -   UU  1   R1-2    77  298 131 249 53  35
SRR7939018.7777574  I   77  I   1223    -   -   UU  1   R1-2    77  1223    32  1174    60  9       T:G:27:1174:1
SRR7939018.41918892 I   77  I   2410    -   -   UU  1   R1-2    77  2410    28  2361    60  13  A:C:13:37:10
SRR7939018.36976831 I   78  I   228 +   -   UU  1   R1-2    78  228 121 179 60  60
SRR7939018.11605183 I   78  I   1068    +   -   UU  1   R1-2    78  1068    127 1019    60  9
SRR7939018.61330774 I   78  I   4018    +   -   UU  1   R1-2    78  4018    127 3969    60  60
SRR7939018.58174255 I   79  I   1330    +   -   UU  1   R1-2    79  1330    128 1281    60  20
SRR7939018.54185633 I   79  I   1369    +   -   UU  1   R1-2    79  1369    128 1320    60  35
SRR7939018.32333692 I   79  I   207738  +   +   UU  1   R1-2    79  207738  114 207787  60  39
SRR7939018.30478651 I   81  I   95  -   +   UU  1   R1-2    81  95  32  144 52  50  A:C:2:35:4,A:C:2:40:9,A:C:2:42:11
SRR7939018.15936606 I   81  I   5173    -   +   UU  1   R1-2    81  5173    32  5210    60  60  A:C:2:37:6
SRR7939018.39027485 I   88  I   56075   -   +   UU  1   R1-2    88  56075   39  56124   60  60      G:A:13:56083:9
SRR7939018.31861861 I   88  I   107563  -   +   UU  1   R1-2    88  107563  39  107612  60  60
SRR7939018.26002914 I   89  I   296 +   -   UU  1   R1-2    89  296 138 247 53  35
SRR7939018.46658462 I   89  I   318 +   -   UU  1   R1-2    89  318 131 269 60  28      A:C:2:272:4,A:C:2:279:11,A:T:2:282:14,T:G:13:308:40
SRR7939018.24703715 I   89  I   964 -   +   UU  1   R1-2    89  964 40  1013    60  39
SRR7939018.34060015 I   93  I   194 +   -   UU  1   R1-2    93  194 126 145 54  18
SRR7939018.4599895  I   94  I   314 +   -   UU  1   R1-2    94  314 126 265 48  60
SRR7939018.22066078 I   94  I   996 +   -   UU  1   R1-2    94  996 125 947 48  8       T:C:40:947:1,C:T:38:967:21,T:C:38:970:24,G:C:38:989:43
SRR7939018.3480101  I   95  I   338 +   -   UU  1   R1-2    95  338 126 289 39  33      A:T:13:298:10
SRR7939018.29817538 I   95  I   411 +   +   UU  1   R1-2    95  411 144 460 2   50  G:A:40:135:41,C:T:40:140:46
SRR7939018.12120171 I   95  I   499 +   -   UU  1   R1-2    95  499 144 450 50  60      T:G:2:472:23
SRR7939018.56703503 I   96  I   463 +   +   UU  1   R1-2    96  463 145 504 50  60
SRR7939018.2893773  I   99  I   401 +   -   UU  1   R1-2    99  401 148 358 50  21
SRR7939018.50311998 I   104 I   4760    -   +   UU  1   R1-2    104 4760    70  4809    60  60
SRR7939018.8198197  I   105 I   83  +   -   UU  1   R1-2    105 83  144 44  21  60
SRR7939018.46628911 I   108 I   238 +   +   UU  1   R1-2    108 238 157 287 39  32
SRR7939018.54704375 I   108 I   256 +   -   UU  1   R1-2    108 256 157 212 39  60
SRR7939018.31780843 I   108 I   411 +   +   UU  1   R1-2    108 411 157 460 39  50
SRR7939018.45965058 I   112 I   10  -   +   UU  1   R1-2    112 10  75  59  60  35
SRR7939018.15594546 I   112 I   261 +   -   UU  1   R1-2    112 261 161 212 53  35
SRR7939018.33827262 I   112 I   407 +   -   UU  1   R1-2    112 407 161 358 53  39
SRR7939018.88645    I   112 I   230127  +   +   UU  1   R1-2    112 230127  144 230168  15  2       G:T:27:230160:38
SRR7939018.2342447  I   114 I   321 -   -   UU  1   R1-2    114 321 79  272 60  60
SRR7939018.33953    I   114 I   1052    +   -   UU  1   R1-2    114 1052    163 1003    60  39
SRR7939018.16129580 I   116 I   10  -   +   UU  1   R1-2    116 10  67  59  60  35
SRR7939018.6945655  I   116 I   62  -   -   UU  1   R1-2    116 62  80  13  60  39      A:C:13:25:13
SRR7939018.18958897 I   116 I   6531    -   +   UU  1   R1-2    116 6531    73  6580    60  60
SRR7939018.36806590 I   117 I   66815   -   +   UU  1   R1-2    117 66815   68  66864   60  60
SRR7939018.56325226 I   120 I   67  +   -   UU  1   R1-2    120 67  169 18  60  42
SRR7939018.48930140 I   120 I   298 +   -   UU  1   R1-2    120 298 169 249 60  35
SRR7939018.10294309 I   120 I   370 +   -   UU  1   R1-2    120 370 169 321 60  35
SRR7939018.149574   I   122 I   329 +   -   UU  1   R1-2    122 329 171 280 60  53
SRR7939018.30608017 I   122 I   440 +   -   UU  1   R1-2    122 440 171 391 60  60
SRR7939018.42054658 I   128 I   556 -   +   UU  1   R1-2    128 556 91  605 39  11
SRR7939018.18870615 I   129 I   77  -   -   UU  1   R1-2    129 77  93  28  60  60
SRR7939018.63830453 I   130 I   306 +   -   UU  1   R1-2    130 306 179 272 53  60
SRR7939018.27872423 I   130 I   318 +   -   UU  1   R1-2    130 318 179 282 53  60
SRR7939018.64264442 I   130 I   361 +   -   UU  1   R1-2    130 361 179 312 53  42
SRR7939018.46489678 I   130 I   499 +   -   UU  1   R1-2    130 499 179 450 53  42
SRR7939018.38483937 I   130 I   598 +   -   UU  1   R1-2    130 598 179 549 53  11
SRR7939018.44672941 I   130 I   4231    +   -   UU  1   R1-2    130 4231    179 4182    53  60      G:A:2:4195:14,G:A:2:4224:43
SRR7939018.8174511  I   131 I   266 +   -   UU  1   R1-2    131 266 180 217 53  22
SRR7939018.63069824 I   131 I   270 +   -   UU  1   R1-2    131 270 160 221 48  59      A:C:2:220:0,T:A:13:248:28,T:A:13:254:34
SRR7939018.63360991 I   131 I   408 +   -   UU  1   R1-2    131 408 180 377 53  1
SRR7939018.35055818 I   131 I   516 +   -   UU  1   R1-2    131 516 180 467 53  53
SRR7939018.41132537 I   131 I   2363    +   -   UU  1   R1-2    131 2363    180 2314    53  60
SRR7939018.53010615 I   132 I   964 +   +   UU  1   R1-2    132 964 167 1013    39  39
SRR7939018.50255224 I   135 I   8633    +   +   UU  1   R1-2    135 8633    184 8682    46  60
SRR7939018.34795673 I   139 I   321 -   +   UU  1   R1-2    139 321 93  370 60  60
SRR7939018.41341751 I   142 I   318 +   -   UU  1   R1-2    142 318 191 269 32  60
SRR7939018.55317485 I   142 I   408 -   -   UU  1   R1-2    142 408 93  359 50  35
SRR7939018.45767801 I   142 I   674 -   -   UU  1   R1-2    142 674 93  625 50  12
SRR7939018.44856945 I   144 I   1   -   +   UU  1   R1-2    144 1   112 41  15  21
SRR7939018.57480364 I   144 I   372 +   -   UU  1   R1-2    144 372 179 323 24  35
SRR7939018.60244328 I   148 I   8314    -   +   UU  1   R1-2    148 8314    99  8363    50  60
SRR7939018.62030183 I   149 I   340 +   +   UU  1   R1-2    149 340 198 389 15  60
SRR7939018.50687203 I   149 I   58674   +   +   UU  1   R1-2    149 58674   198 58723   15  60
SRR7939018.14735998 I   153 I   9   -   +   UU  1   R1-2    153 9   104 40  35  13
SRR7939018.10348915 I   153 I   38  +   +   UU  1   R1-2    153 38  202 87  15  60
SRR7939018.11559411 I   153 I   67  +   -   UU  1   R1-2    153 67  202 27  15  60
SRR7939018.57507662 I   153 I   314 +   -   UU  1   R1-2    153 314 198 265 27  60
SRR7939018.51634879 I   153 I   484 +   -   UU  1   R1-2    153 484 202 435 15  35
SRR7939018.20823598 I   159 I   5   -   +   UU  1   R1-2    159 5   110 50  46  48
SRR7939018.49019958 I   159 I   1065    -   -   UU  1   R1-2    159 1065    110 1016    46  9
SRR7939018.7089964  I   160 I   797 -   +   UU  1   R1-2    160 797 121 846 60  15
SRR7939018.49430764 I   161 I   393 +   -   UU  1   R1-2    161 393 210 344 22  60
SRR7939018.32117170 I   163 I   342 +   -   UU  1   R1-2    163 342 212 293 32  32
SRR7939018.44825194 I   164 I   144 +   -   UU  1   R1-2    164 144 207 95  27  50
SRR7939018.9190308  I   167 I   510 -   +   UU  1   R1-2    167 510 125 559 32  6   G:A:38:135:11,C:T:38:140:16 T:C:40:536:27
SRR7939018.41564659 I   168 I   306 +   -   UU  1   R1-2    168 306 213 257 60  42
SRR7939018.38567586 I   168 I   440 +   -   UU  1   R1-2    168 440 217 391 50  60
SRR7939018.14394214 I   169 I   440 +   -   UU  1   R1-2    169 440 215 391 60  60
SRR7939018.58143382 I   169 I   445 +   -   UU  1   R1-2    169 445 198 396 27  60
SRR7939018.1218818  I   172 I   297 +   -   UU  1   R1-2    172 297 206 248 27  35
SRR7939018.27830998 I   172 I   445 +   -   UU  1   R1-2    172 445 221 396 57  60
SRR7939018.37292189 I   174 I   360 +   -   UU  1   R1-2    174 360 223 311 57  39
SRR7939018.62262963 I   178 I   965 +   +   UU  1   R1-2    178 965 227 1002    57  25
SRR7939018.40100680 I   179 I   179 +   +   UU  1   R1-2    179 179 228 228 42  53  C:G:13:215:37   C:A:38:180:2,A:T:40:196:18
SRR7939018.18013213 I   179 I   393 +   -   UU  1   R1-2    179 393 228 344 60  60
SRR7939018.40530226 I   179 I   997 +   -   UU  1   R1-2    179 997 228 954 60  60
SRR7939018.17438715 I   179 I   1519    +   +   UU  1   R1-2    179 1519    228 1568    60  52      G:T:40:1567:49
SRR7939018.2072227  I   180 I   318 +   -   UU  1   R1-2    180 318 229 269 60  46      C:G:38:304:36
SRR7939018.11959452 I   180 I   320 +   -   UU  1   R1-2    180 320 217 271 33  60
SRR7939018.64470435 I   182 I   159 +   -   UU  1   R1-2    182 159 231 116 60  60
SRR7939018.43306138 I   185 I   347 -   +   UU  1   R1-2    185 347 136 396 42  60
SRR7939018.636925   I   186 I   22109   +   -   UU  1   R1-2    186 22109   235 22060   60  35
SRR7939018.18893333 I   187 I   448 +   +   UU  1   R1-2    187 448 236 497 60  50
SRR7939018.33701049 I   190 I   4166    +   +   UU  1   R1-2    190 4166    239 4215    60  60
SRR7939018.32232023 I   190 I   70094   +   +   UU  1   R1-2    190 70094   239 70143   60  60
SRR7939018.53297799 I   191 I   46260   +   +   UU  1   R1-2    191 46260   240 46309   60  60
SRR7939018.40600493 I   194 I   702 -   -   UU  1   R1-2    194 702 145 653 18  22
SRR7939018.54428661 I   196 I   1872    -   +   UU  1   R1-2    196 1872    147 1921    15  4
SRR7939018.24526425 I   197 I   499 +   -   UU  1   R1-2    197 499 246 450 60  42
SRR7939018.29763149 I   199 I   1423    -   -   UU  1   R1-2    199 1423    161 1374    27  12
SRR7939018.40043700 I   199 I   3516    +   +   UU  1   R1-2    199 3516    248 3565    60  60
SRR7939018.14444090 I   201 I   403 +   +   UU  1   R1-2    201 403 250 452 60  60
SRR7939018.60875057 I   201 I   456 +   +   UU  1   R1-2    201 456 250 505 60  35
SRR7939018.35249835 I   203 I   1396    +   -   UU  1   R1-2    203 1396    252 1347    60  32
SRR7939018.15001816 I   203 I   6184    +   -   UU  1   R1-2    203 6184    252 6135    60  60
SRR7939018.34494724 I   204 I   482 +   -   UU  1   R1-2    204 482 253 433 60  35
SRR7939018.22859704 I   209 I   458 -   -   UU  1   R1-2    209 458 160 409 18  57
SRR7939018.47000044 I   209 I   34714   -   -   UU  1   R1-2    209 34714   168 34665   33  60
SRR7939018.63597093 I   211 I   393 +   -   UU  1   R1-2    211 393 260 350 39  60
SRR7939018.1622372  I   211 I   997 +   -   UU  1   R1-2    211 997 260 951 39  60
SRR7939018.474429   I   213 I   499 -   +   UU  1   R1-2    213 499 164 537 35  48
SRR7939018.20506996 I   219 I   642 +   -   UU  1   R1-2    219 642 268 593 22  39
SRR7939018.53054840 I   221 I   482 -   -   UU  1   R1-2    221 482 172 433 57  35
SRR7939018.5192888  I   228 I   25  -   +   UU  1   R1-2    228 25  179 78  60  14
SRR7939018.54103083 I   228 I   67  -   +   UU  1   R1-2    228 67  179 114 60  60
SRR7939018.58302728 I   228 I   112 -   +   UU  1   R1-2    228 112 179 161 60  53
SRR7939018.11802973 I   228 I   375 -   +   UU  1   R1-2    228 375 179 424 60  32
SRR7939018.13131256 I   228 I   1317    -   +   UU  1   R1-2    228 1317    179 1366    60  42
SRR7939018.61381899 I   229 I   61832   -   -   UU  1   R1-2    229 61832   180 61783   60  60      A:T:32:61808:26
SRR7939018.43463684 I   230 I   66  -   -   UU  1   R1-2    230 66  181 17  60  42
SRR7939018.37234934 I   231 I   1   -   +   UU  1   R1-2    231 1   182 45  60  48
SRR7939018.57215855 I   231 I   1507    +   -   UU  1   R1-2    231 1507    280 1458    22  28
SRR7939018.21538317 I   231 I   3183    +   +   UU  1   R1-2    231 3183    280 3232    20  60  G:T:38:249:19
SRR7939018.27062170 I   231 I   5328    -   -   UU  1   R1-2    231 5328    182 5279    60  60
SRR7939018.30514503 I   232 I   516 +   -   UU  1   R1-2    232 516 281 467 22  53
SRR7939018.25735139 I   237 I   304 -   +   UU  1   R1-2    237 304 188 353 60  22  A:T:13:206:19
SRR7939018.16656470 I   237 I   1268    +   -   UU  1   R1-2    237 1268    286 1219    32  9
SRR7939018.35412212 I   237 I   1575    -   -   UU  1   R1-2    237 1575    188 1526    60  28
SRR7939018.45068006 I   237 I   14967   -   +   UU  1   R1-2    237 14967   188 15016   60  35
SRR7939018.57443737 I   238 I   196 +   -   UU  1   R1-2    238 196 287 153 32  27
SRR7939018.35540452 I   238 I   388 +   -   UU  1   R1-2    238 388 269 339 33  60
SRR7939018.738378   I   238 I   413 +   +   UU  1   R1-2    238 413 287 462 32  42
SRR7939018.49658035 I   238 I   1013    +   +   UU  1   R1-2    238 1013    287 1062    32  13
SRR7939018.18455078 I   238 I   1306    +   +   UU  1   R1-2    238 1306    287 1355    32  60
SRR7939018.25425454 I   239 I   447 +   -   UU  1   R1-2    239 447 288 398 32  60
SRR7939018.50160736 I   239 I   1145    +   -   UU  1   R1-2    239 1145    288 1096    32  60
SRR7939018.6589357  I   240 I   445 +   -   UU  1   R1-2    240 445 289 396 32  60
SRR7939018.29347329 I   240 I   58204   +   +   UU  1   R1-2    240 58204   289 58253   32  60
SRR7939018.47720593 I   241 I   412 +   -   UU  1   R1-2    241 412 272 363 15  50
SRR7939018.27920289 I   242 I   657 -   -   UU  1   R1-2    242 657 193 608 60  28
SRR7939018.28354716 I   243 I   52816   +   +   UU  1   R1-2    243 52816   292 52865   32  60
SRR7939018.46556463 I   247 I   624 +   -   UU  1   R1-2    247 624 296 575 35  35
SRR7939018.30258755 I   247 I   1070    -   -   UU  1   R1-2    247 1070    198 1021    60  9
SRR7939018.31082534 I   249 I   5864    -   +   UU  1   R1-2    249 5864    200 5913    60  60
SRR7939018.27987036 I   255 I   112 -   +   UU  1   R1-2    255 112 206 146 57  27
SRR7939018.50639585 I   256 I   196 +   -   UU  1   R1-2    256 196 305 147 39  15
SRR7939018.25112590 I   256 I   475 +   -   UU  1   R1-2    256 475 305 426 39  4
SRR7939018.37697195 I   256 I   561 +   -   UU  1   R1-2    256 561 305 512 39  7
SRR7939018.18628405 I   256 I   4844    -   +   UU  1   R1-2    256 4844    207 4893    60  60  T:C:13:230:24   T:G:13:4875:32
SRR7939018.8788749  I   257 I   199 +   -   UU  1   R1-2    257 199 306 150 42  15
SRR7939018.64068573 I   260 I   9673    -   +   UU  1   R1-2    260 9673    231 9722    60  60
SRR7939018.36512445 I   261 I   98  -   +   UU  1   R1-2    261 98  212 147 35  50
SRR7939018.53763682 I   261 I   130 -   +   UU  1   R1-2    261 130 212 170 35  54
SRR7939018.11082149 I   261 I   286 -   +   UU  1   R1-2    261 286 212 335 35  42
SRR7939018.395757   I   261 I   1300    -   +   UU  1   R1-2    261 1300    212 1344    35  60      G:T:38:1302:3
SRR7939018.36878402 I   261 I   1503    +   -   UU  1   R1-2    261 1503    310 1454    53  8
SRR7939018.58859396 I   261 I   151795  -   +   UU  1   R1-2    261 151795  212 151844  35  60
SRR7939018.9188285  I   262 I   548 -   -   UU  1   R1-2    262 548 230 499 39  35
SRR7939018.54906449 I   264 I   565 +   +   UU  1   R1-2    264 565 313 614 57  30      T:G:27:569:5,C:T:40:580:16
SRR7939018.6384391  I   264 I   1119    -   -   UU  1   R1-2    264 1119    215 1070    22  42
SRR7939018.22854810 I   265 I   1030    -   +   UU  1   R1-2    265 1030    216 1079    22  8
SRR7939018.12209119 I   265 I   30528   -   -   UU  1   R1-2    265 30528   216 30479   22  60
SRR7939018.24964457 I   267 I   267 +   +   UU  1   R1-2    267 267 316 300 60  60  C:A:2:311:45
SRR7939018.7234736  I   267 I   448 +   -   UU  1   R1-2    267 448 316 399 60  60      G:A:13:427:29
SRR7939018.19510743 I   267 I   540 +   -   UU  1   R1-2    267 540 316 491 60  35
SRR7939018.13899556 I   267 I   17657   +   +   UU  1   R1-2    267 17657   316 17706   60  13
SRR7939018.38503770 I   268 I   877 +   +   UU  1   R1-2    268 877 317 907 60  18
SRR7939018.474499   I   268 I   7631    -   +   UU  1   R1-2    268 7631    219 7669    22  60
SRR7939018.55837536 I   269 I   462 -   -   UU  1   R1-2    269 462 220 413 22  42
SRR7939018.21073549 I   269 I   1068    +   -   UU  1   R1-2    269 1068    318 1019    60  9       A:T:38:1064:46
SRR7939018.22540568 I   270 I   17997   +   +   UU  1   R1-2    270 17997   319 18046   60  15
SRR7939018.19685544 I   271 I   383 +   +   UU  1   R1-2    271 383 320 432 60  50  T:A:40:319:49
SRR7939018.50078671 I   272 I   149 -   +   UU  1   R1-2    272 149 223 198 22  15
SRR7939018.25382176 I   272 I   448 +   -   UU  1   R1-2    272 448 317 399 60  48      A:T:2:404:6,T:G:2:406:8,C:A:13:438:40
SRR7939018.33536302 I   272 I   511 +   -   UU  1   R1-2    272 511 321 462 60  46
SRR7939018.4328848  I   276 I   388 +   -   UU  1   R1-2    276 388 325 350 60  60
SRR7939018.11189274 I   279 I   964 +   +   UU  1   R1-2    279 964 328 1013    53  39
SRR7939018.15295337 I   280 I   618 -   +   UU  1   R1-2    280 618 234 667 39  12
SRR7939018.9615117  I   281 I   9123    -   +   UU  1   R1-2    281 9123    232 9172    22  60
SRR7939018.9583435  I   283 I   500 -   +   UU  1   R1-2    283 500 234 549 22  35
SRR7939018.46278305 I   284 I   1096    -   +   UU  1   R1-2    284 1096    235 1145    4   60  A:C:13:242:8
SRR7939018.41995560 I   284 I   3837    +   +   UU  1   R1-2    284 3837    333 3886    50  60
SRR7939018.42126681 I   284 I   40796   +   -   UU  1   R1-2    284 40796   333 40755   50  60
SRR7939018.60069005 I   286 I   646 -   -   UU  1   R1-2    286 646 237 597 32  35
SRR7939018.2693106  I   286 I   1556    +   +   UU  1   R1-2    286 1556    335 1594    42  19
SRR7939018.16225453 I   287 I   508 +   -   UU  1   R1-2    287 508 336 459 39  35
SRR7939018.22091177 I   289 I   554 +   -   UU  1   R1-2    289 554 338 505 35  6       G:T:2:508:4
SRR7939018.27010956 I   289 I   2411    -   -   UU  1   R1-2    289 2411    242 2362    39  13
SRR7939018.28786476 I   290 I   636 +   -   UU  1   R1-2    290 636 339 587 35  39
SRR7939018.33956231 I   292 I   203 +   -   UU  1   R1-2    292 203 341 154 35  13      T:C:13:198:45
SRR7939018.15585603 I   292 I   450 +   +   UU  1   R1-2    292 450 341 499 35  42
SRR7939018.64208972 I   294 I   350 -   +   UU  1   R1-2    294 350 245 399 35  50
SRR7939018.8013045  I   297 I   298 -   +   UU  1   R1-2    297 298 248 347 35  15
SRR7939018.58440622 I   297 I   566 -   +   UU  1   R1-2    297 566 248 615 35  35
SRR7939018.37769305 I   298 I   121 -   +   UU  1   R1-2    298 121 249 170 35  60
SRR7939018.56583569 I   301 I   221 +   -   UU  1   R1-2    301 221 344 172 27  57
SRR7939018.16125087 I   302 I   453 -   -   UU  1   R1-2    302 453 253 404 35  60
SRR7939018.62353867 I   304 I   620 +   -   UU  1   R1-2    304 620 353 584 22  26      A:G:40:583:0
SRR7939018.18152373 I   304 I   2170    -   +   UU  1   R1-2    304 2170    255 2219    35  6
SRR7939018.66151970 I   306 I   118 -   +   UU  1   R1-2    306 118 257 157 42  60
SRR7939018.4371675  I   307 I   8   -   +   UU  1   R1-2    307 8   258 57  46  28
SRR7939018.17515347 I   309 I   1942    -   -   UU  1   R1-2    309 1942    260 1911    53  27
SRR7939018.7312079  I   309 I   33506   -   +   UU  1   R1-2    309 33506   260 33555   53  60
SRR7939018.19509623 I   309 I   187437  -   -   UU  1   R1-2    309 187437  260 187388  53  4
SRR7939018.17206555 I   310 I   506 +   -   UU  1   R1-2    310 506 359 457 35  35
SRR7939018.21284547 I   310 I   33072   -   -   UU  1   R1-2    310 33072   261 33023   53  60
SRR7939018.5039839  I   314 I   389 -   +   UU  1   R1-2    314 389 265 438 60  60
SRR7939018.58846147 I   314 I   1395    -   -   UU  1   R1-2    314 1395    265 1346    60  32
SRR7939018.39041406 I   316 I   2677    +   +   UU  1   R1-2    316 2677    365 2726    57  46
SRR7939018.59515106 I   317 I   377 -   +   UU  1   R1-2    317 377 268 426 60  32
SRR7939018.53267260 I   317 I   437 -   +   UU  1   R1-2    317 437 268 486 60  42
SRR7939018.63746396 I   317 I   479 -   +   UU  1   R1-2    317 479 268 522 60  60
SRR7939018.12127032 I   317 I   598 -   -   UU  1   R1-2    317 598 268 549 60  11
SRR7939018.48867141 I   317 I   1105    -   -   UU  1   R1-2    317 1105    268 1056    60  9
SRR7939018.41904466 I   317 I   27906   -   -   UU  1   R1-2    317 27906   268 27857   60  60
SRR7939018.28431320 I   318 I   147 -   +   UU  1   R1-2    318 147 269 191 60  27
SRR7939018.27754454 I   318 I   154 -   +   UU  1   R1-2    318 154 269 184 60  19
SRR7939018.44608924 I   318 I   169 -   +   UU  1   R1-2    318 169 269 218 60  53
SRR7939018.25325734 I   318 I   410 -   -   UU  1   R1-2    318 410 269 376 60  7
SRR7939018.34611243 I   318 I   493 -   +   UU  1   R1-2    318 493 269 542 60  35
SRR7939018.48190964 I   318 I   550 -   -   UU  1   R1-2    318 550 269 501 60  35
SRR7939018.42699900 I   318 I   2076    -   +   UU  1   R1-2    318 2076    269 2125    60  8
SRR7939018.62489139 I   318 I   7046    -   -   UU  1   R1-2    318 7046    273 6997    60  60
SRR7939018.5634300  I   319 I   504 -   -   UU  1   R1-2    319 504 270 455 60  60
SRR7939018.5582342  I   319 I   2367    +   -   UU  1   R1-2    319 2367    368 2318    60  60
SRR7939018.50433185 I   319 I   4632    +   +   UU  1   R1-2    319 4632    368 4681    60  60
SRR7939018.13165688 I   321 I   172 +   +   UU  1   R1-2    321 172 370 221 60  57
SRR7939018.31301430 I   321 I   492 +   -   UU  1   R1-2    321 492 370 443 60  53
SRR7939018.26911284 I   321 I   4041    +   +   UU  1   R1-2    321 4041    370 4090    60  60
SRR7939018.16104906 I   321 I   8763    +   +   UU  1   R1-2    321 8763    370 8812    60  60
SRR7939018.17597296 I   322 I   119 -   -   UU  1   R1-2    322 119 273 77  60  60
SRR7939018.52698739 I   322 I   110955  +   -   UU  1   R1-2    322 110955  357 110909  39  60
SRR7939018.5236090  I   323 I   5908    -   +   UU  1   R1-2    323 5908    274 5957    60  60
SRR7939018.54645427 I   324 I   579 -   +   UU  1   R1-2    324 579 275 628 60  32
SRR7939018.171339   I   324 I   671 +   -   UU  1   R1-2    324 671 373 622 60  12
SRR7939018.55582591 I   324 I   2797    -   -   UU  1   R1-2    324 2797    275 2748    60  60
SRR7939018.15787174 I   329 I   149 -   +   UU  1   R1-2    329 149 280 198 53  15
SRR7939018.25588817 I   329 I   3194    +   +   UU  1   R1-2    329 3194    378 3243    38  60  A:G:13:329:1
SRR7939018.44478098 I   329 I   4012    -   -   UU  1   R1-2    329 4012    291 3963    39  60
SRR7939018.20785039 I   330 I   512 +   +   UU  1   R1-2    330 512 379 561 42  7
SRR7939018.36435828 I   330 I   637 -   -   UU  1   R1-2    330 637 281 588 53  39
SRR7939018.3993763  I   330 I   1306    -   +   UU  1   R1-2    330 1306    281 1355    53  60
SRR7939018.62229931 I   330 I   2414    -   -   UU  1   R1-2    330 2414    281 2365    53  13
SRR7939018.36302256 I   331 I   610 -   -   UU  1   R1-2    331 610 282 561 53  16
SRR7939018.22970716 I   331 I   6442    -   +   UU  1   R1-2    331 6442    282 6491    53  60
SRR7939018.20883050 I   333 I   455 -   +   UU  1   R1-2    333 455 284 504 50  35
SRR7939018.8896863  I   333 I   1608    -   +   UU  1   R1-2    333 1608    284 1657    50  2
SRR7939018.30464575 I   333 I   22903   -   +   UU  1   R1-2    333 22903   284 22952   50  4
SRR7939018.57984848 I   335 I   27366   +   +   UU  1   R1-2    335 27366   384 27415   60  53
SRR7939018.57772590 I   336 I   914 +   +   UU  1   R1-2    336 914 385 963 60  60
SRR7939018.46639408 I   338 I   12630   +   -   UU  1   R1-2    338 12630   387 12581   60  11


❯ #  Count number of unique pairs type in "${a_dedup_pre_pairs}"


❯ zcat "${a_dedup_pre_pairs}" \
>     | grep -v "^#" \
>     | cut -f 8 \
>     | sort \
>     | uniq -c
31204815 UU


❯ #  What are the RU and UR pair types?


❯ zcat "${a_dedup_pre_pairs}" | grep "RU\|UR"
```
<a id="rdna-2"></a>
###### "rDNA"
```txt
❯ run_check=TRUE


❯ [[ "${run_check}" == TRUE ]] &&
>     {
>         zcat "${a_dedup_pre_pairs}" | grep -v "#" | head -300
> 
>         #  Count number of unique pairs type in "${a_dedup_pre_pairs}"
>         zcat "${a_dedup_pre_pairs}" \
>             | grep -v "^#" \
>             | cut -f 8 \
>             | sort \
>             | uniq -c
> 
>         #  What are the RU and UR pair types?
>         zcat "${a_dedup_pre_pairs}" | grep "RU\|UR"
>     } ||
>     {
>         echo "Warning: \"run_check\" for dedup unique pairs outfile did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.17569487 I   5   I   194653  +   -   UU  1   R1-2    5   194653  57  194604  0   60
SRR7939018.47769906 I   5   I   207832  +   +   UU  1   R1-2    5   207832  54  207881  28  0
SRR7939018.3451089  I   6   I   229024  +   -   UU  1   R1-2    6   229024  55  228975  28  0
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60
SRR7939018.25573455 I   10  I   558 +   +   UU  1   R1-2    10  558 59  607 35  11
SRR7939018.63854041 I   10  I   646 +   -   UU  1   R1-2    10  646 62  597 0   35
SRR7939018.34992310 I   10  I   887 +   +   UU  1   R1-2    10  887 59  936 35  35
SRR7939018.1104427  I   10  I   31959   +   -   UU  1   R1-2    10  31959   59  31910   35  60
SRR7939018.35158773 I   11  I   865 +   +   UU  1   R1-2    11  865 60  914 39  35
SRR7939018.22989844 I   12  I   219 +   -   UU  1   R1-2    12  219 61  170 42  57
SRR7939018.33126366 I   12  I   119112  +   -   UU  1   R1-2    12  119112  61  119063  42  60
SRR7939018.18616690 I   13  I   280 +   -   UU  1   R1-2    13  280 62  231 42  20
SRR7939018.37239524 I   13  I   225598  +   -   UU  1   R1-2    13  225598  62  225549  42  0
SRR7939018.50678971 I   29  I   407 +   -   UU  1   R1-2    29  407 78  358 60  39
SRR7939018.10119014 I   36  I   470 +   -   UU  1   R1-2    36  470 78  421 60  6
SRR7939018.32594109 I   36  I   4721    -   -   UU  1   R1-2    36  4721    3   4672    0   60
SRR7939018.27720078 I   36  I   6006    -   +   UU  1   R1-2    36  6006    1   6041    0   60
SRR7939018.9636000  I   38  I   194 +   -   UU  1   R1-2    38  194 87  145 60  18
SRR7939018.43976050 I   38  I   229129  -   -   UU  1   R1-2    38  229129  1   229080  2   12
SRR7939018.56159970 I   39  I   2441    +   -   UU  1   R1-2    39  2441    88  2392    60  35
SRR7939018.35458836 I   40  I   89  +   -   UU  1   R1-2    40  89  89  40  60  60
SRR7939018.1099646  I   41  I   3   -   +   UU  1   R1-2    41  3   1   34  21  0
SRR7939018.54943727 I   41  I   178 +   +   UU  1   R1-2    41  178 90  227 60  57
SRR7939018.35434398 I   41  I   321 +   +   UU  1   R1-2    41  321 90  370 60  60
SRR7939018.19718640 I   41  I   395 +   +   UU  1   R1-2    41  395 90  444 60  60
SRR7939018.27890433 I   41  I   1731    +   +   UU  1   R1-2    41  1731    90  1780    60  15
SRR7939018.13293960 I   41  I   38151   -   +   UU  1   R1-2    41  38151   1   38200   18  60
SRR7939018.63754909 I   42  I   230171  +   +   UU  1   R1-2    42  230171  91  230217  60  0
SRR7939018.16006081 I   43  I   242 +   -   UU  1   R1-2    43  242 92  193 60  60
SRR7939018.31390391 I   43  I   2263    -   -   UU  1   R1-2    43  2263    1   2234    33  0
SRR7939018.50825843 I   52  I   336 -   +   UU  1   R1-2    52  336 3   385 28  60
SRR7939018.31073060 I   52  I   225224  -   -   UU  1   R1-2    52  225224  2   225175  26  0
SRR7939018.8625963  I   55  I   319 -   +   UU  1   R1-2    55  319 6   368 28  60
SRR7939018.18404752 I   56  I   479 -   +   UU  1   R1-2    56  479 7   528 28  39
SRR7939018.5344196  I   56  I   33715   -   -   UU  1   R1-2    56  33715   7   33666   22  60
SRR7939018.19358281 I   58  I   2936    -   -   UU  1   R1-2    58  2936    9   2887    13  60
SRR7939018.62948413 I   58  I   27756   -   +   UU  1   R1-2    58  27756   9   27805   32  32
SRR7939018.62698375 I   60  I   75259   -   +   UU  1   R1-2    60  75259   11  75308   18  60
SRR7939018.57525614 I   62  I   333 -   -   UU  1   R1-2    62  333 13  284 39  25
SRR7939018.63561884 I   62  I   9772    -   -   UU  1   R1-2    62  9772    13  9723    39  60
SRR7939018.54429866 I   62  I   228205  -   -   UU  1   R1-2    62  228205  13  228156  42  55
SRR7939018.11337172 I   63  I   3225    +   +   UU  1   R1-2    63  3225    112 3274    60  60
SRR7939018.32883053 I   64  I   4341    +   -   UU  1   R1-2    64  4341    113 4306    60  60
SRR7939018.41612980 I   66  I   289 -   -   UU  1   R1-2    66  289 18  247 44  27
SRR7939018.20486679 I   66  I   47606   -   +   UU  1   R1-2    66  47606   17  47645   42  60
SRR7939018.7101333  I   67  I   22195   -   -   UU  1   R1-2    67  22195   18  22146   38  0
SRR7939018.4271037  I   68  I   500 +   -   UU  1   R1-2    68  500 112 451 60  60
SRR7939018.40910611 I   68  I   210086  -   +   UU  1   R1-2    68  210086  19  210135  42  0
SRR7939018.13346597 I   72  I   4371    -   +   UU  1   R1-2    72  4371    23  4416    53  60
SRR7939018.24593858 I   72  I   7008    -   -   UU  1   R1-2    72  7008    23  6959    37  60
SRR7939018.41263687 I   73  I   49428   +   -   UU  1   R1-2    73  49428   122 49379   60  60
SRR7939018.34067598 I   77  I   298 +   -   UU  1   R1-2    77  298 131 249 53  35
SRR7939018.7777574  I   77  I   1223    -   -   UU  1   R1-2    77  1223    32  1174    60  9
SRR7939018.41918892 I   77  I   2410    -   -   UU  1   R1-2    77  2410    28  2361    60  13
SRR7939018.36976831 I   78  I   228 +   -   UU  1   R1-2    78  228 121 179 60  60
SRR7939018.11605183 I   78  I   1068    +   -   UU  1   R1-2    78  1068    127 1019    60  9
SRR7939018.61330774 I   78  I   4018    +   -   UU  1   R1-2    78  4018    127 3969    60  60
SRR7939018.58174255 I   79  I   1330    +   -   UU  1   R1-2    79  1330    128 1281    60  20
SRR7939018.54185633 I   79  I   1369    +   -   UU  1   R1-2    79  1369    128 1320    60  35
SRR7939018.32333692 I   79  I   207738  +   +   UU  1   R1-2    79  207738  114 207787  60  39
SRR7939018.30478651 I   81  I   95  -   +   UU  1   R1-2    81  95  32  144 52  50
SRR7939018.15936606 I   81  I   5173    -   +   UU  1   R1-2    81  5173    32  5210    60  60
SRR7939018.39027485 I   88  I   56075   -   +   UU  1   R1-2    88  56075   39  56124   60  60
SRR7939018.31861861 I   88  I   107563  -   +   UU  1   R1-2    88  107563  39  107612  60  60
SRR7939018.26002914 I   89  I   296 +   -   UU  1   R1-2    89  296 138 247 53  35
SRR7939018.46658462 I   89  I   318 +   -   UU  1   R1-2    89  318 131 269 60  28
SRR7939018.24703715 I   89  I   964 -   +   UU  1   R1-2    89  964 40  1013    60  39
SRR7939018.34060015 I   93  I   194 +   -   UU  1   R1-2    93  194 126 145 54  18
SRR7939018.4599895  I   94  I   314 +   -   UU  1   R1-2    94  314 126 265 48  60
SRR7939018.22066078 I   94  I   996 +   -   UU  1   R1-2    94  996 125 947 48  8
SRR7939018.3480101  I   95  I   338 +   -   UU  1   R1-2    95  338 126 289 39  33
SRR7939018.29817538 I   95  I   411 +   +   UU  1   R1-2    95  411 144 460 2   50
SRR7939018.12120171 I   95  I   499 +   -   UU  1   R1-2    95  499 144 450 50  60
SRR7939018.21859222 I   95  I   11883   +   +   UU  1   R1-2    95  11883   144 11932   50  0
SRR7939018.56703503 I   96  I   463 +   +   UU  1   R1-2    96  463 145 504 50  60
SRR7939018.2893773  I   99  I   401 +   -   UU  1   R1-2    99  401 148 358 50  21
SRR7939018.53674992 I   99  I   230173  +   -   UU  1   R1-2    99  230173  148 230126  1   0
SRR7939018.50311998 I   104 I   4760    -   +   UU  1   R1-2    104 4760    70  4809    60  60
SRR7939018.8198197  I   105 I   83  +   -   UU  1   R1-2    105 83  144 44  21  60
SRR7939018.46628911 I   108 I   238 +   +   UU  1   R1-2    108 238 157 287 39  32
SRR7939018.54704375 I   108 I   256 +   -   UU  1   R1-2    108 256 157 212 39  60
SRR7939018.31780843 I   108 I   411 +   +   UU  1   R1-2    108 411 157 460 39  50
SRR7939018.45965058 I   112 I   10  -   +   UU  1   R1-2    112 10  75  59  60  35
SRR7939018.15594546 I   112 I   261 +   -   UU  1   R1-2    112 261 161 212 53  35
SRR7939018.33827262 I   112 I   407 +   -   UU  1   R1-2    112 407 161 358 53  39
SRR7939018.88645    I   112 I   230127  +   +   UU  1   R1-2    112 230127  144 230168  15  2
SRR7939018.12523998 I   112 I   230183  -   -   UU  1   R1-2    112 230183  73  230148  60  0
SRR7939018.2342447  I   114 I   321 -   -   UU  1   R1-2    114 321 79  272 60  60
SRR7939018.33953    I   114 I   1052    +   -   UU  1   R1-2    114 1052    163 1003    60  39
SRR7939018.16129580 I   116 I   10  -   +   UU  1   R1-2    116 10  67  59  60  35
SRR7939018.6945655  I   116 I   62  -   -   UU  1   R1-2    116 62  80  13  60  39
SRR7939018.64245749 I   116 I   1991    -   +   UU  1   R1-2    116 1991    73  2040    60  0
SRR7939018.18958897 I   116 I   6531    -   +   UU  1   R1-2    116 6531    73  6580    60  60
SRR7939018.36806590 I   117 I   66815   -   +   UU  1   R1-2    117 66815   68  66864   60  60
SRR7939018.56325226 I   120 I   67  +   -   UU  1   R1-2    120 67  169 18  60  42
SRR7939018.48930140 I   120 I   298 +   -   UU  1   R1-2    120 298 169 249 60  35
SRR7939018.10294309 I   120 I   370 +   -   UU  1   R1-2    120 370 169 321 60  35
SRR7939018.149574   I   122 I   329 +   -   UU  1   R1-2    122 329 171 280 60  53
SRR7939018.30608017 I   122 I   440 +   -   UU  1   R1-2    122 440 171 391 60  60
SRR7939018.42054658 I   128 I   556 -   +   UU  1   R1-2    128 556 91  605 39  11
SRR7939018.18870615 I   129 I   77  -   -   UU  1   R1-2    129 77  93  28  60  60
SRR7939018.63830453 I   130 I   306 +   -   UU  1   R1-2    130 306 179 272 53  60
SRR7939018.27872423 I   130 I   318 +   -   UU  1   R1-2    130 318 179 282 53  60
SRR7939018.64264442 I   130 I   361 +   -   UU  1   R1-2    130 361 179 312 53  42
SRR7939018.46489678 I   130 I   499 +   -   UU  1   R1-2    130 499 179 450 53  42
SRR7939018.38483937 I   130 I   598 +   -   UU  1   R1-2    130 598 179 549 53  11
SRR7939018.44672941 I   130 I   4231    +   -   UU  1   R1-2    130 4231    179 4182    53  60
SRR7939018.8174511  I   131 I   266 +   -   UU  1   R1-2    131 266 180 217 53  22
SRR7939018.63069824 I   131 I   270 +   -   UU  1   R1-2    131 270 160 221 48  59
SRR7939018.63360991 I   131 I   408 +   -   UU  1   R1-2    131 408 180 377 53  1
SRR7939018.35055818 I   131 I   516 +   -   UU  1   R1-2    131 516 180 467 53  53
SRR7939018.7931206  I   131 I   566 +   -   UU  1   R1-2    131 566 180 517 53  0
SRR7939018.41132537 I   131 I   2363    +   -   UU  1   R1-2    131 2363    180 2314    53  60
SRR7939018.53010615 I   132 I   964 +   +   UU  1   R1-2    132 964 167 1013    39  39
SRR7939018.25442689 I   135 I   1856    +   +   UU  1   R1-2    135 1856    184 1905    46  0
SRR7939018.50255224 I   135 I   8633    +   +   UU  1   R1-2    135 8633    184 8682    46  60
SRR7939018.34795673 I   139 I   321 -   +   UU  1   R1-2    139 321 93  370 60  60
SRR7939018.17862572 I   141 I   224076  -   +   UU  1   R1-2    141 224076  92  224125  13  0
SRR7939018.41341751 I   142 I   318 +   -   UU  1   R1-2    142 318 191 269 32  60
SRR7939018.55317485 I   142 I   408 -   -   UU  1   R1-2    142 408 93  359 50  35
SRR7939018.45767801 I   142 I   674 -   -   UU  1   R1-2    142 674 93  625 50  12
SRR7939018.44856945 I   144 I   1   -   +   UU  1   R1-2    144 1   112 41  15  21
SRR7939018.57480364 I   144 I   372 +   -   UU  1   R1-2    144 372 179 323 24  35
SRR7939018.60244328 I   148 I   8314    -   +   UU  1   R1-2    148 8314    99  8363    50  60
SRR7939018.62030183 I   149 I   340 +   +   UU  1   R1-2    149 340 198 389 15  60
SRR7939018.50687203 I   149 I   58674   +   +   UU  1   R1-2    149 58674   198 58723   15  60
SRR7939018.49320290 I   149 I   222763  +   +   UU  1   R1-2    149 222763  194 222812  27  0
SRR7939018.14735998 I   153 I   9   -   +   UU  1   R1-2    153 9   104 40  35  13
SRR7939018.10348915 I   153 I   38  +   +   UU  1   R1-2    153 38  202 87  15  60
SRR7939018.11559411 I   153 I   67  +   -   UU  1   R1-2    153 67  202 27  15  60
SRR7939018.57507662 I   153 I   314 +   -   UU  1   R1-2    153 314 198 265 27  60
SRR7939018.51634879 I   153 I   484 +   -   UU  1   R1-2    153 484 202 435 15  35
SRR7939018.20823598 I   159 I   5   -   +   UU  1   R1-2    159 5   110 50  46  48
SRR7939018.49019958 I   159 I   1065    -   -   UU  1   R1-2    159 1065    110 1016    46  9
SRR7939018.2136687  I   159 I   1955    -   -   UU  1   R1-2    159 1955    119 1918    60  0
SRR7939018.7089964  I   160 I   797 -   +   UU  1   R1-2    160 797 121 846 60  15
SRR7939018.49430764 I   161 I   393 +   -   UU  1   R1-2    161 393 210 344 22  60
SRR7939018.32117170 I   163 I   342 +   -   UU  1   R1-2    163 342 212 293 32  32
SRR7939018.44825194 I   164 I   144 +   -   UU  1   R1-2    164 144 207 95  27  50
SRR7939018.9190308  I   167 I   510 -   +   UU  1   R1-2    167 510 125 559 32  6
SRR7939018.41564659 I   168 I   306 +   -   UU  1   R1-2    168 306 213 257 60  42
SRR7939018.38567586 I   168 I   440 +   -   UU  1   R1-2    168 440 217 391 50  60
SRR7939018.14394214 I   169 I   440 +   -   UU  1   R1-2    169 440 215 391 60  60
SRR7939018.58143382 I   169 I   445 +   -   UU  1   R1-2    169 445 198 396 27  60
SRR7939018.34873955 I   170 I   225984  +   +   UU  1   R1-2    170 225984  219 226033  57  0
SRR7939018.1218818  I   172 I   297 +   -   UU  1   R1-2    172 297 206 248 27  35
SRR7939018.27830998 I   172 I   445 +   -   UU  1   R1-2    172 445 221 396 57  60
SRR7939018.37292189 I   174 I   360 +   -   UU  1   R1-2    174 360 223 311 57  39
SRR7939018.16726495 I   174 I   1634    +   +   UU  1   R1-2    174 1634    223 1678    57  0
SRR7939018.62262963 I   178 I   965 +   +   UU  1   R1-2    178 965 227 1002    57  25
SRR7939018.40100680 I   179 I   179 +   +   UU  1   R1-2    179 179 228 228 42  53
SRR7939018.18013213 I   179 I   393 +   -   UU  1   R1-2    179 393 228 344 60  60
SRR7939018.40530226 I   179 I   997 +   -   UU  1   R1-2    179 997 228 954 60  60
SRR7939018.17438715 I   179 I   1519    +   +   UU  1   R1-2    179 1519    228 1568    60  52
SRR7939018.22131647 I   179 I   2098    +   -   UU  1   R1-2    179 2098    228 2049    60  0
SRR7939018.2072227  I   180 I   318 +   -   UU  1   R1-2    180 318 229 269 60  46
SRR7939018.11959452 I   180 I   320 +   -   UU  1   R1-2    180 320 217 271 33  60
SRR7939018.64470435 I   182 I   159 +   -   UU  1   R1-2    182 159 231 116 60  60
SRR7939018.43306138 I   185 I   347 -   +   UU  1   R1-2    185 347 136 396 42  60
SRR7939018.25238317 I   185 I   683 -   -   UU  1   R1-2    185 683 136 634 42  0
SRR7939018.39319550 I   185 I   225957  -   +   UU  1   R1-2    185 225957  149 226006  25  0
SRR7939018.636925   I   186 I   22109   +   -   UU  1   R1-2    186 22109   235 22060   60  35
SRR7939018.18893333 I   187 I   448 +   +   UU  1   R1-2    187 448 236 497 60  50
SRR7939018.33701049 I   190 I   4166    +   +   UU  1   R1-2    190 4166    239 4215    60  60
SRR7939018.32232023 I   190 I   70094   +   +   UU  1   R1-2    190 70094   239 70143   60  60
SRR7939018.53297799 I   191 I   46260   +   +   UU  1   R1-2    191 46260   240 46309   60  60
SRR7939018.40600493 I   194 I   702 -   -   UU  1   R1-2    194 702 145 653 18  22
SRR7939018.54428661 I   196 I   1872    -   +   UU  1   R1-2    196 1872    147 1921    15  4
SRR7939018.24526425 I   197 I   499 +   -   UU  1   R1-2    197 499 246 450 60  42
SRR7939018.29763149 I   199 I   1423    -   -   UU  1   R1-2    199 1423    161 1374    27  12
SRR7939018.40043700 I   199 I   3516    +   +   UU  1   R1-2    199 3516    248 3565    60  60
SRR7939018.14444090 I   201 I   403 +   +   UU  1   R1-2    201 403 250 452 60  60
SRR7939018.60875057 I   201 I   456 +   +   UU  1   R1-2    201 456 250 505 60  35
SRR7939018.35249835 I   203 I   1396    +   -   UU  1   R1-2    203 1396    252 1347    60  32
SRR7939018.15001816 I   203 I   6184    +   -   UU  1   R1-2    203 6184    252 6135    60  60
SRR7939018.34494724 I   204 I   482 +   -   UU  1   R1-2    204 482 253 433 60  35
SRR7939018.22859704 I   209 I   458 -   -   UU  1   R1-2    209 458 160 409 18  57
SRR7939018.47000044 I   209 I   34714   -   -   UU  1   R1-2    209 34714   168 34665   33  60
SRR7939018.63597093 I   211 I   393 +   -   UU  1   R1-2    211 393 260 350 39  60
SRR7939018.1622372  I   211 I   997 +   -   UU  1   R1-2    211 997 260 951 39  60
SRR7939018.474429   I   213 I   499 -   +   UU  1   R1-2    213 499 164 537 35  48
SRR7939018.20506996 I   219 I   642 +   -   UU  1   R1-2    219 642 268 593 22  39
SRR7939018.53054840 I   221 I   482 -   -   UU  1   R1-2    221 482 172 433 57  35
SRR7939018.5192888  I   228 I   25  -   +   UU  1   R1-2    228 25  179 78  60  14
SRR7939018.54103083 I   228 I   67  -   +   UU  1   R1-2    228 67  179 114 60  60
SRR7939018.58302728 I   228 I   112 -   +   UU  1   R1-2    228 112 179 161 60  53
SRR7939018.11802973 I   228 I   375 -   +   UU  1   R1-2    228 375 179 424 60  32
SRR7939018.13131256 I   228 I   1317    -   +   UU  1   R1-2    228 1317    179 1366    60  42
SRR7939018.25854371 I   228 I   2000    -   -   UU  1   R1-2    228 2000    179 1951    60  0
SRR7939018.65161064 I   228 I   206537  -   -   UU  1   R1-2    228 206537  179 206488  60  0
SRR7939018.61381899 I   229 I   61832   -   -   UU  1   R1-2    229 61832   180 61783   60  60
SRR7939018.43463684 I   230 I   66  -   -   UU  1   R1-2    230 66  181 17  60  42
SRR7939018.37234934 I   231 I   1   -   +   UU  1   R1-2    231 1   182 45  60  48
SRR7939018.57215855 I   231 I   1507    +   -   UU  1   R1-2    231 1507    280 1458    22  28
SRR7939018.21538317 I   231 I   3183    +   +   UU  1   R1-2    231 3183    280 3232    20  60
SRR7939018.27062170 I   231 I   5328    -   -   UU  1   R1-2    231 5328    182 5279    60  60
SRR7939018.15725838 I   231 I   230210  +   -   UU  1   R1-2    231 230210  272 230160  39  0
SRR7939018.30514503 I   232 I   516 +   -   UU  1   R1-2    232 516 281 467 22  53
SRR7939018.12303258 I   237 I   78  +   -   UU  1   R1-2    237 78  285 29  0   60
SRR7939018.25735139 I   237 I   304 -   +   UU  1   R1-2    237 304 188 353 60  22
SRR7939018.16656470 I   237 I   1268    +   -   UU  1   R1-2    237 1268    286 1219    32  9
SRR7939018.59131443 I   237 I   1352    +   -   UU  1   R1-2    237 1352    285 1305    0   60
SRR7939018.35412212 I   237 I   1575    -   -   UU  1   R1-2    237 1575    188 1526    60  28
SRR7939018.45068006 I   237 I   14967   -   +   UU  1   R1-2    237 14967   188 15016   60  35
SRR7939018.57443737 I   238 I   196 +   -   UU  1   R1-2    238 196 287 153 32  27
SRR7939018.35540452 I   238 I   388 +   -   UU  1   R1-2    238 388 269 339 33  60
SRR7939018.738378   I   238 I   413 +   +   UU  1   R1-2    238 413 287 462 32  42
SRR7939018.49658035 I   238 I   1013    +   +   UU  1   R1-2    238 1013    287 1062    32  13
SRR7939018.51753543 I   238 I   1117    +   +   UU  1   R1-2    238 1117    287 1157    32  0
SRR7939018.18455078 I   238 I   1306    +   +   UU  1   R1-2    238 1306    287 1355    32  60
SRR7939018.25425454 I   239 I   447 +   -   UU  1   R1-2    239 447 288 398 32  60
SRR7939018.50160736 I   239 I   1145    +   -   UU  1   R1-2    239 1145    288 1096    32  60
SRR7939018.6589357  I   240 I   445 +   -   UU  1   R1-2    240 445 289 396 32  60
SRR7939018.7361044  I   240 I   523 +   +   UU  1   R1-2    240 523 289 564 32  0
SRR7939018.29347329 I   240 I   58204   +   +   UU  1   R1-2    240 58204   289 58253   32  60
SRR7939018.47720593 I   241 I   412 +   -   UU  1   R1-2    241 412 272 363 15  50
SRR7939018.27920289 I   242 I   657 -   -   UU  1   R1-2    242 657 193 608 60  28
SRR7939018.58987149 I   242 I   218162  -   +   UU  1   R1-2    242 218162  201 218205  60  0
SRR7939018.28354716 I   243 I   52816   +   +   UU  1   R1-2    243 52816   292 52865   32  60
SRR7939018.46556463 I   247 I   624 +   -   UU  1   R1-2    247 624 296 575 35  35
SRR7939018.30258755 I   247 I   1070    -   -   UU  1   R1-2    247 1070    198 1021    60  9
SRR7939018.31082534 I   249 I   5864    -   +   UU  1   R1-2    249 5864    200 5913    60  60
SRR7939018.27987036 I   255 I   112 -   +   UU  1   R1-2    255 112 206 146 57  27
SRR7939018.50639585 I   256 I   196 +   -   UU  1   R1-2    256 196 305 147 39  15
SRR7939018.25112590 I   256 I   475 +   -   UU  1   R1-2    256 475 305 426 39  4
SRR7939018.37697195 I   256 I   561 +   -   UU  1   R1-2    256 561 305 512 39  7
SRR7939018.18628405 I   256 I   4844    -   +   UU  1   R1-2    256 4844    207 4893    60  60
SRR7939018.8788749  I   257 I   199 +   -   UU  1   R1-2    257 199 306 150 42  15
SRR7939018.64068573 I   260 I   9673    -   +   UU  1   R1-2    260 9673    231 9722    60  60
SRR7939018.18845559 I   261 I   56  -   -   UU  1   R1-2    261 56  212 1   35  0
SRR7939018.36512445 I   261 I   98  -   +   UU  1   R1-2    261 98  212 147 35  50
SRR7939018.53763682 I   261 I   130 -   +   UU  1   R1-2    261 130 212 170 35  54
SRR7939018.11082149 I   261 I   286 -   +   UU  1   R1-2    261 286 212 335 35  42
SRR7939018.395757   I   261 I   1300    -   +   UU  1   R1-2    261 1300    212 1344    35  60
SRR7939018.36878402 I   261 I   1503    +   -   UU  1   R1-2    261 1503    310 1454    53  8
SRR7939018.58859396 I   261 I   151795  -   +   UU  1   R1-2    261 151795  212 151844  35  60
SRR7939018.9188285  I   262 I   548 -   -   UU  1   R1-2    262 548 230 499 39  35
SRR7939018.54906449 I   264 I   565 +   +   UU  1   R1-2    264 565 313 614 57  30
SRR7939018.6384391  I   264 I   1119    -   -   UU  1   R1-2    264 1119    215 1070    22  42
SRR7939018.22854810 I   265 I   1030    -   +   UU  1   R1-2    265 1030    216 1079    22  8
SRR7939018.12209119 I   265 I   30528   -   -   UU  1   R1-2    265 30528   216 30479   22  60
SRR7939018.24964457 I   267 I   267 +   +   UU  1   R1-2    267 267 316 300 60  60
SRR7939018.7234736  I   267 I   448 +   -   UU  1   R1-2    267 448 316 399 60  60
SRR7939018.19510743 I   267 I   540 +   -   UU  1   R1-2    267 540 316 491 60  35
SRR7939018.13899556 I   267 I   17657   +   +   UU  1   R1-2    267 17657   316 17706   60  13
SRR7939018.38503770 I   268 I   877 +   +   UU  1   R1-2    268 877 317 907 60  18
SRR7939018.474499   I   268 I   7631    -   +   UU  1   R1-2    268 7631    219 7669    22  60
SRR7939018.55837536 I   269 I   462 -   -   UU  1   R1-2    269 462 220 413 22  42
SRR7939018.21073549 I   269 I   1068    +   -   UU  1   R1-2    269 1068    318 1019    60  9
SRR7939018.22540568 I   270 I   17997   +   +   UU  1   R1-2    270 17997   319 18046   60  15
SRR7939018.19685544 I   271 I   383 +   +   UU  1   R1-2    271 383 320 432 60  50
SRR7939018.50078671 I   272 I   149 -   +   UU  1   R1-2    272 149 223 198 22  15
SRR7939018.25382176 I   272 I   448 +   -   UU  1   R1-2    272 448 317 399 60  48
SRR7939018.33536302 I   272 I   511 +   -   UU  1   R1-2    272 511 321 462 60  46
SRR7939018.4328848  I   276 I   388 +   -   UU  1   R1-2    276 388 325 350 60  60
SRR7939018.11189274 I   279 I   964 +   +   UU  1   R1-2    279 964 328 1013    53  39
SRR7939018.15295337 I   280 I   618 -   +   UU  1   R1-2    280 618 234 667 39  12
SRR7939018.9615117  I   281 I   9123    -   +   UU  1   R1-2    281 9123    232 9172    22  60
SRR7939018.9583435  I   283 I   500 -   +   UU  1   R1-2    283 500 234 549 22  35
SRR7939018.46278305 I   284 I   1096    -   +   UU  1   R1-2    284 1096    235 1145    4   60
SRR7939018.41995560 I   284 I   3837    +   +   UU  1   R1-2    284 3837    333 3886    50  60
SRR7939018.42126681 I   284 I   40796   +   -   UU  1   R1-2    284 40796   333 40755   50  60
SRR7939018.60069005 I   286 I   646 -   -   UU  1   R1-2    286 646 237 597 32  35
SRR7939018.2693106  I   286 I   1556    +   +   UU  1   R1-2    286 1556    335 1594    42  19
SRR7939018.16225453 I   287 I   508 +   -   UU  1   R1-2    287 508 336 459 39  35
SRR7939018.22091177 I   289 I   554 +   -   UU  1   R1-2    289 554 338 505 35  6
SRR7939018.25087515 I   289 I   2406    -   -   UU  1   R1-2    289 2406    242 2362    39  0
SRR7939018.27010956 I   289 I   2411    -   -   UU  1   R1-2    289 2411    242 2362    39  13
SRR7939018.28786476 I   290 I   636 +   -   UU  1   R1-2    290 636 339 587 35  39
SRR7939018.21865566 I   290 I   3652    -   +   UU  1   R1-2    290 3652    245 3701    0   60
SRR7939018.9180585  I   290 I   15356   -   +   UU  1   R1-2    290 15356   245 15405   0   0
SRR7939018.33956231 I   292 I   203 +   -   UU  1   R1-2    292 203 341 154 35  13
SRR7939018.15585603 I   292 I   450 +   +   UU  1   R1-2    292 450 341 499 35  42
SRR7939018.64208972 I   294 I   350 -   +   UU  1   R1-2    294 350 245 399 35  50
SRR7939018.19906886 I   294 I   222381  -   -   UU  1   R1-2    294 222381  245 222332  35  0
SRR7939018.8013045  I   297 I   298 -   +   UU  1   R1-2    297 298 248 347 35  15
SRR7939018.58440622 I   297 I   566 -   +   UU  1   R1-2    297 566 248 615 35  35
SRR7939018.37769305 I   298 I   121 -   +   UU  1   R1-2    298 121 249 170 35  60
SRR7939018.23540125 I   298 I   2005    +   -   UU  1   R1-2    298 2005    343 1956    27  0
SRR7939018.2667010  I   298 I   2066    -   +   UU  1   R1-2    298 2066    249 2115    35  0
SRR7939018.32088079 I   298 I   226396  -   +   UU  1   R1-2    298 226396  249 226445  35  0
SRR7939018.56583569 I   301 I   221 +   -   UU  1   R1-2    301 221 344 172 27  57
SRR7939018.16125087 I   302 I   453 -   -   UU  1   R1-2    302 453 253 404 35  60
SRR7939018.62353867 I   304 I   620 +   -   UU  1   R1-2    304 620 353 584 22  26
SRR7939018.18152373 I   304 I   2170    -   +   UU  1   R1-2    304 2170    255 2219    35  6
SRR7939018.66151970 I   306 I   118 -   +   UU  1   R1-2    306 118 257 157 42  60
SRR7939018.4371675  I   307 I   8   -   +   UU  1   R1-2    307 8   258 57  46  28
SRR7939018.43372861 I   307 I   1116    +   -   UU  1   R1-2    307 1116    336 1067    0   32
SRR7939018.17515347 I   309 I   1942    -   -   UU  1   R1-2    309 1942    260 1911    53  27
SRR7939018.7312079  I   309 I   33506   -   +   UU  1   R1-2    309 33506   260 33555   53  60
SRR7939018.19509623 I   309 I   187437  -   -   UU  1   R1-2    309 187437  260 187388  53  4
SRR7939018.17206555 I   310 I   506 +   -   UU  1   R1-2    310 506 359 457 35  35
SRR7939018.21284547 I   310 I   33072   -   -   UU  1   R1-2    310 33072   261 33023   53  60
SRR7939018.5039839  I   314 I   389 -   +   UU  1   R1-2    314 389 265 438 60  60


50482066 UU


No "RU|UR"
```
</details>
<br />

<a id="check-the-stats-outfile"></a>
##### Check the stats outfile
<details>
<summary><i>Printed: Check the stats outfile</i></summary>

<a id="standard-3"></a>
###### "Standard"
```txt
 1 ❯ #  Check the stats outfile ----------------------------------------------------


 1 ❯ ., "${a_dedup_stats}"
-rw-rw---- 1 kalavatt 13K Jul  6 12:41 0X_stats/SRR7939018.dedup.stats.txt


❯ cat "${a_dedup_stats}"  # less "${a_dedup_stats}"
total   66153900
total_unmapped  16714538
total_single_sided_mapped   11485160
total_mapped    37954202
total_dups  6749387
total_nodups    31204815
cis 17902137
trans   13302678
pair_types/MM   14039891
pair_types/MN   701106
pair_types/NM   558057
pair_types/NN   1415484
pair_types/MU   3912147
pair_types/NU   2065238
pair_types/UM   3502692
pair_types/UN   2005083
pair_types/UU   31204815
pair_types/DD   6749387
cis_1kb+    11274151
cis_2kb+    9127240
cis_4kb+    7303262
cis_10kb+   5296553
cis_20kb+   4030921
cis_40kb+   2951873
summary/frac_cis    0.5736979052751955
summary/frac_cis_1kb+   0.3612952360076482
summary/frac_cis_2kb+   0.2924946037975229
summary/frac_cis_4kb+   0.23404279115258333
summary/frac_cis_10kb+  0.16973511940384842
summary/frac_cis_20kb+  0.1291762505241579
summary/frac_cis_40kb+  0.09459671528256136
summary/frac_dups   0.17782976967873018
summary/complexity_naive    93648195.31794095
chrom_freq/I/I  322211
chrom_freq/I/IV 19390
chrom_freq/I/II 17785
chrom_freq/I/III    17465
chrom_freq/I/IX 19095
chrom_freq/I/VII    18507
chrom_freq/I/VIII   17846
chrom_freq/I/VI 17802
chrom_freq/I/V  15176
chrom_freq/I/X  19740
chrom_freq/I/Mito   1037
chrom_freq/I/XII    18388
chrom_freq/I/XIV    17983
chrom_freq/I/XI 17270
chrom_freq/I/XIII   16902
chrom_freq/I/XV 17562
chrom_freq/I/XVI    17233
chrom_freq/II/I 17628
chrom_freq/II/II    1206575
chrom_freq/II/III   28049
chrom_freq/II/IV    118361
chrom_freq/II/IX    40389
chrom_freq/II/Mito  3702
chrom_freq/II/V 51593
chrom_freq/II/VI    24332
chrom_freq/II/VII   92821
chrom_freq/II/VIII  51243
chrom_freq/II/X 64562
chrom_freq/II/XI    58809
chrom_freq/II/XII   80877
chrom_freq/II/XIII  78441
chrom_freq/II/XIV   66147
chrom_freq/II/XV    93348
chrom_freq/II/XVI   80970
chrom_freq/III/III  454659
chrom_freq/III/II   27751
chrom_freq/III/I    17295
chrom_freq/III/IV   32368
chrom_freq/III/IX   22976
chrom_freq/III/V    24893
chrom_freq/III/Mito 1418
chrom_freq/III/VII  28922
chrom_freq/III/VIII 24822
chrom_freq/III/VI   20912
chrom_freq/III/X    27255
chrom_freq/III/XII  27164
chrom_freq/III/XI   25129
chrom_freq/III/XIII 29121
chrom_freq/III/XIV  29307
chrom_freq/III/XV   28298
chrom_freq/III/XVI  29504
chrom_freq/IV/II    118351
chrom_freq/IV/I 19245
chrom_freq/IV/IV    2297835
chrom_freq/IV/III   32588
chrom_freq/IV/IX    57208
chrom_freq/IV/V 77142
chrom_freq/IV/Mito  6732
chrom_freq/IV/VII   156405
chrom_freq/IV/VI    28436
chrom_freq/IV/VIII  77720
chrom_freq/IV/X 96750
chrom_freq/IV/XI    90197
chrom_freq/IV/XII   143992
chrom_freq/IV/XIII  129879
chrom_freq/IV/XIV   108334
chrom_freq/IV/XV    162096
chrom_freq/IV/XVI   130799
chrom_freq/IX/I 19160
chrom_freq/IX/II    40729
chrom_freq/IX/III   23349
chrom_freq/IX/IV    57296
chrom_freq/IX/IX    637035
chrom_freq/IX/V 31304
chrom_freq/IX/VI    21853
chrom_freq/IX/VII   48039
chrom_freq/IX/Mito  2027
chrom_freq/IX/VIII  30881
chrom_freq/IX/X 39000
chrom_freq/IX/XI    34719
chrom_freq/IX/XII   41642
chrom_freq/IX/XIII  41660
chrom_freq/IX/XIV   38295
chrom_freq/IX/XV    47062
chrom_freq/IX/XVI   42312
chrom_freq/Mito/Mito    50999
chrom_freq/Mito/IV  5410
chrom_freq/Mito/II  3011
chrom_freq/Mito/IX  1627
chrom_freq/Mito/III 1185
chrom_freq/Mito/I   848
chrom_freq/Mito/XII 5443
chrom_freq/Mito/VII 3911
chrom_freq/Mito/XV  3902
chrom_freq/Mito/XIII    3433
chrom_freq/Mito/XVI 3694
chrom_freq/Mito/XIV 2829
chrom_freq/Mito/X   2719
chrom_freq/Mito/XI  2460
chrom_freq/Mito/VIII    2146
chrom_freq/Mito/V   2013
chrom_freq/Mito/VI  1070
chrom_freq/V/II 51986
chrom_freq/V/I  15094
chrom_freq/V/IV 77432
chrom_freq/V/III    25110
chrom_freq/V/IX 31489
chrom_freq/V/V  799457
chrom_freq/V/Mito   2632
chrom_freq/V/VI 20287
chrom_freq/V/VII    62898
chrom_freq/V/VIII   36432
chrom_freq/V/X  46009
chrom_freq/V/XI 43060
chrom_freq/V/XII    56383
chrom_freq/V/XIII   54902
chrom_freq/V/XIV    47039
chrom_freq/V/XV 63505
chrom_freq/V/XVI    57583
chrom_freq/VI/I 17599
chrom_freq/VI/IV    29066
chrom_freq/VI/II    24255
chrom_freq/VI/III   20622
chrom_freq/VI/VI    392432
chrom_freq/VI/IX    21886
chrom_freq/VI/V 20413
chrom_freq/VI/Mito  1271
chrom_freq/VI/VII   26444
chrom_freq/VI/VIII  20948
chrom_freq/VI/X 25734
chrom_freq/VI/XII   24046
chrom_freq/VI/XI    23670
chrom_freq/VI/XIII  23957
chrom_freq/VI/XV    25609
chrom_freq/VI/XIV   23707
chrom_freq/VI/XVI   24023
chrom_freq/VII/II   92565
chrom_freq/VII/I    18574
chrom_freq/VII/III  28928
chrom_freq/VII/IV   156141
chrom_freq/VII/IX   47365
chrom_freq/VII/V    62328
chrom_freq/VII/Mito 4807
chrom_freq/VII/VII  1586259
chrom_freq/VII/VI   26399
chrom_freq/VII/VIII 61158
chrom_freq/VII/X    78267
chrom_freq/VII/XI   72825
chrom_freq/VII/XII  106633
chrom_freq/VII/XIII 99777
chrom_freq/VII/XIV  82929
chrom_freq/VII/XV   120378
chrom_freq/VII/XVI  102489
chrom_freq/VIII/II  51322
chrom_freq/VIII/I   17545
chrom_freq/VIII/IV  77723
chrom_freq/VIII/III 24933
chrom_freq/VIII/IX  30875
chrom_freq/VIII/V   36951
chrom_freq/VIII/Mito    2556
chrom_freq/VIII/VII 61332
chrom_freq/VIII/VI  21102
chrom_freq/VIII/VIII    789740
chrom_freq/VIII/X   46124
chrom_freq/VIII/XI  41375
chrom_freq/VIII/XII 55138
chrom_freq/VIII/XIII    52698
chrom_freq/VIII/XIV 46612
chrom_freq/VIII/XV  59935
chrom_freq/VIII/XVI 53382
chrom_freq/X/II 64925
chrom_freq/X/I  19830
chrom_freq/X/IV 97221
chrom_freq/X/III    27248
chrom_freq/X/IX 39013
chrom_freq/X/V  46195
chrom_freq/X/VI 25569
chrom_freq/X/Mito   3428
chrom_freq/X/VII    78303
chrom_freq/X/VIII   45957
chrom_freq/X/X  1096596
chrom_freq/X/XI 55064
chrom_freq/X/XII    66547
chrom_freq/X/XIII   67216
chrom_freq/X/XIV    59277
chrom_freq/X/XV 75031
chrom_freq/X/XVI    68696
chrom_freq/XI/I 17360
chrom_freq/XI/II    59265
chrom_freq/XI/III   24731
chrom_freq/XI/IV    90094
chrom_freq/XI/V 42762
chrom_freq/XI/IX    34936
chrom_freq/XI/Mito  3023
chrom_freq/XI/VI    23573
chrom_freq/XI/VII   73219
chrom_freq/XI/VIII  41235
chrom_freq/XI/X 55210
chrom_freq/XI/XI    973785
chrom_freq/XI/XII   61108
chrom_freq/XI/XIII  62720
chrom_freq/XI/XIV   55339
chrom_freq/XI/XV    71383
chrom_freq/XI/XVI   65565
chrom_freq/XII/I    18165
chrom_freq/XII/II   81152
chrom_freq/XII/III  26902
chrom_freq/XII/IV   143092
chrom_freq/XII/IX   40869
chrom_freq/XII/V    55840
chrom_freq/XII/Mito 6573
chrom_freq/XII/VII  106748
chrom_freq/XII/VI   23483
chrom_freq/XII/VIII 54066
chrom_freq/XII/X    65426
chrom_freq/XII/XI   61021
chrom_freq/XII/XII  1781301
chrom_freq/XII/XIII 89981
chrom_freq/XII/XIV  74420
chrom_freq/XII/XV   108640
chrom_freq/XII/XVI  90395
chrom_freq/XIII/II  78257
chrom_freq/XIII/I   17207
chrom_freq/XIII/III 28973
chrom_freq/XIII/IV  130454
chrom_freq/XIII/IX  41602
chrom_freq/XIII/Mito    4146
chrom_freq/XIII/V   54422
chrom_freq/XIII/VI  23995
chrom_freq/XIII/VII 99239
chrom_freq/XIII/VIII    53306
chrom_freq/XIII/X   66994
chrom_freq/XIII/XI  62907
chrom_freq/XIII/XII 89633
chrom_freq/XIII/XIII    1370587
chrom_freq/XIII/XIV 71487
chrom_freq/XIII/XV  101585
chrom_freq/XIII/XVI 87644
chrom_freq/XIV/I    17954
chrom_freq/XIV/II   67097
chrom_freq/XIV/III  29218
chrom_freq/XIV/IV   107740
chrom_freq/XIV/IX   37888
chrom_freq/XIV/V    47427
chrom_freq/XIV/Mito 3500
chrom_freq/XIV/VII  83439
chrom_freq/XIV/VI   23225
chrom_freq/XIV/VIII 46973
chrom_freq/XIV/X    59871
chrom_freq/XIV/XI   55585
chrom_freq/XIV/XII  74811
chrom_freq/XIV/XIII 72049
chrom_freq/XIV/XIV  1176394
chrom_freq/XIV/XV   82896
chrom_freq/XIV/XVI  72822
chrom_freq/XV/I 17221
chrom_freq/XV/II    93471
chrom_freq/XV/III   28439
chrom_freq/XV/IV    163112
chrom_freq/XV/IX    46658
chrom_freq/XV/V 63121
chrom_freq/XV/Mito  4875
chrom_freq/XV/VII   120463
chrom_freq/XV/VI    25611
chrom_freq/XV/VIII  60289
chrom_freq/XV/X 74982
chrom_freq/XV/XI    71675
chrom_freq/XV/XII   109660
chrom_freq/XV/XIII  101406
chrom_freq/XV/XIV   82668
chrom_freq/XV/XV    1608272
chrom_freq/XV/XVI   103107
chrom_freq/XVI/II   80977
chrom_freq/XVI/I    17009
chrom_freq/XVI/III  28934
chrom_freq/XVI/IV   131083
chrom_freq/XVI/IX   42872
chrom_freq/XVI/V    57346
chrom_freq/XVI/VI   23644
chrom_freq/XVI/Mito 4245
chrom_freq/XVI/VII  102063
chrom_freq/XVI/VIII 53178
chrom_freq/XVI/X    69068
chrom_freq/XVI/XI   64352
chrom_freq/XVI/XII  90977
chrom_freq/XVI/XIII 86999
chrom_freq/XVI/XIV  72714
chrom_freq/XVI/XV   103549
chrom_freq/XVI/XVI  1358000
dist_freq/0-1/+-    306
dist_freq/0-1/-+    303
dist_freq/0-1/--    121908
dist_freq/0-1/++    121805
dist_freq/1-2/+-    789
dist_freq/1-2/-+    724
dist_freq/1-2/--    341
dist_freq/1-2/++    349
dist_freq/2-3/+-    629
dist_freq/2-3/-+    584
dist_freq/2-3/--    67
dist_freq/2-3/++    90
dist_freq/3-6/+-    2499
dist_freq/3-6/-+    2485
dist_freq/3-6/--    172
dist_freq/3-6/++    205
dist_freq/6-10/+-   3463
dist_freq/6-10/-+   3617
dist_freq/6-10/--   87
dist_freq/6-10/++   124
dist_freq/10-18/+-  6515
dist_freq/10-18/-+  6803
dist_freq/10-18/--  224
dist_freq/10-18/++  272
dist_freq/18-32/+-  12840
dist_freq/18-32/-+  12847
dist_freq/18-32/--  393
dist_freq/18-32/++  539
dist_freq/32-56/+-  27913
dist_freq/32-56/-+  27592
dist_freq/32-56/--  5507
dist_freq/32-56/++  5623
dist_freq/56-100/+- 80632
dist_freq/56-100/-+ 80145
dist_freq/56-100/-- 34958
dist_freq/56-100/++ 35484
dist_freq/100-178/+-    377481
dist_freq/100-178/-+    376362
dist_freq/100-178/--    156042
dist_freq/100-178/++    156813
dist_freq/178-316/+-    585339
dist_freq/178-316/-+    583952
dist_freq/178-316/--    249257
dist_freq/178-316/++    252721
dist_freq/316-562/+-    376230
dist_freq/316-562/-+    374972
dist_freq/316-562/--    366408
dist_freq/316-562/++    367726
dist_freq/562-1000/+-   453001
dist_freq/562-1000/-+   455004
dist_freq/562-1000/--   449222
dist_freq/562-1000/++   448622
dist_freq/1000-1778/+-  452678
dist_freq/1000-1778/-+  451196
dist_freq/1000-1778/--  450868
dist_freq/1000-1778/++  449458
dist_freq/1778-3162/+-  395815
dist_freq/1778-3162/-+  396130
dist_freq/1778-3162/--  396093
dist_freq/1778-3162/++  395042
dist_freq/3162-5623/+-  344055
dist_freq/3162-5623/-+  345000
dist_freq/3162-5623/--  345333
dist_freq/3162-5623/++  344737
dist_freq/5623-10000/+- 302765
dist_freq/5623-10000/-+ 302363
dist_freq/5623-10000/-- 303335
dist_freq/5623-10000/++ 302730
dist_freq/10000-17783/+-    266612
dist_freq/10000-17783/-+    265367
dist_freq/10000-17783/--    266269
dist_freq/10000-17783/++    266375
dist_freq/17783-31623/+-    233566
dist_freq/17783-31623/-+    232976
dist_freq/17783-31623/--    233617
dist_freq/17783-31623/++    233027
dist_freq/31623-56234/+-    204543
dist_freq/31623-56234/-+    203916
dist_freq/31623-56234/--    203725
dist_freq/31623-56234/++    203834
dist_freq/56234-100000/+-   177434
dist_freq/56234-100000/-+   177333
dist_freq/56234-100000/--   177497
dist_freq/56234-100000/++   176513
dist_freq/100000-177828/+-  153339
dist_freq/100000-177828/-+  154025
dist_freq/100000-177828/--  154132
dist_freq/100000-177828/++  153925
dist_freq/177828-316228/+-  128734
dist_freq/177828-316228/-+  128503
dist_freq/177828-316228/--  128973
dist_freq/177828-316228/++  128971
dist_freq/316228-562341/+-  96722
dist_freq/316228-562341/-+  97294
dist_freq/316228-562341/--  96601
dist_freq/316228-562341/++  96339
dist_freq/562341-1000000/+- 54869
dist_freq/562341-1000000/-+ 55066
dist_freq/562341-1000000/-- 55326
dist_freq/562341-1000000/++ 55003
dist_freq/1000000-1778279/+-    9109
dist_freq/1000000-1778279/-+    8970
dist_freq/1000000-1778279/--    9050
dist_freq/1000000-1778279/++    8998
dist_freq/1778279-3162278/+-    0
dist_freq/1778279-3162278/-+    0
dist_freq/1778279-3162278/--    0
dist_freq/1778279-3162278/++    0
dist_freq/3162278-5623413/+-    0
dist_freq/3162278-5623413/-+    0
dist_freq/3162278-5623413/--    0
dist_freq/3162278-5623413/++    0
dist_freq/5623413-10000000/+-   0
dist_freq/5623413-10000000/-+   0
dist_freq/5623413-10000000/--   0
dist_freq/5623413-10000000/++   0
dist_freq/10000000-17782794/+-  0
dist_freq/10000000-17782794/-+  0
dist_freq/10000000-17782794/--  0
dist_freq/10000000-17782794/++  0
dist_freq/17782794-31622777/+-  0
dist_freq/17782794-31622777/-+  0
dist_freq/17782794-31622777/--  0
dist_freq/17782794-31622777/++  0
dist_freq/31622777-56234133/+-  0
dist_freq/31622777-56234133/-+  0
dist_freq/31622777-56234133/--  0
dist_freq/31622777-56234133/++  0
dist_freq/56234133-100000000/+- 0
dist_freq/56234133-100000000/-+ 0
dist_freq/56234133-100000000/-- 0
dist_freq/56234133-100000000/++ 0
dist_freq/100000000-177827941/+-    0
dist_freq/100000000-177827941/-+    0
dist_freq/100000000-177827941/--    0
dist_freq/100000000-177827941/++    0
dist_freq/177827941-316227766/+-    0
dist_freq/177827941-316227766/-+    0
dist_freq/177827941-316227766/--    0
dist_freq/177827941-316227766/++    0
dist_freq/316227766-562341325/+-    0
dist_freq/316227766-562341325/-+    0
dist_freq/316227766-562341325/--    0
dist_freq/316227766-562341325/++    0
dist_freq/562341325-1000000000/+-   0
dist_freq/562341325-1000000000/-+   0
dist_freq/562341325-1000000000/--   0
dist_freq/562341325-1000000000/++   0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```

<a id="rdna-3"></a>
###### "rDNA"
```txt
❯ run_check=TRUE


❯ [[ "${run_check}" == TRUE && -f "${a_dedup_stats}" ]] &&
>     {
>         ., "${a_dedup_stats}"
>         cat "${a_dedup_stats}"  # less "${a_dedup_stats}"
>     } ||
>     {
>         echo "Warning: \"run_check\" for dedup stats did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
-rw-rw---- 1 kalavatt 12K Jul 11 10:17 06_stats/SRR7939018.rDNA.dedup.stats.txt
total   66152049
total_unmapped  1415484
total_single_sided_mapped   4879947
total_mapped    59856618
total_dups  9374552
total_nodups    50482066
cis 31202061
trans   19280005
pair_types/NN   1415484
pair_types/NU   2623331
pair_types/UN   2256616
pair_types/UU   50482066
pair_types/DD   9374552
cis_1kb+    22421807
cis_2kb+    19022050
cis_4kb+    15354570
cis_10kb+   8591026
cis_20kb+   5514666
cis_40kb+   3684278
summary/frac_cis    0.6180820927574557
summary/frac_cis_1kb+   0.4441539100242054
summary/frac_cis_2kb+   0.3768080727916326
summary/frac_cis_4kb+   0.3041589066501359
summary/frac_cis_10kb+  0.17017976245266983
summary/frac_cis_20kb+  0.10924010122723583
summary/frac_cis_40kb+  0.07298191797459319
summary/frac_dups   0.15661680050149174
summary/complexity_naive    170570925.55594927
chrom_freq/I/I  370696
chrom_freq/I/II 25142
chrom_freq/I/III    23169
chrom_freq/I/IV 33843
chrom_freq/I/IX 25691
chrom_freq/I/V  22475
chrom_freq/I/VI 22933
chrom_freq/I/Mito   1344
chrom_freq/I/VIII   46226
chrom_freq/I/VII    29878
chrom_freq/I/X  29512
chrom_freq/I/XII    50744
chrom_freq/I/XI 21957
chrom_freq/I/XIV    26232
chrom_freq/I/XIII   25759
chrom_freq/I/XV 26232
chrom_freq/I/XVI    26966
chrom_freq/II/II    1239839
chrom_freq/II/I 25624
chrom_freq/II/III   36159
chrom_freq/II/IV    152721
chrom_freq/II/IX    49781
chrom_freq/II/V 66406
chrom_freq/II/Mito  4096
chrom_freq/II/VII   117298
chrom_freq/II/VI    31717
chrom_freq/II/VIII  67222
chrom_freq/II/X 81671
chrom_freq/II/XI    64840
chrom_freq/II/XII   166968
chrom_freq/II/XIII  95963
chrom_freq/II/XIV   81846
chrom_freq/II/XV    111537
chrom_freq/II/XVI   103608
chrom_freq/III/I    23252
chrom_freq/III/II   35853
chrom_freq/III/III  486020
chrom_freq/III/IV   50636
chrom_freq/III/IX   29592
chrom_freq/III/V    32927
chrom_freq/III/VI   26937
chrom_freq/III/VII  40559
chrom_freq/III/Mito 1648
chrom_freq/III/VIII 35324
chrom_freq/III/X    37993
chrom_freq/III/XII  69900
chrom_freq/III/XI   34959
chrom_freq/III/XIII 38307
chrom_freq/III/XIV  40084
chrom_freq/III/XV   40058
chrom_freq/III/XVI  40538
chrom_freq/IV/II    154731
chrom_freq/IV/I 35225
chrom_freq/IV/III   50358
chrom_freq/IV/IV    2479684
chrom_freq/IV/IX    76033
chrom_freq/IV/V 104703
chrom_freq/IV/Mito  7759
chrom_freq/IV/VI    43445
chrom_freq/IV/VII   203043
chrom_freq/IV/VIII  105848
chrom_freq/IV/X 139644
chrom_freq/IV/XI    105044
chrom_freq/IV/XII   313094
chrom_freq/IV/XIII  164399
chrom_freq/IV/XIV   142817
chrom_freq/IV/XV    208701
chrom_freq/IV/XVI   168920
chrom_freq/IX/II    50329
chrom_freq/IX/I 25944
chrom_freq/IX/IV    76379
chrom_freq/IX/III   29935
chrom_freq/IX/IX    680449
chrom_freq/IX/V 43332
chrom_freq/IX/Mito  2409
chrom_freq/IX/VII   67448
chrom_freq/IX/VI    29333
chrom_freq/IX/VIII  44348
chrom_freq/IX/X 62764
chrom_freq/IX/XI    41162
chrom_freq/IX/XII   96945
chrom_freq/IX/XIII  51410
chrom_freq/IX/XIV   50504
chrom_freq/IX/XV    62278
chrom_freq/IX/XVI   54828
chrom_freq/Mito/IV  6300
chrom_freq/Mito/II  3346
chrom_freq/Mito/III 1362
chrom_freq/Mito/I   1089
chrom_freq/Mito/Mito    55489
chrom_freq/Mito/XII 25125
chrom_freq/Mito/VII 4425
chrom_freq/Mito/X   3216
chrom_freq/Mito/VIII    2639
chrom_freq/Mito/XI  2613
chrom_freq/Mito/V   2341
chrom_freq/Mito/IX  1970
chrom_freq/Mito/VI  1260
chrom_freq/Mito/XV  4365
chrom_freq/Mito/XVI 3989
chrom_freq/Mito/XIII    3870
chrom_freq/Mito/XIV 3238
chrom_freq/V/I  22339
chrom_freq/V/II 69460
chrom_freq/V/III    33177
chrom_freq/V/IV 110770
chrom_freq/V/IX 42837
chrom_freq/V/V  826960
chrom_freq/V/Mito   3033
chrom_freq/V/VI 28290
chrom_freq/V/VII    82432
chrom_freq/V/VIII   51810
chrom_freq/V/X  64571
chrom_freq/V/XI 49489
chrom_freq/V/XII    128428
chrom_freq/V/XIII   71817
chrom_freq/V/XIV    62857
chrom_freq/V/XV 79919
chrom_freq/V/XVI    76669
chrom_freq/VI/I 22923
chrom_freq/VI/II    31917
chrom_freq/VI/IV    44783
chrom_freq/VI/III   26506
chrom_freq/VI/IX    29226
chrom_freq/VI/VI    408525
chrom_freq/VI/V 29664
chrom_freq/VI/Mito  1470
chrom_freq/VI/VII   36950
chrom_freq/VI/X 35880
chrom_freq/VI/VIII  30994
chrom_freq/VI/XI    27348
chrom_freq/VI/XII   62086
chrom_freq/VI/XIII  30672
chrom_freq/VI/XIV   38243
chrom_freq/VI/XV    35185
chrom_freq/VI/XVI   32458
chrom_freq/VII/I    29467
chrom_freq/VII/II   116630
chrom_freq/VII/III  40481
chrom_freq/VII/IV   204760
chrom_freq/VII/IX   66301
chrom_freq/VII/V    85473
chrom_freq/VII/Mito 5456
chrom_freq/VII/VI   37674
chrom_freq/VII/VII  1639302
chrom_freq/VII/VIII 82180
chrom_freq/VII/X    102776
chrom_freq/VII/XI   82060
chrom_freq/VII/XII  226923
chrom_freq/VII/XIII 122871
chrom_freq/VII/XIV  104993
chrom_freq/VII/XV   146980
chrom_freq/VII/XVI  132617
chrom_freq/VIII/I   45591
chrom_freq/VIII/II  67278
chrom_freq/VIII/III 35077
chrom_freq/VIII/IV  105627
chrom_freq/VIII/IX  44113
chrom_freq/VIII/V   52844
chrom_freq/VIII/Mito    3081
chrom_freq/VIII/VII 84143
chrom_freq/VIII/VI  31543
chrom_freq/VIII/VIII    882701
chrom_freq/VIII/X   67299
chrom_freq/VIII/XI  51072
chrom_freq/VIII/XII 130445
chrom_freq/VIII/XIII    70651
chrom_freq/VIII/XIV 62964
chrom_freq/VIII/XV  77970
chrom_freq/VIII/XVI 74867
chrom_freq/X/I  29176
chrom_freq/X/II 81315
chrom_freq/X/III    37690
chrom_freq/X/IV 140906
chrom_freq/X/IX 62418
chrom_freq/X/V  65520
chrom_freq/X/VI 35854
chrom_freq/X/Mito   4017
chrom_freq/X/VII    102515
chrom_freq/X/VIII   67424
chrom_freq/X/X  1156783
chrom_freq/X/XI 66216
chrom_freq/X/XII    152938
chrom_freq/X/XIII   87431
chrom_freq/X/XIV    79259
chrom_freq/X/XV 98052
chrom_freq/X/XVI    92884
chrom_freq/XI/II    65431
chrom_freq/XI/I 22186
chrom_freq/XI/III   34543
chrom_freq/XI/IV    105177
chrom_freq/XI/IX    41313
chrom_freq/XI/V 49168
chrom_freq/XI/Mito  3237
chrom_freq/XI/VII   82767
chrom_freq/XI/VI    27207
chrom_freq/XI/VIII  51136
chrom_freq/XI/X 66675
chrom_freq/XI/XI    990262
chrom_freq/XI/XII   121031
chrom_freq/XI/XIII  70247
chrom_freq/XI/XIV   63321
chrom_freq/XI/XV    79936
chrom_freq/XI/XVI   74288
chrom_freq/XII/I    49550
chrom_freq/XII/II   162741
chrom_freq/XII/III  68247
chrom_freq/XII/IV   305332
chrom_freq/XII/IX   94729
chrom_freq/XII/Mito 29623
chrom_freq/XII/V    126878
chrom_freq/XII/VI   61127
chrom_freq/XII/VII  224937
chrom_freq/XII/VIII 129847
chrom_freq/XII/X    148700
chrom_freq/XII/XI   119207
chrom_freq/XII/XII  14266917
chrom_freq/XII/XIII 189083
chrom_freq/XII/XIV  161877
chrom_freq/XII/XV   225581
chrom_freq/XII/XVI  196316
chrom_freq/XIII/I   25567
chrom_freq/XIII/II  95083
chrom_freq/XIII/III 37805
chrom_freq/XIII/IV  165054
chrom_freq/XIII/IX  51555
chrom_freq/XIII/Mito    4640
chrom_freq/XIII/V   71210
chrom_freq/XIII/VI  30806
chrom_freq/XIII/VII 123123
chrom_freq/XIII/VIII    71735
chrom_freq/XIII/X   87473
chrom_freq/XIII/XI  70013
chrom_freq/XIII/XII 191268
chrom_freq/XIII/XIII    1410160
chrom_freq/XIII/XIV 90865
chrom_freq/XIII/XV  125428
chrom_freq/XIII/XVI 116477
chrom_freq/XIV/II   82156
chrom_freq/XIV/I    25863
chrom_freq/XIV/III  40229
chrom_freq/XIV/IV   142119
chrom_freq/XIV/IX   49832
chrom_freq/XIV/V    62403
chrom_freq/XIV/VI   37894
chrom_freq/XIV/Mito 3988
chrom_freq/XIV/VII  105901
chrom_freq/XIV/VIII 63805
chrom_freq/XIV/X    79831
chrom_freq/XIV/XI   63335
chrom_freq/XIV/XII  164986
chrom_freq/XIV/XIII 90850
chrom_freq/XIV/XIV  1224695
chrom_freq/XIV/XV   104865
chrom_freq/XIV/XVI  95879
chrom_freq/XV/II    111004
chrom_freq/XV/I 25590
chrom_freq/XV/III   40180
chrom_freq/XV/IV    209215
chrom_freq/XV/IX    61934
chrom_freq/XV/V 79460
chrom_freq/XV/Mito  5468
chrom_freq/XV/VI    35353
chrom_freq/XV/VII   147582
chrom_freq/XV/VIII  78730
chrom_freq/XV/X 98685
chrom_freq/XV/XI    80005
chrom_freq/XV/XII   232349
chrom_freq/XV/XIII  125935
chrom_freq/XV/XIV   104440
chrom_freq/XV/XV    1663558
chrom_freq/XV/XVI   137977
chrom_freq/XVI/I    26372
chrom_freq/XVI/II   102678
chrom_freq/XVI/IV   168869
chrom_freq/XVI/III  40215
chrom_freq/XVI/IX   55412
chrom_freq/XVI/V    76781
chrom_freq/XVI/Mito 4856
chrom_freq/XVI/VII  132380
chrom_freq/XVI/VI   32331
chrom_freq/XVI/VIII 75110
chrom_freq/XVI/X    93720
chrom_freq/XVI/XI   73786
chrom_freq/XVI/XII  201313
chrom_freq/XVI/XIII 115797
chrom_freq/XVI/XIV  94620
chrom_freq/XVI/XV   139970
chrom_freq/XVI/XVI  1420021
dist_freq/0-1/+-    602
dist_freq/0-1/-+    526
dist_freq/0-1/--    123971
dist_freq/0-1/++    124386
dist_freq/1-2/+-    1329
dist_freq/1-2/-+    1185
dist_freq/1-2/--    375
dist_freq/1-2/++    402
dist_freq/2-3/+-    1086
dist_freq/2-3/-+    952
dist_freq/2-3/--    101
dist_freq/2-3/++    152
dist_freq/3-6/+-    3997
dist_freq/3-6/-+    3822
dist_freq/3-6/--    320
dist_freq/3-6/++    348
dist_freq/6-10/+-   5571
dist_freq/6-10/-+   5369
dist_freq/6-10/--   313
dist_freq/6-10/++   346
dist_freq/10-18/+-  10553
dist_freq/10-18/-+  10272
dist_freq/10-18/--  720
dist_freq/10-18/++  746
dist_freq/18-32/+-  20654
dist_freq/18-32/-+  19447
dist_freq/18-32/--  1358
dist_freq/18-32/++  1465
dist_freq/32-56/+-  42734
dist_freq/32-56/-+  40494
dist_freq/32-56/--  8672
dist_freq/32-56/++  8547
dist_freq/56-100/+- 117920
dist_freq/56-100/-+ 112452
dist_freq/56-100/-- 45912
dist_freq/56-100/++ 44930
dist_freq/100-178/+-    512627
dist_freq/100-178/-+    501572
dist_freq/100-178/--    191158
dist_freq/100-178/++    186464
dist_freq/178-316/+-    768868
dist_freq/178-316/-+    746114
dist_freq/178-316/--    311357
dist_freq/178-316/++    304339
dist_freq/316-562/+-    539598
dist_freq/316-562/-+    511467
dist_freq/316-562/--    468521
dist_freq/316-562/++    451876
dist_freq/562-1000/+-   690871
dist_freq/562-1000/-+   653782
dist_freq/562-1000/--   602793
dist_freq/562-1000/++   576818
dist_freq/1000-1778/+-  780689
dist_freq/1000-1778/-+  726705
dist_freq/1000-1778/--  667863
dist_freq/1000-1778/++  633055
dist_freq/1778-3162/+-  837113
dist_freq/1778-3162/-+  766446
dist_freq/1778-3162/--  700556
dist_freq/1778-3162/++  664294
dist_freq/3162-5623/+-  901810
dist_freq/3162-5623/-+  812465
dist_freq/3162-5623/--  811006
dist_freq/3162-5623/++  763929
dist_freq/5623-10000/+- 1165071
dist_freq/5623-10000/-+ 1064436
dist_freq/5623-10000/-- 1307208
dist_freq/5623-10000/++ 1228135
dist_freq/10000-17783/+-    629612
dist_freq/10000-17783/-+    592725
dist_freq/10000-17783/--    841607
dist_freq/10000-17783/++    781042
dist_freq/17783-31623/+-    371876
dist_freq/17783-31623/-+    357600
dist_freq/17783-31623/--    364878
dist_freq/17783-31623/++    351125
dist_freq/31623-56234/+-    296945
dist_freq/31623-56234/-+    277117
dist_freq/31623-56234/--    302541
dist_freq/31623-56234/++    256321
dist_freq/56234-100000/+-   201398
dist_freq/56234-100000/-+   200381
dist_freq/56234-100000/--   202055
dist_freq/56234-100000/++   199578
dist_freq/100000-177828/+-  188180
dist_freq/100000-177828/-+  187668
dist_freq/100000-177828/--  191732
dist_freq/100000-177828/++  190462
dist_freq/177828-316228/+-  172005
dist_freq/177828-316228/-+  169646
dist_freq/177828-316228/--  175316
dist_freq/177828-316228/++  175201
dist_freq/316228-562341/+-  138529
dist_freq/316228-562341/-+  136809
dist_freq/316228-562341/--  141713
dist_freq/316228-562341/++  139972
dist_freq/562341-1000000/+- 72422
dist_freq/562341-1000000/-+ 73920
dist_freq/562341-1000000/-- 75219
dist_freq/562341-1000000/++ 74948
dist_freq/1000000-1778279/+-    13673
dist_freq/1000000-1778279/-+    13610
dist_freq/1000000-1778279/--    16529
dist_freq/1000000-1778279/++    16671
dist_freq/1778279-3162278/+-    0
dist_freq/1778279-3162278/-+    0
dist_freq/1778279-3162278/--    0
dist_freq/1778279-3162278/++    0
dist_freq/3162278-5623413/+-    0
dist_freq/3162278-5623413/-+    0
dist_freq/3162278-5623413/--    0
dist_freq/3162278-5623413/++    0
dist_freq/5623413-10000000/+-   0
dist_freq/5623413-10000000/-+   0
dist_freq/5623413-10000000/--   0
dist_freq/5623413-10000000/++   0
dist_freq/10000000-17782794/+-  0
dist_freq/10000000-17782794/-+  0
dist_freq/10000000-17782794/--  0
dist_freq/10000000-17782794/++  0
dist_freq/17782794-31622777/+-  0
dist_freq/17782794-31622777/-+  0
dist_freq/17782794-31622777/--  0
dist_freq/17782794-31622777/++  0
dist_freq/31622777-56234133/+-  0
dist_freq/31622777-56234133/-+  0
dist_freq/31622777-56234133/--  0
dist_freq/31622777-56234133/++  0
dist_freq/56234133-100000000/+- 0
dist_freq/56234133-100000000/-+ 0
dist_freq/56234133-100000000/-- 0
dist_freq/56234133-100000000/++ 0
dist_freq/100000000-177827941/+-    0
dist_freq/100000000-177827941/-+    0
dist_freq/100000000-177827941/--    0
dist_freq/100000000-177827941/++    0
dist_freq/177827941-316227766/+-    0
dist_freq/177827941-316227766/-+    0
dist_freq/177827941-316227766/--    0
dist_freq/177827941-316227766/++    0
dist_freq/316227766-562341325/+-    0
dist_freq/316227766-562341325/-+    0
dist_freq/316227766-562341325/--    0
dist_freq/316227766-562341325/++    0
dist_freq/562341325-1000000000/+-   0
dist_freq/562341325-1000000000/-+   0
dist_freq/562341325-1000000000/--   0
dist_freq/562341325-1000000000/++   0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```
</details>
<br />
</details>
<br />

### X. Run `pairtools merge` if applicable
<a id="code-21"></a>
#### Code
<details>
<summary><i>Code: Run pairtools merge if applicable</i></summary>

```bash
#!/bin/bash

#  Check the documentation ====================================================
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        pairtools merge --help
    }


#  Run pairtools merge if applicable ==========================================
print_example_call=FALSE
[[ "${print_example_call}" ]] &&
    {
        echo """
        #  Example call: github.com/open2c/pairtools/issues/160
        pairtools merge \\
            -o test.pairsam.gz \\
            --nproc 14 \\
                PC-T25-29-0159_S1_L002.pairsam.gz \\
                PC-T25-29-0159_S1_L003.pairsam.gz
        """
    }


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#to_merge[@]}; i++ )); do
            # i=0
            [[
                     -f "${in_1_std[${i}]}" \
                &&   -f "${in_2_std[${i}]}" \
                && ! -f "${a_merge_std[${i}]}"
            ]] &&
                {
                    job_name="to_merge.${f_merge_pre_std[${i}]}"  # echo "${job_name}"
                    
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=${job_name}
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_merge}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_merge}/err_out/${job_name}.%A.stdout.txt"

                    pairtools merge \\
                        -o \"${a_merge_std[${i}]}\" \\
                        --nproc \"${threads}\" \\
                            \"${in_1_std[${i}]}\" \\
                            \"${in_2_std[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo "Warning: \"Standard\" pairs file not found or merged pairs file exists;"
                    echo "         \"Step #X: Run pairtools merge\" did not run"
                }

            [[
                     -f "${in_1_rDNA[${i}]}" \
                &&   -f "${in_2_rDNA[${i}]}" \
                && ! -f "${a_merge_rDNA[${i}]}"
            ]] &&
                {
                    job_name="to_merge.${f_merge_pre_rDNA[${i}]}"  # echo "${job_name}"
                    
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=${job_name}
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_merge}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_merge}/err_out/${job_name}.%A.stdout.txt"

                    pairtools merge \\
                        -o \"${a_merge_rDNA[${i}]}\" \\
                        --nproc \"${threads}\" \\
                            \"${in_1_rDNA[${i}]}\" \\
                            \"${in_2_rDNA[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo "Warning: \"rDNA\" pairs file not found or merged pairs file exists;"
                    echo "         \"Step #X: Run pairtools merge\" did not run"
                }
        done
    }


#  Submit the jobs to SLURM ---------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#to_merge[@]}; i++ )); do
            # i=0
            [[
                     -f "${in_1_std[${i}]}" \
                &&   -f "${in_2_std[${i}]}" \
                && ! -f "${a_merge_std[${i}]}"
            ]] &&
                {
                    job_name="to_merge.${f_merge_pre_std[${i}]}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_merge}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_merge}/err_out/${job_name}.%A.stdout.txt"

pairtools merge \
    -o "${a_merge_std[${i}]}" \
    --nproc "${threads}" \
        "${in_1_std[${i}]}" \
        "${in_2_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                {
                    echo "Warning: \"Standard\" pairs file not found or merged pairs file exists;"
                    echo "         \"Step #X: Run pairtools merge\" did not run"
                }

            [[
                     -f "${in_1_rDNA[${i}]}" \
                &&   -f "${in_2_rDNA[${i}]}" \
                && ! -f "${a_merge_rDNA[${i}]}"
            ]] &&
                {
                    job_name="to_merge.${f_merge_pre_rDNA[${i}]}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_merge}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_merge}/err_out/${job_name}.%A.stdout.txt"

pairtools merge \
    -o "${a_merge_rDNA[${i}]}" \
    --nproc "${threads}" \
        "${in_1_rDNA[${i}]}" \
        "${in_2_rDNA[${i}]}"
EOF
                    sleep 0.25
                } ||
                {
                    echo "Warning: \"rDNA\" pairs file not found or merged pairs file exists;"
                    echo "         \"Step #X: Run pairtools merge\" did not run"
                }
        done
    }



#  Check the contents of the merge files --------------------------------------
run_check=FALSE  #TODO Need to update/refactor this
[[ "${run_check}" == TRUE && -f "${a_merge}" ]] &&
    {
        ls -lhaFG "${a_merge}"
        ls -lhaFG "${d_merge}"
        ls -lhaFG "${d_merge}/err_out"
    }
```
</details>
<br />

<a id="printed-13"></a>
#### Printed
<details>
<summary><i>Printed: Run pairtools merge if applicable</i></summary>

<a id="check-the-documentation-2"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt
❯ check_documentation=TRUE


❯ [[ "${check_documentation}" == TRUE ]] &&
>     {
>         pairtools merge --help
>     }
Usage: pairtools merge [OPTIONS] [PAIRS_PATH]...

  Merge .pairs/.pairsam files. By default, assumes that the files are sorted
  and maintains the sorting.

  Merge triu-flipped sorted pairs/pairsam files. If present, the @SQ records
  of the SAM header must be identical; the sorting order of these lines is
  taken from the first file in the list. The ID fields of the @PG records of
  the SAM header are modified with a numeric suffix to produce unique records.
  The other unique SAM and non-SAM header lines are copied into the output
  header.

  PAIRS_PATH : upper-triangular flipped sorted .pairs/.pairsam files to merge
  or a group/groups of .pairs/.pairsam files specified by a wildcard. For
  paths ending in .gz/.lz4, the files are decompressed by bgzip/lz4c.

Options:
  -o, --output TEXT               output file. If the path ends with .gz/.lz4,
                                  the output is compressed by bgzip/lz4c. By
                                  default, the output is printed into stdout.
  --max-nmerge INTEGER            The maximal number of inputs merged at once.
                                  For more, store merged intermediates in
                                  temporary files.  [default: 8]
  --tmpdir TEXT                   Custom temporary folder for merged
                                  intermediates.
  --memory TEXT                   The amount of memory used by default.
                                  [default: 2G]
  --compress-program TEXT         A binary to compress temporary merged
                                  chunks. Must decompress input when the flag
                                  -d is provided. Suggested alternatives:
                                  lz4c, gzip, lzop, snzip. NOTE: fails
                                  silently if the command syntax is wrong.
  --nproc INTEGER                 Number of threads for merging.  [default: 8]
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 1]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin. Must read
                                  input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  --keep-first-header / --no-keep-first-header
                                  Keep the first header or merge the headers
                                  together. Default: merge headers.  [default:
                                  no-keep-first-header]
  --concatenate / --no-concatenate
                                  Simple concatenate instead of merging sorted
                                  files.  [default: no-concatenate]
  -h, --help                      Show this message and exit.
```
</details>
<br />

<a id="do-a-trial-run-of-pairtools-merge"></a>
##### Do a trial run of `pairtools merge`
<details>
<summary><i>Printed: Do a trial run of pairtools merge</i></summary>

```txt
❯ print_example_call=FALSE  #HARDCODED


❯ [[ "${print_example_call}" ]] &&
>     {
>         echo """
>         #  Example call: github.com/open2c/pairtools/issues/160
>         pairtools merge \\
>             -o test.pairsam.gz \\
>             --nproc 14 \\
>                 PC-T25-29-0159_S1_L002.pairsam.gz \\
>                 PC-T25-29-0159_S1_L003.pairsam.gz
>         """
>     }

        #  Example call: github.com/open2c/pairtools/issues/160
        pairtools merge \
            -o test.pairsam.gz \
            --nproc 14 \
                PC-T25-29-0159_S1_L002.pairsam.gz \
                PC-T25-29-0159_S1_L003.pairsam.gz


❯ print_test=TRUE


❯ [[ "${print_test}" == TRUE && -f "${in_1}" && -f "${in_2}" ]] &&
>     {
>         echo """
>         pairtools merge \\
>             -o \"${a_merge}\" \\
>             --nproc \"${threads}\" \\
>                 \"${in_1}\" \\
>                 \"${in_2}\" \\
>                     2> >(tee \"${d_merge}/err_out/${f_merge_pre}.merge.stderr.txt\" >&2)
>         """
>     }

        pairtools merge \
            -o "05_dedup/SRR11893084-SRR11893085.nodups.pairs.gz" \
            --nproc "8" \
                "05_dedup/SRR11893084.nodups.pairs.gz" \
                "05_dedup/SRR11893085.nodups.pairs.gz" \
                    2> >(tee "05_dedup/err_out/SRR11893084-SRR11893085.merge.stderr.txt" >&2)


❯ run=TRUE


❯ [[ "${run}" == TRUE && -f "${in_1}" && -f "${in_2}" ]] &&
>     {
>         pairtools merge \
>             -o "${a_merge}" \
>             --nproc "${threads}" \
>                 "${in_1}" \
>                 "${in_2}" \
>                     2> >(tee "${d_merge}/err_out/${f_merge_pre}.merge.stderr.txt" >&2)
>     }
```
</details>
<br />

<a id="check-the-contents-of-the-merge-files"></a>
##### Check the contents of the merge files
<details>
<summary><i>Printed: Check the contents of the merge files</i></summary>

```txt
❯ [[ "${run_check}" == TRUE && -f "${a_merge}" ]] &&
>     {
>         ls -lhaFG "${a_merge}"
>         ls -lhaFG "${d_merge}"
>         ls -lhaFG "${d_merge}/err_out"
>     }
-rw-rw---- 1 kalavatt 1.5G Jul  8 14:46 05_dedup/SRR11893084-SRR11893085.nodups.pairs.gz

total 6.8G
drwxrws---  3 kalavatt  619 Jul  8 14:45 ./
drwxrws--- 10 kalavatt  443 Jul  8 13:58 ../
drwxrws---  2 kalavatt  234 Jul  8 14:45 err_out/
-rw-rw----  1 kalavatt  78M Jul  8 11:22 SRR11893084.dups.pairs.gz
-rw-rw----  1 kalavatt 720M Jul  8 11:22 SRR11893084.nodups.pairs.gz
-rw-rw----  1 kalavatt 1.5G Jul  8 14:46 SRR11893084-SRR11893085.nodups.pairs.gz
-rw-rw----  1 kalavatt  78M Jul  8 11:22 SRR11893084.unmapped.pairs.gz
-rw-rw----  1 kalavatt  81M Jul  8 12:18 SRR11893085.dups.pairs.gz
-rw-rw----  1 kalavatt 797M Jul  8 12:18 SRR11893085.nodups.pairs.gz
-rw-rw----  1 kalavatt  88M Jul  8 12:18 SRR11893085.unmapped.pairs.gz
-rw-rw----  1 kalavatt 199M Jul  7 13:29 SRR11893107.dups.pairs.gz
-rw-rw----  1 kalavatt 1.2G Jul  7 13:29 SRR11893107.nodups.pairs.gz
-rw-rw----  1 kalavatt 223M Jul  7 13:29 SRR11893107.unmapped.pairs.gz
-rw-rw----  1 kalavatt 213M Jul  6 12:41 SRR7939018.dups.pairs.gz
-rw-rw----  1 kalavatt 748M Jul  6 12:41 SRR7939018.nodups.pairs.gz
-rw-rw----  1 kalavatt 158M Jul  6 12:41 SRR7939018.unmapped.pairs.gz

total 200K
drwxrws--- 2 kalavatt  234 Jul  8 14:45 ./
drwxrws--- 3 kalavatt  619 Jul  8 14:45 ../
-rw-rw---- 1 kalavatt 6.9K Jul  8 11:22 SRR11893084.dedup.stderr.txt
-rw-rw---- 1 kalavatt    0 Jul  8 14:45 SRR11893084-SRR11893085.merge.stderr.txt
-rw-rw---- 1 kalavatt 6.6K Jul  8 12:18 SRR11893085.dedup.stderr.txt
-rw-rw---- 1 kalavatt 6.4K Jul  7 13:28 SRR11893107.dedup.stderr.txt
-rw-rw---- 1 kalavatt 6.2K Jul  6 12:41 SRR7939018.dedup.stderr.txt
```
</details>
<br />
</details>
<br />

<a id="x-run-standard-rdna-complete-processing-if-applicable"></a>
### X. Run "`standard-rDNA-complete`" processing if applicable
<a id="a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file"></a>
#### A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file
<a id="code-22"></a>
##### Code
<details>
<summary><i>Code: A. Exclude rDNA-associated cis and trans interactions from "standard"</i></summary>

```bash
#!/bin/bash

# [[ "${pro_comp}" == TRUE ]] &&
# {

#  Exclude rDNA-associated cis and trans interactions =========================
#LOGIC
#       IF chrom1 != "XII" && chrom2 != "XII"                                 THEN print record
#+ ELSE IF chrom1 == "XII" && chrom2 != "XII" && pos1 != rDNA                 THEN print record
#+ ELSE IF chrom1 != "XII" && chrom2 == "XII" && pos2 != rDNA                 THEN print record
#+ ELSE IF chrom1 == "XII" && chrom2 == "XII" && pos1 != rDNA && pos2 != rDNA THEN print record


#  Run print tests -----------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            [[ -f "${all_dedup_pre_pairs_std[${i}]}" && ! -f "${a_comp_std[${i}]}" ]] &&
                {
                    job_name="exclude_rDNA.${f_comp_std_pre[${i}]}"  # echo "${job_name}"

                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=1
                    #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

                    zcat < \"${all_dedup_pre_pairs_std[${i}]}\" \\
                        | grep -v \"^#\" \\
                        | awk \\
                            -v chr=\"XII\" \\
                            -v left=\"${rDNA_pos_l}\" \\
                            -v right=\"${rDNA_pos_r}\" \\
                            '{
                                if (\$2 != chr && \$4 != chr) {  
                                    print \$0
                                } else if ((\$2 == chr && \$4 != chr) && (\$11 < left || \$11 > right)) {
                                    print \$0
                                } else if ((\$4 == chr && \$2 != chr) && (\$12 < left || \$12 > right)) {
                                    print \$0
                                } else if (\$2 == chr && \$4 == chr && (\$11 < left || \$11 > right) && (\$12 < left || \$12 > right)) {
                                    print \$0
                                }
                            }' \\
                        | pbgzip -c \\
                            > \"${a_comp_std[${i}]}\"
                    EOF
                    """
                }
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            [[ -f "${all_dedup_pre_pairs_std[${i}]}" && ! -f "${a_comp_std[${i}]}" ]] &&
                {
                    job_name="exclude_rDNA.${f_comp_std_pre[${i}]}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

zcat < "${all_dedup_pre_pairs_std[${i}]}" \
    | grep -v "^#" \
    | awk \
        -v chr="XII" \
        -v left="${rDNA_pos_l}" \
        -v right="${rDNA_pos_r}" \
        '{
            if (\$2 != chr && \$4 != chr) {  
                print \$0
            } else if ((\$2 == chr && \$4 != chr) && (\$11 < left || \$11 > right)) {
                print \$0
            } else if ((\$4 == chr && \$2 != chr) && (\$12 < left || \$12 > right)) {
                print \$0
            } else if (\$2 == chr && \$4 == chr && (\$11 < left || \$11 > right) && (\$12 < left || \$12 > right)) {
                print \$0
            }
        }' \
    | pbgzip -c \
        > "${a_comp_std[${i}]}"
EOF
                    sleep 0.25
                }
        done
    }


#DEBUGGING ####################################################################
# if chrom1 != 'XII' and chrom2 != 'XII':
#     print(line)
# elif (chrom1 == 'XII' and chrom2 != 'XII') and (int(pos51) < left or int(pos51) > right):
#     print(line)
# elif (chrom2 == 'XII' and chrom1 != 'XII') and (int(pos31) < left or int(pos31) > right):
#     print(line)
# elif chrom1 == 'XII' and chrom2 == 'XII' and (int(pos51) < left or int(pos51) > right) and (int(pos31) < left or int(pos31) > right):
#     print(line)

pairtools select \
    "(
        (
            chrom1 != 'XII' \
            and \
            chrom2 != 'XII'
        ) \
        or \
        (
            chrom1 == 'XII' \
            and \
            chrom2 != 'XII' \
            and \
            (int(pos51) < 451526 or int(pos51) > 468980)
        ) \
        or \
        (
            chrom2 == 'XII' \
            and \
            chrom1 != 'XII' \
            and \
            (int(pos31) < 451526 or int(pos31) > 468980)
        ) \
        or \
        (
            chrom1 == 'XII' \
            and \
            chrom2 == 'XII' \
            and \
            (int(pos51) < 451526 or int(pos51) > 468980) \
            and \
            (int(pos31) < 451526 or int(pos31) > 468980)
        )
    )"
    input_pairs_file.pairs \
    --output output_filtered_pairs_file.pairs


pairtools select \
    "(
        (chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) \
        or \
        (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980)
    )" \
    "${test_infile}" \
    -o "${test_outfile}"


###############################################################################

#  Run checks =================================================================
run_check_manual_1=FALSE  #TODO Update/refactor
[[ "${run_check_manual_1}" == TRUE && -f "${a_comp_std}" ]] &&
    {
        #  Manually check that any XII-associated records are not rDNA-associated
        [[ -f "${a_comp_std/.gz/.txt}" ]] && rm "${a_comp_std/.gz/.txt}"
        zcat < "${a_comp_std}" > "${a_comp_std/.gz/.txt}"

        # rm "${standard_no_rDNA/.gz/.txt}"
    }

run_check_manual_2=FALSE  #TODO Update/refactor
[[ "${run_check_manual_2}" == TRUE && -f "${a_comp_std}" ]] &&
    {
        #  Less through the file
        zcat < "${a_comp_std}" | less
    }

# }
```
</details>
<br />

<a id="printed-13"></a>
##### Printed
<details>
<summary><i>Printed: A. Exclude rDNA-associated cis and trans interactions from "standard"</i></summary>

```txt

```
</details>
<br />

<a id="b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mmnodups-file"></a>
#### B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM.nodups`" file
<a id="code-23"></a>
##### Code
<details>
<summary><i>Code: B. Exclude all but rDNA-associated cis and trans interactions from "keep-MM.nodups" file</i></summary>

```bash
#!/bin/bash

# [[ "${pro_comp}" == TRUE ]] &&
# {

#  Exclude all but rDNA-associated cis and trans interactions =================
#LOGIC
#     IF chrom1 == "XII" && pos1 >= rDNA left && pos1 <= rDNA right
#+ OR IF chrom2 == "XII" && pos2 >= rDNA left && pos2 <= rDNA right
#+  THEN print record


#  Run print tests -----------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            [[ -f "${all_dedup_pre_pairs_rDNA[${i}]}" && ! -f "${a_comp_rDNA[${i}]}" ]] &&
                {
                    job_name="retain_only_rDNA.${f_comp_rDNA_pre[${i}]}"  # echo "${job_name}"
                    
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=1
                    #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

                    zcat < \"${all_dedup_pre_pairs_rDNA[${i}]}\" \\
                        | grep -v \"^#\" \\
                        | awk \\
                            -v chr=\"XII\" \\
                            -v left=\"${rDNA_pos_l}\" \\
                            -v right=\"${rDNA_pos_r}\" \\
                            '( \\
                                \$2 == chr && \$11 >= left && \$11 <= right \\
                            ) || ( \\
                                \$4 == chr && \$12 >= left && \$12 <= right \\
                            )' \\
                        | pbgzip -c \\
                            > \"${a_comp_rDNA[${i}]}\"
                    EOF
                    """
                }
        done
    }

#DEBUGGING ####################################################################
# ^(?:.*\t)({chr})\t(?:[^\t]+\t){{9}}({left}(?:\.\d*)?)\t.*\t(?:[^\t]+\t){{2}}({right}(?:\.\d*)?)$
# ^(?:.*\t)(XII)\t(?:[^\t]+\t){9}(451526(?:\.\d*)?)\t.*\t(?:[^\t]+\t){2}(468980(?:\.\d*)?)$

# readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2


test_infile="05_dedup/MC-2019_Q_WT_repM.keep-MM-6.nodups.pairs.gz"
test_outfile="05_dedup/regex-test_outfile.pairs.gz"

echo $test_infile
echo $test_outfile


pairtools select \
    "(
        (chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) \
        or \
        (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980)
    )" \
    "${test_infile}" \
    -o "${test_outfile}"

#  This is working... but there's still a bug--the file corruption happened even earlier?
#+ Yes, it seems to have occurred in the dedup command
##############################################################################

#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            [[ -f "${all_dedup_pre_pairs_rDNA[${i}]}" && ! -f "${a_comp_rDNA[${i}]}" ]] &&
                {
                    job_name="retain_only_rDNA.${f_comp_rDNA_pre[${i}]}"  # echo "${job_name}"
                    
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

zcat < "${all_dedup_pre_pairs_rDNA[${i}]}" \
    | grep -v "^#" \
    | awk \
        -v chr="XII" \
        -v left="${rDNA_pos_l}" \
        -v right="${rDNA_pos_r}" \
        '( \
            \$2 == chr && \$11 >= left && \$11 <= right \
        ) || ( \
            \$4 == chr && \$12 >= left && \$12 <= right \
        )' \
    | pbgzip -c \
        > "${a_comp_rDNA[${i}]}"
EOF
                    sleep 0.25
                }
        done
    }

# }
```
</details>
<br />

<a id="printed-14"></a>
##### Printed
<details>
<summary><i>Printed: B. Exclude all but rDNA-associated cis and trans interactions from "keep-MM.nodups" file</i></summary>

```txt

```
</details>
<br />

<a id="c-re-header-the-standardnodups-and-keep-mmnodups-files"></a>
#### C. Re-header the "`standard.nodups`" and "`keep-MM.nodups`" files
<a id="code-24"></a>
##### Code
<details>
<summary><i>Code: C. Re-header the "standard.nodups" and "keep-MM.nodups" files</i></summary>

```bash
#!/bin/bash

# [[ "${pro_comp}" == TRUE ]] &&
# {

#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ ${print_test} == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            job_name="reheader.$(basename ${a_comp_std_rhdr[${i}]} .reheader.nodups.pairs.gz)"

            echo """
            #HEREDOC
            sbatch << EOF
            #!/bin/bash

            #SBATCH --job-name=\"${job_name}\"
            #SBATCH --nodes=1
            #SBATCH --cpus-per-task=1
            #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
            #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

            #  Re-header standard-\${max_mismatch_std}.no-rDNA ----------
            pairtools header transfer \\
                --output \"${a_comp_std_rhdr[${i}]}\" \\
                --reference-file \"${all_dedup_pre_pairs_std[${i}]}\" \\
                    \"${a_comp_std[${i}]}\"

            #  Overwrite un-headered standard no-rDNA file with
            #+ re-headered standard no-rDNA file
            [[
                \$? -eq 0 \\
                && -f \"${a_comp_std_rhdr[${i}]}\" \\
                && -f \"${a_comp_std[${i}]}\"
            ]] &&
                {
                    mv -f \\
                        \"${a_comp_std_rhdr[${i}]}\" \\
                        \"${a_comp_std[${i}]}\"
                }
            EOF
            """

            job_name="reheader.$(basename ${a_comp_rDNA_rhdr[${i}]} .reheader.nodups.pairs.gz)"
            
            echo """
            #HEREDOC
            sbatch << EOF
            #!/bin/bash

            #SBATCH --job-name=\"${job_name}\"
            #SBATCH --nodes=1
            #SBATCH --cpus-per-task=1
            #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
            #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

            #  Re-header keep-MM-\${max_mismatch_rDNA}.only-rDNA --------
            pairtools header transfer \\
                --output \"${a_comp_rDNA_rhdr[${i}]}\" \\
                --reference-file \"${all_dedup_pre_pairs_rDNA[${i}]}\" \\
                    \"${a_comp_rDNA[${i}]}\"

            #  Overwrite un-headered keep-MM only-rDNA file with
            #+ re-headered keep-MM only-rDNA file
            [[
                \$? -eq 0 \\
                && -f \"${a_comp_rDNA_rhdr[${i}]}\" \\
                && -f \"${a_comp_rDNA[${i}]}\"
            ]] &&
                {
                    mv -f \\
                        \"${a_comp_rDNA_rhdr[${i}]}\" \\
                        \"${a_comp_rDNA[${i}]}\"
                }
            EOF
            """
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            job_name="reheader.$(basename ${a_comp_std_rhdr[${i}]} .reheader.nodups.pairs.gz)"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

#  Re-header standard-\${max_mismatch_std}.no-rDNA ----------
pairtools header transfer \
    --output "${a_comp_std_rhdr[${i}]}" \
    --reference-file "${all_dedup_pre_pairs_std[${i}]}" \
        "${a_comp_std[${i}]}"

#  Overwrite un-headered standard no-rDNA file with
#+ re-headered standard no-rDNA file
[[
    \$? -eq 0 \
    && -f "${a_comp_std_rhdr[${i}]}" \
    && -f "${a_comp_std[${i}]}"
]] &&
    {
        mv -f \
            "${a_comp_std_rhdr[${i}]}" \
            "${a_comp_std[${i}]}"
    }
EOF
            sleep 0.25

            job_name="reheader.$(basename ${a_comp_rDNA_rhdr[${i}]} .reheader.nodups.pairs.gz)"
            
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

#  Re-header keep-MM-\${max_mismatch_rDNA}.only-rDNA --------
pairtools header transfer \
    --output "${a_comp_rDNA_rhdr[${i}]}" \
    --reference-file "${all_dedup_pre_pairs_rDNA[${i}]}" \
        "${a_comp_rDNA[${i}]}"

#  Overwrite un-headered keep-MM only-rDNA file with
#+ re-headered keep-MM only-rDNA file
[[
    \$? -eq 0 \
    && -f "${a_comp_rDNA_rhdr[${i}]}" \
    && -f "${a_comp_rDNA[${i}]}"
]] &&
    {
        mv -f \
            "${a_comp_rDNA_rhdr[${i}]}" \
            "${a_comp_rDNA[${i}]}"
    }
EOF
            sleep 0.25
        done
    }


```

<a id="d-merge-the-re-headered-standardnodups-and-keep-mmnodups-files"></a>
#### D. Merge the re-headered "`standard.nodups`" and "`keep-MM.nodups`" files
<a id="code-25"></a>
##### Code
<details>
<summary><i>Code: D. Merge the re-headered "standard.nodups" and "keep-MM.nodups" files</i></summary>

```bash
#!/bin/bash

run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${a_comp_std[${i}]}"
            ., "${a_comp_std[${i}]}"
            echo "${a_comp_rDNA[${i}]}"
            ., "${a_comp_rDNA[${i}]}"
            echo ""

            echo "${a_comp_std_rDNA[${i}]}"
            echo ""
            
            echo ""
        done
    }


print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0

            [[ 
                     -f "${a_comp_std[${i}]}" \
                &&   -f "${a_comp_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA[${i}]}"
            ]] &&
            {
                job_name="merge.$(basename ${a_comp_std_rDNA[${i}]} .${post})"
                
                echo """
                #HEREDOC
                sbatch << EOF
                #!/bin/bash

                #SBATCH --job-name=\"${job_name}\"
                #SBATCH --nodes=1
                #SBATCH --cpus-per-task=${threads}
                #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
                #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

                pairtools merge \\
                    --output \"${a_comp_std_rDNA[${i}]}\" \\
                    --nproc \"${threads}\" \\
                    --tmpdir \"${scratch}\" \\
                        \"${a_comp_std[${i}]}\" \\
                        \"${a_comp_rDNA[${i}]}\"
                EOF
                """
            }
        done
    }


run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0

            [[ 
                     -f "${a_comp_std[${i}]}" \
                &&   -f "${a_comp_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA[${i}]}"
            ]] &&
            {
                job_name="merge.$(basename ${a_comp_std_rDNA[${i}]} .${post})"
                
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

pairtools merge \
    --output "${a_comp_std_rDNA[${i}]}" \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
        "${a_comp_std[${i}]}" \
        "${a_comp_rDNA[${i}]}"
EOF
                sleep 0.25
            }
        done
    }
```
</details>
<br />

```bash
#!/bin/bash

ls -1 *.standard-3.nodups* *.standard-rDNA-complete.nodups*

print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0

            [[
                     -f "${a_comp_std_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA_sort[${i}]}"
            ]] &&
                {
                    job_name="sort.$(basename ${a_comp_std_rDNA[${i}]} .sort.nodups.pairs.gz)"

                    #  Sort "${a_comp_std_rDNA[${i}]}", which results in
                    #+ "${a_comp_std_rDNA_sort[${i}]}"; overwrite initial file
                    #+ with sorted file
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=1
                    #SBATCH --error=\"${d_comp}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_comp}/err_out/${job_name}.%A.stdout.txt\"

                    pairtools sort \\
                        --output \"${a_comp_std_rDNA_sort[${i}]}\" \\
                        --nproc \"${threads}\" \\
                        --tmpdir \"${scratch}\" \\
                        \"${a_comp_std_rDNA[${i}]}\"

                    [[
                        \$? -eq 0 \\
                        && -f \"${a_comp_std_rDNA_sort[${i}]}\" \\
                        && -f \"${a_comp_std_rDNA[${i}]}\"
                    ]] &&
                        {
                            mv -f \\
                                \"${a_comp_std_rDNA_sort[${i}]}\" \\
                                \"${a_comp_std_rDNA[${i}]}\"
                        }
                    EOF
                    """
                }
        done
    }

run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            [[
                     -f "${a_comp_std_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA_sort[${i}]}"
            ]] &&
                {
                    job_name="sort.$(basename ${a_comp_std_rDNA[${i}]} .sort.nodups.pairs.gz)"

                    #  Sort "${a_comp_std_rDNA[${i}]}", which results in
                    #+ "${a_comp_std_rDNA_sort[${i}]}"; overwrite initial file
                    #+ with sorted file

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \
    --output "${a_comp_std_rDNA_sort[${i}]}" \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    "${a_comp_std_rDNA[${i}]}"

[[
    \$? -eq 0 \
    && -f "${a_comp_std_rDNA_sort[${i}]}" \
    && -f "${a_comp_std_rDNA[${i}]}"
]] &&
    {
        mv -f \
            "${a_comp_std_rDNA_sort[${i}]}" \
            "${a_comp_std_rDNA[${i}]}"
    }
EOF
                    sleep 0.25
                }
        done
    }
```
</details>
<br />

<a id="printed-previous"></a>
#### Printed (previous)
<details>
<summary><i>Printed (previous): C. Re-header the "standard.nodups" and "keep-MM.nodups" files</i></summary>

```txt
❯                 echo """
>                 #  Re-header \"\${a_std}\" using \"standard.nodups\"
>                 pairtools header transfer \\
>                     --output \"${a_std_tmp}\" \\
>                     --reference-file \"${a_std_re}\" \\
>                         \"${a_std}\" \\
>                             2> >(tee -a \"${d_comp}/err_out/${f_std_tmp%.${suf}}.stderr.txt\")
> 
>                 #  Overwrite un-headered \"\${a_std}\" with re-headered \"\${a_std_tmp}\"
>                 [[
>                     \$? -eq 0 && \\
>                         -f \"${a_std_tmp}\" && \\
>                         -f \"${a_std}\"
>                 ]] &&
>                     {
>                         mv -f \\
>                             \"${a_std_tmp}\" \\
>                             \"${a_std}\"
>                     }
> 
>                 #  Re-header \"\${a_kp}\" using \"keep-MM.nodups\"
>                 pairtools header transfer \\
>                     --output \"${a_kp_tmp}\" \\
>                     --reference-file \"${a_kp_re}\" \\
>                         \"${a_kp}\" \\
>                             2> >(tee -a \"${d_comp}/err_out/${f_kp_tmp%.${suf}}.stderr.txt\")
> 
>                 #  Overwrite un-headered \"\${a_kp}\" with re-headered \"\${a_kp_tmp}\"
>                 [[
>                     \$? -eq 0 && \\
>                         -f \"${a_kp_tmp}\" && \\
>                         -f \"${a_kp}\"
>                 ]] &&
>                     {
>                         mv -f \\
>                             \"${a_kp_tmp}\" \\
>                             \"${a_kp}\"
>                     }
>                 """

                #  Re-header "${a_std}" using "standard.nodups"
                pairtools header transfer \
                    --output "0X_comp/SRR7939018.re-header-standard-no-rDNA.nodups.pairs.gz" \
                    --reference-file "05_dedup/SRR7939018.standard.nodups.pairs.gz" \
                        "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz" \
                            2> >(tee -a "0X_comp/err_out/SRR7939018.re-header-standard-no-rDNA.stderr.txt")

                #  Overwrite un-headered "${a_std}" with re-headered "${a_std_tmp}"
                [[
                    $? -eq 0 && \
                        -f "0X_comp/SRR7939018.re-header-standard-no-rDNA.nodups.pairs.gz" && \
                        -f "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz"
                ]] &&
                    {
                        mv -f \
                            "0X_comp/SRR7939018.re-header-standard-no-rDNA.nodups.pairs.gz" \
                            "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz"
                    }

                #  Re-header "${a_kp}" using "keep-MM.nodups"
                pairtools header transfer \
                    --output "0X_comp/SRR7939018.re-header-keep-MM-rDNA.nodups.pairs.gz" \
                    --reference-file "05_dedup/SRR7939018.keep-MM.nodups.pairs.gz" \
                        "0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz" \
                            2> >(tee -a "0X_comp/err_out/SRR7939018.re-header-keep-MM-rDNA.stderr.txt")

                #  Overwrite un-headered "${a_kp}" with re-headered "${a_kp_tmp}"
                [[
                    $? -eq 0 && \
                        -f "0X_comp/SRR7939018.re-header-keep-MM-rDNA.nodups.pairs.gz" && \
                        -f "0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz"
                ]] &&
                    {
                        mv -f \
                            "0X_comp/SRR7939018.re-header-keep-MM-rDNA.nodups.pairs.gz" \
                            "0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz"
                    }


❯                 #  Re-header "${a_std}" using "standard.nodups"


❯                 pairtools header transfer \
>                     --output "${a_std_tmp}" \
>                     --reference-file "${a_std_re}" \
>                         "${a_std}" \
>                             2> >(tee -a "${d_comp}/err_out/${f_std_tmp%.${suf}}.stderr.txt")


❯                 #  Overwrite un-headered "${a_std}" with re-headered "${a_std_tmp}"


❯                 [[
>                     $? -eq 0 && \
>                         -f "${a_std_tmp}" && \
>                         -f "${a_std}"
>                 ]] &&
>                     {
>                         mv -f \
>                             "${a_std_tmp}" \
>                             "${a_std}"
>                     }
'0X_comp/SRR7939018.re-header-standard-no-rDNA.nodups.pairs.gz' -> '0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz'


❯                 pairtools header transfer \
>                     --output "${a_kp_tmp}" \
>                     --reference-file "${a_kp_re}" \
>                         "${a_kp}" \
>                             2> >(tee -a "${d_comp}/err_out/${f_kp_tmp%.${suf}}.stderr.txt")


❯                 #  Overwrite un-headered "${a_kp}" with re-headered "${a_kp_tmp}"


❯                 [[
>                     $? -eq 0 && \
>                         -f "${a_kp_tmp}" && \
>                         -f "${a_kp}"
>                 ]] &&
>                     {
>                         mv -f \
>                             "${a_kp_tmp}" \
>                             "${a_kp}"
>                     }
'0X_comp/SRR7939018.re-header-keep-MM-rDNA.nodups.pairs.gz' -> '0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz'


❯                 echo """
>                 #  Merge \"\${a_std}\" and \"\${a_kp}\"
>                 [[ -f \"${a_kp}\" && -f \"${a_std}\" ]] &&
>                     {
>                         pairtools merge \\
>                             --output \"${a_rDNA}\" \\
>                             --nproc \"${threads}\" \\
>                             --tmpdir \"${scratch}\" \\
>                                 \"${a_kp}\" \\
>                                 \"${a_std}\" \\
>                                     2> >(tee -a \"${d_comp}/err_out/${f_rDNA%.${suf}}.stderr.txt\")
>                     }
>                 """

                #  Merge "${a_std}" and "${a_kp}"
                [[ -f "0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz" && -f "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz" ]] &&
                    {
                        pairtools merge \
                            --output "0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz" \
                            --nproc "8" \
                            --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
                                "0X_comp/SRR7939018.keep-MM-rDNA.nodups.pairs.gz" \
                                "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz" \
                                    2> >(tee -a "0X_comp/err_out/SRR7939018.standard-rDNA.stderr.txt")
                    }


❯                 [[ -f "${a_kp}" && -f "${a_std}" ]] &&
>                     {
>                         pairtools merge \
>                             --output "${a_rDNA}" \
>                             --nproc "${threads}" \
>                             --tmpdir "${scratch}" \
>                                 "${a_kp}" \
>                                 "${a_std}" \
>                                     2> >(tee -a "${d_comp}/err_out/${f_rDNA%.${suf}}.stderr.txt")
>                     }


❯                 #  Sorting ----------------------------------------------------


❯ echo """
>                 #  Sort \"\${a_rDNA}\"
>                 [[ -f \"${a_rDNA}\" ]] &&
>                     {
>                         pairtools sort \\
>                             --output \"${a_rDNA_tmp}\" \\
>                             --nproc \"${threads}\" \\
>                             --tmpdir \"${scratch}\" \\
>                             \"${a_rDNA}\" \\
>                                 2> >(tee -a \"${d_comp}/err_out/${f_rDNA_tmp%.${suf}}.stderr.txt\" >&2)
>                     }
> 
>                 #  Overwrite unsorted \"\${a_rDNA}\" with sorted \"\${a_rDNA_tmp}\"
>                 [[
>                     \$? -eq 0 && \\
>                         -f \"${a_rDNA_tmp}\" && \\
>                         -f \"${a_rDNA}\"
>                 ]] &&
>                     {
>                         mv -f \\
>                             \"${a_rDNA_tmp}\" \\
>                             \"${a_rDNA}\"
>                     }
>                 """

                #  Sort "${a_rDNA}"
                [[ -f "0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz" ]] &&
                    {
                        pairtools sort \
                            --output "0X_comp/SRR7939018.sorted-standard-rDNA.nodups.pairs.gz" \
                            --nproc "8" \
                            --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
                            "0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz" \
                                2> >(tee -a "0X_comp/err_out/.stderr.txt" >&2)
                    }

                #  Overwrite unsorted "${a_rDNA}" with sorted "${a_rDNA_tmp}"
                [[
                    $? -eq 0 && \
                        -f "0X_comp/SRR7939018.sorted-standard-rDNA.nodups.pairs.gz" && \
                        -f "0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz"
                ]] &&
                    {
                        mv -f \
                            "0X_comp/SRR7939018.sorted-standard-rDNA.nodups.pairs.gz" \
                            "0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz"
                    }


❯ [[ -f "${a_rDNA}" ]] &&
>                     {
>                         pairtools sort \
>                             --output "${a_rDNA_tmp}" \
>                             --nproc "${threads}" \
>                             --tmpdir "${scratch}" \
>                             "${a_rDNA}" \
>                                 2> >(tee -a "${d_comp}/err_out/${f_rDNA_tmp%.${suf}}.stderr.txt" >&2)
>                     }


❯                 [[
>                     $? -eq 0 && \
>                         -f "${a_rDNA_tmp}" && \
>                         -f "${a_rDNA}"
>                 ]] &&
>                     {
>                         mv -f \
>                             "${a_rDNA_tmp}" \
>                             "${a_rDNA}"
>                     }
'0X_comp/SRR7939018.sorted-standard-rDNA.nodups.pairs.gz' -> '0X_comp/SRR7939018.standard-rDNA.nodups.pairs.gz'
```
</details>
<br />

<a id="7-load-pairs-to-cooler"></a>
### 7. Load pairs to cooler
<a id="individual-pairs-file"></a>
#### Individual pairs file
<a id="code-27"></a>
##### Code
<details>
<summary><i>Code: 7. Load pairs to cooler</i></summary>

```bash
#!/bin/bash

#  Check the documentation
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        cooler cload pairs --help
    }

echo "${d_cload}"

for (( i = 0; i < ${#all[@]}; i++ )); do
    ., "${a_comp_std_rDNA[${i}]}"
done
echo ""

for (( i = 0; i < ${#all[@]}; i++ )); do
    echo "${a_comp_std_rDNA_cload[${i}]}"
done


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            job_name="cload.$(basename "${a_comp_std_rDNA_cload[${i}]}" .cool)"  # echo "${job_name}"

            [[
                     -f "${a_comp_std_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA_cload[${i}]}"
            ]] &&
                {
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=1
                    #SBATCH --error=\"${d_cload}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_cload}/err_out/${job_name}.%A.stdout.txt\"

                    cooler cload pairs \\
                        -c1 2 -p1 3 -c2 4 -p2 5 \\
                        --assembly \"${assembly}\" \\
                        \"${a_size}\":\"${bin_initial}\" \\
                        \"${a_comp_std_rDNA[${i}]}\" \\
                        \"${a_comp_std_rDNA_cload[${i}]}\"
                    EOF
                    """
                }
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            job_name="cload.$(basename "${a_comp_std_rDNA_cload[${i}]}" .cool)"  # echo "${job_name}"

            [[
                     -f "${a_comp_std_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA_cload[${i}]}"
            ]] &&
                {
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error="${d_cload}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_cload}/err_out/${job_name}.%A.stdout.txt"

cooler cload pairs \
    -c1 2 -p1 3 -c2 4 -p2 5 \
    --assembly "${assembly}" \
    "${a_size}":"${bin_initial}" \
    "${a_comp_std_rDNA[${i}]}" \
    "${a_comp_std_rDNA_cload[${i}]}"
EOF
                }
            sleep 0.2
        done
    }
```
</details>
<br />

<a id="printed-15"></a>
##### Printed
<details>
<summary><i>Printed: 7. Load pairs to cooler</i></summary>

```txt
❯ #  Check the documentation


❯ cooler cload pairs --help
Usage: cooler cload pairs [OPTIONS] BINS PAIRS_PATH COOL_PATH

  Bin any text file or stream of pairs.

  Pairs data need not be sorted. Accepts compressed files. To pipe input from
  stdin, set PAIRS_PATH to '-'.

  BINS : One of the following

      <TEXT:INTEGER> : 1. Path to a chromsizes file, 2. Bin size in bp

      <TEXT> : Path to BED file defining the genomic bin segmentation.

  PAIRS_PATH : Path to contacts (i.e. read pairs) file.

  COOL_PATH : Output COOL file path or URI.

Options:
  --metadata TEXT                 Path to JSON file containing user metadata.
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10)
  -c1, --chrom1 INTEGER           chrom1 field number (one-based)  [required]
  -p1, --pos1 INTEGER             pos1 field number (one-based)  [required]
  -c2, --chrom2 INTEGER           chrom2 field number (one-based)  [required]
  -p2, --pos2 INTEGER             pos2 field number (one-based)  [required]
  --chunksize INTEGER             Number of input lines to load at a time
  -0, --zero-based                Positions are zero-based
  --comment-char TEXT             Comment character that indicates lines to
                                  ignore.  [default: #]
  -N, --no-symmetric-upper        Create a complete square matrix without
                                  implicit symmetry. This allows for distinct
                                  upper- and lower-triangle values
  --input-copy-status [unique|duplex]
                                  Copy status of input data when using
                                  symmetric-upper storage. | `unique`:
                                  Incoming data comes from a unique half of a
                                  symmetric map, regardless of how the
                                  coordinates of a pair are ordered. `duplex`:
                                  Incoming data contains upper- and lower-
                                  triangle duplicates. All input records that
                                  map to the lower triangle will be discarded!
                                  | If you wish to treat lower- and upper-
                                  triangle input data as distinct, use the
                                  ``--no-symmetric-upper`` option.   [default:
                                  unique]
  --field TEXT                    Specify quantitative input fields to
                                  aggregate into value columns using the
                                  syntax ``--field <field-name>=<field-
                                  number>``. Optionally, append ``:`` followed
                                  by ``dtype=<dtype>`` to specify the data
                                  type (e.g. float), and/or ``agg=<agg>`` to
                                  specify an aggregation function different
                                  from sum (e.g. mean). Field numbers are
                                  1-based. Passing 'count' as the target name
                                  will override the default behavior of
                                  storing pair counts. Repeat the ``--field``
                                  option for each additional field.
  --temp-dir DIRECTORY            Create temporary files in a specified
                                  directory. Pass ``-`` to use the platform
                                  default temp dir.
  --no-delete-temp                Do not delete temporary files when finished.
  --max-merge INTEGER             Maximum number of chunks to merge before
                                  invoking recursive merging  [default: 200]
  --storage-options TEXT          Options to modify the data filter pipeline.
                                  Provide as a comma-separated list of key-
                                  value pairs of the form 'k1=v1,k2=v2,...'.
                                  See http://docs.h5py.org/en/stable/high/data
                                  set.html#filter-pipeline for more details.
  -a, --append                    Pass this flag to append the output cooler
                                  to an existing file instead of overwriting
                                  the file.
  -h, --help                      Show this message and exit.


❯ #  Echo test


❯ run=TRUE


❯ [[ "${run}" == TRUE ]] &&
>     {
>         echo """
>         cooler cload pairs \\
>             -c1 2 -p1 3 -c2 4 -p2 5 \\
>             --assembly \"${assembly}\" \\
>             \"${a_size}\":\"${bin_initial}\" \\
>             \"${a_dedup_pre_pairs}\" \\
>             \"${a_cload}\"
>         """
>     }

        cooler cload pairs \
            -c1 2 -p1 3 -c2 4 -p2 5 \
            --assembly "S288C_R64-3-1" \
            "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size":"50" \
            "05_dedup/SRR7939018.nodups.pairs.gz" \
            "06_cload/SRR7939018.cload.cool"


❯ #  Create a .cool from the processed, filtered pairs


❯ run=TRUE


❯ [[ "${run}" == TRUE ]] &&
>     {
>         cooler cload pairs \
>             -c1 2 -p1 3 -c2 4 -p2 5 \
>             --assembly "${assembly}" \
>             "${a_size}":"${bin_initial}" \
>             "${a_dedup_pre_pairs}" \
>             "${a_cload}"
>     }
INFO:cooler.create:Writing chunk 0: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::0
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::/0"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Writing chunk 1: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::1
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::/1"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Writing chunk 2: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::2
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307/06_cload/tmp1llmtl8g.multi.cool::/2"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Merging into 06_cload/SRR7939018.cload.cool
INFO:cooler.create:Creating cooler at "06_cload/SRR7939018.cload.cool::/"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:nnzs: [12617896, 12714552, 886113]
INFO:cooler.reduce:current: [11728302, 3271639, 0]
INFO:cooler.reduce:current: [12617896, 12714552, 886113]
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
```
</details>
<br />

<a id="merged-pairs-files-1"></a>
#### Merged pairs files
<a id="code-28"></a>
##### Code
<details>
<summary><i>Code: 7. Load pairs to cooler</i></summary>

```bash
#!/bin/bash

print_test=TRUE
[[ "${print_test}" == TRUE && -f "${a_merge}" ]] &&
    {
        echo """
        cooler cload pairs \\
            -c1 2 -p1 3 -c2 4 -p2 5 \\
            --assembly \"${assembly}\" \\
            \"${a_size}\":\"${bin_initial}\" \\
            \"${a_merge}\" \\
            \"${a_merge_cload}\"
        """
    }

run=TRUE
[[ "${run}" == TRUE && -f "${a_dedup_pre_pairs}" ]] &&
    {
        cooler cload pairs \
            -c1 2 -p1 3 -c2 4 -p2 5 \
            --assembly "${assembly}" \
            "${a_size}":"${bin_initial}" \
            "${a_merge}" \
            "${a_merge_cload}"
    }

#TODO Write standard error
```
</details>
<br />

<a id="printed-16"></a>
##### Printed
<details>
<summary><i>Printed: 7. Load pairs to cooler</i></summary>

```txt
❯ print_test=TRUE


❯ [[ "${print_test}" == TRUE && -f "${a_merge}" ]] &&
>     {
>         echo """
>         cooler cload pairs \\
>             -c1 2 -p1 3 -c2 4 -p2 5 \\
>             --assembly \"${assembly}\" \\
>             \"${a_size}\":\"${bin_initial}\" \\
>             \"${a_merge}\" \\
>             \"${a_merge_cload}\"
>         """
>     }

        cooler cload pairs \
            -c1 2 -p1 3 -c2 4 -p2 5 \
            --assembly "S288C_R64-3-1" \
            "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size":"50" \
            "05_dedup/SRR11893084-SRR11893085.nodups.pairs.gz" \
            "07_cload/SRR11893084-SRR11893085.cload.cool"


❯ [[ "${run}" == TRUE && -f "${a_dedup_pre_pairs}" ]] &&
>     {
>         cooler cload pairs \
>             -c1 2 -p1 3 -c2 4 -p2 5 \
>             --assembly "${assembly}" \
>             "${a_size}":"${bin_initial}" \
>             "${a_merge}" \
>             "${a_merge_cload}"
>     }
INFO:cooler.create:Writing chunk 0: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::0
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::/0"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Writing chunk 1: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::1
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::/1"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Writing chunk 2: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::2
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::/2"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Writing chunk 3: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::3
INFO:cooler.create:Creating cooler at "/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/07_cload/tmpvneec_vq.multi.cool::/3"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.create:Merging into 07_cload/SRR11893084-SRR11893085.cload.cool
INFO:cooler.create:Creating cooler at "07_cload/SRR11893084-SRR11893085.cload.cool::/"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:nnzs: [8919946, 8880162, 8675198, 5261652]
INFO:cooler.reduce:current: [8000487, 6282823, 411510, 305087]
INFO:cooler.reduce:current: [8899813, 8880162, 8675198, 3544734]
INFO:cooler.reduce:current: [8919946, 8880162, 8675198, 5261652]
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
```
</details>
<br />

<a id="8-generate-a-multi-resolution-cooler-by-coarsening"></a>
### 8. Generate a multi-resolution cooler by coarsening
<a id="cools-from-individual-pairs-files"></a>
#### Cools from individual pairs files
<a id="code-29"></a>
##### Code
<details>
<summary><i>Code: 8. Generate a multi-resolution cooler by coarsening</i></summary>

```bash
#!/bin/bash

#  Check the documentation
cooler zoomify --help

#  Print test
print_test=TRUE
[[ "${print_test}" == TRUE && -f "${a_cload}" ]] &&
    {
        echo """
        cooler zoomify \\
            --out \"${a_zoom}\" \\
            --nproc \"${threads}\" \\
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
            --balance \\
            \"${a_cload}\" \\
                2> >(tee -a \"${d_zoom}/err_out/${f_pre}.stderr.txt\" >&2)
        """
    }

#  Run cooler zoomify (generate a multi-resolution cooler by coarsening)
run=TRUE
[[ "${run}" == TRUE && -f "${a_cload}" ]] &&
    {
        cooler zoomify \
            --out "${a_zoom}" \
            --nproc "${threads}" \
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
            --balance \
            --balance-args '--max-iters 2000' \
            "${a_cload}" \
                2> >(tee -a "${d_zoom}/err_out/${f_pre}.stderr.txt" >&2)
    }
```
</details>
<br />

<a id="printed-17"></a>
##### Printed
<details>
<summary><i>Printed: 8. Generate a multi-resolution cooler by coarsening</i></summary>

```txt
❯ #  Check the documentation


❯ cooler zoomify --help
Usage: cooler zoomify [OPTIONS] COOL_PATH

  Generate a multi-resolution cooler file by coarsening.

  COOL_PATH : Path to a COOL file or Cooler URI.

Options:
  -n, -p, --nproc INTEGER  Number of processes to use for batch processing
                           chunks of pixels [default: 1, i.e. no process pool]
  -c, --chunksize INTEGER  Number of pixels allocated to each process
                           [default: 10000000]
  -r, --resolutions TEXT   Comma-separated list of target resolutions. Use
                           suffixes B or N to specify a progression: B for
                           binary (geometric steps of factor 2), N for nice
                           (geometric steps of factor 10 interleaved with
                           steps of 2 and 5). Examples:
                           1000B=1000,2000,4000,8000,...
                           1000N=1000,2000,5000,10000,...
                           5000N=5000,10000,25000,50000,... 4DN is an alias
                           for 1000,2000,5000N [default: B]
  --balance                Apply balancing to each zoom level. Off by default.
  --balance-args TEXT      Additional arguments to pass to cooler balance. To
                           deal with space ambiguity, use quotes to pass
                           multiple arguments, e.g. --balance-args '--nproc 8
                           --ignore-diags 3' Note that nproc for balancing
                           must be specified independently of zoomify
                           arguments.
  -i, --base-uri TEXT      One or more additional base coolers to aggregate
                           from, if needed.
  -o, --out TEXT           Output file or URI
  --field TEXT             Specify the names of value columns to merge as
                           '<name>'. Repeat the `--field` option for each one.
                           Use '<name>:dtype=<dtype>' to specify the dtype.
                           Include ',agg=<agg>' to specify an aggregation
                           function different from 'sum'.
  --legacy                 Use the legacy layout of integer-labeled zoom
                           levels.
  -h, --help               Show this message and exit.


❯ #  Echo test


❯ run=TRUE


❯ [[ "${run}" == TRUE ]] &&
>     {
>         echo """
>         cooler zoomify \\
>             --out \"${a_zoom}\" \\
>             --nproc \"${threads}\" \\
>             --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
>             --balance \\
>             \"${a_cload}\"
>         """
>     }

        cooler zoomify \
            --out "07_zoom/SRR7939018.mcool" \
            --nproc "8" \
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
            --balance \
            "06_cload/SRR7939018.cload.cool"


❯ #  Run cooler zoomify (generate a multi-resolution cooler by coarsening)


❯ run=TRUE


❯ [[ "${run}" == TRUE ]] &&
>     {
>         cooler zoomify \
>             --out "${a_zoom}" \
>             --nproc "${threads}" \
>             --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
>             --balance \
>             "${a_cload}"
>     }
INFO:cooler.cli.zoomify:Recursively aggregating "06_cload/SRR7939018.cload.cool"
INFO:cooler.cli.zoomify:Writing to "07_zoom/SRR7939018.mcool"
INFO:cooler.reduce:Copying base matrices and producing 12 new zoom levels.
INFO:cooler.reduce:Bin size: 50
INFO:cooler.reduce:Aggregating from 50 to 100.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/100"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:20000552 26179927
INFO:cooler.reduce:10000199 20000552
INFO:cooler.reduce:0 10000199
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 100 to 200.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:20000254 22879752
INFO:cooler.reduce:10000159 20000254
INFO:cooler.reduce:0 10000159
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 200 to 400.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:10000252 19877549
INFO:cooler.reduce:0 10000252
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 400 to 800.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/800"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:10000257 17302337
INFO:cooler.reduce:0 10000257
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 800 to 1600.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/1600"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:10000736 14633002
INFO:cooler.reduce:0 10000736
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 1600 to 3200.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/3200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:10000354 10829820
INFO:cooler.reduce:0 10000354
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 3200 to 6400.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/6400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 5514271
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 6400 to 12800.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/12800"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 1716106
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 12800 to 25600.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/25600"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 450934
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 25600 to 51200.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/51200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 115680
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 51200 to 102400.
INFO:cooler.create:Creating cooler at "07_zoom/SRR7939018.mcool::/resolutions/102400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 30332
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 100
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/100"
INFO:cooler.balance:variance is 127180.92382562772
INFO:cooler.balance:variance is 1570.4632603578132
INFO:cooler.balance:variance is 222.0469193288678
INFO:cooler.balance:variance is 56.0952825145797
INFO:cooler.balance:variance is 15.58389722832934
INFO:cooler.balance:variance is 5.190378288288674
INFO:cooler.balance:variance is 1.8333214895891816
INFO:cooler.balance:variance is 0.7055856269198852
INFO:cooler.balance:variance is 0.283648781689827
INFO:cooler.balance:variance is 0.11873038753541966
INFO:cooler.balance:variance is 0.0509740521710111
INFO:cooler.balance:variance is 0.022293683253541013
INFO:cooler.balance:variance is 0.009879415351741385
INFO:cooler.balance:variance is 0.004416138057093295
INFO:cooler.balance:variance is 0.0019872386912984
INFO:cooler.balance:variance is 0.0008980587611972038
INFO:cooler.balance:variance is 0.00040723964056634947
INFO:cooler.balance:variance is 0.00018507791527671042
INFO:cooler.balance:variance is 8.426577159504783e-05
INFO:cooler.balance:variance is 3.8412459940675245e-05
INFO:cooler.balance:variance is 1.7527878032098417e-05
INFO:cooler.balance:variance is 8.003605530764791e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 200
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/200"
INFO:cooler.balance:variance is 290565.0133165984
INFO:cooler.balance:variance is 3781.4156934949233
INFO:cooler.balance:variance is 542.7652374623459
INFO:cooler.balance:variance is 128.3418752063874
INFO:cooler.balance:variance is 34.236185289073646
INFO:cooler.balance:variance is 10.821745655174315
INFO:cooler.balance:variance is 3.7208357985201603
INFO:cooler.balance:variance is 1.3864499087721318
INFO:cooler.balance:variance is 0.5410777334203107
INFO:cooler.balance:variance is 0.21810390807093624
INFO:cooler.balance:variance is 0.08976104441416445
INFO:cooler.balance:variance is 0.0374107312366843
INFO:cooler.balance:variance is 0.015734921240253833
INFO:cooler.balance:variance is 0.00665344911923233
INFO:cooler.balance:variance is 0.002825197213221015
INFO:cooler.balance:variance is 0.0012026223079972848
INFO:cooler.balance:variance is 0.0005129724869936561
INFO:cooler.balance:variance is 0.00021908012576543748
INFO:cooler.balance:variance is 9.366182180338215e-05
INFO:cooler.balance:variance is 4.006927411591896e-05
INFO:cooler.balance:variance is 1.7151360622947664e-05
INFO:cooler.balance:variance is 7.344202300210572e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 400
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/400"
INFO:cooler.balance:variance is 616636.677977719
INFO:cooler.balance:variance is 9911.094748324947
INFO:cooler.balance:variance is 1373.587236934758
INFO:cooler.balance:variance is 302.5881159055936
INFO:cooler.balance:variance is 74.60923361175595
INFO:cooler.balance:variance is 21.817181703785646
INFO:cooler.balance:variance is 7.0487637054709715
INFO:cooler.balance:variance is 2.468572512732758
INFO:cooler.balance:variance is 0.9094459770837647
INFO:cooler.balance:variance is 0.34526120583367154
INFO:cooler.balance:variance is 0.13361254636297462
INFO:cooler.balance:variance is 0.05223314194072075
INFO:cooler.balance:variance is 0.02055897279297817
INFO:cooler.balance:variance is 0.008120118846005232
INFO:cooler.balance:variance is 0.0032151099966001816
INFO:cooler.balance:variance is 0.001274597915005707
INFO:cooler.balance:variance is 0.0005057748778323057
INFO:cooler.balance:variance is 0.00020079373830566845
INFO:cooler.balance:variance is 7.974519513229264e-05
INFO:cooler.balance:variance is 3.1676979295530965e-05
INFO:cooler.balance:variance is 1.2584901402776341e-05
INFO:cooler.balance:variance is 5.0002542598783685e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 800
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/800"
INFO:cooler.balance:variance is 1532442.1687874554
INFO:cooler.balance:variance is 23712.36335437967
INFO:cooler.balance:variance is 3008.33551096279
INFO:cooler.balance:variance is 606.7568076745856
INFO:cooler.balance:variance is 137.81216620187058
INFO:cooler.balance:variance is 37.29554611450914
INFO:cooler.balance:variance is 11.197997647406224
INFO:cooler.balance:variance is 3.617426639777768
INFO:cooler.balance:variance is 1.2209181799920035
INFO:cooler.balance:variance is 0.4217671764688839
INFO:cooler.balance:variance is 0.14771852319840503
INFO:cooler.balance:variance is 0.052080924297704084
INFO:cooler.balance:variance is 0.018436768993256684
INFO:cooler.balance:variance is 0.00653893064544714
INFO:cooler.balance:variance is 0.0023219531645594055
INFO:cooler.balance:variance is 0.000824967264988798
INFO:cooler.balance:variance is 0.00029321131934666915
INFO:cooler.balance:variance is 0.00010423071956969351
INFO:cooler.balance:variance is 3.7056267078625084e-05
INFO:cooler.balance:variance is 1.317497511065481e-05
INFO:cooler.balance:variance is 4.68440760913799e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 1600
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/1600"
INFO:cooler.balance:variance is 4034930.011935843
INFO:cooler.balance:variance is 57103.336167537986
INFO:cooler.balance:variance is 6580.7479409935095
INFO:cooler.balance:variance is 1262.33139164054
INFO:cooler.balance:variance is 262.7394086293218
INFO:cooler.balance:variance is 63.87964839591179
INFO:cooler.balance:variance is 16.81308353638366
INFO:cooler.balance:variance is 4.716026157287924
INFO:cooler.balance:variance is 1.3770770777462584
INFO:cooler.balance:variance is 0.41211215789903244
INFO:cooler.balance:variance is 0.12523248384832839
INFO:cooler.balance:variance is 0.03838429433195877
INFO:cooler.balance:variance is 0.011826728927894095
INFO:cooler.balance:variance is 0.0036544586496303575
INFO:cooler.balance:variance is 0.0011311841100351712
INFO:cooler.balance:variance is 0.00035047205641327255
INFO:cooler.balance:variance is 0.00010864741511540032
INFO:cooler.balance:variance is 3.369142884218921e-05
INFO:cooler.balance:variance is 1.0449599738954318e-05
INFO:cooler.balance:variance is 3.2413330747559173e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 3200
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/3200"
INFO:cooler.balance:variance is 8338515.26769532
INFO:cooler.balance:variance is 123328.22535735284
INFO:cooler.balance:variance is 12994.597453926657
INFO:cooler.balance:variance is 2276.7728941486585
INFO:cooler.balance:variance is 436.9332156687475
INFO:cooler.balance:variance is 95.45403539557951
INFO:cooler.balance:variance is 22.390461994630478
INFO:cooler.balance:variance is 5.53473828888962
INFO:cooler.balance:variance is 1.4143101550001844
INFO:cooler.balance:variance is 0.3685961331737275
INFO:cooler.balance:variance is 0.09721283320991284
INFO:cooler.balance:variance is 0.02580891885330545
INFO:cooler.balance:variance is 0.006878555050643267
INFO:cooler.balance:variance is 0.00183714706207003
INFO:cooler.balance:variance is 0.0004912709978854373
INFO:cooler.balance:variance is 0.00013145824793440948
INFO:cooler.balance:variance is 3.519010218154962e-05
INFO:cooler.balance:variance is 9.422019407957079e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 6400
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/6400"
INFO:cooler.balance:variance is 17303489.481990542
INFO:cooler.balance:variance is 277840.5812362575
INFO:cooler.balance:variance is 25535.19296109765
INFO:cooler.balance:variance is 3743.971860706267
INFO:cooler.balance:variance is 620.9271497585978
INFO:cooler.balance:variance is 116.96011808255899
INFO:cooler.balance:variance is 23.782502033862137
INFO:cooler.balance:variance is 5.064864752381864
INFO:cooler.balance:variance is 1.1071121498558467
INFO:cooler.balance:variance is 0.24525931833618525
INFO:cooler.balance:variance is 0.05471787731162826
INFO:cooler.balance:variance is 0.01225027977398924
INFO:cooler.balance:variance is 0.0027475475853524813
INFO:cooler.balance:variance is 0.0006167756226695096
INFO:cooler.balance:variance is 0.00013851784953993344
INFO:cooler.balance:variance is 3.1115766378279607e-05
INFO:cooler.balance:variance is 6.990440251772195e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 12800
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/12800"
INFO:cooler.balance:variance is 36740827.454942636
INFO:cooler.balance:variance is 700041.3399564008
INFO:cooler.balance:variance is 57491.41283607183
INFO:cooler.balance:variance is 7135.622649067127
INFO:cooler.balance:variance is 1020.2307042926867
INFO:cooler.balance:variance is 165.83584747973393
INFO:cooler.balance:variance is 29.030179644431744
INFO:cooler.balance:variance is 5.282488046093687
INFO:cooler.balance:variance is 0.97986747199472
INFO:cooler.balance:variance is 0.18336009370149525
INFO:cooler.balance:variance is 0.03445326072512115
INFO:cooler.balance:variance is 0.0064856104766000365
INFO:cooler.balance:variance is 0.001221911527541545
INFO:cooler.balance:variance is 0.00023029892190659646
INFO:cooler.balance:variance is 4.341296231485567e-05
INFO:cooler.balance:variance is 8.184278054426223e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 25600
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/25600"
INFO:cooler.balance:variance is 94609485.01304233
INFO:cooler.balance:variance is 921757.0884558255
INFO:cooler.balance:variance is 83745.10639761704
INFO:cooler.balance:variance is 11955.084025144088
INFO:cooler.balance:variance is 1854.9515587030073
INFO:cooler.balance:variance is 291.49111977880955
INFO:cooler.balance:variance is 45.98155073697826
INFO:cooler.balance:variance is 7.254810346476389
INFO:cooler.balance:variance is 1.1449680913656375
INFO:cooler.balance:variance is 0.1806947287789455
INFO:cooler.balance:variance is 0.02851751962268079
INFO:cooler.balance:variance is 0.004500640878514389
INFO:cooler.balance:variance is 0.0007102952895425516
INFO:cooler.balance:variance is 0.00011209929052737464
INFO:cooler.balance:variance is 1.769159896505778e-05
INFO:cooler.balance:variance is 2.792101499082057e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 51200
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/51200"
INFO:cooler.balance:variance is 253594081.7205069
INFO:cooler.balance:variance is 3243219.9050388713
INFO:cooler.balance:variance is 352486.2537910153
INFO:cooler.balance:variance is 43427.916469388845
INFO:cooler.balance:variance is 5434.706846757823
INFO:cooler.balance:variance is 679.2665917556232
INFO:cooler.balance:variance is 84.98548787066287
INFO:cooler.balance:variance is 10.62999624444899
INFO:cooler.balance:variance is 1.3297508394854662
INFO:cooler.balance:variance is 0.1663381386262242
INFO:cooler.balance:variance is 0.02080747089858705
INFO:cooler.balance:variance is 0.0026028237456325394
INFO:cooler.balance:variance is 0.0003255899204095728
INFO:cooler.balance:variance is 4.0728357020441145e-05
INFO:cooler.balance:variance is 5.094750504532831e-06
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 102400
INFO:cooler.cli.balance:Balancing "07_zoom/SRR7939018.mcool::resolutions/102400"
INFO:cooler.balance:variance is 695339922.2610035
INFO:cooler.balance:variance is 12966993.17173299
INFO:cooler.balance:variance is 1180160.688543959
INFO:cooler.balance:variance is 112862.9866549583
INFO:cooler.balance:variance is 10879.176082680848
INFO:cooler.balance:variance is 1047.0434692718302
INFO:cooler.balance:variance is 100.82531951234009
INFO:cooler.balance:variance is 9.707394888426977
INFO:cooler.balance:variance is 0.9346698767461828
INFO:cooler.balance:variance is 0.08999260901445384
INFO:cooler.balance:variance is 0.00866478117905116
INFO:cooler.balance:variance is 0.0008342720352318106
INFO:cooler.balance:variance is 8.032634052476781e-05
INFO:cooler.balance:variance is 7.734072057040814e-06
```
</details>
<br />

<a id="cools-from-merged-pairs-files"></a>
#### Cools from merged pairs files
<a id="code-30"></a>
##### Code
<details>
<summary><i>Code: 8. Generate a multi-resolution cooler by coarsening</i></summary>

```bash
#!/bin/bash

#  Print test
print_test=TRUE
[[ "${print_test}" == TRUE && -f "${a_cload}" ]] &&
    {
        echo """
        cooler zoomify \\
            --out \"${a_merge_zoom}\" \\
            --nproc \"${threads}\" \\
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
            --balance \\
            \"${a_merge_cload}\" \\
                2> >(tee -a \"${d_zoom}/err_out/${f_merge_pre}.stderr.txt\" >&2)
        """
    }

#  Run cooler zoomify (generate a multi-resolution cooler by coarsening)
run=TRUE
[[ "${run}" == TRUE && -f "${a_cload}" ]] &&
    {
        cooler zoomify \
            --out "${a_merge_zoom}" \
            --nproc "${threads}" \
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
            --balance \
            --balance-args '--max-iters 2000' \
            "${a_merge_cload}" \
                2> >(tee -a "${d_zoom}/err_out/${f_merge_pre}.stderr.txt" >&2)
    }
```
</details>
<br />

<a id="printed-18"></a>
##### Printed
<details>
<summary><i>Printed: 8. Generate a multi-resolution cooler by coarsening</i></summary>

```txt
❯ print_test=TRUE


❯ [[ "${print_test}" == TRUE && -f "${a_cload}" ]] &&
>     {
>         echo """
>         cooler zoomify \\
>             --out \"${a_merge_zoom}\" \\
>             --nproc \"${threads}\" \\
>             --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
>             --balance \\
>             \"${a_merge_cload}\" \\
>                 2> >(tee -a \"${d_zoom}/err_out/${f_merge_pre}.stderr.txt\" >&2)
>         """
>     }

        cooler zoomify \
            --out "08_zoom/SRR11893084-SRR11893085.mcool" \
            --nproc "8" \
            --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
            --balance \
            "07_cload/SRR11893084-SRR11893085.cload.cool" \
                2> >(tee -a "08_zoom/err_out/SRR11893084-SRR11893085.stderr.txt" >&2)


❯ run=TRUE


❯ [[ "${run}" == TRUE && -f "${a_cload}" ]] &&
>     {
>         cooler zoomify \
>             --out "${a_merge_zoom}" \
>             --nproc "${threads}" \
>             --resolutions 100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
>             --balance \
>             --balance-args '--max-iters 2000' \
>             "${a_merge_cload}" \
>                 2> >(tee -a "${d_zoom}/err_out/${f_merge_pre}.stderr.txt" >&2)
>     }
INFO:cooler.cli.zoomify:Recursively aggregating "07_cload/SRR11893084-SRR11893085.cload.cool"
INFO:cooler.cli.zoomify:Writing to "08_zoom/SRR11893084-SRR11893085.mcool"
INFO:cooler.reduce:Copying base matrices and producing 12 new zoom levels.
INFO:cooler.reduce:Bin size: 50
INFO:cooler.reduce:Aggregating from 50 to 100.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/100"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:30000006 31701891
INFO:cooler.reduce:20000248 30000006
INFO:cooler.reduce:10000133 20000248
INFO:cooler.reduce:0 10000133
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 100 to 200.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:20000125 22793108
INFO:cooler.reduce:10000476 20000125
INFO:cooler.reduce:0 10000476
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 200 to 400.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:10000082 15030070
INFO:cooler.reduce:0 10000082
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 400 to 800.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/800"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 9521786
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 800 to 1600.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/1600"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 6379116
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 1600 to 3200.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/3200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 4553526
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 3200 to 6400.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/6400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 3057819
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 6400 to 12800.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/12800"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 1489395
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 12800 to 25600.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/25600"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 446283
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 25600 to 51200.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/51200"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 115893
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.reduce:Aggregating from 51200 to 102400.
INFO:cooler.create:Creating cooler at "08_zoom/SRR11893084-SRR11893085.mcool::/resolutions/102400"
INFO:cooler.create:Writing chroms
INFO:cooler.create:Writing bins
INFO:cooler.create:Writing pixels
INFO:cooler.reduce:0 30380
INFO:cooler.create:Writing indexes
INFO:cooler.create:Writing info
INFO:cooler.cli.zoomify:Balancing zoom level with bin size 100
```
</details>
<br />
<br />

## To report...?
### Printed
<details>
<summary><i>Printed</i></summary>

```txt
#TODO Report this bug later

❯ cat cload.MC-2020_nz_WT_repM.standard-rDNA-complete.25524134.stderr.txt
Traceback (most recent call last):
  File "pandas/_libs/parsers.pyx", line 1129, in pandas._libs.parsers.TextReader._convert_tokens
TypeError: Cannot cast array data from dtype('O') to dtype('int64') according to the rule 'safe'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/kalavatt/miniconda3/envs/pairtools_env/bin/cooler", line 10, in <module>
    sys.exit(cli())
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/cooler/cli/cload.py", line 584, in pairs
    create_cooler(
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/cooler/create/_create.py", line 1038, in create_cooler
    create_from_unordered(
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/cooler/create/_create.py", line 718, in create_from_unordered
    for i, chunk in enumerate(chunks):
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1624, in __next__
    return self.get_chunk()
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1733, in get_chunk
    return self.read(nrows=size)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pandas/io/parsers/readers.py", line 1704, in read
    ) = self._engine.read(  # type: ignore[attr-defined]
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 234, in read
    chunks = self._reader.read_low_memory(nrows)
  File "pandas/_libs/parsers.pyx", line 824, in pandas._libs.parsers.TextReader.read_low_memory
  File "pandas/_libs/parsers.pyx", line 889, in pandas._libs.parsers.TextReader._read_rows
  File "pandas/_libs/parsers.pyx", line 1034, in pandas._libs.parsers.TextReader._convert_column_data
  File "pandas/_libs/parsers.pyx", line 1135, in pandas._libs.parsers.TextReader._convert_tokens
ValueError: cannot convert float NaN to integer
```

```txt
❯ pbgzip -dc "05_dedup/MC-2020_nz_WT_rep1.standard-rDNA-complete.nodups.pairs.gz" | less
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: whole matrix
#genome_assembly: S288C_R64-3-1
#chromsize: I 230218
#chromsize: II 813184
#chromsize: III 316620
#chromsize: IV 1531933
#chromsize: IX 439888
#chromsize: Mito 85779
#chromsize: V 576874
#chromsize: VI 270161
#chromsize: VII 1090940
#chromsize: VIII 562643
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
#samheader: @SQ SN:I    LN:230218
#samheader: @SQ SN:II   LN:813184
#samheader: @SQ SN:III  LN:316620
#samheader: @SQ SN:IV   LN:1531933
#samheader: @SQ SN:V    LN:576874
#samheader: @SQ SN:VI   LN:270161
#samheader: @SQ SN:VII  LN:1090940
#samheader: @SQ SN:VIII LN:562643
#samheader: @SQ SN:IX   LN:439888
#samheader: @SQ SN:X    LN:745751
#samheader: @SQ SN:XI   LN:666816
#samheader: @SQ SN:XII  LN:1078177
#samheader: @SQ SN:XIII LN:924431
#samheader: @SQ SN:XIV  LN:784333
#samheader: @SQ SN:XV   LN:1091291
#samheader: @SQ SN:XVI  LN:948066
#samheader: @SQ SN:Mito LN:85779
#samheader: @PG ID:bwa-1        PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa 01_trim/MC-
#samheader: @PG ID:samtools-1   PN:samtools     PP:bwa-1        VN:1.16.1       CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2-1   PN:pairtools_parse2     CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/MC-2020_nz_WT_rep1.standard-3.txt
#samheader: @PG ID:pairtools_sort-1     PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiya
#samheader: @PG ID:pairtools_dedup-1    PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 3 --mark-dups --outp
#samheader: @PG ID:pairtools_split-1    PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/MC-2020_nz_WT_rep1.sta
#samheader: @PG ID:pairtools_merge-1.7  PN:pairtools_merge      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools merge --output 05_dedup/MC-2020_nz_WT_rep1.standard-
#samheader: @PG ID:pairtools_select-1   PN:pairtools_select     CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools select (
#samheader: @PG ID:pairtools_merge-2.2  PN:pairtools_merge      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools merge --output 05_dedup/MC-2020_nz_WT_rep1.standard-
#samheader: @PG ID:bwa-2        PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa 01_trim/MC-
#samheader: @PG ID:samtools-2   PN:samtools     PP:bwa-2        VN:1.16.1       CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2-2   PN:pairtools_parse2     CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/MC-2020_nz_WT_rep1.keep-MM-6.txt.
#samheader: @PG ID:pairtools_sort-2     PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiya
#samheader: @PG ID:pairtools_dedup-2    PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 6 --mark-dups --outp
#samheader: @PG ID:pairtools_split-2    PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/MC-2020_nz_WT_rep1.kee
#samheader: @PG ID:pairtools_merge-3.7  PN:pairtools_merge      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools merge --output 05_dedup/MC-2020_nz_WT_rep1.standard-
#samheader: @PG ID:pairtools_select-2   PN:pairtools_select     CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools select (
#samheader: @PG ID:pairtools_merge-4.2  PN:pairtools_merge      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools merge --output 05_dedup/MC-2020_nz_WT_rep1.standard-
        (
            chrom1 != 'XII'             and             chrom2 != 'XII'
        (chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980)         or         (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980)
        )         or         (
            chrom1 == 'XII'             and             chrom2 != 'XII'             and             (int(pos51) < 451526 or int(pos51) > 468980)
        )         or         (
            chrom2 == 'XII'             and             chrom1 != 'XII'             and             (int(pos31) < 451526 or int(pos31) > 468980)
        )         or         (
            chrom1 == 'XII'             and             chrom2 == 'XII'             and             (int(pos51) < 451526 or int(pos51) > 468980)             and             (int(
        )
    ) 05_dedup/MC-2020_nz_WT_rep1.keep-MM-6.nodups.pairs.gz -o 05_dedup/MC-2020_nz_WT_rep1.keep-MM-6.only-rDNA.nodups.pairs.gz  PP:pairtools_split      VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR11893084.12257474    II      451591  XII     80464   +       -       UU      1       R2      451591  80464   451685  80395   60      60
```

</details>
<br />
