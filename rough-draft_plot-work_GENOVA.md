
`#rough-draft_plot-work_2.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set up virtual environment for analyses with `GENOVA`](#set-up-virtual-environment-for-analyses-with-genova)
    1. [Code](#code)
    1. [Printed](#printed)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="set-up-virtual-environment-for-analyses-with-genova"></a>
## Set up virtual environment for analyses with `GENOVA`
<a id="code"></a>
### Code
<details>
<summary><i>Code: Set up virtual environment for analyses with `GENOVA`</i></summary>

Imports: 
    ggplot2 (>= 3.3.0),
    scales (>= 1.1.1),
    data.table,
    methods
RoxygenNote: 7.1.1
Suggests: 
    knitr,
    rmarkdown,
    HiCseg,
    RhpcBLASctl,
    RCurl,
    strawr (>= 0.0.1),
    rhdf5 (>= 2.30.0),
    rtracklayer,
    IRanges,
    pkgfilecache
VignetteBuilder: knitr
Remotes: aidenlab/straw/R,
   bioc::release/rhdf5,
   bioc::release/rtracklayer,
   bioc::release/IRanges

```bash
#!/bin/bash

set_channels=TRUE
[[ ${set_channels} == TRUE ]] &&
    {
        # conda config --show channels
        # conda config --describe channel_priority
        conda config --add channels defaults
        conda config --add channels r
        conda config --add channels bioconda
        conda config --add channels conda-forge
    }

env_name="genova_env"
install_env=TRUE
if [[ "${install_env}" == TRUE ]]; then
    CONDA_SUBDIR=osx-64 \
    mamba create \
        -n ${env_name} \
        -c conda-forge \
        -c bioconda \
            parallel \
            r-base=4.2 \
            r-argparse \
            r-devtools \
            r-remotes \
            r-tidyverse \
            r-scales \
            r-data.table \
            r-r.methodss3 \
            r-knitr \
            r-rmarkdown \
            r-rhpcblasctl \
            r-rcurl \
            r-strawr \
            r-pkgfilecache \
            rename \
            bioconductor-rhdf5 \
            bioconductor-rtracklayer \
            bioconductor-iranges

    alias R-genova="(
        mamba activate ${env_name}
        open -na /Applications/RStudio.app
    )"
    R-genova

    #  Install HiCseg (cran.r-project.org/web/packages/HiCseg/) via CRAN; run
    #+ the following code in an R terminal:
    #+ 
    #+ utils::install.packages("HiCseg")


    #  Per github.com/robinweide/GENOVA#installation, run the following in an R
    #+ terminal to install GENOVA, the package of interest:
    #+ 
    #+ remotes::install_github("robinweide/GENOVA")

    check_installations=TRUE
    [[ ${check_installations} == TRUE ]] &&
        {
            ., ${HOME}/mambaforge/envs/genova_env
            ., ${HOME}/mambaforge/envs/genova_env/lib/R/library/HiCseg
            ., ${HOME}/mambaforge/envs/genova_env/lib/R/library/GENOVA
        }
fi
```
</details>
<br />

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Set up virtual environment for analyses with `GENOVA`</i></summary></i></summary>

```txt
❯ conda config --show channels
channels:
  - conda-forge
  - bioconda
  - defaults


❯ conda config --describe channel_priority
# # channel_priority (ChannelPriority)
# #   Accepts values of 'strict', 'flexible', and 'disabled'. The default
# #   value is 'flexible'. With strict channel priority, packages in lower
# #   priority channels are not considered if a package with the same name
# #   appears in a higher priority channel. With flexible channel priority,
# #   the solver may reach into lower priority channels to fulfill
# #   dependencies, rather than raising an unsatisfiable error. With channel
# #   priority disabled, package version takes precedence, and the
# #   configured priority of channels is used only to break ties. In
# #   previous versions of conda, this parameter was configured as either
# #   True or False. True is now an alias to 'flexible'.
# #
# channel_priority: flexible


❯ set_channels=TRUE
❯ [[ ${set_channels} == TRUE ]] &&
cmdand>     {
cmdand cursh>         # conda config --show channels
cmdand cursh>         # conda config --describe channel_priority
cmdand cursh>         conda config --add channels defaults
cmdand cursh>         conda config --add channels r
cmdand cursh>         conda config --add channels bioconda
cmdand cursh>         conda config --add channels conda-forge
cmdand cursh>     }
Warning: 'defaults' already in 'channels' list, moving to the top
Warning: 'bioconda' already in 'channels' list, moving to the top
Warning: 'conda-forge' already in 'channels' list, moving to the top


❯ conda config --show channels
channels:
  - conda-forge
  - bioconda
  - r
  - defaults


❯ CONDA_SUBDIR=osx-64 \
> mamba create \
>     -n ${env_name} \
>     -c conda-forge \
>     -c bioconda \
>     -c r \
>         parallel \
>         r-base=4.2 \
>         r-argparse \
>         r-devtools \
>         r-remotes \
>         r-tidyverse \
>         r-scales \
>         r-data.table \
>         r-r.methodss3 \
>         r-knitr \
>         r-rmarkdown \
>         r-rhpcblasctl \
>         r-rcurl \
>         r-strawr \
>         r-pkgfilecache \
>         rename \
>         bioconductor-rhdf5 \
>         bioconductor-rtracklayer \
>         bioconductor-iranges \
>         r-hicseg

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel', 'r-base=4.2', 'r-argparse', 'r-devtools', 'r-remotes', 'r-tidyverse', 'r-scales', 'r-data.table', 'r-r.methodss3', 'r-knitr', 'r-rmarkdown', 'r-rhpcblasctl', 'r-rcurl', 'r-strawr', 'r-pkgfilecache', 'rename', 'bioconductor-rhdf5', 'bioconductor-rtracklayer', 'bioconductor-iranges', 'r-hicseg']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
r/osx-64                                                    Using cache
r/noarch                                                    Using cache
pkgs/main/osx-64                                              No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change
Could not solve for environment specs
The following package could not be installed
└─ r-hicseg   does not exist (perhaps a typo or a missing channel).


