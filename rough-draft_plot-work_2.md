
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

```bash
#!/bin/bash

env_name="genova_env"
install_env=TRUE
if [[ "${install_env}" == TRUE ]]; then
    mamba create \
        -n ${env_name} \
        -c conda-forge \
            parallel \
            r-devtools \
            r-tidyverse
    
    mamba activate ${env_name}
    mamba install -c bioconda rename

    alias R-genova="(
        mamba activate ${env_name}
        open -na /Applications/RStudio.app
    )"

    R-genova
    #  Per github.com/robinweide/GENOVA#installation, run the following in an R
    #+ terminal: remotes::install_github("robinweide/GENOVA")

    check_installation=TRUE
    [[ ${check_installation} == TRUE ]] &&
        {
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
❯ env_name="genova_env"
❯ mamba create \
>     -n ${env_name} \
>     -c conda-forge \
>         parallel \
>         r-devtools \
>         r-tidyverse

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


Looking for: ['parallel', 'r-devtools', 'r-tidyverse']

conda-forge/osx-arm64                                       Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-arm64                                          Using cache
bioconda/noarch                                             Using cache
pkgs/main/osx-arm64                                           No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/osx-arm64                                              No change
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/genova_env

  Updating specs:

   - parallel
   - r-devtools
   - r-tidyverse


  Package                             Version  Build                 Channel                     Size
───────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                            1.0.1  anacondar_1           conda-forge/noarch        Cached
  + bwidget                            1.9.14  hce30654_1            conda-forge/osx-arm64      122kB
  + bzip2                               1.0.8  h3422bc3_4            conda-forge/osx-arm64     Cached
  + c-ares                             1.19.1  hb547adb_0            conda-forge/osx-arm64      102kB
  + ca-certificates                2023.08.22  hca03da5_0            pkgs/main/osx-arm64        127kB
  + cairo                              1.16.0  hc5b65c1_1017         conda-forge/osx-arm64      998kB
  + cctools_osx-arm64                 973.0.1  h62378fb_14           conda-forge/osx-arm64        1MB
  + clang                              16.0.6  he79909e_1            conda-forge/osx-arm64       21kB
  + clang-16                           16.0.6  default_h07b2d96_1    conda-forge/osx-arm64      691kB
  + clang_osx-arm64                    16.0.6  hc421ffc_1            conda-forge/osx-arm64       21kB
  + clangxx                            16.0.6  default_h298e243_1    conda-forge/osx-arm64       21kB
  + clangxx_osx-arm64                  16.0.6  hcd7bac0_1            conda-forge/osx-arm64       20kB
  + compiler-rt                        16.0.6  hf8d1dfb_0            conda-forge/osx-arm64       94kB
  + compiler-rt_osx-arm64              16.0.6  hf8d1dfb_0            conda-forge/noarch          10MB
  + curl                                8.3.0  hc52a3a8_0            conda-forge/osx-arm64      151kB
  + expat                               2.5.0  hb7217d7_1            conda-forge/osx-arm64      118kB
  + font-ttf-dejavu-sans-mono            2.37  hab24e00_0            conda-forge/noarch        Cached
  + font-ttf-inconsolata                3.000  h77eed37_0            conda-forge/noarch        Cached
  + font-ttf-source-code-pro            2.038  h77eed37_0            conda-forge/noarch        Cached
  + font-ttf-ubuntu                      0.83  hab24e00_0            conda-forge/noarch        Cached
  + fontconfig                         2.14.2  h82840c6_0            conda-forge/osx-arm64      238kB
  + fonts-conda-ecosystem                   1  0                     conda-forge/noarch        Cached
  + fonts-conda-forge                       1  0                     conda-forge/noarch        Cached
  + freetype                           2.12.1  hadb7bae_2            conda-forge/osx-arm64      596kB
  + fribidi                            1.0.10  h27ca646_0            conda-forge/osx-arm64       60kB
  + gdbm                                 1.18  hce102ff_2            conda-forge/osx-arm64      129kB
  + gettext                            0.21.1  h0186832_0            conda-forge/osx-arm64        4MB
  + gfortran_impl_osx-arm64            12.3.0  hbbb9e1e_1            conda-forge/osx-arm64       17MB
  + gfortran_osx-arm64                 12.3.0  h57527a5_1            conda-forge/osx-arm64       35kB
  + gmp                                 6.2.1  h9f76cd9_0            conda-forge/osx-arm64      571kB
  + graphite2                          1.3.14  hc377ac9_1            pkgs/main/osx-arm64         77kB
  + harfbuzz                            8.2.1  hf1a6348_0            conda-forge/osx-arm64        1MB
  + icu                                  73.2  hc8870d7_0            conda-forge/osx-arm64       12MB
  + isl                                  0.25  h9a09cb3_0            conda-forge/osx-arm64      859kB
  + krb5                               1.21.2  h92f50d5_0            conda-forge/osx-arm64        1MB
  + ld64_osx-arm64                        609  ha4bd21c_14           conda-forge/osx-arm64        1MB
  + lerc                                4.0.0  h9a09cb3_0            conda-forge/osx-arm64      216kB
  + libblas                             3.9.0  18_osxarm64_openblas  conda-forge/osx-arm64       15kB
  + libclang-cpp16                     16.0.6  default_h07b2d96_1    conda-forge/osx-arm64       12MB
  + libcurl                             8.3.0  hc52a3a8_0            conda-forge/osx-arm64      360kB
  + libcxx                             16.0.6  h4653b0c_0            conda-forge/osx-arm64        1MB
  + libdeflate                           1.19  hb547adb_0            conda-forge/osx-arm64       53kB
  + libedit                      3.1.20221030  h80987f9_0            pkgs/main/osx-arm64        158kB
  + libev                                4.33  h642e427_1            conda-forge/osx-arm64     Cached
  + libexpat                            2.5.0  hb7217d7_1            conda-forge/osx-arm64       63kB
  + libffi                              3.4.4  hca03da5_0            pkgs/main/osx-arm64        123kB
  + libgfortran                         5.0.0  13_2_0_hd922786_1     conda-forge/osx-arm64      110kB
  + libgfortran-devel_osx-arm64        12.3.0  hc62be1c_1            conda-forge/noarch         402kB
  + libgfortran5                       13.2.0  hf226fd6_1            conda-forge/osx-arm64      996kB
  + libgit2                             1.7.1  h2940a35_0            conda-forge/osx-arm64      755kB
  + libglib                            2.78.0  h24e9cb9_0            conda-forge/osx-arm64        3MB
  + libiconv                             1.17  he4db4b2_0            conda-forge/osx-arm64     Cached
  + libjpeg-turbo                       3.0.0  hb547adb_1            conda-forge/osx-arm64      548kB
  + liblapack                           3.9.0  18_osxarm64_openblas  conda-forge/osx-arm64       15kB
  + libllvm16                          16.0.6  he79909e_2            conda-forge/osx-arm64       23MB
  + libnghttp2                         1.52.0  hae82a92_0            conda-forge/osx-arm64     Cached
  + libopenblas                        0.3.24  openmp_hd76b1f2_0     conda-forge/osx-arm64        3MB
  + libpng                             1.6.39  h76d750c_0            conda-forge/osx-arm64      259kB
  + libssh2                            1.11.0  h7a5bd25_0            conda-forge/osx-arm64      256kB
  + libtiff                             4.6.0  ha8a6c65_2            conda-forge/osx-arm64      246kB
  + libwebp-base                        1.3.2  hb547adb_0            conda-forge/osx-arm64      274kB
  + libxml2                            2.11.5  h25269f3_1            conda-forge/osx-arm64      615kB
  + libzlib                            1.2.13  h53f4e23_5            conda-forge/osx-arm64       48kB
  + llvm-openmp                        16.0.6  h1c12783_0            conda-forge/osx-arm64      269kB
  + llvm-tools                         16.0.6  he79909e_2            conda-forge/osx-arm64       21MB
  + make                                  4.3  he57ea6c_1            conda-forge/osx-arm64      253kB
  + mpc                                 1.3.1  h91ba8db_0            conda-forge/osx-arm64      104kB
  + mpfr                                4.2.0  he09a6ba_0            conda-forge/osx-arm64      344kB
  + ncurses                               6.4  h7ea286d_0            conda-forge/osx-arm64      799kB
  + openssl                             3.1.3  h53f4e23_0            conda-forge/osx-arm64        2MB
  + pandoc                              3.1.3  hce30654_0            conda-forge/osx-arm64       26MB
  + pango                             1.50.14  hcf40dda_2            conda-forge/osx-arm64      426kB
  + parallel                         20230922  hce30654_0            conda-forge/osx-arm64        2MB
  + pcre2                               10.40  hb34f9b4_0            conda-forge/osx-arm64        1MB
  + perl                               5.34.0  h1a28f6b_2            pkgs/main/osx-arm64         15MB
  + pixman                             0.42.2  h13dd4ca_0            conda-forge/osx-arm64      214kB
  + r-askpass                           1.2.0  r43h21dc0da_0         conda-forge/osx-arm64       32kB
  + r-assertthat                        0.2.1  r43hc72bb7e_4         conda-forge/noarch        Cached
  + r-backports                         1.4.1  r43h21dc0da_2         conda-forge/osx-arm64      109kB
  + r-base                              4.3.1  haf7632b_6            conda-forge/osx-arm64       26MB
  + r-base64enc                         0.1_3  r43h21dc0da_1006      conda-forge/osx-arm64       46kB
  + r-bit                               4.0.5  r43h21dc0da_1         conda-forge/osx-arm64        1MB
  + r-bit64                             4.0.5  r43h21dc0da_2         conda-forge/osx-arm64      479kB
  + r-blob                              1.2.4  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-brew                              1.0_8  r43hc72bb7e_2         conda-forge/noarch          68kB
  + r-brio                              1.1.3  r43h21dc0da_2         conda-forge/osx-arm64       41kB
  + r-broom                             1.0.5  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-bslib                             0.5.1  r43hc72bb7e_0         conda-forge/noarch        Cached
  + r-cachem                            1.0.8  r43h21dc0da_1         conda-forge/osx-arm64       75kB
  + r-callr                             3.7.3  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-cellranger                        1.1.0  r43hc72bb7e_1006      conda-forge/noarch        Cached
  + r-cli                               3.6.1  r43he62749d_1         conda-forge/osx-arm64        1MB
  + r-clipr                             0.8.0  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-colorspace                        2.1_0  r43h21dc0da_1         conda-forge/osx-arm64        2MB
  + r-commonmark                        1.9.0  r43h21dc0da_1         conda-forge/osx-arm64      120kB
  + r-conflicted                        1.2.0  r43h785f33e_1         conda-forge/noarch        Cached
  + r-cpp11                             0.4.6  r43hc72bb7e_0         conda-forge/noarch        Cached
  + r-crayon                            1.5.2  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-credentials                       2.0.1  r43hc72bb7e_0         conda-forge/noarch         226kB
  + r-curl                              5.1.0  r43h867807f_0         conda-forge/osx-arm64      452kB
  + r-data.table                       1.14.8  r43h5bdffde_2         conda-forge/osx-arm64        2MB
  + r-dbi                               1.1.3  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-dbplyr                            2.3.4  r43hc72bb7e_0         conda-forge/noarch           1MB
  + r-desc                              1.4.2  r43hc72bb7e_2         conda-forge/noarch         330kB
  + r-devtools                          2.4.5  r43hc72bb7e_2         conda-forge/noarch         425kB
  + r-diffobj                           0.3.5  r43h21dc0da_2         conda-forge/osx-arm64      981kB
  + r-digest                           0.6.33  r43he62749d_0         conda-forge/osx-arm64      191kB
  + r-downlit                           0.4.3  r43hc72bb7e_0         conda-forge/noarch         120kB
  + r-dplyr                             1.1.3  r43he62749d_0         conda-forge/osx-arm64        1MB
  + r-dtplyr                            1.3.1  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-ellipsis                          0.3.2  r43h21dc0da_2         conda-forge/osx-arm64       43kB
  + r-evaluate                           0.22  r43hc72bb7e_0         conda-forge/noarch          90kB
  + r-fansi                             1.0.4  r43h21dc0da_1         conda-forge/osx-arm64      310kB
  + r-farver                            2.1.1  r43he62749d_2         conda-forge/osx-arm64        1MB
  + r-fastmap                           1.1.1  r43he62749d_1         conda-forge/osx-arm64       72kB
  + r-fontawesome                       0.5.2  r43hc72bb7e_0         conda-forge/noarch           1MB
  + r-forcats                           1.0.0  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-fs                                1.6.3  r43he62749d_0         conda-forge/osx-arm64      280kB
  + r-gargle                            1.5.2  r43h785f33e_0         conda-forge/noarch        Cached
  + r-generics                          0.1.3  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-gert                              2.0.0  r43h8d6c5f1_0         conda-forge/osx-arm64      258kB
  + r-ggplot2                           3.4.3  r43hc72bb7e_0         conda-forge/noarch        Cached
  + r-gh                                1.4.0  r43hc72bb7e_1         conda-forge/noarch         108kB
  + r-gitcreds                          0.1.2  r43hc72bb7e_2         conda-forge/noarch          95kB
  + r-glue                              1.6.2  r43h21dc0da_2         conda-forge/osx-arm64      152kB
  + r-googledrive                       2.1.1  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-googlesheets4                     1.1.1  r43h785f33e_1         conda-forge/noarch        Cached
  + r-gtable                            0.3.4  r43hc72bb7e_0         conda-forge/noarch         222kB
  + r-haven                             2.5.3  r43he62749d_0         conda-forge/osx-arm64      353kB
  + r-highr                              0.10  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-hms                               1.1.3  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-htmltools                         0.5.6  r43he62749d_0         conda-forge/osx-arm64      359kB
  + r-htmlwidgets                       1.6.2  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-httpuv                           1.6.11  r43he62749d_1         conda-forge/osx-arm64      545kB
  + r-httr                              1.4.7  r43hc72bb7e_0         conda-forge/noarch         468kB
  + r-httr2                             0.2.3  r43hc72bb7e_1         conda-forge/noarch         384kB
  + r-ids                               1.0.1  r43hc72bb7e_3         conda-forge/noarch        Cached
  + r-ini                               0.3.1  r43hc72bb7e_1005      conda-forge/noarch          33kB
  + r-isoband                           0.2.7  r43he62749d_2         conda-forge/osx-arm64        2MB
  + r-jquerylib                         0.1.4  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-jsonlite                          1.8.7  r43h21dc0da_0         conda-forge/osx-arm64      632kB
  + r-knitr                              1.44  r43hc72bb7e_0         conda-forge/noarch           1MB
  + r-labeling                          0.4.3  r43hc72bb7e_0         conda-forge/noarch          69kB
  + r-later                             1.3.1  r43he62749d_1         conda-forge/osx-arm64      119kB
  + r-lattice                          0.21_9  r43h21dc0da_0         conda-forge/osx-arm64        1MB
  + r-lifecycle                         1.0.3  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-lubridate                         1.9.3  r43h21dc0da_0         conda-forge/osx-arm64      984kB
  + r-magrittr                          2.0.3  r43h21dc0da_2         conda-forge/osx-arm64      208kB
  + r-mass                             7.3_60  r43h21dc0da_1         conda-forge/osx-arm64        1MB
  + r-matrix                          1.6_1.1  r43hdce2eb6_0         conda-forge/osx-arm64        4MB
  + r-memoise                           2.0.1  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-mgcv                              1.9_0  r43h8420647_0         conda-forge/osx-arm64        3MB
  + r-mime                               0.12  r43h21dc0da_2         conda-forge/osx-arm64       53kB
  + r-miniui                          0.1.1.1  r43hc72bb7e_1004      conda-forge/noarch          54kB
  + r-modelr                           0.1.11  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-munsell                           0.5.0  r43hc72bb7e_1006      conda-forge/noarch        Cached
  + r-nlme                            3.1_163  r43h81fe24e_0         conda-forge/osx-arm64        2MB
  + r-openssl                           2.1.1  r43h138cb08_0         conda-forge/osx-arm64      684kB
  + r-pillar                            1.9.0  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-pkgbuild                          1.4.2  r43hc72bb7e_0         conda-forge/noarch         205kB
  + r-pkgconfig                         2.0.3  r43hc72bb7e_3         conda-forge/noarch        Cached
  + r-pkgdown                           2.0.7  r43hc72bb7e_1         conda-forge/noarch         722kB
  + r-pkgload                           1.3.3  r43hc72bb7e_0         conda-forge/noarch         196kB
  + r-praise                            1.0.0  r43hc72bb7e_1007      conda-forge/noarch          25kB
  + r-prettyunits                       1.2.0  r43hc72bb7e_0         conda-forge/noarch         163kB
  + r-processx                          3.8.2  r43h21dc0da_0         conda-forge/osx-arm64      314kB
  + r-profvis                           0.3.8  r43h21dc0da_3         conda-forge/osx-arm64      205kB
  + r-progress                          1.2.2  r43hc72bb7e_4         conda-forge/noarch        Cached
  + r-promises                          1.2.1  r43he62749d_0         conda-forge/osx-arm64        2MB
  + r-ps                                1.7.5  r43h21dc0da_1         conda-forge/osx-arm64      308kB
  + r-purrr                             1.0.2  r43h21dc0da_0         conda-forge/osx-arm64      484kB
  + r-r6                                2.5.1  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-ragg                              1.2.5  r43hf038ccb_4         conda-forge/osx-arm64      392kB
  + r-rappdirs                          0.3.3  r43h21dc0da_2         conda-forge/osx-arm64       52kB
  + r-rcmdcheck                         1.4.0  r43h785f33e_2         conda-forge/noarch         177kB
  + r-rcolorbrewer                      1.1_3  r43h785f33e_2         conda-forge/noarch        Cached
  + r-rcpp                             1.0.11  r43he62749d_0         conda-forge/osx-arm64        2MB
  + r-readr                             2.1.4  r43he62749d_1         conda-forge/osx-arm64      853kB
  + r-readxl                            1.4.3  r43h9c2710d_0         conda-forge/osx-arm64      729kB
  + r-rematch                           2.0.0  r43hc72bb7e_0         conda-forge/noarch          25kB
  + r-rematch2                          2.1.2  r43hc72bb7e_3         conda-forge/noarch        Cached
  + r-remotes                         2.4.2.1  r43hc72bb7e_0         conda-forge/noarch         402kB
  + r-reprex                            2.0.2  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-rlang                             1.1.1  r43he62749d_1         conda-forge/osx-arm64        2MB
  + r-rmarkdown                          2.25  r43hc72bb7e_0         conda-forge/noarch           2MB
  + r-roxygen2                          7.2.3  r43he62749d_1         conda-forge/osx-arm64      789kB
  + r-rprojroot                         2.0.3  r43hc72bb7e_0         conda-forge/noarch         105kB
  + r-rstudioapi                       0.15.0  r43hc72bb7e_0         conda-forge/noarch        Cached
  + r-rversions                         2.1.2  r43hc72bb7e_2         conda-forge/noarch          73kB
  + r-rvest                             1.0.3  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-sass                              0.4.7  r43he62749d_0         conda-forge/osx-arm64        2MB
  + r-scales                            1.2.1  r43hc72bb7e_2         conda-forge/noarch        Cached
  + r-selectr                           0.4_2  r43hc72bb7e_3         conda-forge/noarch        Cached
  + r-sessioninfo                       1.2.2  r43hc72bb7e_2         conda-forge/noarch         198kB
  + r-shiny                             1.7.5  r43h785f33e_0         conda-forge/noarch        Cached
  + r-sourcetools                     0.1.7_1  r43he62749d_1         conda-forge/osx-arm64       52kB
  + r-stringi                          1.7.12  r43h31e90fb_3         conda-forge/osx-arm64      845kB
  + r-stringr                           1.5.0  r43h785f33e_1         conda-forge/noarch        Cached
  + r-sys                               3.4.2  r43h21dc0da_1         conda-forge/osx-arm64       49kB
  + r-systemfonts                       1.0.4  r43h4f0b353_2         conda-forge/osx-arm64      229kB
  + r-testthat                         3.1.10  r43he62749d_0         conda-forge/osx-arm64        2MB
  + r-textshaping                       0.3.6  r43h059379e_7         conda-forge/osx-arm64      100kB
  + r-tibble                            3.2.1  r43h21dc0da_2         conda-forge/osx-arm64      611kB
  + r-tidyr                             1.3.0  r43he62749d_1         conda-forge/osx-arm64        1MB
  + r-tidyselect                        1.2.0  r43h011812f_1         conda-forge/osx-arm64      216kB
  + r-tidyverse                         2.0.0  r43h785f33e_1         conda-forge/noarch        Cached
  + r-timechange                        0.2.0  r43he62749d_1         conda-forge/osx-arm64      182kB
  + r-tinytex                            0.47  r43hc72bb7e_0         conda-forge/noarch         143kB
  + r-tzdb                              0.4.0  r43he62749d_1         conda-forge/osx-arm64      538kB
  + r-urlchecker                        1.0.1  r43hc72bb7e_2         conda-forge/noarch          52kB
  + r-usethis                           2.2.2  r43hc72bb7e_0         conda-forge/noarch         855kB
  + r-utf8                              1.2.3  r43h21dc0da_1         conda-forge/osx-arm64      140kB
  + r-uuid                              1.1_1  r43h21dc0da_0         conda-forge/osx-arm64       51kB
  + r-vctrs                             0.6.3  r43he62749d_0         conda-forge/osx-arm64        1MB
  + r-viridislite                       0.4.2  r43hc72bb7e_1         conda-forge/noarch        Cached
  + r-vroom                             1.6.4  r43he62749d_0         conda-forge/osx-arm64      803kB
  + r-waldo                             0.5.1  r43hc72bb7e_1         conda-forge/noarch         112kB
  + r-whisker                           0.4.1  r43hc72bb7e_1         conda-forge/noarch          82kB
  + r-withr                             2.5.1  r43hc72bb7e_0         conda-forge/noarch         240kB
  + r-xfun                               0.40  r43he62749d_0         conda-forge/osx-arm64      424kB
  + r-xml2                              1.3.5  r43h77ef413_0         conda-forge/osx-arm64      177kB
  + r-xopen                             1.0.0  r43hc72bb7e_1005      conda-forge/noarch          30kB
  + r-xtable                            1.8_4  r43hc72bb7e_5         conda-forge/noarch        Cached
  + r-yaml                              2.3.7  r43h21dc0da_1         conda-forge/osx-arm64      105kB
  + r-zip                               2.3.0  r43h21dc0da_1         conda-forge/osx-arm64      124kB
  + readline                              8.2  h92ec313_1            conda-forge/osx-arm64     Cached
  + sigtool                             0.1.3  h44b9a77_0            conda-forge/osx-arm64      210kB
  + tapi                            1100.0.11  he4954df_0            conda-forge/osx-arm64      191kB
  + tk                                 8.6.13  hb31c410_0            conda-forge/osx-arm64        3MB
  + tktable                              2.10  hd996620_5            conda-forge/osx-arm64       80kB
  + xz                                  5.4.2  h80987f9_0            pkgs/main/osx-arm64        378kB
  + zlib                               1.2.13  h53f4e23_5            conda-forge/osx-arm64       80kB
  + zstd                                1.5.5  h4f39d0f_0            conda-forge/osx-arm64      401kB

  Summary:

  Install: 233 packages

  Total download: 263MB

───────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libzlib                                             48.1kB @ 939.5kB/s  0.1s
libcxx                                               1.2MB @  17.5MB/s  0.1s
llvm-openmp                                        268.7kB @   2.6MB/s  0.1s
libwebp-base                                       273.8kB @   2.4MB/s  0.1s
zlib                                                79.6kB @ 547.0kB/s  0.0s
isl                                                859.1kB @   4.7MB/s  0.1s
pixman                                             213.8kB @   1.1MB/s  0.1s
gettext                                              4.0MB @  19.6MB/s  0.1s
tktable                                             79.8kB @ 332.0kB/s  0.0s
pcre2                                                1.2MB @   4.6MB/s  0.1s
mpc                                                103.7kB @ 371.1kB/s  0.0s
gdbm                                               128.8kB @ 440.0kB/s  0.1s
libgfortran-devel_osx-arm64                        401.6kB @   1.3MB/s  0.1s
libffi                                             123.0kB @ 358.1kB/s  0.1s
icu                                                 12.0MB @  34.6MB/s  0.3s
libxml2                                            614.8kB @   1.7MB/s  0.1s
cairo                                              998.1kB @   2.3MB/s  0.1s
sigtool                                            210.3kB @ 455.3kB/s  0.1s
ld64_osx-arm64                                       1.0MB @   2.2MB/s  0.1s
clang-16                                           690.5kB @   1.4MB/s  0.1s
pango                                              426.3kB @ 819.5kB/s  0.1s
perl                                                14.6MB @  25.8MB/s  0.3s
r-sourcetools                                       52.4kB @  92.0kB/s  0.0s
gfortran_osx-arm64                                  35.1kB @  61.2kB/s  0.1s
r-fastmap                                           71.8kB @ 117.6kB/s  0.0s
r-bit                                                1.1MB @   1.7MB/s  0.1s
r-farver                                             1.4MB @   2.0MB/s  0.1s
r-curl                                             452.3kB @ 648.5kB/s  0.0s
pandoc                                              26.3MB @  36.6MB/s  0.7s
r-backports                                        109.4kB @ 149.4kB/s  0.0s
compiler-rt_osx-arm64                               10.0MB @  13.6MB/s  0.3s
r-fs                                               280.0kB @ 375.5kB/s  0.1s
r-jsonlite                                         631.5kB @ 829.2kB/s  0.0s
r-xml2                                             176.8kB @ 222.2kB/s  0.0s
r-fansi                                            309.9kB @ 387.4kB/s  0.1s
r-rlang                                              1.5MB @   1.9MB/s  0.1s
r-ellipsis                                          42.7kB @  51.8kB/s  0.0s
r-matrix                                             3.8MB @   4.6MB/s  0.1s
r-labeling                                          69.0kB @  80.8kB/s  0.0s
r-praise                                            25.3kB @  29.6kB/s  0.0s
r-htmltools                                        358.8kB @ 414.2kB/s  0.1s
r-remotes                                          401.9kB @ 462.0kB/s  0.0s
r-credentials                                      225.8kB @ 254.2kB/s  0.0s
r-desc                                             329.7kB @ 365.5kB/s  0.0s
r-gh                                               107.9kB @ 117.2kB/s  0.0s
r-sessioninfo                                      198.0kB @ 212.2kB/s  0.1s
r-tzdb                                             537.7kB @ 570.3kB/s  0.0s
r-zip                                              124.1kB @ 128.6kB/s  0.4s
r-processx                                         314.0kB @ 321.1kB/s  0.1s
r-httpuv                                           544.7kB @ 552.8kB/s  0.0s
r-tinytex                                          143.5kB @ 144.3kB/s  0.1s
r-miniui                                            53.8kB @  52.3kB/s  0.0s
r-tibble                                           610.5kB @ 588.2kB/s  0.0s
r-usethis                                          854.9kB @ 795.2kB/s  0.1s
r-waldo                                            111.7kB @ 100.6kB/s  0.0s
r-tidyr                                              1.1MB @   1.0MB/s  0.1s
r-ragg                                             392.2kB @ 344.4kB/s  0.2s
libdeflate                                          52.8kB @  46.0kB/s  0.0s
r-vroom                                            803.5kB @ 698.6kB/s  0.1s
fribidi                                             60.3kB @  51.2kB/s  0.0s
libgfortran5                                       995.7kB @ 838.7kB/s  0.0s
lerc                                               215.7kB @ 178.2kB/s  0.0s
r-gert                                             257.6kB @ 212.4kB/s  0.3s
freetype                                           596.4kB @ 490.2kB/s  0.0s
tk                                                   3.2MB @   2.6MB/s  0.1s
libtiff                                            246.3kB @ 198.0kB/s  0.0s
liblapack                                           14.8kB @  11.9kB/s  0.0s
graphite2                                           76.5kB @  61.0kB/s  0.0s
libopenblas                                          2.8MB @   2.2MB/s  0.1s
clang                                               20.8kB @  15.5kB/s  0.0s
libcurl                                            359.9kB @ 265.3kB/s  0.1s
clang_osx-arm64                                     21.0kB @  15.1kB/s  0.0s
r-base64enc                                         45.5kB @  32.6kB/s  0.0s
r-sys                                               48.5kB @  33.9kB/s  0.0s
r-ps                                               308.2kB @ 213.9kB/s  0.0s
r-testthat                                           1.6MB @   1.1MB/s  0.3s
r-uuid                                              50.6kB @  34.4kB/s  0.0s
r-yaml                                             105.2kB @  71.2kB/s  0.0s
r-utf8                                             140.4kB @  94.0kB/s  0.0s
r-commonmark                                       120.3kB @  79.4kB/s  0.0s
r-cli                                                1.2MB @ 807.6kB/s  0.1s
r-gitcreds                                          94.8kB @  57.9kB/s  0.1s
r-mgcv                                               3.3MB @   2.0MB/s  0.1s
r-withr                                            239.5kB @ 141.5kB/s  0.0s
r-rematch                                           25.1kB @  14.6kB/s  0.1s
llvm-tools                                          20.7MB @  12.0MB/s  0.5s
libllvm16                                           23.2MB @  13.5MB/s  0.5s
r-bit64                                            479.2kB @ 277.2kB/s  0.2s
r-fontawesome                                        1.3MB @ 752.4kB/s  0.0s
r-httr2                                            384.2kB @ 219.0kB/s  0.0s
r-textshaping                                      100.3kB @  57.1kB/s  0.0s
r-pkgbuild                                         204.5kB @ 114.3kB/s  0.0s
r-sass                                               2.1MB @   1.2MB/s  0.1s
r-purrr                                            483.9kB @ 269.5kB/s  0.1s
r-pkgload                                          196.0kB @ 109.0kB/s  0.0s
r-systemfonts                                      228.7kB @ 127.1kB/s  0.1s
libexpat                                            63.4kB @  34.8kB/s  0.0s
zstd                                               400.5kB @ 218.2kB/s  0.0s
r-devtools                                         425.0kB @ 231.2kB/s  0.0s
r-dbplyr                                             1.1MB @ 592.3kB/s  0.1s
r-dplyr                                              1.4MB @ 755.1kB/s  0.1s
tapi                                               191.4kB @ 103.1kB/s  0.0s
bwidget                                            122.4kB @  65.6kB/s  0.0s
libblas                                             14.9kB @   8.0kB/s  0.0s
libedit                                            157.8kB @  84.1kB/s  0.0s
krb5                                                 1.2MB @ 627.6kB/s  0.1s
cctools_osx-arm64                                    1.1MB @ 584.7kB/s  0.1s
curl                                               151.4kB @  78.9kB/s  0.1s
libglib                                              2.6MB @   1.3MB/s  0.1s
r-magrittr                                         208.4kB @ 106.6kB/s  0.0s
r-xfun                                             423.7kB @ 216.1kB/s  0.0s
r-ini                                               33.0kB @  16.6kB/s  0.0s
r-later                                            118.5kB @  59.2kB/s  0.0s
r-mass                                               1.1MB @ 568.1kB/s  0.1s
r-rprojroot                                        104.6kB @  51.7kB/s  0.0s
r-rversions                                         72.7kB @  35.9kB/s  0.0s
r-knitr                                              1.3MB @ 637.8kB/s  0.0s
r-lubridate                                        984.3kB @ 477.4kB/s  0.0s
r-promises                                           1.6MB @ 759.1kB/s  0.1s
r-downlit                                          119.9kB @  57.5kB/s  0.0s
r-brio                                              40.6kB @  19.4kB/s  0.2s
r-pkgdown                                          722.4kB @ 341.5kB/s  0.0s
libjpeg-turbo                                      547.5kB @ 258.1kB/s  0.0s
c-ares                                             102.0kB @  48.0kB/s  0.0s
expat                                              117.9kB @  54.9kB/s  0.0s
fontconfig                                         237.7kB @ 110.4kB/s  0.0s
libssh2                                            255.6kB @ 116.6kB/s  0.0s
harfbuzz                                             1.2MB @ 565.7kB/s  0.1s
clangxx_osx-arm64                                   19.8kB @   8.9kB/s  0.0s
r-digest                                           191.1kB @  85.5kB/s  0.0s
r-rappdirs                                          52.2kB @  22.6kB/s  0.1s
r-stringi                                          845.4kB @ 363.0kB/s  0.1s
gfortran_impl_osx-arm64                             17.5MB @   7.5MB/s  0.2s
r-whisker                                           81.5kB @  34.6kB/s  0.0s
r-urlchecker                                        51.6kB @  21.8kB/s  0.0s
r-roxygen2                                         789.1kB @ 332.3kB/s  0.3s
r-gtable                                           222.3kB @  93.3kB/s  0.0s
r-askpass                                           31.5kB @  13.2kB/s  0.1s
r-readr                                            852.9kB @ 351.8kB/s  0.0s
make                                               253.2kB @ 104.3kB/s  0.0s
r-rmarkdown                                          2.1MB @ 850.5kB/s  0.1s
gmp                                                570.6kB @ 232.2kB/s  0.0s
xz                                                 377.9kB @ 153.0kB/s  0.0s
compiler-rt                                         93.6kB @  37.7kB/s  0.0s
r-vctrs                                              1.2MB @ 488.0kB/s  0.1s
r-glue                                             151.8kB @  60.5kB/s  0.0s
r-prettyunits                                      162.6kB @  64.2kB/s  0.0s
r-openssl                                          683.8kB @ 268.5kB/s  0.0s
r-rcpp                                               2.0MB @ 798.7kB/s  0.1s
r-rcmdcheck                                        176.7kB @  68.5kB/s  0.0s
libgfortran                                        110.1kB @  42.3kB/s  0.0s
openssl                                              2.2MB @ 841.4kB/s  0.0s
r-haven                                            352.7kB @ 132.5kB/s  0.1s
clangxx                                             20.9kB @   7.8kB/s  0.0s
r-nlme                                               2.3MB @ 843.3kB/s  0.0s
r-data.table                                         1.8MB @ 668.2kB/s  0.1s
r-colorspace                                         2.5MB @ 913.7kB/s  0.9s
r-evaluate                                          89.7kB @  32.7kB/s  0.0s
mpfr                                               343.9kB @ 124.1kB/s  0.0s
r-tidyselect                                       215.6kB @  77.3kB/s  0.1s
r-diffobj                                          980.7kB @ 350.8kB/s  0.3s
r-readxl                                           729.2kB @ 258.4kB/s  0.1s
r-brew                                              68.2kB @  24.0kB/s  0.0s
r-xopen                                             30.3kB @  10.6kB/s  0.0s
libpng                                             259.4kB @  90.4kB/s  0.0s
parallel                                             1.9MB @ 642.9kB/s  0.5s
r-isoband                                            1.6MB @ 553.8kB/s  0.1s
r-cachem                                            74.9kB @  25.4kB/s  0.1s
r-httr                                             468.3kB @ 157.0kB/s  0.0s
ca-certificates                                    126.6kB @  41.8kB/s  0.0s
ncurses                                            799.2kB @ 254.9kB/s  0.1s
libgit2                                            755.0kB @ 239.3kB/s  0.4s
r-mime                                              53.0kB @  16.6kB/s  0.0s
r-profvis                                          205.1kB @  64.2kB/s  0.3s
r-lattice                                            1.3MB @ 418.3kB/s  0.1s
libclang-cpp16                                      11.8MB @   3.7MB/s  0.3s
r-timechange                                       181.7kB @  56.4kB/s  0.0s
r-base                                              26.2MB @   8.0MB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate genova_env

To deactivate an active environment, use

     $ mamba deactivate


❯ mamba activate ${env_name}


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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['rename']

bioconda/osx-arm64                                          Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-arm64                                       Using cache
conda-forge/noarch                                          Using cache
pkgs/main/osx-arm64                                         Using cache
pkgs/main/noarch                                            Using cache
pkgs/r/osx-arm64                                            Using cache
pkgs/r/noarch                                               Using cache
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/genova_env

  Updating specs:

   - rename
   - ca-certificates
   - openssl


  Package               Version  Build       Channel               Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + rename                1.601  hdfd78af_1  bioconda/noarch     Cached

  Reinstall:
─────────────────────────────────────────────────────────────────────────

  o ca-certificates  2023.08.22  hca03da5_0  pkgs/main
  o openssl               3.1.3  h53f4e23_0  conda-forge

  Summary:

  Install: 1 packages
  Reinstall: 2 packages

  Total download: 0 B

─────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ pwd
/Users/kalavatt/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process


❯ [[ $(pwd) != "${HOME}/projects-etc/2023_rDNA/src/" ]] &&
cmdand>     cd "${HOME}/projects-etc/2023_rDNA/src/" ||
cmdand cmdor>     true


❯ alias R-genova="(
dquote>     mamba activate ${env_name}
dquote>     open -na /Applications/RStudio.app
dquote> )"


❯ R-genova


> remotes::install_github("robinweide/GENOVA")
Downloading GitHub repo robinweide/GENOVA@HEAD
── R CMD build ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
✔  checking for file ‘/private/var/folders/58/xy2vwvwj6c51whrb5ns2754m0000gq/T/RtmpBLSssf/remotes124fc1ea8d973/robinweide-GENOVA-7622971/DESCRIPTION’ (467ms)
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


❯ [[ ${check_installation} == TRUE ]] &&
cmdand>     {
cmdand cursh>         ., ${HOME}/mambaforge/envs/genova_env/lib/R/library/GENOVA
cmdand cursh>     }
total 136
drwxr-xr-x@  13 kalavatt  staff   416B Oct  3 05:36 ./
drwxr-xr-x  167 kalavatt  staff   5.2K Oct  3 05:37 ../
-rw-r--r--@   1 kalavatt  staff   961B Oct  3 05:36 CITATION
-rw-r--r--@   1 kalavatt  staff   1.4K Oct  3 05:36 DESCRIPTION
-rw-r--r--@   1 kalavatt  staff   3.5K Oct  3 05:36 INDEX
-rw-r--r--@   1 kalavatt  staff    34K Oct  3 05:36 LICENSE
drwxr-xr-x@   9 kalavatt  staff   288B Oct  3 05:36 Meta/
-rw-r--r--@   1 kalavatt  staff   5.3K Oct  3 05:36 NAMESPACE
-rw-r--r--@   1 kalavatt  staff    11K Oct  3 05:36 NEWS.md
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 05:36 R/
drwxr-xr-x@   5 kalavatt  staff   160B Oct  3 05:36 data/
drwxr-xr-x@   8 kalavatt  staff   256B Oct  3 05:36 help/
drwxr-xr-x@   4 kalavatt  staff   128B Oct  3 05:36 html/
```
</details>
<br />

