
`#work_Micro-C_align-process.md`
<br />
<br />

<!-- MarkdownTOC -->

1. [Install packages necessary for processing Micro-c data](#install-packages-necessary-for-processing-micro-c-data)
    1. [Remote installation](#remote-installation)
        1. [Code](#code)
        1. [Printed](#printed)
    1. [Local installation](#local-installation)
        1. [Code](#code-1)
        1. [Printed](#printed-1)
1. [Work through the steps of \[pairtools\]\(\)](#work-through-the-steps-of-pairtools)
    1. [0. Get situated](#0-get-situated)
        1. [Get to work directory, initialize environment](#get-to-work-directory-initialize-environment)
            1. [Code](#code-2)
        1. [Initialize variables, create outdirectories](#initialize-variables-create-outdirectories)
            1. [Code](#code-3)
        1. [Printed](#printed-2)
    1. [1. Align datasets](#1-align-datasets)
        1. [Code](#code-4)
        1. [Printed](#printed-3)
    1. [2. Run pairtools parse](#2-run-pairtools-parse)
        1. [Code](#code-5)
        1. [Printed](#printed-4)
    1. [3. Run pairtools sort](#3-run-pairtools-sort)
        1. [Code](#code-6)
        1. [Printed](#printed-5)
    1. [4. Run pairtools dedup](#4-run-pairtools-dedup)
        1. [Code](#code-7)
        1. [Printed](#printed-6)
    1. [5. Run pairtools stats](#5-run-pairtools-stats)
        1. [Code](#code-8)
        1. [Printed](#printed-7)
    1. [6. Load pairs to cooler](#6-load-pairs-to-cooler)
        1. [Code](#code-9)
        1. [Printed](#printed-8)

<!-- /MarkdownTOC -->
<br />
<br />

<a id="install-packages-necessary-for-processing-micro-c-data"></a>
## Install packages necessary for processing Micro-c data
<a id="remote-installation"></a>
### Remote installation
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Remote installation</i></summary>

```bash
#!/bin/bash

mamba create \
    -n pairtools_env \
    -c conda-forge \
        parallel

source activate pairtools_env
mamba install \
    -c bioconda \
        bioframe cooler coolpuppy cooltools pairtools rename
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Remote installation</i></summary>

```txt
❯ mamba create \
>     -n pairtools_env \
>     -c conda-forge \
>         parallel

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


Looking for: ['parallel']

pkgs/main/linux-64                                   5.8MB @   4.9MB/s  1.5s
bioconda/linux-64                                    5.0MB @   3.2MB/s  1.7s
bioconda/noarch                                      4.3MB @   2.7MB/s  1.9s
pkgs/r/noarch                                                 No change
pkgs/r/linux-64                                      1.4MB @ 677.6kB/s  1.0s
pkgs/main/noarch                                   837.8kB @ 378.3kB/s  0.7s
conda-forge/noarch                                  12.5MB @   3.9MB/s  3.6s
conda-forge/linux-64                                32.1MB @   4.3MB/s  8.6s
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/pairtools_env

  Updating specs:

   - parallel


  Package           Version  Build             Channel                    Size
────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex       0.1  conda_forge       conda-forge/linux-64     Cached
  + _openmp_mutex       4.5  2_gnu             conda-forge/linux-64     Cached
  + libgcc-ng        13.1.0  he5830b7_0        conda-forge/linux-64     Cached
  + libgomp          13.1.0  he5830b7_0        conda-forge/linux-64     Cached
  + libnsl            2.0.0  h7f98852_0        conda-forge/linux-64     Cached
  + parallel       20230522  ha770c72_0        conda-forge/linux-64     Cached
  + perl             5.32.1  2_h7f98852_perl5  conda-forge/linux-64     Cached

  Summary:

  Install: 7 packages

  Total download: 0 B

────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate pairtools_env

To deactivate an active environment, use

     $ mamba deactivate


❯ source activate pairtools_env


❯ mamba install \
>     -c bioconda \
>         bioframe cooler coolpuppy cooltools pairtools rename

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


Looking for: ['bioframe', 'cooler', 'coolpuppy', 'cooltools', 'pairtools', 'rename']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/linux-64                                            No change
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/pairtools_env

  Updating specs:

   - bioframe
   - cooler
   - coolpuppy
   - cooltools
   - pairtools
   - rename


  Package                         Version  Build                    Channel                    Size
─────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  + aom                             3.5.0  h27087fc_0               conda-forge/linux-64        3MB
  + asciitree                       0.3.3  py_2                     conda-forge/noarch          6kB
  + aws-c-auth                     0.6.27  he072965_1               conda-forge/linux-64      102kB
  + aws-c-cal                      0.5.26  hf677bf3_1               conda-forge/linux-64       50kB
  + aws-c-common                   0.8.19  hd590300_0               conda-forge/linux-64      196kB
  + aws-c-compression              0.2.16  hbad4bc6_7               conda-forge/linux-64       19kB
  + aws-c-event-stream             0.2.20  hb4b372c_7               conda-forge/linux-64       54kB
  + aws-c-http                      0.7.7  h2632f9a_4               conda-forge/linux-64      192kB
  + aws-c-io                      0.13.21  h9fef7b8_5               conda-forge/linux-64      140kB
  + aws-c-mqtt                     0.8.11  h2282364_1               conda-forge/linux-64      148kB
  + aws-c-s3                        0.3.0  hcb5a9b2_2               conda-forge/linux-64       76kB
  + aws-c-sdkutils                  0.1.9  hbad4bc6_2               conda-forge/linux-64       54kB
  + aws-checksums                  0.1.14  hbad4bc6_7               conda-forge/linux-64       50kB
  + aws-crt-cpp                    0.20.2  he0fdcb3_0               conda-forge/linux-64      319kB
  + aws-sdk-cpp                   1.10.57  h059227d_13              conda-forge/linux-64        4MB
  + bioframe                        0.4.1  pyhdfd78af_0             bioconda/noarch           100kB
  + biopython                        1.81  py310h1fa729e_0          conda-forge/linux-64        3MB
  + blosc                          1.21.4  h0f2a231_0               conda-forge/linux-64       49kB
  + bokeh                           3.1.1  pyhd8ed1ab_0             conda-forge/noarch          6MB
  + brotli                          1.0.9  h166bdaf_8               conda-forge/linux-64     Cached
  + brotli-bin                      1.0.9  h166bdaf_8               conda-forge/linux-64     Cached
  + brunsli                           0.1  h9c3ff4c_0               conda-forge/linux-64      205kB
  + bzip2                           1.0.8  h7f98852_4               conda-forge/linux-64     Cached
  + c-ares                         1.19.1  hd590300_0               conda-forge/linux-64     Cached
  + c-blosc2                        2.9.2  hb4ffafa_0               conda-forge/linux-64      305kB
  + ca-certificates              2023.5.7  hbcca054_0               conda-forge/linux-64     Cached
  + cached-property                 1.5.2  hd8ed1ab_1               conda-forge/noarch          4kB
  + cached_property                 1.5.2  pyha770c72_1             conda-forge/noarch         11kB
  + certifi                      2023.5.7  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + cfitsio                         4.2.0  hd9d235c_0               conda-forge/linux-64      848kB
  + charls                          2.4.2  h59595ed_0               conda-forge/linux-64      150kB
  + charset-normalizer              3.1.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + click                           8.1.3  unix_pyhd8ed1ab_2        conda-forge/noarch         76kB
  + cloudpickle                     2.2.1  pyhd8ed1ab_0             conda-forge/noarch         28kB
  + contourpy                       1.0.7  py310hdf3cbec_0          conda-forge/linux-64     Cached
  + cooler                          0.9.2  pyh7cba7a3_0             bioconda/noarch            85kB
  + coolpuppy                       1.0.0  pyh086e186_0             bioconda/noarch            43kB
  + cooltools                       0.5.4  py310h4b81fae_1          bioconda/linux-64         294kB
  + coreutils                        8.25  1                        bioconda/linux-64          10MB
  + cycler                         0.11.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + cytoolz                        0.12.0  py310h5764c6d_1          conda-forge/linux-64      398kB
  + dask                         2023.6.0  pyhd8ed1ab_0             conda-forge/noarch          7kB
  + dask-core                    2023.6.0  pyhd8ed1ab_0             conda-forge/noarch        846kB
  + dav1d                           1.2.1  hd590300_0               conda-forge/linux-64      760kB
  + dill                            0.3.6  pyhd8ed1ab_1             conda-forge/noarch         83kB
  + distributed                  2023.6.0  pyhd8ed1ab_0             conda-forge/noarch        775kB
  + docutils                       0.20.1  py310hff52083_0          conda-forge/linux-64      721kB
  + fonttools                      4.39.4  py310h2372a71_0          conda-forge/linux-64        2MB
  + freetype                       2.12.1  hca18f0e_1               conda-forge/linux-64     Cached
  + fsspec                       2023.6.0  pyh1a96a4e_0             conda-forge/noarch        118kB
  + gflags                          2.2.2  he1b5a44_1004            conda-forge/linux-64      117kB
  + giflib                          5.2.1  h0b41bf4_3               conda-forge/linux-64       77kB
  + glog                            0.6.0  h6f12383_0               conda-forge/linux-64      114kB
  + h5py                            3.8.0  nompi_py310ha66b2ad_101  conda-forge/linux-64        1MB
  + h5sparse                        0.1.0  pyh086e186_0             bioconda/noarch            12kB
  + hdf5                           1.14.0  nompi_hb72d44e_103       conda-forge/linux-64        4MB
  + htslib                           1.17  h81da01d_2               bioconda/linux-64           3MB
  + idna                              3.4  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + imagecodecs                 2023.1.23  py310h241fb82_2          conda-forge/linux-64        2MB
  + imageio                        2.28.1  pyh24c5eb1_0             conda-forge/noarch          3MB
  + importlib-metadata              6.6.0  pyha770c72_0             conda-forge/noarch         26kB
  + importlib_metadata              6.6.0  hd8ed1ab_0               conda-forge/noarch          9kB
  + jinja2                          3.1.2  pyhd8ed1ab_1             conda-forge/noarch        101kB
  + joblib                          1.2.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + jxrlib                            1.1  h7f98852_2               conda-forge/linux-64      241kB
  + keyutils                        1.6.1  h166bdaf_0               conda-forge/linux-64     Cached
  + kiwisolver                      1.4.4  py310hbf28c38_1          conda-forge/linux-64     Cached
  + krb5                           1.20.1  h81ceb04_0               conda-forge/linux-64     Cached
  + lazy_loader                       0.2  pyhd8ed1ab_0             conda-forge/noarch         14kB
  + lcms2                            2.15  haa2dc70_1               conda-forge/linux-64      242kB
  + ld_impl_linux-64                 2.40  h41732ed_0               conda-forge/linux-64     Cached
  + lerc                            4.0.0  h27087fc_0               conda-forge/linux-64     Cached
  + libabseil                  20230125.2  cxx17_h59595ed_2         conda-forge/linux-64        1MB
  + libaec                          1.0.6  hcb278e6_1               conda-forge/linux-64       34kB
  + libarrow                       12.0.0  hed73b3e_7_cpu           conda-forge/linux-64       28MB
  + libavif                        0.11.1  h8182462_2               conda-forge/linux-64      102kB
  + libblas                         3.9.0  17_linux64_openblas      conda-forge/linux-64       14kB
  + libbrotlicommon                 1.0.9  h166bdaf_8               conda-forge/linux-64     Cached
  + libbrotlidec                    1.0.9  h166bdaf_8               conda-forge/linux-64     Cached
  + libbrotlienc                    1.0.9  h166bdaf_8               conda-forge/linux-64     Cached
  + libcblas                        3.9.0  17_linux64_openblas      conda-forge/linux-64       14kB
  + libcrc32c                       1.1.2  h9c3ff4c_0               conda-forge/linux-64       20kB
  + libcurl                         8.1.2  h409715c_0               conda-forge/linux-64     Cached
  + libdeflate                       1.18  h0b41bf4_0               conda-forge/linux-64     Cached
  + libedit                  3.1.20191231  he28a2e2_2               conda-forge/linux-64     Cached
  + libev                            4.33  h516909a_1               conda-forge/linux-64     Cached
  + libevent                       2.1.12  hf998b51_1               conda-forge/linux-64      427kB
  + libffi                          3.4.2  h7f98852_5               conda-forge/linux-64     Cached
  + libgcc                          7.2.0  h69d50b8_2               conda-forge/linux-64     Cached
  + libgfortran-ng                 13.1.0  h69a702a_0               conda-forge/linux-64       23kB
  + libgfortran5                   13.1.0  h15d22d2_0               conda-forge/linux-64        1MB
  + libgoogle-cloud                2.11.0  hac9eb74_1               conda-forge/linux-64       40MB
  + libgrpc                        1.54.2  hb20ce57_2               conda-forge/linux-64        6MB
  + libjpeg-turbo                 2.1.5.1  h0b41bf4_0               conda-forge/linux-64     Cached
  + liblapack                       3.9.0  17_linux64_openblas      conda-forge/linux-64       14kB
  + libllvm14                      14.0.6  hcd5def8_3               conda-forge/linux-64       31MB
  + libnghttp2                     1.52.0  h61bc06f_0               conda-forge/linux-64     Cached
  + libnuma                        2.0.16  h0b41bf4_1               conda-forge/linux-64       41kB
  + libopenblas                    0.3.23  pthreads_h80387f5_0      conda-forge/linux-64        5MB
  + libpng                         1.6.39  h753d276_0               conda-forge/linux-64     Cached
  + libprotobuf                   3.21.12  h3eb15da_0               conda-forge/linux-64        2MB
  + libsqlite                      3.42.0  h2797004_0               conda-forge/linux-64     Cached
  + libssh2                        1.11.0  h0841786_0               conda-forge/linux-64     Cached
  + libstdcxx-ng                   13.1.0  hfd8a6a1_0               conda-forge/linux-64     Cached
  + libthrift                      0.18.1  h8fd135c_2               conda-forge/linux-64        4MB
  + libtiff                         4.5.0  ha587672_6               conda-forge/linux-64     Cached
  + libutf8proc                     2.8.0  h166bdaf_0               conda-forge/linux-64      101kB
  + libuuid                        2.38.1  h0b41bf4_0               conda-forge/linux-64     Cached
  + libwebp-base                    1.3.0  h0b41bf4_0               conda-forge/linux-64     Cached
  + libxcb                           1.15  h0b41bf4_0               conda-forge/linux-64      384kB
  + libzlib                        1.2.13  h166bdaf_4               conda-forge/linux-64     Cached
  + libzopfli                       1.0.3  h9c3ff4c_0               conda-forge/linux-64      168kB
  + llvmlite                       0.40.0  py310h1b8f574_0          conda-forge/linux-64        3MB
  + locket                          1.0.0  pyhd8ed1ab_0             conda-forge/noarch          8kB
  + lz4                             4.3.2  py310h0cfdcf0_0          conda-forge/linux-64       37kB
  + lz4-c                           1.9.4  hcb278e6_0               conda-forge/linux-64     Cached
  + lzo                              2.10  h516909a_1000            conda-forge/linux-64     Cached
  + m2r2                      0.3.3.post2  pyhd8ed1ab_0             conda-forge/noarch         16kB
  + markupsafe                      2.1.3  py310h2372a71_0          conda-forge/linux-64       24kB
  + matplotlib-base                 3.7.1  py310he60537e_0          conda-forge/linux-64     Cached
  + mistune                         0.8.4  pyh1a96a4e_1006          conda-forge/noarch         48kB
  + more-itertools                  9.1.0  pyhd8ed1ab_0             conda-forge/noarch         52kB
  + msgpack-python                  1.0.5  py310hdf3cbec_0          conda-forge/linux-64       85kB
  + multiprocess                  0.70.14  py310h5764c6d_3          conda-forge/linux-64      228kB
  + multiprocessing-logging         0.3.3  pyhd8ed1ab_0             conda-forge/noarch         13kB
  + munkres                         1.0.7  py_1                     bioconda/noarch          Cached
  + natsort                         8.3.1  pyhd8ed1ab_0             conda-forge/noarch         37kB
  + ncurses                           6.4  hcb278e6_0               conda-forge/linux-64     Cached
  + networkx                          3.1  pyhd8ed1ab_0             conda-forge/noarch          1MB
  + nomkl                             1.0  h5ca1d4c_0               conda-forge/noarch       Cached
  + numba                          0.57.0  py310h0f6aa51_1          conda-forge/linux-64        4MB
  + numexpr                         2.8.4  py310h690d005_100        conda-forge/linux-64      129kB
  + numpy                          1.23.5  py310h53a5b5f_0          conda-forge/linux-64     Cached
  + openjpeg                        2.5.0  hfec8fc6_2               conda-forge/linux-64      352kB
  + openssl                         3.1.1  hd590300_1               conda-forge/linux-64     Cached
  + orc                             1.8.3  h2f23424_1               conda-forge/linux-64      930kB
  + packaging                        23.1  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pairix                          0.3.7  py310h83093d7_5          bioconda/linux-64         104kB
  + pairtools                       1.0.2  py310hb45ccb3_1          bioconda/linux-64         269kB
  + pandas                          2.0.2  py310h7cbd5c2_0          conda-forge/linux-64       12MB
  + partd                           1.4.0  pyhd8ed1ab_0             conda-forge/noarch         20kB
  + patsy                           0.5.3  pyhd8ed1ab_0             conda-forge/noarch        194kB
  + pbgzip                     2016.08.04  h9d449c0_4               bioconda/linux-64          94kB
  + pillow                          9.5.0  py310h582fbeb_1          conda-forge/linux-64       46MB
  + pip                            23.1.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + platformdirs                    3.5.3  pyhd8ed1ab_0             conda-forge/noarch         19kB
  + pooch                           1.7.0  pyha770c72_3             conda-forge/noarch       Cached
  + psutil                          5.9.5  py310h1fa729e_0          conda-forge/linux-64      362kB
  + pthread-stubs                     0.4  h36c2ea0_1001            conda-forge/linux-64     Cached
  + py-cpuinfo                      9.0.0  pyhd8ed1ab_0             conda-forge/noarch         25kB
  + pyarrow                        12.0.0  py310he6bfd7f_7_cpu      conda-forge/linux-64        4MB
  + pyfaidx                       0.7.2.1  pyh7cba7a3_1             bioconda/noarch            33kB
  + pyparsing                       3.0.9  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + pysam                          0.21.0  py310h41dec4a_1          bioconda/linux-64           4MB
  + pysocks                         1.7.1  pyha2e5f31_6             conda-forge/noarch       Cached
  + pytables                        3.8.0  py310hde6a235_1          conda-forge/linux-64        2MB
  + python                        3.10.11  he550d4f_0_cpython       conda-forge/linux-64       26MB
  + python-dateutil                 2.8.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + python-tzdata                  2023.3  pyhd8ed1ab_0             conda-forge/noarch        143kB
  + python_abi                       3.10  3_cp310                  conda-forge/linux-64     Cached
  + pytz                           2023.3  pyhd8ed1ab_0             conda-forge/noarch        187kB
  + pyvcf3                          1.0.3  pyhdfd78af_0             bioconda/noarch          Cached
  + pywavelets                      1.4.1  py310h0a54255_0          conda-forge/linux-64        4MB
  + pyyaml                            6.0  py310h5764c6d_5          conda-forge/linux-64     Cached
  + rdma-core                        28.9  h59595ed_1               conda-forge/linux-64        4MB
  + re2                        2023.03.02  h8c504da_0               conda-forge/linux-64      201kB
  + readline                          8.2  h8228510_1               conda-forge/linux-64     Cached
  + rename                          1.601  hdfd78af_1               bioconda/noarch          Cached
  + requests                       2.31.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + s2n                            1.3.44  h06160fa_0               conda-forge/linux-64      368kB
  + samtools                         1.17  hd87286a_1               bioconda/linux-64         460kB
  + scikit-image                   0.20.0  py310h9b08913_1          conda-forge/linux-64       10MB
  + scikit-learn                    1.2.2  py310hf7d194e_2          conda-forge/linux-64        8MB
  + scipy                          1.10.1  py310ha4c1d20_3          conda-forge/linux-64       15MB
  + seaborn                        0.12.2  hd8ed1ab_0               conda-forge/noarch          6kB
  + seaborn-base                   0.12.2  pyhd8ed1ab_0             conda-forge/noarch        232kB
  + setuptools                     67.7.2  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + simplejson                     3.19.1  py310h1fa729e_0          conda-forge/linux-64      109kB
  + six                            1.16.0  pyh6c4a22f_0             conda-forge/noarch       Cached
  + snappy                         1.1.10  h9fff704_0               conda-forge/linux-64       39kB
  + sortedcontainers                2.4.0  pyhd8ed1ab_0             conda-forge/noarch         26kB
  + statsmodels                    0.14.0  py310h278f3c1_1          conda-forge/linux-64       11MB
  + tblib                           1.7.0  pyhd8ed1ab_0             conda-forge/noarch         15kB
  + threadpoolctl                   3.1.0  pyh8a188c0_0             conda-forge/noarch         18kB
  + tifffile                    2023.4.12  pyhd8ed1ab_0             conda-forge/noarch        175kB
  + tk                             8.6.12  h27826a3_0               conda-forge/linux-64     Cached
  + toolz                          0.12.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + tornado                         6.3.2  py310h2372a71_0          conda-forge/linux-64      639kB
  + typing-extensions               4.6.3  hd8ed1ab_0               conda-forge/noarch         10kB
  + typing_extensions               4.6.3  pyha770c72_0             conda-forge/noarch         35kB
  + tzdata                          2023c  h71feb2d_0               conda-forge/noarch       Cached
  + ucx                            1.14.1  hf587318_2               conda-forge/linux-64       17MB
  + unicodedata2                   15.0.0  py310h5764c6d_0          conda-forge/linux-64     Cached
  + urllib3                         2.0.3  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + wheel                          0.40.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + xorg-libxau                    1.0.11  hd590300_0               conda-forge/linux-64       14kB
  + xorg-libxdmcp                   1.1.3  h7f98852_0               conda-forge/linux-64     Cached
  + xyzservices                  2023.5.0  pyhd8ed1ab_1             conda-forge/noarch         36kB
  + xz                              5.2.6  h166bdaf_0               conda-forge/linux-64     Cached
  + yaml                            0.2.5  h7f98852_2               conda-forge/linux-64     Cached
  + zfp                             1.0.0  h27087fc_3               conda-forge/linux-64      292kB
  + zict                            3.0.0  pyhd8ed1ab_0             conda-forge/noarch         36kB
  + zipp                           3.15.0  pyhd8ed1ab_0             conda-forge/noarch       Cached
  + zlib                           1.2.13  h166bdaf_4               conda-forge/linux-64     Cached
  + zlib-ng                         2.0.7  h0b41bf4_0               conda-forge/linux-64       95kB
  + zstd                            1.5.2  h3eb15da_6               conda-forge/linux-64     Cached

  Summary:

  Install: 206 packages

  Total download: 344MB

─────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libgfortran5                                         1.4MB @  16.8MB/s  0.1s
xorg-libxau                                         14.5kB @ 153.6kB/s  0.1s
libutf8proc                                        101.1kB @   1.0MB/s  0.1s
aws-c-common                                       196.0kB @   1.4MB/s  0.2s
libzopfli                                          168.1kB @   1.1MB/s  0.1s
giflib                                              77.4kB @ 464.0kB/s  0.2s
charls                                             150.3kB @ 825.7kB/s  0.1s
libabseil                                            1.2MB @   6.2MB/s  0.1s
gflags                                             116.5kB @ 579.8kB/s  0.1s
snappy                                              38.9kB @ 192.0kB/s  0.1s
aws-c-compression                                   18.9kB @  77.3kB/s  0.1s
aws-c-sdkutils                                      53.6kB @ 196.3kB/s  0.1s
aws-checksums                                       50.2kB @ 183.0kB/s  0.1s
libxcb                                             384.2kB @   1.2MB/s  0.1s
libevent                                           427.4kB @   1.3MB/s  0.1s
s2n                                                368.0kB @   1.1MB/s  0.1s
aws-c-cal                                           50.1kB @ 145.4kB/s  0.1s
aws-c-event-stream                                  53.7kB @ 128.5kB/s  0.1s
cfitsio                                            848.0kB @   2.0MB/s  0.1s
hdf5                                                 3.6MB @   7.5MB/s  0.1s
networkx                                             1.5MB @   2.8MB/s  0.0s
pbgzip                                              94.5kB @ 166.2kB/s  0.1s
xyzservices                                         36.3kB @  63.5kB/s  0.1s
tblib                                               15.4kB @  24.2kB/s  0.1s
sortedcontainers                                    26.3kB @  41.1kB/s  0.1s
ucx                                                 16.6MB @  25.0MB/s  0.5s
mistune                                             47.8kB @  69.6kB/s  0.1s
typing_extensions                                   34.9kB @  50.7kB/s  0.1s
more-itertools                                      51.6kB @  69.1kB/s  0.1s
cached-property                                      4.1kB @   5.5kB/s  0.1s
importlib-metadata                                  25.8kB @  34.5kB/s  0.1s
markupsafe                                          23.9kB @  28.7kB/s  0.1s
cytoolz                                            397.8kB @ 456.7kB/s  0.0s
llvmlite                                             2.5MB @   2.8MB/s  0.2s
coreutils                                            9.6MB @  10.3MB/s  0.5s
pywavelets                                           3.7MB @   3.7MB/s  0.1s
numba                                                4.2MB @   4.1MB/s  0.1s
scikit-learn                                         7.7MB @   6.9MB/s  0.2s
m2r2                                                16.5kB @  14.4kB/s  0.1s
patsy                                              193.6kB @ 169.0kB/s  0.0s
h5sparse                                            12.2kB @  10.4kB/s  0.2s
dask                                                 7.5kB @   6.3kB/s  0.0s
fonttools                                            2.2MB @   1.8MB/s  0.1s
libgoogle-cloud                                     39.5MB @  31.9MB/s  0.9s
cooler                                              84.6kB @  65.8kB/s  0.1s
rdma-core                                            3.7MB @   2.8MB/s  0.1s
re2                                                201.2kB @ 146.8kB/s  0.1s
aom                                                  2.9MB @   2.1MB/s  0.1s
libavif                                            102.2kB @  72.4kB/s  0.0s
c-blosc2                                           305.3kB @ 216.2kB/s  0.0s
pillow                                              46.1MB @  32.6MB/s  0.7s
coolpuppy                                           43.3kB @  30.6kB/s  0.2s
bioframe                                           100.2kB @  69.6kB/s  0.3s
aws-c-io                                           140.4kB @  95.6kB/s  0.0s
libgrpc                                              5.7MB @   3.8MB/s  0.1s
aws-c-s3                                            75.8kB @  51.3kB/s  0.0s
libopenblas                                          5.4MB @   3.6MB/s  0.1s
libthrift                                            3.6MB @   2.3MB/s  0.1s
samtools                                           459.9kB @ 299.2kB/s  0.1s
pytz                                               186.5kB @ 120.9kB/s  0.1s
fsspec                                             118.3kB @  74.9kB/s  0.0s
zict                                                36.3kB @  23.0kB/s  0.0s
locket                                               8.2kB @   5.2kB/s  0.0s
partd                                               20.5kB @  12.8kB/s  0.0s
typing-extensions                                   10.0kB @   6.3kB/s  0.0s
natsort                                             37.0kB @  22.9kB/s  0.0s
numexpr                                            128.8kB @  79.4kB/s  0.0s
h5py                                                 1.1MB @ 693.9kB/s  0.1s
libarrow                                            27.6MB @  16.3MB/s  0.4s
imageio                                              3.3MB @   1.9MB/s  0.2s
distributed                                        774.8kB @ 407.9kB/s  0.2s
scipy                                               15.1MB @   7.9MB/s  0.3s
bokeh                                                5.9MB @   3.0MB/s  0.3s
seaborn-base                                       231.9kB @ 118.2kB/s  0.1s
zlib-ng                                             94.6kB @  47.2kB/s  0.1s
libcrc32c                                           20.4kB @  10.1kB/s  0.0s
zfp                                                292.1kB @ 144.0kB/s  0.0s
python                                              25.9MB @  12.8MB/s  0.7s
libaec                                              34.4kB @  15.8kB/s  0.2s
lcms2                                              242.1kB @ 110.7kB/s  0.2s
libblas                                             14.5kB @   6.6kB/s  0.2s
pysam                                                4.3MB @   2.0MB/s  0.6s
aws-c-http                                         191.7kB @  86.8kB/s  0.0s
aws-c-mqtt                                         147.7kB @  66.7kB/s  0.0s
aws-c-auth                                         102.2kB @  46.2kB/s  0.0s
brunsli                                            204.9kB @  92.2kB/s  0.0s
python-tzdata                                      143.1kB @  64.3kB/s  0.0s
multiprocessing-logging                             13.4kB @   6.0kB/s  0.0s
platformdirs                                        18.8kB @   8.4kB/s  0.0s
simplejson                                         108.6kB @  48.6kB/s  0.0s
multiprocess                                       228.0kB @ 101.5kB/s  0.0s
pyfaidx                                             33.0kB @  14.6kB/s  0.1s
jinja2                                             101.4kB @  45.0kB/s  0.1s
imagecodecs                                          1.7MB @ 747.2kB/s  0.1s
libnuma                                             41.1kB @  17.8kB/s  0.0s
orc                                                930.3kB @ 396.6kB/s  0.1s
liblapack                                           14.4kB @   6.1kB/s  0.0s
pairix                                             104.1kB @  44.3kB/s  0.1s
cached_property                                     11.1kB @   4.7kB/s  0.0s
htslib                                               2.6MB @   1.1MB/s  0.0s
lazy_loader                                         13.8kB @   5.8kB/s  0.0s
importlib_metadata                                   9.4kB @   3.9kB/s  0.0s
psutil                                             362.3kB @ 150.4kB/s  0.0s
tifffile                                           174.8kB @  71.8kB/s  0.0s
docutils                                           721.2kB @ 295.6kB/s  0.1s
pandas                                              12.2MB @   4.9MB/s  0.1s
libprotobuf                                          2.2MB @ 859.5kB/s  0.1s
cooltools                                          293.6kB @ 114.3kB/s  0.3s
blosc                                               48.7kB @  18.9kB/s  0.0s
libllvm14                                           31.4MB @  12.1MB/s  0.5s
aws-crt-cpp                                        318.5kB @ 115.4kB/s  0.2s
dill                                                82.7kB @  30.0kB/s  0.2s
py-cpuinfo                                          24.9kB @   9.0kB/s  0.2s
lz4                                                 36.9kB @  13.4kB/s  0.2s
pairtools                                          269.3kB @  97.3kB/s  0.4s
dask-core                                          846.0kB @ 302.0kB/s  0.0s
pytables                                             2.0MB @ 698.3kB/s  0.1s
dav1d                                              760.2kB @ 268.6kB/s  0.0s
click                                               76.0kB @  26.9kB/s  0.0s
biopython                                            2.8MB @ 970.6kB/s  0.1s
msgpack-python                                      84.8kB @  29.5kB/s  0.1s
pyarrow                                              3.9MB @   1.4MB/s  0.1s
jxrlib                                             240.9kB @  82.1kB/s  0.0s
libgfortran-ng                                      23.2kB @   7.9kB/s  0.0s
openjpeg                                           352.0kB @ 119.1kB/s  0.0s
aws-sdk-cpp                                          4.1MB @   1.4MB/s  0.1s
scikit-image                                        10.4MB @   3.5MB/s  0.2s
statsmodels                                         10.5MB @   3.6MB/s  0.3s
libcblas                                            14.4kB @   4.7kB/s  0.2s
tornado                                            638.9kB @ 206.2kB/s  0.1s
seaborn                                              6.3kB @   2.0kB/s  0.1s
glog                                               114.3kB @  36.7kB/s  0.0s
cloudpickle                                         27.9kB @   9.0kB/s  0.0s
threadpoolctl                                       18.3kB @   5.8kB/s  0.1s
asciitree                                            6.2kB @   2.0kB/s  0.0s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="local-installation"></a>
### Local installation
*bioconda installs not working configuring conda environment for work with osx-64; [troubleshoot this later](https://www.google.com/search?q=how+to+use+bioconda+with+apple+m1&oq=how+to+use+bioconda+with+apple+m1&aqs=chrome..69i57j33i160l2.5494j1j4&sourceid=chrome&ie=UTF-8)*

<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Local installation</i></summary>

```bash
#!/bin/bash

create_x86_conda_environment pairtools_env
conda activate pairtools_env

conda install \
    -c conda-forge \
    parallel mamba python==3.10.11

mamba install \
    -c bioconda \
        bioframe cooler coolpuppy cooltools pairtools rename
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Local installation</i></summary>

```txt

```
</details>
<br />
<br />

<a id="work-through-the-steps-of-pairtools"></a>
## Work through the steps of [pairtools]()
<a id="0-get-situated"></a>
### 0. Get situated
<a id="get-to-work-directory-initialize-environment"></a>
#### Get to work directory, initialize environment
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Get to work directory, initialize environment</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307" ||
    echo "cd'ing failed; check on this..."

source activate pairtools_env
```
</details>
<br />

<a id="initialize-variables-create-outdirectories"></a>
#### Initialize variables, create outdirectories
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Initialize variables, create outdirectories</i></summary>

```bash
p_fq="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742"  # ., "${p_fq}"
f_fq="SRR7939018"  # ., "${p_fq}/${f_fq}"*
a_fq_1="${p_fq}/${f_fq}_1.fastq.gz"  # ., "${a_fq_1}"
a_fq_2="${p_fq}/${f_fq}_2.fastq.gz"  # ., "${a_fq_2}"

d_bam="bams"  # echo "${d_bam}"
f_bam="${f_fq}.bam"  # echo "${f_bam}"
a_bam="${d_bam}/${f_bam}"  # echo "${a_bam}"

p_index="${HOME}/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa"  # ., "${p_index}"
f_index="S288C_R64-3-1.fa"  # ., "${p_index}/${f_index}"*
a_index="${p_index}/${f_index}"  # ., "${a_index}"*

p_size="${HOME}/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed"  # .,s "${p_size}"
f_size="S288C_reference_sequence_R64-3-1_20210421.size"  # ., "${p_size}/${f_size}"
a_size="${p_size}/${f_size}"  # ., "${a_size}"

d_pairs="pairs"  # echo "${d_pairs}"
f_pairs="${f_fq}.txt.gz"  # echo "${f_pairs}"
a_pairs="${d_pairs}/${f_pairs}"  # echo "${a_pairs}"

d_stats="stats"  # echo "${d_stats}"
f_stats="${f_fq}.stats.txt"  # echo "${f_stats}"
a_stats="${d_stats}/${f_stats}"  # echo "${a_stats}"

assembly="S288C_R64-3-1"  # echo "${assembly}"

if [[ ! -d "${d_bam}" ]]; then mkdir -p "${d_bam}/err_out"; fi
if [[ ! -d "${d_pairs}" ]]; then mkdir -p "${d_pairs}/err_out"; fi
if [[ ! -d "${d_stats}" ]]; then mkdir -p "${d_stats}"; fi
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Initialize variables, create outdirectories</i></summary>

```txt
❯ if [[ ! -d "${d_bam}" ]]; then mkdir -p "${d_bam}/err_out"; fi
mkdir: created directory 'bams'
mkdir: created directory 'bams/err_out'


❯ if [[ ! -d "${d_pairs}" ]]; then mkdir -p "${d_pairs}/err_out"; fi
mkdir: created directory 'pairs'
mkdir: created directory 'pairs/err_out'


❯ if [[ ! -d "${d_stats}" ]]; then mkdir -p "${d_stats}"; fi
mkdir: created directory 'stats'
```
</details>
<br />

<a id="1-align-datasets"></a>
### 1. Align datasets
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: 1. Align datasets</i></summary>

```bash
#!/bin/bash

module purge
ml BWA/0.7.17-GCCcore-11.2.0 SAMtools/1.16.1-GCC-11.2.0

#  pairtools parse expects unsorted bams:
#+ github.com/open2c/pairtools/issues/178#issuecomment-1554866847
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        echo """
        {
            bwa mem \\
                -t \"${SLURM_CPUS_ON_NODE}\" \\
                -SP \"${a_index}\" \"${a_fq_1}\" \"${a_fq_2}\" \\
                    | samtools sort \\
                        -@ ${SLURM_CPUS_ON_NODE} \\
                        -O bam \\
                        -o \"${a_bam}\"
            
            if [[ -f \"${a_bam}\" ]]; then
                samtools index \\
                    -@ ${SLURM_CPUS_ON_NODE} \\
                    \"${a_bam}\"
            fi
        } \\
            2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
        """

        {
            bwa mem \
                -t "${SLURM_CPUS_ON_NODE}" \
                -SP "${a_index}" "${a_fq_1}" "${a_fq_2}" \
                    | samtools sort \
                        -@ ${SLURM_CPUS_ON_NODE} \
                        -O bam \
                        -o "${a_bam}"

            if [[ -f "${a_bam}" ]]; then
                samtools index \
                    -@ "${SLURM_CPUS_ON_NODE}" \
                    "${a_bam}"
            fi
        } \
            2> >(tee -a "${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt" >&2)
    }

run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        echo """
        {
            bwa mem \\
                -t \"${SLURM_CPUS_ON_NODE}\" \\
                -SP \\
                \"${a_index}\" \\
                \"${a_fq_1}\" \\
                \"${a_fq_2}\" \\
                    | samtools view -@ ${SLURM_CPUS_ON_NODE} -S -b > \"${a_bam}\"
        } \\
            2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
        """

        {
            bwa mem \
                -t "${SLURM_CPUS_ON_NODE}" \
                -SP \
                "${a_index}" \
                "${a_fq_1}" \
                "${a_fq_2}" \
                    | samtools view -@ ${SLURM_CPUS_ON_NODE} -S -b > "${a_bam}"
        } \
            2> >(tee "${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt" >&2)
    }
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: 1. Align datasets</i></summary>

```txt
❯ module purge


❯ ml BWA/0.7.17-GCCcore-11.2.0 SAMtools/1.16.1-GCC-11.2.0


❯ echo """
> {
>     bwa mem \\
>         -t \"${SLURM_CPUS_ON_NODE}\" \\
>         -SP \"${a_index}\" \"${a_fq_1}\" \"${a_fq_2}\" \\
>             | samtools sort \\
>                 -@ ${SLURM_CPUS_ON_NODE} \\
>                 -O bam \\
>                 -o \"${a_bam}\"
> 
>     if [[ -f \"${a_bam}\" ]]; then
>         samtools index \\
>             -@ ${SLURM_CPUS_ON_NODE} \\
>             \"${a_bam}\"
>     fi
> } \\
>     2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
> """

❯ [[ "${run}" == TRUE ]] &&
>     {
>         echo """
>         {
>             bwa mem \\
>                 -t \"${SLURM_CPUS_ON_NODE}\" \\
>                 -SP \\
>                 \"${a_index}\" \\
>                 \"${a_fq_1}\" \\
>                 \"${a_fq_2}\" \\
>                     | samtools view -@ ${SLURM_CPUS_ON_NODE} -S -b > \"${a_bam}\"
>         } \\
>             2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
>         """
> 
>         {
>             bwa mem \
>                 -t "${SLURM_CPUS_ON_NODE}" \
>                 -SP \
>                 "${a_index}" \
>                 "${a_fq_1}" \
>                 "${a_fq_2}" \
>                     | samtools view -@ ${SLURM_CPUS_ON_NODE} -S -b > "${a_bam}"
>         } \
>             2> >(tee "${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt" >&2)
>     }

        {
            bwa mem \
                -t "16" \
                -SP \
                "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
                "/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz" \
                "/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz" \
                    | samtools view -@ 16 -S -b > "bams/SRR7939018.bam"
        } \
            2> >(tee "bams/err_out/SRR7939018.stderr.txt" >&2)

[M::bwa_idx_load_from_disk] read 0 ALT contigs
*(see stderr txt file)*
```
</details>
<br />

<a id="2-run-pairtools-parse"></a>
### 2. Run pairtools parse
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: 2. Run pairtools parse</i></summary>

```bash
#!/bin/bash

pairtools parse --help

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
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: 2. Run pairtools parse</i></summary>

```txt
❯ pairtools parse --help
Usage: pairtools parse [OPTIONS] [SAM_PATH]

  Find ligation pairs in .sam data, make .pairs. SAM_PATH : an input .sam/.bam
  file with paired-end sequence alignments of Hi-C molecules. If the path ends
  with .bam, the input is decompressed from bam with samtools. By default, the
  input is read from stdin.

Options:
  -c, --chroms-path TEXT          Chromosome order used to flip
                                  interchromosomal mates: path to a
                                  chromosomes file (e.g. UCSC chrom.sizes or
                                  similar) whose first column lists scaffold
                                  names. Any scaffolds not listed will be
                                  ordered lexicographically following the
                                  names provided.  [required]
  -o, --output TEXT               output file.  If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4-compressed.By
                                  default, the output is printed into stdout.
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10) to
                                  store in the pairs header.
  --min-mapq INTEGER              The minimal MAPQ score to consider a read as
                                  uniquely mapped  [default: 1]
  --max-molecule-size INTEGER     The maximal size of a Hi-C molecule; used to
                                  rescue single ligations(from molecules with
                                  three alignments) and to rescue complex
                                  ligations.The default is based on oriented
                                  P(s) at short ranges of multiple Hi-C.Not
                                  used with walks-policy all.  [default: 750]
  --drop-readid                   If specified, do not add read ids to the
                                  output
  --drop-seq                      If specified, remove sequences and PHREDs
                                  from the sam fields
  --drop-sam                      If specified, do not add sams to the output
  --add-pair-index                If specified, each pair will have pair index
                                  in the molecule
  --add-columns TEXT              Report extra columns describing alignments
                                  Possible values (can take multiple values as
                                  a comma-separated list): a SAM tag (any pair
                                  of uppercase letters) or mapq, pos5, pos3,
                                  cigar, read_len, matched_bp, algn_ref_span,
                                  algn_read_span, dist_to_5, dist_to_3, seq,
                                  mismatches.
  --output-parsed-alignments TEXT
                                  output file for all parsed alignments,
                                  including walks. Useful for debugging and
                                  rnalysis of walks. If file exists, it will
                                  be open in the append mode. If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed. By default, not used.
  --output-stats TEXT             output file for various statistics of pairs
                                  file.  By default, statistics is not
                                  generated.
  --report-alignment-end [5|3]    specifies whether the 5' or 3' end of the
                                  alignment is reported as the position of the
                                  Hi-C read.
  --max-inter-align-gap INTEGER   read segments that are not covered by any
                                  alignment and longer than the specified
                                  value are treated as "null" alignments.
                                  These null alignments convert otherwise
                                  linear alignments into walks, and affect how
                                  they get reported as a Hi-C pair (see
                                  --walks-policy).  [default: 20]
  --walks-policy [mask|5any|5unique|3any|3unique|all]
                                  the policy for reporting unrescuable walks
                                  (reads containing more than one alignment on
                                  one or both sides, that can not be explained
                                  by a single ligation between two mappable
                                  DNA fragments). "mask" - mask walks
                                  (chrom="!", pos=0, strand="-");  "5any" -
                                  report the 5'-most alignment on each side;
                                  "5unique" - report the 5'-most unique
                                  alignment on each side, if present; "3any" -
                                  report the 3'-most alignment on each side;
                                  "3unique" - report the 3'-most unique
                                  alignment on each side, if present; "all" -
                                  report all available unique alignments on
                                  each side.  [default: mask]
  --readid-transform TEXT         A Python expression to modify read IDs.
                                  Useful when read IDs differ between the two
                                  reads of a pair. Must be a valid Python
                                  expression that uses variables called readID
                                  and/or i (the 0-based index of the read pair
                                  in the bam file) and returns a new value,
                                  e.g. "readID[:-2]+'_'+str(i)". Make sure
                                  that transformed readIDs remain unique!
  --flip / --no-flip              If specified, do not flip pairs in genomic
                                  order and instead preserve the order in
                                  which they were sequenced.
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


❯ echo """
> pairtools parse \\
>     -o \"${a_pairs}\" \\
>     -c \"${a_size}\" \\
>     --drop-sam \\
>     --drop-seq \\
>     --output-stats \"${a_stats}\" \\
>     --assembly \"${assembly}\" \\
>     --no-flip \\
>     --add-columns mapq \\
>     --walks-policy mask \\
>     \"${a_bam}\" \\
>         2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).stderr.txt\" >&2)
> """

pairtools parse \
    -o "pairs/SRR7939018.txt.gz" \
    -c "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size" \
    --drop-sam \
    --drop-seq \
    --output-stats "stats/SRR7939018.stats.txt" \
    --assembly "S288C_R64-3-1" \
    --no-flip \
    --add-columns mapq \
    --walks-policy mask \
    "bams/SRR7939018.bam" \
        2> >(tee -a "pairs/err_out/SRR7939018.stderr.txt" >&2)


❯ pairtools parse \
>     -o "${a_pairs}" \
>     -c "${a_size}" \
>     --drop-sam \
>     --drop-seq \
>     --output-stats "${a_stats}" \
>     --assembly "${assembly}" \
>     --no-flip \
>     --add-columns mapq \
>     --walks-policy mask \
>     "${a_bam}" \
>         2> >(tee -a "${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).stderr.txt" >&2)
[E::idx_find_and_load] Could not retrieve index file for 'bams/SRR7939018.bam'
```
</details>
<br />

<a id="3-run-pairtools-sort"></a>
### 3. Run pairtools sort
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: 3. Run pairtools sort</i></summary>

```bash
#!/bin/bash


```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: 3. Run pairtools sort</i></summary>

```txt


```
</details>
<br />

<a id="4-run-pairtools-dedup"></a>
### 4. Run pairtools dedup
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: 4. Run pairtools dedup</i></summary>

```bash
#!/bin/bash


```
</details>
<br />

<a id="printed-6"></a>
#### Printed
<details>
<summary><i>Printed: 4. Run pairtools dedup</i></summary>

```txt


```
</details>
<br />

<a id="5-run-pairtools-stats"></a>
### 5. Run pairtools stats
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: 5. Run pairtools stats</i></summary>

```bash
#!/bin/bash


```
</details>
<br />

<a id="printed-7"></a>
#### Printed
<details>
<summary><i>Printed: 5. Run pairtools stats</i></summary>

```txt


```
</details>
<br />

<a id="6-load-pairs-to-cooler"></a>
### 6. Load pairs to cooler
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: 6. Load pairs to cooler</i></summary>

```bash
#!/bin/bash


```
</details>
<br />

<a id="printed-8"></a>
#### Printed
<details>
<summary><i>Printed: 6. Load pairs to cooler</i></summary>

```txt


```
</details>
<br />