❯ CONDA_SUBDIR=osx-64 \
> mamba create \
>     -n ${env_name} \
>     -c conda-forge \
>     -c bioconda \
>         parallel \
>         r-base=4.2 \
>         r-argparse \
>         r-devtools \
>         r-remotes \
>         r-tidyverse \
>         r-scales \
>         r-data.table \
>         r-r.methodss3 \
>         r-knitr \
>         r-rmarkdown \
>         r-rhpcblasctl \
>         r-rcurl \
>         r-strawr \
>         r-pkgfilecache \
>         rename \
>         bioconductor-rhdf5 \
>         bioconductor-rtracklayer \
>         bioconductor-iranges

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel', 'r-base=4.2', 'r-argparse', 'r-devtools', 'r-remotes', 'r-tidyverse', 'r-scales', 'r-data.table', 'r-r.methodss3', 'r-knitr', 'r-rmarkdown', 'r-rhpcblasctl', 'r-rcurl', 'r-strawr', 'r-pkgfilecache', 'rename', 'bioconductor-rhdf5', 'bioconductor-rtracklayer', 'bioconductor-iranges']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
r/osx-64                                                    Using cache
r/noarch                                                    Using cache
pkgs/main/osx-64                                              No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/genova_env

  Updating specs:

   - parallel
   - r-base=4.2
   - r-argparse
   - r-devtools
   - r-remotes
   - r-tidyverse
   - r-scales
   - r-data.table
   - r-r.methodss3
   - r-knitr
   - r-rmarkdown
   - r-rhpcblasctl
   - r-rcurl
   - r-strawr
   - r-pkgfilecache
   - rename
   - bioconductor-rhdf5
   - bioconductor-rtracklayer
   - bioconductor-iranges


  Package                                   Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                                  1.0.1  anacondar_1         conda-forge/noarch     Cached
  + argcomplete                               3.1.2  pyhd8ed1ab_0        conda-forge/noarch       39kB
  + bioconductor-biobase                     2.58.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-biocgenerics                0.44.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-biocio                       1.8.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-biocparallel                1.32.5  r42hc0ef7c4_1       bioconda/osx-64        Cached
  + bioconductor-biostrings                  2.66.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-data-packages             20230718  hdfd78af_1          bioconda/noarch        Cached
  + bioconductor-delayedarray                0.24.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-genomeinfodb                1.34.9  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-genomeinfodbdata             1.2.9  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-genomicalignments           1.34.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-genomicranges               1.50.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-iranges                     2.32.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-matrixgenerics              1.10.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-rhdf5                       2.42.0  r42hfab559d_2       bioconda/osx-64           3MB
  + bioconductor-rhdf5filters                1.10.0  r42hc0ef7c4_1       bioconda/osx-64         809kB
  + bioconductor-rhdf5lib                    1.20.0  r42h4c50009_2       bioconda/osx-64           4MB
  + bioconductor-rhtslib                      2.0.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-rsamtools                   2.14.0  r42hc0ef7c4_1       bioconda/osx-64        Cached
  + bioconductor-rtracklayer                 1.58.0  r42h4bb2b61_2       bioconda/osx-64        Cached
  + bioconductor-s4vectors                   0.36.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-summarizedexperiment        1.28.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-xvector                     0.38.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-zlibbioc                    1.44.0  r42h4c50009_2       bioconda/osx-64        Cached
  + bwidget                                  1.9.14  h694c41f_1          conda-forge/osx-64     Cached
  + bzip2                                     1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + c-ares                                   1.19.1  h0dc2134_0          conda-forge/osx-64     Cached
  + ca-certificates                      2023.08.22  hecd8cb5_0          pkgs/main/osx-64       Cached
  + cairo                                    1.16.0  hfdb49f2_1017       conda-forge/osx-64      947kB
  + cctools_osx-64                          973.0.1  ha1c5b94_14         conda-forge/osx-64     Cached
  + clang                                    16.0.6  hc177806_1          conda-forge/osx-64     Cached
  + clang-16                                 16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + clang_osx-64                             16.0.6  h8787910_1          conda-forge/osx-64     Cached
  + clangxx                                  16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + clangxx_osx-64                           16.0.6  h1b7723c_1          conda-forge/osx-64     Cached
  + compiler-rt                              16.0.6  he1888fc_0          conda-forge/osx-64     Cached
  + compiler-rt_osx-64                       16.0.6  he1888fc_0          conda-forge/noarch     Cached
  + curl                                      8.3.0  h5f667d7_0          conda-forge/osx-64      151kB
  + expat                                     2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0          conda-forge/noarch     Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0          conda-forge/noarch     Cached
  + fontconfig                               2.14.2  h5bb23bf_0          conda-forge/osx-64     Cached
  + fonts-conda-ecosystem                         1  0                   conda-forge/noarch     Cached
  + fonts-conda-forge                             1  0                   conda-forge/noarch     Cached
  + freetype                                 2.12.1  h60636b9_2          conda-forge/osx-64      599kB
  + fribidi                                  1.0.10  hbcb3906_0          conda-forge/osx-64     Cached
  + gdbm                                       1.18  h8a0c380_2          conda-forge/osx-64      134kB
  + gettext                                  0.21.1  h8a4c099_0          conda-forge/osx-64     Cached
  + gfortran_impl_osx-64                     12.3.0  h54fd467_1          conda-forge/osx-64     Cached
  + gfortran_osx-64                          12.3.0  h18f7dce_1          conda-forge/osx-64     Cached
  + gmp                                       6.2.1  h2e338ed_0          conda-forge/osx-64     Cached
  + graphite2                                1.3.14  he9d5cce_1          pkgs/main/osx-64         84kB
  + gsl                                       2.7.1  hdbe807d_1          pkgs/main/osx-64          2MB
  + harfbuzz                                  8.2.1  h7666e2a_0          conda-forge/osx-64        1MB
  + icu                                        73.2  hf5e326d_0          conda-forge/osx-64       12MB
  + isl                                        0.25  hb486fe8_0          conda-forge/osx-64     Cached
  + jq                                          1.6  hc929b4f_1000       conda-forge/osx-64      377kB
  + krb5                                     1.21.2  hb884880_0          conda-forge/osx-64     Cached
  + ld64_osx-64                                 609  ha20a434_14         conda-forge/osx-64     Cached
  + lerc                                      4.0.0  hb486fe8_0          conda-forge/osx-64     Cached
  + libblas                                   3.9.0  18_osx64_openblas   conda-forge/osx-64       15kB
  + libclang-cpp16                           16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + libcurl                                   8.3.0  h5f667d7_0          conda-forge/osx-64      366kB
  + libcxx                                   16.0.6  hd57cbcb_0          conda-forge/osx-64     Cached
  + libdeflate                                 1.19  ha4e1b8e_0          conda-forge/osx-64       69kB
  + libedit                            3.1.20221030  h6c40b1e_0          pkgs/main/osx-64       Cached
  + libev                                      4.33  haf1e3a3_1          conda-forge/osx-64     Cached
  + libexpat                                  2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + libffi                                    3.4.4  hecd8cb5_0          pkgs/main/osx-64       Cached
  + libgfortran                               5.0.0  13_2_0_h97931a8_1   conda-forge/osx-64      110kB
  + libgfortran-devel_osx-64                 12.3.0  h0b6f5ec_1          conda-forge/noarch     Cached
  + libgfortran5                             13.2.0  h2873a65_1          conda-forge/osx-64        2MB
  + libgit2                                   1.7.1  h94d3247_0          conda-forge/osx-64      740kB
  + libglib                                  2.78.0  hc62aa5d_0          conda-forge/osx-64        2MB
  + libiconv                                   1.17  hac89ed1_0          conda-forge/osx-64     Cached
  + libjpeg-turbo                             3.0.0  h0dc2134_1          conda-forge/osx-64      580kB
  + liblapack                                 3.9.0  18_osx64_openblas   conda-forge/osx-64       15kB
  + libllvm16                                16.0.6  he4b1e75_2          conda-forge/osx-64     Cached
  + libnghttp2                               1.52.0  he2ab024_0          conda-forge/osx-64     Cached
  + libopenblas                              0.3.24  openmp_h48a4ad5_0   conda-forge/osx-64        6MB
  + libpng                                   1.6.39  ha978bb4_0          conda-forge/osx-64     Cached
  + libsqlite                                3.43.0  h58db7d2_0          conda-forge/osx-64     Cached
  + libssh2                                  1.11.0  hd019ec5_0          conda-forge/osx-64     Cached
  + libtiff                                   4.6.0  h684deea_2          conda-forge/osx-64      267kB
  + libwebp-base                              1.3.2  h0dc2134_0          conda-forge/osx-64      347kB
  + libxml2                                  2.11.5  h3346baf_1          conda-forge/osx-64      623kB
  + libzlib                                  1.2.13  h8a1eda9_5          conda-forge/osx-64     Cached
  + llvm-openmp                              16.0.6  hff08bdf_0          conda-forge/osx-64     Cached
  + llvm-tools                               16.0.6  he4b1e75_2          conda-forge/osx-64     Cached
  + make                                        4.3  h22f3db7_1          conda-forge/osx-64     Cached
  + mpc                                       1.3.1  h81bd1dd_0          conda-forge/osx-64     Cached
  + mpfr                                      4.2.0  h4f9bd69_0          conda-forge/osx-64     Cached
  + ncurses                                     6.4  hf0c8a7f_0          conda-forge/osx-64     Cached
  + oniguruma                                 6.9.8  hac89ed1_0          conda-forge/osx-64      396kB
  + openssl                                   3.1.3  h8a1eda9_0          conda-forge/osx-64     Cached
  + pandoc                                    3.1.3  h9d075a6_0          conda-forge/osx-64     Cached
  + pango                                   1.50.14  h19c1c8a_2          conda-forge/osx-64      419kB
  + parallel                               20230922  h694c41f_0          conda-forge/osx-64        2MB
  + pcre2                                     10.40  h1c4e4bc_0          conda-forge/osx-64     Cached
  + perl                                     5.34.0  h435f0c2_2          pkgs/main/osx-64         16MB
  + pip                                      23.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pixman                                   0.42.2  he965462_0          conda-forge/osx-64      336kB
  + python                                   3.12.0  h30d4d87_0_cpython  conda-forge/osx-64       15MB
  + python_abi                                 3.12  4_cp312             conda-forge/osx-64        6kB
  + pyyaml                                    6.0.1  py312h104f124_1     conda-forge/osx-64      186kB
  + r-argparse                                2.2.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-askpass                                 1.2.0  r42h6dc245f_0       conda-forge/osx-64       31kB
  + r-assertthat                              0.2.1  r42hc72bb7e_4       conda-forge/noarch     Cached
  + r-backports                               1.4.1  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-base                                    4.2.3  h109b13c_9          conda-forge/osx-64       25MB
  + r-base64enc                               0.1_3  r42h6dc245f_1006    conda-forge/osx-64     Cached
  + r-bh                                   1.81.0_1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-bit                                     4.0.5  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-bit64                                   4.0.5  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-bitops                                  1.0_7  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-blob                                    1.2.4  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-brew                                    1.0_8  r42hc72bb7e_2       conda-forge/noarch       69kB
  + r-brio                                    1.1.3  r42h6dc245f_2       conda-forge/osx-64       40kB
  + r-broom                                   1.0.5  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-bslib                                   0.5.1  r42hc72bb7e_0       conda-forge/noarch        5MB
  + r-cachem                                  1.0.8  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-callr                                   3.7.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-cellranger                              1.1.0  r42hc72bb7e_1006    conda-forge/noarch     Cached
  + r-cli                                     3.6.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-clipr                                   0.8.0  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-codetools                              0.2_19  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-colorspace                              2.1_0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-commonmark                              1.9.0  r42h6dc245f_1       conda-forge/osx-64      122kB
  + r-conflicted                              1.2.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-cpp11                                   0.4.6  r42hc72bb7e_0       conda-forge/noarch      230kB
  + r-crayon                                  1.5.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-credentials                             2.0.1  r42hc72bb7e_0       conda-forge/noarch      225kB
  + r-curl                                    5.1.0  r42h0100ac3_0       conda-forge/osx-64      450kB
  + r-data.table                             1.14.8  r42h7eccc33_2       conda-forge/osx-64     Cached
  + r-dbi                                     1.1.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-dbplyr                                  2.3.4  r42hc72bb7e_0       conda-forge/noarch        1MB
  + r-desc                                    1.4.2  r42hc72bb7e_2       conda-forge/noarch      331kB
  + r-devtools                                2.4.5  r42hc72bb7e_2       conda-forge/noarch      428kB
  + r-diffobj                                 0.3.5  r42h6dc245f_2       conda-forge/osx-64      967kB
  + r-digest                                 0.6.33  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-downlit                                 0.4.3  r42hc72bb7e_0       conda-forge/noarch      121kB
  + r-downloader                                0.4  r42hc72bb7e_1005    conda-forge/noarch       36kB
  + r-dplyr                                   1.1.3  r42hac7d2d5_0       conda-forge/osx-64        1MB
  + r-dtplyr                                  1.3.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-ellipsis                                0.3.2  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-evaluate                                 0.22  r42hc72bb7e_0       conda-forge/noarch       90kB
  + r-fansi                                   1.0.4  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-farver                                  2.1.1  r42hac7d2d5_2       conda-forge/osx-64     Cached
  + r-fastmap                                 1.1.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-findpython                              1.0.8  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-fontawesome                             0.5.2  r42hc72bb7e_0       conda-forge/noarch        1MB
  + r-forcats                                 1.0.0  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-formatr                                  1.14  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-fs                                      1.6.3  r42hac7d2d5_0       conda-forge/osx-64      277kB
  + r-futile.logger                           1.4.3  r42hc72bb7e_1005    conda-forge/noarch     Cached
  + r-futile.options                          1.0.1  r42hc72bb7e_1004    conda-forge/noarch     Cached
  + r-gargle                                  1.5.2  r42h785f33e_0       conda-forge/noarch      708kB
  + r-generics                                0.1.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-gert                                    2.0.0  r42he07e7ac_0       conda-forge/osx-64      255kB
  + r-ggplot2                                 3.4.3  r42hc72bb7e_0       conda-forge/noarch        3MB
  + r-gh                                      1.4.0  r42hc72bb7e_1       conda-forge/noarch      108kB
  + r-gitcreds                                0.1.2  r42hc72bb7e_2       conda-forge/noarch       94kB
  + r-glue                                    1.6.2  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-googledrive                             2.1.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-googlesheets4                           1.1.1  r42h785f33e_1       conda-forge/noarch     Cached
  + r-gtable                                  0.3.4  r42hc72bb7e_0       conda-forge/noarch      222kB
  + r-haven                                   2.5.3  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-highr                                    0.10  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-hms                                     1.1.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-htmltools                               0.5.6  r42hac7d2d5_0       conda-forge/osx-64      357kB
  + r-htmlwidgets                             1.6.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-httpuv                                 1.6.11  r42hac7d2d5_1       conda-forge/osx-64      542kB
  + r-httr                                    1.4.7  r42hc72bb7e_0       conda-forge/noarch      471kB
  + r-httr2                                   0.2.3  r42hc72bb7e_1       conda-forge/noarch      386kB
  + r-ids                                     1.0.1  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-ini                                     0.3.1  r42hc72bb7e_1005    conda-forge/noarch       33kB
  + r-isoband                                 0.2.7  r42hac7d2d5_2       conda-forge/osx-64     Cached
  + r-jquerylib                               0.1.4  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-jsonlite                                1.8.7  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-knitr                                    1.44  r42hc72bb7e_0       conda-forge/noarch        1MB
  + r-labeling                                0.4.3  r42hc72bb7e_0       conda-forge/noarch       69kB
  + r-lambda.r                                1.2.4  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-later                                   1.3.1  r42h670e93c_1       conda-forge/osx-64     Cached
  + r-lattice                                0.21_9  r42h6dc245f_0       conda-forge/osx-64        1MB
  + r-lifecycle                               1.0.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-lubridate                               1.9.3  r42h6dc245f_0       conda-forge/osx-64      970kB
  + r-magrittr                                2.0.3  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-mass                                   7.3_60  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-matrix                                1.6_1.1  r42hc46c21c_0       conda-forge/osx-64        4MB
  + r-matrixstats                             1.0.0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-memoise                                 2.0.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-mgcv                                    1.9_0  r42h9c380c6_0       conda-forge/osx-64     Cached
  + r-mime                                     0.12  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-miniui                                0.1.1.1  r42hc72bb7e_1004    conda-forge/noarch       54kB
  + r-modelr                                 0.1.11  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-munsell                                 0.5.0  r42hc72bb7e_1006    conda-forge/noarch     Cached
  + r-nlme                                  3.1_163  r42hfe07776_0       conda-forge/osx-64        2MB
  + r-openssl                                 2.1.1  r42hc61a7e2_0       conda-forge/osx-64      681kB
  + r-pillar                                  1.9.0  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-pkgbuild                                1.4.2  r42hc72bb7e_0       conda-forge/noarch      205kB
  + r-pkgconfig                               2.0.3  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-pkgdown                                 2.0.7  r42hc72bb7e_1       conda-forge/noarch      725kB
  + r-pkgfilecache                            0.1.4  r42hc72bb7e_1       conda-forge/noarch       66kB
  + r-pkgload                                 1.3.3  r42hc72bb7e_0       conda-forge/noarch      196kB
  + r-praise                                  1.0.0  r42hc72bb7e_1007    conda-forge/noarch       25kB
  + r-prettyunits                             1.2.0  r42hc72bb7e_0       conda-forge/noarch      163kB
  + r-processx                                3.8.2  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-profvis                                 0.3.8  r42h6dc245f_3       conda-forge/osx-64      205kB
  + r-progress                                1.2.2  r42hc72bb7e_4       conda-forge/noarch     Cached
  + r-promises                                1.2.1  r42hac7d2d5_0       conda-forge/osx-64        2MB
  + r-ps                                      1.7.5  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-purrr                                   1.0.2  r42h6dc245f_0       conda-forge/osx-64      486kB
  + r-r.methodss3                             1.8.2  r42hc72bb7e_2       conda-forge/noarch       97kB
  + r-r6                                      2.5.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-ragg                                    1.2.5  r42h50fe79f_4       conda-forge/osx-64      401kB
  + r-rappdirs                                0.3.3  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-rcmdcheck                               1.4.0  r42h785f33e_2       conda-forge/noarch      177kB
  + r-rcolorbrewer                            1.1_3  r42h785f33e_2       conda-forge/noarch     Cached
  + r-rcpp                                   1.0.11  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-rcurl                               1.98_1.12  r42h0100ac3_3       conda-forge/osx-64      811kB
  + r-readr                                   2.1.4  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-readxl                                  1.4.3  r42h88814b1_0       conda-forge/osx-64     Cached
  + r-rematch                                 2.0.0  r42hc72bb7e_0       conda-forge/noarch       25kB
  + r-rematch2                                2.1.2  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-remotes                               2.4.2.1  r42hc72bb7e_0       conda-forge/noarch      402kB
  + r-reprex                                  2.0.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-restfulr                               0.0.15  r42hfa19939_2       bioconda/osx-64        Cached
  + r-rhpcblasctl                           0.23_42  r42hc72ff8c_1       conda-forge/osx-64       32kB
  + r-rjson                                  0.2.21  r42hac7d2d5_3       conda-forge/osx-64     Cached
  + r-rlang                                   1.1.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-rmarkdown                                2.25  r42hc72bb7e_0       conda-forge/noarch        2MB
  + r-roxygen2                                7.2.3  r42hac7d2d5_1       conda-forge/osx-64      669kB
  + r-rprojroot                               2.0.3  r42hc72bb7e_1       conda-forge/noarch      118kB
  + r-rstudioapi                             0.15.0  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-rversions                               2.1.2  r42hc72bb7e_2       conda-forge/noarch       73kB
  + r-rvest                                   1.0.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-sass                                    0.4.7  r42hac7d2d5_0       conda-forge/osx-64        2MB
  + r-scales                                  1.2.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-selectr                                 0.4_2  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-sessioninfo                             1.2.2  r42hc72bb7e_2       conda-forge/noarch      198kB
  + r-shiny                                   1.7.5  r42h785f33e_0       conda-forge/noarch        3MB
  + r-snow                                    0.4_4  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-sourcetools                           0.1.7_1  r42hac7d2d5_1       conda-forge/osx-64       52kB
  + r-strawr                                 0.0.91  r42h519547d_1       conda-forge/osx-64      827kB
  + r-stringi                                1.7.12  r42h480af0a_3       conda-forge/osx-64      857kB
  + r-stringr                                 1.5.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-sys                                     3.4.2  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-systemfonts                             1.0.4  r42h7f6030a_2       conda-forge/osx-64     Cached
  + r-testthat                               3.1.10  r42hac7d2d5_0       conda-forge/osx-64        2MB
  + r-textshaping                             0.3.6  r42hcc8de0d_7       conda-forge/osx-64      103kB
  + r-tibble                                  3.2.1  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-tidyr                                   1.3.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-tidyselect                              1.2.0  r42hbe3e9c8_1       conda-forge/osx-64     Cached
  + r-tidyverse                               2.0.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-timechange                              0.2.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-tinytex                                  0.47  r42hc72bb7e_0       conda-forge/noarch      144kB
  + r-tzdb                                    0.4.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-urlchecker                              1.0.1  r42hc72bb7e_2       conda-forge/noarch       52kB
  + r-usethis                                 2.2.2  r42hc72bb7e_0       conda-forge/noarch      859kB
  + r-utf8                                    1.2.3  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-uuid                                    1.1_1  r42h6dc245f_0       conda-forge/osx-64       49kB
  + r-vctrs                                   0.6.3  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-viridislite                             0.4.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-vroom                                   1.6.4  r42hac7d2d5_0       conda-forge/osx-64      805kB
  + r-waldo                                   0.5.1  r42hc72bb7e_1       conda-forge/noarch      112kB
  + r-whisker                                 0.4.1  r42hc72bb7e_1       conda-forge/noarch       82kB
  + r-withr                                   2.5.1  r42hc72bb7e_0       conda-forge/noarch      239kB
  + r-xfun                                     0.40  r42hac7d2d5_0       conda-forge/osx-64      425kB
  + r-xml                                 3.99_0.14  r42hb8526f4_2       conda-forge/osx-64     Cached
  + r-xml2                                    1.3.5  r42h2e0d1c5_0       conda-forge/osx-64     Cached
  + r-xopen                                   1.0.0  r42hc72bb7e_1005    conda-forge/noarch       30kB
  + r-xtable                                  1.8_4  r42hc72bb7e_5       conda-forge/noarch      698kB
  + r-yaml                                    2.3.7  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-zip                                     2.3.0  r42h6dc245f_1       conda-forge/osx-64      126kB
  + readline                                    8.2  h9e318b2_1          conda-forge/osx-64     Cached
  + rename                                    1.601  hdfd78af_1          bioconda/noarch        Cached
  + setuptools                               68.2.2  pyhd8ed1ab_0        conda-forge/noarch      464kB
  + sigtool                                   0.1.3  h88f4db0_0          conda-forge/osx-64     Cached
  + tapi                                  1100.0.11  h9ce4665_0          conda-forge/osx-64     Cached
  + tk                                       8.6.13  hef22860_0          conda-forge/osx-64        3MB
  + tktable                                    2.10  ha166976_5          conda-forge/osx-64       80kB
  + toml                                     0.10.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tomlkit                                  0.12.1  pyha770c72_0        conda-forge/noarch     Cached
  + tzdata                                    2023c  h71feb2d_0          conda-forge/noarch     Cached
  + wheel                                    0.41.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xmltodict                                0.13.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xz                                        5.4.2  h6c40b1e_0          pkgs/main/osx-64       Cached
  + yaml                                      0.2.5  h0d85af4_2          conda-forge/osx-64     Cached
  + yq                                        3.2.3  pyhd8ed1ab_0        conda-forge/noarch       23kB
  + zlib                                     1.2.13  h8a1eda9_5          conda-forge/osx-64     Cached
  + zstd                                      1.5.5  h829000d_0          conda-forge/osx-64     Cached

  Summary:

  Install: 294 packages

  Total download: 152MB

