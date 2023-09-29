
## Review what files we have with what resolutions
### On the files as described in `work_download-data.md`
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

### On the files in `2023-0307_work_Micro-C_align-process`
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

#### Notes
<details>
<summary><i>Notes: On the files in `2023-0307_work_Micro-C_align-process`</i></summary>
<br />

We currently don't have Sarah's unmerged biological replicates for the Q data, and they're not available via public data repositories; however, they remember that they were amidst Sarah's files on [Motuz](https://motuz.fredhutch.org/login).

- [ ] Get and process them
- [ ] Consider MDS projections of Q, G1, G2/M biological replicates for all interactions and only rDNA interactions `#MAYBE`
</details>
<br />

### What are the resolutions associated with the files in `2023-0307_work_Micro-C_align-process/08_zoom`?
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

# cooler dump ${f_cool}::/resolutions/6400 -r "I:100000-200000" | head
```
</details>
<br />

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

## Set up virtual environment for analyses with `FAN-C`
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

## Learn to use `fanc compare`, draw some preliminary plots
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


    -vvv \

fancplot \
    -o "test.pdf" \
    XII:100000-200000 \
    -p square \
    -vmin 0 -vmax 0.1 \
    --title "6400 bp, XII:100000-200000" \
    -c Reds \
    08_zoom/MC-2019_Q_WT_repM.standard-rDNA-complete.mcool@6400

    "${f_Q}@${res}"

run_command=TRUE
[[ ${run_command} == TRUE ]] &&
    {

    } || true

ls mats/2023-0929_init
ls pngs/2023-0929_init
```
</details>
<br />

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



```
</details>
<br />

### Help
<details>
<summary><i>Help: </i></summary>

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
