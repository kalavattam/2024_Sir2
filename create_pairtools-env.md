
`#create_pairtools-env.md`
<br />
<br />

<a id="install-packages-necessary-for-micro-c-processing-analysis"></a>
## Install packages necessary for Micro-C processing, analysis
<a id="remote-and-local-work-installations"></a>
### Remote installation
<a id="install-mamba-packages"></a>
#### Install mamba packages
<a id="code"></a>
##### Code
<details>
<summary><i>Code: Install mamba packages</i></summary>

```bash
#!/bin/bash

install_env_server=false
if ${install_env_server}; then
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

install_env_ARM=true
activate_env=true
install_clodius=true
if ${install_env_ARM}; then
    env_name="pairtools_env"
    
    CONDA_SUBDIR=osx-64 \
    mamba create \
        -n "${env_name}" \
        -c conda-forge \
        -c bioconda \
            parallel \
            pbzip2 \
            pigz \
            r-argparse \
            r-ggsci \
            r-plotly \
            r-tidyverse \
            bedops \
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

    if ${activate_env}; then mamba activate "${env_name}"; fi
    if ${install_clodius}; then pip install clodius; fi
fi
```
</details>
<br />

<a id="printed"></a>
##### Printed
###### Install mamba packages (ARM, KrisMac)
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

###### Install mamba packages (ARM, WorkMac)
<details>
<summary><i>Printed: Install mamba packages (ARM, WorkMac)</i></summary>