────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
python_abi                                           6.5kB @ 119.4kB/s  0.1s
libdeflate                                          69.0kB @   1.2MB/s  0.1s
libjpeg-turbo                                      579.7kB @   8.6MB/s  0.1s
libwebp-base                                       346.6kB @   4.7MB/s  0.1s
libgfortran                                        109.9kB @   1.2MB/s  0.0s
liblapack                                           14.7kB @ 157.0kB/s  0.0s
freetype                                           599.3kB @   5.4MB/s  0.1s
harfbuzz                                             1.3MB @   7.3MB/s  0.1s
pango                                              418.7kB @   2.3MB/s  0.1s
argcomplete                                         39.5kB @ 181.0kB/s  0.0s
libglib                                              2.5MB @  11.3MB/s  0.1s
icu                                                 11.8MB @  47.0MB/s  0.3s
r-uuid                                              49.2kB @ 185.4kB/s  0.0s
r-stringi                                          856.6kB @   2.8MB/s  0.1s
r-sourcetools                                       51.7kB @ 149.5kB/s  0.2s
r-nlme                                               2.3MB @   6.4MB/s  0.1s
yq                                                  23.4kB @  61.8kB/s  0.0s
r-rcurl                                            811.1kB @   2.1MB/s  0.1s
r-ini                                               32.9kB @  83.6kB/s  0.0s
r-commonmark                                       121.6kB @ 296.6kB/s  0.2s
r-praise                                            25.3kB @  59.9kB/s  0.0s
r-withr                                            239.1kB @ 554.0kB/s  0.0s
perl                                                15.7MB @  36.1MB/s  0.4s
r-r.methodss3                                       97.2kB @ 221.6kB/s  0.0s
r-rversions                                         72.9kB @ 160.4kB/s  0.0s
r-prettyunits                                      163.2kB @ 336.7kB/s  0.1s
r-knitr                                              1.3MB @   2.6MB/s  0.1s
bioconductor-rhdf5lib                                3.9MB @   7.3MB/s  0.1s
r-downloader                                        36.2kB @  49.0kB/s  0.3s
r-gert                                             255.3kB @ 345.5kB/s  0.2s
r-textshaping                                      103.0kB @ 134.6kB/s  0.2s
r-httr                                             471.0kB @ 613.6kB/s  0.3s
r-xopen                                             30.1kB @  38.9kB/s  0.0s
r-promises                                           1.6MB @   2.0MB/s  0.3s
r-vroom                                            804.6kB @ 980.2kB/s  0.0s
r-bslib                                              5.1MB @   6.1MB/s  0.1s
r-pkgload                                          196.1kB @ 230.2kB/s  0.1s
pixman                                             336.2kB @ 387.4kB/s  0.0s
r-ggplot2                                            3.3MB @   3.7MB/s  0.1s
jq                                                 377.3kB @ 421.5kB/s  0.0s
r-rmarkdown                                          2.1MB @   2.3MB/s  0.1s
graphite2                                           83.6kB @  89.8kB/s  0.0s
libopenblas                                          6.2MB @   6.4MB/s  0.1s
libgit2                                            740.2kB @ 761.3kB/s  0.1s
pyyaml                                             185.6kB @ 186.5kB/s  0.1s
r-brio                                              39.6kB @  39.0kB/s  0.1s
r-xfun                                             424.9kB @ 402.5kB/s  0.1s
r-testthat                                           1.6MB @   1.5MB/s  0.3s
r-matrix                                             4.0MB @   3.7MB/s  0.1s
parallel                                             1.9MB @   1.7MB/s  0.2s
r-whisker                                           82.0kB @  75.3kB/s  0.0s
r-evaluate                                          89.7kB @  80.8kB/s  0.0s
r-urlchecker                                        51.6kB @  46.2kB/s  0.0s
r-remotes                                          401.6kB @ 356.2kB/s  0.0s
r-htmltools                                        356.9kB @ 314.9kB/s  0.1s
r-fontawesome                                        1.3MB @   1.1MB/s  0.0s
r-downlit                                          120.6kB @ 103.2kB/s  0.0s
r-pkgbuild                                         205.4kB @ 170.6kB/s  0.0s
r-gargle                                           708.4kB @ 583.1kB/s  0.1s
r-lubridate                                        970.2kB @ 796.0kB/s  0.1s
r-sass                                               2.1MB @   1.7MB/s  0.1s
r-devtools                                         427.7kB @ 339.3kB/s  0.0s
r-pkgfilecache                                      65.8kB @  52.1kB/s  0.2s
r-pkgdown                                          725.0kB @ 570.8kB/s  0.1s
libblas                                             14.8kB @  11.5kB/s  0.0s
libcurl                                            366.3kB @ 280.4kB/s  0.0s
libgfortran5                                         1.6MB @   1.2MB/s  0.1s
libxml2                                            623.4kB @ 474.8kB/s  0.0s
r-xtable                                           698.2kB @ 514.9kB/s  0.0s
r-curl                                             449.9kB @ 327.6kB/s  0.1s
r-askpass                                           30.5kB @  22.1kB/s  0.1s
r-rematch                                           24.9kB @  17.8kB/s  0.0s
r-rprojroot                                        118.2kB @  84.2kB/s  0.0s
r-sessioninfo                                      198.0kB @ 139.8kB/s  0.0s
r-gtable                                           222.5kB @ 155.3kB/s  0.0s
r-purrr                                            485.5kB @ 334.6kB/s  0.0s
r-roxygen2                                         669.0kB @ 457.1kB/s  0.3s
bioconductor-rhdf5                                   2.9MB @   2.0MB/s  0.1s
r-waldo                                            111.9kB @  74.7kB/s  0.0s
tktable                                             80.0kB @  52.2kB/s  0.0s
libtiff                                            266.5kB @ 172.0kB/s  0.0s
r-shiny                                              3.5MB @   2.2MB/s  0.1s
curl                                               151.3kB @  96.0kB/s  0.0s
r-lattice                                            1.3MB @ 834.6kB/s  0.1s
r-brew                                              68.9kB @  42.7kB/s  0.0s
r-base                                              24.7MB @  15.1MB/s  0.4s
r-desc                                             330.5kB @ 200.5kB/s  0.0s
r-tinytex                                          143.6kB @  85.3kB/s  0.1s
r-usethis                                          858.6kB @ 509.4kB/s  0.0s
tk                                                   3.3MB @   1.9MB/s  0.1s
r-profvis                                          205.4kB @ 115.6kB/s  0.3s
cairo                                              946.7kB @ 528.7kB/s  0.0s
r-dplyr                                              1.4MB @ 777.4kB/s  0.1s
r-cpp11                                            229.7kB @ 124.5kB/s  0.0s
r-openssl                                          681.1kB @ 363.0kB/s  0.1s
r-gh                                               108.4kB @  57.5kB/s  0.0s
r-strawr                                           827.3kB @ 430.3kB/s  0.4s
r-dbplyr                                             1.1MB @ 561.3kB/s  0.1s
r-diffobj                                          966.8kB @ 487.0kB/s  0.3s
r-zip                                              126.1kB @  62.9kB/s  0.2s
r-credentials                                      224.8kB @ 106.9kB/s  0.1s
gsl                                                  2.3MB @   1.1MB/s  0.2s
oniguruma                                          395.6kB @ 184.2kB/s  0.0s
r-ragg                                             401.2kB @ 185.3kB/s  0.3s
r-httr2                                            386.3kB @ 177.2kB/s  0.0s
setuptools                                         464.4kB @ 211.8kB/s  0.1s
r-rcmdcheck                                        176.7kB @  80.4kB/s  0.0s
r-httpuv                                           542.3kB @ 242.3kB/s  0.2s
bioconductor-rhdf5filters                          808.8kB @ 358.3kB/s  0.1s
r-fs                                               277.4kB @ 122.6kB/s  0.1s
r-miniui                                            53.7kB @  23.7kB/s  0.0s
r-gitcreds                                          94.4kB @  41.2kB/s  0.0s
r-labeling                                          69.1kB @  30.0kB/s  0.0s
gdbm                                               134.2kB @  58.2kB/s  0.1s
python                                              14.5MB @   6.1MB/s  0.2s
r-rhpcblasctl                                       32.3kB @  13.4kB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate genova_env

