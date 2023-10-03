
`#rough-draft_plot-work_1.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Review what files we have with what resolutions](#review-what-files-we-have-with-what-resolutions)
    1. [On the files as described in `work_download-data.md`](#on-the-files-as-described-in-work_download-datamd)
        1. [Notes](#notes)
    1. [On the files in `2023-0307_work_Micro-C_align-process`](#on-the-files-in-2023-0307_work_micro-c_align-process)
        1. [Code](#code)
        1. [Printed](#printed)
        1. [Notes](#notes-1)
    1. [What are the resolutions associated with the files in `2023-0307_work_Micro-C_align-process/08_zoom`?](#what-are-the-resolutions-associated-with-the-files-in-2023-0307_work_micro-c_align-process08_zoom)
        1. [Code](#code-1)
        1. [Printed](#printed-1)
1. [Set up virtual environment for analyses with `FAN-C`](#set-up-virtual-environment-for-analyses-with-fan-c)
    1. [Code](#code-2)
    1. [Printed](#printed-2)
1. [Learn to use `fanc compare`, draw some preliminary plots](#learn-to-use-fanc-compare-draw-some-preliminary-plots)
    1. [Code](#code-3)
    1. [Printed](#printed-3)
    1. [Help](#help)
1. [Set up virtual environment for analyses with `HiCExplorer`](#set-up-virtual-environment-for-analyses-with-hicexplorer)
    1. [Code](#code-4)
    1. [Printed](#printed-4)
1. [Learn to use `hicexplorer`, draw some preliminary plots](#learn-to-use-hicexplorer-draw-some-preliminary-plots)
    1. [Take the log2 ratio of Q over G2](#take-the-log2-ratio-of-q-over-g2)
        1. [Code](#code-5)
    1. [Take the log2 ratio of Q over G1](#take-the-log2-ratio-of-q-over-g1)
        1. [Code](#code-6)
    1. [Take the log2 ratio of G2 over G1](#take-the-log2-ratio-of-g2-over-g1)
        1. [Code](#code-7)
    1. [Help](#help-1)
    1. [Notes](#notes-2)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="review-what-files-we-have-with-what-resolutions"></a>
## Review what files we have with what resolutions
<a id="on-the-files-as-described-in-work_download-datamd"></a>
### On the files as described in `work_download-data.md`
<a id="notes"></a>
#### Notes
<details>
<summary><i>Notes: On the files as described in `work_download-data.md`</i></summary>
<br />

*Information copied over from [`work_download-data.md`](/Users/kalavatt/projects-etc/2023_rDNA/results/2023-0228_work_fastqs_download/work_download-data.md)*

PRJNA493742 is Micro-C XL (Swygert et al., *Mol Cell* 2019)
```bash
SRR7939017="MC_log_WT_repM"
SRR7939018="MC_Q_WT_repM"
SRR7939019="MC_Q_SMC4-off_repM"
SRR7939020="MC_Q_SMC4-on_repM"
```

PRJNA702747 is Micro-C XL (Swygert et al., *eLife* 2021)
```bash
SRR13736654=MC_log_no-DSG_repM
SRR13736656=MC_Q_5toA_repM
SRR13736659=MC_Q_WT_repM
SRR13736655=MC_log_WT_repM
SRR13736658=MC_Q_no-DSG_repM
SRR13736657=MC_Q_HHF2_repM
SRR13736661=MC_Q_TSA_repM
SRR13736660=MC_Q_R17R19A_repM
```

PRJNA636358 is Micro-C (Constantino et al., eLife *eLife* 2020)
```bash
SRR11893084="MC_nz_WT_rep1"
SRR11893085="MC_nz_WT_rep2"
SRR11893086="MC_nz_MCD1-AID_rep1"
SRR11893087="MC_nz_MCD1-AID_rep2"
SRR11893088="MC_nz_BRN1-AID_rep1"
SRR11893089="MC_nz_BRN1-AID_rep2"
SRR11893090="MC_nz_MCD1-AID-BRN1-AID_rep1"
SRR11893091="MC_nz_MCD1-AID-BRN1-AID_rep2"
SRR11893092="MC_nz_WPL1-AID_rep1"
SRR11893093="MC_nz_WPL1-AID_rep2"
SRR11893094="MC_nz_PDS5-AID_rep0"
SRR11893095="MC_30C-a15_WT_rep1"
SRR11893096="MC_30C-a15_WT_rep2"
SRR11893097="MC_30C-a30_WT_rep1"
SRR11893098="MC_30C-a30_WT_rep2"
SRR11893099="MC_30C-a45_WT_rep1"
SRR11893100="MC_30C-a45_WT_rep2"
SRR11893101="MC_30C-a60_WT_rep1"
SRR11893102="MC_30C-a60_WT_rep2"
SRR11893103="MC_30C-a75_WT_rep1"
SRR11893104="MC_30C-a75_WT_rep2"
SRR11893105="MC_30C-a90_WT_rep1"
SRR11893106="MC_30C-a90_WT_rep2"
SRR11893107="MC_23C-a15_WT_rep0"
SRR11893108="MC_23C-a30_WT_rep0"
SRR11893109="MC_23C-a45_WT_rep0"
SRR11893110="MC_23C-a60_WT_rep0"
SRR11893111="MC_23C-a75_WT_rep0"
SRR11893112="MC_23C-a90_WT_rep0"
SRR11893113="MC_23C-a105_WT_rep0"
SRR11893114="MC_23C-a120_WT_rep0"
```
</details>
<br />

<a id="on-the-files-in-2023-0307_work_micro-c_align-process"></a>
### On the files in `2023-0307_work_Micro-C_align-process`
<a id="code"></a>
#### Code
<details>
<summary><i>Code: On the files in `2023-0307_work_Micro-C_align-process`</i></summary>

```bash
#!/bin/bash