```txt
❯ env_name="pairtools_env"❯
❯     CONDA_SUBDIR=osx-64 \
>     mamba create \
>         -n "${env_name}" \
>         -c conda-forge \
>         -c bioconda \
>             parallel \
>             pbzip2 \
>             pigz \
>             r-argparse \
>             r-ggsci \
>             r-plotly \
>             r-tidyverse \
>             bedops \
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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel', 'pbzip2', 'pigz', 'r-argparse', 'r-ggsci', 'r-plotly', 'r-tidyverse', 'bedops', 'bioframe', 'cooler', 'coolpuppy', 'cooltools', 'pairtools', 'rename', 'bioconductor-genomicinteractions', 'bioconductor-genomicranges', 'bioconductor-gviz', 'bioconductor-interactionset']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
r/osx-64                                                    Using cache
r/noarch                                                    Using cache
pkgs/main/osx-64                                            Using cache
pkgs/main/noarch                                            Using cache
pkgs/r/osx-64                                               Using cache
pkgs/r/noarch                                               Using cache
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/pairtools_env

  Updating specs:

   - parallel
   - pbzip2
   - pigz
   - r-argparse
   - r-ggsci
   - r-plotly
   - r-tidyverse
   - bedops
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
  + aom                                       3.6.1  he965462_0              conda-forge/osx-64        3MB
  + argcomplete                               3.1.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + asciitree                                 0.3.3  py_2                    conda-forge/noarch        6kB
  + aws-c-auth                                0.7.4  h671831e_6              conda-forge/osx-64       89kB
  + aws-c-cal                                 0.6.7  h50c96e6_0              conda-forge/osx-64       45kB
  + aws-c-common                              0.9.4  h10d778d_0              conda-forge/osx-64      205kB
  + aws-c-compression                        0.2.17  h6cdfeff_4              conda-forge/osx-64       18kB
  + aws-c-event-stream                        0.3.2  h74ccef4_4              conda-forge/osx-64       47kB
  + aws-c-http                               0.7.13  h7fc0988_7              conda-forge/osx-64      163kB
  + aws-c-io                                0.13.35  h3dcb58e_4              conda-forge/osx-64      137kB
  + aws-c-mqtt                                0.9.8  hb951632_0              conda-forge/osx-64      138kB
  + aws-c-s3                                 0.3.19  hc680d6c_1              conda-forge/osx-64       75kB
  + aws-c-sdkutils                           0.1.12  h6cdfeff_3              conda-forge/osx-64       47kB
  + aws-checksums                            0.1.17  h6cdfeff_3              conda-forge/osx-64       49kB
  + aws-crt-cpp                              0.24.3  hd32531e_7              conda-forge/osx-64      275kB
  + aws-sdk-cpp                            1.11.182  h5657ac1_1              conda-forge/osx-64        3MB
  + bedops                                   2.4.41  h85dcccf_1              bioconda/osx-64        Cached
  + bioconductor-annotationdbi               1.62.2  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-annotationfilter            1.24.0  r43hdfd78af_0           bioconda/noarch         561kB
  + bioconductor-biobase                     2.60.0  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-biocfilecache                2.8.0  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-biocgenerics                0.46.0  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-biocio                      1.10.0  r43hdfd78af_0           bioconda/noarch         469kB
  + bioconductor-biocparallel                1.34.2  r43hc0ef7c4_0           bioconda/osx-64        Cached
  + bioconductor-biomart                     2.56.1  r43hdfd78af_0           bioconda/noarch         927kB
  + bioconductor-biostrings                  2.68.1  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-biovizbase                  1.48.0  r43h4c50009_0           bioconda/osx-64           3MB
  + bioconductor-bsgenome                    1.68.0  r43hdfd78af_0           bioconda/noarch           7MB
  + bioconductor-data-packages             20230718  hdfd78af_1              bioconda/noarch        Cached
  + bioconductor-delayedarray                0.26.6  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-ensembldb                   2.24.0  r43hdfd78af_0           bioconda/noarch           4MB
  + bioconductor-genomeinfodb                1.36.1  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-genomeinfodbdata            1.2.10  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-genomicalignments           1.36.0  r43h4c50009_0           bioconda/osx-64           2MB
  + bioconductor-genomicfeatures             1.52.1  r43hdfd78af_0           bioconda/noarch           2MB
  + bioconductor-genomicinteractions         1.34.0  r43hdfd78af_0           bioconda/noarch           4MB
  + bioconductor-genomicranges               1.52.0  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-gviz                        1.44.0  r43hdfd78af_0           bioconda/noarch           7MB
  + bioconductor-interactionset              1.28.1  r43hc0ef7c4_0           bioconda/osx-64           2MB
  + bioconductor-iranges                     2.34.1  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-keggrest                    1.40.0  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-matrixgenerics              1.12.2  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-protgenerics                1.32.0  r43hdfd78af_0           bioconda/noarch         249kB
  + bioconductor-rhtslib                      2.2.0  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-rsamtools                   2.16.0  r43hc0ef7c4_0           bioconda/osx-64        Cached
  + bioconductor-rtracklayer                 1.60.0  r43h4c50009_0           bioconda/osx-64           6MB
  + bioconductor-s4arrays                     1.0.4  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-s4vectors                   0.38.1  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-summarizedexperiment        1.30.2  r43hdfd78af_0           bioconda/noarch        Cached
  + bioconductor-variantannotation           1.46.0  r43h4c50009_0           bioconda/osx-64           4MB
  + bioconductor-xvector                     0.40.0  r43h4c50009_0           bioconda/osx-64        Cached
  + bioconductor-zlibbioc                    1.46.0  r43h4c50009_0           bioconda/osx-64        Cached
  + bioframe                                  0.5.0  pyhdfd78af_0            bioconda/noarch         128kB
  + biopython                                  1.81  py39ha09f3b3_1          conda-forge/osx-64        3MB
  + blosc                                    1.21.5  heccf04b_0              conda-forge/osx-64       50kB
  + bokeh                                     3.3.0  pyhd8ed1ab_0            conda-forge/noarch        5MB
  + brotli                                    1.1.0  h0dc2134_1              conda-forge/osx-64       20kB
  + brotli-bin                                1.1.0  h0dc2134_1              conda-forge/osx-64       17kB
  + brotli-python                             1.1.0  py39h840bb9f_1          conda-forge/osx-64      367kB
  + brunsli                                     0.1  h046ec9c_0              conda-forge/osx-64      183kB
  + bwidget                                  1.9.14  h694c41f_1              conda-forge/osx-64     Cached
  + bzip2                                     1.0.8  h0d85af4_4              conda-forge/osx-64     Cached
  + c-ares                                   1.20.1  h10d778d_1              conda-forge/osx-64      104kB
  + c-blosc2                                 2.10.5  h354e526_0              conda-forge/osx-64      273kB
  + ca-certificates                      2023.08.22  hecd8cb5_0              pkgs/main/osx-64       Cached
  + cached-property                           1.5.2  hd8ed1ab_1              conda-forge/noarch        4kB
  + cached_property                           1.5.2  pyha770c72_1            conda-forge/noarch       11kB
  + cairo                                    1.18.0  h99e66fa_0              conda-forge/osx-64     Cached
  + cctools_osx-64                          973.0.1  ha1c5b94_15             conda-forge/osx-64     Cached
  + certifi                               2023.7.22  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + charls                                    2.4.2  he965462_0              conda-forge/osx-64      138kB
  + charset-normalizer                        3.3.0  pyhd8ed1ab_0            conda-forge/noarch       46kB
  + clang                                    16.0.6  hc177806_1              conda-forge/osx-64     Cached
  + clang-16                                 16.0.6  default_h762fdd7_1      conda-forge/osx-64     Cached
  + clang_impl_osx-64                        16.0.6  h8787910_5              conda-forge/osx-64       18kB
  + clang_osx-64                             16.0.6  hb91bd55_5              conda-forge/osx-64       21kB
  + clangxx                                  16.0.6  default_h762fdd7_1      conda-forge/osx-64     Cached
  + clangxx_impl_osx-64                      16.0.6  h1b7723c_5              conda-forge/osx-64       18kB
  + clangxx_osx-64                           16.0.6  hb91bd55_5              conda-forge/osx-64       19kB
  + click                                     8.1.7  unix_pyh707e725_0       conda-forge/noarch       84kB
  + cloudpickle                               3.0.0  pyhd8ed1ab_0            conda-forge/noarch       25kB
  + compiler-rt                              16.0.6  he1888fc_1              conda-forge/osx-64     Cached
  + compiler-rt_osx-64                       16.0.6  he1888fc_1              conda-forge/noarch     Cached
  + contourpy                                 1.1.1  py39h8ee36c8_1          conda-forge/osx-64      218kB
  + cooler                                    0.9.3  pyhdfd78af_0            bioconda/noarch          85kB
  + coolpuppy                                 1.1.0  pyh086e186_0            bioconda/noarch          45kB
  + cooltools                                 0.5.4  py39hc889f67_2          bioconda/osx-64         300kB
  + coreutils                                   9.4  h0dc2134_0              conda-forge/osx-64        1MB
  + curl                                      8.4.0  h726d00d_0              conda-forge/osx-64     Cached
  + cycler                                   0.12.1  pyhd8ed1ab_0            conda-forge/noarch       13kB
  + cytoolz                                  0.12.2  py39hdc70f33_1          conda-forge/osx-64      317kB
  + dask                                  2023.10.0  pyhd8ed1ab_0            conda-forge/noarch        7kB
  + dask-core                             2023.10.0  pyhd8ed1ab_0            conda-forge/noarch      863kB
  + dav1d                                     1.2.1  h0dc2134_0              conda-forge/osx-64      668kB
  + dill                                      0.3.7  pyhd8ed1ab_0            conda-forge/noarch       88kB
  + distributed                           2023.10.0  pyhd8ed1ab_0            conda-forge/noarch      788kB
  + docutils                                 0.20.1  py39h6e9494a_2          conda-forge/osx-64      707kB
  + expat                                     2.5.0  hf0c8a7f_1              conda-forge/osx-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0              conda-forge/noarch     Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0              conda-forge/noarch     Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0              conda-forge/noarch     Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0              conda-forge/noarch     Cached
  + fontconfig                               2.14.2  h5bb23bf_0              conda-forge/osx-64     Cached
  + fonts-conda-ecosystem                         1  0                       conda-forge/noarch     Cached
  + fonts-conda-forge                             1  0                       conda-forge/noarch     Cached
  + fonttools                                4.43.1  py39ha09f3b3_0          conda-forge/osx-64        2MB
  + freetype                                 2.12.1  h60636b9_2              conda-forge/osx-64     Cached
  + fribidi                                  1.0.10  hbcb3906_0              conda-forge/osx-64     Cached
  + fsspec                                2023.10.0  pyhca7485f_0            conda-forge/noarch      125kB
  + gdbm                                       1.18  h8a0c380_2              conda-forge/osx-64     Cached
  + gettext                                  0.21.1  h8a4c099_0              conda-forge/osx-64     Cached
  + gflags                                    2.2.2  hb1e8313_1004           conda-forge/osx-64       95kB
  + gfortran_impl_osx-64                     12.3.0  h54fd467_1              conda-forge/osx-64     Cached
  + gfortran_osx-64                          12.3.0  h18f7dce_1              conda-forge/osx-64     Cached
  + giflib                                    5.2.1  hb7f2c08_3              conda-forge/osx-64     Cached
  + glog                                      0.6.0  h8ac2a54_0              conda-forge/osx-64      101kB
  + glpk                                        5.0  h3cb5acd_0              conda-forge/osx-64     Cached
  + gmp                                       6.2.1  h2e338ed_0              conda-forge/osx-64     Cached
  + graphite2                                1.3.14  he9d5cce_1              pkgs/main/osx-64       Cached
  + h5py                                     3.10.0  nompi_py39hab254d4_100  conda-forge/osx-64      987kB
  + h5sparse                                  0.1.0  pyh086e186_0            bioconda/noarch          12kB
  + harfbuzz                                  8.2.1  h7666e2a_0              conda-forge/osx-64     Cached
  + hdf5                                     1.14.2  nompi_hedada53_100      conda-forge/osx-64        4MB
  + htslib                                     1.18  h365c357_0              bioconda/osx-64           2MB
  + icu                                        73.2  hf5e326d_0              conda-forge/osx-64     Cached
  + idna                                        3.4  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + imagecodecs                            2023.9.4  py39haa70d31_1          conda-forge/osx-64        2MB
  + imageio                                  2.31.5  pyh8c1a49c_0            conda-forge/noarch      291kB
  + importlib-metadata                        6.8.0  pyha770c72_0            conda-forge/noarch       26kB
  + importlib-resources                       6.1.0  pyhd8ed1ab_0            conda-forge/noarch       10kB
  + importlib_metadata                        6.8.0  hd8ed1ab_0              conda-forge/noarch        9kB
  + importlib_resources                       6.1.0  pyhd8ed1ab_0            conda-forge/noarch       30kB
  + isl                                        0.25  hb486fe8_0              conda-forge/osx-64     Cached
  + jinja2                                    3.1.2  pyhd8ed1ab_1            conda-forge/noarch     Cached
  + joblib                                    1.3.2  pyhd8ed1ab_0            conda-forge/noarch      221kB
  + jq                                          1.6  hc929b4f_1000           conda-forge/osx-64     Cached
  + jxrlib                                      1.1  h35c211d_2              conda-forge/osx-64      231kB
  + kiwisolver                                1.4.5  py39h8ee36c8_1          conda-forge/osx-64       60kB
  + krb5                                     1.21.2  hb884880_0              conda-forge/osx-64     Cached
  + lazy_loader                                 0.3  pyhd8ed1ab_0            conda-forge/noarch       14kB
  + lcms2                                      2.15  ha53face_2              conda-forge/osx-64      225kB
  + ld64_osx-64                                 609  ha20a434_15             conda-forge/osx-64     Cached
  + lerc                                      4.0.0  hb486fe8_0              conda-forge/osx-64     Cached
  + libabseil                            20230802.1  cxx17_h048a20a_0        conda-forge/osx-64        1MB
  + libaec                                    1.1.2  he965462_1              conda-forge/osx-64       29kB
  + libarrow                                 13.0.0  h23351de_11_cpu         conda-forge/osx-64       20MB
  + libavif16                                 1.0.1  h4fa63ff_2              conda-forge/osx-64       90kB
  + libblas                                   3.9.0  19_osx64_openblas       conda-forge/osx-64     Cached
  + libbrotlicommon                           1.1.0  h0dc2134_1              conda-forge/osx-64       67kB
  + libbrotlidec                              1.1.0  h0dc2134_1              conda-forge/osx-64       30kB
  + libbrotlienc                              1.1.0  h0dc2134_1              conda-forge/osx-64      299kB
  + libcblas                                  3.9.0  19_osx64_openblas       conda-forge/osx-64       15kB
  + libclang-cpp16                           16.0.6  default_h762fdd7_1      conda-forge/osx-64     Cached
  + libcrc32c                                 1.1.2  he49afe7_0              conda-forge/osx-64       20kB
  + libcurl                                   8.4.0  h726d00d_0              conda-forge/osx-64     Cached
  + libcxx                                   16.0.6  hd57cbcb_0              conda-forge/osx-64     Cached
  + libdeflate                                 1.18  hac1461d_0              conda-forge/osx-64     Cached
  + libedit                            3.1.20221030  h6c40b1e_0              pkgs/main/osx-64       Cached
  + libev                                      4.33  haf1e3a3_1              conda-forge/osx-64     Cached
  + libevent                                 2.1.12  ha90c15b_1              conda-forge/osx-64      373kB
  + libexpat                                  2.5.0  hf0c8a7f_1              conda-forge/osx-64     Cached
  + libffi                                    3.4.4  hecd8cb5_0              pkgs/main/osx-64       Cached
  + libgfortran                               5.0.0  13_2_0_h97931a8_1       conda-forge/osx-64     Cached
  + libgfortran-devel_osx-64                 12.3.0  h0b6f5ec_1              conda-forge/noarch     Cached
  + libgfortran5                             13.2.0  h2873a65_1              conda-forge/osx-64     Cached
  + libglib                                  2.78.0  hc62aa5d_0              conda-forge/osx-64     Cached
  + libgoogle-cloud                          2.12.0  h407922f_3              conda-forge/osx-64       31MB
  + libgrpc                                  1.58.1  hecc90c7_2              conda-forge/osx-64        4MB
  + libiconv                                   1.17  hac89ed1_0              conda-forge/osx-64     Cached
  + libjpeg-turbo                           2.1.5.1  h0dc2134_1              conda-forge/osx-64      457kB
  + liblapack                                 3.9.0  19_osx64_openblas       conda-forge/osx-64     Cached
  + libllvm14                                14.0.6  hc8e404f_4              conda-forge/osx-64       22MB
  + libllvm16                                16.0.6  he4b1e75_2              conda-forge/osx-64     Cached
  + libnghttp2                               1.57.0  h9beae6a_0              pkgs/main/osx-64       Cached
  + libopenblas                              0.3.24  openmp_h48a4ad5_0       conda-forge/osx-64     Cached
  + libpng                                   1.6.39  ha978bb4_0              conda-forge/osx-64     Cached
  + libprotobuf                              4.24.3  he0c2237_1              conda-forge/osx-64        2MB
  + libre2-11                            2023.06.02  h4694dbf_0              conda-forge/osx-64      183kB
  + libsqlite                                3.43.2  h92b6c6a_0              conda-forge/osx-64     Cached
  + libssh2                                  1.11.0  hd019ec5_0              conda-forge/osx-64     Cached
  + libthrift                                0.19.0  h064b379_1              conda-forge/osx-64      325kB
  + libtiff                                   4.6.0  hf955e92_0              conda-forge/osx-64      260kB
  + libutf8proc                               2.8.0  hb7f2c08_0              conda-forge/osx-64       99kB
  + libwebp-base                              1.3.2  h0dc2134_0              conda-forge/osx-64     Cached
  + libxcb                                     1.15  hb7f2c08_0              conda-forge/osx-64     Cached
  + libxml2                                  2.11.5  h3346baf_1              conda-forge/osx-64     Cached
  + libzlib                                  1.2.13  h8a1eda9_5              conda-forge/osx-64     Cached
  + libzopfli                                 1.0.3  h046ec9c_0              conda-forge/osx-64      162kB
  + llvm-openmp                              17.0.3  hb6ac08f_0              conda-forge/osx-64     Cached
  + llvm-tools                               16.0.6  he4b1e75_2              conda-forge/osx-64     Cached
  + llvmlite                                 0.41.1  py39he5a6977_0          conda-forge/osx-64      291kB
  + locket                                    1.0.0  pyhd8ed1ab_0            conda-forge/noarch        8kB
  + lz4                                       4.3.2  py39h2a14dfd_1          conda-forge/osx-64       34kB
  + lz4-c                                     1.9.4  hf0c8a7f_0              conda-forge/osx-64      156kB
  + m2r2                                0.3.3.post2  pyhd8ed1ab_0            conda-forge/noarch       16kB
  + make                                        4.3  h22f3db7_1              conda-forge/osx-64     Cached
  + markupsafe                                2.1.3  py39hdc70f33_1          conda-forge/osx-64       23kB
  + matplotlib-base                           3.8.0  py39h7070ae8_2          conda-forge/osx-64        7MB
  + mistune                                   0.8.4  py39h89e85a6_1005       conda-forge/osx-64       56kB
  + more-itertools                           10.1.0  pyhd8ed1ab_0            conda-forge/noarch       54kB
  + mpc                                       1.3.1  h81bd1dd_0              conda-forge/osx-64     Cached
  + mpfr                                      4.2.0  h4f9bd69_0              conda-forge/osx-64     Cached
  + msgpack-python                            1.0.6  py39h8ee36c8_0          conda-forge/osx-64      187kB
  + multiprocess                            0.70.15  py39hdc70f33_1          conda-forge/osx-64      237kB
  + multiprocessing-logging                   0.3.3  pyhd8ed1ab_0            conda-forge/noarch       13kB
  + munkres                                   1.1.4  pyh9f0ad1d_0            conda-forge/noarch     Cached
  + natsort                                   8.4.0  pyhd8ed1ab_0            conda-forge/noarch       37kB
  + ncurses                                     6.4  hf0c8a7f_0              conda-forge/osx-64     Cached
  + networkx                                    3.2  pyhd8ed1ab_1            conda-forge/noarch        1MB
  + numba                                    0.58.0  py39h3ea8b11_0          pkgs/main/osx-64          5MB
  + numexpr                                   2.8.7  py39h5d65943_4          conda-forge/osx-64      126kB
  + numpy                                    1.23.5  py39hdfa1d0c_0          conda-forge/osx-64        6MB
  + oniguruma                                 6.9.9  h10d778d_0              conda-forge/osx-64     Cached
  + openjpeg                                  2.5.0  ha4da562_3              conda-forge/osx-64      336kB
  + openssl                                   3.1.3  h8a1eda9_0              conda-forge/osx-64     Cached
  + orc                                       1.9.0  hb037d9a_3              conda-forge/osx-64      423kB
  + packaging                                  23.2  pyhd8ed1ab_0            conda-forge/noarch       49kB
  + pairix                                    0.3.7  py39h66c2135_4          bioconda/osx-64         100kB
  + pairtools                                 0.3.0  py39h33ca528_6          bioconda/osx-64         162kB
  + pandas                                    1.5.3  py39hecff1ad_1          conda-forge/osx-64       11MB
  + pandoc                                    3.1.3  h9d075a6_0              conda-forge/osx-64     Cached
  + pango                                   1.50.14  h19c1c8a_2              conda-forge/osx-64     Cached
  + parallel                               20230922  h694c41f_0              conda-forge/osx-64     Cached
  + partd                                     1.4.1  pyhd8ed1ab_0            conda-forge/noarch       21kB
  + patsy                                     0.5.3  pyhd8ed1ab_0            conda-forge/noarch      194kB
  + pbgzip                               2016.08.04  h652314c_4              bioconda/osx-64          31kB
  + pbzip2                                   1.1.13  h92b232e_2              conda-forge/osx-64       41kB
  + pcre2                                     10.40  h1c4e4bc_0              conda-forge/osx-64     Cached
  + perl                                     5.34.0  h435f0c2_2              pkgs/main/osx-64       Cached
  + pigz                                        2.8  h92b6c6a_0              conda-forge/osx-64       70kB
  + pillow                                   10.0.1  py39h0ada47f_1          conda-forge/osx-64       47MB
  + pip                                      23.3.1  pyhd8ed1ab_0            conda-forge/noarch        1MB
  + pixman                                   0.42.2  he965462_0              conda-forge/osx-64     Cached
  + psutil                                    5.9.5  py39hdc70f33_1          conda-forge/osx-64      367kB
  + pthread-stubs                               0.4  hc929b4f_1001           conda-forge/osx-64     Cached
  + py-cpuinfo                                9.0.0  pyhd8ed1ab_0            conda-forge/noarch       25kB
  + pyarrow                                  13.0.0  py39h8632116_11_cpu     conda-forge/osx-64        4MB
  + pyfaidx                                 0.7.2.2  pyhdfd78af_0            bioconda/noarch          34kB
  + pyparsing                                 3.1.1  pyhd8ed1ab_0            conda-forge/noarch       90kB
  + pysam                                    0.22.0  py39hba326fb_0          bioconda/osx-64           4MB
  + pysocks                                   1.7.1  py39h6e9494a_5          conda-forge/osx-64       29kB
  + pytables                                  3.9.1  py39h24dbf18_0          conda-forge/osx-64        1MB
  + python                                   3.9.18  h07e1443_0_cpython      conda-forge/osx-64       11MB
  + python-dateutil                           2.8.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + python_abi                                  3.9  4_cp39                  conda-forge/osx-64        6kB
  + pytz                               2023.3.post1  pyhd8ed1ab_0            conda-forge/noarch      187kB
  + pyvcf3                                    1.0.3  pyhdfd78af_0            bioconda/noarch         980kB
  + pywavelets                                1.4.1  py39hd01001f_1          conda-forge/osx-64        4MB
  + pyyaml                                    6.0.1  py39hdc70f33_1          conda-forge/osx-64      162kB
  + r-argparse                                2.2.2  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-askpass                                 1.2.0  r43h6dc245f_0           conda-forge/osx-64       31kB
  + r-assertthat                              0.2.1  r43hc72bb7e_4           conda-forge/noarch     Cached
  + r-backports                               1.4.1  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-base                                    4.3.1  h61172b1_5              conda-forge/osx-64       25MB
  + r-base64enc                               0.1_3  r43h6dc245f_1006        conda-forge/osx-64     Cached
  + r-bh                                   1.81.0_1  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-bit                                     4.0.5  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-bit64                                   4.0.5  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-bitops                                  1.0_7  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-blob                                    1.2.4  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-broom                                   1.0.5  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-bslib                                   0.5.1  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-cachem                                  1.0.8  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-callr                                   3.7.3  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-cellranger                              1.1.0  r43hc72bb7e_1006        conda-forge/noarch     Cached
  + r-checkmate                               2.2.0  r43h6dc245f_1           conda-forge/osx-64      667kB
  + r-cli                                     3.6.1  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-clipr                                   0.8.0  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-cluster                                 2.1.4  r43hfe07776_1           conda-forge/osx-64      574kB
  + r-codetools                              0.2_19  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-colorspace                              2.1_0  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-conflicted                              1.2.0  r43h785f33e_1           conda-forge/noarch     Cached
  + r-cpp11                                   0.4.6  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-crayon                                  1.5.2  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-crosstalk                               1.2.0  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-curl                                    5.1.0  r43h0100ac3_0           conda-forge/osx-64      450kB
  + r-data.table                             1.14.8  r43h7eccc33_2           conda-forge/osx-64     Cached
  + r-dbi                                     1.1.3  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-dbplyr                                  2.3.4  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-deldir                                  1.0_9  r43hfe07776_1           conda-forge/osx-64      304kB
  + r-dichromat                             2.0_0.1  r43ha770c72_2           conda-forge/noarch      161kB
  + r-digest                                 0.6.33  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-dplyr                                   1.1.3  r43hac7d2d5_0           conda-forge/osx-64        1MB
  + r-dtplyr                                  1.3.1  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-ellipsis                                0.3.2  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-evaluate                                 0.22  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-fansi                                   1.0.5  r43hb2c329c_0           conda-forge/osx-64      309kB
  + r-farver                                  2.1.1  r43hac7d2d5_2           conda-forge/osx-64     Cached
  + r-fastmap                                 1.1.1  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-filelock                                1.0.2  r43h6dc245f_1004        conda-forge/osx-64     Cached
  + r-findpython                              1.0.8  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-fontawesome                             0.5.2  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-forcats                                 1.0.0  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-foreign                                0.8_85  r43h6dc245f_0           conda-forge/osx-64      264kB
  + r-formatr                                  1.14  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-formula                                 1.2_5  r43hc72bb7e_1           conda-forge/noarch      174kB
  + r-fs                                      1.6.3  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-futile.logger                           1.4.3  r43hc72bb7e_1005        conda-forge/noarch     Cached
  + r-futile.options                          1.0.1  r43hc72bb7e_1004        conda-forge/noarch     Cached
  + r-gargle                                  1.5.2  r43h785f33e_0           conda-forge/noarch     Cached
  + r-generics                                0.1.3  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-ggplot2                                 3.4.4  r43hc72bb7e_0           conda-forge/noarch        4MB
  + r-ggsci                                   3.0.0  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-glue                                    1.6.2  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-googledrive                             2.1.1  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-googlesheets4                           1.1.1  r43h785f33e_1           conda-forge/noarch     Cached
  + r-gridextra                                 2.3  r43hc72bb7e_1005        conda-forge/noarch        1MB
  + r-gtable                                  0.3.4  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-haven                                   2.5.3  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-hexbin                                 1.28.3  r43hfe07776_1           conda-forge/osx-64     Cached
  + r-highr                                    0.10  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-hmisc                                   5.1_1  r43hfe07776_0           conda-forge/osx-64        4MB
  + r-hms                                     1.1.3  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-htmltable                               2.4.1  r43hc72bb7e_2           conda-forge/noarch      406kB
  + r-htmltools                             0.5.6.1  r43h64b2c41_0           conda-forge/osx-64      358kB
  + r-htmlwidgets                             1.6.2  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-httr                                    1.4.7  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-ids                                     1.0.1  r43hc72bb7e_3           conda-forge/noarch     Cached
  + r-igraph                                  1.5.1  r43hedd5883_0           conda-forge/osx-64        4MB
  + r-interp                                  1.1_4  r43ha1020dc_1           conda-forge/osx-64        2MB
  + r-isoband                                 0.2.7  r43hac7d2d5_2           conda-forge/osx-64     Cached
  + r-jpeg                                   0.1_10  r43he6a093d_3           conda-forge/osx-64       52kB
  + r-jquerylib                               0.1.4  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-jsonlite                                1.8.7  r43h6dc245f_0           conda-forge/osx-64     Cached
  + r-knitr                                    1.44  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-labeling                                0.4.3  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-lambda.r                                1.2.4  r43hc72bb7e_3           conda-forge/noarch     Cached
  + r-later                                   1.3.1  r43h670e93c_1           conda-forge/osx-64     Cached
  + r-lattice                                0.22_4  r43hb2c329c_0           conda-forge/osx-64        1MB
  + r-latticeextra                           0.6_30  r43hc72bb7e_2           conda-forge/noarch        2MB
  + r-lazyeval                                0.2.2  r43h6dc245f_4           conda-forge/osx-64     Cached
  + r-lifecycle                               1.0.3  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-lubridate                               1.9.3  r43h6dc245f_0           conda-forge/osx-64      983kB
  + r-magrittr                                2.0.3  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-mass                                   7.3_60  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-matrix                                1.6_1.1  r43hc46c21c_0           conda-forge/osx-64        4MB
  + r-matrixstats                             1.0.0  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-memoise                                 2.0.1  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-mgcv                                    1.9_0  r43h9c380c6_0           conda-forge/osx-64     Cached
  + r-mime                                     0.12  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-modelr                                 0.1.11  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-munsell                                 0.5.0  r43hc72bb7e_1006        conda-forge/noarch     Cached
  + r-nlme                                  3.1_163  r43hfe07776_0           conda-forge/osx-64     Cached
  + r-nnet                                   7.3_19  r43h6dc245f_1           conda-forge/osx-64      135kB
  + r-openssl                                 2.1.1  r43hc61a7e2_0           conda-forge/osx-64      680kB
  + r-pillar                                  1.9.0  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-pkgconfig                               2.0.3  r43hc72bb7e_3           conda-forge/noarch     Cached
  + r-plogr                                   0.2.0  r43hc72bb7e_1005        conda-forge/noarch     Cached
  + r-plotly                                 4.10.3  r43hc72bb7e_0           conda-forge/noarch        3MB
  + r-png                                     0.1_8  r43h9ae9e50_1           conda-forge/osx-64     Cached
  + r-prettyunits                             1.2.0  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-processx                                3.8.2  r43h6dc245f_0           conda-forge/osx-64     Cached
  + r-progress                                1.2.2  r43hc72bb7e_4           conda-forge/noarch     Cached
  + r-promises                                1.2.1  r43hac7d2d5_0           conda-forge/osx-64        2MB
  + r-ps                                      1.7.5  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-purrr                                   1.0.2  r43h6dc245f_0           conda-forge/osx-64     Cached
  + r-r6                                      2.5.1  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-ragg                                    1.2.5  r43h5126171_3           conda-forge/osx-64      399kB
  + r-rappdirs                                0.3.3  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-rcolorbrewer                            1.1_3  r43h785f33e_2           conda-forge/noarch     Cached
  + r-rcpp                                   1.0.11  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-rcppeigen                           0.3.3.9.3  r43hfaea39f_1           conda-forge/osx-64        1MB
  + r-rcurl                               1.98_1.12  r43h0100ac3_3           conda-forge/osx-64      816kB
  + r-readr                                   2.1.4  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-readxl                                  1.4.3  r43h88814b1_0           conda-forge/osx-64     Cached
  + r-rematch                                 2.0.0  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-rematch2                                2.1.2  r43hc72bb7e_3           conda-forge/noarch     Cached
  + r-reprex                                  2.0.2  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-restfulr                               0.0.15  r43hfa19939_3           bioconda/osx-64         448kB
  + r-rjson                                  0.2.21  r43hac7d2d5_3           conda-forge/osx-64      157kB
  + r-rlang                                   1.1.1  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-rmarkdown                                2.25  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-rpart                                  4.1.21  r43hb2c329c_0           conda-forge/osx-64      700kB
  + r-rsqlite                                 2.3.1  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-rstudioapi                             0.15.0  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-rvest                                   1.0.3  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-sass                                    0.4.7  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-scales                                  1.2.1  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-selectr                                 0.4_2  r43hc72bb7e_3           conda-forge/noarch     Cached
  + r-snow                                    0.4_4  r43hc72bb7e_2           conda-forge/noarch     Cached
  + r-stringi                                1.7.12  r43h480af0a_3           conda-forge/osx-64      855kB
  + r-stringr                                 1.5.0  r43h785f33e_1           conda-forge/noarch     Cached
  + r-survival                                3.5_7  r43h6dc245f_0           conda-forge/osx-64        6MB
  + r-sys                                     3.4.2  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-systemfonts                             1.0.5  r43hac8360d_0           conda-forge/osx-64      218kB
  + r-textshaping                             0.3.7  r43hfe21e11_0           conda-forge/osx-64      101kB
  + r-tibble                                  3.2.1  r43h6dc245f_2           conda-forge/osx-64     Cached
  + r-tidyr                                   1.3.0  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-tidyselect                              1.2.0  r43hbe3e9c8_1           conda-forge/osx-64     Cached
  + r-tidyverse                               2.0.0  r43h785f33e_1           conda-forge/noarch     Cached
  + r-timechange                              0.2.0  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-tinytex                                  0.48  r43hc72bb7e_0           conda-forge/noarch      144kB
  + r-tzdb                                    0.4.0  r43hac7d2d5_1           conda-forge/osx-64     Cached
  + r-utf8                                    1.2.3  r43h6dc245f_1           conda-forge/osx-64     Cached
  + r-uuid                                    1.1_1  r43h6dc245f_0           conda-forge/osx-64       49kB
  + r-vctrs                                   0.6.4  r43h64b2c41_0           conda-forge/osx-64        1MB
  + r-viridis                                 0.6.4  r43hc72bb7e_0           conda-forge/noarch        3MB
  + r-viridislite                             0.4.2  r43hc72bb7e_1           conda-forge/noarch     Cached
  + r-vroom                                   1.6.4  r43hac7d2d5_0           conda-forge/osx-64      805kB
  + r-withr                                   2.5.1  r43hc72bb7e_0           conda-forge/noarch     Cached
  + r-xfun                                     0.40  r43hac7d2d5_0           conda-forge/osx-64     Cached
  + r-xml                                 3.99_0.14  r43hb8526f4_2           conda-forge/osx-64        2MB
  + r-xml2                                    1.3.5  r43h2e0d1c5_0           conda-forge/osx-64     Cached
  + r-yaml                                    2.3.7  r43h6dc245f_1           conda-forge/osx-64     Cached
  + rav1e                                     0.6.6  h7205ca4_2              conda-forge/osx-64        2MB
  + re2                                  2023.06.02  hd34609a_0              conda-forge/osx-64       27kB
  + readline                                    8.2  h9e318b2_1              conda-forge/osx-64     Cached
  + rename                                    1.601  hdfd78af_1              bioconda/noarch        Cached
  + requests                                 2.31.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + samtools                                   1.18  hd510865_1              bioconda/osx-64         471kB
  + scikit-image                             0.22.0  py39h5d65943_2          conda-forge/osx-64       10MB
  + scikit-learn                              1.3.1  py39hecadb86_1          conda-forge/osx-64        7MB
  + scipy                                    1.11.3  py39h2145d6e_1          conda-forge/osx-64       15MB
  + seaborn                                  0.13.0  hd8ed1ab_0              conda-forge/noarch        7kB
  + seaborn-base                             0.13.0  pyhd8ed1ab_0            conda-forge/noarch      234kB
  + setuptools                               68.2.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + sigtool                                   0.1.3  h88f4db0_0              conda-forge/osx-64     Cached
  + simplejson                               3.19.2  py39ha09f3b3_0          conda-forge/osx-64      106kB
  + six                                      1.16.0  pyh6c4a22f_0            conda-forge/noarch     Cached
  + snappy                                   1.1.10  h225ccf5_0              conda-forge/osx-64       35kB
  + sortedcontainers                          2.4.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + statsmodels                              0.14.0  py39h5b4affa_2          conda-forge/osx-64       10MB
  + svt-av1                                   1.7.0  he965462_0              conda-forge/osx-64        2MB
  + tapi                                  1100.0.11  h9ce4665_0              conda-forge/osx-64     Cached
  + tbb                                   2021.10.0  h1c7c39f_2              conda-forge/osx-64      160kB
  + tblib                                     2.0.0  pyhd8ed1ab_0            conda-forge/noarch       17kB
  + threadpoolctl                             3.2.0  pyha21a80b_0            conda-forge/noarch       21kB
  + tifffile                              2023.9.26  pyhd8ed1ab_0            conda-forge/noarch      176kB
  + tk                                       8.6.13  hef22860_0              conda-forge/osx-64     Cached
  + tktable                                    2.10  ha166976_5              conda-forge/osx-64     Cached
  + toml                                     0.10.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + tomlkit                                  0.12.1  pyha770c72_0            conda-forge/noarch     Cached
  + toolz                                    0.12.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + tornado                                   6.3.3  py39hdc70f33_1          conda-forge/osx-64      631kB
  + tzdata                                    2023c  h71feb2d_0              conda-forge/noarch     Cached
  + unicodedata2                             15.1.0  py39hdc70f33_0          conda-forge/osx-64      370kB
  + urllib3                                   2.0.7  pyhd8ed1ab_0            conda-forge/noarch       99kB
  + wheel                                    0.41.2  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + xmltodict                                0.13.0  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + xorg-libxau                              1.0.11  h0dc2134_0              conda-forge/osx-64     Cached
  + xorg-libxdmcp                             1.1.3  h35c211d_0              conda-forge/osx-64     Cached
  + xyzservices                           2023.10.0  pyhd8ed1ab_0            conda-forge/noarch       36kB
  + xz                                        5.4.2  h6c40b1e_0              pkgs/main/osx-64       Cached
  + yaml                                      0.2.5  h0d85af4_2              conda-forge/osx-64     Cached
  + yq                                        3.2.3  pyhd8ed1ab_0            conda-forge/noarch     Cached
  + zfp                                       1.0.0  hf3d7188_4              conda-forge/osx-64      224kB
  + zict                                      3.0.0  pyhd8ed1ab_0            conda-forge/noarch       36kB
  + zipp                                     3.17.0  pyhd8ed1ab_0            conda-forge/noarch       19kB
  + zlib                                     1.2.13  h8a1eda9_5              conda-forge/osx-64     Cached
  + zlib-ng                                   2.0.7  hb7f2c08_0              conda-forge/osx-64       93kB
  + zstd                                      1.5.5  h829000d_0              conda-forge/osx-64     Cached

  Summary:

  Install: 452 packages

  Total download: 393MB

────────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
python_abi                                           6.5kB @  94.8kB/s  0.1s
libbrotlicommon                                     67.5kB @ 903.5kB/s  0.1s
coreutils                                            1.4MB @  15.6MB/s  0.1s
libjpeg-turbo                                      456.9kB @   4.8MB/s  0.1s
aws-c-common                                       204.6kB @   1.8MB/s  0.0s
pigz                                                70.4kB @ 603.6kB/s  0.0s
zlib-ng                                             93.2kB @ 632.2kB/s  0.1s
charls                                             138.1kB @ 914.2kB/s  0.0s
libbrotlidec                                        30.3kB @ 190.8kB/s  0.0s
pbzip2                                              40.8kB @ 204.7kB/s  0.0s
aom                                                  2.9MB @  13.8MB/s  0.1s
libre2-11                                          182.8kB @ 837.3kB/s  0.1s
aws-checksums                                       48.7kB @ 208.8kB/s  0.1s
blosc                                               49.9kB @ 210.4kB/s  0.0s
orc                                                423.4kB @   1.6MB/s  0.0s
aws-c-event-stream                                  47.2kB @ 176.5kB/s  0.0s
libcblas                                            14.7kB @  53.7kB/s  0.0s
aws-c-auth                                          89.4kB @ 289.9kB/s  0.1s
libevent                                           372.7kB @   1.2MB/s  0.0s
libthrift                                          325.4kB @ 994.0kB/s  0.1s
fsspec                                             124.9kB @ 362.2kB/s  0.0s
locket                                               8.2kB @  22.4kB/s  0.0s
libtiff                                            260.4kB @ 695.5kB/s  0.1s
charset-normalizer                                  46.2kB @ 117.5kB/s  0.1s
dill                                                87.6kB @ 220.2kB/s  0.1s
natsort                                             37.3kB @  92.1kB/s  0.0s
libllvm14                                           22.5MB @  54.4MB/s  0.3s
cycler                                              13.5kB @  31.8kB/s  0.0s
packaging                                           49.5kB @ 112.2kB/s  0.0s
partd                                               20.7kB @  46.7kB/s  0.0s
importlib_metadata                                   9.4kB @  20.9kB/s  0.0s
brotli-python                                      367.3kB @ 780.9kB/s  0.0s
tornado                                            631.3kB @   1.3MB/s  0.0s
llvmlite                                           290.6kB @ 581.6kB/s  0.1s
joblib                                             221.2kB @ 421.8kB/s  0.1s
multiprocess                                       237.1kB @ 449.0kB/s  0.0s
contourpy                                          217.8kB @ 383.1kB/s  0.0s
fonttools                                            2.1MB @   3.3MB/s  0.1s
mistune                                             55.6kB @  75.3kB/s  0.3s
h5py                                               986.9kB @   1.3MB/s  0.1s
clangxx_impl_osx-64                                 17.8kB @  21.8kB/s  0.1s
r-deldir                                           303.6kB @ 332.3kB/s  0.1s
matplotlib-base                                      6.9MB @   6.6MB/s  0.3s
r-uuid                                              49.1kB @  45.5kB/s  0.2s
scipy                                               15.3MB @  14.0MB/s  0.5s
r-curl                                             449.5kB @ 386.6kB/s  0.1s
libgoogle-cloud                                     30.9MB @  25.3MB/s  0.7s
r-askpass                                           30.6kB @  24.5kB/s  0.2s
r-jpeg                                              52.4kB @  41.9kB/s  0.2s
r-nnet                                             134.6kB @ 105.8kB/s  0.1s
r-rcppeigen                                          1.3MB @ 987.0kB/s  0.1s
bioconductor-protgenerics                          248.8kB @ 182.7kB/s  0.1s
htslib                                               2.4MB @   1.8MB/s  0.1s
tifffile                                           175.9kB @ 125.1kB/s  0.0s
r-formula                                          174.2kB @ 120.9kB/s  0.0s
m2r2                                                16.5kB @  10.7kB/s  0.2s
bokeh                                                4.9MB @   3.1MB/s  0.1s
r-restfulr                                         448.3kB @ 274.0kB/s  0.3s
dask                                                 7.4kB @   4.5kB/s  0.1s
pillow                                              46.8MB @  27.6MB/s  1.2s
bioconductor-biocio                                469.4kB @ 277.0kB/s  0.1s
r-interp                                             1.5MB @ 843.1kB/s  0.5s
scikit-image                                        10.4MB @   5.7MB/s  0.2s
r-dplyr                                              1.4MB @ 743.6kB/s  0.1s
r-ragg                                             399.3kB @ 200.9kB/s  0.3s
r-textshaping                                      100.7kB @  49.0kB/s  0.4s
r-viridis                                            3.0MB @   1.5MB/s  0.1s
bioconductor-annotationfilter                      561.2kB @ 271.0kB/s  0.3s
statsmodels                                          9.9MB @   4.8MB/s  0.4s
libutf8proc                                         98.9kB @  46.2kB/s  0.1s
bioconductor-biomart                               927.3kB @ 417.7kB/s  0.2s
jxrlib                                             231.0kB @ 103.9kB/s  0.1s
libcrc32c                                           20.1kB @   8.9kB/s  0.0s
libaec                                              29.0kB @  12.7kB/s  0.1s
aws-c-sdkutils                                      47.4kB @  20.0kB/s  0.1s
zfp                                                223.5kB @  93.7kB/s  0.1s
brotli-bin                                          16.7kB @   6.9kB/s  0.0s
brotli                                              19.5kB @   7.9kB/s  0.0s
aws-c-mqtt                                         138.2kB @  55.4kB/s  0.0s
libprotobuf                                          2.2MB @ 860.4kB/s  0.1s
libgrpc                                              4.0MB @   1.5MB/s  0.2s
cached_property                                     11.1kB @   4.1kB/s  0.1s
bioconductor-genomicinteractions                     3.7MB @   1.4MB/s  0.7s
bioconductor-rtracklayer                             5.6MB @   2.0MB/s  0.9s
zipp                                                19.0kB @   6.9kB/s  0.0s
pbgzip                                              30.8kB @  11.0kB/s  0.3s
lazy_loader                                         14.3kB @   5.1kB/s  0.0s
zict                                                36.3kB @  13.0kB/s  0.1s
more-itertools                                      53.7kB @  19.1kB/s  0.1s
click                                               84.4kB @  29.9kB/s  0.0s
importlib_resources                                 30.0kB @  10.6kB/s  0.0s
msgpack-python                                     187.0kB @  65.5kB/s  0.1s
unicodedata2                                       369.8kB @ 128.9kB/s  0.1s
bioconductor-variantannotation                       4.1MB @   1.4MB/s  0.8s
markupsafe                                          22.9kB @   7.9kB/s  0.1s
numexpr                                            125.8kB @  43.2kB/s  0.0s
numpy                                                5.6MB @   1.9MB/s  0.1s
clangxx_osx-64                                      19.4kB @   6.6kB/s  0.0s
hdf5                                                 3.6MB @   1.2MB/s  0.1s
pytables                                             1.3MB @ 422.4kB/s  0.1s
r-stringi                                          855.2kB @ 282.7kB/s  0.1s
r-foreign                                          264.0kB @  86.7kB/s  0.1s
pyfaidx                                             34.1kB @  11.0kB/s  0.1s
samtools                                           470.7kB @ 147.0kB/s  0.1s
r-xml                                                1.7MB @ 540.4kB/s  0.3s
dask-core                                          863.0kB @ 265.8kB/s  0.0s
seaborn-base                                       233.8kB @  71.2kB/s  0.1s
distributed                                        787.9kB @ 238.6kB/s  0.1s
r-htmltools                                        357.5kB @ 107.4kB/s  0.3s
pandas                                              11.3MB @   3.4MB/s  0.5s
numba                                                4.5MB @   1.3MB/s  0.1s
r-htmltable                                        405.5kB @ 116.3kB/s  0.1s
r-rcurl                                            816.0kB @ 233.3kB/s  0.5s
r-systemfonts                                      218.2kB @  61.3kB/s  0.3s
tbb                                                159.8kB @  44.4kB/s  0.0s
r-plotly                                             2.9MB @ 794.0kB/s  0.1s
rav1e                                                1.8MB @ 483.3kB/s  0.1s
bioconductor-ensembldb                               3.6MB @ 995.1kB/s  0.2s
libabseil                                            1.1MB @ 312.1kB/s  0.1s
lz4-c                                              156.4kB @  42.2kB/s  0.0s
aws-c-cal                                           45.3kB @  12.2kB/s  0.0s
c-blosc2                                           273.1kB @  73.4kB/s  0.0s
aws-c-http                                         162.5kB @  43.5kB/s  0.0s
r-lubridate                                        983.0kB @ 262.6kB/s  0.4s
aws-crt-cpp                                        275.5kB @  73.3kB/s  0.1s
xyzservices                                         36.4kB @   9.7kB/s  0.0s
asciitree                                            6.2kB @   1.6kB/s  0.0s
cached-property                                      4.1kB @   1.1kB/s  0.0s
pytz                                               187.5kB @  49.1kB/s  0.1s
docutils                                           707.3kB @ 183.8kB/s  0.0s
clang_impl_osx-64                                   17.6kB @   4.5kB/s  0.0s
pyyaml                                             162.4kB @  41.4kB/s  0.1s
pywavelets                                           3.6MB @ 905.0kB/s  0.1s
pysocks                                             28.6kB @   7.1kB/s  0.2s
python                                              11.4MB @   2.8MB/s  0.3s
r-lattice                                            1.4MB @ 332.4kB/s  0.1s
r-rpart                                            699.6kB @ 169.6kB/s  0.1s
scikit-learn                                         7.4MB @   1.8MB/s  0.2s
r-matrix                                             4.0MB @ 971.3kB/s  0.1s
pyvcf3                                             979.5kB @ 236.0kB/s  0.1s
r-tinytex                                          143.9kB @  34.5kB/s  0.0s
imageio                                            291.0kB @  69.5kB/s  0.1s
bioframe                                           127.7kB @  30.4kB/s  0.1s
seaborn                                              6.7kB @   1.6kB/s  0.0s
bioconductor-genomicalignments                       2.4MB @ 571.4kB/s  0.9s
r-igraph                                             4.5MB @   1.0MB/s  0.2s
gflags                                              94.6kB @  21.7kB/s  0.0s
snappy                                              34.7kB @   7.9kB/s  0.0s
glog                                               100.6kB @  22.7kB/s  0.0s
pairix                                             100.5kB @  22.3kB/s  0.4s
re2                                                 27.0kB @   6.0kB/s  0.1s
bioconductor-interactionset                          1.6MB @ 350.0kB/s  0.3s
py-cpuinfo                                          24.9kB @   5.5kB/s  0.0s
lcms2                                              225.4kB @  49.6kB/s  0.0s
threadpoolctl                                       21.0kB @   4.6kB/s  0.0s
lz4                                                 33.9kB @   7.4kB/s  0.0s
kiwisolver                                          60.5kB @  13.2kB/s  0.0s
clang_osx-64                                        20.7kB @   4.5kB/s  0.1s
biopython                                            2.7MB @ 586.8kB/s  0.1s
r-fansi                                            309.3kB @  65.9kB/s  0.0s
r-checkmate                                        666.6kB @ 139.0kB/s  0.1s
multiprocessing-logging                             13.4kB @   2.8kB/s  0.3s
urllib3                                             98.5kB @  20.4kB/s  0.0s
r-hmisc                                              3.5MB @ 713.3kB/s  0.7s
h5sparse                                            12.2kB @   2.5kB/s  0.2s
r-latticeextra                                       2.2MB @ 448.5kB/s  0.1s
r-ggplot2                                            4.1MB @ 823.8kB/s  0.1s
svt-av1                                              2.4MB @ 478.3kB/s  0.1s
bioconductor-gviz                                    7.2MB @   1.4MB/s  0.8s
libavif16                                           90.4kB @  17.7kB/s  0.0s
tblib                                               16.6kB @   3.2kB/s  0.0s
aws-c-s3                                            74.5kB @  14.4kB/s  0.1s
networkx                                             1.1MB @ 221.7kB/s  0.0s
coolpuppy                                           44.8kB @   8.6kB/s  0.3s
psutil                                             366.6kB @  70.4kB/s  0.0s
aws-sdk-cpp                                          3.2MB @ 601.9kB/s  0.1s
r-promises                                           1.6MB @ 299.9kB/s  0.4s
r-rjson                                            156.9kB @  29.7kB/s  0.1s
r-vctrs                                              1.2MB @ 230.6kB/s  0.1s
pyarrow                                              3.6MB @ 666.4kB/s  0.2s
pysam                                                4.1MB @ 766.9kB/s  0.1s
aws-c-compression                                   18.0kB @   3.3kB/s  0.0s
dav1d                                              668.4kB @ 122.8kB/s  0.1s
openjpeg                                           335.6kB @  61.4kB/s  0.0s
pyparsing                                           89.5kB @  16.3kB/s  0.1s
r-dichromat                                        160.8kB @  29.2kB/s  0.2s
simplejson                                         106.3kB @  19.3kB/s  0.0s
bioconductor-bsgenome                                7.3MB @   1.3MB/s  0.2s
patsy                                              193.6kB @  34.9kB/s  0.0s
c-ares                                             103.6kB @  18.5kB/s  0.0s
aws-c-io                                           136.6kB @  24.3kB/s  0.0s
cloudpickle                                         24.7kB @   4.4kB/s  0.0s
bioconductor-genomicfeatures                         2.2MB @ 388.1kB/s  0.7s
cytoolz                                            316.5kB @  55.5kB/s  0.0s
r-cluster                                          574.3kB @ 100.3kB/s  0.1s
r-gridextra                                          1.0MB @ 182.1kB/s  0.1s
brunsli                                            183.1kB @  31.5kB/s  0.0s
importlib-resources                                  9.7kB @   1.7kB/s  0.0s
cooltools                                          300.1kB @  50.9kB/s  0.3s
r-survival                                           6.2MB @   1.0MB/s  0.1s
r-openssl                                          680.2kB @ 113.4kB/s  0.5s
pip                                                  1.4MB @ 231.7kB/s  0.1s
libzopfli                                          162.3kB @  26.8kB/s  0.0s
r-vroom                                            805.5kB @ 128.0kB/s  0.4s
libarrow                                            20.0MB @   3.2MB/s  0.8s
libbrotlienc                                       299.1kB @  47.2kB/s  0.0s
bioconductor-biovizbase                              2.7MB @ 430.2kB/s  0.6s
importlib-metadata                                  25.9kB @   4.1kB/s  0.0s
cooler                                              85.1kB @  13.1kB/s  0.2s
imagecodecs                                          1.6MB @ 241.6kB/s  0.4s
pairtools                                          161.5kB @  24.2kB/s  0.3s
r-base                                              25.4MB @   3.8MB/s  0.7s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate pairtools_env

To deactivate an active environment, use

     $ mamba deactivate


❯ if ${activate_env}; then mamba activate "${env_name}"; fi
❯ if ${install_clodius}; then pip install clodius; fi
Collecting clodius
  Downloading clodius-0.20.1-py2.py3-none-any.whl.metadata (3.1 kB)
Requirement already satisfied: click>=7 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (8.1.7)
Requirement already satisfied: cooler>0.9.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (0.9.3)
Requirement already satisfied: dask in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (2023.10.0)
Requirement already satisfied: h5py in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (3.10.0)
Collecting negspy (from clodius)
  Downloading negspy-0.2.24.tar.gz (1.7 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 8.0 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Requirement already satisfied: numpy in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (1.23.5)
Requirement already satisfied: pandas>=1.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (1.5.3)
Collecting pybbi>=0.2.0 (from clodius)
  Downloading pybbi-0.3.5-cp39-cp39-macosx_10_9_x86_64.whl.metadata (7.3 kB)
Collecting pydantic (from clodius)
  Downloading pydantic-2.4.2-py3-none-any.whl.metadata (158 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 158.6/158.6 kB 19.5 MB/s eta 0:00:00
Requirement already satisfied: pyfaidx in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (0.7.2.2)
Requirement already satisfied: pysam in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (0.22.0)
Requirement already satisfied: requests in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (2.31.0)
Collecting slugid (from clodius)
  Downloading slugid-2.0.0-py2.py3-none-any.whl (8.2 kB)
Requirement already satisfied: sortedcontainers in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from clodius) (2.4.0)
Collecting tqdm (from clodius)
  Downloading tqdm-4.66.1-py3-none-any.whl.metadata (57 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 57.6/57.6 kB 6.0 MB/s eta 0:00:00
Requirement already satisfied: asciitree in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (0.3.3)
Requirement already satisfied: cytoolz in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (0.12.2)
Requirement already satisfied: multiprocess in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (0.70.15)
Requirement already satisfied: pyyaml in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (6.0.1)
Requirement already satisfied: scipy>=0.16 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (1.11.3)
Requirement already satisfied: simplejson in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from cooler>0.9.0->clodius) (3.19.2)
Requirement already satisfied: python-dateutil>=2.8.1 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from pandas>=1.0->clodius) (2.8.2)
Requirement already satisfied: pytz>=2020.1 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from pandas>=1.0->clodius) (2023.3.post1)
Requirement already satisfied: cloudpickle>=1.5.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (3.0.0)
Requirement already satisfied: fsspec>=2021.09.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (2023.10.0)
Requirement already satisfied: packaging>=20.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (23.2)
Requirement already satisfied: partd>=1.2.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (1.4.1)
Requirement already satisfied: toolz>=0.10.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (0.12.0)
Requirement already satisfied: importlib-metadata>=4.13.0 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from dask->clodius) (6.8.0)
Collecting annotated-types>=0.4.0 (from pydantic->clodius)
  Downloading annotated_types-0.6.0-py3-none-any.whl.metadata (12 kB)
Collecting pydantic-core==2.10.1 (from pydantic->clodius)
  Downloading pydantic_core-2.10.1-cp39-cp39-macosx_10_7_x86_64.whl.metadata (6.5 kB)
Collecting typing-extensions>=4.6.1 (from pydantic->clodius)
  Downloading typing_extensions-4.8.0-py3-none-any.whl.metadata (3.0 kB)
Requirement already satisfied: six in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from pyfaidx->clodius) (1.16.0)
Requirement already satisfied: setuptools in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from pyfaidx->clodius) (68.2.2)
Requirement already satisfied: charset-normalizer<4,>=2 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from requests->clodius) (3.3.0)
Requirement already satisfied: idna<4,>=2.5 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from requests->clodius) (3.4)
Requirement already satisfied: urllib3<3,>=1.21.1 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from requests->clodius) (2.0.7)
Requirement already satisfied: certifi>=2017.4.17 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from requests->clodius) (2023.7.22)
Requirement already satisfied: zipp>=0.5 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from importlib-metadata>=4.13.0->dask->clodius) (3.17.0)
Requirement already satisfied: locket in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from partd>=1.2.0->dask->clodius) (1.0.0)
Requirement already satisfied: dill>=0.3.7 in /Users/kalavatt/mambaforge/envs/pairtools_env/lib/python3.9/site-packages (from multiprocess->cooler>0.9.0->clodius) (0.3.7)
Downloading clodius-0.20.1-py2.py3-none-any.whl (82 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 82.6/82.6 kB 10.7 MB/s eta 0:00:00
Downloading pybbi-0.3.5-cp39-cp39-macosx_10_9_x86_64.whl (2.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.5/2.5 MB 9.5 MB/s eta 0:00:00
Downloading pydantic-2.4.2-py3-none-any.whl (395 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 395.8/395.8 kB 15.6 MB/s eta 0:00:00
Downloading pydantic_core-2.10.1-cp39-cp39-macosx_10_7_x86_64.whl (1.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.9/1.9 MB 64.4 MB/s eta 0:00:00
Downloading tqdm-4.66.1-py3-none-any.whl (78 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.3/78.3 kB 5.5 MB/s eta 0:00:00
Downloading annotated_types-0.6.0-py3-none-any.whl (12 kB)
Downloading typing_extensions-4.8.0-py3-none-any.whl (31 kB)
Building wheels for collected packages: negspy
  Building wheel for negspy (setup.py) ... done
  Created wheel for negspy: filename=negspy-0.2.24-py3-none-any.whl size=1725344 sha256=6d7f9c74803cce9f60feeb7cb37163689306a719d162c70b5d21042c961bb3bb
  Stored in directory: /Users/kalavatt/Library/Caches/pip/wheels/44/2f/4b/b619e2ad6d52f174d31580951ee2002bcc1480426d38572268
Successfully built negspy
Installing collected packages: slugid, negspy, typing-extensions, tqdm, pybbi, annotated-types, pydantic-core, pydantic, clodius
Successfully installed annotated-types-0.6.0 clodius-0.20.1 negspy-0.2.24 pybbi-0.3.5 pydantic-2.4.2 pydantic-core-2.10.1 slugid-2.0.0 tqdm-4.66.1 typing-extensions-4.8.0
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

install_julia=false
if ${install_julia}; then
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
fi

install_atria=false
if ${install_atria}; then
    cd "${HOME}/2023_rDNA" || echo "cd'ing failed; check on this..."

    [[ ! -d software/ ]] && mkdir software/

    cd software/ || echo "cd'ing failed; check on this..."
    git clone "https://github.com/cihga39871/Atria.git"

    cd Atria/

    julia build_atria.jl
fi

alias_atria=false
if ${alias_atria}; then
    alias atria="\${HOME}/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/app-3.2.2/bin/atria"
    # atria
fi
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

install_higlass=true
if ${install_higlass}; then
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
fi
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
[[ "${install_clodius}" == TRUE ]] \
    && pip install clodius \
    || true

install_bedops=TRUE
[[ "${install_bedops}" == TRUE ]] \
    && mamba install -c bioconda bedops \
    || true
```
</details>
<br />