To deactivate an active environment, use

     $ mamba deactivate


❯ alias R-genova="(
dquote>     mamba activate ${env_name}
dquote>     open -na /Applications/RStudio.app
dquote> )"
❯ R-genova


❯ #  Install HiCseg (cran.r-project.org/web/packages/HiCseg/) via CRAN; run
❯ #+ the following code in an R terminal:
❯ #+
❯ #+ utils::install.packages("HiCseg")
> utils::install.packages("HiCseg")
utils::install.packages("HiCseg")
trying URL 'https://cran.rstudio.com/src/contrib/HiCseg_1.1.tar.gz'
Content type 'application/x-gzip' length 314105 bytes (306 KB)
==================================================
downloaded 306 KB

* installing *source* package ‘HiCseg’ ...
** package ‘HiCseg’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
x86_64-apple-darwin13.4.0-clang -I"/Users/kalavatt/mambaforge/envs/genova_env/lib/R/include" -DNDEBUG -I/usr/local/include -I.  -D_FORTIFY_SOURCE=2 -isystem /Users/kalavatt/mambaforge/envs/genova_env/include -mmacosx-version-min=10.9 -I/Users/kalavatt/mambaforge/envs/genova_env/include   -fPIC  -march=core2 -mtune=haswell -mssse3 -ftree-vectorize -fPIC -fPIE -fstack-protector-strong -O2 -pipe -isystem /Users/kalavatt/mambaforge/envs/genova_env/include -fdebug-prefix-map=/Users/runner/miniforge3/conda-bld/r-base-split_1695968354839/work=/usr/local/src/conda/r-base-4.2.3 -fdebug-prefix-map=/Users/kalavatt/mambaforge/envs/genova_env=/usr/local/src/conda-prefix  -c HiCseg_linkR.c -o HiCseg_linkR.o
x86_64-apple-darwin13.4.0-clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Users/kalavatt/mambaforge/envs/genova_env/lib/R/lib -Wl,-dead_strip_dylibs -Wl,-pie -Wl,-headerpad_max_install_names -Wl,-dead_strip_dylibs -Wl,-rpath,/Users/kalavatt/mambaforge/envs/genova_env/lib -L/Users/kalavatt/mambaforge/envs/genova_env/lib -o HiCseg.dylib HiCseg_linkR.o -L/usr/local/lib -lgsl -lgslcblas -L/Users/kalavatt/mambaforge/envs/genova_env/lib/R/lib -lR -Wl,-framework -Wl,CoreFoundation
ld: warning: -pie being ignored. It is only used when linking a main executable
installing to /Users/kalavatt/mambaforge/envs/genova_env/lib/R/library/00LOCK-HiCseg/00new/HiCseg/libs
** R
** data
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (HiCseg)

