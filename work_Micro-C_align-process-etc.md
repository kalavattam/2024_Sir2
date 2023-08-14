
`#work_Micro-C_align-process.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Install packages necessary for Micro-C processing, analysis](#install-packages-necessary-for-micro-c-processing-analysis)
    1. [Remote and local \(work\) installations](#remote-and-local-work-installations)
        1. [Install mamba packages](#install-mamba-packages)
            1. [Code](#code)
        1. [Install atria](#install-atria)
            1. [Code](#code-1)
        1. [Install HiGlass](#install-higlass)
            1. [Code](#code-2)
        1. [Install Clodius and bedops](#install-clodius-and-bedops)
            1. [Code](#code-3)
1. [Set up the Micro-C processing workflow](#set-up-the-micro-c-processing-workflow)
    1. [0. Get situated](#0-get-situated)
        1. [Get to work directory, initialize environment](#get-to-work-directory-initialize-environment)
            1. [Start or enter `tmux` session](#start-or-enter-tmux-session)
                1. [Code](#code-4)
            1. [`grabnode`](#grabnode)
                1. [Code](#code-5)
            1. [Go to work directory, initialize environment](#go-to-work-directory-initialize-environment)
                1. [Code](#code-6)
        1. [Symlink to and rename files of interest](#symlink-to-and-rename-files-of-interest)
            1. [Initialize variables and arrays, run checks](#initialize-variables-and-arrays-run-checks)
                1. [Code](#code-7)
            1. [Symlink to and rename the `fastq`s](#symlink-to-and-rename-the-fastqs)
                1. [Code](#code-8)
        1. [Initialize variables, create outdirectories](#initialize-variables-create-outdirectories)
            1. [What datasets do we want to work with?](#what-datasets-do-we-want-to-work-with)
                1. [Notes](#notes)
            1. [Initialize "general" variables for workflow](#initialize-general-variables-for-workflow)
                1. [Code](#code-9)
            1. [Initialize "specific" variables, arrays for workflow](#initialize-specific-variables-arrays-for-workflow)
                1. [Code](#code-10)
            1. [Run print tests for the variables, arrays](#run-print-tests-for-the-variables-arrays)
                1. [Code](#code-11)
            1. [Initialize "specific" variables, arrays for `pairtools merge`](#initialize-specific-variables-arrays-for-pairtools-merge)
                1. [Code](#code-12)
            1. [Run print tests for `pairtools merge` variables, arrays](#run-print-tests-for-pairtools-merge-variables-arrays)
                1. [Code](#code-13)
            1. [Initialize varibales, arrays for "`standard-rDNA-complete`" processing](#initialize-varibales-arrays-for-standard-rdna-complete-processing)
                1. [Code](#code-14)
            1. [Create outdirectories if not present](#create-outdirectories-if-not-present)
                1. [Code](#code-15)
    1. [1. Trim `fastq` files](#1-trim-fastq-files)
        1. [Code](#code-16)
    1. [2. Align datasets](#2-align-datasets)
        1. [Code](#code-17)
    1. [3. Run `pairtools parse2`](#3-run-pairtools-parse2)
        1. [Code](#code-18)
    1. [4. Run `pairtools sort`](#4-run-pairtools-sort)
        1. [Code](#code-19)
    1. [5. Run `pairtools dedup` and `pairtools split`](#5-run-pairtools-dedup-and-pairtools-split)
        1. [Code](#code-20)
    1. [X. Run `pairtools merge` if applicable](#x-run-pairtools-merge-if-applicable)
        1. [Code](#code-21)
    1. [X. Run "`standard-rDNA-complete`" processing if applicable](#x-run-standard-rdna-complete-processing-if-applicable)
        1. [A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file](#a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file)
            1. [Code](#code-22)
        1. [B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM.nodups`" file](#b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mmnodups-file)
            1. [Code](#code-23)
        1. [C. Merge the "`standard.nodups`" and "`keep-MM.nodups`" files](#c-merge-the-standardnodups-and-keep-mmnodups-files)
            1. [Code](#code-24)
    1. [6. Run `pairtools stats`](#6-run-pairtools-stats)
        1. [Individual pairs files](#individual-pairs-files)
            1. [Code](#code-25)
    1. [7. Load pairs to cooler](#7-load-pairs-to-cooler)
        1. [Individual pairs file](#individual-pairs-file)
            1. [Code](#code-26)
    1. [8. Generate a multi-resolution cooler by coarsening](#8-generate-a-multi-resolution-cooler-by-coarsening)
        1. [Cools from individual pairs files](#cools-from-individual-pairs-files)
            1. [Code](#code-27)
    1. [9. Ingest files for HiGlass](#9-ingest-files-for-higlass)
        1. [Code](#code-28)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="install-packages-necessary-for-micro-c-processing-analysis"></a>
## Install packages necessary for Micro-C processing, analysis
<a id="remote-and-local-work-installations"></a>
### Remote and local (work) installations
<a id="install-mamba-packages"></a>
#### Install mamba packages
<a id="code"></a>
##### Code
<details>
<summary><i>Code: Install mamba packages</i></summary>

```bash
#!/bin/bash

install_env=FALSE
if [[ "${install_env}" == TRUE ]]; then
    #  Get GNU parallel, which is used below
    mamba create \
        -n pairtools_env \
        -c conda-forge \
            parallel
    
    source activate pairtools_env
    
    #  Obtain the Open2C suite of tools, plus Perl rename
    mamba install \
        -c bioconda \
            bioframe \
            cooler \
            coolpuppy \
            cooltools \
            pairtools \
            rename

    #  Packages needed for Atria, etc.
    mamba install \
        -c conda-forge \
            pbzip2 \
            pigz \
            r-tidyverse \
            r-argparse \
            r-plotly \
            r-ggsci
fi
```
</details>
<br />

<a id="install-atria"></a>
#### Install [atria](https://github.com/cihga39871/Atria)
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Install atria</i></summary>

```bash
#!/bin/bash

install_julia=FALSE
[[ "${install_julia}" == TRUE ]] &&
    {
        #  cd into "${HOME}"
        cd ~

        #  Obtain tar for the language Julia
        wget "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz"

        #  Decompress tar
        tar zxvf julia-1.8.5-linux-x86_64.tar.gz

        #  Add Julia to "${PATH}"
        #+ 1. Permanent: Run, e.g., vi ~/.bashrc, then manually add
        #+               "export PATH=$PATH:$HOME/julia-1.8.1/bin"
        #+ 2. Temporary: export PATH=$PATH:$HOME/julia-1.8.1/bin

        # which julia
    }

install_atria=FALSE
[[ "${install_atria}" == TRUE ]] &&
    {
        cd "${HOME}/2023_rDNA" || echo "cd'ing failed; check on this..."

        [[ -d software/ ]] || mkdir software/

        cd software/ || echo "cd'ing failed; check on this..."
        git clone "https://github.com/cihga39871/Atria.git"

        cd Atria/

        julia build_atria.jl
    }

alias_atria=FALSE
[[ "${alias_atria}" == TRUE ]] &&
    {
        alias atria="\${HOME}/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/app-3.2.2/bin/atria"
        # atria
    }
```
</details>
<br />

<a id="install-higlass"></a>
#### Install HiGlass
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Install HiGlass</i></summary>

```bash
#!/bin/bash

install_higlass=FALSE
[[ "${install_higlass}" == TRUE ]] &&
    {        
        docker pull higlass/higlass-docker

        p_proj="${HOME}/projects-etc/2023_rDNA"
        p_data="results/2023-0307_work_Micro-C_align-process/cool"
        docker run \
            --detach \
            --publish 8888:80 \
            --volume "${p_proj}/${p_data}":/data \
            --volume /tmp:/tmp \
            --name higlass-container \
            higlass/higlass-docker

        #  Check the mounts
        # docker exec higlass-container ls /tmp
        # docker exec higlass-container ls /data
    }
```
</details>
<br />
<br />

<a id="install-clodius-and-bedops"></a>
#### Install [Clodius](https://github.com/higlass/clodius) and [bedops](http://bedops.readthedocs.io/)
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Install Clodius and bedops</i></summary>

```bash
#!/bin/bash

[[ "${CONDA_DEFAULT_ENV}" != "pairtools_env" ]] \
    && source activate "pairtools_env" \
    || conda activate "pairtools_env"

install_clodius=FALSE
[[ "${install_clodius}" == TRUE ]] && pip install clodius

install_bedops=TRUE
[[ "${install_bedops}" == TRUE ]] && mamba install -c bioconda bedops
```
</details>
<br />
<br />

<a id="set-up-the-micro-c-processing-workflow"></a>
## Set up the Micro-C processing workflow
<a id="0-get-situated"></a>
### 0. Get situated
<a id="get-to-work-directory-initialize-environment"></a>
#### Get to work directory, initialize environment
<a id="start-or-enter-tmux-session"></a>
##### Start or enter `tmux` session
<a id="code-4"></a>
###### Code
<details>
<summary><i>Code: Start or enter tmux session</i></summary>

```bash
#!/bin/bash

# tmux new-ses -t mc
# tmux a -t mc
```
</details>
<br />

<a id="grabnode"></a>
##### `grabnode`
<a id="code-5"></a>
###### Code
<details>
<summary><i>Code: grabnode</i></summary>

```bash
#!/bin/bash

# #  Workflow is written to be interactive
# grabnode  # 8 cores: 8, 20, 1, N
```
</details>
<br />

<a id="go-to-work-directory-initialize-environment"></a>
##### Go to work directory, initialize environment
<a id="code-6"></a>
###### Code
<details>
<summary><i>Code: Go to work directory, initialize environment</i></summary>

```bash
#!/bin/bash

#LOAD
p_base="${HOME}/tsukiyamalab/kalavatt"
p_proj="2023_rDNA/results/2023-0307_work_Micro-C_align-process"
cd "${p_base}/${p_proj}" || echo "cd'ing failed; check on this..."


[[ "${CONDA_DEFAULT_ENV}" != "pairtools_env" ]] \
    && source activate pairtools_env \
    || conda activate pairtools_env
```
</details>
<br />

<a id="symlink-to-and-rename-files-of-interest"></a>
#### Symlink to and rename files of interest
<a id="initialize-variables-and-arrays-run-checks"></a>
##### Initialize variables and arrays, run checks
<a id="code-7"></a>
###### Code
<details>
<summary><i>Code: Symlink to and rename files of interest</i></summary>

```bash
#!/bin/bash

#LOAD
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        p_Mol_Cell_2019="${HOME}/2023_rDNA_data/PRJNA493742"  # ., "${p_Mol_Cell_2019}"
        p_eLife_2020="${HOME}/2023_rDNA_data/PRJNA636358"  # ., "${p_eLife_2020}"
        p_eLife_2021="${HOME}/2023_rDNA_data/PRJNA702747"  # ., "${p_eLife_2021}"

        run_check=FALSE
        [[ "${run_check}" == TRUE ]] &&
            {
                ls -1 "${p_Mol_Cell}"
                ls -1 "${p_eLife_2020}"
                ls -1 "${p_eLife_2021}"
            }

        unset A_eLife_2020 && typeset -A A_eLife_2020
        unset a_eLife_2020 && typeset -a a_eLife_2020
        A_eLife_2020["SRR11893084"]="MC-2020_nz_WT_rep1"; a_eLife_2020="SRR11893084"
        A_eLife_2020["SRR11893085"]="MC-2020_nz_WT_rep2"; a_eLife_2020="SRR11893085"
        A_eLife_2020["SRR11893086"]="MC-2020_nz_MCD1-AID_rep1"; a_eLife_2020="SRR11893086"
        A_eLife_2020["SRR11893087"]="MC-2020_nz_MCD1-AID_rep2"; a_eLife_2020="SRR11893087"
        A_eLife_2020["SRR11893088"]="MC-2020_nz_BRN1-AID_rep1"; a_eLife_2020="SRR11893088"
        A_eLife_2020["SRR11893089"]="MC-2020_nz_BRN1-AID_rep2"; a_eLife_2020="SRR11893089"
        A_eLife_2020["SRR11893090"]="MC-2020_nz_MCD1-AID-BRN1-AID_rep1"; a_eLife_2020="SRR11893090"
        A_eLife_2020["SRR11893091"]="MC-2020_nz_MCD1-AID-BRN1-AID_rep2"; a_eLife_2020="SRR11893091"
        A_eLife_2020["SRR11893092"]="MC-2020_nz_WPL1-AID_rep1"; a_eLife_2020="SRR11893092"
        A_eLife_2020["SRR11893093"]="MC-2020_nz_WPL1-AID_rep2"; a_eLife_2020="SRR11893093"
        A_eLife_2020["SRR11893094"]="MC-2020_nz_PDS5-AID_rep0"; a_eLife_2020="SRR11893094"
        A_eLife_2020["SRR11893095"]="MC-2020_30C-a15_WT_rep1"; a_eLife_2020="SRR11893095"
        A_eLife_2020["SRR11893096"]="MC-2020_30C-a15_WT_rep2"; a_eLife_2020="SRR11893096"
        A_eLife_2020["SRR11893107"]="MC-2020_23C-a15_WT_rep0"; a_eLife_2020="SRR11893107"

        unset A_Mol_Cell_2019 && typeset -A A_Mol_Cell_2019
        unset a_Mol_Cell_2019 && typeset -a a_Mol_Cell_2019
        A_Mol_Cell_2019["SRR7939017"]="MC-2019_log_WT_repM"; a_Mol_Cell_2019="MC_log_WT_repM"
        A_Mol_Cell_2019["SRR7939018"]="MC-2019_Q_WT_repM"; a_Mol_Cell_2019="MC_Q_WT_repM"

        unset A_eLife_2021 && typeset -A A_eLife_2021
        unset a_eLife_2021 && typeset -A a_eLife_2021
        A_eLife_2021["SRR13736655"]="MC-2021_log_WT_repM"; a_eLife_2021="MC-2021_log_WT_repM"
        A_eLife_2021["SRR13736659"]="MC-2021_Q_WT_repM"; a_eLife_2021="MC-2021_Q_WT_repM"

        run_check=FALSE
        [[ "${run_check}" == TRUE ]] &&
            {
                #  Check that files are correctly accessed
                for i in "${!A_eLife_2020[@]}"; do
                    echo "  key  ${i}"
                    echo "value  ${A_eLife_2020[${i}]}"
                    echo ""

                    ls -lhaFG "${p_eLife_2020}/${i}_1.fastq.gz"
                    ls -lhaFG "${p_eLife_2020}/${i}_2.fastq.gz"
                    echo ""
                done

                for i in "${!A_Mol_Cell_2019[@]}"; do
                    echo "  key  ${i}"
                    echo "value  ${A_Mol_Cell_2019[${i}]}"
                    echo ""

                    ls -lhaFG "${p_Mol_Cell_2019}/${i}_1.fastq.gz"
                    ls -lhaFG "${p_Mol_Cell_2019}/${i}_2.fastq.gz"
                    echo ""
                done

                for i in "${!A_eLife_2021[@]}"; do
                    echo "  key  ${i}"
                    echo "value  ${A_eLife_2021[${i}]}"
                    echo ""

                    ls -lhaFG "${p_eLife_2021}/${i}_1.fastq.gz"
                    ls -lhaFG "${p_eLife_2021}/${i}_2.fastq.gz"
                    echo ""
                done
            }
    }
```
</details>
<br />

<a id="symlink-to-and-rename-the-fastqs"></a>
##### Symlink to and rename the `fastq`s
<a id="code-8"></a>
###### Code
<details>
<summary><i>Code: Symlink to and rename the fastqs</i></summary>

```bash
#!/bin/bash

run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        [[ $(pwd) =~ "2023-0307_work_Micro-C_align-process" ]] \
            && cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"
        [[ ! -d "sym/" ]] && mkdir -p "sym/"

        for i in "${!A_eLife_2020[@]}"; do
            echo "  key  ${i}"
            echo "value  ${A_eLife_2020[${i}]}"
            echo ""

            ln -s "${p_eLife_2020}/${i}_1.fastq.gz" "sym/${A_eLife_2020[${i}]}_R1.fastq.gz"
            ln -s "${p_eLife_2020}/${i}_2.fastq.gz" "sym/${A_eLife_2020[${i}]}_R2.fastq.gz"
            echo ""
        done

        for i in "${!A_Mol_Cell_2019[@]}"; do
            echo "  key  ${i}"
            echo "value  ${A_Mol_Cell_2019[${i}]}"
            echo ""

            ln -s "${p_Mol_Cell_2019}/${i}_1.fastq.gz" "sym/${A_Mol_Cell_2019[${i}]}_R1.fastq.gz"
            ln -s "${p_Mol_Cell_2019}/${i}_2.fastq.gz" "sym/${A_Mol_Cell_2019[${i}]}_R2.fastq.gz"
            echo ""
        done

        for i in "${!A_eLife_2021[@]}"; do
            echo "  key  ${i}"
            echo "value  ${A_eLife_2021[${i}]}"
            echo ""

            ln -s "${p_eLife_2021}/${i}_1.fastq.gz" "sym/${A_eLife_2021[${i}]}_R1.fastq.gz"
            ln -s "${p_eLife_2021}/${i}_2.fastq.gz" "sym/${A_eLife_2021[${i}]}_R2.fastq.gz"
            echo ""
        done

        run_check=FALSE
        [[ "${run_check}" == TRUE ]] && ls -lhaFG sym/
    }
```
</details>
<br />

<a id="initialize-variables-create-outdirectories"></a>
#### Initialize variables, create outdirectories
<a id="what-datasets-do-we-want-to-work-with"></a>
##### What datasets do we want to work with?
<a id="notes"></a>
###### Notes
<details>
<summary><i>Notes: What datasets do we want to work with?</i></summary>
<br />

*These datasets...*  
MC-2019_log_WT_repM_R1.fastq.gz  
MC-2019_log_WT_repM_R2.fastq.gz

MC-2019_Q_WT_repM_R1.fastq.gz  
MC-2019_Q_WT_repM_R2.fastq.gz

MC-2020_23C-a15_WT_rep0_R1.fastq.gz  
MC-2020_23C-a15_WT_rep0_R2.fastq.gz

MC-2020_30C-a15_WT_rep1_R1.fastq.gz  
MC-2020_30C-a15_WT_rep1_R2.fastq.gz  
MC-2020_30C-a15_WT_rep2_R1.fastq.gz  
MC-2020_30C-a15_WT_rep2_R2.fastq.gz

MC-2020_nz_BRN1-AID_rep1_R1.fastq.gz  
MC-2020_nz_BRN1-AID_rep1_R2.fastq.gz  
MC-2020_nz_BRN1-AID_rep2_R1.fastq.gz  
MC-2020_nz_BRN1-AID_rep2_R2.fastq.gz

MC-2020_nz_MCD1-AID-BRN1-AID_rep1_R1.fastq.gz  
MC-2020_nz_MCD1-AID-BRN1-AID_rep1_R2.fastq.gz  
MC-2020_nz_MCD1-AID-BRN1-AID_rep2_R1.fastq.gz  
MC-2020_nz_MCD1-AID-BRN1-AID_rep2_R2.fastq.gz

MC-2020_nz_MCD1-AID_rep1_R1.fastq.gz  
MC-2020_nz_MCD1-AID_rep1_R2.fastq.gz  
MC-2020_nz_MCD1-AID_rep2_R1.fastq.gz  
MC-2020_nz_MCD1-AID_rep2_R2.fastq.gz

MC-2020_nz_PDS5-AID_rep0_R1.fastq.gz  
MC-2020_nz_PDS5-AID_rep0_R2.fastq.gz

MC-2020_nz_WPL1-AID_rep1_R1.fastq.gz  
MC-2020_nz_WPL1-AID_rep1_R2.fastq.gz  
MC-2020_nz_WPL1-AID_rep2_R1.fastq.gz  
MC-2020_nz_WPL1-AID_rep2_R2.fastq.gz

MC-2020_nz_WT_rep1_R1.fastq.gz  
MC-2020_nz_WT_rep1_R2.fastq.gz  
MC-2020_nz_WT_rep2_R1.fastq.gz  
MC-2020_nz_WT_rep2_R2.fastq.gz

MC-2021_log_WT_repM_R1.fastq.gz  
MC-2021_log_WT_repM_R2.fastq.gz

MC-2021_Q_WT_repM_R1.fastq.gz  
MC-2021_Q_WT_repM_R2.fastq.gz
<br />
<br />

*I guess all of it...*
<br />
<br />

*But to start with&mdash;for initial experiments and to refactor/build out the code?*  
MC-2019_Q_WT_repM_R1.fastq.gz  
MC-2019_Q_WT_repM_R2.fastq.gz

MC-2020_30C-a15_WT_rep1_R1.fastq.gz  
MC-2020_30C-a15_WT_rep1_R2.fastq.gz  
MC-2020_30C-a15_WT_rep2_R1.fastq.gz  
MC-2020_30C-a15_WT_rep2_R2.fastq.gz

MC-2020_nz_WT_rep1_R1.fastq.gz  
MC-2020_nz_WT_rep1_R2.fastq.gz  
MC-2020_nz_WT_rep2_R1.fastq.gz  
MC-2020_nz_WT_rep2_R2.fastq.gz
</details>
<br />

<a id="initialize-general-variables-for-workflow"></a>
##### Initialize "general" variables for workflow
<a id="code-9"></a>
###### Code
<details>
<summary><i>Code: Initialize "general" variables for workflow</i></summary>

```bash
#!/bin/bash

#LOAD
#  Initialize array of samples to work with
unset stem && typeset -a stem
stem+=( "MC-2019_Q_WT_repM" )        #INITIAL
stem+=( "MC-2020_30C-a15_WT_rep1" )  #INITIAL
stem+=( "MC-2020_30C-a15_WT_rep2" )  #INITIAL
stem+=( "MC-2020_nz_WT_rep1" )       #INITIAL
stem+=( "MC-2020_nz_WT_rep2" )       #INITIAL

#  Initialize arrays of samples to merge
unset to_merge && typeset -a to_merge
to_merge+=( "MC-2020_30C-a15_WT" )   #INITIAL
to_merge+=( "MC-2020_nz_WT" )        #INITIAL

run_check=TRUE
[[ "${run_check[@]}" == TRUE ]] &&
    {
        for i in "${stem[@]}"; do
            ls -lhaFG "sym/${i}_R1.fastq.gz"
            ls -lhaFG "sym/${i}_R2.fastq.gz"
            echo ""
        done
    }

#TODO Reconsider appropriate locations to initialize these variables
#  CPU and scratch storage settings
threads="8"                                 # echo "${threads}"
scratch="/fh/scratch/delete30/tsukiyama_t"  # ., "${scratch}"  

#  Settings to run "standard", "rDNA", and "complete" operations
pro_std=TRUE
pro_rDNA=TRUE
pro_comp=TRUE

#  Initialize variables for left- and right-most positions to be considered for
#+ the rDNA locus on XII
rDNA_pos_l=451526  # echo "${rDNA_pos_l}"
rDNA_pos_r=468980  # echo "${rDNA_pos_r}"

#  Run print test
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        echo """
        General variables for workflow
        ==============================
           threads=${threads}
           scratch=${scratch}
           
           pro_std=${pro_std}
          pro_rDNA=${pro_rDNA}
          pro_comp=${pro_comp}
        
        rDNA_pos_l=${rDNA_pos_l}
        rDNA_pos_r=${rDNA_pos_r}
        """
    }
```
</details>
<br />

<a id="initialize-specific-variables-arrays-for-workflow"></a>
##### Initialize "specific" variables, arrays for workflow
<a id="code-10"></a>
###### Code
<details>
<summary><i>Code: Initialize "specific" variables, arrays for workflow</i></summary>

```bash
#!/bin/bash

#LOAD
#  Initialize function
echo_test() { for i in "${@:-*}"; do echo "${i}"; done; }


#  For alignment
         d_genome="${HOME}/tsukiyamalab/kalavatt/genomes"                 # ., "${d_genome}"
          d_index="${d_genome}/Saccharomyces_cerevisiae/bwa"              # ., "${d_index}"
          f_index="S288C_R64-3-1.fa"                                      # ., "${d_index}/${f_index}"*
          a_index="${d_index}/${f_index}"                                 # ., "${a_index}"*

#  For pairtools parse2
           d_size="${d_genome}/Saccharomyces_cerevisiae/fasta-processed"  # ., "${d_size}"
           f_size="S288C_reference_sequence_R64-3-1_20210421.size"        # ., "${d_size}/${f_size}"
           a_size="${d_size}/${f_size}"                                   # ., "${a_size}"

         assembly="S288C_R64-3-1"                                         # echo "${assembly}"

 max_mismatch_std=3                                                       # echo "${max_mismatch_std}"
max_mismatch_rDNA=6                                                       # echo "${max_mismatch_rDNA}"

     min_mapq_std=1                                                       # echo "${min_mapq_std}"
    min_mapq_rDNA=0                                                       # echo "${min_mapq_rDNA}"

#  For cooler cload pairs
      bin_initial=25

#  Directories to store pipeline outfiles
           d_trim="01_trim"        # echo "${d_trim}"
            d_bam="02_align"       # echo "${d_bam}"
          d_pairs="03_parse"       # echo "${d_pairs}"
          d_stats="06_stats"       # echo "${d_stats}"
           d_sort="04_sort"        # echo "${d_sort}"
          d_dedup="05_dedup"       # echo "${d_dedup}"
          d_cload="07_cload"       # echo "${d_cload}"
           d_zoom="08_zoom"        # echo "${d_zoom}"

#  Get situated
unset                        f_pre && typeset -a f_pre                         # echo_test "${f_pre[@]}"

unset                       a_fq_1 && typeset -a a_fq_1                        # echo_test "${a_fq_1[@]}"
unset                       a_fq_2 && typeset -a a_fq_2                        # echo_test "${a_fq_2[@]}"

#  01_trim
unset                      a_afq_1 && typeset -a a_afq_1                       # echo_test "${a_afq_1[@]}"
unset                      a_afq_2 && typeset -a a_afq_2                       # echo_test "${a_afq_2[@]}"

#  02_bam
unset                        a_bam && typeset -a a_bam                         # echo_test "${a_bam[@]}"

#  03_parse2: standard
unset                    f_pre_std && typeset -a f_pre_std                     # echo_test "${f_pre_std[@]}"
unset                  f_pairs_std && typeset -a f_pairs_std                   # echo_test "${f_pairs_std[@]}"
unset                  a_pairs_std && typeset -a a_pairs_std                   # echo_test "${a_pairs_std[@]}"

#  03_parse2: rDNA
unset                   f_pre_rDNA && typeset -a f_pre_rDNA                    # echo_test "${f_pre_rDNA[@]}"
unset                 f_pairs_rDNA && typeset -a f_pairs_rDNA                  # echo_test "${f_pairs_rDNA[@]}"
unset                 a_pairs_rDNA && typeset -a a_pairs_rDNA                  # echo_test "${a_pairs_rDNA[@]}"

#  06_stats: standard
unset                  f_stats_std && typeset -a f_stats_std                   # echo_test "${f_stats_std[@]}"
unset                  a_stats_std && typeset -a a_stats_std                   # echo_test "${a_stats_std[@]}"

#  06_stats: rDNA
unset                 f_stats_rDNA && typeset -a f_stats_rDNA                  # echo_test "${f_stats_rDNA[@]}"
unset                 a_stats_rDNA && typeset -a a_stats_rDNA                  # echo_test "${a_stats_rDNA[@]}"

#  04_sort: standard
unset                   f_sort_std && typeset -a f_sort_std                    # echo_test "${f_sort_std[@]}"
unset                   a_sort_std && typeset -a a_sort_std                    # echo_test "${a_sort_std[@]}"

#  04_sort: rDNA
unset                  f_sort_rDNA && typeset -a f_sort_rDNA                   # echo_test "${f_sort_rDNA[@]}"
unset                  a_sort_rDNA && typeset -a a_sort_rDNA                   # echo_test "${a_sort_rDNA[@]}"

#  05_dedup: standard
unset              f_dedup_pre_std && typeset -a f_dedup_pre_std               # echo_test "${f_dedup_pre_std[@]}"
unset        a_dedup_pre_pairs_std && typeset -a a_dedup_pre_pairs_std         # echo_test "${a_dedup_pre_pairs_std[@]}"

unset                f_dup_pre_std && typeset -a f_dup_pre_std                 # echo_test "${f_dup_pre_std[@]}"
unset          a_dup_pre_pairs_std && typeset -a a_dup_pre_pairs_std           # echo_test "${a_dup_pre_pairs_std[@]}"

unset              f_unmap_pre_std && typeset -a f_unmap_pre_std               # echo_test "${f_unmap_pre_std[@]}"
unset        a_unmap_pre_pairs_std && typeset -a a_unmap_pre_pairs_std         # echo_test "${a_unmap_pre_pairs_std[@]}"

unset            f_dedup_stats_std && typeset -a f_dedup_stats_std             # echo_test "${f_dedup_stats_std[@]}"
unset            a_dedup_stats_std && typeset -a a_dedup_stats_std             # echo_test "${a_dedup_stats_std[@]}"

#  05_dedup: rDNA
unset             f_dedup_pre_rDNA && typeset -a f_dedup_pre_rDNA              # echo_test "${f_dedup_pre_rDNA[@]}"
unset       a_dedup_pre_pairs_rDNA && typeset -a a_dedup_pre_pairs_rDNA        # echo_test "${a_dedup_pre_pairs_rDNA[@]}"

unset               f_dup_pre_rDNA && typeset -a f_dup_pre_rDNA                # echo_test "${f_dup_pre_rDNA[@]}"
unset         a_dup_pre_pairs_rDNA && typeset -a a_dup_pre_pairs_rDNA          # echo_test "${a_dup_pre_pairs_rDNA[@]}"

unset             f_unmap_pre_rDNA && typeset -a f_unmap_pre_rDNA              # echo_test "${f_unmap_pre_rDNA[@]}"
unset       a_unmap_pre_pairs_rDNA && typeset -a a_unmap_pre_pairs_rDNA        # echo_test "${a_unmap_pre_pairs_rDNA[@]}"

unset           f_dedup_stats_rDNA && typeset -a f_dedup_stats_rDNA            # echo_test "${f_dedup_stats_rDNA[@]}"
unset           a_dedup_stats_rDNA && typeset -a a_dedup_stats_rDNA            # echo_test "${a_dedup_stats_rDNA[@]}"

#  06_stats: standard
unset  f_dedup_pre_pairs_stats_std && typeset -a f_dedup_pre_pairs_stats_std   # echo_test "${f_dedup_pre_pairs_stats[@]}"
unset  a_dedup_pre_pairs_stats_std && typeset -a a_dedup_pre_pairs_stats_std   # echo_test "${a_dedup_pre_pairs_stats[@]}"

unset    f_dup_pre_pairs_stats_std && typeset -a f_dup_pre_pairs_stats_std     # echo_test "${f_dup_pre_pairs_stats[@]}"
unset    a_dup_pre_pairs_stats_std && typeset -a a_dup_pre_pairs_stats_std     # echo_test "${a_dup_pre_pairs_stats[@]}"

unset  f_unmap_pre_pairs_stats_std && typeset -a f_unmap_pre_pairs_stats_std   # echo_test "${f_unmap_pre_pairs_stats[@]}"
unset  a_unmap_pre_pairs_stats_std && typeset -a a_unmap_pre_pairs_stats_std   # echo_test "${a_unmap_pre_pairs_stats[@]}"

#  06_stats: rDNA
unset f_dedup_pre_pairs_stats_rDNA && typeset -a f_dedup_pre_pairs_stats_rDNA  # echo_test "${f_dedup_pre_pairs_stats_rDNA[@]}"
unset a_dedup_pre_pairs_stats_rDNA && typeset -a a_dedup_pre_pairs_stats_rDNA  # echo_test "${a_dedup_pre_pairs_stats_rDNA[@]}"

unset   f_dup_pre_pairs_stats_rDNA && typeset -a f_dup_pre_pairs_stats_rDNA    # echo_test "${f_dup_pre_pairs_stats_rDNA[@]}"
unset   a_dup_pre_pairs_stats_rDNA && typeset -a a_dup_pre_pairs_stats_rDNA    # echo_test "${a_dup_pre_pairs_stats_rDNA[@]}"

unset f_unmap_pre_pairs_stats_rDNA && typeset -a f_unmap_pre_pairs_stats_rDNA  # echo_test "${f_unmap_pre_pairs_stats_rDNA[@]}"
unset a_unmap_pre_pairs_stats_rDNA && typeset -a a_unmap_pre_pairs_stats_rDNA  # echo_test "${a_unmap_pre_pairs_stats_rDNA[@]}"

#  07_cload
unset                      f_cload && typeset -a f_cload                       # echo_test "${f_cload[@]}"
unset                      a_cload && typeset -a a_cload                       # echo_test "${a_cload[@]}"

#  08_zoom
unset                       f_zoom && typeset -a f_zoom                        # echo_test "${f_zoom[@]}"
unset                       a_zoom && typeset -a a_zoom                        # echo_test "${a_zoom[@]}"

#  Populate arrays
for (( i = 0; i < "${#stem[@]}"; i++ )); do  #LATER
    # echo "${i}"

    #  Get situated
                           f_pre+=( "${stem[${i}]}" )

                          a_fq_1+=( "sym/${f_pre[${i}]}_R1.fastq.gz" )
                          a_fq_2+=( "sym/${f_pre[${i}]}_R2.fastq.gz" )

    #  01_trim
                         a_afq_1+=( "${d_trim}/${f_pre[${i}]}_R1.atria.fastq.gz" )
                         a_afq_2+=( "${d_trim}/${f_pre[${i}]}_R2.atria.fastq.gz" )

    #  02_bam
                           f_bam+=( "${f_pre[${i}]}.bam" )
                           a_bam+=( "${d_bam}/${f_bam[${i}]}" )

    #  03_parse2: standard
                       f_pre_std+=( "${f_pre[${i}]}.standard-${max_mismatch_std}" )
                     f_pairs_std+=( "${f_pre_std[${i}]}.txt.gz" )
                     a_pairs_std+=( "${d_pairs}/${f_pairs_std[${i}]}" )

    #  03_parse2: rDNA
                      f_pre_rDNA+=( "${f_pre[${i}]}.keep-MM-${max_mismatch_rDNA}" )
                    f_pairs_rDNA+=( "${f_pre_rDNA[${i}]}.txt.gz" )
                    a_pairs_rDNA+=( "${d_pairs}/${f_pairs_rDNA[${i}]}" )

    #  06_stats: standard
                     f_stats_std+=( "${f_pre_std[${i}]}.stats.txt" )
                     a_stats_std+=( "${d_stats}/${f_stats_std[${i}]}" )

    #  06_stats: rDNA
                    f_stats_rDNA+=( "${f_pre_rDNA[${i}]}.stats.txt" )
                    a_stats_rDNA+=( "${d_stats}/${f_stats_rDNA[${i}]}" )

    #  04_sort: standard
                      f_sort_std+=( "${f_pre_std[${i}]}.sort.txt.gz" )
                      a_sort_std+=( "${d_sort}/${f_sort_std[${i}]}" )

    #  04_sort: rDNA
                     f_sort_rDNA+=( "${f_pre_rDNA[${i}]}.sort.txt.gz" )
                     a_sort_rDNA+=( "${d_sort}/${f_sort_rDNA[${i}]}" )

    #  05_dedup: standard
                 f_dedup_pre_std+=( "${f_pre_std[${i}]}.nodups" )
           a_dedup_pre_pairs_std+=( "${d_dedup}/${f_dedup_pre_std[${i}]}.pairs.gz" )
    
                   f_dup_pre_std+=( "${f_pre_std[${i}]}.dups" )
             a_dup_pre_pairs_std+=( "${d_dedup}/${f_dup_pre_std[${i}]}.pairs.gz" )
    
                 f_unmap_pre_std+=( "${f_pre_std[${i}]}.unmapped" )
           a_unmap_pre_pairs_std+=( "${d_dedup}/${f_unmap_pre_std[${i}]}.pairs.gz" )

               f_dedup_stats_std+=( "${f_pre_std[${i}]}.dedup.stats.txt" )
               a_dedup_stats_std+=( "${d_stats}/${f_dedup_stats_std[${i}]}" )

    #  05_dedup: rDNA
                f_dedup_pre_rDNA+=( "${f_pre_rDNA[${i}]}.nodups" )
          a_dedup_pre_pairs_rDNA+=( "${d_dedup}/${f_dedup_pre_rDNA[${i}]}.pairs.gz" )
    
                  f_dup_pre_rDNA+=( "${f_pre_rDNA[${i}]}.dups" )
            a_dup_pre_pairs_rDNA+=( "${d_dedup}/${f_dup_pre_rDNA[${i}]}.pairs.gz" )
    
                f_unmap_pre_rDNA+=( "${f_pre_rDNA[${i}]}.unmapped" )
          a_unmap_pre_pairs_rDNA+=( "${d_dedup}/${f_unmap_pre_rDNA[${i}]}.pairs.gz" )

              f_dedup_stats_rDNA+=( "${f_pre_rDNA[${i}]}.dedup.stats.txt" )
              a_dedup_stats_rDNA+=( "${d_stats}/${f_dedup_stats_rDNA[${i}]}" )

    #  06_stats: standard
     f_dedup_pre_pairs_stats_std+=( "${f_dedup_pre_std[${i}]}.stats.txt" )
     a_dedup_pre_pairs_stats_std+=( "${d_stats}/${f_dedup_pre_pairs_stats_std[${i}]}" )
    
       f_dup_pre_pairs_stats_std+=( "${f_dup_pre_std[${i}]}.stats.txt" )
       a_dup_pre_pairs_stats_std+=( "${d_stats}/${f_dup_pre_pairs_stats_std[${i}]}" )
    
     f_unmap_pre_pairs_stats_std+=( "${f_unmap_pre_std[${i}]}.stats.txt" )
     a_unmap_pre_pairs_stats_std+=( "${d_stats}/${f_unmap_pre_pairs_stats_std[${i}]}" )

    #  06_stats: rDNA
    f_dedup_pre_pairs_stats_rDNA+=( "${f_dedup_pre_rDNA[${i}]}.stats.txt" )
    a_dedup_pre_pairs_stats_rDNA+=( "${d_stats}/${f_dedup_pre_pairs_stats_rDNA[${i}]}" )
    
      f_dup_pre_pairs_stats_rDNA+=( "${f_dup_pre_rDNA[${i}]}.stats.txt" )
      a_dup_pre_pairs_stats_rDNA+=( "${d_stats}/${f_dup_pre_pairs_stats_rDNA[${i}]}" )
    
    f_unmap_pre_pairs_stats_rDNA+=( "${f_unmap_pre_rDNA[${i}]}.stats.txt" )
    a_unmap_pre_pairs_stats_rDNA+=( "${d_stats}/${f_unmap_pre_pairs_stats_rDNA[${i}]}" )

    #  07_cload
                         f_cload+=( "${f_pre[${i}]}.cload.cool" )
                         a_cload+=( "${d_cload}/${f_cload[${i}]}" )

    #  08_zoom
                          f_zoom+=( "${f_pre[${i}]}.mcool" )
                          a_zoom+=( "${d_zoom}/${f_zoom[${i}]}" )
done
```
</details>
<br />

<a id="run-print-tests-for-the-variables-arrays"></a>
##### Run print tests for the variables, arrays
<a id="code-11"></a>
###### Code
<details>
<summary><i>Code: Run print tests for the variables, arrays</i></summary>

```bash
#!/bin/bash

print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0 ; i < ${#stem[@]} ; i++ )); do
            # i=4
            echo """
            Specific variables for workflow
            ===============================
            fastqs
            --------------------------------------------------
                             a_fq_1=${a_fq_1[${i}]}
                             a_fq_2=${a_fq_2[${i}]}

            atria
            --------------------------------------------------
                             d_trim=${d_trim}
                            a_afq_1=${a_afq_1[${i}]}
                            a_afq_2=${a_afq_2[${i}]}
            
            bwa mem
            --------------------------------------------------
                              d_bam=${d_bam}
                              a_bam=${a_bam[${i}]}
            
                            d_index=${d_index}
                            f_index=${f_index}
                            a_index=${a_index}

            pairtools parse2
            --------------------------------------------------
                             d_size=${d_size}
                             f_size=${f_size}
                             a_size=${a_size}
            
                           assembly=${assembly}

                   max_mismatch_std=${max_mismatch_std}
                       min_mapq_std=${min_mapq_std}

                  max_mismatch_rDNA=${max_mismatch_rDNA}
                      min_mapq_rDNA=${min_mapq_rDNA}

                            d_pairs=${d_pairs}

                        f_pairs_std=${f_pairs_std[${i}]}
                       f_pairs_rDNA=${f_pairs_rDNA[${i}]}

                        a_pairs_std=${a_pairs_std[${i}]}
                       a_pairs_rDNA=${a_pairs_rDNA[${i}]}

                            d_stats=${d_stats}

                        f_stats_std=${f_stats_std[${i}]}
                       f_stats_rDNA=${f_stats_rDNA[${i}]}

                        a_stats_std=${a_stats_std[${i}]}
                       a_stats_rDNA=${a_stats_rDNA[${i}]}

            pairtools sort
            --------------------------------------------------
                                  d_sort=${d_sort}

                              f_sort_std=${f_sort_std[${i}]}
                             f_sort_rDNA=${f_sort_rDNA[${i}]}

                              a_sort_std=${a_sort_std[${i}]}
                             a_sort_rDNA=${a_sort_rDNA[${i}]}

            pairtools dedup
            --------------------------------------------------
                                 d_dedup=${d_dedup}

                         f_dedup_pre_std=${f_dedup_pre_std[${i}]}
                           f_dup_pre_std=${f_dup_pre_std[${i}]}
                         f_unmap_pre_std=${f_unmap_pre_std[${i}]}

                   a_dedup_pre_pairs_std=${a_dedup_pre_pairs_std[${i}]}
                     a_dup_pre_pairs_std=${a_dup_pre_pairs_std[${i}]}
                   a_unmap_pre_pairs_std=${a_unmap_pre_pairs_std[${i}]}
            
                       f_dedup_stats_std=${f_dedup_stats_std[${i}]}
                       a_dedup_stats_std=${a_dedup_stats_std[${i}]}

                        f_dedup_pre_rDNA=${f_dedup_pre_rDNA[${i}]}
                          f_dup_pre_rDNA=${f_dup_pre_rDNA[${i}]}
                        f_unmap_pre_rDNA=${f_unmap_pre_rDNA[${i}]}

                  a_dedup_pre_pairs_rDNA=${a_dedup_pre_pairs_rDNA[${i}]}
                    a_dup_pre_pairs_rDNA=${a_dup_pre_pairs_rDNA[${i}]}
                  a_unmap_pre_pairs_rDNA=${a_unmap_pre_pairs_rDNA[${i}]}
            
                      f_dedup_stats_rDNA=${f_dedup_stats_rDNA[${i}]}
                      a_dedup_stats_rDNA=${a_dedup_stats_rDNA[${i}]}

            pairtools stats
            --------------------------------------------------
             f_dedup_pre_pairs_stats_std=${f_dedup_pre_pairs_stats_std[${i}]}
               f_dup_pre_pairs_stats_std=${f_dup_pre_pairs_stats_std[${i}]}
             f_unmap_pre_pairs_stats_std=${f_unmap_pre_pairs_stats_std[${i}]}
            
             a_dedup_pre_pairs_stats_std=${a_dedup_pre_pairs_stats_std[${i}]}
               a_dup_pre_pairs_stats_std=${a_dup_pre_pairs_stats_std[${i}]}
             a_unmap_pre_pairs_stats_std=${a_unmap_pre_pairs_stats_std[${i}]}

            f_dedup_pre_pairs_stats_rDNA=${f_dedup_pre_pairs_stats_rDNA[${i}]}
              f_dup_pre_pairs_stats_rDNA=${f_dup_pre_pairs_stats_rDNA[${i}]}
            f_unmap_pre_pairs_stats_rDNA=${f_unmap_pre_pairs_stats_rDNA[${i}]}
            
            a_dedup_pre_pairs_stats_rDNA=${a_dedup_pre_pairs_stats_rDNA[${i}]}
              a_dup_pre_pairs_stats_rDNA=${a_dup_pre_pairs_stats_rDNA[${i}]}
            a_unmap_pre_pairs_stats_rDNA=${a_unmap_pre_pairs_stats_rDNA[${i}]}

            #TODO
            cooler cload pairs
            --------------------------------------------------
                             bin_initial=${bin_initial}
                                 d_cload=${d_cload}
                                 f_cload=${f_cload[${i}]}
                                 a_cload=${a_cload[${i}]}

            cooler zoomify
            --------------------------------------------------
                                  d_zoom=${d_zoom}
                                  f_zoom=${f_zoom[${i}]}
                                  a_zoom=${a_zoom[${i}]}
            """
        done
    }
```
</details>
<br />

<a id="initialize-specific-variables-arrays-for-pairtools-merge"></a>
##### Initialize "specific" variables, arrays for `pairtools merge`
<a id="code-12"></a>
###### Code
<details>
<summary><i>Code: Initialize "specific" variables, arrays for pairtools merge</i></summary>

```bash
#!/bin/bash

#LOAD
[[ "${#to_merge[@]}" -ne 0 ]] &&
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

        #  Populate arrays
        for (( i = 0 ; i < ${#to_merge[@]} ; i++ )); do
            # i=0
            
            # echo "${i}"
            # echo "${to_merge[${i}]}"

            #  For pairtools merge
               name_1+=( "${to_merge[${i}]}_rep1" )  # echo "${name_1[${i}]}"
               name_2+=( "${to_merge[${i}]}_rep2" )  # echo "${name_2[${i}]}"

             in_1_std+=( "${d_dedup}/${name_1[${i}]}.standard-${max_mismatch_std}.${post}" )  # ., "${in_1_std[${i}]}"
             in_2_std+=( "${d_dedup}/${name_2[${i}]}.standard-${max_mismatch_std}.${post}" )  # ., "${in_2_std[${i}]}"

            in_1_rDNA+=( "${d_dedup}/${name_1[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}" )  # ., "${in_1_rDNA[${i}]}"
            in_2_rDNA+=( "${d_dedup}/${name_2[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}" )  # ., "${in_2_rDNA[${i}]}"

            [[ -f "${in_1_std[${i}]}" && -f "${in_2_std[${i}]}" ]] \
                || echo "Warning: \"Standard\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
                        d_merge="${d_dedup}"                                                   # echo "${d_dedup}"
               f_merge_pre_std+=( "${name_1[${i}]%_rep1}_repM.standard-${max_mismatch_std}" )  # echo "${f_merge_pre_std[${i}]}"
                   f_merge_std+=( "${f_merge_pre_std[${i}]}.${post}" )                         # echo "${f_merge_std[${i}]}"
                   a_merge_std+=( "${d_merge}/${f_merge_std[${i}]}" )                          # echo "${a_merge_std[${i}]}"

            #  For pairtools stats
                  d_merge_stats="06_stats"                                         # echo "${d_merge_stats[${i}]}"
             f_merge_stats_std+=( "${f_merge_pre_std[${i}]}.stats.txt" )           # echo "${f_merge_stats_std[${i}]}"
             a_merge_stats_std+=( "${d_merge_stats}/${f_merge_stats_std[${i}]}" )  # echo "${a_merge_stats_std[${i}]}"

            #  For cooler cload pairs
                  d_merge_cload="07_cload"                                         # echo "${d_merge_cload[${i}]}"
             f_merge_cload_std+=( "${f_merge_pre_std[${i}]}.cload.cool" )          # echo "${f_merge_cload_std}"
             a_merge_cload_std+=( "${d_merge_cload}/${f_merge_cload_std[${i}]}" )  # echo "${a_merge_cload_std}"

            #  For cooler zoomify
                   d_merge_zoom="08_zoom"                                           # echo "${d_merge_zoom[${i}]}"
              f_merge_zoom_std+=( "${f_merge_pre_std[${i}]}.mcool" )                # echo "${f_merge_zoom_std[${i}]}"
              a_merge_zoom_std+=( "${d_merge_zoom}/${f_merge_zoom_std[${i}]}" )     # echo "${a_merge_zoom_std[${i}]}"

            [[ -f "${in_1_rDNA[${i}]}" && -f "${in_2_rDNA[${i}]}" ]] \
                || echo "Warning: \"rDNA\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
                        d_merge="${d_dedup}"                                                   # echo "${d_dedup}"
              f_merge_pre_rDNA+=( "${name_1[${i}]%_rep1}_repM.keep-MM-${max_mismatch_rDNA}" )  # echo "${f_merge_pre_rDNA[${i}]}"
                  f_merge_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post}" )                        # echo "${f_merge_rDNA[${i}]}"
                  a_merge_rDNA+=( "${d_merge}/${f_merge_rDNA[${i}]}" )                         # echo "${a_merge_rDNA[${i}]}"

            #  For pairtools stats
                  d_merge_stats="06_stats"                                          # echo "${d_merge_stats}"
            f_merge_stats_rDNA+=( "${f_merge_pre_rDNA[${i}]}.stats.txt" )           # echo "${f_merge_stats_rDNA[${i}]}"
            a_merge_stats_rDNA+=( "${d_merge_stats}/${f_merge_stats_rDNA[${i}]}" )  # echo "${a_merge_stats_rDNA[${i}]}"

            #  For cooler cload pairs
                  d_merge_cload="07_cload"                                          # echo "${d_merge_cload}"
            f_merge_cload_rDNA+=( "${f_merge_pre_rDNA[${i}]}.cload.cool" )          # echo "${f_merge_cload_rDNA[${i}]}"
            a_merge_cload_rDNA+=( "${d_merge_cload}/${f_merge_cload_rDNA[${i}]}" )  # echo "${a_merge_cload_rDNA[${i}]}"

            #  For cooler zoomify
                   d_merge_zoom="08_zoom"                                         # echo "${d_merge_zoom}"
             f_merge_zoom_rDNA+=( "${f_merge_pre_rDNA[${i}]}.mcool"  )            # echo "${f_merge_zoom_rDNA[${i}]}"
             a_merge_zoom_rDNA+=( "${d_merge_zoom}/${f_merge_zoom_rDNA[${i}]}" )  # echo "${a_merge_zoom_std[${i}]}"
        done
    }
```
</details>
<br />

<a id="run-print-tests-for-pairtools-merge-variables-arrays"></a>
##### Run print tests for `pairtools merge` variables, arrays
<a id="code-13"></a>
###### Code
<details>
<summary><i>Code: Run print tests for pairtools merge variables, arrays</i></summary>

```bash
#!/bin/bash

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
            -------------------------------
                 d_merge_stats=${d_merge_stats}
             f_merge_stats_std=${f_merge_stats_std[${i}]}
             a_merge_stats_std=${a_merge_stats_std[${i}]}

            pairtools stats: rDNA
            -------------------------------
                 d_merge_stats=${d_merge_stats}
            f_merge_stats_rDNA=${f_merge_stats_rDNA[${i}]}
            a_merge_stats_rDNA=${a_merge_stats_rDNA[${i}]}

            cooler cload pairs: standard
            -------------------------------
                 d_merge_cload=${d_merge_cload}
             f_merge_cload_std=${f_merge_cload_std[${i}]}
             a_merge_cload_std=${a_merge_cload_std[${i}]}

            cooler cload pairs: rDNA
            -------------------------------
                 d_merge_cload=${d_merge_cload}
            f_merge_cload_rDNA=${f_merge_cload_rDNA[${i}]}
            a_merge_cload_rDNA=${a_merge_cload_rDNA[${i}]}

            For cooler zoomify: standard
            -------------------------------
                 d_merge_zoom=${d_merge_zoom}
             f_merge_zoom_std=${f_merge_zoom_std[${i}]}
             a_merge_zoom_std=${a_merge_zoom_std[${i}]}

            For cooler zoomify: rDNA
            -------------------------------
                 d_merge_zoom=${d_merge_zoom}
            f_merge_zoom_rDNA=${f_merge_zoom_rDNA[${i}]}
            a_merge_zoom_rDNA=${a_merge_zoom_rDNA[${i}]}
            """
        done
    }
```
</details>
<br />

<a id="initialize-varibales-arrays-for-standard-rdna-complete-processing"></a>
##### Initialize varibales, arrays for "`standard-rDNA-complete`" processing
<a id="code-14"></a>
###### Code
<details>
<summary><i>Code: Initialize varibales, arrays for "standard-rDNA-complete" processing</i></summary>

```bash
#!/bin/bash

#TODO Better organization, logic; remove ".," checks

#LOAD
#  X.A. -----------------------------------------------------------------------
#  Create a new array "${all[@]}" from "${stem[@]}" and, if
#+ "${to_merge[@]}" is not empty, then append "${to_merge[@]}" elements
#+ to "${all[@]}"
# post="nodups.pairs.gz"  # echo "${post}"  #DUPLICATE
d_comp="05_dedup"       # echo "${d_comp}"

unset                      all && typeset -a all
unset  all_dedup_pre_pairs_std && typeset -a all_dedup_pre_pairs_std

unset           f_comp_std_pre && typeset -a f_comp_std_pre
unset               f_comp_std && typeset -a f_comp_std
unset               a_comp_std && typeset -a a_comp_std

                             all+=( "${stem[@]}" )                              # echo_test "${all[@]}"                      # echo "${#all[@]}"

for (( i = 0; i < ${#stem[@]}; i++ )); do
        all_dedup_pre_pairs_std+=(
            "${d_comp}/${stem[${i}]}.standard-${max_mismatch_std}.${post}"
        )                                                                       # echo_test "${all_dedup_pre_pairs_std[@]}"  # echo "${#all_dedup_pre_pairs_std[@]}"
done

if [[ "${#to_merge[@]}" -ne 0 ]]; then
    for (( i = 0; i < ${#to_merge[@]}; i++ )); do
                            all+=( "${to_merge[${i}]}_repM" )                   # echo_test "${all[@]}"                      # echo "${#all[@]}"
        all_dedup_pre_pairs_std+=( "${a_merge_std[${i}]}" )                     # echo_test "${all_dedup_pre_pairs_std[@]}"  # echo "${#all_dedup_pre_pairs_std[@]}"
    done
fi

for (( i = 0; i < ${#all[@]}; i++ )); do
    f_comp_std_pre+=( "${all[${i}]}.standard-${max_mismatch_std}.no-rDNA" )     # echo_test "${f_comp_std_pre[@]}"
        f_comp_std+=( "${f_comp_std_pre[${i}]}.${post}" )                       # echo_test "${f_comp_std[@]}"
        a_comp_std+=( "${d_comp}/${f_comp_std[${i}]}" )                         # echo_test "${a_comp_std[@]}"
done


#  X.B. -----------------------------------------------------------------------
unset all_dedup_pre_pairs_rDNA && typeset -a all_dedup_pre_pairs_rDNA

unset          f_comp_rDNA_pre && typeset -a f_comp_rDNA_pre
unset              f_comp_rDNA && typeset -a f_comp_rDNA
unset              a_comp_rDNA && typeset -a a_comp_rDNA

for (( i = 0; i < ${#stem[@]}; i++ )); do
        all_dedup_pre_pairs_rDNA+=(
            "${d_comp}/${stem[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}"
        )                                                                       # echo_test "${all_dedup_pre_pairs_rDNA[@]}"  # echo "${#all_dedup_pre_pairs_rDNA[@]}"
done

if [[ "${#to_merge[@]}" -ne 0 ]]; then
    for (( i = 0; i < ${#to_merge[@]}; i++ )); do
        all_dedup_pre_pairs_rDNA+=( "${a_merge_rDNA[${i}]}" )                   # echo_test "${all_dedup_pre_pairs_rDNA[@]}"  # echo "${#all_dedup_pre_pairs_rDNA[@]}"
    done
fi

for (( i = 0; i < ${#all[@]}; i++ )); do
    f_comp_rDNA_pre+=( "${all[${i}]}.keep-MM-${max_mismatch_rDNA}.only-rDNA" )  # echo_test "${f_comp_rDNA_pre[@]}"
        f_comp_rDNA+=( "${f_comp_rDNA_pre[${i}]}.${post}" )                     # echo_test "${f_comp_rDNA[@]}"
        a_comp_rDNA+=( "${d_comp}/${f_comp_rDNA[${i}]}" )                       # echo_test "${a_comp_rDNA[@]}"
done


#  X.C. -----------------------------------------------------------------------
unset          a_comp_std_rhdr && typeset -a a_comp_std_rhdr
unset         a_comp_rDNA_rhdr && typeset -a a_comp_rDNA_rhdr
unset          a_comp_std_rDNA && typeset -a a_comp_std_rDNA
unset     a_comp_std_rDNA_sort && typeset -a a_comp_std_rDNA_sort
unset    a_comp_std_rDNA_cload && typeset -a a_comp_std_rDNA_cload

for (( i = 0; i < ${#all[@]}; i++ )); do
    a_comp_std_rhdr+=(
        "${a_comp_std[${i}]%.no-rDNA.nodups.pairs.gz}.no-rDNA.reheader.${post}"
    )  # echo_test "${a_comp_std_rhdr[@]}"
    a_comp_rDNA_rhdr+=(
        "${a_comp_rDNA[${i}]%.only-rDNA.nodups.pairs.gz}.only-rDNA.reheader.${post}"
    )  # echo_test "${a_comp_rDNA_rhdr[@]}"
    a_comp_std_rDNA+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.${post}"
    )  # echo_test "${a_comp_std_rDNA[@]}"
    a_comp_std_rDNA_sort+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.sort.${post}"
    )  # echo_test "${a_comp_std_rDNA[@]}"
    a_comp_std_rDNA_cload+=(
        "${d_cload}/$(basename ${a_comp_std[${i}]} .standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz).standard-rDNA-complete.cool"
    )  # echo_test "${a_comp_std_rDNA[@]}"
done


#  Run checks #TODO Better... -------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${all[@]}" && echo ""
        echo_test "${all_dedup_pre_pairs_std[@]}" && echo ""
        for i in "${all_dedup_pre_pairs_std[@]}"; do ., "${i}"; done
        echo ""

        echo_test "${f_comp_std_pre[@]}" && echo ""
        echo_test "${f_comp_std[@]}" && echo ""
        echo_test "${a_comp_std[@]}"
    }

run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${all[@]}" && echo ""
        echo_test "${all_dedup_pre_pairs_rDNA[@]}" && echo ""
        for i in "${all_dedup_pre_pairs_rDNA[@]}"; do ., "${i}"; done
        echo ""

        echo_test "${f_comp_rDNA_pre[@]}" && echo ""
        echo_test "${f_comp_rDNA[@]}" && echo ""
        echo_test "${a_comp_rDNA[@]}"
    }

run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${a_comp_std_rhdr[@]}" && echo ""
        echo_test "${a_comp_rDNA_rhdr[@]}" && echo ""
        echo_test "${a_comp_std_rDNA[@]}" && echo ""
        echo_test "${a_comp_std_rDNA_sort[@]}" && echo ""
        echo_test "${a_comp_std_rDNA_cload[@]}"
    }
```
</details>
<br />

<a id="create-outdirectories-if-not-present"></a>
##### Create outdirectories if not present
<a id="code-15"></a>
###### Code
<details>
<summary><i>Code: Create outdirectories if not present</i></summary>

```bash
#!/bin/bash

 [[ ! -d "${d_trim}"  ]] && mkdir -p  "${d_trim}/err_out"
[[  ! -d "${d_bam}"   ]] && mkdir -p   "${d_bam}/err_out"
[[  ! -d "${d_pairs}" ]] && mkdir -p "${d_pairs}/err_out"
 [[ ! -d "${d_sort}"  ]] && mkdir -p  "${d_sort}/err_out"
[[  ! -d "${d_stats}" ]] && mkdir -p "${d_stats}/err_out"
[[  ! -d "${d_dedup}" ]] && mkdir -p "${d_dedup}/err_out"
[[  ! -d "${d_cload}" ]] && mkdir -p "${d_cload}/err_out"
 [[ ! -d "${d_zoom}"  ]] && mkdir -p  "${d_zoom}/err_out"
```
</details>
<br />

<a id="1-trim-fastq-files"></a>
### 1. Trim `fastq` files
<a id="code-16"></a>
#### Code
<details>
<summary><i>Code: 1. Trim fastq files</i></summary>

```bash
#!/bin/bash

print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=0

            [[
                     -f "${a_fq_1[${i}]}" \
                &&   -f "${a_fq_2[${i}]}" \
                && ! -f "${a_afq_1[${i}]}" \
                && ! -f "${a_afq_2[${i}]}"
            ]] &&
                {
                    job_name="${d_trim}.${stem[${i}]}"

                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=${job_name}
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error="${d_trim}/err_out/${job_name}.%A.stderr.txt"
                    #SBATCH --output="${d_trim}/err_out/${job_name}.%A.stdout.txt"

                    \"\${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/Atria/app-3.2.2/bin/atria\" \\
                        -t \"${threads}\" \\
                        -r \"${a_fq_1[${i}]}\" \\
                        -R \"${a_fq_2[${i}]}\" \\
                        -o \"${d_trim}\" \\
                        --no-length-filtration

                    #  Store logs in err_out/
                    if compgen -G ${d_trim}/*.{log,log.json} > /dev/null; then
                        mv ${d_trim}/*.{log,log.json} "${d_trim}/err_out"
                    fi
                    EOF
                    """
                } ||
                echo "Trimmed fastqs exist; skipping \"Step #1: Trim fastq files\""
                #TODO Update this message
        done
    }


#  Perform adapter trimming of fastqs with Atria
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=0

            [[
                     -f "${a_fq_1[${i}]}" \
                &&   -f "${a_fq_2[${i}]}" \
                && ! -f "${a_afq_1[${i}]}" \
                && ! -f "${a_afq_2[${i}]}"
            ]] &&
                {                    
                    job_name="${d_trim}.${stem[${i}]}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_trim}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_trim}/err_out/${job_name}.%A.stdout.txt"

"${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/Atria/app-3.2.2/bin/atria" \
    -t "${threads}" \
    -r "${a_fq_1[${i}]}" \
    -R "${a_fq_2[${i}]}" \
    -o "${d_trim}" \
    --no-length-filtration

#  Store logs in err_out/
if compgen -G ${d_trim}/*.{log,log.json} > /dev/null; then
    mv ${d_trim}/*.{log,log.json} "${d_trim}/err_out"
fi
EOF
                } ||
                echo "Trimmed fastqs exist; skipping \"Step #1: Trim fastq files\""
                #TODO Update this message
        done
    }

#TODO 1/2 Get rid of globs associated compgen and mv, i.e., be explicit about
#TODO 2/2 the files to check and move
```
</details>
<br />

<a id="2-align-datasets"></a>
### 2. Align datasets
<a id="code-17"></a>
#### Code
<details>
<summary><i>Code: 2. Align datasets</i></summary>

```bash
#!/bin/bash

[[ $(command -v bwa > /dev/null) ]] ||
    {
        module purge
        ml BWA/0.7.17-GCCcore-11.2.0 SAMtools/1.16.1-GCC-11.2.0
    }


#  These calls to bwa mem and samtools are incorrect --------------------------
#  pairtools parse expects bams unsorted after bwa mem alignment, which are in
#+ QNAME order, so *don't* run the following chunk, which sees the bwa mem
#+ stream piped to samtools sort for coordinate-based sorting; more info:
#+ github.com/open2c/pairtools/issues/178#issuecomment-1554866847
do_not_do=TRUE
[[ "${do_not_do}" == FALSE ]] &&
    {
        {
            bwa mem \
                -t "${threads}" \
                -SP "${a_index}" "${a_fq_1}" "${a_fq_2}" \
                    | samtools sort \
                        -@ ${threads} \
                        -O bam \
                        -o "${a_bam}"

            if [[ -f "${a_bam}" ]]; then
                samtools index \
                    -@ "${threads}" \
                    "${a_bam}"
            fi
        } \
            2> >(tee -a "${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt" >&2)
    }


#  These calls to bwa mem and samtools are correct ----------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ ! -f "${a_bam[${i}]}" ]] &&
                {
                    job_name="${d_bam}.${stem[${i}]}"

echo """
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"

bwa mem \\
    -t \"${threads}\" \\
    -SP \\
    \"${a_index}\" \\
    \"${a_afq_1[${i}]}\" \\
    \"${a_afq_2[${i}]}\" \\
        | samtools view \\
            -@ ${threads} \\
            -S -b \\
                > \"${a_bam[${i}]}\"

if [[ -f \"${a_bam}\" ]]; then
    samtools index \\
        -@ ${threads} \\
        \"${a_bam[${i}]}\"
fi
EOF
"""
                } ||
                echo "bam exists; skipping \"Step #2: Align datasets\""
        done
    }

#  Run the calls to bwa mem and samtools
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ ! -f "${a_bam[${i}]}" ]] &&
                {
                    job_name="${d_bam}.${stem[${i}]}"
        
# echo """
# #HEREDOC
# sbatch << EOF
# #!/bin/bash
#
# #SBATCH --job-name=${job_name}
# #SBATCH --nodes=1
# #SBATCH --cpus-per-task=${threads}
# #SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
# #SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"
#
# bwa mem \\
#     -t \"${threads}\" \\
#     -SP \\
#     \"${a_index}\" \\
#     \"${a_afq_1[${i}]}\" \\
#     \"${a_afq_2[${i}]}\" \\
#         | samtools view \\
#             -@ ${threads} \\
#             -S -b \\
#                 > \"${a_bam[${i}]}\"
#
# if [[ -f \"${a_bam}\" ]]; then
#     samtools index \\
#         -@ ${threads} \\
#         \"${a_bam[${i}]}\"
# fi
# EOF
# """

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"

bwa mem \
    -t "${threads}" \
    -SP \
    "${a_index}" \
    "${a_afq_1[${i}]}" \
    "${a_afq_2[${i}]}" \
        | samtools view \
            -@ ${threads} \
            -S -b \
                > "${a_bam[${i}]}"

if [[ -f "${a_bam}" ]]; then
    samtools index \
        -@ ${threads} \
        "${a_bam[${i}]}"
fi
EOF
                } ||
                echo "bam exists; skipping \"Step #2: Align datasets\""
        done
    }
```
</details>
<br />

<a id="3-run-pairtools-parse2"></a>
### 3. Run `pairtools parse2`
<a id="code-18"></a>
#### Code
<details>
<summary><i>Code: 3. Run pairtools parse</i></summary>

```bash
#!/bin/bash

#  Check the documentation ====================================================
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        pairtools parse --help
        pairtools parse2 --help
    }


#  Do a trial run of pairtools parse ==========================================
#+ However, no longer using parse and, instead, using parse2 (see below)
do_not_do=TRUE
[[ "${do_not_do}" == FALSE && -f "${a_bam}" ]] &&
    {
        echo """
        pairtools parse \\
            -o \"${a_pairs}\" \\
            -c \"${a_size}\" \\
            --drop-sam \\
            --drop-seq \\
            --output-stats \"${a_stats}\" \\
            --assembly \"${assembly}\" \\
            --no-flip \\
            --add-columns mapq \\
            --walks-policy mask \\
            \"${a_bam}\" \\
                2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).stderr.txt\" >&2)
        """
    }

do_not_do=TRUE
[[ "${do_not_do}" == FALSE && -f "${a_bam}" ]] &&
    {
        pairtools parse \
            -o "${a_pairs}" \
            -c "${a_size}" \
            --drop-sam \
            --drop-seq \
            --output-stats "${a_stats}" \
            --assembly "${assembly}" \
            --no-flip \
            --add-columns mapq \
            --walks-policy mask \
            "${a_bam}" \
                2> >(tee -a "${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).stderr.txt" >&2)
    }


#  Run of pairtools parse2 ====================================================
print_example_call=FALSE
[[ "${print_example_call}" ]] &&
    {
        echo """
        #  Example call: github.com/open2c/pairtools/issues/159
        #+ See also github.com/open2c/pairtools/issues/176
        pairtools parse2 \\
            --min-mapq 30 \\
            --report-position read \\
            --report-orientation read \\
            --add-pair-index \\
            --add-columns pos5,pos3 \\
            --max-inter-align-gap 30 \\
            --nproc-in 16 \\
            --nproc-out 16 \\
            --chroms-path /data/kun/Align_Index/grch38_no_alt/hg38.genome \\
            test.sam \\
                > test.pairsam
        """
    }


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE && -f "${a_bam}" ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ ! -f "${a_pairs_std[${i}]}" ]] &&
                {
                    job_name="${d_pairs}.${f_pairs_std[${i}]%.txt.gz}"  # echo "${job_name}"

echo """
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_pairs}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_pairs}/err_out/${job_name}.%A.stdout.txt"

pairtools parse2 \\
    -o \"${a_pairs_std[${i}]}\" \\
    -c \"${a_size}\" \\
    --report-position outer \\
    --report-orientation pair \\
    --assembly \"${assembly}\" \\
    --dedup-max-mismatch \"${max_mismatch_std}\" \\
    --min-mapq \"${min_mapq_std}\" \\
    --expand \\
    --add-pair-index \\
    --no-flip \\
    --add-columns pos5,pos3,mapq \\
    --drop-seq \\
    --drop-sam \\
    --output-stats \"${a_stats_std[${i}]}\" \\
    --nproc-in \"${threads}\" \\
    --nproc-out \"${threads}\" \\
    \"${a_bam[${i}]}\"
EOF
"""
                }  

            [[ ! -f "${a_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="${d_pairs}.${f_pairs_rDNA[${i}]%.txt.gz}"  # echo "${job_name}"

echo """
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_pairs}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_pairs}/err_out/${job_name}.%A.stdout.txt"

pairtools parse2 \\
    -o \"${a_pairs_rDNA[${i}]}\" \\
    -c \"${a_size}\" \\
    --report-position outer \\
    --report-orientation pair \\
    --assembly \"${assembly}\" \\
    --dedup-max-mismatch \"${max_mismatch_rDNA}\" \\
    --min-mapq \"${min_mapq_rDNA}\" \\
    --expand \\
    --add-pair-index \\
    --no-flip \\
    --add-columns pos5,pos3,mapq \\
    --drop-seq \\
    --drop-sam \\
    --output-stats \"${a_stats_rDNA[${i}]}\" \\
    --nproc-in \"${threads}\" \\
    --nproc-out \"${threads}\" \\
    \"${a_bam[${i}]}\"
EOF
"""
                } ||
                echo "rDNA pairs file exists; skipping \"Step #3: Run pairtools parse2\""
        done
    } ||
    {
        echo "Warning: \"Step #3: Run pairtools parse\" did not run"
        echo "Stopping the operation"
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE && -f "${a_bam}" ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ ! -f "${a_pairs_std[${i}]}" ]] &&
                {
                    job_name="${d_pairs}.${f_pairs_std[${i}]%.txt.gz}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_pairs}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_pairs}/err_out/${job_name}.%A.stdout.txt"

pairtools parse2 \
    -o "${a_pairs_std[${i}]}" \
    -c "${a_size}" \
    --report-position outer \
    --report-orientation pair \
    --assembly "${assembly}" \
    --dedup-max-mismatch "${max_mismatch_std}" \
    --min-mapq "${min_mapq_std}" \
    --expand \
    --add-pair-index \
    --no-flip \
    --add-columns pos5,pos3,mapq \
    --drop-seq \
    --drop-sam \
    --output-stats "${a_stats_std[${i}]}" \
    --nproc-in "${threads}" \
    --nproc-out "${threads}" \
    "${a_bam[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "Standard pairs file exists; skipping \"Step #3: Run pairtools parse2\""


            [[ ! -f "${a_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="${d_pairs}.${f_pairs_rDNA[${i}]%.txt.gz}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_pairs}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_pairs}/err_out/${job_name}.%A.stdout.txt"

pairtools parse2 \
    -o "${a_pairs_rDNA[${i}]}" \
    -c "${a_size}" \
    --report-position outer \
    --report-orientation pair \
    --assembly "${assembly}" \
    --dedup-max-mismatch "${max_mismatch_rDNA}" \
    --min-mapq "${min_mapq_rDNA}" \
    --expand \
    --add-pair-index \
    --no-flip \
    --add-columns pos5,pos3,mapq \
    --drop-seq \
    --drop-sam \
    --output-stats "${a_stats_rDNA[${i}]}" \
    --nproc-in "${threads}" \
    --nproc-out "${threads}" \
    "${a_bam[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "rDNA pairs file exists; skipping \"Step #3: Run pairtools parse2\""
        done
    } ||
    {
        echo "Warning: \"Step #3: Run pairtools parse\" did not run"
        echo "Stopping the operation"
    }


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
               
    } ||
    {
        echo "Warning: \"run_check\" for pairs outfiles did not run;"
        echo "         pairs files not found"
        echo "Stopping the operation"
    }


#  Examine the stats outfile ==================================================
run_check=TRUE  #UNTESTED
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
    } ||
    {
        echo "Warning: \"run_check\" for stats outfile did not run;"
        echo "         stats files not found"
        echo "Stopping the operation"
    }
```
</details>
<br />

<a id="4-run-pairtools-sort"></a>
### 4. Run `pairtools sort`
<a id="code-19"></a>
#### Code
<details>
<summary><i>Code: 4. Run pairtools sort</i></summary>

```bash
#!/bin/bash

#  Check the documentation ====================================================
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        pairtools sort --help
    }


#  Run pairtools sort =========================================================
#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_pairs_std[${i}]}" && ! -f "${a_sort_std[${i}]}" ]] &&
                {
                    job_name="${d_sort}.${f_sort_std[${i}]%.sort.txt.gz}"  # echo "${job_name}"

echo """
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_sort}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_sort}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \\
    --nproc \"${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort_std[${i}]}\" \\
    \"${a_pairs_std[${i}]}\"
EOF
"""
                } ||
                echo "Sorted standard pairs file exists; skipping \"Step #3: Run pairtools sort\""

            [[ -f "${a_pairs_rDNA[${i}]}" && ! -f "${a_sort_rDNA[${i}]}" ]] &&
                {
                    job_name="${d_sort}.${f_sort_rDNA[${i}]%.sort.txt.gz}"  # echo "${job_name}"

echo """
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_sort}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_sort}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \\
    --nproc \"${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort_rDNA[${i}]}\" \\
    \"${a_pairs_rDNA[${i}]}\"
EOF
"""
                } ||
                echo "Sorted rDNA pairs file exists; skipping \"Step #3: Run pairtools sort\""
        done
    } ||
    {
        echo "Warning: \"Step #4: Run pairtools sort\" did not run"
        echo "Stopping the operation"
    }


#  Submit pairtools sort jobs to SLURM ----------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_pairs_std[${i}]}" && ! -f "${a_sort_std[${i}]}" ]] &&
                {
                    job_name="${d_sort}.${f_sort_std[${i}]%.sort.txt.gz}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_sort}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_sort}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort_std[${i}]}" \
    "${a_pairs_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "Sorted standard pairs file exists; skipping "Step #3: Run pairtools sort""

            [[ -f "${a_pairs_rDNA[${i}]}" && ! -f "${a_sort_rDNA[${i}]}" ]] &&
                {
                    job_name="${d_sort}.${f_sort_rDNA[${i}]%.sort.txt.gz}"  # echo "${job_name}"

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_sort}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_sort}/err_out/${job_name}.%A.stdout.txt"

pairtools sort \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort_rDNA[${i}]}" \
    "${a_pairs_rDNA[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "Sorted rDNA pairs file exists; skipping \"Step #3: Run pairtools sort\""
        done
    } ||
    {
        echo "Warning: \"Step #4: Run pairtools sort\" did not run"
        echo "Stopping the operation"
    }


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
        echo "Warning: \"run_check\" for sort outfiles did not run;"
        echo "         Sort files not found"
        echo "Stopping the operation..."
    }
```
</details>
<br />

<a id="5-run-pairtools-dedup-and-pairtools-split"></a>
### 5. Run `pairtools dedup` and `pairtools split`
<a id="code-20"></a>
#### Code
<details>
<summary><i>Code: Run pairtools dedup and pairtools split</i></summary>

```bash
#!/bin/bash

#  Run pairtools dedup ========================================================
#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dedup_pre_pairs_std[${i}]}" ]] &&
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
                        --output-stats \"${a_dedup_stats[${i}]}\" \\
                        \"${a_sort_std[${i}]}\"
                    EOF
                    """
                } ||
                echo "Standard dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" ]] &&
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

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dedup_pre_pairs_std[${i}]}" ]] &&
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
    --output-stats "${a_dedup_stats[${i}]}" \
    "${a_sort_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo "Standard dedup files exist; skipping \"Step #5: Run pairtools dedup and pairtools split\""

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" ]] &&
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
    --output >(pairtools split --output-pairs "${a_dedup_pre_pairs_rDNA[${i}]}") \
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
```
</details>
<br />

<a id="x-run-pairtools-merge-if-applicable"></a>
### X. Run `pairtools merge` if applicable
<a id="code-21"></a>
#### Code
<details>
<summary><i>Code: Run pairtools merge if applicable</i></summary>

```bash
#!/bin/bash

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


#  Submit jobs to SLURM -------------------------------------------------------
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
```
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

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            ., "${all_dedup_pre_pairs_std[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${a_comp_std[${i}]}"
        done
    }


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

                    pairtools select \\
                        \"((chrom1 != 'XII' and chrom2 != 'XII') or (chrom1 == 'XII' and chrom2 != 'XII' and (int(pos51) < 451526 or int(pos51) > 468980)) or (chrom2 == 'XII' and chrom1 != 'XII' and (int(pos31) < 451526 or int(pos31) > 468980)) or (chrom1 == 'XII' and chrom2 == 'XII' and (int(pos51) < 451526 or int(pos51) > 468980) and (int(pos31) < 451526 or int(pos31) > 468980)))\" \\
                        \"${all_dedup_pre_pairs_std[${i}]}\" \\
                        -o \"${a_comp_std[${i}]}\"
                    EOF
                    """
                }
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
# "(
#     (
#         chrom1 != 'XII' \
#         and \
#         chrom2 != 'XII'
#     ) \
#     or \
#     (
#         chrom1 == 'XII' \
#         and \
#         chrom2 != 'XII' \
#         and \
#         (int(pos51) < 451526 or int(pos51) > 468980)
#     ) \
#     or \
#     (
#         chrom2 == 'XII' \
#         and \
#         chrom1 != 'XII' \
#         and \
#         (int(pos31) < 451526 or int(pos31) > 468980)
#     ) \
#     or \
#     (
#         chrom1 == 'XII' \
#         and \
#         chrom2 == 'XII' \
#         and \
#         (int(pos51) < 451526 or int(pos51) > 468980) \
#         and \
#         (int(pos31) < 451526 or int(pos31) > 468980)
#     )
# )"

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

pairtools select \
    "((chrom1 != 'XII' and chrom2 != 'XII') or (chrom1 == 'XII' and chrom2 != 'XII' and (int(pos51) < 451526 or int(pos51) > 468980)) or (chrom2 == 'XII' and chrom1 != 'XII' and (int(pos31) < 451526 or int(pos31) > 468980)) or (chrom1 == 'XII' and chrom2 == 'XII' and (int(pos51) < 451526 or int(pos51) > 468980) and (int(pos31) < 451526 or int(pos31) > 468980)))" \
    "${all_dedup_pre_pairs_std[${i}]}" \
    -o "${a_comp_std[${i}]}"
EOF
                    sleep 0.2
                }
        done
    }
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

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            ., "${all_dedup_pre_pairs_rDNA[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${f_comp_rDNA_pre[${i}]}"
        done
    }


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

                    pairtools select \\
                        \"((chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) or (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980))\" \\
                        \"${all_dedup_pre_pairs_rDNA[${i}]}\" \\
                        -o \"${a_comp_rDNA[${i}]}\"
                    EOF
                    """
                }
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
"(
    (chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) \
    or \
    (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980)
)"
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

pairtools select \
    "((chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) or (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980))" \
    "${all_dedup_pre_pairs_rDNA[${i}]}" \
    -o "${a_comp_rDNA[${i}]}"
EOF
                    sleep 0.2
                }
        done
    }
```
</details>
<br />

<a id="c-merge-the-standardnodups-and-keep-mmnodups-files"></a>
#### C. Merge the "`standard.nodups`" and "`keep-MM.nodups`" files
<a id="code-24"></a>
##### Code
<details>
<summary><i>Code: C. Merge the "standard.nodups" and "keep-MM.nodups" files</i></summary>

```bash
#!/bin/bash

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # echo "${a_comp_std[${i}]}"
            ., "${a_comp_std[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            # echo "${a_comp_rDNA[${i}]}"
            ., "${a_comp_rDNA[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${a_comp_std_rDNA[${i}]}"
        done
    }


#  Run print tests ------------------------------------------------------------
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


#  Submit jobs to SLURM -------------------------------------------------------
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

<a id="6-run-pairtools-stats"></a>
### 6. Run `pairtools stats`
<a id="individual-pairs-files"></a>
#### Individual pairs files
<a id="code-25"></a>
##### Code
<details>
<summary><i>Code: 6. Run pairtools stats</i></summary>

```bash
#!/bin/bash

#TODO #LOWERPRIORITY Update/refactor

#  Do a trial run of pairtools stats ------------------------------------------
run=TRUE
[[ 
    "${run}" == TRUE && \
        -f "${a_dedup_pre_pairs}" && \
        -f "${a_dup_pre_pairs}" && \
        -f "${a_unmap_pre_pairs}" 
]] &&
    {
        pairtools stats \
            -o "${a_dedup_pre_pairs_stats}" \
            "${a_dedup_pre_pairs}"
        
        pairtools stats \
            -o "${a_dup_pre_pairs_stats}" \
            "${a_dup_pre_pairs}"

        pairtools stats \
            -o "${a_unmap_pre_pairs_stats}" \
            "${a_unmap_pre_pairs}"
    }
```
</details>
<br />

<a id="7-load-pairs-to-cooler"></a>
### 7. Load pairs to cooler
<a id="individual-pairs-file"></a>
#### Individual pairs file
<a id="code-26"></a>
##### Code
<details>
<summary><i>Code: 7. Load pairs to cooler</i></summary>

```bash
#!/bin/bash

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            ., "${a_comp_std_rDNA[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${a_comp_std_rDNA_cload[${i}]}"
        done
    }


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

            [[
                     -f "${a_comp_std_rDNA[${i}]}" \
                && ! -f "${a_comp_std_rDNA_cload[${i}]}"
            ]] &&
                {
                    job_name="cload.$(basename "${a_comp_std_rDNA_cload[${i}]}" .cool)"  # echo "${job_name}"

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
                    sleep 0.2
                }
        done
    }
```
</details>
<br />

<a id="8-generate-a-multi-resolution-cooler-by-coarsening"></a>
### 8. Generate a multi-resolution cooler by coarsening
<a id="cools-from-individual-pairs-files"></a>
#### Cools from individual pairs files
<a id="code-27"></a>
##### Code
<details>
<summary><i>Code: 8. Generate a multi-resolution cooler by coarsening</i></summary>

```bash
#!/bin/bash

#TODO Move initialization to an appropriate spot in Step #0
unset a_comp_std_rDNA_zoom && typeset -a a_comp_std_rDNA_zoom

for (( i = 0; i < ${#all[@]}; i++ )); do
    # echo "${a_comp_std_rDNA_cload[${i}]}"
    a_comp_std_rDNA_zoom+=( "${d_zoom}/$(basename ${a_comp_std_rDNA_cload[${i}]} .cool).mcool" )
done
# echo_test "${a_comp_std_rDNA_zoom[@]}"


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            
            [[
                     -f "${a_comp_std_rDNA_cload[${i}]}" \
                && ! -f "${a_comp_std_rDNA_zoom[${i}]}"
            ]] &&
                {
                    job_name="zoom.$(basename "${a_comp_std_rDNA_zoom[${i}]}" .mcool)"  # echo "${job_name}"
                    
                    echo """
                    #HEREDOC
                    sbatch << EOF
                    #!/bin/bash

                    #SBATCH --job-name=\"${job_name}\"
                    #SBATCH --nodes=1
                    #SBATCH --cpus-per-task=${threads}
                    #SBATCH --error=\"${d_zoom}/err_out/${job_name}.%A.stderr.txt\"
                    #SBATCH --output=\"${d_zoom}/err_out/${job_name}.%A.stdout.txt\"

                    cooler zoomify \\
                        --out \"${a_comp_std_rDNA_zoom[${i}]}\" \\
                        --nproc ${threads} \\
                        --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
                        --balance \\
                        --balance-args '--max-iters 2000' \\
                        \"${a_comp_std_rDNA_cload[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo "Warning: Either the infile was not found or the outfile already exists"
                    echo "         Stopping the operation"
                }
        done
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            
            [[
                     -f "${a_comp_std_rDNA_cload[${i}]}" \
                && ! -f "${a_comp_std_rDNA_zoom[${i}]}"
            ]] &&
                {
                    job_name="zoom.$(basename "${a_comp_std_rDNA_zoom[${i}]}" .mcool)"  # echo "${job_name}"
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_zoom}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_zoom}/err_out/${job_name}.%A.stdout.txt"

cooler zoomify \
    --out "${a_comp_std_rDNA_zoom[${i}]}" \
    --nproc ${threads} \
    --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
    --balance \
    --balance-args '--max-iters 2000' \
    "${a_comp_std_rDNA_cload[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo "Warning: Either the infile was not found or the outfile already exists"
                    echo "         Stopping the operation"
                }
        done
    }
```
</details>
<br />

<a id="9-ingest-files-for-higlass"></a>
### 9. Ingest files for HiGlass
<a id="code-28"></a>
#### Code
<details>
<summary><i>Code: Ingest files for HiGlass</i></summary>

```bash
#!/bin/bash

#  Run on WorkMac (local)
run_check=FALSE
[[ "${run_check}" == TRUE ]] &&
    {
        docker exec higlass-container python higlass-server/manage.py

        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --help
    }


#  Load mcool files: This is work for quick, rough-draft assessments ----------
rough_Q=FALSE
[[ "${rough_Q}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR7939018.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_G1=FALSE
[[ "${rough_G1}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR11893107.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_G2_M=FALSE
[[ ${rough_G2_M} == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR11893084-SRR11893085.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

#  Test my "${rough_G2_M}" .mcool against the publicly available .mcool
rough_G2_M_GSE151553=TRUE
[[ ${rough_G2_M_GSE151553} == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/GSE151553_A364_merged.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_size=FALSE
[[ "${rough_size}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/S288C_reference_sequence_R64-3-1_20210421.size \
                --filetype chromsizes-tsv \
                --datatype chromsizes

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_Q_rDNA=TRUE
[[ "${rough_Q_rDNA}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR7939018.standard-rDNA.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }


#  Work, 2023-0807 ------------------------------------------------------------
conda activate chromatin_env

#  Initialize function for ingesting mcool files
ingest_mcool() {
    docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename "/data/${1}" \
                --filetype cooler \
                --datatype matrix
}


aggregate_bed() {
    clodius aggregate bedfile \
        --assembly "sacCer3" \
        --output-file "${1/bed/db}" \
        --chromsizes-filename "${2:-S288C_reference_sequence_R64-3-1_20210421.size}" \
        "${1}"
}


ingest_bed() {
    docker exec higlass-container \
        python higlass-server/manage.py ingest_tileset \
           --filename "/data/${1}" \
           --filetype beddb \
           --datatype bedlike \
           --coordSystem sacCer3
}


export -f load_mcool
export -f aggregate_bed
export -f ingest_bed


#  Ingest "updated" mcool files
updated_Q=FALSE
updated_G2M=FALSE
updated_G1=FALSE
[[ "${updated_Q}" == TRUE ]] \
    && ingest_mcool MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
[[ "${updated_G2M}" == TRUE ]] \
    && ingest_mcool MC-2020_nz_WT_repM.standard-rDNA-complete.mcool
[[ "${updated_G1}" == TRUE ]] \
    && ingest_mcool MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool


#  Aggregate and ingest gene track file
agg_rep_coding_ncRNA=FALSE
[[ "${agg_rep_coding_ncRNA}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

ing_rep_coding_ncRNA=FALSE
[[ "${ing_rep_coding_ncRNA}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.db
    #ACCIDENT #DELETE #TODO
    # && ingest_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

agg_rep_coding_non_pancRNA=FALSE
[[ "${agg_rep_coding_non_pancRNA}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.bed

ing_rep_coding_non_pancRNA=FALSE
[[ "${ing_rep_coding_non_pancRNA}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.db

agg_rep_coding_noncoding=FALSE
[[ "${agg_rep_coding_noncoding}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-non-coding-transcriptome.bed

ing_rep_coding_noncoding=FALSE
[[ "${ing_rep_coding_noncoding}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-non-coding-transcriptome.db

agg_S_cerevisiae_gene=TRUE
[[ "${agg_S_cerevisiae_gene}" == TRUE ]] \
    && aggregate_bed Saccharomyces_cerevisiae.R64-1-1.108.gene.bed

ing_S_cerevisiae_gene=TRUE
[[ "${ing_S_cerevisiae_gene}" == TRUE ]] \
    && ingest_bed Saccharomyces_cerevisiae.R64-1-1.108.gene.db

run_check=TRUE
[[ "${run_check}" == TRUE ]] && curl http://localhost:8888/api/v1/tilesets/


#  Work, 2023-0713, 2023-0807 -------------------------------------------------
docker exec higlass-container \
    python higlass-server/manage.py --help

docker exec higlass-container \
    python higlass-server/manage.py ingest_tileset --help

clodius --help

clodius aggregate --help

clodius aggregate bedfile --help

clodius aggregate bedgraph --help

clodius aggregate bedfile \
    --output-file "${outfile}" \
    --assembly "${assembly}" \

#  Step #1: Convert gtfs of interest into beds
gtf2bed \
    < Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf \
    > Greenlaw-et-al_non-collapsed-non-coding-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-non-coding-transcriptome.gtf \
    > Greenlaw-et-al_representative-non-coding-transcriptome.bed

gtf2bed \
    < processed_features-intergenic_sense-antisense.gtf \
    > processed_features-intergenic_sense-antisense.bed

gtf2bed \
    < processed_features-intergenic_sense.gtf \
    > processed_features-intergenic_sense.bed

cat Saccharomyces_cerevisiae.R64-1-1.108.gtf \
    | awk '{ if ($0 ~ "transcript_id") print $0; else print $0" transcript_id \"\";"; }' \
    | gtf2bed - \
        > Saccharomyces_cerevisiae.R64-1-1.108.bed

#IMPORTANT (2023-0807)
cat Saccharomyces_cerevisiae.R64-1-1.108.bed \
    | awk '{ if ($8 ~ "gene") { print $0 } }' \
        > Saccharomyces_cerevisiae.R64-1-1.108.gene.bed

cat Saccharomyces_cerevisiae.R64-1-1.108.bed | head

#  Step #2: Aggregate bed files for use with HiGlass
clodius aggregate bedfile \
    --assembly "sacCer3" \
    --output-file Saccharomyces_cerevisiae.R64-1-1.108.db \
    --chromsizes-filename S288C_reference_sequence_R64-3-1_20210421.size \
    Saccharomyces_cerevisiae.R64-1-1.108.bed

#  Step #3: Ingest the aggregated bed files
docker exec higlass-container \
    python higlass-server/manage.py ingest_tileset \
       --filename /data/Saccharomyces_cerevisiae.R64-1-1.108.db \
       --filetype beddb \
       --datatype bedlike \
       --coordSystem sacCer3

rough_gene_track=TRUE
[[ "${rough_gene_track}" == TRUE ]] &&
    {

    }
```
</details>
<br />