[[ "$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ]] &&
    cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    true

ls -lhaFG 08_zoom/
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: On the files in `2023-0307_work_Micro-C_align-process`</i></summary>

```txt
❯ [[ "$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ]] &&
>     cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
>     true


❯ ls -lhaFG 08_zoom/
total 1.6G
drwxrws---  3 kalavatt  494 Aug  6 17:21 ./
drwxrws--- 12 kalavatt  717 Sep 29 11:03 ../
drwxrws---  2 kalavatt 1.2K Aug  6 17:20 err_out/
-rw-rw----  1 kalavatt 236M Aug  6 17:25 MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 215M Aug  6 17:28 MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 195M Aug  6 17:28 MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 343M Aug  6 17:29 MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 101M Aug  6 17:30 MC-2020_nz_WT_rep1.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 123M Aug  6 17:33 MC-2020_nz_WT_rep2.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 183M Aug  6 17:35 MC-2020_nz_WT_repM.standard-rDNA-complete.mcool
```
</details>
<br />

<a id="notes-1"></a>
#### Notes
<details>
<summary><i>Notes: On the files in `2023-0307_work_Micro-C_align-process`</i></summary>
<br />

We currently don't have Sarah's unmerged biological replicates for the Q data, and they're not available via public data repositories; however, they remember that they were amidst Sarah's files on [Motuz](https://motuz.fredhutch.org/login).

- [ ] Get and process them `#MAYBE`
- [ ] Consider MDS projections of Q, G1, G2/M biological replicates for all interactions and only rDNA interactions `#MAYBE`
</details>
<br />

<a id="what-are-the-resolutions-associated-with-the-files-in-2023-0307_work_micro-c_align-process08_zoom"></a>
### What are the resolutions associated with the files in `2023-0307_work_Micro-C_align-process/08_zoom`?
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: What are the resolutions associated with the files in `2023-0307_work_Micro-C_align-process/08_zoom`?</i></summary>

```bash
#!/bin/bash

[[ ${CONDA_DEFAULT_ENV} != base ]] && conda deactivate || true
source activate pairtools_env

f_cool=08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
cooler ls ${f_cool}  #NOTE Go with 50-bp resolution, the lowest to have been balanced
cooler attrs ${f_cool}
cooler tree ${f_cool}
cooler info ${f_cool}::/resolutions/6400

#  Check that there are interactions associated with example regions
# cooler dump ${f_cool}::/resolutions/6400 -r "I:100000-200000" | head
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: What are the resolutions associated with the files in `2023-0307_work_Micro-C_align-process/08_zoom`?</i></summary>

```txt
❯ [[ ${CONDA_DEFAULT_ENV} != base ]] && conda deactivate || true
❯ source activate pairtools_env


❯ f_cool=08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
❯ cooler ls ${f_cool}
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/25
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/50
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/100
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/200
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/400
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/800
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/1600
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/3200
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/6400
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/12800
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/25600
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/51200
08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool::/resolutions/102400


...


❯ cooler info ${f_cool}::/resolutions/6400
{
    "bin-size": 6400,
    "bin-type": "fixed",
    "creation-date": "2023-08-06T17:23:14.571393",
    "format": "HDF5::Cooler",
    "format-url": "https://github.com/open2c/cooler",
    "format-version": 3,
    "generated-by": "cooler-0.9.2",
    "genome-assembly": "unknown",
    "nbins": 1909,
    "nchroms": 17,
    "nnz": 1716800,
    "storage-mode": "symmetric-upper",
    "sum": 33732166
}
```
</details>
<br />
<br />

<a id="set-up-virtual-environment-for-analyses-with-fan-c"></a>
## Set up virtual environment for analyses with `FAN-C`
<a id="code-2"></a>
### Code
<details>
<summary><i>Code: Set up virtual environment for analyses with `FAN-C`</i></summary>

```bash
#!/bin/bash

env_name="fanc_env"
install_env=TRUE
if [[ "${install_env}" == TRUE ]]; then
    mamba create \
        -n ${env_name} \
        -c conda-forge \
            parallel \
            pip \
            python==3.11
    
    source activate ${env_name}
    mamba install -c bioconda rename

    [[ $(pwd) != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/" ]] &&
        cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/" ||
        true

    git clone http://www.github.com/vaquerizaslab/fanc
    cd fanc
    pip install -e .
fi
```
</details>
<br />

<a id="printed-2"></a>
### Printed
<details>
<summary><i>Printed: Set up virtual environment for analyses with `FAN-C`</i></summary>

```txt
❯ env_name="fanc_env"
❯ mamba create \
>    -n ${env_name} \
>    -c conda-forge \
>        parallel \
>        pip \
>        python==3.11

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel', 'pip', 'python==3.11']

conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
pkgs/main/linux-64                                            No change
pkgs/r/linux-64                                               No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/fanc_env

  Updating specs:

   - parallel
   - pip
   - python==3.11


  Package               Version  Build               Channel                    Size
──────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex           0.1  conda_forge         conda-forge/linux-64     Cached
  + _openmp_mutex           4.5  2_gnu               conda-forge/linux-64     Cached
  + bzip2                 1.0.8  h7f98852_4          conda-forge/linux-64     Cached
  + ca-certificates   2023.7.22  hbcca054_0          conda-forge/linux-64     Cached
  + ld_impl_linux-64       2.40  h41732ed_0          conda-forge/linux-64     Cached
  + libffi                3.4.2  h7f98852_5          conda-forge/linux-64     Cached
  + libgcc-ng            13.2.0  h807b86a_2          conda-forge/linux-64      771kB
  + libgomp              13.2.0  h807b86a_2          conda-forge/linux-64      421kB
  + libnsl                2.0.0  hd590300_1          conda-forge/linux-64       33kB
  + libsqlite            3.43.0  h2797004_0          conda-forge/linux-64      841kB
  + libuuid              2.38.1  h0b41bf4_0          conda-forge/linux-64     Cached
  + libzlib              1.2.13  hd590300_5          conda-forge/linux-64     Cached
  + ncurses                 6.4  hcb278e6_0          conda-forge/linux-64     Cached
  + openssl               3.1.3  hd590300_0          conda-forge/linux-64        3MB
  + parallel           20230922  ha770c72_0          conda-forge/linux-64        2MB
  + perl                 5.32.1  4_hd590300_perl5    conda-forge/linux-64       13MB
  + pip                  23.2.1  pyhd8ed1ab_0        conda-forge/noarch          1MB
  + python               3.11.0  he550d4f_1_cpython  conda-forge/linux-64     Cached
  + readline                8.2  h8228510_1          conda-forge/linux-64     Cached
  + setuptools           68.2.2  pyhd8ed1ab_0        conda-forge/noarch        464kB
  + tk                   8.6.13  h2797004_0          conda-forge/linux-64        3MB
  + tzdata                2023c  h71feb2d_0          conda-forge/noarch       Cached
  + wheel                0.41.2  pyhd8ed1ab_0        conda-forge/noarch         57kB
  + xz                    5.2.6  h166bdaf_0          conda-forge/linux-64     Cached

  Summary:

  Install: 24 packages

  Total download: 25MB

──────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libnsl                                              33.2kB @ 363.6kB/s  0.1s
libgcc-ng                                          771.1kB @   6.8MB/s  0.1s
libgomp                                            421.1kB @   3.5MB/s  0.1s
tk                                                   3.3MB @  25.5MB/s  0.2s
wheel                                               57.5kB @ 440.9kB/s  0.1s
openssl                                              2.6MB @  17.3MB/s  0.2s
libsqlite                                          840.9kB @   4.1MB/s  0.1s
pip                                                  1.4MB @   6.4MB/s  0.1s
setuptools                                         464.4kB @   2.2MB/s  0.1s
parallel                                             1.9MB @   6.5MB/s  0.2s
perl                                                13.3MB @  34.0MB/s  0.3s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate fanc_env

To deactivate an active environment, use

     $ mamba deactivate


❯ source activate ${env_name}
❯ mamba install -c bioconda rename

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['rename']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/fanc_env

  Updating specs:

   - rename
   - ca-certificates
   - openssl


  Package   Version  Build       Channel               Size
─────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────

  + rename    1.601  hdfd78af_1  bioconda/noarch     Cached

  Summary:

  Install: 1 packages

  Total download: 0 B

─────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ [[ $(pwd) != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/" ]] &&
>     cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/" ||
>     true


❯ git clone http://www.github.com/vaquerizaslab/fanc
Cloning into 'fanc'...
warning: redirecting to https://github.com/vaquerizaslab/fanc.git/
remote: Enumerating objects: 22182, done.
remote: Counting objects: 100% (1552/1552), done.
remote: Compressing objects: 100% (409/409), done.
remote: Total 22182 (delta 1115), reused 1534 (delta 1107), pack-reused 20630
Receiving objects: 100% (22182/22182), 428.93 MiB | 12.71 MiB/s, done.
Resolving deltas: 100% (15729/15729), done.
Checking out files: 100% (692/692), done.


❯ cd fanc
/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fanc


❯ pip install -e .
Obtaining file:///fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/src/fanc
  Preparing metadata (setup.py) ... done
Collecting numpy>=1.16.0 (from fanc==0.9.26)
  Obtaining dependency information for numpy>=1.16.0 from https://files.pythonhosted.org/packages/c4/36/161e2f8110f8c49e59f6107bd6da4257d30aff9f06373d0471811f73dcc5/numpy-1.26.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading numpy-1.26.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (58 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 58.5/58.5 kB 1.0 MB/s eta 0:00:00
Collecting scipy (from fanc==0.9.26)
  Obtaining dependency information for scipy from https://files.pythonhosted.org/packages/ef/1b/7538792254aec6850657d5b940fd05fe60582af829ffe40d6c054f065f34/scipy-1.11.3-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading scipy-1.11.3-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (60 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 60.4/60.4 kB 2.7 MB/s eta 0:00:00
Collecting pillow (from fanc==0.9.26)
  Obtaining dependency information for pillow from https://files.pythonhosted.org/packages/c6/43/f2f31fd9d8282ac9724f5f2b6534ffd556dc7b67b64f239167e175e5b5c5/Pillow-10.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading Pillow-10.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.5 kB)
Collecting matplotlib>=3.1.0 (from fanc==0.9.26)
  Obtaining dependency information for matplotlib>=3.1.0 from https://files.pythonhosted.org/packages/65/5b/3b8fd7d66043f0638a35fa650570cbe69efd42fe169e5024f9307598b47e/matplotlib-3.8.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading matplotlib-3.8.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (5.8 kB)
Collecting pandas>=0.15.0 (from fanc==0.9.26)
  Obtaining dependency information for pandas>=0.15.0 from https://files.pythonhosted.org/packages/de/ce/b5d9c7ce1aaf9023b823c81932a50cd5e8f407198a696b0d1c6025a40b03/pandas-2.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading pandas-2.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (18 kB)
Collecting pysam>=0.9.1 (from fanc==0.9.26)
  Downloading pysam-0.21.0-cp311-cp311-manylinux_2_24_x86_64.whl (20.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 20.1/20.1 MB 30.9 MB/s eta 0:00:00
Collecting biopython (from fanc==0.9.26)
  Downloading biopython-1.81-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.1/3.1 MB 16.2 MB/s eta 0:00:00
Collecting pytest (from fanc==0.9.26)
  Obtaining dependency information for pytest from https://files.pythonhosted.org/packages/df/d0/e192c4275aecabf74faa1aacd75ef700091913236ec78b1a98f62a2412ee/pytest-7.4.2-py3-none-any.whl.metadata
  Downloading pytest-7.4.2-py3-none-any.whl.metadata (7.9 kB)
Collecting msgpack>=1.0.0 (from fanc==0.9.26)
  Obtaining dependency information for msgpack>=1.0.0 from https://files.pythonhosted.org/packages/df/09/dee50913ba5cc047f7fd7162f09453a676e7935c84b3bf3a398e12108677/msgpack-1.0.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading msgpack-1.0.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.1 kB)
Collecting msgpack-numpy>=0.4.6.1 (from fanc==0.9.26)
  Downloading msgpack_numpy-0.4.8-py2.py3-none-any.whl (6.9 kB)
Collecting scikit-learn (from fanc==0.9.26)
  Obtaining dependency information for scikit-learn from https://files.pythonhosted.org/packages/8f/87/5969092159207f583481ad80a03f09e2d4af1ebd197f4530ca4e906c947e/scikit_learn-1.3.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading scikit_learn-1.3.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (11 kB)
Collecting progressbar2 (from fanc==0.9.26)
  Downloading progressbar2-4.2.0-py2.py3-none-any.whl (27 kB)
Collecting pybedtools (from fanc==0.9.26)
  Downloading pybedtools-0.9.1.tar.gz (12.5 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.5/12.5 MB 3.2 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Collecting pyBigWig (from fanc==0.9.26)
  Downloading pyBigWig-0.3.22-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (213 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 213.3/213.3 kB 1.5 MB/s eta 0:00:00
Collecting PyYAML>=5.1 (from fanc==0.9.26)
  Obtaining dependency information for PyYAML>=5.1 from https://files.pythonhosted.org/packages/7b/5e/efd033ab7199a0b2044dab3b9f7a4f6670e6a52c089de572e928d2873b06/PyYAML-6.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading PyYAML-6.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (2.1 kB)
Collecting tables>=3.5.1 (from fanc==0.9.26)
  Downloading tables-3.8.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (6.5 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.5/6.5 MB 2.3 MB/s eta 0:00:00
Collecting seaborn (from fanc==0.9.26)
  Downloading seaborn-0.12.2-py3-none-any.whl (293 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 293.3/293.3 kB 2.8 MB/s eta 0:00:00
Collecting future (from fanc==0.9.26)
  Downloading future-0.18.3.tar.gz (840 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 840.9/840.9 kB 2.4 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Collecting gridmap>=0.14.0 (from fanc==0.9.26)
  Downloading gridmap-0.15.0.tar.gz (41 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 41.6/41.6 kB 1.5 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Collecting intervaltree (from fanc==0.9.26)
  Downloading intervaltree-3.1.0.tar.gz (32 kB)
  Preparing metadata (setup.py) ... done
Collecting genomic_regions>=0.0.10 (from fanc==0.9.26)
  Downloading genomic_regions-0.0.10.tar.gz (23 kB)
  Preparing metadata (setup.py) ... done
Collecting scikit-image>=0.15.0 (from fanc==0.9.26)
  Obtaining dependency information for scikit-image>=0.15.0 from https://files.pythonhosted.org/packages/22/c3/c5f3c351d6337a18d07c3fb04475626c106cd3dc3d59b85ec50d07656db0/scikit_image-0.21.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading scikit_image-0.21.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (14 kB)
Collecting cooler>=0.8.0 (from fanc==0.9.26)
  Obtaining dependency information for cooler>=0.8.0 from https://files.pythonhosted.org/packages/92/32/42e54d16653343108a3af8ec442ca61055e81586217e3183a97473b5e391/cooler-0.9.3-py3-none-any.whl.metadata
  Downloading cooler-0.9.3-py3-none-any.whl.metadata (8.2 kB)
Collecting h5py (from fanc==0.9.26)
  Obtaining dependency information for h5py from https://files.pythonhosted.org/packages/a7/d9/ac660616671e30d70c091e46ed4fdc50df48ca79b1ac99df5499a45de128/h5py-3.9.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading h5py-3.9.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (2.5 kB)
Collecting Deprecated (from fanc==0.9.26)
  Obtaining dependency information for Deprecated from https://files.pythonhosted.org/packages/20/8d/778b7d51b981a96554f29136cd59ca7880bf58094338085bcf2a979a0e6a/Deprecated-1.2.14-py2.py3-none-any.whl.metadata
  Downloading Deprecated-1.2.14-py2.py3-none-any.whl.metadata (5.4 kB)
Collecting asciitree (from cooler>=0.8.0->fanc==0.9.26)
  Downloading asciitree-0.3.3.tar.gz (4.0 kB)
  Preparing metadata (setup.py) ... done
Collecting click>=7 (from cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for click>=7 from https://files.pythonhosted.org/packages/00/2e/d53fa4befbf2cfa713304affc7ca780ce4fc1fd8710527771b58311a3229/click-8.1.7-py3-none-any.whl.metadata
  Downloading click-8.1.7-py3-none-any.whl.metadata (3.0 kB)
Collecting cytoolz (from cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for cytoolz from https://files.pythonhosted.org/packages/bc/c4/263774e624e3321575b04536da3d1026a4913cc57140ad2ab13a42f3dd74/cytoolz-0.12.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading cytoolz-0.12.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.5 kB)
Collecting multiprocess (from cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for multiprocess from https://files.pythonhosted.org/packages/e7/41/96ac938770ba6e7d5ae1d8c9cafebac54b413549042c6260f0d0a6ec6622/multiprocess-0.70.15-py311-none-any.whl.metadata
  Downloading multiprocess-0.70.15-py311-none-any.whl.metadata (7.2 kB)
Collecting pyfaidx (from cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for pyfaidx from https://files.pythonhosted.org/packages/83/bf/269e9b3a18dfda8a22a2d76decf98725f28ff930bd449f87a194625ba913/pyfaidx-0.7.2.2-py3-none-any.whl.metadata
  Downloading pyfaidx-0.7.2.2-py3-none-any.whl.metadata (25 kB)
Collecting simplejson (from cooler>=0.8.0->fanc==0.9.26)
  Downloading simplejson-3.19.1-cp311-cp311-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (144 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 144.7/144.7 kB 2.1 MB/s eta 0:00:00
Collecting cloudpickle (from gridmap>=0.14.0->fanc==0.9.26)
  Downloading cloudpickle-2.2.1-py3-none-any.whl (25 kB)
Collecting drmaa (from gridmap>=0.14.0->fanc==0.9.26)
  Downloading drmaa-0.7.9.tar.gz (30 kB)
  Preparing metadata (setup.py) ... done
Collecting psutil>=2.0.0 (from gridmap>=0.14.0->fanc==0.9.26)
  Downloading psutil-5.9.5-cp36-abi3-manylinux_2_12_x86_64.manylinux2010_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (282 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 282.1/282.1 kB 2.4 MB/s eta 0:00:00
Collecting pyzmq (from gridmap>=0.14.0->fanc==0.9.26)
  Obtaining dependency information for pyzmq from https://files.pythonhosted.org/packages/7a/3b/a4ad590411a582254c188dd2a0df1404004edf9923672a6063c87a6eaf69/pyzmq-25.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading pyzmq-25.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.9 kB)
Collecting contourpy>=1.0.1 (from matplotlib>=3.1.0->fanc==0.9.26)
  Obtaining dependency information for contourpy>=1.0.1 from https://files.pythonhosted.org/packages/b7/f6/78f60fa0b6ae64971178e2542e8b3ad3ba5f4f379b918ab7b18038a3f897/contourpy-1.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading contourpy-1.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (5.9 kB)
Collecting cycler>=0.10 (from matplotlib>=3.1.0->fanc==0.9.26)
  Obtaining dependency information for cycler>=0.10 from https://files.pythonhosted.org/packages/2b/b3/70c33027c4918c10ccf176014b38f8b91cb18ac018a78854543a4fc72609/cycler-0.12.0-py3-none-any.whl.metadata
  Downloading cycler-0.12.0-py3-none-any.whl.metadata (3.8 kB)
Collecting fonttools>=4.22.0 (from matplotlib>=3.1.0->fanc==0.9.26)
  Obtaining dependency information for fonttools>=4.22.0 from https://files.pythonhosted.org/packages/ca/3b/9554bcd5005f994ab65e8238c713e62ddfd30e1d003a0b8e77193a0c2356/fonttools-4.43.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading fonttools-4.43.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (151 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 151.9/151.9 kB 2.4 MB/s eta 0:00:00
Collecting kiwisolver>=1.0.1 (from matplotlib>=3.1.0->fanc==0.9.26)
  Obtaining dependency information for kiwisolver>=1.0.1 from https://files.pythonhosted.org/packages/17/ba/17a706b232308e65f57deeccae503c268292e6a091313f6ce833a23093ea/kiwisolver-1.4.5-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading kiwisolver-1.4.5-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.4 kB)
Collecting packaging>=20.0 (from matplotlib>=3.1.0->fanc==0.9.26)
  Downloading packaging-23.1-py3-none-any.whl (48 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 48.9/48.9 kB 1.9 MB/s eta 0:00:00
Collecting pyparsing>=2.3.1 (from matplotlib>=3.1.0->fanc==0.9.26)
  Obtaining dependency information for pyparsing>=2.3.1 from https://files.pythonhosted.org/packages/39/92/8486ede85fcc088f1b3dba4ce92dd29d126fd96b0008ea213167940a2475/pyparsing-3.1.1-py3-none-any.whl.metadata
  Downloading pyparsing-3.1.1-py3-none-any.whl.metadata (5.1 kB)
Collecting python-dateutil>=2.7 (from matplotlib>=3.1.0->fanc==0.9.26)
  Using cached python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
Collecting pytz>=2020.1 (from pandas>=0.15.0->fanc==0.9.26)
  Obtaining dependency information for pytz>=2020.1 from https://files.pythonhosted.org/packages/32/4d/aaf7eff5deb402fd9a24a1449a8119f00d74ae9c2efa79f8ef9994261fc2/pytz-2023.3.post1-py2.py3-none-any.whl.metadata
  Downloading pytz-2023.3.post1-py2.py3-none-any.whl.metadata (22 kB)
Collecting tzdata>=2022.1 (from pandas>=0.15.0->fanc==0.9.26)
  Downloading tzdata-2023.3-py2.py3-none-any.whl (341 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 341.8/341.8 kB 2.9 MB/s eta 0:00:00
Collecting six (from pybedtools->fanc==0.9.26)
  Using cached six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting cython (from pysam>=0.9.1->fanc==0.9.26)
  Obtaining dependency information for cython from https://files.pythonhosted.org/packages/d9/fc/3a49ab49ae556b7d644a2d3082f01082bb902befe3e398f11d675d6c2ad0/Cython-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Using cached Cython-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (3.1 kB)
Collecting networkx>=2.8 (from scikit-image>=0.15.0->fanc==0.9.26)
  Downloading networkx-3.1-py3-none-any.whl (2.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.1/2.1 MB 1.8 MB/s eta 0:00:00
Collecting imageio>=2.27 (from scikit-image>=0.15.0->fanc==0.9.26)
  Obtaining dependency information for imageio>=2.27 from https://files.pythonhosted.org/packages/1a/55/7a7646d7cc42e771d689d39930afcbe57b3d82267544ebabead57ffb86d1/imageio-2.31.4-py3-none-any.whl.metadata
  Downloading imageio-2.31.4-py3-none-any.whl.metadata (4.6 kB)
Collecting tifffile>=2022.8.12 (from scikit-image>=0.15.0->fanc==0.9.26)
  Obtaining dependency information for tifffile>=2022.8.12 from https://files.pythonhosted.org/packages/f5/72/68ea763b5f3e3d9871492683059ed4724fd700dbe54aa03cdda7a9692129/tifffile-2023.9.26-py3-none-any.whl.metadata
  Downloading tifffile-2023.9.26-py3-none-any.whl.metadata (30 kB)
Collecting PyWavelets>=1.1.1 (from scikit-image>=0.15.0->fanc==0.9.26)
  Downloading PyWavelets-1.4.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (7.0 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.0/7.0 MB 1.7 MB/s eta 0:00:00
Collecting lazy_loader>=0.2 (from scikit-image>=0.15.0->fanc==0.9.26)
  Obtaining dependency information for lazy_loader>=0.2 from https://files.pythonhosted.org/packages/a1/c3/65b3814e155836acacf720e5be3b5757130346670ac454fee29d3eda1381/lazy_loader-0.3-py3-none-any.whl.metadata
  Downloading lazy_loader-0.3-py3-none-any.whl.metadata (4.3 kB)
Collecting numexpr>=2.6.2 (from tables>=3.5.1->fanc==0.9.26)
  Obtaining dependency information for numexpr>=2.6.2 from https://files.pythonhosted.org/packages/6a/3e/fa33d67bc4f5ee05f5bc2ce65fd1a796211f0b759cec3f60ded2763013b9/numexpr-2.8.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading numexpr-2.8.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (8.7 kB)
Collecting blosc2~=2.0.0 (from tables>=3.5.1->fanc==0.9.26)
  Downloading blosc2-2.0.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.9 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.9/3.9 MB 1.6 MB/s eta 0:00:00
Collecting py-cpuinfo (from tables>=3.5.1->fanc==0.9.26)
  Downloading py_cpuinfo-9.0.0-py3-none-any.whl (22 kB)
Collecting wrapt<2,>=1.10 (from Deprecated->fanc==0.9.26)
  Downloading wrapt-1.15.0-cp311-cp311-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (78 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.9/78.9 kB 1.3 MB/s eta 0:00:00
Collecting sortedcontainers<3.0,>=2.0 (from intervaltree->fanc==0.9.26)
  Downloading sortedcontainers-2.4.0-py2.py3-none-any.whl (29 kB)
Collecting python-utils>=3.0.0 (from progressbar2->fanc==0.9.26)
  Obtaining dependency information for python-utils>=3.0.0 from https://files.pythonhosted.org/packages/f0/7b/e83e7b184e53530abe064b237a3731c738d3cb59f4201f3ce1a4ec0efe6f/python_utils-3.8.1-py2.py3-none-any.whl.metadata
  Downloading python_utils-3.8.1-py2.py3-none-any.whl.metadata (9.7 kB)
Collecting iniconfig (from pytest->fanc==0.9.26)
  Downloading iniconfig-2.0.0-py3-none-any.whl (5.9 kB)
Collecting pluggy<2.0,>=0.12 (from pytest->fanc==0.9.26)
  Obtaining dependency information for pluggy<2.0,>=0.12 from https://files.pythonhosted.org/packages/05/b8/42ed91898d4784546c5f06c60506400548db3f7a4b3fb441cba4e5c17952/pluggy-1.3.0-py3-none-any.whl.metadata
  Downloading pluggy-1.3.0-py3-none-any.whl.metadata (4.3 kB)
Collecting joblib>=1.1.1 (from scikit-learn->fanc==0.9.26)
  Obtaining dependency information for joblib>=1.1.1 from https://files.pythonhosted.org/packages/10/40/d551139c85db202f1f384ba8bcf96aca2f329440a844f924c8a0040b6d02/joblib-1.3.2-py3-none-any.whl.metadata
  Downloading joblib-1.3.2-py3-none-any.whl.metadata (5.4 kB)
Collecting threadpoolctl>=2.0.0 (from scikit-learn->fanc==0.9.26)
  Obtaining dependency information for threadpoolctl>=2.0.0 from https://files.pythonhosted.org/packages/81/12/fd4dea011af9d69e1cad05c75f3f7202cdcbeac9b712eea58ca779a72865/threadpoolctl-3.2.0-py3-none-any.whl.metadata
  Downloading threadpoolctl-3.2.0-py3-none-any.whl.metadata (10.0 kB)
Collecting typing-extensions>3.10.0.2 (from python-utils>=3.0.0->progressbar2->fanc==0.9.26)
  Obtaining dependency information for typing-extensions>3.10.0.2 from https://files.pythonhosted.org/packages/24/21/7d397a4b7934ff4028987914ac1044d3b7d52712f30e2ac7a2ae5bc86dd0/typing_extensions-4.8.0-py3-none-any.whl.metadata
  Downloading typing_extensions-4.8.0-py3-none-any.whl.metadata (3.0 kB)
Collecting toolz>=0.8.0 (from cytoolz->cooler>=0.8.0->fanc==0.9.26)
  Downloading toolz-0.12.0-py3-none-any.whl (55 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 55.8/55.8 kB 1.2 MB/s eta 0:00:00
Collecting dill>=0.3.7 (from multiprocess->cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for dill>=0.3.7 from https://files.pythonhosted.org/packages/f5/3a/74a29b11cf2cdfcd6ba89c0cecd70b37cd1ba7b77978ce611eb7a146a832/dill-0.3.7-py3-none-any.whl.metadata
  Downloading dill-0.3.7-py3-none-any.whl.metadata (9.9 kB)
Requirement already satisfied: setuptools in /home/kalavatt/miniconda3/envs/fanc_env/lib/python3.11/site-packages (from pyfaidx->cooler>=0.8.0->fanc==0.9.26) (68.2.2)
Collecting importlib-metadata (from pyfaidx->cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for importlib-metadata from https://files.pythonhosted.org/packages/cc/37/db7ba97e676af155f5fcb1a35466f446eadc9104e25b83366e8088c9c926/importlib_metadata-6.8.0-py3-none-any.whl.metadata
  Downloading importlib_metadata-6.8.0-py3-none-any.whl.metadata (5.1 kB)
Collecting zipp>=0.5 (from importlib-metadata->pyfaidx->cooler>=0.8.0->fanc==0.9.26)
  Obtaining dependency information for zipp>=0.5 from https://files.pythonhosted.org/packages/d9/66/48866fc6b158c81cc2bfecc04c480f105c6040e8b077bc54c634b4a67926/zipp-3.17.0-py3-none-any.whl.metadata
  Downloading zipp-3.17.0-py3-none-any.whl.metadata (3.7 kB)
Downloading cooler-0.9.3-py3-none-any.whl (103 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.7/103.7 kB 1.4 MB/s eta 0:00:00
Downloading h5py-3.9.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (4.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.8/4.8 MB 2.0 MB/s eta 0:00:00
Downloading matplotlib-3.8.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (11.6 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 11.6/11.6 MB 2.2 MB/s eta 0:00:00
Downloading msgpack-1.0.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (557 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 558.0/558.0 kB 1.8 MB/s eta 0:00:00
Downloading numpy-1.26.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (18.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 18.2/18.2 MB 2.3 MB/s eta 0:00:00
Downloading pandas-2.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (12.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.2/12.2 MB 2.1 MB/s eta 0:00:00
Downloading Pillow-10.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.5/3.5 MB 2.0 MB/s eta 0:00:00
Downloading PyYAML-6.0.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (757 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 757.7/757.7 kB 2.2 MB/s eta 0:00:00
Downloading scikit_image-0.21.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (13.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 13.7/13.7 MB 1.4 MB/s eta 0:00:00
Downloading scipy-1.11.3-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (36.4 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 36.4/36.4 MB 1.4 MB/s eta 0:00:00
Downloading Deprecated-1.2.14-py2.py3-none-any.whl (9.6 kB)
Downloading pytest-7.4.2-py3-none-any.whl (324 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 324.5/324.5 kB 2.0 MB/s eta 0:00:00
Downloading scikit_learn-1.3.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (10.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 10.9/10.9 MB 1.8 MB/s eta 0:00:00
Downloading click-8.1.7-py3-none-any.whl (97 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 97.9/97.9 kB 1.2 MB/s eta 0:00:00
Downloading contourpy-1.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (302 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 302.8/302.8 kB 1.4 MB/s eta 0:00:00
Downloading cycler-0.12.0-py3-none-any.whl (8.2 kB)
Using cached Cython-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.6 MB)
Downloading fonttools-4.43.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (4.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.9/4.9 MB 1.6 MB/s eta 0:00:00
Downloading imageio-2.31.4-py3-none-any.whl (313 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 313.2/313.2 kB 1.3 MB/s eta 0:00:00
Downloading joblib-1.3.2-py3-none-any.whl (302 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 302.2/302.2 kB 1.4 MB/s eta 0:00:00
Downloading kiwisolver-1.4.5-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.4 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.4/1.4 MB 1.4 MB/s eta 0:00:00
Downloading lazy_loader-0.3-py3-none-any.whl (9.1 kB)
Downloading numexpr-2.8.7-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (386 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 386.4/386.4 kB 1.5 MB/s eta 0:00:00
Downloading pluggy-1.3.0-py3-none-any.whl (18 kB)
Downloading pyparsing-3.1.1-py3-none-any.whl (103 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.1/103.1 kB 1.1 MB/s eta 0:00:00
Downloading python_utils-3.8.1-py2.py3-none-any.whl (27 kB)
Downloading pytz-2023.3.post1-py2.py3-none-any.whl (502 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 502.5/502.5 kB 1.5 MB/s eta 0:00:00
Downloading threadpoolctl-3.2.0-py3-none-any.whl (15 kB)
Downloading tifffile-2023.9.26-py3-none-any.whl (222 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 222.9/222.9 kB 1.5 MB/s eta 0:00:00
Downloading cytoolz-0.12.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (2.1 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.1/2.1 MB 1.4 MB/s eta 0:00:00
Downloading multiprocess-0.70.15-py311-none-any.whl (135 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 135.4/135.4 kB 1.1 MB/s eta 0:00:00
Downloading pyfaidx-0.7.2.2-py3-none-any.whl (28 kB)
Downloading pyzmq-25.1.1-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.1 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.1/1.1 MB 1.2 MB/s eta 0:00:00
Downloading dill-0.3.7-py3-none-any.whl (115 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 115.3/115.3 kB 1.3 MB/s eta 0:00:00
Downloading typing_extensions-4.8.0-py3-none-any.whl (31 kB)
Downloading importlib_metadata-6.8.0-py3-none-any.whl (22 kB)
Downloading zipp-3.17.0-py3-none-any.whl (7.4 kB)
Building wheels for collected packages: genomic_regions, gridmap, pybedtools, future, intervaltree, asciitree, drmaa
  Building wheel for genomic_regions (setup.py) ... done
  Created wheel for genomic_regions: filename=genomic_regions-0.0.10-py3-none-any.whl size=26047 sha256=6f24d1a89e96ca26fe3128f66920ba00dc5b0ebe4f0fa22943f97559bca2fb51
  Stored in directory: /home/kalavatt/.cache/pip/wheels/37/d7/5d/7911f7457f58163e1c6c1aa8c8aca2e9f3bfe202ecf91425e7
  Building wheel for gridmap (setup.py) ... done
  Created wheel for gridmap: filename=gridmap-0.15.0-py3-none-any.whl size=37669 sha256=1bf967a3ffb45f935ce60e2a0d39a163cc583e6399ce61205d782d789c73355c
  Stored in directory: /home/kalavatt/.cache/pip/wheels/56/b8/48/884d0f339b6e101502e83aa30bcd2b2f43ef26e43c47479e0d
  Building wheel for pybedtools (setup.py) ... done
  Created wheel for pybedtools: filename=pybedtools-0.9.1-cp311-cp311-linux_x86_64.whl size=12752880 sha256=10073c22d1ac886e5c5d4727f3564346092d5fef4a3f0e0126ce680ee302e9cf
  Stored in directory: /home/kalavatt/.cache/pip/wheels/c4/f4/19/26c8d60799f04c0cd0167e9e823203eb4c8d16c41afe60f6d6
  Building wheel for future (setup.py) ... done
  Created wheel for future: filename=future-0.18.3-py3-none-any.whl size=492024 sha256=7b516889cc2620e07202bb4eec3b38f9191fffab1bd4c6106abb62bcb029811a
  Stored in directory: /home/kalavatt/.cache/pip/wheels/da/19/ca/9d8c44cd311a955509d7e13da3f0bea42400c469ef825b580b
  Building wheel for intervaltree (setup.py) ... done
  Created wheel for intervaltree: filename=intervaltree-3.1.0-py2.py3-none-any.whl size=26094 sha256=f0b513ce712336eda4ee81038a5aa87bbba7c0ea3fe0520e712d84261da1469e
  Stored in directory: /home/kalavatt/.cache/pip/wheels/31/d7/d9/eec6891f78cac19a693bd40ecb8365d2f4613318c145ec9816
  Building wheel for asciitree (setup.py) ... done
  Created wheel for asciitree: filename=asciitree-0.3.3-py3-none-any.whl size=5034 sha256=ad757ba3e8ab06a37fb0fed21659150a1fa1e76077cfd0444fbbbdf61cee3f54
  Stored in directory: /home/kalavatt/.cache/pip/wheels/71/c1/da/23077eb3b87d24d6f3852ed1ed1a1ac2d3c885ad6ebd2b4a07
  Building wheel for drmaa (setup.py) ... done
  Created wheel for drmaa: filename=drmaa-0.7.9-py2.py3-none-any.whl size=19751 sha256=338ea6ebc144c248e1a83d6ec553a5464121c04a2848812cbec2103886bf503d
  Stored in directory: /home/kalavatt/.cache/pip/wheels/0f/72/95/3b5be3fb7998ba2c0803ff67183016b085acf2e75d7a6350a1
Successfully built genomic_regions gridmap pybedtools future intervaltree asciitree drmaa
Installing collected packages: sortedcontainers, pytz, py-cpuinfo, drmaa, asciitree, zipp, wrapt, tzdata, typing-extensions, toolz, threadpoolctl, six, simplejson, pyzmq, PyYAML, pyparsing, pyBigWig, psutil, pluggy, pillow, packaging, numpy, networkx, msgpack, lazy_loader, kiwisolver, joblib, intervaltree, iniconfig, future, fonttools, dill, cython, cycler, cloudpickle, click, tifffile, scipy, PyWavelets, python-utils, python-dateutil, pytest, pysam, numexpr, multiprocess, msgpack-numpy, importlib-metadata, imageio, h5py, gridmap, Deprecated, cytoolz, contourpy, blosc2, biopython, tables, scikit-learn, scikit-image, pyfaidx, pybedtools, progressbar2, pandas, matplotlib, seaborn, genomic_regions, cooler, fanc
  Running setup.py develop for fanc
Successfully installed Deprecated-1.2.14 PyWavelets-1.4.1 PyYAML-6.0.1 asciitree-0.3.3 biopython-1.81 blosc2-2.0.0 click-8.1.7 cloudpickle-2.2.1 contourpy-1.1.1 cooler-0.9.3 cycler-0.12.0 cython-3.0.2 cytoolz-0.12.2 dill-0.3.7 drmaa-0.7.9 fanc-0.9.26 fonttools-4.43.0 future-0.18.3 genomic_regions-0.0.10 gridmap-0.15.0 h5py-3.9.0 imageio-2.31.4 importlib-metadata-6.8.0 iniconfig-2.0.0 intervaltree-3.1.0 joblib-1.3.2 kiwisolver-1.4.5 lazy_loader-0.3 matplotlib-3.8.0 msgpack-1.0.7 msgpack-numpy-0.4.8 multiprocess-0.70.15 networkx-3.1 numexpr-2.8.7 numpy-1.26.0 packaging-23.1 pandas-2.1.1 pillow-10.0.1 pluggy-1.3.0 progressbar2-4.2.0 psutil-5.9.5 py-cpuinfo-9.0.0 pyBigWig-0.3.22 pybedtools-0.9.1 pyfaidx-0.7.2.2 pyparsing-3.1.1 pysam-0.21.0 pytest-7.4.2 python-dateutil-2.8.2 python-utils-3.8.1 pytz-2023.3.post1 pyzmq-25.1.1 scikit-image-0.21.0 scikit-learn-1.3.1 scipy-1.11.3 seaborn-0.12.2 simplejson-3.19.1 six-1.16.0 sortedcontainers-2.4.0 tables-3.8.0 threadpoolctl-3.2.0 tifffile-2023.9.26 toolz-0.12.0 typing-extensions-4.8.0 tzdata-2023.3 wrapt-1.15.0 zipp-3.17.0
```
</details>
<br />
<br />

<a id="learn-to-use-fanc-compare-draw-some-preliminary-plots"></a>
## Learn to use `fanc compare`, draw some preliminary plots
<a id="code-3"></a>
### Code
<details>
<summary><i>Code: Learn to use `fanc compare`, draw some preliminary plots</i></summary>

```bash
#!/bin/bash

[[ ${CONDA_DEFAULT_ENV} != base ]] && conda deactivate || true
source activate fanc_env

[[ "$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ]] &&
    cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    true

[[ ! -d mats ]] && mkdir mats
[[ ! -d mats/2023-0929_init ]] && mkdir mats/2023-0929_init

[[ ! -d pngs ]] && mkdir pngs
[[ ! -d pngs/2023-0929_init ]] && mkdir pngs/2023-0929_init

ls -lhaFG 08_zoom/

res=6400

f_Q=08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
f_1=08_zoom/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool
f_2=08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool
d_out=mats/2023-0929_init
m_Q2="log2_Q-over-G2_${res}"

check_help=FALSE
[[ check_help == TRUE ]] && fanc compare --help || true

check_command=TRUE
[[ ${check_command} == TRUE ]] &&
    {
        echo """
        fanc compare \\
            --comparison \"fold-change\" \\
            --no-scale \\
            --log \\
            --ignore-zero \\
            --ignore-infinite \\
            ${f_Q}@${res} \\
            ${f_2}@${res} \\
            ${d_out}/${m_Q2}
        """
    } || true

run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {
        fanc compare \
            --comparison "fold-change" \
            --no-scale \
            --log \
            --ignore-zero \
            --ignore-infinite \
            ${f_Q}@${res} ${f_2}@${res} \
            ${d_out}/${m_Q2}
    }

ls -lhaFG ${d_out}/

 in=mats/2023-0929_init/${m_Q2}
out=pngs/2023-0929_init/${m_Q2}

check_command=TRUE
[[ ${check_command} == TRUE ]] &&
    {
        echo """
        fancplot --output ${out} I:1-230218 --plot square ${in}
        """
    } || true

#  Awaiting a response from author of FAN-C before continuing work
#+ For more details on the errors encountered (etc.), see the following URL:
#+ github.com/vaquerizaslab/fanc/issues/170
run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {
        fancplot \
            -o "test.pdf" \
            XII:100000-200000 \
            -p square \
            -vmin 0 -vmax 0.1 \
            --title "6400 bp, XII:100000-200000" \
            -c Reds \
            "${f_Q}@${res}"
            # 08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool@6400
    } || true
```
</details>
<br />

<a id="printed-3"></a>
### Printed
<details>
<summary><i>Printed: Learn to use `fanc compare`, draw some preliminary plots</i></summary>

```txt
❯ [[ ${CONDA_DEFAULT_ENV} != base ]] && conda deactivate || true
❯ source activate fanc_env


❯ [[ "$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ]] &&
>     cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
>     true


❯ ls -lhaFG 08_zoom/
total 1.6G
drwxrws---  3 kalavatt  494 Aug  6 17:21 ./
drwxrws--- 12 kalavatt  717 Sep 29 11:03 ../
drwxrws---  2 kalavatt 1.2K Aug  6 17:20 err_out/
-rw-rw----  1 kalavatt 236M Aug  6 17:25 MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 215M Aug  6 17:28 MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 195M Aug  6 17:28 MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 343M Aug  6 17:29 MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 101M Aug  6 17:30 MC-2020_nz_WT_rep1.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 123M Aug  6 17:33 MC-2020_nz_WT_rep2.standard-rDNA-complete.mcool
-rw-rw----  1 kalavatt 183M Aug  6 17:35 MC-2020_nz_WT_repM.standard-rDNA-complete.mcool


❯ [[ ! -d pngs ]] && mkdir pngs
mkdir: created directory 'pngs'


❯ [[ ! -d pngs/2023-0929_init ]] && mkdir pngs/2023-0929_init
mkdir: created directory 'pngs/2023-0929_init'


❯ [[ ! -d mats ]] && mkdir mats
mkdir: created directory 'mats'


❯ [[ ! -d mats/2023-0929_init ]] && mkdir mats/2023-0929_init
mkdir: created directory 'mats/2023-0929_init'


❯ check_help=FALSE
❯ [[ check_help == TRUE ]] && fanc compare --help || true


❯ res=6400
❯ f_Q=08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
❯ f_1=08_zoom/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool
❯ f_2=08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool
❯ d_out=mats/2023-0929_init
❯ m_Q2="log2_Q-over-G2_${res}"


❯ check_command=TRUE
❯ [[ ${check_command} == TRUE ]] &&
>     {
>         echo """
>         fanc compare \\
>             --comparison \"fold-change\" \\
>             --no-scale \\
>             --log \\
>             --ignore-zero \\
>             --ignore-infinite \\
>             ${f_Q}@${res} \\
>             ${f_2}@${res} \\
>             ${d_out}/${m_Q2}
>         """
>     } || true

        fanc compare \
            --comparison "fold-change" \
            --no-scale \
            --log \
            --ignore-zero \
            --ignore-infinite \
            08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool@6400 \
            08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool@6400 \
            pngs/2023-0929_init/log2_Q-over-G2_6400


❯ run_command=TRUE
❯ [[ ${run_command} == TRUE ]] &&
>     {
>         fanc compare \
>             --comparison "fold-change" \
>             --no-scale \
>             --log \
>             --ignore-zero \
>             --ignore-infinite \
>             ${f_Q}@${res} ${f_2}@${res} \
>             ${d_out}/${m_Q2}
>     }
/home/kalavatt/miniconda3/envs/fanc_env/bin/fanc:4: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
  __import__('pkg_resources').require('fanc==0.9.26')
2023-09-29 11:57:15,323 INFO FAN-C version: 0.9.26
2023-09-29 11:57:16,107 INFO Enabling zero filter
Compare 100% (153 of 153) |#############################################################################################################################| Elapsed Time: 0:00:47 Time:  0:00:47
Buffers 100% (3 of 3) |#################################################################################################################################| Elapsed Time: 0:00:00 Time:  0:00:00
Expected 100% (1328774 of 1328774) |####################################################################################################################| Elapsed Time: 0:00:07 Time:  0:00:07


❯ ls -lhaFG ${d_out}/
total 18M
drwxrws--- 2 kalavatt  37 Sep 29 12:01 ./
drwxrws--- 3 kalavatt  32 Sep 29 12:00 ../
-rw-rw---- 1 kalavatt 15M Sep 29 11:58 log2_Q-over-G2_6400


❯  in=mats/2023-0929_init/${m_Q2}
❯ out=pngs/2023-0929_init/${m_Q2}.png


...
```
</details>
<br />

<a id="help"></a>
### Help
<details>
<summary><i>Help: Learn to use `fanc compare`, draw some preliminary plots</i></summary>

```txt
❯ fanc compare --help
/home/kalavatt/miniconda3/envs/fanc_env/bin/fanc:4: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
  __import__('pkg_resources').require('fanc==0.9.26')
2023-09-29 11:39:39,118 INFO FAN-C version: 0.9.26
usage: fanc compare [-h] [-c COMPARISON] [-o OUTPUT_FORMAT] [-S] [-l] [--log-matrix] [-Z] [-I] [-e] [-u] [-tmp] input input output

Create pairwise comparisons of Hi-C comparison maps

positional arguments:
  input                 Input matrix (e.g. Hic) files.
  output                Output ComparisonMatrix file.

options:
  -h, --help            show this help message and exit
  -c COMPARISON, --comparison COMPARISON
                        Type of comparison. Default: fold-change, other options are: difference
  -o OUTPUT_FORMAT, --output-format OUTPUT_FORMAT
                        Output format for region-based comparisons. Only relevant when using BED, GFF, or another region-based format as input.
  -S, --no-scale        Do not scale input matrices to the same number of valid pairs
  -l, --log             Log2-convert comparison values (AFTER the comparison)
  --log-matrix          Log2-convert matrices (BEFORE the comparison)
  -Z, --ignore-zero     Do not consider pixels where one matrix entry is zero
  -I, --ignore-infinite
                        Do not consider pixels where the comparison yields "inf"
  -e, --observed-expected
                        O/E transform matrix values before comparison. Only has an effect on matrix comparisons.
  -u, --uncorrected     Compare uncorrected matrices. Only has an effect on matrix comparisons.
  -tmp, --work-in-tmp   Work in temporary directory
```

More details [here](https://fan-c.readthedocs.io/en/latest/fanc-executable/fanc-analyse-hic/comparisons.html).
</details>
<br />
<br />

<a id="set-up-virtual-environment-for-analyses-with-hicexplorer"></a>
## Set up virtual environment for analyses with `HiCExplorer`
<a id="code-4"></a>
### Code
<details>
<summary><i>Code: Set up virtual environment for analyses with `HiCExplorer`</i></summary>

```bash
#!/bin/bash

env_name="hicexplorer_env"
install_env=TRUE
if [[ "${install_env}" == TRUE ]]; then
    mamba create \
        -n ${env_name} \
        hicexplorer=3.7.2=pyhdfd78af_1 \
        -c conda-forge \
        -c bioconda
    
    source activate ${env_name}
    mamba install -c bioconda rename
    
    # conda remove -n hicexplorer_env --all
fi
```
</details>
<br />

<a id="printed-4"></a>
### Printed
<details>
<summary><i>Printed: Set up virtual environment for analyses with `HiCExplorer`</i></summary>

```txt
❯ mamba create \
>     -n ${env_name} \
>     hicexplorer=3.7.2=pyhdfd78af_1 \
>     -c conda-forge \
>     -c bioconda

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['hicexplorer==3.7.2=pyhdfd78af_1']

conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/hicexplorer_env

  Updating specs:

   - hicexplorer==3.7.2=pyhdfd78af_1


  Package                               Version  Build                    Channel                    Size
───────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex                           0.1  conda_forge              conda-forge/linux-64     Cached
  + _openmp_mutex                           4.5  2_gnu                    conda-forge/linux-64     Cached
  + argcomplete                           3.1.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + argh                                 0.29.4  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + asciitree                             0.3.3  py_2                     conda-forge/noarch       Cached
  + asttokens                             2.4.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + atk-1.0                              2.38.0  hd4edc92_1               conda-forge/linux-64     Cached
  + aws-c-auth                            0.7.4  hc8144f4_1               conda-forge/linux-64     Cached
  + aws-c-cal                             0.6.2  h09139f6_2               conda-forge/linux-64     Cached
  + aws-c-common                          0.9.3  hd590300_0               conda-forge/linux-64     Cached
  + aws-c-compression                    0.2.17  h184a658_3               conda-forge/linux-64     Cached
  + aws-c-event-stream                    0.3.2  hd6ebb48_1               conda-forge/linux-64     Cached
  + aws-c-http                           0.7.13  hc690213_1               conda-forge/linux-64     Cached
  + aws-c-io                            0.13.32  h89a0be2_4               conda-forge/linux-64     Cached
  + aws-c-mqtt                            0.9.6  h32970c0_2               conda-forge/linux-64     Cached
  + aws-c-s3                             0.3.17  hb5e3142_3               conda-forge/linux-64     Cached
  + aws-c-sdkutils                       0.1.12  h184a658_2               conda-forge/linux-64     Cached
  + aws-checksums                        0.1.17  h184a658_2               conda-forge/linux-64     Cached
  + aws-crt-cpp                          0.23.1  h94c364a_5               conda-forge/linux-64     Cached
  + aws-sdk-cpp                        1.11.156  h6600424_3               conda-forge/linux-64     Cached
  + backcall                              0.2.0  pyh9f0ad1d_0             conda-forge/noarch       Cached
  + backports                               1.0  pyhd8ed1ab_3             conda-forge/noarch       Cached
  + backports.functools_lru_cache         1.6.5  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + bedtools                             2.31.0  hf5e1c6e_3               bioconda/linux-64        Cached
  + biopython                              1.81  py310h1fa729e_0          conda-forge/linux-64     Cached
  + blosc                                1.21.5  h0f2a231_0               conda-forge/linux-64     Cached
  + bokeh                                 3.2.2  pyhd8ed1ab_0             conda-forge/noarch          5MB
  + brotli                                1.1.0  hd590300_1               conda-forge/linux-64     Cached
  + brotli-bin                            1.1.0  hd590300_1               conda-forge/linux-64     Cached
  + brotli-python                         1.1.0  py310hc6cd4ac_1          conda-forge/linux-64      349kB
  + bx-python                            0.10.0  py310h551a815_0          bioconda/linux-64           1MB
  + bzip2                                 1.0.8  h7f98852_4               conda-forge/linux-64     Cached
  + c-ares                               1.19.1  hd590300_0               conda-forge/linux-64     Cached
  + c-blosc2                             2.10.2  hb4ffafa_0               conda-forge/linux-64     Cached
  + ca-certificates                   2023.7.22  hbcca054_0               conda-forge/linux-64     Cached
  + cached-property                       1.5.2  hd8ed1ab_1               conda-forge/noarch       Cached
  + cached_property                       1.5.2  pyha770c72_1             conda-forge/noarch       Cached
  + cairo                                1.16.0  h0c91306_1017            conda-forge/linux-64     Cached
  + certifi                           2023.7.22  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + cleanlab                              2.5.0  pyhd8ed1ab_0             conda-forge/noarch        187kB
  + click                                 8.1.7  unix_pyh707e725_0        conda-forge/noarch       Cached
  + cloudpickle                           2.2.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + colorama                              0.4.6  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + comm                                  0.1.4  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + contourpy                             1.1.1  py310hd41b1e2_1          conda-forge/linux-64      224kB
  + cooler                                0.9.3  pyhdfd78af_0             bioconda/noarch          Cached
  + cycler                               0.11.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + cytoolz                              0.12.2  py310h2372a71_1          conda-forge/linux-64      368kB
  + dask                               2023.9.3  pyhd8ed1ab_0             conda-forge/noarch          7kB
  + dask-core                          2023.9.3  pyhd8ed1ab_0             conda-forge/noarch        858kB
  + debugpy                               1.8.0  py310hc6cd4ac_1          conda-forge/linux-64        2MB
  + decorator                             5.1.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + dill                                  0.3.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + distributed                        2023.9.3  pyhd8ed1ab_0             conda-forge/noarch        784kB
  + eigen                                 3.4.0  h00ab1b0_0               conda-forge/linux-64     Cached
  + exceptiongroup                        1.1.3  pyhd8ed1ab_0             conda-forge/noarch         19kB
  + executing                             1.2.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + expat                                 2.5.0  hcb278e6_1               conda-forge/linux-64     Cached
  + fit_nbinom                              1.1  pyh864c0ab_2             bioconda/noarch          Cached
  + font-ttf-dejavu-sans-mono              2.37  hab24e00_0               conda-forge/noarch       Cached
  + font-ttf-inconsolata                  3.000  h77eed37_0               conda-forge/noarch       Cached
  + font-ttf-source-code-pro              2.038  h77eed37_0               conda-forge/noarch       Cached
  + font-ttf-ubuntu                        0.83  hab24e00_0               conda-forge/noarch       Cached
  + fontconfig                           2.14.2  h14ed4e7_0               conda-forge/linux-64     Cached
  + fonts-conda-ecosystem                     1  0                        conda-forge/noarch       Cached
  + fonts-conda-forge                         1  0                        conda-forge/noarch       Cached
  + fonttools                            4.43.0  py310h2372a71_0          conda-forge/linux-64        2MB
  + freetype                             2.12.1  h267a509_2               conda-forge/linux-64     Cached
  + fribidi                              1.0.10  h36c2ea0_0               conda-forge/linux-64     Cached
  + fsspec                             2023.9.2  pyh1a96a4e_0             conda-forge/noarch       Cached
  + future                               0.18.3  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + gdk-pixbuf                          2.42.10  h6c15284_3               conda-forge/linux-64     Cached
  + gettext                              0.21.1  h27087fc_0               conda-forge/linux-64     Cached
  + gffutils                               0.12  pyh7cba7a3_0             bioconda/noarch          Cached
  + gflags                                2.2.2  he1b5a44_1004            conda-forge/linux-64     Cached
  + giflib                                5.2.1  h0b41bf4_3               conda-forge/linux-64     Cached
  + glog                                  0.6.0  h6f12383_0               conda-forge/linux-64     Cached
  + graphite2                            1.3.13  h58526e2_1001            conda-forge/linux-64     Cached
  + graphviz                              8.1.0  h28d9a01_0               conda-forge/linux-64     Cached
  + gtk2                                2.24.33  h90689f9_2               conda-forge/linux-64     Cached
  + gts                                   0.7.6  h977cf35_4               conda-forge/linux-64     Cached
  + h5py                                  3.9.0  nompi_py310ha2ad45a_103  conda-forge/linux-64        1MB
  + harfbuzz                              8.2.1  h3d44ed6_0               conda-forge/linux-64     Cached
  + hdf5                                 1.14.2  nompi_h4f84152_100       conda-forge/linux-64     Cached
  + hic2cool                              0.8.3  pyh864c0ab_2             bioconda/noarch          Cached
  + hicexplorer                           3.7.2  pyhdfd78af_1             bioconda/noarch             2MB
  + hicmatrix                                17  pyhdfd78af_0             bioconda/noarch          Cached
  + htslib                                 1.18  h81da01d_0               bioconda/linux-64        Cached
  + hyperopt                              0.2.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + icu                                    73.2  h59595ed_0               conda-forge/linux-64     Cached
  + imbalanced-learn                     0.11.0  pyhd8ed1ab_0             conda-forge/noarch        141kB
  + importlib-metadata                    6.8.0  pyha770c72_0             conda-forge/noarch       Cached
  + importlib_metadata                    6.8.0  hd8ed1ab_0               conda-forge/noarch       Cached
  + intervaltree                          3.1.0  pyhd8ed1ab_1             conda-forge/noarch       Cached
  + ipykernel                            6.25.2  pyh2140261_0             conda-forge/noarch       Cached
  + ipython                              8.16.0  pyh0d859eb_0             conda-forge/noarch        590kB
  + jedi                                 0.19.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + jinja2                                3.1.2  pyhd8ed1ab_1             conda-forge/noarch       Cached
  + joblib                                1.3.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + jupyter_client                        8.3.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + jupyter_core                          5.3.2  py310hff52083_0          conda-forge/linux-64       79kB
  + keyutils                              1.6.1  h166bdaf_0               conda-forge/linux-64     Cached
  + kiwisolver                            1.4.5  py310hd41b1e2_1          conda-forge/linux-64       73kB
  + krb5                                 1.21.2  h659d440_0               conda-forge/linux-64     Cached
  + krbalancing                           0.0.5  py310h0dbaff4_7          bioconda/linux-64         120kB
  + lcms2                                  2.15  h7f713cb_2               conda-forge/linux-64     Cached
  + ld_impl_linux-64                       2.40  h41732ed_0               conda-forge/linux-64     Cached
  + lerc                                  4.0.0  h27087fc_0               conda-forge/linux-64     Cached
  + libabseil                        20230802.1  cxx17_h59595ed_0         conda-forge/linux-64     Cached
  + libaec                                1.1.1  h59595ed_0               conda-forge/linux-64     Cached
  + libarrow                             13.0.0  h1935d02_5_cpu           conda-forge/linux-64     Cached
  + libblas                               3.9.0  18_linux64_openblas      conda-forge/linux-64     Cached
  + libbrotlicommon                       1.1.0  hd590300_1               conda-forge/linux-64     Cached
  + libbrotlidec                          1.1.0  hd590300_1               conda-forge/linux-64     Cached
  + libbrotlienc                          1.1.0  hd590300_1               conda-forge/linux-64     Cached
  + libcblas                              3.9.0  18_linux64_openblas      conda-forge/linux-64     Cached
  + libcrc32c                             1.1.2  h9c3ff4c_0               conda-forge/linux-64     Cached
  + libcurl                               8.3.0  hca28451_0               conda-forge/linux-64     Cached
  + libdeflate                             1.18  h0b41bf4_0               conda-forge/linux-64     Cached
  + libedit                        3.1.20191231  he28a2e2_2               conda-forge/linux-64     Cached
  + libev                                  4.33  h516909a_1               conda-forge/linux-64     Cached
  + libevent                             2.1.12  hf998b51_1               conda-forge/linux-64     Cached
  + libexpat                              2.5.0  hcb278e6_1               conda-forge/linux-64     Cached
  + libffi                                3.4.2  h7f98852_5               conda-forge/linux-64     Cached
  + libgcc-ng                            13.2.0  h807b86a_2               conda-forge/linux-64     Cached
  + libgd                                 2.3.3  he9388d3_8               conda-forge/linux-64     Cached
  + libgfortran-ng                       13.2.0  h69a702a_2               conda-forge/linux-64     Cached
  + libgfortran5                         13.2.0  ha4646dd_2               conda-forge/linux-64     Cached
  + libglib                              2.78.0  hebfc3b9_0               conda-forge/linux-64     Cached
  + libgomp                              13.2.0  h807b86a_2               conda-forge/linux-64     Cached
  + libgoogle-cloud                      2.12.0  h8d7e28b_2               conda-forge/linux-64     Cached
  + libgrpc                              1.57.0  ha4d0f93_1               conda-forge/linux-64     Cached
  + libiconv                               1.17  h166bdaf_0               conda-forge/linux-64     Cached
  + libjpeg-turbo                       2.1.5.1  hd590300_1               conda-forge/linux-64     Cached
  + liblapack                             3.9.0  18_linux64_openblas      conda-forge/linux-64     Cached
  + libnghttp2                           1.52.0  h61bc06f_0               conda-forge/linux-64     Cached
  + libnsl                                2.0.0  hd590300_1               conda-forge/linux-64     Cached
  + libnuma                              2.0.16  h0b41bf4_1               conda-forge/linux-64     Cached
  + libopenblas                          0.3.24  pthreads_h413a1c8_0      conda-forge/linux-64     Cached
  + libpng                               1.6.39  h753d276_0               conda-forge/linux-64     Cached
  + libprotobuf                          4.23.4  hf27288f_6               conda-forge/linux-64     Cached
  + librsvg                              2.56.3  h98fae49_0               conda-forge/linux-64     Cached
  + libsodium                            1.0.18  h36c2ea0_1               conda-forge/linux-64     Cached
  + libsqlite                            3.43.0  h2797004_0               conda-forge/linux-64     Cached
  + libssh2                              1.11.0  h0841786_0               conda-forge/linux-64     Cached
  + libstdcxx-ng                         13.2.0  h7e041cc_2               conda-forge/linux-64     Cached
  + libthrift                            0.19.0  hb90f79a_1               conda-forge/linux-64     Cached
  + libtiff                               4.6.0  h8b53f26_0               conda-forge/linux-64     Cached
  + libtool                               2.4.7  h27087fc_0               conda-forge/linux-64     Cached
  + libutf8proc                           2.8.0  h166bdaf_0               conda-forge/linux-64     Cached
  + libuuid                              2.38.1  h0b41bf4_0               conda-forge/linux-64     Cached
  + libwebp                               1.3.2  hdffd6e0_0               conda-forge/linux-64     Cached
  + libwebp-base                          1.3.2  hd590300_0               conda-forge/linux-64     Cached
  + libxcb                                 1.15  h0b41bf4_0               conda-forge/linux-64     Cached
  + libxml2                              2.11.5  h232c23b_1               conda-forge/linux-64     Cached
  + libzlib                              1.2.13  hd590300_5               conda-forge/linux-64     Cached
  + locket                                1.0.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + lz4                                   4.3.2  py310h350c4a5_1          conda-forge/linux-64       37kB
  + lz4-c                                 1.9.4  hcb278e6_0               conda-forge/linux-64     Cached
  + lzo                                    2.10  h516909a_1000            conda-forge/linux-64     Cached
  + markupsafe                            2.1.3  py310h2372a71_1          conda-forge/linux-64       24kB
  + matplotlib-base                       3.6.2  py310h8d5ebf3_0          conda-forge/linux-64        8MB
  + matplotlib-inline                     0.1.6  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + msgpack-python                        1.0.6  py310hd41b1e2_0          conda-forge/linux-64      197kB
  + multiprocess                        0.70.15  py310h2372a71_1          conda-forge/linux-64      243kB
  + munkres                               1.1.4  pyh9f0ad1d_0             conda-forge/noarch       Cached
  + ncurses                                 6.4  hcb278e6_0               conda-forge/linux-64     Cached
  + nest-asyncio                          1.5.6  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + networkx                                3.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + nomkl                                   1.0  h5ca1d4c_0               conda-forge/noarch       Cached
  + numexpr                               2.8.7  py310hcc13569_100        conda-forge/linux-64      133kB
  + numpy                                1.26.0  py310hb13e2d6_0          conda-forge/linux-64        7MB
  + openjpeg                              2.5.0  h488ebb8_3               conda-forge/linux-64     Cached
  + openssl                               3.1.3  hd590300_0               conda-forge/linux-64     Cached
  + orc                                   1.9.0  h52d3b3c_2               conda-forge/linux-64     Cached
  + packaging                              23.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pairix                                0.3.7  py310h83093d7_5          bioconda/linux-64        Cached
  + pandas                                2.1.1  py310hcc13569_1          conda-forge/linux-64       12MB
  + pango                               1.50.14  ha41ecd1_2               conda-forge/linux-64     Cached
  + parso                                 0.8.3  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + partd                                 1.4.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pcre2                                 10.40  hc3806b6_0               conda-forge/linux-64     Cached
  + pexpect                               4.8.0  pyh1a96a4e_2             conda-forge/noarch       Cached
  + pickleshare                           0.7.5  py_1003                  conda-forge/noarch       Cached
  + pillow                               10.0.1  py310h29da1c1_1          conda-forge/linux-64       46MB
  + pip                                  23.2.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pixman                               0.42.2  h59595ed_0               conda-forge/linux-64     Cached
  + platformdirs                         3.10.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + prompt-toolkit                       3.0.39  pyha770c72_0             conda-forge/noarch       Cached
  + prompt_toolkit                       3.0.39  hd8ed1ab_0               conda-forge/noarch       Cached
  + psutil                                5.9.5  py310h2372a71_1          conda-forge/linux-64      361kB
  + pthread-stubs                           0.4  h36c2ea0_1001            conda-forge/linux-64     Cached
  + ptyprocess                            0.7.0  pyhd3deb0d_0             conda-forge/noarch       Cached
  + pure_eval                             0.2.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + py-cpuinfo                            9.0.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + py4j                               0.10.9.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pyarrow                              13.0.0  py310hf9e7431_5_cpu      conda-forge/linux-64        4MB
  + pybedtools                            0.9.1  py310h2b6aa90_0          bioconda/linux-64          13MB
  + pybigwig                             0.3.22  py310h79000e5_1          bioconda/linux-64          91kB
  + pybind11                             2.11.1  py310hd41b1e2_2          conda-forge/linux-64      184kB
  + pybind11-global                      2.11.1  py310hd41b1e2_2          conda-forge/linux-64      172kB
  + pyfaidx                             0.7.2.2  pyhdfd78af_0             bioconda/noarch          Cached
  + pygenometracks                          3.8  pyhdfd78af_0             bioconda/noarch          Cached
  + pygments                             2.16.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pyparsing                             3.1.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pysam                                0.21.0  py310h41dec4a_1          bioconda/linux-64        Cached
  + pysocks                               1.7.1  pyha2e5f31_6             conda-forge/noarch       Cached
  + pytables                              3.8.0  py310h374b01c_3          conda-forge/linux-64        2MB
  + python                              3.10.12  hd12c33a_0_cpython       conda-forge/linux-64     Cached
  + python-dateutil                       2.8.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + python-graphviz                      0.20.1  pyh22cad53_0             conda-forge/noarch       Cached
  + python-tzdata                        2023.3  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + python_abi                             3.10  4_cp310                  conda-forge/linux-64        6kB
  + pytz                           2023.3.post1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pyvcf3                                1.0.3  pyhdfd78af_0             bioconda/noarch          Cached
  + pyyaml                                6.0.1  py310h2372a71_1          conda-forge/linux-64      171kB
  + pyzmq                                25.1.1  py310h5bbb5d0_1          conda-forge/linux-64      457kB
  + rdma-core                              28.9  h59595ed_1               conda-forge/linux-64     Cached
  + re2                              2023.03.02  h8c504da_0               conda-forge/linux-64     Cached
  + readline                                8.2  h8228510_1               conda-forge/linux-64     Cached
  + s2n                                  1.3.51  h06160fa_0               conda-forge/linux-64     Cached
  + scikit-learn                          1.3.1  py310h1fdf081_0          conda-forge/linux-64        8MB
  + scipy                                1.11.3  py310hb13e2d6_0          conda-forge/linux-64       16MB
  + setuptools                           68.2.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + simplejson                           3.19.1  py310h2372a71_1          conda-forge/linux-64      109kB
  + six                                  1.16.0  pyh6c4a22f_0             conda-forge/noarch       Cached
  + snappy                               1.1.10  h9fff704_0               conda-forge/linux-64     Cached
  + sortedcontainers                      2.4.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + stack_data                            0.6.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + tblib                                 2.0.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + termcolor                             2.3.0  pyhd8ed1ab_0             conda-forge/noarch         12kB
  + threadpoolctl                         3.2.0  pyha21a80b_0             conda-forge/noarch       Cached
  + tk                                   8.6.13  h2797004_0               conda-forge/linux-64     Cached
  + toolz                                0.12.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + tornado                               6.3.3  py310h2372a71_1          conda-forge/linux-64      642kB
  + tqdm                                 4.66.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + traitlets                            5.10.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + typing-extensions                     4.8.0  hd8ed1ab_0               conda-forge/noarch       Cached
  + typing_extensions                     4.8.0  pyha770c72_0             conda-forge/noarch       Cached
  + tzdata                                2023c  h71feb2d_0               conda-forge/noarch       Cached
  + ucx                                  1.14.1  h64cca9d_5               conda-forge/linux-64     Cached
  + unicodedata2                         15.1.0  py310h2372a71_0          conda-forge/linux-64      374kB
  + unidecode                             1.3.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + urllib3                               2.0.5  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + wcwidth                               0.2.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + wheel                                0.41.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + xorg-kbproto                          1.0.7  h7f98852_1002            conda-forge/linux-64     Cached
  + xorg-libice                           1.1.1  hd590300_0               conda-forge/linux-64     Cached
  + xorg-libsm                            1.2.4  h7391055_0               conda-forge/linux-64     Cached
  + xorg-libx11                           1.8.6  h8ee46fc_0               conda-forge/linux-64     Cached
  + xorg-libxau                          1.0.11  hd590300_0               conda-forge/linux-64     Cached
  + xorg-libxdmcp                         1.1.3  h7f98852_0               conda-forge/linux-64     Cached
  + xorg-libxext                          1.3.4  h0b41bf4_2               conda-forge/linux-64     Cached
  + xorg-libxrender                      0.9.11  hd590300_0               conda-forge/linux-64     Cached
  + xorg-renderproto                     0.11.1  h7f98852_1002            conda-forge/linux-64     Cached
  + xorg-xextproto                        7.3.0  h0b41bf4_1003            conda-forge/linux-64     Cached
  + xorg-xproto                          7.0.31  h7f98852_1007            conda-forge/linux-64     Cached
  + xyzservices                        2023.7.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + xz                                    5.2.6  h166bdaf_0               conda-forge/linux-64     Cached
  + yaml                                  0.2.5  h7f98852_2               conda-forge/linux-64     Cached
  + zeromq                                4.3.4  h9c3ff4c_1               conda-forge/linux-64     Cached
  + zict                                  3.0.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + zipp                                 3.17.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + zlib                                 1.2.13  hd590300_5               conda-forge/linux-64     Cached
  + zlib-ng                               2.0.7  h0b41bf4_0               conda-forge/linux-64     Cached
  + zstd                                  1.5.5  hfc55251_0               conda-forge/linux-64     Cached

  Summary:

  Install: 266 packages

  Total download: 138MB

───────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
termcolor                                           11.8kB @ 143.3kB/s  0.1s
python_abi                                           6.4kB @  55.6kB/s  0.1s
exceptiongroup                                      19.3kB @ 166.3kB/s  0.1s
msgpack-python                                     197.1kB @   1.7MB/s  0.0s
psutil                                             361.3kB @   1.3MB/s  0.2s
ipython                                            589.9kB @   2.1MB/s  0.3s
pybind11-global                                    171.8kB @ 602.7kB/s  0.2s
unicodedata2                                       374.1kB @   1.3MB/s  0.3s
pyzmq                                              456.6kB @   1.6MB/s  0.2s
jupyter_core                                        78.6kB @ 172.7kB/s  0.4s
numexpr                                            133.2kB @ 207.5kB/s  0.4s
contourpy                                          223.8kB @ 347.9kB/s  0.4s
bx-python                                            1.2MB @   1.8MB/s  0.4s
dask-core                                          858.1kB @   1.1MB/s  0.4s
imbalanced-learn                                   141.1kB @ 163.0kB/s  0.4s
cleanlab                                           186.5kB @ 196.1kB/s  0.4s
matplotlib-base                                      7.9MB @   7.5MB/s  0.8s
tornado                                            641.6kB @ 467.5kB/s  0.3s
pyyaml                                             170.6kB @ 123.8kB/s  0.3s
bokeh                                                5.3MB @   3.9MB/s  0.7s
debugpy                                              2.4MB @   1.7MB/s  0.4s
h5py                                                 1.2MB @ 821.2kB/s  0.1s
pyarrow                                              4.0MB @   2.3MB/s  0.7s
krbalancing                                        119.8kB @  60.8kB/s  0.7s
multiprocess                                       243.0kB @ 100.5kB/s  0.3s
pybedtools                                          12.7MB @   4.7MB/s  1.3s
scipy                                               15.6MB @   5.7MB/s  1.4s
pytables                                             2.0MB @ 717.7kB/s  0.3s
distributed                                        783.6kB @ 284.3kB/s  0.1s
numpy                                                6.9MB @   2.5MB/s  1.0s
markupsafe                                          24.1kB @   6.9kB/s  0.7s
brotli-python                                      349.4kB @ 100.3kB/s  0.7s
cytoolz                                            368.1kB @ 105.5kB/s  0.7s
hicexplorer                                          1.9MB @ 539.0kB/s  0.8s
lz4                                                 37.1kB @   9.7kB/s  0.4s
kiwisolver                                          73.1kB @  17.0kB/s  1.0s
fonttools                                            2.2MB @ 517.3kB/s  1.0s
pybind11                                           183.7kB @  40.9kB/s  0.7s
simplejson                                         109.0kB @  24.2kB/s  0.2s
pybigwig                                            90.7kB @  17.5kB/s  0.9s
dask                                                 7.5kB @   1.4kB/s  0.9s
pandas                                              12.4MB @   2.1MB/s  2.1s
scikit-learn                                         8.4MB @   1.4MB/s  1.4s
pillow                                              46.4MB @   7.5MB/s  4.9s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate hicexplorer_env

To deactivate an active environment, use

     $ mamba deactivate


❯ mamba install -c bioconda rename

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['rename']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/hicexplorer_env

  Updating specs:

   - rename
   - ca-certificates
   - certifi
   - openssl


  Package   Version  Build             Channel                    Size
────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────

  + perl     5.32.1  4_hd590300_perl5  conda-forge/linux-64     Cached
  + rename    1.601  hdfd78af_1        bioconda/noarch          Cached

  Summary:

  Install: 2 packages

  Total download: 0 B

────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
<br />

<a id="learn-to-use-hicexplorer-draw-some-preliminary-plots"></a>
## Learn to use `hicexplorer`, draw some preliminary plots
<a id="take-the-log2-ratio-of-q-over-g2"></a>
### Take the log2 ratio of Q over G2
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Take the log2 ratio of Q over G2</i></summary>

```bash
#!/bin/bash

#  See below for useful pertinent help messages
check_help_messages=TRUE
[[ ${check_help_messages} == TRUE ]] &&
    {
        hicCompareMatrices --help
        hicPlotMatrix --help
        hicPlotViewpoint --help
    }


[[ ${CONDA_DEFAULT_ENV} != base ]] && conda deactivate || true
source activate hicexplorer_env

[[ "$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ]] &&
    cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    true

[[ ! -d mats ]] && mkdir mats || true
[[ ! -d mats/2023-1001_init ]] && mkdir mats/2023-1001_init || true

[[ ! -d pngs ]] && mkdir pngs || true
[[ ! -d pngs/2023-1001_init ]] && mkdir pngs/2023-1001_init || true

  f_Q="08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool"
  f_1="08_zoom/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool"
  f_2="08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool"
d_out="mats/2023-1001_init"
 m_Q2="log2_Q-over-G2_${res}"
  res=50
  ext="cool"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          f_Q  ${f_Q}
          f_1  ${f_1}
          f_2  ${f_2}
        d_out  ${d_out}
         m_Q2  ${m_Q2}
          res  ${res}
          ext  ${ext}
        """
    } || true

check_command=TRUE
[[ ${check_command} == TRUE ]] &&
    {
        echo """
        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_Q}::/resolutions/${res} \\
                ${f_2}::/resolutions/${res} \\
            --outFileName ${d_out}/${m_Q2}.${ext}

        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_Q}::/resolutions/${res} \\
                ${f_2}::/resolutions/${res} \\
            --noNorm \\
            --outFileName ${d_out}/${m_Q2}.no-norm.${ext}
        """
    } || true

run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {
        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_Q}::/resolutions/${res} \
                ${f_2}::/resolutions/${res} \
            --outFileName ${d_out}/${m_Q2}.${ext}

        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_Q}::/resolutions/${res} \
                ${f_2}::/resolutions/${res} \
            --noNorm \
            --outFileName ${d_out}/${m_Q2}.no-norm.${ext}
    } || true

ls -lhaFG ${d_out}/${m_Q2}*

 in=mats/2023-1001_init/${m_Q2}  # ., ${in}.cool
out=pngs/2023-1001_init/${m_Q2}  # echo "${png}"
chr="XII"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
         in  ${in}
        out  ${out}
        chr  ${chr}
        """
    } || true

check_commands=TRUE
[[ ${check_commands} == TRUE ]] &&
    {
        echo """
        hicPlotMatrix \\
            --matrix ${in}.cool \\
            --outFileName ${out}.png \\
            --chromosomeOrder ${chr} \\
            --region ${chr}:451400-461000 \\
            --dpi 300 \\
            --colorMap coolwarm \\
            --vMin \"-4.0\" \\
            --vMax \"4.0\"
        """
    } || true

run_commands=TRUE
[[ ${run_commands} == TRUE ]] &&
    {
        hicPlotMatrix \
            --matrix ${in}.cool \
            --outFileName ${out}.${chr}-451400-461000.col-cent.png \
            --region ${chr}:451400-461000 \
            --dpi 300 \
            --colorMap coolwarm \
            --vMin "-4.0" \
            --vMax "4.0"
    } || true
```
</details>
<br />

<a id="take-the-log2-ratio-of-q-over-g1"></a>
### Take the log2 ratio of Q over G1
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Take the log2 ratio of Q over G1</i></summary>

```bash
#!/bin/bash

  f_Q="08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool"
  f_1="08_zoom/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool"
  f_2="08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool"
d_out="mats/2023-1001_init"
 m_Q1="log2_Q-over-G1_${res}"
  res=50
  ext="cool"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          f_Q  ${f_Q}
          f_1  ${f_1}
          f_2  ${f_2}
        d_out  ${d_out}
         m_Q1  ${m_Q1}
          res  ${res}
          ext  ${ext}
        """
    } || true

check_command=TRUE
[[ ${check_command} == TRUE ]] &&
    {
        echo """
        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_Q}::/resolutions/${res} \\
                ${f_1}::/resolutions/${res} \\
            --outFileName ${d_out}/${m_Q1}.${ext}

        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_Q}::/resolutions/${res} \\
                ${f_1}::/resolutions/${res} \\
            --noNorm \\
            --outFileName ${d_out}/${m_Q1}.no-norm.${ext}
        """
    } || true

run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {
        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_Q}::/resolutions/${res} \
                ${f_1}::/resolutions/${res} \
            --outFileName ${d_out}/${m_Q1}.${ext}

        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_Q}::/resolutions/${res} \
                ${f_1}::/resolutions/${res} \
            --noNorm \
            --outFileName ${d_out}/${m_Q1}.no-norm.${ext}
    } || true

ls -lhaFG ${d_out}/${m_Q1}*

 in=mats/2023-1001_init/${m_Q1}  # ., ${in}.cool
out=pngs/2023-1001_init/${m_Q1}  # echo "${png}"
chr="XII"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
         in  ${in}
        out  ${out}
        chr  ${chr}
        """
    } || true

check_commands=TRUE
[[ ${check_commands} == TRUE ]] &&
    {
        echo """
        hicPlotMatrix \\
            --matrix ${in}.cool \\
            --outFileName ${out}.png \\
            --chromosomeOrder ${chr} \\
            --region ${chr}:451400-461000 \\
            --dpi 300 \\
            --colorMap coolwarm \\
            --vMin \"-4.0\" \\
            --vMax \"4.0\"
        """
    } || true

run_commands=TRUE
[[ ${run_commands} == TRUE ]] &&
    {
        hicPlotMatrix \
            --matrix ${in}.cool \
            --outFileName ${out}.${chr}-451400-461000.col-cent.png \
            --region ${chr}:451400-461000 \
            --dpi 300 \
            --colorMap coolwarm \
            --vMin "-4.0" \
            --vMax "4.0"
    } || true
```
</details>
<br />

<a id="take-the-log2-ratio-of-g2-over-g1"></a>
### Take the log2 ratio of G2 over G1
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Take the log2 ratio of G2 over G1</i></summary>

```bash
#!/bin/bash

  f_Q="08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool"
  f_1="08_zoom/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool"
  f_2="08_zoom/MC-2020_nz_WT_repM.standard-rDNA-complete.mcool"
d_out="mats/2023-1001_init"
 m_21="log2_G2-over-G1_${res}"
  res=50
  ext="cool"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
          f_Q  ${f_Q}
          f_1  ${f_1}
          f_2  ${f_2}
        d_out  ${d_out}
         m_21  ${m_21}
          res  ${res}
          ext  ${ext}
        """
    } || true

check_command=TRUE
[[ ${check_command} == TRUE ]] &&
    {
        echo """
        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_2}::/resolutions/${res} \\
                ${f_1}::/resolutions/${res} \\
            --outFileName ${d_out}/${m_21}.${ext}

        hicCompareMatrices \\
            --operation log2ratio \\
            --matrices \\
                ${f_2}::/resolutions/${res} \\
                ${f_1}::/resolutions/${res} \\
            --noNorm \\
            --outFileName ${d_out}/${m_21}.no-norm.${ext}
        """
    } || true

run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {
        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_2}::/resolutions/${res} \
                ${f_1}::/resolutions/${res} \
            --outFileName ${d_out}/${m_21}.${ext}

        hicCompareMatrices \
            --operation log2ratio \
            --matrices \
                ${f_2}::/resolutions/${res} \
                ${f_1}::/resolutions/${res} \
            --noNorm \
            --outFileName ${d_out}/${m_21}.no-norm.${ext}
    } || true

ls -lhaFG ${d_out}/${m_21}*

 in=mats/2023-1001_init/${m_21}  # ., ${in}.cool
out=pngs/2023-1001_init/${m_21}  # echo "${png}"
chr="XII"

check_variables=TRUE
[[ ${check_variables} == TRUE ]] &&
    {
        echo """
         in  ${in}
        out  ${out}
        chr  ${chr}
        """
    } || true

check_commands=TRUE
[[ ${check_commands} == TRUE ]] &&
    {
        echo """
        hicPlotMatrix \\
            --matrix ${in}.cool \\
            --outFileName ${out}.png \\
            --chromosomeOrder ${chr} \\
            --region ${chr}:451400-461000 \\
            --dpi 300 \\
            --colorMap coolwarm \\
            --vMin \"-2.0\" \\
            --vMax \"2.0\"
        """
    } || true

run_commands=TRUE
[[ ${run_commands} == TRUE ]] &&
    {
        hicPlotMatrix \
            --matrix ${in}.cool \
            --outFileName ${out}.${chr}-451400-461000.col-cent.png \
            --region ${chr}:451400-461000 \
            --dpi 300 \
            --colorMap coolwarm \
            --vMin "-2.0" \
            --vMax "2.0"
    } || true
```
</details>
<br />

<a id="help-1"></a>
### Help
<details>
<summary><i>Help: Learn to use `hicexplorer`, draw some preliminary plots</i></summary>

```txt
❯ [[ ${check_help_messages} == TRUE ]] &&
>     {
>         hicCompareMatrices --help
>         hicPlotMatrix --help
>         hicPlotViewpoint --help
>     }
usage: hicCompareMatrices --matrices matrix.h5 matrix.h5 --outFileName OUTFILENAME [--operation {diff,ratio,log2ratio}] [--noNorm] [--help] [--version]

Takes two matrices as input, normalizes them and applies the given operation. To normalize the matrices each element is divided by the sum of the matrix.

Required arguments:
  --matrices matrix.h5 matrix.h5, -m matrix.h5 matrix.h5
                        Name of the matrices in .h5 format to use, separated by a space. (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting matrix. The output is also a .h5 file. (default: None)

Optional arguments:
  --operation {diff,ratio,log2ratio}
                        Operation to apply to the matrices (Default: log2ratio).
  --noNorm              Do not apply normalisation before computing the operation (Default: False). (default: False)
  --help, -h            show this help message and exit
  --version             show program's version number and exit


usage: hicPlotMatrix --matrix MATRIX --outFileName OUTFILENAME [--title TITLE] [--scoreName SCORENAME] [--perChromosome] [--clearMaskedBins]
                     [--chromosomeOrder CHROMOSOMEORDER [CHROMOSOMEORDER ...]] [--region REGION] [--region2 REGION2] [--log1p] [--log] [--colorMap COLORMAP] [--vMin VMIN] [--vMax VMAX]
                     [--dpi DPI] [--bigwig BIGWIG [BIGWIG ...]] [--bigwigAdditionalVerticalAxis] [--vMinBigwig VMINBIGWIG] [--vMaxBigwig VMAXBIGWIG] [--flipBigwigSign]
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
                        Plotting additional bigwig tracks can cause compression in x or y direction of the heatmap. Set this factor to a value unequal to 0 to correct this (Default: 0.5).
  --increaseFigureHeight INCREASEFIGUREHEIGHT
                        Plotting additional bigwig tracks can cause compression in x or y direction of the heatmap. Set this factor to a value unequal to 0 to correct this (Default: 0.5).
  --loops LOOPS         Bedgraph file to plot detected long range contacts from hicDetectLoops.
  --loopLargeRegionsOperation {first,last,center}
                        If a given coordinate in the bed file is larger than a bin of the input matrix, by default only the first bin is taken into account. However there are more
                        possibilities to handel such a case. Users can ask for the last bin or for center of the region.
  --tads TADS           Bedgraph file to plot detected tads
  --help, -h            show this help message and exit
  --version             show program's version number and exit


usage: hicPlotViewpoint --matrix MATRIX [MATRIX ...] --region REGION --outFileName OUTFILENAME --referencePoint REFERENCEPOINT [--chromosome CHROMOSOME]
                        [--interactionOutFileName INTERACTIONOUTFILENAME] [--dpi DPI] [--version] [--help]

Plots the number of interactions around a given reference point in a region.

Required arguments:
  --matrix MATRIX [MATRIX ...], -m MATRIX [MATRIX ...]
                        Hi-C matrix to plot.
  --region REGION       The format is chr:start-end.
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name of the image to save.
  --referencePoint REFERENCEPOINT, -rp REFERENCEPOINT
                        Reference point. Needs to be in the format: 'chr:100' for a single reference point or 'chr:100-200' for a reference region.

Optional arguments:
  --chromosome CHROMOSOME, -C CHROMOSOME
                        Optional parameter: Only show results for this chromosome.
  --interactionOutFileName INTERACTIONOUTFILENAME, -i INTERACTIONOUTFILENAME
                        Optional parameter: If set, a bedgraph file with all interaction will be created.
  --dpi DPI             Optional parameter: Resolution for the image in case theouput is a raster graphics image (e.g png, jpg) (Default: 300).
  --version             show program's version number and exit
  --help, -h            show this help message and exit
```
</details>
<br />

<a id="notes-2"></a>
### Notes
<details>
<summary><i>Notes: Learn to use `hicexplorer`, draw some preliminary plots</i></summary>
<br />

`2023-1002`: `HiCExplorer` plots (of a portion of the rDNA locus) are inconsistent with the `HiGlass` plots supplied to CC, which show a much stronger local increase in far-*cis* interactions in Q versus G1 and Q versus G2, together with a local decrease in Q near-*cis* interactions compared to the other two states.

Not sure if `HiCExplorer` is including the ICE weighting information. `#NEXTSTEP` Will set up [`GENOVA`](https://github.com/robinweide/GENOVA) `R` software for this work; `GENOVA` enables the choice to use balanced or unbalanced contacts with cool files (and `GENOVA` makes it easy to plot virtual 4C plots as well as genome-wide observed-over-expected plots too).

Also, still haven't heard back from anyone involved with `FANC` regarding [the issue encountered (see above)](https://github.com/vaquerizaslab/fanc/issues/170).
</details>
<br />