The downloaded source packages are in
    ‘/private/var/folders/58/xy2vwvwj6c51whrb5ns2754m0000gq/T/RtmpuIXspm/downloaded_packages’
Updating HTML index of packages in '.Library'
Making 'packages.html' ... done


❯ #  Per github.com/robinweide/GENOVA#installation, run the following in an R
❯ #+ terminal to install GENOVA, the package of interest:
❯ #+
❯ #+ remotes::install_github("robinweide/GENOVA")
> remotes::install_github("robinweide/GENOVA")
Downloading GitHub repo robinweide/GENOVA@HEAD
── R CMD build ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
✔  checking for file ‘/private/var/folders/58/xy2vwvwj6c51whrb5ns2754m0000gq/T/RtmpuIXspm/remotes15a562502dda0/robinweide-GENOVA-7622971/DESCRIPTION’ (362ms)
─  preparing ‘GENOVA’:
✔  checking DESCRIPTION meta-information ...
─  checking for LF line-endings in source and make files and shell scripts
─  checking for empty or unneeded directories
─  building ‘GENOVA_1.0.1.tar.gz’
   
* installing *source* package ‘GENOVA’ ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Note: possible error in 'rev(range(compbreaks), ': unused argument (na.rm = TRUE) 
** help
*** installing help indices
*** copying figures
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (GENOVA)


