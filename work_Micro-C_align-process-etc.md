
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
            1. [Printed](#printed)
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
        1. [A. ...for `nodups` pairs](#a-for-nodups-pairs)
            1. [Code](#code-20)
        1. [B. ...for `dups` pairs](#b-for-dups-pairs)
            1. [Code](#code-21)
    1. [X. General strategy](#x-general-strategy)
        1. [Notes](#notes-1)
    1. [X. Create `*.keep-MM-0.mapped.pairs.gz files` if applicable](#x-create-keep-mm-0mappedpairsgz-files-if-applicable)
        1. [Code](#code-22)
    1. [X. Run `pairtools merge` if applicable](#x-run-pairtools-merge-if-applicable)
        1. [A. ...for `nodups` pairs](#a-for-nodups-pairs-1)
            1. [Code](#code-23)
        1. [B. ...for `mapped` pairs](#b-for-mapped-pairs)
            1. [Code](#code-24)
    1. [X. Run "`standard-rDNA-complete`" processing if applicable](#x-run-standard-rdna-complete-processing-if-applicable)
        1. [A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file](#a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file)
            1. [Code](#code-25)
        1. [B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM-?`" file](#b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mm--file)
            1. [i. ...for `nodups` pairs](#i-for-nodups-pairs)
                1. [Code](#code-26)
            1. [ii. ...for `mapped` pairs](#ii-for-mapped-pairs)
                1. [Code](#code-27)
        1. [C. Merge the "`standard.nodups`" and "`keep-MM-?.nodups`" files](#c-merge-the-standardnodups-and-keep-mm-nodups-files)
            1. [i. ...with "rDNA" `nodups` pairs](#i-with-rdna-nodups-pairs)
                1. [Code](#code-28)
            1. [ii. ...with "rDNA" `mapped` pairs](#ii-with-rdna-mapped-pairs)
                1. [Code](#code-29)
    1. [6. Run `pairtools stats`](#6-run-pairtools-stats)
        1. [Individual pairs files](#individual-pairs-files)
            1. [Code](#code-30)
    1. [7. Load pairs to cooler](#7-load-pairs-to-cooler)
        1. [A. ...containing "rDNA" `nodups` pairs](#a-containing-rdna-nodups-pairs)
            1. [Code](#code-31)
        1. [B. ...containing "rDNA" `mapped` pairs](#b-containing-rdna-mapped-pairs)
            1. [Code](#code-32)
    1. [8. Generate a multi-resolution cooler by coarsening](#8-generate-a-multi-resolution-cooler-by-coarsening)
        1. [A. ...containing "rDNA" `nodups` pairs](#a-containing-rdna-nodups-pairs-1)
            1. [Code](#code-33)
        1. [B. ...containing "rDNA" `mapped` pairs](#b-containing-rdna-mapped-pairs-1)
            1. [Code](#code-34)

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
            r-argparse \
            r-ggsci \
            r-plotly \
            r-tidyverse
fi

install_env_ARM=TRUE
if [[ "${install_env_ARM}" == TRUE ]]; then
    env_name="pairtools_env"
    CONDA_SUBDIR=osx-64 \
    mamba create \
        -n "${env_name}" \
        -c conda-forge \
            parallel

    mamba activate "${env_name}"

    CONDA_SUBDIR=osx-64 \
    mamba install \
        -c bioconda \
            bioframe \
            cooler \
            coolpuppy \
            cooltools \
            pairtools \
            rename \
            bioconductor-genomicinteractions \
            bioconductor-genomicranges \
            bioconductor-gviz \
            bioconductor-interactionset

    CONDA_SUBDIR=osx-64 \
    mamba install \
        -c conda-forge \
            pbzip2 \
            pigz \
            r-argparse \
            r-ggsci \
            r-plotly \
            r-tidyverse
fi
```
</details>
<br />

<a id="printed"></a>
##### Printed
<details>
<summary><i>Printed: Install mamba packages (ARM, KrisMac)</i></summary>

```txt
❯     CONDA_SUBDIR=osx-64 \
>     mamba create \
>         -n "${env_name}" \
>         -c conda-forge \
>             parallel

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.25.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel']

pkgs/main/osx-64                                              No change
pkgs/r/osx-64                                                 No change
bioconda/osx-64                                               No change
bioconda/noarch                                               No change
conda-forge/noarch                                            No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
conda-forge/osx-64                                  30.4MB @   4.6MB/s  7.6s
Transaction

  Prefix: /Users/kalavattam/miniconda3/envs/pairtools_env

  Updating specs:

   - parallel


  Package      Version  Build             Channel                Size
───────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────

  + parallel  20230722  h694c41f_0        conda-forge/osx-64      2MB
  + perl        5.32.1  4_h0dc2134_perl5  conda-forge/osx-64     12MB

  Summary:

  Install: 2 packages

  Total download: 14MB

───────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
parallel                                             1.9MB @   4.9MB/s  0.4s
perl                                                12.5MB @  17.4MB/s  0.7s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate pairtools_env

To deactivate an active environment, use

     $ mamba deactivate


❯ conda activate "${env_name}"


❯     CONDA_SUBDIR=osx-64 \
>     mamba install \
>         -c bioconda \
>             bioframe \
>             cooler \
>             coolpuppy \
>             cooltools \
>             pairtools \
>             rename \
>             bioconductor-genomicinteractions \
>             bioconductor-genomicranges \
>             bioconductor-gviz \
>             bioconductor-interactionset

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.25.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['bioframe', 'cooler', 'coolpuppy', 'cooltools', 'pairtools', 'rename', 'bioconductor-genomicinteractions', 'bioconductor-genomicranges', 'bioconductor-gviz', 'bioconductor-interactionset']

bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
pkgs/main/osx-64                                              No change
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
Transaction

  Prefix: /Users/kalavattam/miniconda3/envs/pairtools_env

  Updating specs:

   - bioframe
   - cooler
   - coolpuppy
   - cooltools
   - pairtools
   - rename
   - bioconductor-genomicinteractions
   - bioconductor-genomicranges
   - bioconductor-gviz
   - bioconductor-interactionset


  Package                                   Version  Build                   Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                                  1.0.1  anacondar_1             conda-forge/noarch     Cached
  + aom                                       3.5.0  hf0c8a7f_0              conda-forge/osx-64        3MB
  + argcomplete                               3.1.1  pyhd8ed1ab_0            conda-forge/noarch       39kB
  + asciitree                                 0.3.3  py_2                    conda-forge/noarch     Cached
  + aws-c-auth                                0.7.3  h1fca4dd_3              conda-forge/osx-64       90kB
  + aws-c-cal                                 0.6.2  h03343b3_0              conda-forge/osx-64       40kB
  + aws-c-common                              0.9.0  h0dc2134_0              conda-forge/osx-64      180kB
  + aws-c-compression                        0.2.17  hc1c6d78_2              conda-forge/osx-64       18kB
  + aws-c-event-stream                        0.3.2  hf265e0f_0              conda-forge/osx-64       47kB
  + aws-c-http                               0.7.12  h572c275_1              conda-forge/osx-64      164kB
  + aws-c-io                                0.13.32  hc0caee9_2              conda-forge/osx-64      136kB
  + aws-c-mqtt                                0.9.5  h54c5ab7_1              conda-forge/osx-64      139kB
  + aws-c-s3                                 0.3.14  hab1dffe_3              conda-forge/osx-64       75kB
  + aws-c-sdkutils                           0.1.12  hc1c6d78_1              conda-forge/osx-64       47kB
  + aws-checksums                            0.1.17  hc1c6d78_1              conda-forge/osx-64       49kB
  + aws-crt-cpp                              0.23.0  hf409f0c_5              conda-forge/osx-64      275kB
  + aws-sdk-cpp                             1.10.57  hcbc40b4_21             conda-forge/osx-64        3MB
  + bioconductor-annotationdbi               1.62.2  r43hdfd78af_0           bioconda/noarch           5MB
  + bioconductor-annotationfilter            1.24.0  r43hdfd78af_0           bioconda/noarch         561kB
  + bioconductor-biobase                     2.60.0  r43h4c50009_0           bioconda/osx-64           3MB
  + bioconductor-biocfilecache                2.8.0  r43hdfd78af_0           bioconda/noarch         591kB
  + bioconductor-biocgenerics                0.46.0  r43hdfd78af_0           bioconda/noarch         655kB
  + bioconductor-biocio                      1.10.0  r43hdfd78af_0           bioconda/noarch         469kB
  + bioconductor-biocparallel                1.34.2  r43hc0ef7c4_0           bioconda/osx-64           2MB
  + bioconductor-biomart                     2.56.1  r43hdfd78af_0           bioconda/noarch         927kB
  + bioconductor-biostrings                  2.68.1  r43h4c50009_0           bioconda/osx-64          14MB
  + bioconductor-biovizbase                  1.48.0  r43h4c50009_0           bioconda/osx-64           3MB
  + bioconductor-bsgenome                    1.68.0  r43hdfd78af_0           bioconda/noarch           7MB
  + bioconductor-data-packages             20230718  hdfd78af_1              bioconda/noarch         188kB
  + bioconductor-delayedarray                0.26.6  r43h4c50009_0           bioconda/osx-64           2MB
  + bioconductor-ensembldb                   2.24.0  r43hdfd78af_0           bioconda/noarch           4MB
  + bioconductor-genomeinfodb                1.36.1  r43hdfd78af_0           bioconda/noarch           4MB
  + bioconductor-genomeinfodbdata            1.2.10  r43hdfd78af_0           bioconda/noarch           8kB
  + bioconductor-genomicalignments           1.36.0  r43h4c50009_0           bioconda/osx-64           2MB
  + bioconductor-genomicfeatures             1.52.1  r43hdfd78af_0           bioconda/noarch           2MB
  + bioconductor-genomicinteractions         1.34.0  r43hdfd78af_0           bioconda/noarch           4MB
  + bioconductor-genomicranges               1.52.0  r43h4c50009_0           bioconda/osx-64           2MB
  + bioconductor-gviz                        1.44.0  r43hdfd78af_0           bioconda/noarch           7MB
  + bioconductor-interactionset              1.28.1  r43hc0ef7c4_0           bioconda/osx-64           2MB
  + bioconductor-iranges                     2.34.1  r43h4c50009_0           bioconda/osx-64           3MB
  + bioconductor-keggrest                    1.40.0  r43hdfd78af_0           bioconda/noarch         202kB
  + bioconductor-matrixgenerics              1.12.2  r43hdfd78af_0           bioconda/noarch         471kB
  + bioconductor-protgenerics                1.32.0  r43hdfd78af_0           bioconda/noarch         249kB
  + bioconductor-rhtslib                      2.2.0  r43h4c50009_0           bioconda/osx-64           2MB
  + bioconductor-rsamtools                   2.16.0  r43hc0ef7c4_0           bioconda/osx-64           4MB
  + bioconductor-rtracklayer                 1.60.0  r43h4c50009_0           bioconda/osx-64           6MB
  + bioconductor-s4arrays                     1.0.4  r43h4c50009_0           bioconda/osx-64         796kB
  + bioconductor-s4vectors                   0.38.1  r43h4c50009_0           bioconda/osx-64           3MB
  + bioconductor-summarizedexperiment        1.30.2  r43hdfd78af_0           bioconda/noarch           2MB
  + bioconductor-variantannotation           1.46.0  r43h4c50009_0           bioconda/osx-64           4MB
  + bioconductor-xvector                     0.40.0  r43h4c50009_0           bioconda/osx-64         749kB
  + bioconductor-zlibbioc                    1.46.0  r43h4c50009_0           bioconda/osx-64          24kB
  + bioframe                                  0.4.1  pyhdfd78af_0            bioconda/noarch         100kB
  + biopython                                  1.81  py39ha30fb19_0          conda-forge/osx-64        3MB
  + blosc                                    1.21.4  heccf04b_0              conda-forge/osx-64       50kB
  + bokeh                                     3.2.2  pyhd8ed1ab_0            conda-forge/noarch        5MB
  + brotli                                    1.0.9  hb7f2c08_9              conda-forge/osx-64       20kB
  + brotli-bin                                1.0.9  hb7f2c08_9              conda-forge/osx-64       18kB
  + brotli-python                             1.0.9  py39h7a8716b_9          conda-forge/osx-64      351kB
  + brunsli                                     0.1  h046ec9c_0              conda-forge/osx-64      183kB
  + bwidget                                  1.9.14  h694c41f_1              conda-forge/osx-64     Cached
  + bzip2                                     1.0.8  h0d85af4_4              conda-forge/osx-64     Cached
  + c-ares                                   1.19.1  h0dc2134_0              conda-forge/osx-64     Cached
  + c-blosc2                                 2.10.2  h0dcb076_0              conda-forge/osx-64      286kB
  + ca-certificates                       2023.7.22  h8857fd0_0              conda-forge/osx-64      150kB
  + cached-property                           1.5.2  hd8ed1ab_1              conda-forge/noarch        4kB
  + cached_property                           1.5.2  pyha770c72_1            conda-forge/noarch     Cached
  + cairo                                    1.16.0  h09dd18c_1016           conda-forge/osx-64     Cached
  + cctools_osx-64                          973.0.1  ha1c5b94_14             conda-forge/osx-64        1MB
  + certifi                               2023.7.22  pyhd8ed1ab_0            conda-forge/noarch      154kB
  + charls                                    2.4.2  he965462_0              conda-forge/osx-64      138kB
  + charset-normalizer                        3.2.0  pyhd8ed1ab_0            conda-forge/noarch       46kB
  + clang                                    16.0.6  hc177806_1              conda-forge/osx-64       21kB
  + clang-16                                 16.0.6  default_h762fdd7_1      conda-forge/osx-64      693kB
  + clang_osx-64                             16.0.6  h8787910_1              conda-forge/osx-64       21kB
  + clangxx                                  16.0.6  default_h762fdd7_1      conda-forge/osx-64       21kB
  + clangxx_osx-64                           16.0.6  h1b7723c_1              conda-forge/osx-64       20kB
  + click                                     8.1.7  unix_pyh707e725_0       conda-forge/noarch       84kB
  + cloudpickle                               2.2.1  pyhd8ed1ab_0            conda-forge/noarch       28kB
  + compiler-rt                              16.0.6  he1888fc_0              conda-forge/osx-64     Cached
  + compiler-rt_osx-64                       16.0.6  he1888fc_0              conda-forge/noarch     Cached
  + contourpy                                 1.1.0  py39h8ee36c8_0          conda-forge/osx-64      215kB
  + cooler                                    0.9.2  pyh7cba7a3_0            bioconda/noarch          85kB
  + coolpuppy                                 1.1.0  pyh086e186_0            bioconda/noarch          45kB
  + cooltools                                 0.5.4  py39hc889f67_2          bioconda/osx-64         300kB
  + coreutils                                  8.25  1                       bioconda/osx-64           2MB
  + curl                                      8.2.1  h5f667d7_0              conda-forge/osx-64      147kB
  + cycler                                   0.11.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + cytoolz                                  0.12.2  py39hdc70f33_0          conda-forge/osx-64      317kB
  + dask                                   2023.8.1  pyhd8ed1ab_0            conda-forge/noarch        7kB
  + dask-core                              2023.8.1  pyhd8ed1ab_0            conda-forge/noarch      856kB
  + dav1d                                     1.2.1  h0dc2134_0              conda-forge/osx-64      668kB
  + dill                                      0.3.7  pyhd8ed1ab_0            conda-forge/noarch       88kB
  + distributed                            2023.8.1  pyhd8ed1ab_0            conda-forge/noarch      782kB
  + docutils                                 0.20.1  py39h6e9494a_0          conda-forge/osx-64      707kB
  + expat                                     2.5.0  hf0c8a7f_1              conda-forge/osx-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0              conda-forge/noarch     Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0              conda-forge/noarch     Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0              conda-forge/noarch     Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0              conda-forge/noarch     Cached
  + fontconfig                               2.14.2  h5bb23bf_0              conda-forge/osx-64     Cached
  + fonts-conda-ecosystem                         1  0                       conda-forge/noarch     Cached
  + fonts-conda-forge                             1  0                       conda-forge/noarch     Cached
  + fonttools                                4.42.1  py39hdc70f33_0          conda-forge/osx-64        2MB
  + freetype                                 2.12.1  h3f81eb7_1              conda-forge/osx-64     Cached
  + fribidi                                  1.0.10  hbcb3906_0              conda-forge/osx-64     Cached
  + fsspec                                 2023.6.0  pyh1a96a4e_0            conda-forge/noarch      118kB
  + gettext                                  0.21.1  h8a4c099_0              conda-forge/osx-64     Cached
  + gflags                                    2.2.2  hb1e8313_1004           conda-forge/osx-64       95kB
  + gfortran_impl_osx-64                     12.3.0  h54fd467_1              conda-forge/osx-64       21MB
  + gfortran_osx-64                          12.3.0  h18f7dce_1              conda-forge/osx-64       35kB
  + giflib                                    5.2.1  hb7f2c08_3              conda-forge/osx-64       77kB
  + glog                                      0.6.0  h8ac2a54_0              conda-forge/osx-64      101kB
  + glpk                                        5.0  h3cb5acd_0              conda-forge/osx-64     Cached
  + gmp                                       6.2.1  h2e338ed_0              conda-forge/osx-64     Cached
  + graphite2                                1.3.13  h2e338ed_1001           conda-forge/osx-64     Cached
  + gsl                                         2.7  h93259b0_0              conda-forge/osx-64     Cached
  + h5py                                      3.9.0  nompi_py39h95d806b_101  conda-forge/osx-64      986kB
  + h5sparse                                  0.1.0  pyh086e186_0            bioconda/noarch          12kB
  + harfbuzz                                  7.3.0  h413ba03_0              conda-forge/osx-64     Cached
  + hdf5                                     1.14.1  nompi_hedada53_100      conda-forge/osx-64        4MB
  + htslib                                     1.18  h365c357_0              bioconda/osx-64           2MB
  + icu                                        72.1  h7336db1_0              conda-forge/osx-64     Cached
  + idna                                        3.4  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + imagecodecs                           2023.8.12  py39hfc0e906_0          conda-forge/osx-64        2MB
  + imageio                                  2.31.1  pyh24c5eb1_0            conda-forge/noarch      290kB
  + importlib-metadata                        6.8.0  pyha770c72_0            conda-forge/noarch       26kB
  + importlib-resources                       6.0.1  pyhd8ed1ab_0            conda-forge/noarch       10kB
  + importlib_metadata                        6.8.0  hd8ed1ab_0              conda-forge/noarch        9kB
  + importlib_resources                       6.0.1  pyhd8ed1ab_0            conda-forge/noarch       31kB
  + isl                                        0.25  hb486fe8_0              conda-forge/osx-64     Cached
  + jinja2                                    3.1.2  pyhd8ed1ab_1            conda-forge/noarch     Cached
  + joblib                                    1.3.2  pyhd8ed1ab_0            conda-forge/noarch      221kB
  + jq                                          1.5  0                       bioconda/osx-64        Cached
  + jxrlib                                      1.1  h35c211d_2              conda-forge/osx-64      231kB
  + kiwisolver                                1.4.5  py39h8ee36c8_0          conda-forge/osx-64       61kB
  + krb5                                     1.21.2  hb884880_0              conda-forge/osx-64        1MB
  + lazy_loader                                 0.3  pyhd8ed1ab_0            conda-forge/noarch       14kB
  + lcms2                                      2.15  h2dcdeff_1              conda-forge/osx-64      228kB
  + ld64_osx-64                                 609  ha20a434_14             conda-forge/osx-64        1MB
  + lerc                                      4.0.0  hb486fe8_0              conda-forge/osx-64     Cached
  + libabseil                            20230125.3  cxx17_h000cb23_0        conda-forge/osx-64        1MB
  + libaec                                    1.0.6  hf0c8a7f_1              conda-forge/osx-64     Cached
  + libarrow                                 13.0.0  ha268fe5_0_cpu          conda-forge/osx-64       20MB
  + libavif                                  0.11.1  h22361c6_2              conda-forge/osx-64       95kB
  + libblas                                   3.9.0  17_osx64_openblas       conda-forge/osx-64     Cached
  + libbrotlicommon                           1.0.9  hb7f2c08_9              conda-forge/osx-64       70kB
  + libbrotlidec                              1.0.9  hb7f2c08_9              conda-forge/osx-64       32kB
  + libbrotlienc                              1.0.9  hb7f2c08_9              conda-forge/osx-64      279kB
  + libcblas                                  3.9.0  17_osx64_openblas       conda-forge/osx-64     Cached
  + libclang-cpp16                           16.0.6  default_h762fdd7_1      conda-forge/osx-64       13MB
  + libcrc32c                                 1.1.2  he49afe7_0              conda-forge/osx-64       20kB
  + libcurl                                   8.2.1  h5f667d7_0              conda-forge/osx-64      354kB
  + libcxx                                   16.0.6  hd57cbcb_0              conda-forge/osx-64     Cached
  + libdeflate                                 1.18  hac1461d_0              conda-forge/osx-64     Cached
  + libedit                            3.1.20191231  h0678c8f_2              conda-forge/osx-64     Cached
  + libev                                      4.33  haf1e3a3_1              conda-forge/osx-64     Cached
  + libevent                                 2.1.12  ha90c15b_1              conda-forge/osx-64      373kB
  + libexpat                                  2.5.0  hf0c8a7f_1              conda-forge/osx-64     Cached
  + libffi                                    3.4.2  h0d85af4_5              conda-forge/osx-64     Cached
  + libgcc                                    4.8.5  1                       conda-forge/osx-64     Cached
  + libgfortran                               5.0.0  12_3_0_h97931a8_1       conda-forge/osx-64      133kB
  + libgfortran-devel_osx-64                 12.3.0  h0b6f5ec_1              conda-forge/noarch      454kB
  + libgfortran5                             12.3.0  hbd3c1fe_1              conda-forge/osx-64        2MB
  + libglib                                  2.76.4  hc62aa5d_0              conda-forge/osx-64        2MB
  + libgoogle-cloud                          2.12.0  h37a168a_1              conda-forge/osx-64       33MB
  + libgrpc                                  1.56.2  he6801ca_1              conda-forge/osx-64        4MB
  + libiconv                                   1.17  hac89ed1_0              conda-forge/osx-64     Cached
  + libjpeg-turbo                           2.1.5.1  hb7f2c08_0              conda-forge/osx-64     Cached
  + liblapack                                 3.9.0  17_osx64_openblas       conda-forge/osx-64     Cached
  + libllvm14                                14.0.6  hc8e404f_4              conda-forge/osx-64       22MB
  + libllvm16                                16.0.6  he4b1e75_2              conda-forge/osx-64       25MB
  + libnghttp2                               1.52.0  he2ab024_0              conda-forge/osx-64     Cached
  + libopenblas                              0.3.23  openmp_h429af6e_0       conda-forge/osx-64     Cached
  + libpng                                   1.6.39  ha978bb4_0              conda-forge/osx-64     Cached
  + libprotobuf                              4.23.3  h5feb325_0              conda-forge/osx-64        2MB
  + libsqlite                                3.43.0  h58db7d2_0              conda-forge/osx-64      891kB
  + libssh2                                  1.11.0  hd019ec5_0              conda-forge/osx-64     Cached
  + libthrift                                0.18.1  h88b220a_2              conda-forge/osx-64      324kB
  + libtiff                                   4.5.1  hf955e92_1              conda-forge/osx-64      393kB
  + libutf8proc                               2.8.0  hb7f2c08_0              conda-forge/osx-64       99kB
  + libwebp-base                              1.3.1  h0dc2134_0              conda-forge/osx-64      346kB
  + libxcb                                     1.15  hb7f2c08_0              conda-forge/osx-64      314kB
  + libxml2                                  2.11.5  hd95e348_0              conda-forge/osx-64      623kB
  + libzlib                                  1.2.13  h8a1eda9_5              conda-forge/osx-64     Cached
  + libzopfli                                 1.0.3  h046ec9c_0              conda-forge/osx-64      162kB
  + llvm-openmp                              16.0.6  hff08bdf_0              conda-forge/osx-64     Cached
  + llvm-tools                               16.0.6  he4b1e75_2              conda-forge/osx-64       22MB
  + llvmlite                                 0.40.1  py39hc281fc9_0          conda-forge/osx-64      257kB
  + locket                                    1.0.0  pyhd8ed1ab_0            conda-forge/noarch        8kB
  + lz4                                       4.3.2  py39hd0af75a_0          conda-forge/osx-64       33kB
  + lz4-c                                     1.9.4  hf0c8a7f_0              conda-forge/osx-64     Cached
  + m2r2                                0.3.3.post2  pyhd8ed1ab_0            conda-forge/noarch       16kB
  + make                                        4.3  h22f3db7_1              conda-forge/osx-64     Cached
  + markupsafe                                2.1.3  py39hdc70f33_0          conda-forge/osx-64       23kB
  + matplotlib-base                           3.7.2  py39h6e39af2_0          conda-forge/osx-64        7MB
  + mistune                                   0.8.4  pyh1a96a4e_1006         conda-forge/noarch       48kB
  + more-itertools                           10.1.0  pyhd8ed1ab_0            conda-forge/noarch       54kB
  + mpc                                       1.3.1  h81bd1dd_0              conda-forge/osx-64     Cached
  + mpfr                                      4.2.0  h4f9bd69_0              conda-forge/osx-64     Cached
  + msgpack-python                            1.0.5  py39h92daf61_0          conda-forge/osx-64       77kB
  + multiprocess                            0.70.15  py39hdc70f33_0          conda-forge/osx-64      237kB
  + multiprocessing-logging                   0.3.3  pyhd8ed1ab_0            conda-forge/noarch       13kB
  + munkres                                   1.0.7  py_1                    bioconda/noarch        Cached
  + natsort                                   8.4.0  pyhd8ed1ab_0            conda-forge/noarch       37kB
  + ncurses                                     6.4  hf0c8a7f_0              conda-forge/osx-64     Cached
  + networkx                                    3.1  pyhd8ed1ab_0            conda-forge/noarch        1MB
  + numba                                    0.57.1  py39hb7a5252_0          conda-forge/osx-64        4MB
  + numexpr                                   2.8.4  py39h11b3245_1          conda-forge/osx-64      122kB
  + numpy                                    1.23.5  py39hdfa1d0c_0          conda-forge/osx-64        6MB
  + openjpeg                                  2.5.0  h13ac156_2              conda-forge/osx-64      330kB
  + openssl                                   3.1.2  h8a1eda9_0              conda-forge/osx-64        2MB
  + orc                                       1.9.0  hef23039_1              conda-forge/osx-64      441kB
  + packaging                                  23.1  pyhd8ed1ab_0            conda-forge/noarch       46kB
  + pairix                                    0.3.7  py39h66c2135_4          bioconda/osx-64         100kB
  + pairtools                                 0.3.0  py39h33ca528_6          bioconda/osx-64         162kB
  + pandas                                    1.5.3  py39hecff1ad_1          conda-forge/osx-64       11MB
  + pandoc                                    3.1.3  h9d075a6_0              conda-forge/osx-64       16MB
  + pango                                   1.50.14  hbce5e75_1              conda-forge/osx-64     Cached
  + partd                                     1.4.0  pyhd8ed1ab_0            conda-forge/noarch       20kB
  + patsy                                     0.5.3  pyhd8ed1ab_0            conda-forge/noarch      194kB
  + pbgzip                               2016.08.04  h652314c_4              bioconda/osx-64          31kB
  + pcre2                                     10.40  h1c4e4bc_0              conda-forge/osx-64     Cached
  + pillow                                   10.0.0  py39he6683de_0          conda-forge/osx-64       46MB
  + pip                                      23.2.1  pyhd8ed1ab_0            conda-forge/noarch        1MB
  + pixman                                   0.40.0  hbcb3906_0              conda-forge/osx-64     Cached
  + platformdirs                             3.10.0  pyhd8ed1ab_0            conda-forge/noarch       20kB
  + pooch                                     1.7.0  pyha770c72_3            conda-forge/noarch       51kB
  + psutil                                    5.9.5  py39ha30fb19_0          conda-forge/osx-64      366kB
  + pthread-stubs                               0.4  hc929b4f_1001           conda-forge/osx-64     Cached
  + py-cpuinfo                                9.0.0  pyhd8ed1ab_0            conda-forge/noarch       25kB
  + pyarrow                                  13.0.0  py39h9aa5c8a_0_cpu      conda-forge/osx-64        4MB
  + pyfaidx                                 0.7.2.1  pyh7cba7a3_1            bioconda/noarch          33kB
  + pyparsing                                 3.0.9  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + pysam                                    0.21.0  py39hba326fb_1          bioconda/osx-64           4MB
  + pysocks                                   1.7.1  pyha2e5f31_6            conda-forge/noarch     Cached
  + pytables                                  3.8.0  py39h91e7277_2          conda-forge/osx-64        2MB
  + python                                   3.9.18  h07e1443_0_cpython      conda-forge/osx-64       11MB
  + python-dateutil                           2.8.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + python_abi                                  3.9  3_cp39                  conda-forge/osx-64        6kB
  + pytz                                     2023.3  pyhd8ed1ab_0            conda-forge/noarch      187kB
  + pyvcf3                                    1.0.3  pyhdfd78af_0            bioconda/noarch         980kB
  + pywavelets                                1.4.1  py39h7cc1f47_0          conda-forge/osx-64        4MB
  + pyyaml                                    6.0.1  py39hdc70f33_0          conda-forge/osx-64      163kB
  + r-askpass                                   1.1  r43h6dc245f_4           conda-forge/osx-64       29kB
  + r-assertthat                              0.2.1  r43hc72bb7e_4           conda-forge/noarch       72kB
  + r-backports                               1.4.1  r43h6dc245f_2           conda-forge/osx-64      108kB
  + r-base                                    4.3.1  had2b78c_3              conda-forge/osx-64       25MB
  + r-base64enc                               0.1_3  r43h6dc245f_1006        conda-forge/osx-64       44kB
  + r-bh                                   1.81.0_1  r43hc72bb7e_1           conda-forge/noarch       11MB
  + r-bit                                     4.0.5  r43h6dc245f_1           conda-forge/osx-64        1MB
  + r-bit64                                   4.0.5  r43h6dc245f_2           conda-forge/osx-64      504kB
  + r-bitops                                  1.0_7  r43h6dc245f_2           conda-forge/osx-64       43kB
  + r-blob                                    1.2.4  r43hc72bb7e_1           conda-forge/noarch       66kB
  + r-bslib                                   0.5.1  r43hc72bb7e_0           conda-forge/noarch        5MB
  + r-cachem                                  1.0.8  r43h6dc245f_1           conda-forge/osx-64       74kB
  + r-checkmate                               2.2.0  r43h6dc245f_1           conda-forge/osx-64      667kB
  + r-cli                                     3.6.1  r43hac7d2d5_1           conda-forge/osx-64        1MB
  + r-cluster                                 2.1.4  r43hfe07776_1           conda-forge/osx-64      574kB
  + r-codetools                              0.2_19  r43hc72bb7e_1           conda-forge/noarch      108kB
  + r-colorspace                              2.1_0  r43h6dc245f_1           conda-forge/osx-64        3MB
  + r-cpp11                                   0.4.6  r43hc72bb7e_0           conda-forge/noarch      231kB
  + r-crayon                                  1.5.2  r43hc72bb7e_2           conda-forge/noarch      164kB
  + r-curl                                    5.0.2  r43h0100ac3_0           conda-forge/osx-64      450kB
  + r-data.table                             1.14.8  r43h7eccc33_2           conda-forge/osx-64        2MB
  + r-dbi                                     1.1.3  r43hc72bb7e_2           conda-forge/noarch      721kB
  + r-dbplyr                                  2.3.3  r43hc72bb7e_0           conda-forge/noarch        1MB
  + r-deldir                                  1.0_9  r43hfe07776_1           conda-forge/osx-64      304kB
  + r-dichromat                             2.0_0.1  r43ha770c72_2           conda-forge/noarch      161kB
  + r-digest                                 0.6.33  r43hac7d2d5_0           conda-forge/osx-64      194kB
  + r-dplyr                                   1.1.2  r43hac7d2d5_1           conda-forge/osx-64        1MB
  + r-ellipsis                                0.3.2  r43h6dc245f_2           conda-forge/osx-64       42kB
  + r-evaluate                                 0.21  r43hc72bb7e_1           conda-forge/noarch       89kB
  + r-fansi                                   1.0.4  r43h6dc245f_1           conda-forge/osx-64      308kB
  + r-farver                                  2.1.1  r43hac7d2d5_2           conda-forge/osx-64        1MB
  + r-fastmap                                 1.1.1  r43hac7d2d5_1           conda-forge/osx-64       71kB
  + r-filelock                                1.0.2  r43h6dc245f_1004        conda-forge/osx-64       29kB
  + r-fontawesome                             0.5.2  r43hc72bb7e_0           conda-forge/noarch        1MB
  + r-foreign                                0.8_84  r43h6dc245f_1           conda-forge/osx-64      263kB
  + r-formatr                                  1.14  r43hc72bb7e_1           conda-forge/noarch      165kB
  + r-formula                                 1.2_5  r43hc72bb7e_1           conda-forge/noarch      174kB
  + r-fs                                      1.6.3  r43hac7d2d5_0           conda-forge/osx-64      277kB
  + r-futile.logger                           1.4.3  r43hc72bb7e_1005        conda-forge/noarch      105kB
  + r-futile.options                          1.0.1  r43hc72bb7e_1004        conda-forge/noarch       29kB
  + r-generics                                0.1.3  r43hc72bb7e_2           conda-forge/noarch       91kB
  + r-ggplot2                                 3.4.3  r43hc72bb7e_0           conda-forge/noarch        3MB
  + r-glue                                    1.6.2  r43h6dc245f_2           conda-forge/osx-64      151kB
  + r-gridextra                                 2.3  r43hc72bb7e_1005        conda-forge/noarch        1MB
  + r-gtable                                  0.3.4  r43hc72bb7e_0           conda-forge/noarch      222kB
  + r-highr                                    0.10  r43hc72bb7e_1           conda-forge/noarch       58kB
  + r-hmisc                                   5.1_0  r43hfe07776_1           conda-forge/osx-64        3MB
  + r-hms                                     1.1.3  r43hc72bb7e_1           conda-forge/noarch      107kB
  + r-htmltable                               2.4.1  r43hc72bb7e_2           conda-forge/noarch      406kB
  + r-htmltools                               0.5.6  r43hac7d2d5_0           conda-forge/osx-64      357kB
  + r-htmlwidgets                             1.6.2  r43hc72bb7e_1           conda-forge/noarch      423kB
  + r-httr                                    1.4.7  r43hc72bb7e_0           conda-forge/noarch      468kB
  + r-igraph                                  1.5.1  r43hedd5883_0           conda-forge/osx-64        4MB
  + r-interp                                  1.1_4  r43ha1020dc_1           conda-forge/osx-64        2MB
  + r-isoband                                 0.2.7  r43hac7d2d5_2           conda-forge/osx-64        2MB
  + r-jpeg                                   0.1_10  r43he6a093d_3           conda-forge/osx-64       52kB
  + r-jquerylib                               0.1.4  r43hc72bb7e_2           conda-forge/noarch      305kB
  + r-jsonlite                                1.8.7  r43h6dc245f_0           conda-forge/osx-64      631kB
  + r-knitr                                    1.43  r43hc72bb7e_1           conda-forge/noarch        1MB
  + r-labeling                                0.4.3  r43hc72bb7e_0           conda-forge/noarch       69kB
  + r-lambda.r                                1.2.4  r43hc72bb7e_3           conda-forge/noarch      119kB
  + r-lattice                                0.21_8  r43h6dc245f_1           conda-forge/osx-64        1MB
  + r-latticeextra                           0.6_30  r43hc72bb7e_2           conda-forge/noarch        2MB
  + r-lazyeval                                0.2.2  r43h6dc245f_4           conda-forge/osx-64      156kB
  + r-lifecycle                               1.0.3  r43hc72bb7e_2           conda-forge/noarch      122kB
  + r-magrittr                                2.0.3  r43h6dc245f_2           conda-forge/osx-64      207kB
  + r-mass                                   7.3_60  r43h6dc245f_1           conda-forge/osx-64        1MB
  + r-matrix                                  1.6_1  r43hc46c21c_0           conda-forge/osx-64        4MB
  + r-matrixstats                             1.0.0  r43h6dc245f_1           conda-forge/osx-64      466kB
  + r-memoise                                 2.0.1  r43hc72bb7e_2           conda-forge/noarch       56kB
  + r-mgcv                                    1.9_0  r43h9c380c6_0           conda-forge/osx-64        3MB
  + r-mime                                     0.12  r43h6dc245f_2           conda-forge/osx-64       52kB
  + r-munsell                                 0.5.0  r43hc72bb7e_1006        conda-forge/noarch      244kB
  + r-nlme                                  3.1_163  r43hfe07776_0           conda-forge/osx-64        2MB
  + r-nnet                                   7.3_19  r43h6dc245f_1           conda-forge/osx-64      135kB
  + r-openssl                                 2.0.6  r43hc61a7e2_1           conda-forge/osx-64      632kB
  + r-pillar                                  1.9.0  r43hc72bb7e_1           conda-forge/noarch      617kB
  + r-pkgconfig                               2.0.3  r43hc72bb7e_3           conda-forge/noarch       26kB
  + r-plogr                                   0.2.0  r43hc72bb7e_1005        conda-forge/noarch       22kB
  + r-png                                     0.1_8  r43h9ae9e50_1           conda-forge/osx-64       59kB
  + r-prettyunits                             1.1.1  r43hc72bb7e_3           conda-forge/noarch       42kB
  + r-progress                                1.2.2  r43hc72bb7e_4           conda-forge/noarch       92kB
  + r-purrr                                   1.0.2  r43h6dc245f_0           conda-forge/osx-64      483kB
  + r-r6                                      2.5.1  r43hc72bb7e_2           conda-forge/noarch       90kB
  + r-rappdirs                                0.3.3  r43h6dc245f_2           conda-forge/osx-64       51kB
  + r-rcolorbrewer                            1.1_3  r43h785f33e_2           conda-forge/noarch       68kB
  + r-rcpp                                   1.0.11  r43hac7d2d5_0           conda-forge/osx-64        2MB
  + r-rcppeigen                           0.3.3.9.3  r43hfaea39f_1           conda-forge/osx-64        1MB
  + r-rcurl                               1.98_1.12  r43h0100ac3_3           conda-forge/osx-64      816kB
  + r-restfulr                               0.0.15  r43hfa19939_3           bioconda/osx-64         448kB
  + r-rjson                                  0.2.21  r43hac7d2d5_3           conda-forge/osx-64      157kB
  + r-rlang                                   1.1.1  r43hac7d2d5_1           conda-forge/osx-64        2MB
  + r-rmarkdown                                2.24  r43hc72bb7e_0           conda-forge/noarch        2MB
  + r-rpart                                  4.1.19  r43h6dc245f_1           conda-forge/osx-64      933kB
  + r-rsqlite                                 2.3.1  r43hac7d2d5_1           conda-forge/osx-64        1MB
  + r-rstudioapi                             0.15.0  r43hc72bb7e_0           conda-forge/noarch      295kB
  + r-sass                                    0.4.7  r43hac7d2d5_0           conda-forge/osx-64        2MB
  + r-scales                                  1.2.1  r43hc72bb7e_2           conda-forge/noarch      595kB
  + r-snow                                    0.4_4  r43hc72bb7e_2           conda-forge/noarch      115kB
  + r-stringi                                1.7.12  r43hf939c12_2           conda-forge/osx-64      855kB
  + r-stringr                                 1.5.0  r43h785f33e_1           conda-forge/noarch      296kB
  + r-survival                                3.5_7  r43h6dc245f_0           conda-forge/osx-64        6MB
  + r-sys                                     3.4.2  r43h6dc245f_1           conda-forge/osx-64       48kB
  + r-tibble                                  3.2.1  r43h6dc245f_2           conda-forge/osx-64      610kB
  + r-tidyr                                   1.3.0  r43hac7d2d5_1           conda-forge/osx-64        1MB
  + r-tidyselect                              1.2.0  r43hbe3e9c8_1           conda-forge/osx-64      215kB
  + r-tinytex                                  0.46  r43hc72bb7e_0           conda-forge/noarch      143kB
  + r-utf8                                    1.2.3  r43h6dc245f_1           conda-forge/osx-64      138kB
  + r-vctrs                                   0.6.3  r43hac7d2d5_0           conda-forge/osx-64        1MB
  + r-viridis                                 0.6.4  r43hc72bb7e_0           conda-forge/noarch        3MB
  + r-viridislite                             0.4.2  r43hc72bb7e_1           conda-forge/noarch        1MB
  + r-withr                                   2.5.0  r43hc72bb7e_2           conda-forge/noarch      239kB
  + r-xfun                                     0.40  r43hac7d2d5_0           conda-forge/osx-64      423kB
  + r-xml                                 3.99_0.14  r43hb8526f4_2           conda-forge/osx-64        2MB
  + r-xml2                                    1.3.5  r43h2e0d1c5_0           conda-forge/osx-64      300kB
  + r-yaml                                    2.3.7  r43h6dc245f_1           conda-forge/osx-64      107kB
  + re2                                  2023.03.02  h096449b_0              conda-forge/osx-64      185kB
  + readline                                    8.2  h9e318b2_1              conda-forge/osx-64     Cached
  + rename                                    1.601  hdfd78af_1              bioconda/noarch        Cached
  + requests                                 2.31.0  pyhd8ed1ab_0            conda-forge/noarch       57kB
  + samtools                                    1.6  h27eba97_10             bioconda/osx-64         493kB
  + scikit-image                             0.21.0  py39h840bb9f_0          conda-forge/osx-64       10MB
  + scikit-learn                              1.3.0  py39hcb35850_0          conda-forge/osx-64        8MB
  + scipy                                    1.11.2  py39hded996c_0          conda-forge/osx-64       16MB
  + seaborn                                  0.12.2  hd8ed1ab_0              conda-forge/noarch        6kB
  + seaborn-base                             0.12.2  pyhd8ed1ab_0            conda-forge/noarch      232kB
  + setuptools                               68.1.2  pyhd8ed1ab_0            conda-forge/noarch      462kB
  + sigtool                                   0.1.3  h88f4db0_0              conda-forge/osx-64     Cached
  + simplejson                               3.19.1  py39ha30fb19_0          conda-forge/osx-64      106kB
  + six                                      1.16.0  pyh6c4a22f_0            conda-forge/noarch     Cached
  + snappy                                   1.1.10  h225ccf5_0              conda-forge/osx-64     Cached
  + sortedcontainers                          2.4.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + statsmodels                              0.14.0  py39h57e1da4_1          conda-forge/osx-64       10MB
  + tapi                                  1100.0.11  h9ce4665_0              conda-forge/osx-64     Cached
  + tblib                                     1.7.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + threadpoolctl                             3.2.0  pyha21a80b_0            conda-forge/noarch       21kB
  + tifffile                              2023.8.30  pyhd8ed1ab_0            conda-forge/noarch      177kB
  + tk                                       8.6.12  h5dbffcc_0              conda-forge/osx-64     Cached
  + tktable                                    2.10  h49f0cf7_3              conda-forge/osx-64     Cached
  + toml                                     0.10.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + tomlkit                                  0.12.1  pyha770c72_0            conda-forge/noarch       37kB
  + toolz                                    0.12.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + tornado                                   6.3.3  py39hdc70f33_0          conda-forge/osx-64      631kB
  + typing-extensions                         4.7.1  hd8ed1ab_0              conda-forge/noarch       10kB
  + typing_extensions                         4.7.1  pyha770c72_0            conda-forge/noarch       36kB
  + tzdata                                    2023c  h71feb2d_0              conda-forge/noarch     Cached
  + unicodedata2                             15.0.0  py39ha30fb19_0          conda-forge/osx-64      498kB
  + urllib3                                   2.0.4  pyhd8ed1ab_0            conda-forge/noarch       98kB
  + wheel                                    0.41.2  pyhd8ed1ab_0            conda-forge/noarch       57kB
  + xmltodict                                0.13.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + xorg-libxau                              1.0.11  h0dc2134_0              conda-forge/osx-64       13kB
  + xorg-libxdmcp                             1.1.3  h35c211d_0              conda-forge/osx-64     Cached
  + xyzservices                            2023.7.0  pyhd8ed1ab_0            conda-forge/noarch       36kB
  + xz                                        5.2.6  h775f41a_0              conda-forge/osx-64     Cached
  + yaml                                      0.2.5  h0d85af4_2              conda-forge/osx-64     Cached
  + yq                                        3.2.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + zfp                                       1.0.0  ha894c9a_3              conda-forge/osx-64      270kB
  + zict                                      3.0.0  pyhd8ed1ab_0            conda-forge/noarch       36kB
  + zipp                                     3.16.2  pyhd8ed1ab_0            conda-forge/noarch       19kB
  + zlib                                     1.2.13  h8a1eda9_5              conda-forge/osx-64     Cached
  + zlib-ng                                   2.0.7  hb7f2c08_0              conda-forge/osx-64       93kB
  + zstd                                      1.5.5  h829000d_0              conda-forge/osx-64      499kB

  Summary:

  Install: 406 packages

  Total download: 606MB

────────────────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
python_abi                                           5.8kB @  40.1kB/s  0.1s
xorg-libxau                                         13.1kB @  73.9kB/s  0.2s
giflib                                              76.5kB @ 366.7kB/s  0.2s
ca-certificates                                    149.9kB @ 638.4kB/s  0.2s
libwebp-base                                       346.4kB @   1.4MB/s  0.3s
aws-c-common                                       180.0kB @ 646.1kB/s  0.1s
re2                                                185.5kB @ 574.0kB/s  0.1s
zfp                                                270.4kB @ 831.6kB/s  0.1s
aws-c-sdkutils                                      47.2kB @ 119.3kB/s  0.1s
libbrotlienc                                       279.1kB @ 631.8kB/s  0.1s
libavif                                             94.9kB @ 195.4kB/s  0.1s
libevent                                           372.7kB @ 536.7kB/s  0.2s
aom                                                  3.4MB @   4.6MB/s  0.5s
openssl                                              2.3MB @   3.1MB/s  0.5s
libtiff                                            393.2kB @ 458.6kB/s  0.4s
aws-c-io                                           135.9kB @ 144.8kB/s  0.1s
brotli                                              20.2kB @  19.9kB/s  0.1s
aws-c-event-stream                                  47.0kB @  43.0kB/s  0.1s
libglib                                              2.5MB @   2.2MB/s  0.4s
orc                                                441.3kB @ 400.6kB/s  0.4s
clang                                               20.7kB @  17.6kB/s  0.1s
aws-c-mqtt                                         139.1kB @ 114.8kB/s  0.1s
aws-sdk-cpp                                          3.4MB @   2.0MB/s  0.5s
hdf5                                                 3.5MB @   2.0MB/s  0.7s
clang_osx-64                                        20.8kB @  11.5kB/s  0.1s
coreutils                                            1.8MB @ 938.8kB/s  0.7s
r-digest                                           193.9kB @  94.3kB/s  0.1s
samtools                                           492.8kB @ 217.4kB/s  0.6s
r-xfun                                             423.2kB @ 178.6kB/s  0.3s
pandoc                                              16.1MB @   6.4MB/s  2.3s
r-mass                                               1.1MB @ 451.0kB/s  0.3s
r-fastmap                                           71.2kB @  27.2kB/s  0.1s
r-lattice                                            1.3MB @ 491.9kB/s  0.4s
r-fansi                                            308.4kB @ 111.0kB/s  0.2s
r-isoband                                            1.6MB @ 572.9kB/s  0.3s
r-jpeg                                              52.4kB @  17.9kB/s  0.2s
r-magrittr                                         206.7kB @  69.1kB/s  0.1s
r-rappdirs                                          51.1kB @  17.0kB/s  0.1s
r-cli                                                1.2MB @ 396.6kB/s  0.4s
r-matrixstats                                      466.3kB @ 144.8kB/s  0.2s
r-bit64                                            504.5kB @ 146.0kB/s  0.2s
r-rlang                                              1.5MB @ 435.5kB/s  0.5s
r-cachem                                            74.1kB @  20.8kB/s  0.1s
r-htmltools                                        357.5kB @  94.9kB/s  0.2s
r-nlme                                               2.3MB @ 594.8kB/s  0.7s
r-rcppeigen                                          1.3MB @ 324.7kB/s  0.5s
setuptools                                         462.3kB @ 116.7kB/s  0.2s
r-cpp11                                            230.8kB @  57.2kB/s  0.2s
r-withr                                            238.9kB @  58.6kB/s  0.1s
r-formatr                                          165.0kB @  40.2kB/s  0.2s
r-formula                                          174.2kB @  42.2kB/s  0.1s
r-generics                                          90.7kB @  21.6kB/s  0.1s
r-rcolorbrewer                                      68.3kB @  16.2kB/s  0.1s
r-crayon                                           164.1kB @  38.9kB/s  0.1s
r-munsell                                          244.1kB @  56.8kB/s  0.1s
r-httr                                             468.3kB @ 107.5kB/s  0.1s
r-scales                                           595.3kB @ 131.1kB/s  0.2s
r-fontawesome                                        1.3MB @ 287.7kB/s  0.4s
fsspec                                             118.3kB @  25.7kB/s  0.1s
cloudpickle                                         27.9kB @   6.0kB/s  0.1s
natsort                                             37.3kB @   8.0kB/s  0.1s
zipp                                                18.8kB @   4.0kB/s  0.1s
tomlkit                                             37.0kB @   7.8kB/s  0.1s
pytz                                               186.5kB @  39.2kB/s  0.1s
r-latticeextra                                       2.2MB @ 460.7kB/s  0.5s
click                                               84.4kB @  17.4kB/s  0.1s
cached-property                                      4.1kB @ 851.0 B/s  0.1s
importlib-resources                                  9.7kB @   2.0kB/s  0.1s
importlib_resources                                 30.6kB @   6.2kB/s  0.1s
llvm-tools                                          22.3MB @   4.4MB/s  4.3s
networkx                                             1.5MB @ 286.6kB/s  0.4s
bioconductor-biocgenerics                          655.4kB @ 128.3kB/s  0.2s
pyvcf3                                             979.5kB @ 188.3kB/s  0.3s
bioconductor-s4arrays                              795.6kB @ 148.5kB/s  0.3s
markupsafe                                          22.7kB @   4.2kB/s  0.1s
psutil                                             365.9kB @  66.2kB/s  0.1s
bioconductor-biocparallel                            1.7MB @ 304.7kB/s  0.5s
bioconductor-rhtslib                                 1.9MB @ 347.4kB/s  0.5s
brotli-python                                      350.9kB @  62.3kB/s  0.1s
unicodedata2                                       497.7kB @  86.6kB/s  0.2s
r-sass                                               2.1MB @ 365.5kB/s  0.6s
multiprocess                                       236.7kB @  40.6kB/s  0.2s
imagecodecs                                          1.5MB @ 247.6kB/s  0.3s
fonttools                                            2.1MB @ 346.5kB/s  0.5s
bioconductor-biocio                                469.4kB @  74.1kB/s  0.1s
biopython                                            2.7MB @ 430.1kB/s  0.6s
r-hms                                              107.2kB @  16.7kB/s  0.1s
r-stringr                                          295.6kB @  45.4kB/s  0.1s
r-progress                                          92.3kB @  14.0kB/s  0.1s
dask-core                                          856.2kB @ 129.1kB/s  0.2s
requests                                            56.7kB @   8.5kB/s  0.1s
pooch                                               50.9kB @   7.6kB/s  0.1s
numba                                                4.1MB @ 589.5kB/s  0.8s
r-base                                              25.4MB @   3.6MB/s  5.2s
bioframe                                           100.2kB @  14.2kB/s  0.1s
bioconductor-genomeinfodbdata                        8.4kB @   1.2kB/s  0.1s
patsy                                              193.6kB @  26.9kB/s  0.1s
pairtools                                          161.5kB @  22.4kB/s  0.6s
bioconductor-genomicranges                           2.3MB @ 293.9kB/s  0.6s
r-viridis                                            3.0MB @ 381.5kB/s  0.7s
bioconductor-annotationfilter                      561.2kB @  70.1kB/s  0.1s
bioconductor-biomart                               927.3kB @ 111.9kB/s  0.3s
r-hmisc                                              3.5MB @ 410.1kB/s  0.7s
scikit-image                                        10.1MB @   1.2MB/s  1.7s
bioconductor-interactionset                          1.6MB @ 180.2kB/s  0.5s
bioconductor-genomicfeatures                         2.2MB @ 244.4kB/s  0.5s
zlib-ng                                             93.2kB @  10.2kB/s  0.1s
gflags                                              94.6kB @  10.3kB/s  0.1s
scipy                                               15.7MB @   1.7MB/s  2.6s
libzopfli                                          162.3kB @  17.5kB/s  0.1s
zstd                                               499.4kB @  53.0kB/s  0.2s
bioconductor-variantannotation                       4.1MB @ 432.1kB/s  0.8s
aws-c-compression                                   17.7kB @   1.9kB/s  0.1s
libsqlite                                          891.0kB @  93.8kB/s  0.2s
libgfortran                                        133.3kB @  14.0kB/s  0.1s
lcms2                                              227.7kB @  23.4kB/s  0.2s
krb5                                                 1.2MB @ 119.7kB/s  0.4s
libthrift                                          324.0kB @  32.7kB/s  0.2s
libprotobuf                                          2.1MB @ 208.4kB/s  0.5s
aws-c-auth                                          89.5kB @   8.9kB/s  0.1s
clang-16                                           693.4kB @  68.8kB/s  0.2s
bioconductor-genomicinteractions                     3.7MB @ 368.0kB/s  1.3s
aws-crt-cpp                                        274.8kB @  27.1kB/s  0.1s
r-curl                                             449.7kB @  43.5kB/s  0.2s
pbgzip                                              30.8kB @   3.0kB/s  0.4s
r-mime                                              52.0kB @   5.0kB/s  0.2s
r-png                                               58.8kB @   5.6kB/s  0.1s
r-cluster                                          574.3kB @  53.9kB/s  0.2s
r-bit                                                1.1MB @ 101.4kB/s  0.3s
r-stringi                                          855.3kB @  78.3kB/s  0.3s
r-sys                                               47.6kB @   4.3kB/s  0.1s
r-filelock                                          29.2kB @   2.6kB/s  0.1s
r-nnet                                             134.6kB @  12.0kB/s  0.1s
r-rjson                                            156.9kB @  14.0kB/s  0.3s
r-askpass                                           29.0kB @   2.6kB/s  0.1s
r-interp                                             1.5MB @ 129.4kB/s  0.4s
r-labeling                                          69.0kB @   5.8kB/s  0.1s
r-assertthat                                        71.6kB @   6.0kB/s  0.1s
r-mgcv                                               3.4MB @ 282.9kB/s  0.7s
python                                              11.4MB @ 945.6kB/s  1.9s
r-dichromat                                        160.8kB @  13.3kB/s  0.1s
r-viridislite                                        1.3MB @ 107.3kB/s  0.3s
r-lifecycle                                        121.6kB @  10.0kB/s  0.1s
r-knitr                                              1.3MB @ 104.6kB/s  0.2s
pip                                                  1.4MB @ 111.7kB/s  0.3s
xyzservices                                         36.3kB @   2.9kB/s  0.1s
mistune                                             47.8kB @   3.8kB/s  0.1s
argcomplete                                         39.4kB @   3.1kB/s  0.1s
dill                                                87.6kB @   7.0kB/s  0.1s
packaging                                           46.1kB @   3.7kB/s  0.1s
importlib-metadata                                  25.9kB @   2.0kB/s  0.1s
r-futile.logger                                    105.3kB @   8.3kB/s  0.2s
platformdirs                                        19.8kB @   1.6kB/s  0.1s
bioconductor-zlibbioc                               24.3kB @   1.9kB/s  0.1s
r-bh                                                11.4MB @ 851.1kB/s  1.4s
bioconductor-s4vectors                               2.6MB @ 190.5kB/s  0.7s
tornado                                            630.7kB @  46.0kB/s  0.3s
bioconductor-iranges                                 2.6MB @ 186.7kB/s  0.9s
simplejson                                         106.0kB @   7.7kB/s  0.1s
llvmlite                                           257.1kB @  18.6kB/s  0.1s
r-purrr                                            482.9kB @  34.5kB/s  0.2s
r-igraph                                             4.5MB @ 319.0kB/s  0.7s
pyarrow                                              3.6MB @ 242.3kB/s  0.9s
r-blob                                              65.8kB @   4.4kB/s  0.1s
urllib3                                             98.4kB @   6.6kB/s  0.1s
pywavelets                                           3.6MB @ 236.3kB/s  1.1s
matplotlib-base                                      6.7MB @ 440.1kB/s  1.1s
r-htmlwidgets                                      423.2kB @  27.8kB/s  0.2s
r-rmarkdown                                          2.1MB @ 134.8kB/s  0.4s
libgoogle-cloud                                     32.6MB @   2.1MB/s  5.4s
r-rsqlite                                            1.2MB @  79.8kB/s  0.3s
pillow                                              46.4MB @   3.0MB/s  9.9s
h5sparse                                            12.2kB @ 782.0 B/s  0.3s
r-ggplot2                                            3.3MB @ 204.5kB/s  0.5s
bioconductor-summarizedexperiment                    1.9MB @ 120.6kB/s  0.3s
cooltools                                          300.1kB @  18.6kB/s  0.7s
bioconductor-genomicalignments                       2.4MB @ 147.7kB/s  0.5s
dav1d                                              668.4kB @  40.1kB/s  0.2s
libabseil                                            1.1MB @  66.6kB/s  0.3s
bioconductor-bsgenome                                7.3MB @ 431.7kB/s  1.1s
scikit-learn                                         7.5MB @ 443.2kB/s  1.8s
libbrotlidec                                        31.9kB @   1.9kB/s  0.1s
aws-c-cal                                           40.3kB @   2.3kB/s  0.1s
c-blosc2                                           285.6kB @  16.7kB/s  0.1s
openjpeg                                           329.6kB @  19.1kB/s  0.1s
libcurl                                            353.9kB @  20.5kB/s  0.1s
curl                                               147.2kB @   8.5kB/s  0.1s
libgfortran5                                         1.6MB @  90.7kB/s  0.3s
bioconductor-gviz                                    7.2MB @ 415.3kB/s  1.2s
clangxx_osx-64                                      19.7kB @   1.1kB/s  0.0s
aws-c-s3                                            75.5kB @   4.4kB/s  0.1s
statsmodels                                         10.1MB @ 580.8kB/s  1.9s
r-base64enc                                         44.5kB @   2.6kB/s  0.1s
r-utf8                                             138.4kB @   7.9kB/s  0.1s
r-foreign                                          263.2kB @  15.1kB/s  0.1s
r-jsonlite                                         631.3kB @  36.2kB/s  0.1s
r-bitops                                            43.1kB @   2.5kB/s  0.1s
r-xml2                                             300.5kB @  17.1kB/s  0.2s
r-codetools                                        108.4kB @   6.2kB/s  0.1s
r-openssl                                          632.1kB @  35.9kB/s  0.2s
r-plogr                                             22.1kB @   1.3kB/s  0.0s
htslib                                               2.4MB @ 138.7kB/s  0.4s
r-futile.options                                    28.5kB @   1.6kB/s  0.1s
r-highr                                             57.5kB @   3.3kB/s  0.1s
r-rcurl                                            816.0kB @  46.2kB/s  0.2s
r-lambda.r                                         119.4kB @   6.8kB/s  0.1s
multiprocessing-logging                             13.4kB @ 755.0 B/s  0.0s
py-cpuinfo                                          24.9kB @   1.4kB/s  0.1s
charset-normalizer                                  45.7kB @   2.6kB/s  0.0s
threadpoolctl                                       21.0kB @   1.2kB/s  0.0s
partd                                               20.5kB @   1.2kB/s  0.1s
lz4                                                 33.3kB @   1.9kB/s  0.1s
bioconductor-protgenerics                          248.8kB @  14.0kB/s  0.1s
pyyaml                                             163.0kB @   9.1kB/s  0.1s
bioconductor-xvector                               749.1kB @  41.9kB/s  0.2s
cytoolz                                            316.8kB @  17.7kB/s  0.1s
r-pillar                                           617.4kB @  34.3kB/s  0.1s
tifffile                                           176.7kB @   9.8kB/s  0.2s
dask                                                 7.4kB @ 410.0 B/s  0.1s
h5py                                               985.8kB @  54.4kB/s  0.3s
pytables                                             1.9MB @ 103.0kB/s  0.5s
r-dbplyr                                             1.1MB @  59.7kB/s  0.2s
seaborn                                              6.3kB @ 344.0 B/s  0.0s
pysam                                                3.9MB @ 213.7kB/s  0.7s
libbrotlicommon                                     69.6kB @   3.8kB/s  0.1s
r-dplyr                                              1.4MB @  75.4kB/s  0.4s
bioconductor-biocfilecache                         590.6kB @  31.9kB/s  0.2s
charls                                             138.1kB @   7.4kB/s  0.1s
libxcb                                             313.8kB @  16.9kB/s  0.1s
blosc                                               49.7kB @   2.7kB/s  0.1s
r-tidyr                                              1.1MB @  60.9kB/s  0.5s
aws-c-http                                         164.4kB @   8.8kB/s  0.1s
brunsli                                            183.1kB @   9.8kB/s  0.1s
r-deldir                                           303.6kB @  16.1kB/s  0.2s
bioconductor-ensembldb                               3.6MB @ 191.4kB/s  0.7s
r-data.table                                         1.9MB @  96.3kB/s  0.6s
libgrpc                                              4.3MB @ 223.6kB/s  0.7s
wheel                                               57.5kB @   3.0kB/s  0.1s
r-colorspace                                         2.5MB @ 129.4kB/s  0.5s
r-evaluate                                          89.3kB @   4.6kB/s  0.1s
r-jquerylib                                        305.5kB @  15.7kB/s  0.1s
r-checkmate                                        666.6kB @  34.2kB/s  0.2s
r-dbi                                              720.9kB @  36.9kB/s  0.2s
zict                                                36.3kB @   1.9kB/s  0.0s
typing_extensions                                   36.3kB @   1.9kB/s  0.0s
importlib_metadata                                   9.4kB @ 481.0 B/s  0.0s
joblib                                             221.2kB @  11.3kB/s  0.1s
kiwisolver                                          60.6kB @   3.1kB/s  0.1s
numexpr                                            121.8kB @   6.2kB/s  0.1s
pyfaidx                                             33.0kB @   1.7kB/s  0.1s
r-vctrs                                              1.2MB @  62.7kB/s  0.3s
imageio                                            290.5kB @  14.6kB/s  0.1s
r-htmltable                                        405.5kB @  20.3kB/s  0.1s
r-lazyeval                                         156.3kB @   7.8kB/s  0.9s
cooler                                              84.6kB @   4.2kB/s  0.1s
bioconductor-biobase                                 2.5MB @ 126.4kB/s  0.6s
libcrc32c                                           20.1kB @ 995.0 B/s  0.1s
aws-checksums                                       48.7kB @   2.4kB/s  0.1s
brotli-bin                                          18.0kB @ 881.0 B/s  0.1s
cctools_osx-64                                       1.1MB @  53.6kB/s  0.4s
bioconductor-biovizbase                              2.7MB @ 131.2kB/s  0.8s
bioconductor-annotationdbi                           5.2MB @ 247.7kB/s  1.0s
libgfortran-devel_osx-64                           453.9kB @  21.6kB/s  0.1s
r-farver                                             1.4MB @  64.6kB/s  0.5s
r-rcpp                                               2.0MB @  95.7kB/s  0.6s
gfortran_impl_osx-64                                20.6MB @ 958.8kB/s  2.8s
r-pkgconfig                                         26.4kB @   1.2kB/s  0.1s
r-memoise                                           55.9kB @   2.6kB/s  0.1s
r-xml                                                1.7MB @  81.1kB/s  0.6s
locket                                               8.2kB @ 383.0 B/s  0.1s
typing-extensions                                   10.1kB @ 467.0 B/s  0.0s
lazy_loader                                         14.3kB @ 662.0 B/s  0.1s
bioconductor-delayedarray                            2.3MB @ 105.2kB/s  0.7s
bioconductor-biostrings                             14.2MB @ 641.3kB/s  2.3s
bioconductor-data-packages                         187.5kB @   8.4kB/s  0.1s
r-survival                                           6.2MB @ 275.6kB/s  1.1s
numpy                                                5.6MB @ 244.7kB/s  1.2s
coolpuppy                                           44.8kB @   2.0kB/s  0.3s
pandas                                              11.3MB @ 488.4kB/s  1.5s
clangxx                                             20.9kB @ 900.0 B/s  0.1s
r-fs                                               277.4kB @  11.9kB/s  0.1s
bokeh                                                5.3MB @ 229.7kB/s  1.1s
r-glue                                             150.5kB @   6.4kB/s  0.1s
r-ellipsis                                          41.6kB @   1.8kB/s  0.1s
bioconductor-rsamtools                               4.2MB @ 178.4kB/s  1.1s
r-snow                                             114.8kB @   4.9kB/s  0.1s
r-gtable                                           222.3kB @   9.5kB/s  0.1s
r-tidyselect                                       214.9kB @   9.1kB/s  0.1s
r-gridextra                                          1.0MB @  44.5kB/s  0.2s
m2r2                                                16.5kB @ 696.0 B/s  0.1s
r-restfulr                                         448.3kB @  18.8kB/s  0.4s
libxml2                                            623.0kB @  26.0kB/s  0.2s
ld64_osx-64                                          1.1MB @  43.7kB/s  0.2s
bioconductor-genomeinfodb                            4.4MB @ 181.1kB/s  0.7s
r-rpart                                            933.3kB @  38.2kB/s  0.2s
r-tinytex                                          143.1kB @   5.8kB/s  0.1s
certifi                                            153.8kB @   6.2kB/s  0.1s
msgpack-python                                      76.7kB @   3.1kB/s  0.1s
bioconductor-rtracklayer                             5.6MB @ 224.1kB/s  1.3s
r-matrix                                             4.0MB @ 160.4kB/s  0.7s
seaborn-base                                       231.9kB @   9.3kB/s  0.1s
libutf8proc                                         98.9kB @   3.9kB/s  0.1s
r-yaml                                             106.7kB @   4.2kB/s  0.2s
r-prettyunits                                       42.2kB @   1.7kB/s  0.1s
r-bslib                                              5.1MB @ 197.4kB/s  0.9s
pairix                                             100.5kB @   3.9kB/s  0.4s
distributed                                        782.1kB @  30.3kB/s  0.2s
gfortran_osx-64                                     35.0kB @   1.4kB/s  0.1s
jxrlib                                             231.0kB @   8.9kB/s  0.2s
r-r6                                                90.4kB @   3.5kB/s  0.1s
bioconductor-keggrest                              202.0kB @   7.8kB/s  0.1s
libllvm14                                           22.5MB @ 862.2kB/s  3.3s
libllvm16                                           25.3MB @ 971.2kB/s  3.3s
docutils                                           707.3kB @  27.1kB/s  0.2s
r-backports                                        108.1kB @   4.1kB/s  0.1s
glog                                               100.6kB @   3.8kB/s  0.1s
more-itertools                                      53.7kB @   2.1kB/s  0.1s
bioconductor-matrixgenerics                        471.5kB @  18.0kB/s  0.1s
r-rstudioapi                                       295.5kB @  11.3kB/s  0.1s
contourpy                                          214.6kB @   8.2kB/s  0.1s
r-tibble                                           610.3kB @  23.2kB/s  0.1s
libarrow                                            20.1MB @ 739.5kB/s  2.1s
libclang-cpp16                                      12.8MB @ 461.9kB/s  1.6s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯     CONDA_SUBDIR=osx-64 \
>     mamba install \
>         -c conda-forge \
>             pbzip2 \
>             pigz \
>             r-argparse \
>             r-ggsci \
>             r-plotly \
>             r-tidyverse

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.25.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['pbzip2', 'pigz', 'r-argparse', 'r-ggsci', 'r-plotly', 'r-tidyverse']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/main/osx-64                                              No change
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.9.*


Transaction

  Prefix: /Users/kalavattam/miniconda3/envs/pairtools_env

  Updating specs:

   - pbzip2
   - pigz
   - r-argparse
   - r-ggsci
   - r-plotly
   - r-tidyverse
   - ca-certificates
   - certifi
   - openssl


  Package            Version  Build             Channel                  Size
───────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────

  + pbzip2            1.1.13  h9d27c22_1        conda-forge/osx-64     Cached
  + pigz                 2.6  h5dbffcc_0        conda-forge/osx-64       90kB
  + r-argparse         2.2.2  r43hc72bb7e_1     conda-forge/noarch      158kB
  + r-broom            1.0.5  r43hc72bb7e_1     conda-forge/noarch        2MB
  + r-callr            3.7.3  r43hc72bb7e_1     conda-forge/noarch      417kB
  + r-cellranger       1.1.0  r43hc72bb7e_1006  conda-forge/noarch      108kB
  + r-clipr            0.8.0  r43hc72bb7e_2     conda-forge/noarch       70kB
  + r-conflicted       1.2.0  r43h785f33e_1     conda-forge/noarch       63kB
  + r-crosstalk        1.2.0  r43hc72bb7e_2     conda-forge/noarch      373kB
  + r-dtplyr           1.3.1  r43hc72bb7e_1     conda-forge/noarch      354kB
  + r-findpython       1.0.8  r43hc72bb7e_1     conda-forge/noarch       29kB
  + r-forcats          1.0.0  r43hc72bb7e_1     conda-forge/noarch      422kB
  + r-gargle           1.5.2  r43h785f33e_0     conda-forge/noarch      706kB
  + r-ggsci            3.0.0  r43hc72bb7e_1     conda-forge/noarch        2MB
  + r-googledrive      2.1.1  r43hc72bb7e_1     conda-forge/noarch        1MB
  + r-googlesheets4    1.1.1  r43h785f33e_1     conda-forge/noarch      513kB
  + r-haven            2.5.3  r43hac7d2d5_0     conda-forge/osx-64      355kB
  + r-hexbin          1.28.3  r43hfe07776_1     conda-forge/osx-64        2MB
  + r-ids              1.0.1  r43hc72bb7e_3     conda-forge/noarch      127kB
  + r-later            1.3.1  r43h670e93c_1     conda-forge/osx-64      116kB
  + r-lubridate        1.9.2  r43h6dc245f_2     conda-forge/osx-64      977kB
  + r-modelr          0.1.11  r43hc72bb7e_1     conda-forge/noarch      221kB
  + r-plotly          4.10.2  r43hc72bb7e_1     conda-forge/noarch        3MB
  + r-processx         3.8.2  r43h6dc245f_0     conda-forge/osx-64      310kB
  + r-promises         1.2.1  r43hac7d2d5_0     conda-forge/osx-64        2MB
  + r-ps               1.7.5  r43h6dc245f_1     conda-forge/osx-64      305kB
  + r-ragg             1.2.5  r43he54449d_2     conda-forge/osx-64      400kB
  + r-readr            2.1.4  r43hac7d2d5_1     conda-forge/osx-64      809kB
  + r-readxl           1.4.3  r43h88814b1_0     conda-forge/osx-64      728kB
  + r-rematch          2.0.0  r43hc72bb7e_0     conda-forge/noarch       25kB
  + r-rematch2         2.1.2  r43hc72bb7e_3     conda-forge/noarch       54kB
  + r-reprex           2.0.2  r43hc72bb7e_2     conda-forge/noarch      502kB
  + r-rvest            1.0.3  r43hc72bb7e_2     conda-forge/noarch      214kB
  + r-selectr          0.4_2  r43hc72bb7e_3     conda-forge/noarch      421kB
  + r-systemfonts      1.0.4  r43h7f6030a_2     conda-forge/osx-64      227kB
  + r-textshaping      0.3.6  r43heedee68_6     conda-forge/osx-64      105kB
  + r-tidyverse        2.0.0  r43h785f33e_1     conda-forge/noarch      425kB
  + r-timechange       0.2.0  r43hac7d2d5_1     conda-forge/osx-64      182kB
  + r-tzdb             0.4.0  r43hac7d2d5_1     conda-forge/osx-64      538kB
  + r-uuid             1.1_1  r43h6dc245f_0     conda-forge/osx-64       49kB
  + r-vroom            1.6.3  r43hac7d2d5_1     conda-forge/osx-64      805kB

  Summary:

  Install: 41 packages

  Total download: 22MB

───────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
pigz                                                90.5kB @ 610.6kB/s  0.1s
r-systemfonts                                      227.3kB @ 992.3kB/s  0.2s
r-hexbin                                             1.6MB @   5.6MB/s  0.3s
r-tzdb                                             538.3kB @   1.8MB/s  0.3s
r-timechange                                       181.6kB @ 575.2kB/s  0.3s
r-lubridate                                        977.4kB @   2.9MB/s  0.2s
r-conflicted                                        63.2kB @ 185.9kB/s  0.1s
r-dtplyr                                           354.5kB @ 912.4kB/s  0.1s
r-ragg                                             399.6kB @   1.0MB/s  0.2s
r-clipr                                             69.7kB @ 176.3kB/s  0.1s
r-modelr                                           220.6kB @ 553.4kB/s  0.1s
r-rematch                                           25.1kB @  58.6kB/s  0.1s
r-rvest                                            213.6kB @ 459.5kB/s  0.1s
r-reprex                                           501.9kB @ 990.2kB/s  0.1s
r-readxl                                           727.9kB @   1.4MB/s  0.1s
r-later                                            116.3kB @ 226.6kB/s  0.1s
r-processx                                         310.3kB @ 568.4kB/s  0.1s
r-ids                                              126.9kB @ 217.5kB/s  0.1s
r-vroom                                            805.4kB @   1.4MB/s  0.2s
r-selectr                                          421.1kB @ 709.6kB/s  0.1s
r-textshaping                                      105.3kB @ 145.0kB/s  0.1s
r-tidyverse                                        425.2kB @ 563.0kB/s  0.2s
r-googlesheets4                                    512.7kB @ 660.4kB/s  0.2s
r-forcats                                          422.4kB @ 522.0kB/s  0.1s
r-broom                                              1.8MB @   2.2MB/s  0.3s
r-rematch2                                          54.2kB @  65.2kB/s  0.1s
r-argparse                                         158.4kB @ 181.4kB/s  0.1s
r-findpython                                        29.4kB @  33.0kB/s  0.1s
r-plotly                                             2.9MB @   3.2MB/s  0.4s
r-ps                                               305.5kB @ 339.7kB/s  0.1s
r-callr                                            417.0kB @ 439.9kB/s  0.1s
r-readr                                            809.3kB @ 832.0kB/s  0.2s
r-uuid                                              49.1kB @  50.3kB/s  0.1s
r-googledrive                                        1.2MB @   1.1MB/s  0.2s
r-gargle                                           706.0kB @ 635.6kB/s  0.1s
r-haven                                            355.4kB @ 315.6kB/s  0.2s
r-cellranger                                       108.3kB @  90.2kB/s  0.1s
r-crosstalk                                        372.8kB @ 308.9kB/s  0.1s
r-ggsci                                              2.2MB @   1.8MB/s  0.3s
r-promises                                           1.6MB @   1.2MB/s  0.3s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
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
    } || true

install_atria=FALSE
[[ "${install_atria}" == TRUE ]] &&
    {
        cd "${HOME}/2023_rDNA" || echo "cd'ing failed; check on this..."

        [[ -d software/ ]] || mkdir software/

        cd software/ || echo "cd'ing failed; check on this..."
        git clone "https://github.com/cihga39871/Atria.git"

        cd Atria/

        julia build_atria.jl
    } || true

alias_atria=FALSE
[[ "${alias_atria}" == TRUE ]] &&
    {
        alias atria="\${HOME}/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/app-3.2.2/bin/atria"
        # atria
    } || true
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
    } || true
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
[[ "${install_clodius}" == TRUE ]] && pip install clodius || true

install_bedops=TRUE
[[ "${install_bedops}" == TRUE ]] && mamba install -c bioconda bedops || true
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

# tmux new -s mc
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
# grabnode  # 8, 160, 1, N
# grabnode  # 1, 20, 1, N
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

p_base="${HOME}/tsukiyamalab/kalavatt"
p_proj="2023_rDNA/results/2023-0307_work_Micro-C_align-process"
cd "${p_base}/${p_proj}" || echo "cd'ing failed; check on this..."


[[ "${CONDA_DEFAULT_ENV}" != "pairtools_env" ]] \
    && source activate pairtools_env \
    || true
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

run=FALSE
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
            } || true
    } || true
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
        [[ "${run_check}" == TRUE ]] && ls -lhaFG sym/ || true
    } || true
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

#  Initialize array of samples to work with
unset stem && typeset -a stem
stem+=( "MC-2019_Q_WT_repM" )
stem+=( "MC-2020_30C-a15_WT_rep1" )
stem+=( "MC-2020_30C-a15_WT_rep2" )
stem+=( "MC-2020_nz_WT_rep1" )
stem+=( "MC-2020_nz_WT_rep2" )

#  Initialize arrays of samples to merge
unset to_merge && typeset -a to_merge
to_merge+=( "MC-2020_30C-a15_WT" )
to_merge+=( "MC-2020_nz_WT" )

run_check=TRUE
[[ "${run_check[@]}" == TRUE ]] &&
    {
        for i in "${stem[@]}"; do
            ls -lhaFG "sym/${i}_R1.fastq.gz"
            ls -lhaFG "sym/${i}_R2.fastq.gz"
            echo ""
        done
    } || true

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
    } || true
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
# max_mismatch_rDNA=6                                                     # echo "${max_mismatch_rDNA}"
max_mismatch_rDNA=0                                                       # echo "${max_mismatch_rDNA}"

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

unset               f_map_pre_rDNA && typeset -a f_map_pre_rDNA                # echo_test "${f_map_pre_rDNA[@]}"
unset         a_map_pre_pairs_rDNA && typeset -a a_map_pre_pairs_rDNA          # echo_test "${a_map_pre_pairs_rDNA[@]}"

unset          f_map_sort_pre_rDNA && typeset -a f_map_sort_pre_rDNA           # echo_test "${f_map_sort_pre_rDNA[@]}"
unset    a_map_sort_pre_pairs_rDNA && typeset -a a_map_sort_pre_pairs_rDNA     # echo_test "${a_map_sort_pre_pairs_rDNA[@]}"

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

unset   f_map_pre_pairs_stats_rDNA && typeset -a f_map_pre_pairs_stats_rDNA    # echo_test "${f_map_pre_pairs_stats_rDNA[@]}"
unset   a_map_pre_pairs_stats_rDNA && typeset -a a_map_pre_pairs_stats_rDNA    # echo_test "${a_map_pre_pairs_stats_rDNA[@]}"

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
    
                  f_map_pre_rDNA+=( "${f_pre_rDNA[${i}]}.mapped" )
            a_map_pre_pairs_rDNA+=( "${d_dedup}/${f_map_pre_rDNA[${i}]}.pairs.gz" )

             f_map_sort_pre_rDNA+=( "${f_pre_rDNA[${i}]}.mapped.sort" )
       a_map_sort_pre_pairs_rDNA+=( "${d_dedup}/${f_map_sort_pre_rDNA[${i}]}.pairs.gz" )

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

      f_map_pre_pairs_stats_rDNA+=( "${f_map_pre_rDNA[${i}]}.stats.txt" )
      a_map_pre_pairs_stats_rDNA+=( "${d_stats}/${f_map_pre_pairs_stats_rDNA[${i}]}" )
    
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
            ===============================
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
                          f_map_pre_rDNA=${f_map_pre_rDNA[${i}]}
                     f_map_sort_pre_rDNA=${f_map_sort_pre_rDNA[${i}]}
                        f_unmap_pre_rDNA=${f_unmap_pre_rDNA[${i}]}

                  a_dedup_pre_pairs_rDNA=${a_dedup_pre_pairs_rDNA[${i}]}
                    a_dup_pre_pairs_rDNA=${a_dup_pre_pairs_rDNA[${i}]}
                    a_map_pre_pairs_rDNA=${a_map_pre_pairs_rDNA[${i}]}
               a_map_sort_pre_pairs_rDNA=${a_map_sort_pre_pairs_rDNA[${i}]}
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
              f_map_pre_pairs_stats_rDNA=${f_map_pre_pairs_stats_rDNA[${i}]}
            f_unmap_pre_pairs_stats_rDNA=${f_unmap_pre_pairs_stats_rDNA[${i}]}
            
            a_dedup_pre_pairs_stats_rDNA=${a_dedup_pre_pairs_stats_rDNA[${i}]}
              a_dup_pre_pairs_stats_rDNA=${a_dup_pre_pairs_stats_rDNA[${i}]}
              a_map_pre_pairs_stats_rDNA=${a_map_pre_pairs_stats_rDNA[${i}]}
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
    } || true
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

# echo_test "${to_merge[@]}"
[[ "${#to_merge[@]}" -ne 0 ]] &&
    {
                    unset name_1 && typeset -a name_1
                    unset name_2 && typeset -a name_2

                  unset in_1_std && typeset -a in_1_std
                  unset in_2_std && typeset -a in_2_std

                 unset in_1_rDNA && typeset -a in_1_rDNA
                 unset in_2_rDNA && typeset -a in_2_rDNA
             unset in_1_rDNA_map && typeset -a in_1_rDNA_map
             unset in_2_rDNA_map && typeset -a in_2_rDNA_map

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
          unset f_merge_rDNA_map && typeset -a f_merge_rDNA_map
          unset a_merge_rDNA_map && typeset -a a_merge_rDNA_map

        unset f_merge_stats_rDNA && typeset -a f_merge_stats_rDNA
        unset a_merge_stats_rDNA && typeset -a a_merge_stats_rDNA
    unset f_merge_stats_rDNA_map && typeset -a f_merge_stats_rDNA_map
    unset a_merge_stats_rDNA_map && typeset -a a_merge_stats_rDNA_map

        unset f_merge_cload_rDNA && typeset -a f_merge_cload_rDNA
        unset a_merge_cload_rDNA && typeset -a a_merge_cload_rDNA
    unset f_merge_cload_rDNA_map && typeset -a f_merge_cload_rDNA_map
    unset a_merge_cload_rDNA_map && typeset -a a_merge_cload_rDNA_map

         unset f_merge_zoom_rDNA && typeset -a f_merge_zoom_rDNA
         unset a_merge_zoom_rDNA && typeset -a a_merge_zoom_rDNA
     unset f_merge_zoom_rDNA_map && typeset -a f_merge_zoom_rDNA_map
     unset a_merge_zoom_rDNA_map && typeset -a a_merge_zoom_rDNA_map

        post="nodups.pairs.gz"  # echo "${post}"
    post_map="mapped.pairs.gz"  # echo "${post_map}"

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
            in_1_rDNA_map+=( $(echo "${in_1_rDNA[${i}]}" | sed "s:${post}:${post_map}:g") )       # ., "${in_1_rDNA_map[${i}]}"
            in_2_rDNA_map+=( $(echo "${in_2_rDNA[${i}]}" | sed "s:${post}:${post_map}:g") )       # ., "${in_2_rDNA_map[${i}]}"

            # [[ -f "${in_1_std[${i}]}" && -f "${in_2_std[${i}]}" ]] ||
            #     echo "Warning: \"Standard\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
                        d_merge="${d_dedup}"                                                   # echo "${d_dedup}"
               f_merge_pre_std+=( "${name_1[${i}]%_rep1}_repM.standard-${max_mismatch_std}" )  # echo "${f_merge_pre_std[${i}]}"
                   f_merge_std+=( "${f_merge_pre_std[${i}]}.${post}" )                         # echo "${f_merge_std[${i}]}"
                   a_merge_std+=( "${d_merge}/${f_merge_std[${i}]}" )                          # echo "${a_merge_std[${i}]}"

            #  For pairtools stats
                  d_merge_stats="06_stats"                                                     # echo "${d_merge_stats}"
             f_merge_stats_std+=( "${f_merge_pre_std[${i}]}.${post/pairs.gz/stats.txt}" )      # echo "${f_merge_stats_std[${i}]}"
             a_merge_stats_std+=( "${d_merge_stats}/${f_merge_stats_std[${i}]}" )              # echo "${a_merge_stats_std[${i}]}"

            #  For cooler cload pairs
                  d_merge_cload="07_cload"                                                     # echo "${d_merge_cload}"
             f_merge_cload_std+=( "${f_merge_pre_std[${i}]}.${post/pairs.gz/cload.cool}" )     # echo "${f_merge_cload_std}"
             a_merge_cload_std+=( "${d_merge_cload}/${f_merge_cload_std[${i}]}" )              # echo "${a_merge_cload_std}"

            #  For cooler zoomify
                   d_merge_zoom="08_zoom"                                                      # echo "${d_merge_zoom}"
              f_merge_zoom_std+=( "${f_merge_pre_std[${i}]}.${post/pairs.gz/mcool}" )          # echo "${f_merge_zoom_std[${i}]}"
              a_merge_zoom_std+=( "${d_merge_zoom}/${f_merge_zoom_std[${i}]}" )                # echo "${a_merge_zoom_std[${i}]}"

            # [[ -f "${in_1_rDNA[${i}]}" && -f "${in_2_rDNA[${i}]}" ]] ||
            #     echo "Warning: \"rDNA\" infiles for pairtools merge not found; stopping the operations"

            #  Setting up names, directories
                        d_merge="${d_dedup}"                                                         # echo "${d_dedup}"
              f_merge_pre_rDNA+=( "${name_1[${i}]%_rep1}_repM.keep-MM-${max_mismatch_rDNA}" )        # echo "${f_merge_pre_rDNA[${i}]}"
                  f_merge_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post}" )                              # echo "${f_merge_rDNA[${i}]}"
                  a_merge_rDNA+=( "${d_merge}/${f_merge_rDNA[${i}]}" )                               # echo "${a_merge_rDNA[${i}]}"
              f_merge_rDNA_map+=( $(echo "${f_merge_rDNA[${i}]}" | sed "s:${post}:${post_map}:g") )  # echo "${f_merge_rDNA_map[${i}]}"
              a_merge_rDNA_map+=( $(echo "${a_merge_rDNA[${i}]}" | sed "s:${post}:${post_map}:g") )  # echo "${a_merge_rDNA_map[${i}]}"

            #  For pairtools stats
                  d_merge_stats="06_stats"                                                           # echo "${d_merge_stats}"
            f_merge_stats_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post/pairs.gz/stats.txt}" )           # echo "${f_merge_stats_rDNA[${i}]}"
            a_merge_stats_rDNA+=( "${d_merge_stats}/${f_merge_stats_rDNA[${i}]}" )                   # echo "${a_merge_stats_rDNA[${i}]}"
        f_merge_stats_rDNA_map+=( $(echo "${f_merge_stats_rDNA[${i}]}" | sed "s:nodups:mapped:g") )  # echo "${f_merge_stats_rDNA_map[${i}]}"
        a_merge_stats_rDNA_map+=( $(echo "${a_merge_stats_rDNA[${i}]}" | sed "s:nodups:mapped:g") )  # echo "${a_merge_stats_rDNA_map[${i}]}"

            #  For cooler cload pairs
                  d_merge_cload="07_cload"                                                           # echo "${d_merge_cload}"
            f_merge_cload_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post/pairs.gz/cload.cool}" )          # echo "${f_merge_cload_rDNA[${i}]}"
            a_merge_cload_rDNA+=( "${d_merge_cload}/${f_merge_cload_rDNA[${i}]}" )                   # echo "${a_merge_cload_rDNA[${i}]}"
        f_merge_cload_rDNA_map+=( $(echo "${f_merge_cload_rDNA[${i}]}" | sed "s:nodups:mapped:g") )  # echo "${f_merge_cload_rDNA_map[${i}]}"
        a_merge_cload_rDNA_map+=( $(echo "${a_merge_cload_rDNA[${i}]}" | sed "s:nodups:mapped:g") )  # echo "${a_merge_cload_rDNA_map[${i}]}"

            #  For cooler zoomify
                   d_merge_zoom="08_zoom"                                                            # echo "${d_merge_zoom}"
             f_merge_zoom_rDNA+=( "${f_merge_pre_rDNA[${i}]}.${post/pairs.gz/mcool}"  )              # echo "${f_merge_zoom_rDNA[${i}]}"
             a_merge_zoom_rDNA+=( "${d_merge_zoom}/${f_merge_zoom_rDNA[${i}]}" )                     # echo "${a_merge_zoom_rDNA[${i}]}"
         f_merge_zoom_rDNA_map+=( $(echo "${f_merge_zoom_rDNA[${i}]}" | sed "s:nodups:mapped:g") )   # echo "${f_merge_zoom_rDNA_map[${i}]}"
         a_merge_zoom_rDNA_map+=( $(echo "${a_merge_zoom_rDNA[${i}]}" | sed "s:nodups:mapped:g") )   # echo "${a_merge_zoom_rDNA_map[${i}]}"
        done
    } || true
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
            =========================================
            Specific variables for merged .cool files
            =========================================
            pairtools merge: standard
            -------------------------------
                        name_1=${name_1[${i}]}
                        name_2=${name_2[${i}]}

                       d_merge=${d_merge}

                      in_1_std=${in_1_std[${i}]}
                      in_2_std=${in_2_std[${i}]}
                 in_1_rDNA_map=${in_1_rDNA_map[${i}]}
                 in_2_rDNA_map=${in_2_rDNA_map[${i}]}

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
              f_merge_rDNA_map=${f_merge_rDNA_map[${i}]}
              a_merge_rDNA_map=${a_merge_rDNA_map[${i}]}

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
        f_merge_stats_rDNA_map=${f_merge_stats_rDNA_map[${i}]}
        a_merge_stats_rDNA_map=${a_merge_stats_rDNA_map[${i}]}

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
        f_merge_cload_rDNA_map=${f_merge_cload_rDNA_map[${i}]}
        a_merge_cload_rDNA_map=${a_merge_cload_rDNA_map[${i}]}

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
        f_merge_zoom_rDNA_map=${f_merge_zoom_rDNA_map[${i}]}
        a_merge_zoom_rDNA_map=${a_merge_zoom_rDNA_map[${i}]}
            """
        done
    } || true
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

#  X.A. -----------------------------------------------------------------------
#  Create a new array "${all[@]}" from "${stem[@]}" and, if
#+ "${to_merge[@]}" is not empty, then append "${to_merge[@]}" elements
#+ to "${all[@]}"
# post="nodups.pairs.gz"  # echo "${post}"  #DUPLICATE
d_comp="05_dedup"         # echo "${d_comp}"

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


#  X.B.i/ii. ------------------------------------------------------------------
unset     all_dedup_pre_pairs_rDNA && typeset -a all_dedup_pre_pairs_rDNA       # echo_test "${all_dedup_pre_pairs_rDNA[@]}"
unset all_dedup_pre_pairs_rDNA_map && typeset -a all_dedup_pre_pairs_rDNA_map   # echo_test "${all_dedup_pre_pairs_rDNA_map[@]}"

unset          f_comp_rDNA_pre && typeset -a f_comp_rDNA_pre                    # echo_test "${f_comp_rDNA_pre[@]}"
unset              f_comp_rDNA && typeset -a f_comp_rDNA                        # echo_test "${f_comp_rDNA[@]}"
unset          f_comp_rDNA_map && typeset -a f_comp_rDNA_map                    # echo_test "${f_comp_rDNA_map[@]}"
unset              a_comp_rDNA && typeset -a a_comp_rDNA                        # echo_test "${a_comp_rDNA[@]}"
unset          a_comp_rDNA_map && typeset -a a_comp_rDNA_map                    # echo_test "${a_comp_rDNA_map[@]}"

for (( i = 0; i < ${#stem[@]}; i++ )); do
        all_dedup_pre_pairs_rDNA+=(
            "${d_comp}/${stem[${i}]}.keep-MM-${max_mismatch_rDNA}.${post}"
        )                                                                       # echo_test "${all_dedup_pre_pairs_rDNA[@]}"      # echo "${#all_dedup_pre_pairs_rDNA[@]}"
    all_dedup_pre_pairs_rDNA_map+=(
            "${d_comp}/${stem[${i}]}.keep-MM-${max_mismatch_rDNA}.${post_map}"
    )                                                                           # echo_test "${all_dedup_pre_pairs_rDNA_map[@]}"  # echo "${#all_dedup_pre_pairs_rDNA_map[@]}"
done

if [[ "${#to_merge[@]}" -ne 0 ]]; then
    for (( i = 0; i < ${#to_merge[@]}; i++ )); do
        all_dedup_pre_pairs_rDNA+=( "${a_merge_rDNA[${i}]}" )                   # echo_test "${all_dedup_pre_pairs_rDNA[@]}"      # echo "${#all_dedup_pre_pairs_rDNA[@]}"
    all_dedup_pre_pairs_rDNA_map+=( "${a_merge_rDNA_map[${i}]}" )               # echo_test "${all_dedup_pre_pairs_rDNA_map[@]}"  # echo "${#all_dedup_pre_pairs_rDNA_map[@]}"
    done
fi

for (( i = 0; i < ${#all[@]}; i++ )); do
    f_comp_rDNA_pre+=( "${all[${i}]}.keep-MM-${max_mismatch_rDNA}.only-rDNA" )  # echo_test "${f_comp_rDNA_pre[@]}"
        f_comp_rDNA+=( "${f_comp_rDNA_pre[${i}]}.${post}" )                     # echo_test "${f_comp_rDNA[@]}"
    f_comp_rDNA_map+=( "${f_comp_rDNA_pre[${i}]}.${post_map}" )                 # echo_test "${f_comp_rDNA_map[@]}"
        a_comp_rDNA+=( "${d_comp}/${f_comp_rDNA[${i}]}" )                       # echo_test "${a_comp_rDNA[@]}"
    a_comp_rDNA_map+=( "${d_comp}/${f_comp_rDNA_map[${i}]}" )                   # echo_test "${a_comp_rDNA_map[@]}"
done


#  X.C. -----------------------------------------------------------------------
unset          a_comp_std_rhdr && typeset -a a_comp_std_rhdr                    # echo_test "${a_comp_std_rhdr[@]}"

for (( i = 0; i < ${#all[@]}; i++ )); do
    a_comp_std_rhdr+=(
        "${a_comp_std[${i}]%.no-rDNA.nodups.pairs.gz}.no-rDNA.reheader.${post}"
    )
done

#  X.C.i. ---------------------------------------------------------------------
unset         a_comp_rDNA_rhdr && typeset -a a_comp_rDNA_rhdr                   # echo_test "${a_comp_rDNA_rhdr[@]}"
unset          a_comp_std_rDNA && typeset -a a_comp_std_rDNA                    # echo_test "${a_comp_std_rDNA[@]}"
unset     a_comp_std_rDNA_sort && typeset -a a_comp_std_rDNA_sort               # echo_test "${a_comp_std_rDNA_sort[@]}"
unset    a_comp_std_rDNA_cload && typeset -a a_comp_std_rDNA_cload              # echo_test "${a_comp_std_rDNA_cload[@]}"

for (( i = 0; i < ${#all[@]}; i++ )); do
    a_comp_rDNA_rhdr+=(
        "${a_comp_rDNA[${i}]%.only-rDNA.nodups.pairs.gz}.only-rDNA.reheader.${post}"
    )
    a_comp_std_rDNA+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.${post}"
    )
    a_comp_std_rDNA_sort+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.sort.${post}"
    )
    a_comp_std_rDNA_cload+=(
        "${d_cload}/$(basename ${a_comp_std[${i}]} .standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz).standard-rDNA-complete.nodups.cool"
    )
done


#  X.C.ii. --------------------------------------------------------------------
unset      a_comp_rDNA_map_rhdr && typeset -a a_comp_rDNA_map_rhdr               # echo_test "${a_comp_rDNA_map_rhdr[@]}"
unset       a_comp_std_rDNA_map && typeset -a a_comp_std_rDNA_map                # echo_test "${a_comp_std_rDNA_map[@]}"
unset  a_comp_std_rDNA_map_sort && typeset -a a_comp_std_rDNA_map_sort           # echo_test "${a_comp_std_rDNA_map_sort[@]}"
unset a_comp_std_rDNA_map_cload && typeset -a a_comp_std_rDNA_map_cload          # echo_test "${a_comp_std_rDNA_map_cload[@]}"

for (( i = 0; i < ${#all[@]}; i++ )); do
    # i=0
    a_comp_rDNA_map_rhdr+=(
        "${a_comp_rDNA_map[${i}]%.only-rDNA.mapped.pairs.gz}.only-rDNA.reheader.${post_map}"
    )
    a_comp_std_rDNA_map+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.${post_map}"
    )
    a_comp_std_rDNA_map_sort+=(
        "${a_comp_std[${i}]%.standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz}.standard-rDNA-complete.sort.${post_map}"
    )
    a_comp_std_rDNA_map_cload+=(
        "${d_cload}/$(basename ${a_comp_std[${i}]} .standard-${max_mismatch_std}.no-rDNA.nodups.pairs.gz).standard-rDNA-complete.mapped.cool"
    )
done

#  Run checks #TODO Better, expanded... -------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${all[@]}" && echo ""
        echo_test "${all_dedup_pre_pairs_std[@]}" && echo ""
        for i in "${all_dedup_pre_pairs_std[@]}"; do ls -lhaFG "${i}"; done
        echo ""

        echo_test "${f_comp_std_pre[@]}" && echo ""
        echo_test "${f_comp_std[@]}" && echo ""
        echo_test "${a_comp_std[@]}"
    } || true

run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${all[@]}" && echo ""
        echo_test "${all_dedup_pre_pairs_rDNA[@]}" && echo ""
        for i in "${all_dedup_pre_pairs_rDNA[@]}"; do ls -lhaFG "${i}"; done
        echo ""

        echo_test "${f_comp_rDNA_pre[@]}" && echo ""
        echo_test "${f_comp_rDNA[@]}" && echo ""
        echo_test "${a_comp_rDNA[@]}"
    } || true

run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        echo_test "${a_comp_std_rhdr[@]}" && echo ""
        echo_test "${a_comp_rDNA_rhdr[@]}" && echo ""
        echo_test "${a_comp_std_rDNA[@]}" && echo ""
        echo_test "${a_comp_std_rDNA_sort[@]}" && echo ""
        echo_test "${a_comp_std_rDNA_cload[@]}"
    } || true
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
submit_jobs=FALSE
for (( i = 0; i < ${#stem[@]}; i++ )); do
    # i=0

    #  Run print tests for adapter trimming of fastqs with Atria
    if [[ "${print_test}" == TRUE ]]; then
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
            echo """
            Warning: Trimmed fastqs for $(basename ${a_fq_1[${i}]%_R1.fastq.gz})
                     exist; skipping \"Step #1: Trim fastq files\"
            """
    fi

    #  Perform adapter trimming of fastqs with Atria
    if [[ "${submit_jobs}" == TRUE ]]; then
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
            echo """
            Warning: Trimmed fastqs for $(basename ${a_fq_1[${i}]%_R1.fastq.gz})
                     exist; skipping \"Step #1: Trim fastq files\"
            """
    fi
done

#TODO
#  Get rid of globs associated compgen and mv, i.e., be explicit about the
#+ files to check and move
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
    } || true


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
                echo """
                Warning: bam $(basename ${a_bam[${i}]}) exists; skipping \"Step
                         #2: Align datasets\"
                """
        done
    } || true

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
                echo """
                Warning: bam $(basename ${a_bam[${i}]}) exists; skipping \"Step
                         #2: Align datasets\"
                """
        done
    } || true
```
</details>
<br />

<a id="3-run-pairtools-parse2"></a>
### 3. Run `pairtools parse2`
<a id="code-18"></a>
#### Code
<details>
<summary><i>Code: 3. Run pairtools parse2</i></summary>

```bash
#!/bin/bash

#  Check the documentation ====================================================
check_documentation=FALSE
[[ "${check_documentation}" == TRUE ]] &&
    {
        pairtools parse --help
        pairtools parse2 --help
    } || true


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
    } ||
    echo "bam not found; skipping call to pairtools parse"

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
    } ||
    echo "bam not found; skipping call to pairtools parse"


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
    } || true


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
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    \"${a_bam[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: Standard pairs file $(basename ${a_pairs_std[${i}]})
                         exists; skipping \"Step #3: Run pairtools parse2\"
                """

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
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    \"${a_bam[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: rDNA pairs file $(basename ${a_pairs_rDNA[${i}]})
                         exists; skipping \"Step #3: Run pairtools parse2\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #3: Run pairtools parse\" did not run; stopping the
                 operation
        """
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
    --cmd-out "pbgzip -c -n ${threads}" \
    "${a_bam[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo """
                Warning: Standard pairs file $(basename ${a_pairs_std[${i}]})
                         exists; skipping \"Step #3: Run pairtools parse2\"
                """


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
    --cmd-out "pbgzip -c -n ${threads}" \
    "${a_bam[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo """
                Warning: rDNA pairs file $(basename ${a_pairs_rDNA[${i}]})
                         exists; skipping \"Step #3: Run pairtools parse2\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #3: Run pairtools parse\" did not run; stopping the
                 operation
        """
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
    } || true


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
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort_std[${i}]}\" \\
    \"${a_pairs_std[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: Sorted standard pairs $(basename ${a_sort_std[${i}]})
                         file exists; skipping \"Step #4: Run pairtools sort\"
                """

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
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort_rDNA[${i}]}\" \\
    \"${a_pairs_rDNA[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: Sorted rDNA pairs $(basename ${a_sort_rDNA[${i}]})
                         file exists; skipping \"Step #4: Run pairtools sort\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #4: Run pairtools sort\" did not run; stopping the
                 operation
        """
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
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort_std[${i}]}" \
    "${a_pairs_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo """
                Warning: Sorted standard pairs $(basename ${a_sort_std[${i}]})
                         file exists; skipping \"Step #4: Run pairtools sort\"
                """

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
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort_rDNA[${i}]}" \
    "${a_pairs_rDNA[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo """
                Warning: Sorted rDNA pairs $(basename ${a_sort_rDNA[${i}]})
                         file exists; skipping \"Step #4: Run pairtools sort\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #4: Run pairtools sort\" did not run; stopping the
                 operation
        """
    }
```
</details>
<br />

<a id="5-run-pairtools-dedup-and-pairtools-split"></a>
### 5. Run `pairtools dedup` and `pairtools split`
<a id="a-for-nodups-pairs"></a>
#### A. ...for `nodups` pairs
<a id="code-20"></a>
##### Code
<details>
<summary><i>Code: Run pairtools dedup and pairtools split for (A) `nodups` pairs</i></summary>

```bash
#!/bin/bash

#  Variables for stats outfiles #TB∆
# #  06_stats: standard
# unset  a_dedup_pre_pairs_stats_std && typeset -a a_dedup_pre_pairs_stats_std
# unset    a_dup_pre_pairs_stats_std && typeset -a a_dup_pre_pairs_stats_std
# unset  a_unmap_pre_pairs_stats_std && typeset -a a_unmap_pre_pairs_stats_std
#
# #  06_stats: rDNA
# unset a_dedup_pre_pairs_stats_rDNA && typeset -a a_dedup_pre_pairs_stats_rDNA
# unset   a_dup_pre_pairs_stats_rDNA && typeset -a a_dup_pre_pairs_stats_rDNA
# unset   a_map_pre_pairs_stats_rDNA && typeset -a a_map_pre_pairs_stats_rDNA
# unset a_unmap_pre_pairs_stats_rDNA && typeset -a a_unmap_pre_pairs_stats_rDNA


#  Run pairtools dedup ========================================================
#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dedup_pre_pairs_std[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dedup_pre_pairs_std[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    --output \"${a_dedup_pre_pairs_std[${i}]}\" \\
    --output-stats \"${a_dedup_pre_pairs_stats_std[${i}]}\" \\
    \"${a_sort_std[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: Standard dedup file $(basename ${a_dedup_pre_pairs_std[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dedup_pre_pairs_rDNA[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    --output \"${a_dedup_pre_pairs_rDNA[${i}]}\" \\
    --output-stats \"${a_dedup_pre_pairs_stats_rDNA[${i}]}\" \\
    \"${a_sort_rDNA[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: rDNA dedup file $(basename ${a_dedup_pre_pairs_rDNA[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not
                 run; stopping the operation
        """
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dedup_pre_pairs_std[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dedup_pre_pairs_std[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
    --output "${a_dedup_pre_pairs_std[${i}]}" \
    --output-stats "${a_dedup_pre_pairs_stats_std[${i}]}" \
    "${a_sort_std[${i}]}"
EOF
                    sleep 0.25
                } ||
                echo """
                Warning: Standard dedup file $(basename ${a_dedup_pre_pairs_std[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dedup_pre_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dedup_pre_pairs_rDNA[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
    --output "${a_dedup_pre_pairs_rDNA[${i}]}" \
    --output-stats "${a_dedup_pre_pairs_stats_rDNA[${i}]}" \
    "${a_sort_rDNA[${i}]}"
EOF
                    sleep 0.2
                } ||
                echo """
                Warning: rDNA dedup file $(basename ${a_dedup_pre_pairs_rDNA[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not
                 run; stopping the operation
        """
    }
```
</details>
<br />

<a id="b-for-dups-pairs"></a>
#### B. ...for `dups` pairs
<a id="code-21"></a>
##### Code
<details>
<summary><i>Code: Run pairtools dedup and pairtools split for (B) `dups` pairs</i></summary>

```bash
#!/bin/bash

#  Run pairtools dedup ========================================================
#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dup_pre_pairs_std[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dup_pre_pairs_std[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

# echo """
# #HEREDOC
# sbatch << EOF
# #!/bin/bash
#
# #SBATCH --job-name=${job_name}
# #SBATCH --nodes=1
# #SBATCH --cpus-per-task=${threads}
# #SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
# #SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"
#
# pairtools dedup \\
#     --n-proc \"${threads}\" \\
#     --max-mismatch \"${max_mismatch_std}\" \\
#     --mark-dups \\
#     --cmd-in \"pbgzip -dc -n ${threads}\" \\
#     --cmd-out \"pbgzip -c -n ${threads}\" \\
#     --output-dups \"${a_dup_pre_pairs_std[${i}]}\" \\
#     --output-stats \"${a_dup_pre_pairs_stats_std[${i}]}\" \\
#     \"${a_sort_std[${i}]}\"
# EOF
# """
                } ||
                echo """
                Warning: Standard dup file  $(basename ${a_dup_pre_pairs_std[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dup_pre_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dup_pre_pairs_rDNA[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
    --output-dups \"${a_dup_pre_pairs_rDNA[${i}]}\" \\
    --output-stats \"${a_dup_pre_pairs_stats_rDNA[${i}]}\" \\
    \"${a_sort_rDNA[${i}]}\"
EOF
"""
                } ||
                echo """
                Warning: rDNA dup file  $(basename ${a_dup_pre_pairs_rDNA[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not
                 run; stopping the operation
        """
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=1

            [[ -f "${a_sort_std[${i}]}" && ! -f "${a_dup_pre_pairs_std[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dup_pre_pairs_std[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

# #HEREDOC
# sbatch << EOF
# #!/bin/bash
#
# #SBATCH --job-name=${job_name}
# #SBATCH --nodes=1
# #SBATCH --cpus-per-task=${threads}
# #SBATCH --error="${d_dedup}/err_out/${job_name}.%A.stderr.txt"
# #SBATCH --output="${d_dedup}/err_out/${job_name}.%A.stdout.txt"
#
# pairtools dedup \
#     --n-proc "${threads}" \
#     --max-mismatch "${max_mismatch_std}" \
#     --mark-dups \
#     --cmd-in "pbgzip -dc -n ${threads}" \
#     --cmd-out "pbgzip -c -n ${threads}" \
#     --output-dups "${a_dup_pre_pairs_std[${i}]}" \
#     --output-stats "${a_dup_pre_pairs_stats_std[${i}]}" \
#     "${a_sort_std[${i}]}"
# EOF
#                     sleep 0.25
                } ||
                echo """
                Warning: Standard dup file  $(basename ${a_dup_pre_pairs_std[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """

            [[ -f "${a_sort_rDNA[${i}]}" && ! -f "${a_dup_pre_pairs_rDNA[${i}]}" ]] &&
                {
                    job_name="$(
                        echo ${a_dup_pre_pairs_rDNA[${i}]%.pairs.gz} | sed 's:\/:\.:g'
                    )"  # echo "${job_name}"

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
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
    --output-dups "${a_dup_pre_pairs_rDNA[${i}]}" \
    --output-stats "${a_dup_pre_pairs_stats_rDNA[${i}]}" \
    "${a_sort_rDNA[${i}]}"
EOF
                    sleep 0.2
                } ||
                echo """
                Warning: rDNA dup file  $(basename ${a_dup_pre_pairs_rDNA[${i}]})
                         exist; skipping \"Step #5: Run pairtools dedup and
                         pairtools split\"
                """
        done
    } ||
    {
        echo """
        Warning: \"Step #5: Run pairtools dedup and pairtools split\" did not
                 run; stopping the operation
        """
    }
```
</details>
<br />

<a id="x-general-strategy"></a>
### X. General strategy
<a id="notes-1"></a>
#### Notes
<details>
<summary><i>Notes: X. General strategy</i></summary>

```txt
#  Here, *.mapped.pairs.gz means the concatenation of
#+     - *.keep-MM-0.dups.pairs.gz
#+     - *.keep-MM-0.nodups.pairs.gz
#+ 
#+ 1. Do the above concatenation  #DONE `pairtools dedup` and `pairtools merge`
#+ 2. Sort *.mapped.pairs.gz  #DONE `pairtools merge`
#+ 3. As necessary, merge sorted
#+    a. *.nodups.pairs.gz
#+    b. *.mapped.pairs.gz 
#+ 4. Use sorted *.nodups.pairs.gz and *.mapped.pairs.gz in the
#+    "`standard-rDNA-complete`" workflow
```
</details>
<br />

<a id="x-create-keep-mm-0mappedpairsgz-files-if-applicable"></a>
### X. Create `*.keep-MM-0.mapped.pairs.gz files` if applicable
<a id="code-22"></a>
#### Code
<details>
<summary><i>Code: Create *.keep-MM-0.mapped.pairs.gz files if applicable</i></summary>

```bash
#!/bin/bash

#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=0
            [[
                  -f "${a_dedup_pre_pairs_rDNA[${i}]}" &&
                  -f "${a_dup_pre_pairs_rDNA[${i}]}" &&
                ! -f "${a_map_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="merge.${f_map_pre_rDNA[${i}]}"  # echo "${job_name}"
                    
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
    -o \"${a_map_pre_pairs_rDNA[${i}]}\" \\
    --nproc \"${threads}\" \\
    --cmd-in \"pbgzip -dc -n ${threads}\" \\
    --cmd-out \"pbgzip -c -n ${threads}\" \\
        \"${a_dedup_pre_pairs_rDNA[${i}]}\" \\
        \"${a_dup_pre_pairs_rDNA[${i}]}\"
EOF
"""
                } ||
                {
                    echo """
                    Warning: \"rDNA\" deduplicated pairs file $(basename ${a_dedup_pre_pairs_rDNA[${i}]}) not found or
                             \"rDNA\" duplicated pairs file $(basename ${a_dup_pre_pairs_rDNA[${i}]}) not found;
                             \"Step #X: Create *.keep-MM-0.mapped.pairs.gz files if applicable\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#stem[@]}; i++ )); do
            # i=0
            [[
                  -f "${a_dedup_pre_pairs_rDNA[${i}]}" &&
                  -f "${a_dup_pre_pairs_rDNA[${i}]}" &&
                ! -f "${a_map_pre_pairs_rDNA[${i}]}"
            ]] &&
                {
                    job_name="merge.${f_map_pre_rDNA[${i}]}"  # echo "${job_name}"
                    
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=${job_name}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_merge}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_merge}/err_out/${job_name}.%A.stdout.txt"

pairtools merge \
    -o "${a_map_pre_pairs_rDNA[${i}]}" \
    --nproc "${threads}" \
    --cmd-in "pbgzip -dc -n ${threads}" \
    --cmd-out "pbgzip -c -n ${threads}" \
        "${a_dedup_pre_pairs_rDNA[${i}]}" \
        "${a_dup_pre_pairs_rDNA[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: \"rDNA\" deduplicated pairs file $(basename ${a_dedup_pre_pairs_rDNA[${i}]}) not found or
                             \"rDNA\" duplicated pairs file $(basename ${a_dup_pre_pairs_rDNA[${i}]}) not found;
                             \"Step #X: Create *.keep-MM-0.mapped.pairs.gz files if applicable\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
    }
```
</details>
<br />

<a id="x-run-pairtools-merge-if-applicable"></a>
### X. Run `pairtools merge` if applicable
<a id="a-for-nodups-pairs-1"></a>
#### A. ...for `nodups` pairs
<a id="code-23"></a>
##### Code
<details>
<summary><i>Code: Run pairtools merge if applicable for (A) nodups pairs</i></summary>

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
                    echo """
                    Warning: \"Standard\" pairs file $(basename ${a_merge_std[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                    """
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
                    echo """
                    Warning: \"rDNA\" pairs file $(basename ${a_merge_rDNA[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
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
                    echo """
                    Warning: \"Standard\" pairs file $(basename ${a_merge_std[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                 """
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
                    echo """
                    Warning: \"rDNA\" pairs file $(basename ${a_merge_rDNA[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
    }
```
</details>
<br />

<a id="b-for-mapped-pairs"></a>
#### B. ...for `mapped` pairs
<a id="code-24"></a>
##### Code
<details>
<summary><i>Code: Run pairtools merge if applicable for (B) mapped pairs</i></summary>

```bash
#!/bin/bash

# in_1_rDNA_map
# in_2_rDNA_map
# f_merge_rDNA_map
# a_merge_rDNA_map
# f_merge_stats_rDNA_map
# a_merge_stats_rDNA_map
# f_merge_cload_rDNA_map
# a_merge_cload_rDNA_map
# f_merge_zoom_rDNA_map
# a_merge_zoom_rDNA_map

#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#to_merge[@]}; i++ )); do
            # i=0
            [[
                     -f "${in_1_rDNA_map[${i}]}" \
                &&   -f "${in_2_rDNA_map[${i}]}" \
                && ! -f "${a_merge_rDNA_map[${i}]}"
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
    -o \"${a_merge_rDNA_map[${i}]}\" \\
    --nproc \"${threads}\" \\
        \"${in_1_rDNA_map[${i}]}\" \\
        \"${in_2_rDNA_map[${i}]}\"
EOF
"""
                } ||
                {
                    echo """
                    Warning: \"rDNA\" pairs file $(basename ${a_merge_rDNA_map[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
    }


#  Submit jobs to SLURM -------------------------------------------------------
run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#to_merge[@]}; i++ )); do
            # i=0
            [[
                     -f "${in_1_rDNA_map[${i}]}" \
                &&   -f "${in_2_rDNA_map[${i}]}" \
                && ! -f "${a_merge_rDNA_map[${i}]}"
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
    -o "${a_merge_rDNA_map[${i}]}" \
    --nproc "${threads}" \
        "${in_1_rDNA_map[${i}]}" \
        "${in_2_rDNA_map[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: \"rDNA\" pairs file $(basename ${a_merge_rDNA_map[${i}]})
                             not found or merged pairs file exists; \"Step #X:
                             Run pairtools merge\" did not run
                    """
                }
        done
    } ||
    {
        echo """
        Warning: \"Step #X: Run pairtools merge\" did not run; stopping the
                 operation
        """
    }
```
</details>
<br />

<a id="x-run-standard-rdna-complete-processing-if-applicable"></a>
### X. Run "`standard-rDNA-complete`" processing if applicable
<a id="a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file"></a>
#### A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file
<a id="code-25"></a>
##### Code
<details>
<summary><i>Code: A. Exclude rDNA-associated cis and trans interactions from "standard.nodups" file</i></summary>

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
    } || true


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
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_std[${i}]}\" was
                             not found, or \"${a_comp_std[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.A.: Exclude rDNA-associated cis and trans
                    interactions from \"standard.nodups\" via \"pairtools select\"
                    """
                }
        done
    } || true


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
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_std[${i}]}\" was
                             not found, or \"${a_comp_std[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.A.: Exclude rDNA-associated cis and trans
                    interactions from \"standard.nodups\" via \"pairtools select\"
                    """
                }
        done
    } || true
```
</details>
<br />

<a id="b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mm--file"></a>
#### B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM-?`" file
<a id="i-for-nodups-pairs"></a>
##### i. ...for `nodups` pairs
<a id="code-26"></a>
###### Code
<details>
<summary><i>Code: B.i. Exclude all but rDNA-associated cis and trans interactions from "keep-MM-?.nodups" file</i></summary>

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

#CODESNIPPET
# "(
#     (chrom1 == 'XII' and int(pos51) >= 451526 and int(pos51) <= 468980) \
#     or \
#     (chrom2 == 'XII' and int(pos31) >= 451526 and int(pos31) <= 468980)
# )"


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
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_rDNA[${i}]}\" was
                             not found, or \"${a_comp_rDNA[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.B.i.: Exclude all but rDNA-associated
                    cis and trans interactions from 'keep-MM-?.nodups' file\"
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
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_rDNA[${i}]}\" was
                             not found, or \"${a_comp_rDNA[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.B.i.: Exclude all but rDNA-associated
                    cis and trans interactions from 'keep-MM-?.nodups' file\"
                    """
                }
        done
    }
```
</details>
<br />

<a id="ii-for-mapped-pairs"></a>
##### ii. ...for `mapped` pairs
<a id="code-27"></a>
###### Code
<details>
<summary><i>Code: B.ii. Exclude all but rDNA-associated cis and trans interactions from "keep-MM-?.mapped" file</i></summary>

```bash
#!/bin/bash

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            ., "${all_dedup_pre_pairs_rDNA_map[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            echo "${f_comp_rDNA_pre[${i}]}"
        done
    }


#  Run print tests -----------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            [[ -f "${all_dedup_pre_pairs_rDNA_map[${i}]}" && ! -f "${a_comp_rDNA_map[${i}]}" ]] &&
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
                        \"${all_dedup_pre_pairs_rDNA_map[${i}]}\" \\
                        -o \"${a_comp_rDNA_map[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_rDNA_map[${i}]}\" was
                             not found, or \"${a_comp_rDNA_map[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.B.i.: Exclude all but rDNA-associated
                    cis and trans interactions from 'keep-MM-?.mapped' file\"
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
            [[ -f "${all_dedup_pre_pairs_rDNA_map[${i}]}" && ! -f "${a_comp_rDNA_map[${i}]}" ]] &&
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
    "${all_dedup_pre_pairs_rDNA_map[${i}]}" \
    -o "${a_comp_rDNA_map[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: Either \"${all_dedup_pre_pairs_rDNA_map[${i}]}\" was
                             not found, or \"${a_comp_rDNA_map[${i}]}\" was
                             already present.

                    Thus, did not run \"Step #X.B.i.: Exclude all but rDNA-associated
                    cis and trans interactions from 'keep-MM-?.mapped' file\"
                    """
                }
        done
    }
```
</details>
<br />


<a id="c-merge-the-standardnodups-and-keep-mm-nodups-files"></a>
#### C. Merge the "`standard.nodups`" and "`keep-MM-?.nodups`" files
<a id="i-with-rdna-nodups-pairs"></a>
##### i. ...with "rDNA" `nodups` pairs
<a id="code-28"></a>
###### Code
<details>
<summary><i>Code: C.i. Merge the "standard.nodups" and "keep-MM-?.nodups" files</i></summary>

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
            } ||
            {
                echo """
                Warning: Either \"${a_comp_std[${i}]}\" or \"${a_comp_rDNA[${i}]}\" was
                         not found, or \"${a_comp_std_rDNA[${i}]}\" was already present.

                Thus, did not run \"Step #X.C.i.: Merge the \"standard.nodups\" and
                \"keep-MM-?.nodups\" files
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
    } ||
            {
                echo """
                Warning: Either \"${a_comp_std[${i}]}\" or \"${a_comp_rDNA[${i}]}\" was
                         not found, or \"${a_comp_std_rDNA[${i}]}\" was already present.

                Thus, did not run \"Step #X.C.i.: Merge the \"standard.nodups\" and
                \"keep-MM-?.nodups\" files
                """
            }
```
</details>
<br />

<a id="ii-with-rdna-mapped-pairs"></a>
##### ii. ...with "rDNA" `mapped` pairs
<a id="code-29"></a>
###### Code
<details>
<summary><i>Code: C.ii. Merge the "standard.nodups" and "keep-MM-?.mapped" files</i></summary>

```bash
#!/bin/bash

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0 && echo "${a_comp_std[${i}]}"
            ., "${a_comp_std[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0 && echo "${a_comp_rDNA_map[${i}]}"
            ., "${a_comp_rDNA_map[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0 && echo "${a_comp_std_rDNA_map[${i}]}"
            echo "${a_comp_std_rDNA_map[${i}]}"
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
                &&   -f "${a_comp_rDNA_map[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map[${i}]}"
            ]] &&
            {
                job_name="merge.$(basename ${a_comp_std_rDNA_map[${i}]} .${post})"  # echo "${job_name}"
                
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
                    --keep-first-header \\
                    --output \"${a_comp_std_rDNA_map[${i}]}\" \\
                    --nproc \"${threads}\" \\
                    --tmpdir \"${scratch}\" \\
                        \"${a_comp_std[${i}]}\" \\
                        \"${a_comp_rDNA_map[${i}]}\"
                EOF
                """
            } ||
            {
                echo """
                Warning: Either \"${a_comp_std[${i}]}\" or \"${a_comp_rDNA_map[${i}]}\" was
                         not found, or \"${a_comp_std_rDNA_map[${i}]}\" was already present.

                Thus, did not run \"Step #X.C.ii.: Merge the \"standard.nodups\" and
                \"keep-MM-?.nodups\" files
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
                &&   -f "${a_comp_rDNA_map[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map[${i}]}"
            ]] &&
            {
                job_name="merge.$(basename ${a_comp_std_rDNA_map[${i}]} .${post})"
                
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_comp}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_comp}/err_out/${job_name}.%A.stdout.txt"

pairtools merge \
    --keep-first-header \
    --output "${a_comp_std_rDNA_map[${i}]}" \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
        "${a_comp_std[${i}]}" \
        "${a_comp_rDNA_map[${i}]}"
EOF
                sleep 0.25
            } ||
            {
                echo """
                Warning: Either \"${a_comp_std[${i}]}\" or \"${a_comp_rDNA_map[${i}]}\" was
                         not found, or \"${a_comp_std_rDNA_map[${i}]}\" was already present.

                Thus, did not run \"Step #X.C.ii.: Merge the \"standard.nodups\" and
                \"keep-MM-?.nodups\" files
                """
            }
        done
    }

#NOTE 2023-1009
#  Have added flag "--keep-first-header" because was encountering the following
#+ error in the creation of some files:
#+ 
#+ ❯ cat merge.MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.pairs.gz.30129423.stderr.txt
#+ Traceback (most recent call last):
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools", line 11, in <module>
#+     sys.exit(cli())
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1130, in __call__
#+     return self.main(*args, **kwargs)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1055, in main
#+     rv = self.invoke(ctx)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1657, in invoke
#+     return _process_result(sub_ctx.command.invoke(sub_ctx))
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1404, in invoke
#+     return ctx.invoke(self.callback, **ctx.params)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 760, in invoke
#+     return __callback(*args, **kwargs)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/cli/merge.py", line 134, in merge
#+     merge_py(
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/cli/merge.py", line 194, in merge_py
#+     merged_header = headerops.merge_headers(headers)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/headerops.py", line 730, in merge_headers
#+     new_pairheader = _merge_pairheaders(pairheaders, force=False)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/headerops.py", line 686, in _merge_pairheaders
#+     chroms_merged = merge_chrom_lists(*chrom_lists)
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/headerops.py", line 576, in merge_chrom_lists
#+     chrom_list = list(_toposort(g.copy(), tie_breaker=min))
#+   File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/headerops.py", line 561, in _toposort
#+     raise ValueError("Circular dependencies exist: {} ".format(list(dag.items())))
#+ ValueError: Circular dependencies exist: [('V', {'Mito'}), ('VI', {'V'}), ('VII', {'VI'}), ('VIII', {'VII'}), ('IX', {'VIII'}), ('X', {'IX', 'VIII'}), ('XI', {'X'}), ('XII', {'XI'}), ('XIII', {'XII'}), ('XIV', {'XIII'}), ('XV', {'XIV'}), ('XVI', {'XV'}), ('Mito', {'XVI', 'IX'})]
```
</details>
<br />

<a id="6-run-pairtools-stats"></a>
### 6. Run `pairtools stats`
<a id="individual-pairs-files"></a>
#### Individual pairs files
<a id="code-30"></a>
##### Code
<details>
<summary><i>Code: 6. Run pairtools stats</i></summary>

```bash
#!/bin/bash

#TODO #LOWERPRIORITY Update/refactor

#  Do a trial run of pairtools stats ------------------------------------------
run=FALSE
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
<a id="a-containing-rdna-nodups-pairs"></a>
#### A. ...containing "rDNA" `nodups` pairs
<a id="code-31"></a>
##### Code
<details>
<summary><i>Code: 7.A. Load pairs (containing "rDNA" nodups pairs) to cooler</i></summary>

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
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA[${i}]}\" was not found, or
                             \"${a_comp_std_rDNA_cload[${i}]}\" was already present.

                    Thus, did not run \"Step 7.A. Load pairs (containing 'rDNA' nodups pairs) to cooler\"
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
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA[${i}]}\" was not found, or
                             \"${a_comp_std_rDNA_cload[${i}]}\" was already present.

                    Thus, did not run \"Step 7.A. Load pairs (containing 'rDNA' nodups pairs) to cooler\"
                    """
                }
        done
    }
```
</details>
<br />

<a id="b-containing-rdna-mapped-pairs"></a>
#### B. ...containing "rDNA" `mapped` pairs
<a id="code-32"></a>
##### Code
<details>
<summary><i>Code: 7.B. Load pairs (containing "rDNA" mapped pairs) to cooler</i></summary>

```bash
#!/bin/bash

#  Check arrays, files --------------------------------------------------------
run_check=TRUE
[[ "${run_check}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0 && ., "${a_comp_std_rDNA_map[${i}]}"
            ., "${a_comp_std_rDNA_md[${i}]}"
        done
        echo ""

        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0 && echo "${a_comp_std_rDNA_map_cload[${i}]}"
            echo "${a_comp_std_rDNA_map_cload[${i}]}"
        done
    }


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            job_name="cload.$(basename "${a_comp_std_rDNA_map_cload[${i}]}" .cool)"  # echo "${job_name}"

            [[
                     -f "${a_comp_std_rDNA_map[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map_cload[${i}]}"
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
                        \"${a_comp_std_rDNA_map[${i}]}\" \\
                        \"${a_comp_std_rDNA_map_cload[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_map[${i}]}\" was not found, or
                             \"${a_comp_std_rDNA_map_cload[${i}]}\" was already present.

                    Thus, did not run \"Step 7.B. Load pairs (containing 'rDNA' mapped pairs) to cooler\"
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
                     -f "${a_comp_std_rDNA_map[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map_cload[${i}]}"
            ]] &&
                {
                    job_name="cload.$(basename "${a_comp_std_rDNA_map_cload[${i}]}" .cool)"  # echo "${job_name}"

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
    "${a_comp_std_rDNA_map[${i}]}" \
    "${a_comp_std_rDNA_map_cload[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_map[${i}]}\" was not found, or
                             \"${a_comp_std_rDNA_map_cload[${i}]}\" was already present.

                    Thus, did not run \"Step 7.B. Load pairs (containing 'rDNA' mapped pairs) to cooler\"
                    """
                }
        done
    }
```
</details>
<br />

<a id="8-generate-a-multi-resolution-cooler-by-coarsening"></a>
### 8. Generate a multi-resolution cooler by coarsening
<a id="a-containing-rdna-nodups-pairs-1"></a>
#### A. ...containing "rDNA" `nodups` pairs
<a id="code-33"></a>
##### Code
<details>
<summary><i>Code: 8.A. Generate a multi-resolution cooler by coarsening (cool containing "rDNA" nodups pairs)</i></summary>

```bash
#!/bin/bash

#TODO Move initialization to an appropriate spot in Step #0
    unset a_comp_std_rDNA_zoom && typeset -a a_comp_std_rDNA_zoom
unset a_comp_std_rDNA_map_zoom && typeset -a a_comp_std_rDNA_map_zoom

for (( i = 0; i < ${#all[@]}; i++ )); do
    # i=0 && echo "${a_comp_std_rDNA_cload[${i}]}"
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
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_cload[${i}]}\" was not found or
                             \"${a_comp_std_rDNA_zoom[${i}]}\" already exists

                    Stopping \"8.A. Generate a multi-resolution cooler by coarsening (cool containing 'rDNA' nodups pairs)\"
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
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_cload[${i}]}\" was not found or
                             \"${a_comp_std_rDNA_zoom[${i}]}\" already exists

                    Stopping \"8.A. Generate a multi-resolution cooler by coarsening (cool containing 'rDNA' nodups pairs)\"
                    """
                }
        done
    }
```
</details>
<br />

<a id="b-containing-rdna-mapped-pairs-1"></a>
#### B. ...containing "rDNA" `mapped` pairs
<a id="code-34"></a>
##### Code
<details>
<summary><i>Code: 8.B. Generate a multi-resolution cooler by coarsening (cool containing "rDNA" mapped pairs)</i></summary>

```bash
#!/bin/bash

#TODO Move initialization to an appropriate spot in Step #0
unset a_comp_std_rDNA_map_zoom && typeset -a a_comp_std_rDNA_map_zoom

for (( i = 0; i < ${#all[@]}; i++ )); do
    # i=0 && echo "${a_comp_std_rDNA_map_cload[${i}]}"
    a_comp_std_rDNA_map_zoom+=( "${d_zoom}/$(basename ${a_comp_std_rDNA_map_cload[${i}]} .cool).mcool" )
done
# echo_test "${a_comp_std_rDNA_map_zoom[@]}"


#  Run print tests ------------------------------------------------------------
print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
    {
        for (( i = 0; i < ${#all[@]}; i++ )); do
            # i=0
            
            [[
                     -f "${a_comp_std_rDNA_map_cload[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map_zoom[${i}]}"
            ]] &&
                {
                    job_name="zoom.$(basename "${a_comp_std_rDNA_map_zoom[${i}]}" .mcool)"  # echo "${job_name}"
                    
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
                        --out \"${a_comp_std_rDNA_map_zoom[${i}]}\" \\
                        --nproc ${threads} \\
                        --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \\
                        --balance \\
                        --balance-args '--max-iters 2000' \\
                        \"${a_comp_std_rDNA_map_cload[${i}]}\"
                    EOF
                    """
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_map_cload[${i}]}\" was not found or
                             \"${a_comp_std_rDNA_map_zoom[${i}]}\" already exists

                    Stopping \"8.B. Generate a multi-resolution cooler by coarsening (cool containing 'rDNA' mapped pairs)\"
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
                     -f "${a_comp_std_rDNA_map_cload[${i}]}" \
                && ! -f "${a_comp_std_rDNA_map_zoom[${i}]}"
            ]] &&
                {
                    job_name="zoom.$(basename "${a_comp_std_rDNA_map_zoom[${i}]}" .mcool)"  # echo "${job_name}"
#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name="${job_name}"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error="${d_zoom}/err_out/${job_name}.%A.stderr.txt"
#SBATCH --output="${d_zoom}/err_out/${job_name}.%A.stdout.txt"

cooler zoomify \
    --out "${a_comp_std_rDNA_map_zoom[${i}]}" \
    --nproc ${threads} \
    --resolutions 50,100,200,400,800,1600,3200,6400,12800,25600,51200,102400 \
    --balance \
    --balance-args '--max-iters 2000' \
    "${a_comp_std_rDNA_map_cload[${i}]}"
EOF
                    sleep 0.2
                } ||
                {
                    echo """
                    Warning: Either \"${a_comp_std_rDNA_map_cload[${i}]}\" was not found or
                             \"${a_comp_std_rDNA_map_zoom[${i}]}\" already exists

                    Stopping \"8.B. Generate a multi-resolution cooler by coarsening (cool containing 'rDNA' mapped pairs)\"
                    """
                }
        done
    }
```
</details>
<br />


