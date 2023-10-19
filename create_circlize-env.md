
`#create_circlize_env.md`
<br />
<br />

## Create `circlize_env`
### Code
<details>
<summary><i>Code: Create `circlize_env`</i></summary>

```bash
#!/bin/bash

CONDA_SUBDIR=osx-64 \
mamba create \
    -n circlize_env \
    -c conda-forge \
    -c bioconda \
    parallel \
    r-base=4.2 \
    r-argparse \
    r-circlize \
    r-data.table \
    r-devtools \
    r-rhpcblasctl \
    r-knitr \
    r-pkgfilecache \
    r-rcurl \
    r-r.methodss3 \
    r-remotes \
    r-rmarkdown \
    r-scales \
    r-strawr \
    r-tidyverse \
    rename \
    bioconductor-rhdf5 \
    bioconductor-rtracklayer \
    bioconductor-iranges
```
</details>
<br />

### Printed
<details>
<summary><i>Printed: Create `circlize_env`</i></summary>

```txt
❯ CONDA_SUBDIR=osx-64 \
> mamba create \
>     -n circlize_env \
>     -c conda-forge \
>     -c bioconda \
>     parallel \
>     r-base=4.2 \
>     r-argparse \
>     r-circlize \
>     r-data.table \
>     r-devtools \
>     r-rhpcblasctl \
>     r-knitr \
>     r-pkgfilecache \
>     r-rcurl \
>     r-r.methodss3 \
>     r-remotes \
>     r-rmarkdown \
>     r-scales \
>     r-strawr \
>     r-tidyverse \
>     rename \
>     bioconductor-rhdf5 \
>     bioconductor-rtracklayer \
>     bioconductor-iranges

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


Looking for: ['parallel', 'r-base=4.2', 'r-argparse', 'r-circlize', 'r-data.table', 'r-devtools', 'r-rhpcblasctl', 'r-knitr', 'r-pkgfilecache', 'r-rcurl', 'r-r.methodss3', 'r-remotes', 'r-rmarkdown', 'r-scales', 'r-strawr', 'r-tidyverse', 'rename', 'bioconductor-rhdf5', 'bioconductor-rtracklayer', 'bioconductor-iranges']

r/osx-64                                                      No change
r/noarch                                                      No change
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                        1.3MB @   1.6MB/s  0.6s
bioconda/osx-64                                      4.3MB @   3.6MB/s  1.3s
bioconda/noarch                                      4.7MB @   3.3MB/s  1.6s
pkgs/main/noarch                                   853.0kB @ 538.1kB/s  0.4s
conda-forge/noarch                                  14.2MB @   5.0MB/s  3.1s
pkgs/main/osx-64                                     5.9MB @   1.9MB/s  2.3s
conda-forge/osx-64                                  31.5MB @   4.6MB/s  7.4s
warning  libmamba Invalid package cache, file '/Users/kalavatt/mambaforge/pkgs/r-base-4.2.3-h109b13c_9/lib/R/doc/html/packages.html' has incorrect size
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/circlize_env

  Updating specs:

   - parallel
   - r-base=4.2
   - r-argparse
   - r-circlize
   - r-data.table
   - r-devtools
   - r-rhpcblasctl
   - r-knitr
   - r-pkgfilecache
   - r-rcurl
   - r-r.methodss3
   - r-remotes
   - r-rmarkdown
   - r-scales
   - r-strawr
   - r-tidyverse
   - rename
   - bioconductor-rhdf5
   - bioconductor-rtracklayer
   - bioconductor-iranges


  Package                                   Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                                  1.0.1  anacondar_1         conda-forge/noarch     Cached
  + argcomplete                               3.1.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
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
  + bioconductor-rhdf5                       2.42.0  r42hfab559d_2       bioconda/osx-64        Cached
  + bioconductor-rhdf5filters                1.10.0  r42hc0ef7c4_1       bioconda/osx-64        Cached
  + bioconductor-rhdf5lib                    1.20.0  r42h4c50009_2       bioconda/osx-64        Cached
  + bioconductor-rhtslib                      2.0.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-rsamtools                   2.14.0  r42hc0ef7c4_1       bioconda/osx-64        Cached
  + bioconductor-rtracklayer                 1.58.0  r42h4bb2b61_2       bioconda/osx-64        Cached
  + bioconductor-s4vectors                   0.36.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-summarizedexperiment        1.28.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-xvector                     0.38.0  r42h4c50009_1       bioconda/osx-64        Cached
  + bioconductor-zlibbioc                    1.44.0  r42h4c50009_2       bioconda/osx-64        Cached
  + bwidget                                  1.9.14  h694c41f_1          conda-forge/osx-64     Cached
  + bzip2                                     1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + c-ares                                   1.20.1  h10d778d_0          conda-forge/osx-64      103kB
  + ca-certificates                      2023.08.22  hecd8cb5_0          pkgs/main/osx-64       Cached
  + cairo                                    1.18.0  h99e66fa_0          conda-forge/osx-64      885kB
  + cctools_osx-64                          973.0.1  ha1c5b94_15         conda-forge/osx-64        1MB
  + clang                                    16.0.6  hc177806_1          conda-forge/osx-64     Cached
  + clang-16                                 16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + clang_osx-64                             16.0.6  h8787910_2          conda-forge/osx-64       21kB
  + clangxx                                  16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + clangxx_osx-64                           16.0.6  h1b7723c_2          conda-forge/osx-64       20kB
  + compiler-rt                              16.0.6  he1888fc_1          conda-forge/osx-64       93kB
  + compiler-rt_osx-64                       16.0.6  he1888fc_1          conda-forge/noarch       10MB
  + curl                                      8.4.0  h726d00d_0          conda-forge/osx-64      153kB
  + expat                                     2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0          conda-forge/noarch     Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0          conda-forge/noarch     Cached
  + fontconfig                               2.14.2  h5bb23bf_0          conda-forge/osx-64     Cached
  + fonts-conda-ecosystem                         1  0                   conda-forge/noarch     Cached
  + fonts-conda-forge                             1  0                   conda-forge/noarch     Cached
  + freetype                                 2.12.1  h60636b9_2          conda-forge/osx-64     Cached
  + fribidi                                  1.0.10  hbcb3906_0          conda-forge/osx-64     Cached
  + gdbm                                       1.18  h8a0c380_2          conda-forge/osx-64     Cached
  + gettext                                  0.21.1  h8a4c099_0          conda-forge/osx-64     Cached
  + gfortran_impl_osx-64                     12.3.0  h54fd467_1          conda-forge/osx-64     Cached
  + gfortran_osx-64                          12.3.0  h18f7dce_1          conda-forge/osx-64     Cached
  + gmp                                       6.2.1  h2e338ed_0          conda-forge/osx-64     Cached
  + graphite2                                1.3.14  he9d5cce_1          pkgs/main/osx-64       Cached
  + gsl                                       2.7.1  hdbe807d_1          pkgs/main/osx-64       Cached
  + harfbuzz                                  8.2.1  h7666e2a_0          conda-forge/osx-64     Cached
  + icu                                        73.2  hf5e326d_0          conda-forge/osx-64     Cached
  + isl                                        0.25  hb486fe8_0          conda-forge/osx-64     Cached
  + jq                                          1.6  hc929b4f_1000       conda-forge/osx-64     Cached
  + krb5                                     1.21.2  hb884880_0          conda-forge/osx-64     Cached
  + ld64_osx-64                                 609  ha20a434_15         conda-forge/osx-64        1MB
  + lerc                                      4.0.0  hb486fe8_0          conda-forge/osx-64     Cached
  + libblas                                   3.9.0  19_osx64_openblas   conda-forge/osx-64       15kB
  + libclang-cpp16                           16.0.6  default_h762fdd7_1  conda-forge/osx-64     Cached
  + libcurl                                   8.4.0  h726d00d_0          conda-forge/osx-64      366kB
  + libcxx                                   16.0.6  hd57cbcb_0          conda-forge/osx-64     Cached
  + libdeflate                                 1.19  ha4e1b8e_0          conda-forge/osx-64     Cached
  + libedit                            3.1.20221030  h6c40b1e_0          pkgs/main/osx-64       Cached
  + libev                                      4.33  haf1e3a3_1          conda-forge/osx-64     Cached
  + libexpat                                  2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + libffi                                    3.4.4  hecd8cb5_0          pkgs/main/osx-64       Cached
  + libgfortran                               5.0.0  13_2_0_h97931a8_1   conda-forge/osx-64     Cached
  + libgfortran-devel_osx-64                 12.3.0  h0b6f5ec_1          conda-forge/noarch     Cached
  + libgfortran5                             13.2.0  h2873a65_1          conda-forge/osx-64     Cached
  + libgit2                                   1.7.1  h94d3247_0          conda-forge/osx-64     Cached
  + libglib                                  2.78.0  hc62aa5d_0          conda-forge/osx-64     Cached
  + libiconv                                   1.17  hac89ed1_0          conda-forge/osx-64     Cached
  + libjpeg-turbo                             3.0.0  h0dc2134_1          conda-forge/osx-64     Cached
  + liblapack                                 3.9.0  19_osx64_openblas   conda-forge/osx-64       15kB
  + libllvm16                                16.0.6  he4b1e75_2          conda-forge/osx-64     Cached
  + libnghttp2                               1.57.0  h9beae6a_0          pkgs/main/osx-64        684kB
  + libopenblas                              0.3.24  openmp_h48a4ad5_0   conda-forge/osx-64     Cached
  + libpng                                   1.6.39  ha978bb4_0          conda-forge/osx-64     Cached
  + libsqlite                                3.43.2  h92b6c6a_0          conda-forge/osx-64      885kB
  + libssh2                                  1.11.0  hd019ec5_0          conda-forge/osx-64     Cached
  + libtiff                                   4.6.0  h684deea_2          conda-forge/osx-64     Cached
  + libwebp-base                              1.3.2  h0dc2134_0          conda-forge/osx-64     Cached
  + libxml2                                  2.11.5  h3346baf_1          conda-forge/osx-64     Cached
  + libzlib                                  1.2.13  h8a1eda9_5          conda-forge/osx-64     Cached
  + llvm-openmp                              17.0.3  hb6ac08f_0          conda-forge/osx-64      300kB
  + llvm-tools                               16.0.6  he4b1e75_2          conda-forge/osx-64     Cached
  + make                                        4.3  h22f3db7_1          conda-forge/osx-64     Cached
  + mpc                                       1.3.1  h81bd1dd_0          conda-forge/osx-64     Cached
  + mpfr                                      4.2.0  h4f9bd69_0          conda-forge/osx-64     Cached
  + ncurses                                     6.4  hf0c8a7f_0          conda-forge/osx-64     Cached
  + oniguruma                                 6.9.9  h10d778d_0          conda-forge/osx-64      224kB
  + openssl                                   3.1.3  h8a1eda9_0          conda-forge/osx-64     Cached
  + pandoc                                    3.1.3  h9d075a6_0          conda-forge/osx-64     Cached
  + pango                                   1.50.14  h19c1c8a_2          conda-forge/osx-64     Cached
  + parallel                               20230922  h694c41f_0          conda-forge/osx-64     Cached
  + pcre2                                     10.40  h1c4e4bc_0          conda-forge/osx-64     Cached
  + perl                                     5.34.0  h435f0c2_2          pkgs/main/osx-64       Cached
  + pip                                        23.3  pyhd8ed1ab_0        conda-forge/noarch        1MB
  + pixman                                   0.42.2  he965462_0          conda-forge/osx-64     Cached
  + python                                   3.12.0  h30d4d87_0_cpython  conda-forge/osx-64     Cached
  + python_abi                                 3.12  4_cp312             conda-forge/osx-64     Cached
  + pyyaml                                    6.0.1  py312h104f124_1     conda-forge/osx-64     Cached
  + r-argparse                                2.2.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-askpass                                 1.2.0  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-assertthat                              0.2.1  r42hc72bb7e_4       conda-forge/noarch     Cached
  + r-backports                               1.4.1  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-base                                    4.2.3  h109b13c_9          conda-forge/osx-64     Cached
  + r-base64enc                               0.1_3  r42h6dc245f_1006    conda-forge/osx-64     Cached
  + r-bh                                   1.81.0_1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-bit                                     4.0.5  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-bit64                                   4.0.5  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-bitops                                  1.0_7  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-blob                                    1.2.4  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-brew                                    1.0_8  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-brio                                    1.1.3  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-broom                                   1.0.5  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-bslib                                   0.5.1  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-cachem                                  1.0.8  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-callr                                   3.7.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-cellranger                              1.1.0  r42hc72bb7e_1006    conda-forge/noarch     Cached
  + r-circlize                               0.4.15  r42hc72bb7e_2       conda-forge/noarch        3MB
  + r-cli                                     3.6.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-clipr                                   0.8.0  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-codetools                              0.2_19  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-colorspace                              2.1_0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-commonmark                              1.9.0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-conflicted                              1.2.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-cpp11                                   0.4.6  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-crayon                                  1.5.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-credentials                             2.0.1  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-curl                                    5.1.0  r42h0100ac3_0       conda-forge/osx-64     Cached
  + r-data.table                             1.14.8  r42h7eccc33_2       conda-forge/osx-64     Cached
  + r-dbi                                     1.1.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-dbplyr                                  2.3.4  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-desc                                    1.4.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-devtools                                2.4.5  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-diffobj                                 0.3.5  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-digest                                 0.6.33  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-downlit                                 0.4.3  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-downloader                                0.4  r42hc72bb7e_1005    conda-forge/noarch     Cached
  + r-dplyr                                   1.1.3  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-dtplyr                                  1.3.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-ellipsis                                0.3.2  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-evaluate                                 0.22  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-fansi                                   1.0.5  r42hb2c329c_0       conda-forge/osx-64      310kB
  + r-farver                                  2.1.1  r42hac7d2d5_2       conda-forge/osx-64     Cached
  + r-fastmap                                 1.1.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-findpython                              1.0.8  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-fontawesome                             0.5.2  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-forcats                                 1.0.0  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-formatr                                  1.14  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-fs                                      1.6.3  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-futile.logger                           1.4.3  r42hc72bb7e_1005    conda-forge/noarch     Cached
  + r-futile.options                          1.0.1  r42hc72bb7e_1004    conda-forge/noarch     Cached
  + r-gargle                                  1.5.2  r42h785f33e_0       conda-forge/noarch     Cached
  + r-generics                                0.1.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-gert                                    2.0.0  r42he07e7ac_0       conda-forge/osx-64     Cached
  + r-ggplot2                                 3.4.4  r42hc72bb7e_0       conda-forge/noarch        4MB
  + r-gh                                      1.4.0  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-gitcreds                                0.1.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-globaloptions                           0.1.2  r42ha770c72_2       conda-forge/noarch      437kB
  + r-glue                                    1.6.2  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-googledrive                             2.1.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-googlesheets4                           1.1.1  r42h785f33e_1       conda-forge/noarch     Cached
  + r-gtable                                  0.3.4  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-haven                                   2.5.3  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-highr                                    0.10  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-hms                                     1.1.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-htmltools                             0.5.6.1  r42h64b2c41_0       conda-forge/osx-64      357kB
  + r-htmlwidgets                             1.6.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-httpuv                                 1.6.11  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-httr                                    1.4.7  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-httr2                                   0.2.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-ids                                     1.0.1  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-ini                                     0.3.1  r42hc72bb7e_1005    conda-forge/noarch     Cached
  + r-isoband                                 0.2.7  r42hac7d2d5_2       conda-forge/osx-64     Cached
  + r-jquerylib                               0.1.4  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-jsonlite                                1.8.7  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-knitr                                    1.44  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-labeling                                0.4.3  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-lambda.r                                1.2.4  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-later                                   1.3.1  r42h670e93c_1       conda-forge/osx-64     Cached
  + r-lattice                                0.21_9  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-lifecycle                               1.0.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-lubridate                               1.9.3  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-magrittr                                2.0.3  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-mass                                   7.3_60  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-matrix                                1.6_1.1  r42hc46c21c_0       conda-forge/osx-64     Cached
  + r-matrixstats                             1.0.0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-memoise                                 2.0.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-mgcv                                    1.9_0  r42h9c380c6_0       conda-forge/osx-64     Cached
  + r-mime                                     0.12  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-miniui                                0.1.1.1  r42hc72bb7e_1004    conda-forge/noarch     Cached
  + r-modelr                                 0.1.11  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-munsell                                 0.5.0  r42hc72bb7e_1006    conda-forge/noarch     Cached
  + r-nlme                                  3.1_163  r42hfe07776_0       conda-forge/osx-64     Cached
  + r-openssl                                 2.1.1  r42hc61a7e2_0       conda-forge/osx-64     Cached
  + r-pillar                                  1.9.0  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-pkgbuild                                1.4.2  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-pkgconfig                               2.0.3  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-pkgdown                                 2.0.7  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-pkgfilecache                            0.1.4  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-pkgload                                 1.3.3  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-praise                                  1.0.0  r42hc72bb7e_1007    conda-forge/noarch     Cached
  + r-prettyunits                             1.2.0  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-processx                                3.8.2  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-profvis                                 0.3.8  r42h6dc245f_3       conda-forge/osx-64     Cached
  + r-progress                                1.2.2  r42hc72bb7e_4       conda-forge/noarch     Cached
  + r-promises                                1.2.1  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-ps                                      1.7.5  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-purrr                                   1.0.2  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-r.methodss3                             1.8.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-r6                                      2.5.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-ragg                                    1.2.6  r42h1914a8a_0       conda-forge/osx-64      397kB
  + r-rappdirs                                0.3.3  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-rcmdcheck                               1.4.0  r42h785f33e_2       conda-forge/noarch     Cached
  + r-rcolorbrewer                            1.1_3  r42h785f33e_2       conda-forge/noarch     Cached
  + r-rcpp                                   1.0.11  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-rcurl                               1.98_1.12  r42h0100ac3_3       conda-forge/osx-64     Cached
  + r-readr                                   2.1.4  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-readxl                                  1.4.3  r42h88814b1_0       conda-forge/osx-64     Cached
  + r-rematch                                 2.0.0  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-rematch2                                2.1.2  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-remotes                               2.4.2.1  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-reprex                                  2.0.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-restfulr                               0.0.15  r42hfa19939_2       bioconda/osx-64        Cached
  + r-rhpcblasctl                           0.23_42  r42hc72ff8c_1       conda-forge/osx-64     Cached
  + r-rjson                                  0.2.21  r42hac7d2d5_3       conda-forge/osx-64     Cached
  + r-rlang                                   1.1.1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-rmarkdown                                2.25  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-roxygen2                                7.2.3  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-rprojroot                               2.0.3  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-rstudioapi                             0.15.0  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-rversions                               2.1.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-rvest                                   1.0.3  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-sass                                    0.4.7  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-scales                                  1.2.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-selectr                                 0.4_2  r42hc72bb7e_3       conda-forge/noarch     Cached
  + r-sessioninfo                             1.2.2  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-shape                                   1.4.6  r42ha770c72_2       conda-forge/noarch      785kB
  + r-shiny                                 1.7.5.1  r42h785f33e_0       conda-forge/noarch        3MB
  + r-snow                                    0.4_4  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-sourcetools                           0.1.7_1  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-strawr                                 0.0.91  r42h519547d_1       conda-forge/osx-64     Cached
  + r-stringi                                1.7.12  r42h480af0a_3       conda-forge/osx-64     Cached
  + r-stringr                                 1.5.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-sys                                     3.4.2  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-systemfonts                             1.0.5  r42hac8360d_0       conda-forge/osx-64      219kB
  + r-testthat                                3.2.0  r42h64b2c41_0       conda-forge/osx-64        2MB
  + r-textshaping                             0.3.7  r42hfe21e11_0       conda-forge/osx-64      101kB
  + r-tibble                                  3.2.1  r42h6dc245f_2       conda-forge/osx-64     Cached
  + r-tidyr                                   1.3.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-tidyselect                              1.2.0  r42hbe3e9c8_1       conda-forge/osx-64     Cached
  + r-tidyverse                               2.0.0  r42h785f33e_1       conda-forge/noarch     Cached
  + r-timechange                              0.2.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-tinytex                                  0.48  r42hc72bb7e_0       conda-forge/noarch      144kB
  + r-tzdb                                    0.4.0  r42hac7d2d5_1       conda-forge/osx-64     Cached
  + r-urlchecker                              1.0.1  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-usethis                                 2.2.2  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-utf8                                    1.2.3  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-uuid                                    1.1_1  r42h6dc245f_0       conda-forge/osx-64     Cached
  + r-vctrs                                   0.6.4  r42h64b2c41_0       conda-forge/osx-64        1MB
  + r-viridislite                             0.4.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-vroom                                   1.6.4  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-waldo                                   0.5.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-whisker                                 0.4.1  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-withr                                   2.5.1  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-xfun                                     0.40  r42hac7d2d5_0       conda-forge/osx-64     Cached
  + r-xml                                 3.99_0.14  r42hb8526f4_2       conda-forge/osx-64     Cached
  + r-xml2                                    1.3.5  r42h2e0d1c5_0       conda-forge/osx-64     Cached
  + r-xopen                                   1.0.0  r42hc72bb7e_1005    conda-forge/noarch     Cached
  + r-xtable                                  1.8_4  r42hc72bb7e_5       conda-forge/noarch     Cached
  + r-yaml                                    2.3.7  r42h6dc245f_1       conda-forge/osx-64     Cached
  + r-zip                                     2.3.0  r42h6dc245f_1       conda-forge/osx-64     Cached
  + readline                                    8.2  h9e318b2_1          conda-forge/osx-64     Cached
  + rename                                    1.601  hdfd78af_1          bioconda/noarch        Cached
  + setuptools                               68.2.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sigtool                                   0.1.3  h88f4db0_0          conda-forge/osx-64     Cached
  + tapi                                  1100.0.11  h9ce4665_0          conda-forge/osx-64     Cached
  + tk                                       8.6.13  hef22860_0          conda-forge/osx-64     Cached
  + tktable                                    2.10  ha166976_5          conda-forge/osx-64     Cached
  + toml                                     0.10.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tomlkit                                  0.12.1  pyha770c72_0        conda-forge/noarch     Cached
  + tzdata                                    2023c  h71feb2d_0          conda-forge/noarch     Cached
  + wheel                                    0.41.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xmltodict                                0.13.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xz                                        5.4.2  h6c40b1e_0          pkgs/main/osx-64       Cached
  + yaml                                      0.2.5  h0d85af4_2          conda-forge/osx-64     Cached
  + yq                                        3.2.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + zlib                                     1.2.13  h8a1eda9_5          conda-forge/osx-64     Cached
  + zstd                                      1.5.5  h829000d_0          conda-forge/osx-64     Cached

  Summary:

  Install: 297 packages

  Total download: 34MB

────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
llvm-openmp                                        299.8kB @   3.3MB/s  0.1s
libblas                                             14.8kB @ 128.4kB/s  0.1s
c-ares                                             103.1kB @ 800.3kB/s  0.1s
oniguruma                                          224.4kB @   1.7MB/s  0.1s
compiler-rt                                         93.3kB @ 520.2kB/s  0.1s
libsqlite                                          885.2kB @   4.8MB/s  0.2s
r-shape                                            784.5kB @   4.1MB/s  0.1s
clangxx_osx-64                                      19.9kB @  96.9kB/s  0.1s
compiler-rt_osx-64                                  10.0MB @  35.6MB/s  0.2s
libnghttp2                                         684.2kB @   2.0MB/s  0.1s
curl                                               153.5kB @ 423.3kB/s  0.1s
r-ggplot2                                            4.1MB @  11.4MB/s  0.2s
r-testthat                                           1.7MB @   4.0MB/s  0.0s
r-textshaping                                      101.0kB @ 230.2kB/s  0.3s
r-globaloptions                                    437.2kB @ 972.6kB/s  0.1s
pip                                                  1.4MB @   3.0MB/s  0.1s
r-circlize                                           3.3MB @   7.1MB/s  0.3s
liblapack                                           14.7kB @  29.4kB/s  0.0s
r-fansi                                            309.8kB @ 595.9kB/s  0.1s
libcurl                                            366.0kB @ 687.5kB/s  0.1s
r-tinytex                                          143.7kB @ 251.7kB/s  0.1s
r-systemfonts                                      218.8kB @ 371.0kB/s  0.1s
r-htmltools                                        357.1kB @ 601.7kB/s  0.1s
ld64_osx-64                                          1.1MB @   1.8MB/s  0.1s
cctools_osx-64                                       1.1MB @   1.8MB/s  0.0s
clang_osx-64                                        21.1kB @  32.2kB/s  0.1s
r-shiny                                              3.5MB @   5.3MB/s  0.1s
r-vctrs                                              1.2MB @   1.7MB/s  0.1s
r-ragg                                             396.9kB @ 509.6kB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: \
SafetyError: The package for r-base located at /Users/kalavatt/mambaforge/pkgs/r-base-4.2.3-h109b13c_9
appears to be corrupted. The path 'lib/R/doc/html/packages.html'
has an incorrect size.
  reported size: 3423 bytes
  actual size: 45777 bytes


done
Executing transaction: done

To activate this environment, use

     $ mamba activate circlize_env

To deactivate an active environment, use

     $ mamba deactivate
```
</details>
<br />