❯ check_installations=TRUE
❯ [[ ${check_installations} == TRUE ]] &&
cmdand>     {
cmdand cursh>         ., ${HOME}/mambaforge/envs/genova_env
cmdand cursh>         ., ${HOME}/mambaforge/envs/genova_env/lib/R/library/HiCseg
cmdand cursh>         ., ${HOME}/mambaforge/envs/genova_env/lib/R/library/GENOVA
cmdand cursh>     }
total 0
drwxr-xr-x   15 kalavatt  staff   480B Oct  3 06:51 ./
drwxr-xr-x   10 kalavatt  staff   320B Oct  3 06:51 ../
drwxr-xr-x  372 kalavatt  staff    12K Oct  3 06:51 bin/
drwxr-xr-x    4 kalavatt  staff   128B Oct  3 06:51 cmake/
drwxr-xr-x  297 kalavatt  staff   9.3K Oct  3 06:51 conda-meta/
drwxr-xr-x    4 kalavatt  staff   128B Oct  3 06:51 etc/
drwxr-xr-x   33 kalavatt  staff   1.0K Oct  3 06:51 fonts/
drwxr-xr-x  210 kalavatt  staff   6.6K Oct  3 06:51 include/
drwxr-xr-x  340 kalavatt  staff    11K Oct  3 06:51 lib/
drwxr-xr-x    4 kalavatt  staff   128B Oct  3 06:51 libexec/
drwxr-xr-x    4 kalavatt  staff   128B Oct  3 06:51 man/
drwxr-xr-x   14 kalavatt  staff   448B Oct  3 06:51 sbin/
drwxr-xr-x   24 kalavatt  staff   768B Oct  3 06:51 share/
drwxr-xr-x    9 kalavatt  staff   288B Oct  3 06:51 ssl/
drwxr-xr-x    3 kalavatt  staff    96B Oct  3 06:51 var/

total 24
drwxr-xr-x@  12 kalavatt  staff   384B Oct  3 06:57 ./
drwxr-xr-x  209 kalavatt  staff   6.5K Oct  3 07:00 ../
-rw-r--r--@   1 kalavatt  staff   559B Oct  3 06:56 DESCRIPTION
-rw-r--r--@   1 kalavatt  staff   129B Oct  3 06:57 INDEX
drwxr-xr-x@  10 kalavatt  staff   320B Oct  3 06:57 Meta/
-rw-r--r--@   1 kalavatt  staff    49B Oct  3 06:56 NAMESPACE
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 06:57 R/
drwxr-xr-x@   3 kalavatt  staff    96B Oct  3 06:57 data/
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 06:57 doc/
drwxr-xr-x@   7 kalavatt  staff   224B Oct  3 06:57 help/
drwxr-xr-x@   4 kalavatt  staff   128B Oct  3 06:57 html/
drwxr-xr-x@   3 kalavatt  staff    96B Oct  3 06:57 libs/

total 136
drwxr-xr-x@  13 kalavatt  staff   416B Oct  3 07:00 ./
drwxr-xr-x  209 kalavatt  staff   6.5K Oct  3 07:00 ../
-rw-r--r--@   1 kalavatt  staff   961B Oct  3 07:00 CITATION
-rw-r--r--@   1 kalavatt  staff   1.4K Oct  3 07:00 DESCRIPTION
-rw-r--r--@   1 kalavatt  staff   3.5K Oct  3 07:00 INDEX
-rw-r--r--@   1 kalavatt  staff    34K Oct  3 07:00 LICENSE
drwxr-xr-x@   9 kalavatt  staff   288B Oct  3 07:00 Meta/
-rw-r--r--@   1 kalavatt  staff   5.3K Oct  3 07:00 NAMESPACE
-rw-r--r--@   1 kalavatt  staff    11K Oct  3 07:00 NEWS.md
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 07:00 R/
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 07:00 data/
drwxr-xr-x@   8 kalavatt  staff   256B Oct  3 07:00 help/
drwxr-xr-x@   4 kalavatt  staff   128B Oct  3 07:00 html/
```
</details>
<br />
