
`#work_Micro-C_align-process.md`
<br />
<br />

<!-- MarkdownTOC -->

1. [Install packages necessary for processing Micro-C data](#install-packages-necessary-for-processing-micro-c-data)
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
    1. [2. Run `pairtools parse`](#2-run-pairtools-parse)
        1. [Code](#code-5)
        1. [Printed](#printed-4)
            1. [Check the documentation](#check-the-documentation)
            1. [`pairtools parse`](#pairtools-parse)
            1. [Examine the pairs outfile](#examine-the-pairs-outfile)
            1. [Examine the stats outfile](#examine-the-stats-outfile)
    1. [3. Run `pairtools sort`](#3-run-pairtools-sort)
        1. [Code](#code-6)
        1. [Printed](#printed-5)
            1. [Check the documentation](#check-the-documentation-1)
            1. [`pairtools sort`](#pairtools-sort)
            1. [Examine the sorted pairs outfile](#examine-the-sorted-pairs-outfile)
    1. [4. Run `pairtools dedup` and `pairtools split`](#4-run-pairtools-dedup-and-pairtools-split)
        1. [Code](#code-7)
        1. [Printed](#printed-6)
            1. [Check the documentation](#check-the-documentation-2)
            1. [`pairtools dedup`](#pairtools-dedup)
            1. [Check the various outfiles](#check-the-various-outfiles)
            1. [Examine the unique pairs](#examine-the-unique-pairs)
            1. [Check the stats outfile](#check-the-stats-outfile)
        1. [Notes](#notes)
    1. [5. Run `pairtools select`](#5-run-pairtools-select)
        1. [Code](#code-8)
        1. [Printed](#printed-7)
            1. [Check the documentation](#check-the-documentation-3)
            1. [`pairtools select`](#pairtools-select)
    1. [6. Run `pairtools stats`](#6-run-pairtools-stats)
        1. [Code](#code-9)
        1. [Printed](#printed-8)
            1. [Check the documentation](#check-the-documentation-4)
    1. [7. Load pairs to cooler](#7-load-pairs-to-cooler)
        1. [Code](#code-10)
        1. [Printed](#printed-9)

<!-- /MarkdownTOC -->
<br />
<br />

<a id="install-packages-necessary-for-processing-micro-c-data"></a>
## Install packages necessary for processing Micro-C data
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
*Bioconda installs not working when configuring conda environment for work with osx-64; `#TODO` `#IMPORTANT` [troubleshoot this later](https://www.google.com/search?q=how+to+use+bioconda+with+apple+m1&oq=how+to+use+bioconda+with+apple+m1&aqs=chrome..69i57j33i160l2.5494j1j4&sourceid=chrome&ie=UTF-8)*

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
#!/bin/bash

#  Initialize variables -------------------------------------------------------
#  General variables
threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"
scratch="/fh/scratch/delete30/tsukiyama_t"  # ., "${scratch}"

#  For bwa mem
p_fq="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742"  # ., "${p_fq}"
f_pre="SRR7939018"  # ., "${p_fq}/${f_pre}"*
a_fq_1="${p_fq}/${f_pre}_1.fastq.gz"  # ., "${a_fq_1}"
a_fq_2="${p_fq}/${f_pre}_2.fastq.gz"  # ., "${a_fq_2}"

d_bam="bams"  # echo "${d_bam}"
f_bam="${f_pre}.bam"  # echo "${f_bam}"
a_bam="${d_bam}/${f_bam}"  # echo "${a_bam}"

p_index="${HOME}/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa"  # ., "${p_index}"
f_index="S288C_R64-3-1.fa"  # ., "${p_index}/${f_index}"*
a_index="${p_index}/${f_index}"  # ., "${a_index}"*

#  For pairtools parse
p_size="${HOME}/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed"  # .,s "${p_size}"
f_size="S288C_reference_sequence_R64-3-1_20210421.size"  # ., "${p_size}/${f_size}"
a_size="${p_size}/${f_size}"  # ., "${a_size}"

d_pairs="pairs"  # echo "${d_pairs}"
f_pairs="${f_pre}.txt.gz"  # echo "${f_pairs}"
a_pairs="${d_pairs}/${f_pairs}"  # echo "${a_pairs}"

assembly="S288C_R64-3-1"  # echo "${assembly}"

d_stats="stats"  # echo "${d_stats}"
f_stats="${f_pre}.stats.txt"  # echo "${f_stats}"
a_stats="${d_stats}/${f_stats}"  # echo "${a_stats}"

#  For pairtools sort
d_sort="pairs"  # echo "${d_sort}"
f_sort="${f_pre}.sort.txt.gz"  # echo "${f_sort}"
a_sort="${d_sort}/${f_sort}"  # echo "${a_sort}"

#  For pairtools dedup
d_dedup="dedup"  # echo "${d_dedup}"

f_dedup_pre="${f_pre}.nodups"  # echo "${f_dedup_pre}"
f_dup_pre="${f_pre}.dups"  # echo "${f_dup_pre}"
f_unmap_pre="${f_pre}.unmapped"  # echo "${f_unmap_pre}"

a_dedup_pre_pairs="${d_dedup}/pairs/${f_pre}.nodups.pairs.gz"  # echo "${a_dedup_pre_pairs}"
a_dedup_pre_bam="${d_dedup}/bam/${f_pre}.nodups.bam"  # echo "${a_dedup_pre_bam}"

a_dup_pre_pairs="${d_dedup}/pairs/${f_pre}.dups.pairs.gz"  # echo "${a_dup_pre_pairs}"
a_dup_pre_bam="${d_dedup}/bam/${f_pre}.dups.bam"  # echo "${a_dup_pre_bam}"

a_unmap_pre_pairs="${d_dedup}/pairs/${f_pre}.unmapped.pairs.gz"  # echo "${a_unmap_pre_pairs}"
a_unmap_pre_bam="${d_dedup}/bam/${f_pre}.unmapped.bam"  # echo "${a_unmap_pre_bam}"

f_dedup_stats="${f_pre}.dedup.stats.txt"  # echo "${f_dedup_stats}"
a_dedup_stats="${d_stats}/${f_dedup_stats}"  # echo "${a_dedup_stats}"

max_mismatch=3  # echo "${max_mismatch}"


#  Create outdirectories ------------------------------------------------------
if [[ ! -d "${d_bam}" ]]; then mkdir -p "${d_bam}/err_out"; fi
if [[ ! -d "${d_pairs}" ]]; then mkdir -p "${d_pairs}/err_out"; fi
if [[ ! -d "${d_stats}" ]]; then mkdir -p "${d_stats}"; fi
if [[ ! -d "${d_dedup}" ]]; then mkdir -p ${d_dedup}/{pairs,bam,err_out}; fi
```
</details>
<br />

<a id="printed-2"></a>
##### Printed
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


❯ if [[ ! -d "${d_dedup}" ]]; then mkdir -p ${d_dedup}/{pairs,bam,err_out}; fi
mkdir: created directory 'dedup'
mkdir: created directory 'dedup/pairs'
mkdir: created directory 'dedup/bam'
mkdir: created directory 'dedup/err_out'
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

#  pairtools parse expects unsorted bams, so don't run this chunk:
#+ github.com/open2c/pairtools/issues/178#issuecomment-1554866847
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        echo """
        {
            bwa mem \\
                -t \"${threads}\" \\
                -SP \"${a_index}\" \"${a_fq_1}\" \"${a_fq_2}\" \\
                    | samtools sort \\
                        -@ ${threads} \\
                        -O bam \\
                        -o \"${a_bam}\"
            
            if [[ -f \"${a_bam}\" ]]; then
                samtools index \\
                    -@ ${threads} \\
                    \"${a_bam}\"
            fi
        } \\
            2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
        """

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

run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        echo """
        {
            bwa mem \\
                -t \"${threads}\" \\
                -SP \\
                \"${a_index}\" \\
                \"${a_fq_1}\" \\
                \"${a_fq_2}\" \\
                    | samtools view -@ ${threads} -S -b > \"${a_bam}\"
        } \\
            2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
        """

        {
            bwa mem \
                -t "${threads}" \
                -SP \
                "${a_index}" \
                "${a_fq_1}" \
                "${a_fq_2}" \
                    | samtools view -@ ${threads} -S -b > "${a_bam}"
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
>         -t \"${threads}\" \\
>         -SP \"${a_index}\" \"${a_fq_1}\" \"${a_fq_2}\" \\
>             | samtools sort \\
>                 -@ ${threads} \\
>                 -O bam \\
>                 -o \"${a_bam}\"
> 
>     if [[ -f \"${a_bam}\" ]]; then
>         samtools index \\
>             -@ ${threads} \\
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
>                 -t \"${threads}\" \\
>                 -SP \\
>                 \"${a_index}\" \\
>                 \"${a_fq_1}\" \\
>                 \"${a_fq_2}\" \\
>                     | samtools view -@ ${threads} -S -b > \"${a_bam}\"
>         } \\
>             2> >(tee \"${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt\" >&2)
>         """
> 
>         {
>             bwa mem \
>                 -t "${threads}" \
>                 -SP \
>                 "${a_index}" \
>                 "${a_fq_1}" \
>                 "${a_fq_2}" \
>                     | samtools view -@ ${threads} -S -b > "${a_bam}"
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
### 2. Run `pairtools parse`
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: 2. Run pairtools parse</i></summary>

```bash
#!/bin/bash

#  Check the documentation ----------------------------------------------------
pairtools parse --help


#  Do a trial run of pairtools parse ------------------------------------------
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


#  Examine the pairs outfile --------------------------------------------------
., "${a_pairs}"

zcat "${a_pairs}" | wc -l
samtools view -c "${a_bam}"

samtools view "${a_bam}" | head

n_lines="$(zcat "${a_pairs}" | wc -l)"
echo $(( n_lines - 41 ))  # Subtract header, column-name lines

n_pairs="$(samtools view -c "${a_bam}")"
echo $(( n_pairs / 2 ))

echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing from "${a_pairs}"?

zcat "${a_pairs}" | head -100
zcat "${a_pairs}" | tail -100


#  Examine the stats outfile --------------------------------------------------
., "${a_stats}"

cat "${a_stats}" | wc -l

cat "${a_stats}"
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: 2. Run pairtools parse</i></summary>

<a id="check-the-documentation"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

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
```
</details>
<br />

<a id="pairtools-parse"></a>
##### `pairtools parse`
<details>
<summary><i>Printed: pairtools parse</i></summary>

```txt
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
WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/stats.py:888: RuntimeWarning: divide by zero encountered in double_scalars
  complexity = float(nseq / seq_to_complexity)  # clean np.int64 data type
```
</details>
<br />

<a id="examine-the-pairs-outfile"></a>
##### Examine the pairs outfile
<details>
<summary><i>Printed: Examine the pairs outfile</i></summary>

```txt
❯ ., "${a_pairs}"
-rw-rw---- 1 kalavatt 726M Jun 10 18:16 pairs/SRR7939018.txt.gz


❯ zcat "${a_pairs}" | wc -l
66837113


❯ samtools view -c "${a_bam}"
133674984


❯ samtools view "${a_bam}" | head
SRR7939018.1    77      *       0       0       *       *       0       0       TNTTANNNNNNNNNNNNNNNNGCGAAGGTGANAGTTGGTTGATACTTTCA      G#<<G################<<<GGGIGGG#<<<GGGIIIIIIIIGIII     AS:i:0  XS:i:0
SRR7939018.1    141     *       0       0       *       *       0       0       ACGAATCTTNCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIGII#<G######################################     AS:i:0  XS:i:0
SRR7939018.2    77      *       0       0       *       *       0       0       TCTTTNNNNNNNNNNNNNNNANNGNAACGTTNNNNNNNANNAGNNNGCGT      GGGGG#############################################     AS:i:0  XS:i:0
SRR7939018.2    141     *       0       0       *       *       0       0       CGTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGG#############################################     AS:i:0  XS:i:0
SRR7939018.3    77      *       0       0       *       *       0       0       TGCAGGANNNNNNTNNTTNNGANTTTACGCANNNNCAGGGAAAAGTTGCT      GGGGGII######<##<<##<<#<<GGGIII####<<GGIIIIIIIIIGI     AS:i:0  XS:i:0
SRR7939018.3    141     *       0       0       *       *       0       0       ACCACNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGG#############################################     AS:i:0  XS:i:0
SRR7939018.4    77      *       0       0       *       *       0       0       ACCCACTATCCTNGCCGGTTCGGTGGCCAGCNNAAACTTTCGATTCCCCT      GGGGGIIIIIII#<GGGIIIIIIIIIIIIII##<<GGIIIIIIIIIIIII     AS:i:0  XS:i:0
SRR7939018.4    141     *       0       0       *       *       0       0       TCCTCTTCTNCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIIII#<G######################################     AS:i:0  XS:i:0
SRR7939018.5    77      *       0       0       *       *       0       0       ANACANNNNNNNNNNNNNNNNNCGTTTTATANATGAGTTATGAATTCCTT      G#################################################     AS:i:0  XS:i:0
SRR7939018.5    141     *       0       0       *       *       0       0       AAATTCGGTACCAANTCTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      A<A<AAGGGIA#######################################     AS:i:0  XS:i:0


❯ n_lines="$(zcat "${a_pairs}" | wc -l)"


❯ echo $(( n_lines - 41 ))  # Subtract header, column-name lines
66837072


❯ n_pairs="$(samtools view -c "${a_bam}")"


❯ echo $(( n_pairs / 2 ))
66837492


❯ echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing from "${a_pairs}"?
379


❯ zcat "${a_pairs}" | head -100
## pairs format v1.0.0
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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
#samheader: @PG ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
SRR7939018.1    !       0       !       0       -       -       NN      0       0
SRR7939018.2    !       0       !       0       -       -       NN      0       0
SRR7939018.3    !       0       !       0       -       -       NN      0       0
SRR7939018.4    !       0       !       0       -       -       NN      0       0
SRR7939018.5    !       0       !       0       -       -       NN      0       0
SRR7939018.6    !       0       !       0       -       -       NM      0       0
SRR7939018.7    !       0       !       0       -       -       NM      0       0
SRR7939018.8    !       0       II      775703  -       +       NU      0       60
SRR7939018.9    !       0       !       0       -       -       NN      0       0
SRR7939018.10   !       0       II      10240   -       -       NU      0       60
SRR7939018.11   !       0       !       0       -       -       NN      0       0
SRR7939018.12   !       0       !       0       -       -       NN      0       0
SRR7939018.13   !       0       !       0       -       -       NM      0       0
SRR7939018.14   !       0       !       0       -       -       NM      0       0
SRR7939018.15   II      734242  II      735917  +       +       UU      60      60
SRR7939018.16   !       0       I       188959  -       -       MU      0       60
SRR7939018.17   V       15051   !       0       -       -       UN      60      0
SRR7939018.18   XIII    906996  XIII    904641  +       +       UU      60      60
SRR7939018.19   !       0       !       0       -       -       NN      0       0
SRR7939018.20   IV      801779  !       0       +       -       UN      60      0
SRR7939018.21   !       0       !       0       -       -       MM      0       0
SRR7939018.22   !       0       !       0       -       -       MM      0       0
SRR7939018.23   XII     754749  IX      110448  -       -       UU      60      60
SRR7939018.24   !       0       !       0       -       -       NM      0       0
SRR7939018.25   !       0       !       0       -       -       NM      0       0
SRR7939018.26   !       0       XII     460048  -       +       NU      0       60
SRR7939018.27   !       0       !       0       -       -       NM      0       0
SRR7939018.28   VII     890436  VII     882095  -       -       UU      60      60
SRR7939018.29   !       0       !       0       -       -       NM      0       0
SRR7939018.30   !       0       !       0       -       -       MM      0       0
SRR7939018.31   V       41387   V       41544   -       +       UU      60      60
SRR7939018.32   XIV     583189  III     105899  -       +       UU      60      60
SRR7939018.33   V       375302  V       345311  +       +       UU      60      60
SRR7939018.34   !       0       II      715798  -       -       MU      0       60
SRR7939018.35   II      713403  XIII    881948  -       -       UU      60      60
SRR7939018.36   !       0       IV      1042066 -       -       NU      0       60
SRR7939018.37   XII     492804  XIII    479967  -       +       UU      60      60
SRR7939018.38   V       143625  !       0       +       -       UM      60      0
SRR7939018.39   !       0       XII     531643  -       +       NU      0       60
SRR7939018.40   !       0       XIII    743635  -       +       NU      0       60
SRR7939018.41   IV      424676  IV      424576  -       +       UU      60      60
SRR7939018.42   !       0       !       0       -       -       NM      0       0
SRR7939018.43   !       0       !       0       -       -       NM      0       0
SRR7939018.44   XV      194630  XV      195049  -       -       UU      28      60
SRR7939018.45   !       0       X       49753   -       -       MU      0       60
SRR7939018.46   XIII    706297  XIII    705554  -       -       UU      34      60
SRR7939018.47   XII     973906  XII     974873  -       -       UU      52      60
SRR7939018.48   !       0       !       0       -       -       MM      0       0
SRR7939018.49   !       0       !       0       -       -       MM      0       0
SRR7939018.50   VII     466949  !       0       +       -       UN      60      0
SRR7939018.51   VII     451782  V       204170  -       +       UU      60      60
SRR7939018.52   XIII    86591   XIII    84823   -       -       UU      60      60
SRR7939018.53   !       0       !       0       -       -       MM      0       0
SRR7939018.54   IV      496721  IV      354274  +       -       UU      60      60
SRR7939018.55   !       0       !       0       -       -       NN      0       0
SRR7939018.56   !       0       II      58112   -       +       MU      0       60
SRR7939018.57   !       0       !       0       -       -       MM      0       0
SRR7939018.58   V       315210  IV      344786  -       +       UU      60      60
SRR7939018.59   !       0       XII     460368  -       -       MU      0       60


❯ zcat "${a_pairs}" | tail -100
SRR7939018.66836973     !       0       !       0       -       -       MN      0       0
SRR7939018.66836974     X       698537  !       0       -       -       UN      60      0
SRR7939018.66836975     XII     459943  !       0       -       -       UN      60      0
SRR7939018.66836976     IV      784040  !       0       -       -       UN      60      0
SRR7939018.66836977     XII     416967  !       0       -       -       UN      60      0
SRR7939018.66836978     XI      267795  !       0       -       -       UN      60      0
SRR7939018.66836979     XII     299855  !       0       -       -       UN      60      0
SRR7939018.66836980     !       0       !       0       -       -       NN      0       0
SRR7939018.66836981     XI      488216  !       0       +       -       UN      60      0
SRR7939018.66836982     XIV     81040   !       0       -       -       UN      60      0
SRR7939018.66836983     VIII    78157   !       0       -       -       UN      60      0
SRR7939018.66836984     XIII    59626   !       0       -       -       UN      60      0
SRR7939018.66836985     XII     459804  XII     460129  -       +       UU      18      60
SRR7939018.66836986     XII     788963  XII     831886  -       +       UU      60      60
SRR7939018.66836987     !       0       !       0       -       -       MM      0       0
SRR7939018.66836988     IV      117724  IV      120256  +       +       UU      60      60
SRR7939018.66836989     VII     484733  VII     523183  -       +       UU      60      60
SRR7939018.66836990     XII     771037  IV      50585   +       -       UU      60      60
SRR7939018.66836991     II      447150  II      435629  +       +       UU      60      60
SRR7939018.66836992     I       80736   !       0       +       -       UN      60      0
SRR7939018.66836993     X       570149  II      619866  -       -       UU      60      60
SRR7939018.66836994     IV      1249665 IV      1269898 -       +       UU      60      60
SRR7939018.66836995     XIV     620123  !       0       -       -       UN      60      0
SRR7939018.66836996     !       0       !       0       -       -       MM      0       0
SRR7939018.66836997     XIV     551720  XIV     548489  -       -       UU      60      60
SRR7939018.66836998     !       0       XV      719682  -       +       MU      0       60
SRR7939018.66836999     !       0       !       0       -       -       MM      0       0
SRR7939018.66837000     XII     106700  XII     106928  +       -       UU      60      60

SRR7939018.66837012     XVI     372160  !       0       +       -       UN      60      0
SRR7939018.66837013     !       0       !       0       -       -       MN      0       0
SRR7939018.66837014     XIII    62745   !       0       -       -       UN      60      0
SRR7939018.66837015     XIV     670465  !       0       -       -       UN      60      0
SRR7939018.66837016     III     220877  !       0       +       -       UN      60      0
SRR7939018.66837017     !       0       !       0       -       -       MN      0       0
SRR7939018.66837018     !       0       !       0       -       -       NN      0       0
SRR7939018.66837019     !       0       !       0       -       -       NN      0       0
SRR7939018.66837020     XII     1056596 !       0       +       -       UN      60      0
SRR7939018.66837021     !       0       !       0       -       -       NN      0       0
SRR7939018.66837022     !       0       !       0       -       -       MN      0       0
SRR7939018.66837023     !       0       !       0       -       -       MN      0       0
SRR7939018.66837024     VII     445502  !       0       -       -       UN      44      0
SRR7939018.66837025     !       0       !       0       -       -       NN      0       0
SRR7939018.66837026     V       344269  !       0       -       -       UN      41      0
SRR7939018.66837027     !       0       !       0       -       -       MM      0       0
SRR7939018.66837028     XVI     860558  XIV     715069  -       -       UU      60      60
SRR7939018.66837029     !       0       !       0       -       -       MM      0       0
SRR7939018.66837030     XVI     614393  XIV     342834  -       +       UU      60      60
SRR7939018.66837031     X       532857  X       532857  +       +       UU      60      60
SRR7939018.66837032     !       0       XI      551230  -       +       MU      0       60
SRR7939018.66837033     !       0       !       0       -       -       MM      0       0
SRR7939018.66837034     VIII    480083  VIII    479866  -       -       UU      60      60
SRR7939018.66837035     XI      206780  V       498989  +       -       UU      60      60
SRR7939018.66837036     XII     459832  !       0       +       -       UM      60      0
SRR7939018.66837037     !       0       !       0       -       -       MM      0       0
SRR7939018.66837038     !       0       !       0       -       -       MM      0       0
SRR7939018.66837039     XV      722564  VIII    365579  -       -       UU      60      60
SRR7939018.66837040     VI      231378  VI      232979  +       -       UU      60      60
SRR7939018.66837041     XII     699439  VII     20989   -       +       UU      60      60
SRR7939018.66837042     !       0       !       0       -       -       MN      0       0
SRR7939018.66837043     IX      72498   !       0       -       -       UN      60      0
SRR7939018.66837044     !       0       !       0       -       -       MN      0       0
SRR7939018.66837045     !       0       !       0       -       -       MN      0       0
SRR7939018.66837046     !       0       !       0       -       -       NN      0       0
SRR7939018.66837047     !       0       !       0       -       -       NN      0       0
SRR7939018.66837048     IV      1138433 !       0       -       -       UN      60      0
SRR7939018.66837049     XI      76783   !       0       +       -       UN      60      0
SRR7939018.66837050     !       0       !       0       -       -       MN      0       0
SRR7939018.66837051     XIII    805272  !       0       -       -       UN      60      0
SRR7939018.66837052     XV      347294  !       0       -       -       UN      60      0
SRR7939018.66837053     !       0       !       0       -       -       MN      0       0
SRR7939018.66837054     !       0       !       0       -       -       NN      0       0
SRR7939018.66837055     XIV     672789  !       0       -       -       UN      60      0
SRR7939018.66837056     !       0       !       0       -       -       MN      0       0
SRR7939018.66837057     X       505727  !       0       +       -       UN      51      0
SRR7939018.66837058     XV      776053  !       0       -       -       UN      60      0
SRR7939018.66837059     V       337272  !       0       +       -       UN      48      0
SRR7939018.66837060     VI      245305  !       0       +       -       UN      48      0
SRR7939018.66837061     XI      431995  !       0       -       -       UN      41      0
SRR7939018.66837062     !       0       !       0       -       -       NM      0       0
SRR7939018.66837063     XI      570081  XI      570724  -       +       UU      60      60
SRR7939018.66837064     !       0       XIV     364616  -       +       NU      0       60
SRR7939018.66837065     XIII    294265  XIII    119732  -       -       UU      60      60
SRR7939018.66837066     X       61461   X       61292   -       -       UU      60      60
SRR7939018.66837067     !       0       !       0       -       -       NN      0       0
SRR7939018.66837068     !       0       !       0       -       -       NN      0       0
SRR7939018.66837069     !       0       !       0       -       -       MN      0       0
SRR7939018.66837070     !       0       !       0       -       -       NN      0       0
SRR7939018.66837071     VII     391704  !       0       -       -       UN      60      0
SRR7939018.66837072     IX      143298  !       0       +       -       UN      55      0
```
</details>
<br />

<a id="examine-the-stats-outfile"></a>
##### Examine the stats outfile
<details>
<summary><i>Printed: Examine the stats outfile</i></summary>

```txt
❯ ., "${a_stats}"
-rw-rw---- 1 kalavatt 13K Jun 10 18:16 stats/SRR7939018.stats.txt


❯ cat "${a_stats}" | wc -l
478


❯ cat "${a_stats}"
total   66837072
total_unmapped  16715069
total_single_sided_mapped       12175353
total_mapped    37946650
total_dups      0
total_nodups    37946650
cis     21805569
trans   16141081
pair_types/NN   1415484
pair_types/NM   558055
pair_types/NU   2065026
pair_types/UU   37946604
pair_types/MU   3912017
pair_types/UN   2245179
pair_types/MM   14039715
pair_types/UM   3953047
pair_types/MN   701106
pair_types/WW   709
pair_types/RM   64
pair_types/MR   20
pair_types/RU   28
pair_types/UR   18
cis_1kb+        13696397
cis_2kb+        11084751
cis_4kb+        8867917
cis_10kb+       6430276
cis_20kb+       4893887
cis_40kb+       3583599
summary/frac_cis        0.574637523997507
summary/frac_cis_1kb+   0.36093823828980953
summary/frac_cis_2kb+   0.292114086487213
summary/frac_cis_4kb+   0.23369433138366627
summary/frac_cis_10kb+  0.16945569635264246
summary/frac_cis_20kb+  0.12896756367162845
summary/frac_cis_40kb+  0.09443782257458827
summary/frac_dups       0.0
summary/complexity_naive        inf
chrom_freq/II/II        1465313
chrom_freq/XIII/XIII    1664936
chrom_freq/XII/IX       49624
chrom_freq/VII/VII      1926887
chrom_freq/V/V  971439
chrom_freq/XIV/III      35446
chrom_freq/II/XIII      95218
chrom_freq/XII/XIII     109260
chrom_freq/IV/IV        2792457
chrom_freq/XV/XV        1953665
chrom_freq/XII/XII      2222339
chrom_freq/VII/V        75601
chrom_freq/V/IV 94311
chrom_freq/VIII/XI      50059
chrom_freq/III/III      553079
chrom_freq/XVI/XIV      88260
chrom_freq/XVI/XVI      1648978
chrom_freq/XVI/IV       159162
chrom_freq/II/XI        71532
chrom_freq/XIV/XIV      1429089
chrom_freq/IV/XI        109496
chrom_freq/X/XI 66947
chrom_freq/IV/XIV       131765
chrom_freq/XV/II        113349
chrom_freq/XIII/VI      29220
chrom_freq/XV/V 76513
chrom_freq/IV/XV        196812
chrom_freq/VII/III      34954
chrom_freq/VI/IV        35190
chrom_freq/XI/XI        1182238
chrom_freq/VIII/VIII    959185
chrom_freq/II/Mito      4316
chrom_freq/IX/IX        774155
chrom_freq/XI/VII       88922
chrom_freq/XIV/XIII     87417
chrom_freq/X/X  1332782
chrom_freq/X/VIII       55679
chrom_freq/IV/V 93716
chrom_freq/XVI/XV       125602
chrom_freq/IV/VII       189626
chrom_freq/II/VI        29454
chrom_freq/VII/XV       145964
chrom_freq/III/X        32997
chrom_freq/V/VII        76216
chrom_freq/VIII/XII     67252
chrom_freq/II/I 21417
chrom_freq/XV/XIV       100492
chrom_freq/X/IV 118057
chrom_freq/VII/XIII     121086
chrom_freq/XVI/V        69410
chrom_freq/XII/XV       131879
chrom_freq/III/XIII     35231
chrom_freq/XI/XII       74098
chrom_freq/VI/VI        476873
chrom_freq/I/VII        22476
chrom_freq/II/VII       112808
chrom_freq/V/X  55883
chrom_freq/IX/I 23326
chrom_freq/XI/IX        42366
chrom_freq/I/I  392321
chrom_freq/V/XI 52244
chrom_freq/XIII/XV      123556
chrom_freq/XV/XII       133116
chrom_freq/XIII/X       81456
chrom_freq/II/XIV       80427
chrom_freq/XI/X 66961
chrom_freq/XIII/VIII    64674
chrom_freq/III/VII      35131
chrom_freq/XIV/IV       131102
chrom_freq/VII/I        22586
chrom_freq/XI/IV        109273
chrom_freq/Mito/Mito    59833
chrom_freq/I/XV 21358
chrom_freq/II/XV        113441
chrom_freq/IX/XIV       46561
chrom_freq/XIII/II      95169
chrom_freq/VII/X        95400
chrom_freq/XII/XI       73981
chrom_freq/XII/VIII     65531
chrom_freq/XV/IV        198098
chrom_freq/X/V  56153
chrom_freq/XI/III       30034
chrom_freq/XIV/VI       28126
chrom_freq/XVI/XIII     105458
chrom_freq/VIII/XVI     64386
chrom_freq/XI/XV        86634
chrom_freq/XV/IX        56832
chrom_freq/VII/IV       189354
chrom_freq/XIII/I       20851
chrom_freq/XIII/VII     120575
chrom_freq/V/XII        68441
chrom_freq/IV/VI        34487
chrom_freq/XI/V 51953
chrom_freq/X/VII        95235
chrom_freq/IV/X 117621
chrom_freq/VII/XII      129336
chrom_freq/XIII/IV      158196
chrom_freq/VI/VIII      25400
chrom_freq/XVI/VIII     64628
chrom_freq/X/XV 90816
chrom_freq/VIII/IX      37342
chrom_freq/XIII/XIV     86943
chrom_freq/V/XV 77356
chrom_freq/I/VIII       21631
chrom_freq/XVI/VII      123818
chrom_freq/XII/VII      129706
chrom_freq/XVI/XI       77962
chrom_freq/II/X 78451
chrom_freq/IV/XVI       158690
chrom_freq/XIII/XII     108932
chrom_freq/VII/IX       57350
chrom_freq/VII/II       112148
chrom_freq/IV/IX        69480
chrom_freq/V/VIII       44465
chrom_freq/XIV/XV       100728
chrom_freq/V/III        30431
chrom_freq/X/I  23979
chrom_freq/III/V        30262
chrom_freq/XIV/II       81437
chrom_freq/IV/II        143736
chrom_freq/XV/VIII      73415
chrom_freq/IV/XII       174675
chrom_freq/XII/XVI      109312
chrom_freq/VIII/V       44900
chrom_freq/X/XII        80691
chrom_freq/X/IX 47382
chrom_freq/XI/Mito      3564
chrom_freq/IX/II        49604
chrom_freq/XV/XIII      123134
chrom_freq/XV/VII       146251
chrom_freq/VIII/XIII    64069
chrom_freq/VIII/VII     74460
chrom_freq/XV/XVI       124960
chrom_freq/V/XVI        69695
chrom_freq/VIII/II      62368
chrom_freq/XV/XI        87107
chrom_freq/VIII/XV      72816
chrom_freq/XV/I 21026
chrom_freq/VIII/XIV     56602
chrom_freq/XIII/IX      50686
chrom_freq/XVI/II       98177
chrom_freq/II/IV        143442
chrom_freq/IX/V 38066
chrom_freq/VIII/VI      25651
chrom_freq/VI/IX        26532
chrom_freq/XII/IV       173816
chrom_freq/V/XIII       66696
chrom_freq/II/IX        49202
chrom_freq/XIII/XI      76390
chrom_freq/II/III       33941
chrom_freq/I/III        21249
chrom_freq/XII/II       98557
chrom_freq/V/I  18278
chrom_freq/XVI/X        83888
chrom_freq/XIII/XVI     106160
chrom_freq/I/XIII       20588
chrom_freq/VII/XIV      100959
chrom_freq/IX/VI        26582
chrom_freq/X/XIV        71847
chrom_freq/II/XVI       98131
chrom_freq/VI/X 31224
chrom_freq/III/XVI      35118
chrom_freq/IV/VIII      94548
chrom_freq/XI/XVI       77782
chrom_freq/III/XII      32911
chrom_freq/VII/XI       88660
chrom_freq/X/VI 31002
chrom_freq/VII/XVI      124431
chrom_freq/III/IX       27788
chrom_freq/XII/V        67869
chrom_freq/XIV/VIII     57121
chrom_freq/XIV/VII      101263
chrom_freq/XII/XIV      90368
chrom_freq/II/VIII      62247
chrom_freq/XI/XIV       67003
chrom_freq/XIV/X        72729
chrom_freq/VII/VIII     74212
chrom_freq/VIII/IV      94409
chrom_freq/X/XIII       81432
chrom_freq/IX/VII       58437
chrom_freq/III/XI       30616
chrom_freq/XIV/V        57490
chrom_freq/XV/X 90912
chrom_freq/III/VIII     30053
chrom_freq/III/XIV      35551
chrom_freq/XI/II        71608
chrom_freq/IX/XVI       51320
chrom_freq/VI/II        29502
chrom_freq/IV/I 23395
chrom_freq/V/II 63119
chrom_freq/VIII/I       21145
chrom_freq/VII/VI       32097
chrom_freq/IX/III       28277
chrom_freq/XI/VIII      50068
chrom_freq/V/IX 38121
chrom_freq/II/V 62746
chrom_freq/XIV/XI       67420
chrom_freq/I/XIV        21734
chrom_freq/XIII/V       66069
chrom_freq/XVI/III      35195
chrom_freq/XVI/IX       51931
chrom_freq/X/XVI        83079
chrom_freq/V/XIV        56969
chrom_freq/VI/XII       29236
chrom_freq/IX/IV        69460
chrom_freq/IX/XI        42068
chrom_freq/XIV/XII      90908
chrom_freq/III/VI       25421
chrom_freq/XVI/XII      110512
chrom_freq/XI/VI        28582
chrom_freq/XII/X        79339
chrom_freq/I/II 21678
chrom_freq/VI/XV        31012
chrom_freq/IV/XIII      157821
chrom_freq/IX/X 47445
chrom_freq/XIII/III     35332
chrom_freq/X/II 78771
chrom_freq/Mito/VII     4641
chrom_freq/IX/XII       50706
chrom_freq/VI/I 21371
chrom_freq/III/XV       34268
chrom_freq/IX/Mito      2360
chrom_freq/I/VI 21537
chrom_freq/VI/VII       32215
chrom_freq/XII/I        22097
chrom_freq/IX/XV        57317
chrom_freq/VI/V 24849
chrom_freq/XV/III       34514
chrom_freq/XII/VI       28460
chrom_freq/VI/XIV       28802
chrom_freq/XV/VI        31115
chrom_freq/III/II       33581
chrom_freq/II/XII       98113
chrom_freq/IX/XIII      50698
chrom_freq/VI/III       25080
chrom_freq/XIV/I        21835
chrom_freq/I/IV 23672
chrom_freq/IX/VIII      37577
chrom_freq/IV/III       39415
chrom_freq/VIII/X       55936
chrom_freq/X/III        33104
chrom_freq/I/X  23940
chrom_freq/V/VI 24717
chrom_freq/III/IV       39289
chrom_freq/I/XII        22277
chrom_freq/XVI/VI       28674
chrom_freq/XIV/XVI      87797
chrom_freq/XIV/IX       46127
chrom_freq/VI/XI        28741
chrom_freq/VI/XIII      29116
chrom_freq/XI/XIII      76312
chrom_freq/XI/I 21108
chrom_freq/Mito/X       3261
chrom_freq/VII/Mito     5624
chrom_freq/VI/XVI       28615
chrom_freq/X/Mito       4013
chrom_freq/XIV/Mito     4074
chrom_freq/Mito/VIII    2567
chrom_freq/I/IX 23221
chrom_freq/III/I        20939
chrom_freq/I/V  18448
chrom_freq/VI/Mito      1508
chrom_freq/VIII/III     30229
chrom_freq/IV/Mito      7912
chrom_freq/Mito/IV      6422
chrom_freq/XVI/I        20656
chrom_freq/Mito/XII     6351
chrom_freq/I/XI 20830
chrom_freq/III/Mito     1644
chrom_freq/I/XVI        20520
chrom_freq/Mito/XI      2942
chrom_freq/Mito/XIII    4068
chrom_freq/Mito/XV      4564
chrom_freq/XII/III      32702
chrom_freq/XVI/Mito     4962
chrom_freq/V/Mito       3082
chrom_freq/XV/Mito      5701
chrom_freq/Mito/II      3521
chrom_freq/XIII/Mito    4860
chrom_freq/Mito/I       1003
chrom_freq/Mito/XIV     3339
chrom_freq/Mito/IX      1924
chrom_freq/VIII/Mito    3016
chrom_freq/XII/Mito     7670
chrom_freq/Mito/XVI     3989
chrom_freq/Mito/III     1421
chrom_freq/Mito/VI      1237
chrom_freq/Mito/V       2434
chrom_freq/I/Mito       1189
dist_freq/0-1/+-        370
dist_freq/0-1/-+        381
dist_freq/0-1/--        130066
dist_freq/0-1/++        130074
dist_freq/1-2/+-        942
dist_freq/1-2/-+        882
dist_freq/1-2/--        353
dist_freq/1-2/++        373
dist_freq/2-3/+-        767
dist_freq/2-3/-+        717
dist_freq/2-3/--        59
dist_freq/2-3/++        85
dist_freq/3-6/+-        3057
dist_freq/3-6/-+        2984
dist_freq/3-6/--        177
dist_freq/3-6/++        232
dist_freq/6-10/+-       4287
dist_freq/6-10/-+       4411
dist_freq/6-10/--       97
dist_freq/6-10/++       154
dist_freq/10-18/+-      7906
dist_freq/10-18/-+      8229
dist_freq/10-18/--      263
dist_freq/10-18/++      332
dist_freq/18-32/+-      15653
dist_freq/18-32/-+      15581
dist_freq/18-32/--      461
dist_freq/18-32/++      658
dist_freq/32-56/+-      34043
dist_freq/32-56/-+      33666
dist_freq/32-56/--      6743
dist_freq/32-56/++      6964
dist_freq/56-100/+-     100061
dist_freq/56-100/-+     99290
dist_freq/56-100/--     42826
dist_freq/56-100/++     43818
dist_freq/100-178/+-    478398
dist_freq/100-178/-+    474140
dist_freq/100-178/--    191214
dist_freq/100-178/++    192924
dist_freq/178-316/+-    724555
dist_freq/178-316/-+    717910
dist_freq/178-316/--    305195
dist_freq/178-316/++    311932
dist_freq/316-562/+-    459950
dist_freq/316-562/-+    457935
dist_freq/316-562/--    446911
dist_freq/316-562/++    450387
dist_freq/562-1000/+-   551879
dist_freq/562-1000/-+   554678
dist_freq/562-1000/--   547012
dist_freq/562-1000/++   547190
dist_freq/1000-1778/+-  550822
dist_freq/1000-1778/-+  549149
dist_freq/1000-1778/--  547931
dist_freq/1000-1778/++  546878
dist_freq/1778-3162/+-  480898
dist_freq/1778-3162/-+  481904
dist_freq/1778-3162/--  481619
dist_freq/1778-3162/++  480213
dist_freq/3162-5623/+-  418043
dist_freq/3162-5623/-+  418748
dist_freq/3162-5623/--  419799
dist_freq/3162-5623/++  418846
dist_freq/5623-10000/+- 367883
dist_freq/5623-10000/-+ 367368
dist_freq/5623-10000/-- 368506
dist_freq/5623-10000/++ 367514
dist_freq/10000-17783/+-        323321
dist_freq/10000-17783/-+        322248
dist_freq/10000-17783/--        323182
dist_freq/10000-17783/++        323371
dist_freq/17783-31623/+-        283955
dist_freq/17783-31623/-+        282811
dist_freq/17783-31623/--        283803
dist_freq/17783-31623/++        282692
dist_freq/31623-56234/+-        248193
dist_freq/31623-56234/-+        247435
dist_freq/31623-56234/--        247400
dist_freq/31623-56234/++        247332
dist_freq/56234-100000/+-       215392
dist_freq/56234-100000/-+       215323
dist_freq/56234-100000/--       215836
dist_freq/56234-100000/++       214441
dist_freq/100000-177828/+-      186292
dist_freq/100000-177828/-+      187082
dist_freq/100000-177828/--      186890
dist_freq/100000-177828/++      186702
dist_freq/177828-316228/+-      156160
dist_freq/177828-316228/-+      156239
dist_freq/177828-316228/--      156601
dist_freq/177828-316228/++      156465
dist_freq/316228-562341/+-      117611
dist_freq/316228-562341/-+      118332
dist_freq/316228-562341/--      117318
dist_freq/316228-562341/++      116868
dist_freq/562341-1000000/+-     66659
dist_freq/562341-1000000/-+     66844
dist_freq/562341-1000000/--     66949
dist_freq/562341-1000000/++     66604
dist_freq/1000000-1778279/+-    11043
dist_freq/1000000-1778279/-+    10881
dist_freq/1000000-1778279/--    11022
dist_freq/1000000-1778279/++    10979
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
dist_freq/100000000-177827941/+-        0
dist_freq/100000000-177827941/-+        0
dist_freq/100000000-177827941/--        0
dist_freq/100000000-177827941/++        0
dist_freq/177827941-316227766/+-        0
dist_freq/177827941-316227766/-+        0
dist_freq/177827941-316227766/--        0
dist_freq/177827941-316227766/++        0
dist_freq/316227766-562341325/+-        0
dist_freq/316227766-562341325/-+        0
dist_freq/316227766-562341325/--        0
dist_freq/316227766-562341325/++        0
dist_freq/562341325-1000000000/+-       0
dist_freq/562341325-1000000000/-+       0
dist_freq/562341325-1000000000/--       0
dist_freq/562341325-1000000000/++       0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```
</details>
<br />
</details>
<br />

<a id="3-run-pairtools-sort"></a>
### 3. Run `pairtools sort`
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: 3. Run pairtools sort</i></summary>

```bash
#!/bin/bash

#  Check the documentation ----------------------------------------------------
pairtools sort --help


#  Do a trial run of pairtools parse ------------------------------------------
echo """
pairtools sort \\
    --nproc \"${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort}\" \\
    \"${a_pairs}\" \\
        2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_sort} .txt.gz).stderr.txt\" >&2)
"""

pairtools sort \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort}" \
    "${a_pairs}" \
        2> >(tee -a "${d_pairs}/err_out/$(basename ${a_sort} .txt.gz).stderr.txt" >&2)


#  Examine the sorted pairs outfile -------------------------------------------
., "${a_sort}"

n_lines="$(zcat "${a_sort}" | wc -l)"
echo "${n_lines}"
echo $(( n_lines - 43 ))  # Subtract header, column-name lines

zcat "${a_sort}" | head -100
zcat "${a_sort}" | tail -100
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: 3. Run pairtools sort</i></summary>

<a id="check-the-documentation-1"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt
❯ pairtools sort --help
Usage: pairtools sort [OPTIONS] [PAIRS_PATH]

  Sort a .pairs/.pairsam file.

  Sort pairs in the lexicographic order along chrom1 and chrom2, in the
  numeric order along pos1 and pos2 and in the lexicographic order along
  pair_type.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip or lz4c, correspondingly. By default, the
  input is read as text from stdin.

Options:
  -o, --output TEXT        output pairs file. If the path ends with .gz or
                           .lz4, the output is compressed by bgzip or lz4,
                           correspondingly. By default, the output is printed
                           into stdout.
  --nproc INTEGER          Number of processes to split the sorting work
                           between.  [default: 8]
  --tmpdir TEXT            Custom temporary folder for sorting intermediates.
  --memory TEXT            The amount of memory used by default.  [default:
                           2G]
  --compress-program TEXT  A binary to compress temporary sorted chunks. Must
                           decompress input when the flag -d is provided.
                           Suggested alternatives: gzip, lzop, lz4c, snzip. If
                           "auto", then use lz4c if available, and gzip
                           otherwise.  [default: auto]
  --nproc-in INTEGER       Number of processes used by the auto-guessed input
                           decompressing command.  [default: 3]
  --nproc-out INTEGER      Number of processes used by the auto-guessed output
                           compressing command.  [default: 8]
  --cmd-in TEXT            A command to decompress the input file. If
                           provided, fully overrides the auto-guessed command.
                           Does not work with stdin and pairtools parse. Must
                           read input from stdin and print output into stdout.
                           EXAMPLE: pbgzip -dc -n 3
  --cmd-out TEXT           A command to compress the output file. If provided,
                           fully overrides the auto-guessed command. Does not
                           work with stdout. Must read input from stdin and
                           print output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help               Show this message and exit.
```
</details>
<br />

<a id="pairtools-sort"></a>
##### `pairtools sort`
<details>
<summary><i>Printed: pairtools sort</i></summary>

```txt
❯ echo """
> pairtools sort \\
>     --nproc \"${threads}\" \\
>     --tmpdir \"${scratch}\" \\
>     --output \"${a_sort}\" \\
>     \"${a_pairs}\" \\
>         2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_sort} .txt.gz).stderr.txt\" >&2)
> """

pairtools sort \
    --nproc "16" \
    --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
    --output "pairs/SRR7939018.sort.txt.gz" \
    "pairs/SRR7939018.txt.gz" \
        2> >(tee -a "pairs/err_out/SRR7939018.sort.stderr.txt" >&2)


❯ pairtools sort \
>     --nproc "${threads}" \
>     --tmpdir "${scratch}" \
>     --output "${a_sort}" \
>     "${a_pairs}" \
>         2> >(tee -a "${d_pairs}/err_out/$(basename ${a_sort} .txt.gz).stderr.txt" >&2)
```
</details>
<br />

<a id="examine-the-sorted-pairs-outfile"></a>
##### Examine the sorted pairs outfile
<details>
<summary><i>Printed: Examine the sorted pairs outfile</i></summary>

```txt
❯ ., "${a_sort}"
-rw-rw---- 1 kalavatt 591M Jun 11 08:50 pairs/SRR7939018.sort.txt.gz


❯ n_lines="$(zcat "${a_sort}" | wc -l)"


❯ echo "${n_lines}"
66837115


❯ echo $(( n_lines - 43 ))  # Subtract header, column-name lines
66837072


❯ zcat "${a_sort}" | head -100
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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
#samheader: @PG ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
#samheader: @PG ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
SRR7939018.21   !       0       !       0       -       -       MM      0       0
SRR7939018.22   !       0       !       0       -       -       MM      0       0
SRR7939018.30   !       0       !       0       -       -       MM      0       0
SRR7939018.48   !       0       !       0       -       -       MM      0       0
SRR7939018.49   !       0       !       0       -       -       MM      0       0
SRR7939018.53   !       0       !       0       -       -       MM      0       0
SRR7939018.57   !       0       !       0       -       -       MM      0       0
SRR7939018.66   !       0       !       0       -       -       MM      0       0
SRR7939018.69   !       0       !       0       -       -       MM      0       0
SRR7939018.97   !       0       !       0       -       -       MM      0       0
SRR7939018.102  !       0       !       0       -       -       MM      0       0
SRR7939018.111  !       0       !       0       -       -       MM      0       0
SRR7939018.113  !       0       !       0       -       -       MM      0       0
SRR7939018.114  !       0       !       0       -       -       MM      0       0
SRR7939018.118  !       0       !       0       -       -       MM      0       0
SRR7939018.123  !       0       !       0       -       -       MM      0       0
SRR7939018.145  !       0       !       0       -       -       MM      0       0
SRR7939018.157  !       0       !       0       -       -       MM      0       0
SRR7939018.163  !       0       !       0       -       -       MM      0       0
SRR7939018.177  !       0       !       0       -       -       MM      0       0
SRR7939018.180  !       0       !       0       -       -       MM      0       0
SRR7939018.182  !       0       !       0       -       -       MM      0       0
SRR7939018.189  !       0       !       0       -       -       MM      0       0
SRR7939018.192  !       0       !       0       -       -       MM      0       0
SRR7939018.194  !       0       !       0       -       -       MM      0       0
SRR7939018.205  !       0       !       0       -       -       MM      0       0
SRR7939018.209  !       0       !       0       -       -       MM      0       0
SRR7939018.211  !       0       !       0       -       -       MM      0       0
SRR7939018.213  !       0       !       0       -       -       MM      0       0
SRR7939018.217  !       0       !       0       -       -       MM      0       0
SRR7939018.222  !       0       !       0       -       -       MM      0       0
SRR7939018.224  !       0       !       0       -       -       MM      0       0
SRR7939018.226  !       0       !       0       -       -       MM      0       0
SRR7939018.229  !       0       !       0       -       -       MM      0       0
SRR7939018.244  !       0       !       0       -       -       MM      0       0
SRR7939018.245  !       0       !       0       -       -       MM      0       0
SRR7939018.246  !       0       !       0       -       -       MM      0       0
SRR7939018.248  !       0       !       0       -       -       MM      0       0
SRR7939018.249  !       0       !       0       -       -       MM      0       0
SRR7939018.259  !       0       !       0       -       -       MM      0       0
SRR7939018.265  !       0       !       0       -       -       MM      0       0
SRR7939018.274  !       0       !       0       -       -       MM      0       0
SRR7939018.282  !       0       !       0       -       -       MM      0       0
SRR7939018.290  !       0       !       0       -       -       MM      0       0
SRR7939018.300  !       0       !       0       -       -       MM      0       0
SRR7939018.302  !       0       !       0       -       -       MM      0       0
SRR7939018.305  !       0       !       0       -       -       MM      0       0
SRR7939018.320  !       0       !       0       -       -       MM      0       0
SRR7939018.324  !       0       !       0       -       -       MM      0       0
SRR7939018.334  !       0       !       0       -       -       MM      0       0
SRR7939018.335  !       0       !       0       -       -       MM      0       0
SRR7939018.344  !       0       !       0       -       -       MM      0       0
SRR7939018.352  !       0       !       0       -       -       MM      0       0
SRR7939018.353  !       0       !       0       -       -       MM      0       0
SRR7939018.357  !       0       !       0       -       -       MM      0       0
SRR7939018.362  !       0       !       0       -       -       MM      0       0
SRR7939018.363  !       0       !       0       -       -       MM      0       0


❯ zcat "${a_sort}" | tail -100
SRR7939018.12222092     XVI     943124  XVI     940121  +       -       UU      12      60
SRR7939018.17730638     XVI     943124  XVI     943284  +       -       UU      12      8
SRR7939018.28190237     XVI     943126  XVI     296448  +       +       UU      12      60
SRR7939018.42388777     XVI     943126  XVI     930027  +       -       UU      12      60
SRR7939018.11062244     XVI     943129  XVI     935399  +       -       UU      12      60
SRR7939018.61202518     XVI     943130  XVI     144840  +       -       UU      12      60
SRR7939018.48308777     XVI     943130  XVI     799410  +       -       UU      12      60
SRR7939018.34327409     XVI     943130  XVI     881804  +       -       UU      13      60
SRR7939018.20157644     XVI     943130  XVI     910666  +       -       UU      12      60
SRR7939018.64721363     XVI     943130  XVI     910666  +       -       UU      12      60
SRR7939018.40232783     XVI     943130  XVI     923663  +       -       UU      12      60
SRR7939018.8345170      XVI     943130  XVI     941359  +       -       UU      12      60
SRR7939018.38299718     XVI     943130  XVI     941359  +       -       UU      12      60
SRR7939018.58639867     XVI     943132  XVI     799642  +       -       UU      12      60
SRR7939018.11233681     XVI     943133  XVI     367084  +       -       UU      24      60
SRR7939018.28316258     XVI     943133  XVI     367084  +       -       UU      24      60
SRR7939018.43779838     XVI     943133  XVI     931562  +       -       UU      12      60
SRR7939018.22958595     XVI     943134  XVI     331028  +       +       UU      5       60
SRR7939018.64388114     XVI     943134  XVI     331028  +       +       UU      5       60
SRR7939018.66226745     XVI     943138  XVI     927987  +       +       UU      12      60
SRR7939018.17100354     XVI     943140  XVI     393603  +       -       UU      12      60
SRR7939018.40115862     XVI     943140  XVI     942522  +       -       UU      12      24
SRR7939018.374637       XVI     943144  XVI     28983   +       -       UU      12      60
SRR7939018.34595812     XVI     943150  XVI     405335  +       -       UU      12      60
SRR7939018.38203156     XVI     943150  XVI     405335  +       -       UU      12      60
SRR7939018.43448376     XVI     943152  XVI     185898  +       +       UU      60      60
SRR7939018.18440278     XVI     943156  XVI     733072  +       +       UU      12      60
SRR7939018.48164343     XVI     943156  XVI     898872  +       -       UU      12      60
SRR7939018.25351579     XVI     943157  XVI     721512  +       -       UU      12      60
SRR7939018.39628631     XVI     943165  XVI     34242   +       +       UU      1       60
SRR7939018.16423456     XVI     943165  XVI     458280  +       +       UU      1       60
SRR7939018.13797015     XVI     943165  XVI     821885  +       -       UU      1       60
SRR7939018.63594573     XVI     943169  XVI     672482  -       -       UU      3       60
SRR7939018.23074715     XVI     943169  XVI     938317  -       +       UU      3       60
SRR7939018.28098084     XVI     943169  XVI     940539  -       +       UU      3       60
SRR7939018.55298794     XVI     943169  XVI     942626  -       +       UU      3       11
SRR7939018.24350670     XVI     943170  XVI     935546  -       +       UU      7       60
SRR7939018.57333295     XVI     943172  XVI     641892  -       +       UU      7       60
SRR7939018.40032321     XVI     943172  XVI     941818  -       -       UU      7       60
SRR7939018.10215472     XVI     943173  XVI     534074  -       -       UU      12      60
SRR7939018.61020666     XVI     943173  XVI     913530  -       +       UU      12      60
SRR7939018.29073419     XVI     943173  XVI     942843  -       -       UU      12      60
SRR7939018.35378144     XVI     943178  XVI     105800  -       +       UU      12      60
SRR7939018.5151187      XVI     943178  XVI     765972  -       +       UU      12      60
SRR7939018.50299456     XVI     943178  XVI     899697  -       -       UU      12      60
SRR7939018.19428870     XVI     943179  XVI     190396  -       -       UU      12      60
SRR7939018.34211276     XVI     943180  XVI     943249  -       +       UU      12      6
SRR7939018.3637158      XVI     943185  XVI     896258  -       -       UU      12      60
SRR7939018.43194678     XVI     943185  XVI     896258  -       -       UU      12      60
SRR7939018.17366006     XVI     943191  XVI     943191  -       -       UU      12      11
SRR7939018.7106523      XVI     943193  XVI     929605  -       +       UU      12      60
SRR7939018.27269317     XVI     943193  XVI     941934  -       +       UU      12      60
SRR7939018.18682055     XVI     943201  XVI     925742  -       +       UU      12      60
SRR7939018.44911277     XVI     943201  XVI     925742  -       +       UU      12      60
SRR7939018.47303683     XVI     943207  XVI     940235  -       -       UU      12      60
SRR7939018.44434948     XVI     943210  XVI     727879  -       -       UU      12      60
SRR7939018.39129918     XVI     943213  XVI     85349   -       -       UU      5       60
SRR7939018.1005707      XVI     943213  XVI     941254  -       +       UU      5       60
SRR7939018.53338781     XVI     943213  XVI     942649  -       -       UU      5       10
SRR7939018.26548532     XVI     943213  XVI     943123  -       +       UU      5       19
SRR7939018.52983436     XVI     943214  XVI     938492  -       +       UU      1       60
SRR7939018.24809697     XVI     943214  XVI     943244  -       +       UU      1       3
SRR7939018.43321177     XVI     943240  XVI     940713  +       -       UU      6       60
SRR7939018.63738901     XVI     943245  XVI     943245  +       +       UU      6       6
SRR7939018.49365027     XVI     943251  XVI     942811  +       -       UU      6       1
SRR7939018.3148879      XVI     943252  XVI     622916  +       +       UU      6       60
SRR7939018.39477980     XVI     943254  XVI     915272  +       -       UU      6       60
SRR7939018.49811209     XVI     943254  XVI     915272  +       -       UU      6       60
SRR7939018.36545703     XVI     943256  XVI     901139  +       -       UU      12      60
SRR7939018.34945858     XVI     943266  XVI     638344  -       +       UU      8       60
SRR7939018.48274581     XVI     943266  XVI     900173  -       -       UU      8       60
SRR7939018.62805509     XVI     943269  XVI     942325  -       -       UU      8       60
SRR7939018.62823641     XVI     943269  XVI     942325  -       -       UU      8       60
SRR7939018.31047266     XVI     943290  XVI     918029  -       -       UU      6       60
SRR7939018.62262490     XVI     943291  XVI     931384  -       +       UU      5       60
SRR7939018.27584084     XVI     946238  XVI     297878  +       +       UU      15      60
SRR7939018.29255091     XVI     946238  XVI     297878  +       +       UU      15      60
SRR7939018.7242477      XVI     946241  XVI     937840  +       -       UU      15      60
SRR7939018.37241679     XVI     946241  XVI     937840  +       -       UU      15      60
SRR7939018.38484100     XVI     946241  XVI     937840  +       -       UU      13      60
SRR7939018.13124921     XVI     946242  XVI     730898  +       -       UU      15      60
SRR7939018.48115804     XVI     946249  XVI     946249  +       +       UU      7       15
SRR7939018.987072       XVI     946250  XVI     900167  +       +       UU      6       60
SRR7939018.29612869     XVI     946250  XVI     900167  +       +       UU      6       60
SRR7939018.4422013      XVI     946250  XVI     946250  +       +       UU      8       16
SRR7939018.37280808     XVI     946253  XVI     937718  +       -       UU      2       60
SRR7939018.50168664     XVI     946253  XVI     937718  +       -       UU      6       60
SRR7939018.65747920     XVI     946253  XVI     937718  +       -       UU      6       60
SRR7939018.39634147     XVI     946289  XVI     340211  -       -       UU      15      60
SRR7939018.52212008     XVI     946289  XVI     340211  -       -       UU      15      60
SRR7939018.61910153     XVI     946289  XVI     340211  -       -       UU      15      60
SRR7939018.33097797     XVI     946290  XVI     47785   -       -       UU      15      60
SRR7939018.20675152     XVI     946291  XVI     242176  -       -       UU      15      60
SRR7939018.48906274     XVI     946291  XVI     906900  -       +       UU      15      60
SRR7939018.36276575     XVI     946291  XVI     940004  -       +       UU      15      60
SRR7939018.5626478      XVI     946293  XVI     908572  -       -       UU      8       60
SRR7939018.65350763     XVI     946297  XVI     239919  -       -       UU      7       60
SRR7939018.30035267     XVI     946297  XVI     939701  -       -       UU      7       60
SRR7939018.55113867     XVI     946300  XVI     939782  -       +       UU      7       60
SRR7939018.57420183     XVI     946300  XVI     939782  -       +       UU      7       60
```
</details>
<br />
</details>
<br />

<a id="4-run-pairtools-dedup-and-pairtools-split"></a>
### 4. Run `pairtools dedup` and `pairtools split`
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: 4. Run pairtools dedup</i></summary>

```bash
#!/bin/bash

#  Check the documentation ----------------------------------------------------
pairtools dedup --help
pairtools split --help


#  Do a trial run of pairtools dedup ------------------------------------------
echo """
pairtools dedup \\
    --n-proc \"${threads}\" \\
    --max-mismatch \"${max_mismatch}\" \\
    --mark-dups \\
    --output \\
        >(
            pairtools split \\
                --output-pairs \"${a_dedup_pre_pairs}\" \\
                --output-sam \"${a_dedup_pre_bam}\" \\
        ) \\
    --output-unmapped \\
        >(
            pairtools split \\
                --output-pairs \"${a_dup_pre_pairs}\" \\
                --output-sam \"${a_dup_pre_bam}\" \\
        ) \\
    --output-dups \\
        >(
            pairtools split \\
                --output-pairs \"${a_unmap_pre_pairs}\" \\
                --output-sam \"${a_unmap_pre_bam}\" \\
        ) \\
    --output-stats \"${a_dedup_stats}\" \\
    \"${a_sort}\" \\
        2> >(tee -a \"${d_dedup}/err_out/${f_pre}.dedup.stderr.txt\" >&2)
"""

pairtools dedup \
    --n-proc "${threads}" \
    --max-mismatch "${max_mismatch}" \
    --mark-dups \
    --output \
        >(
            pairtools split \
                --output-pairs "${a_dedup_pre_pairs}" \
                --output-sam "${a_dedup_pre_bam}" \
        ) \
    --output-unmapped \
        >(
            pairtools split \
                --output-pairs "${a_dup_pre_pairs}" \
                --output-sam "${a_dup_pre_bam}" \
        ) \
    --output-dups \
        >(
            pairtools split \
                --output-pairs "${a_unmap_pre_pairs}" \
                --output-sam "${a_unmap_pre_bam}" \
        ) \
    --output-stats "${a_dedup_stats}" \
    "${a_sort}" \
        2> >(tee -a "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt" >&2)


#  Check the various outfiles -------------------------------------------------
., "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt"

., "${a_dedup_pre_pairs}"
., "${a_dup_pre_pairs}"
., "${a_unmap_pre_pairs}"

., "${a_dedup_pre_bam}"
., "${a_dup_pre_bam}"
., "${a_unmap_pre_bam}"

zcat "${a_dedup_pre_pairs}" | head -100  # zcat "${a_dedup_pre_pairs}" | less
zcat "${a_dup_pre_pairs}" | head -100
zcat "${a_unmap_pre_pairs}" | head -100


#  Examine the unique pairs ---------------------------------------------------
zcat "${a_dedup_pre_pairs}" | grep -v "#" | head -300

#  Count number of unique pairs type in "${a_dedup_pre_pairs}"
zcat "${a_dedup_pre_pairs}" \
    | grep -v "^#" \
    | cut -f 8 \
    | sort \
    | uniq -c

#  What are the RU and UR pair types?
zcat "${a_dedup_pre_pairs}" | grep "RU\|UR"


#  Check the stats outfile ----------------------------------------------------
., "${a_dedup_stats}"
cat "${a_dedup_stats}"  # less "${a_dedup_stats}"


#  Something is wrong with the bams (see sub-header "Notes" below) ------------
samtools view "${a_dedup_pre_bam}"
samtools view "${a_dup_pre_bam}"
samtools view "${a_unmap_pre_bam}"

zcat "${a_dedup_pre_bam}"
zcat "${a_dup_pre_bam}"
zcat "${a_unmap_pre_bam}"
```
</details>
<br />

<a id="printed-6"></a>
#### Printed
<details>
<summary><i>Printed: 4. Run pairtools dedup</i></summary>

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

<a id="pairtools-dedup"></a>
##### `pairtools dedup`
<details>
<summary><i>Printed: pairtools dedup</i></summary>

```txt
❯ echo """
> pairtools dedup \\
>     --n-proc \"${threads}\" \\
>     --max-mismatch \"${max_mismatch}\" \\
>     --mark-dups \\
>     --output \\
>         >(
>             pairtools split \\
>                 --output-pairs \"${a_dedup_pre_pairs}\" \\
>                 --output-sam \"${a_dedup_pre_bam}\" \\
>         ) \\
>     --output-unmapped \\
>         >(
>             pairtools split \\
>                 --output-pairs \"${a_dup_pre_pairs}\" \\
>                 --output-sam \"${a_dup_pre_bam}\" \\
>         ) \\
>     --output-dups \\
>         >(
>             pairtools split \\
>                 --output-pairs \"${a_unmap_pre_pairs}\" \\
>                 --output-sam \"${a_unmap_pre_bam}\" \\
>         ) \\
>     --output-stats \"${a_dedup_stats}\" \\
>     \"${a_sort}\" \\
>         2> >(tee -a \"${d_dedup}/err_out/${f_pre}.dedup.stderr.txt\" >&2)
> """

pairtools dedup \
    --n-proc "16" \
    --max-mismatch "3" \
    --mark-dups \
    --output \
        >(
            pairtools split \
                --output-pairs "dedup/pairs/SRR7939018.nodups.pairs.gz" \
                --output-sam "dedup/bam/SRR7939018.nodups.bam" \
        ) \
    --output-unmapped \
        >(
            pairtools split \
                --output-pairs "dedup/pairs/SRR7939018.dups.pairs.gz" \
                --output-sam "dedup/bam/SRR7939018.dups.bam" \
        ) \
    --output-dups \
        >(
            pairtools split \
                --output-pairs "dedup/pairs/SRR7939018.unmapped.pairs.gz" \
                --output-sam "dedup/bam/SRR7939018.unmapped.bam" \
        ) \
    --output-stats "stats/SRR7939018.dedup.stats.txt" \
    "pairs/SRR7939018.sort.txt.gz" \
        2> >(tee -a "dedup/err_out/SRR7939018.dedup.stderr.txt" >&2)


❯ pairtools dedup \
>     --n-proc "${threads}" \
>     --max-mismatch "${max_mismatch}" \
>     --mark-dups \
>     --output \
>         >(
>             pairtools split \
>                 --output-pairs "${a_dedup_pre_pairs}" \
>                 --output-sam "${a_dedup_pre_bam}" \
>         ) \
>     --output-unmapped \
>         >(
>             pairtools split \
>                 --output-pairs "${a_dup_pre_pairs}" \
>                 --output-sam "${a_dup_pre_bam}" \
>         ) \
>     --output-dups \
>         >(
>             pairtools split \
>                 --output-pairs "${a_unmap_pre_pairs}" \
>                 --output-sam "${a_unmap_pre_bam}" \
>         ) \
>     --output-stats "${a_dedup_stats}" \
>     "${a_sort}" \
>         2> >(tee -a "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt" >&2)
```
</details>
<br />

<a id="check-the-various-outfiles"></a>
##### Check the various outfiles
<details>
<summary><i>Printed: Check the various outfiles</i></summary>

```txt
❯ ., "${d_dedup}/err_out/${f_pre}.dedup.stderr.txt"
-rw-rw---- 1 kalavatt 0 Jun 11 10:37 dedup/err_out/SRR7939018.dedup.stderr.txt


❯ ., "${a_dedup_pre_pairs}"
-rw-rw---- 1 kalavatt 385M Jun 11 10:44 dedup/pairs/SRR7939018.nodups.pairs.gz


❯ ., "${a_dup_pre_pairs}"
-rw-rw---- 1 kalavatt 148M Jun 11 10:44 dedup/pairs/SRR7939018.dups.pairs.gz


❯ ., "${a_unmap_pre_pairs}"
-rw-rw---- 1 kalavatt 86M Jun 11 10:44 dedup/pairs/SRR7939018.unmapped.pairs.gz


❯ ., "${a_dedup_pre_bam}"
-rw-rw---- 1 kalavatt 968 Jun 11 10:44 dedup/bam/SRR7939018.nodups.bam


❯ ., "${a_dup_pre_bam}"
-rw-rw---- 1 kalavatt 966 Jun 11 10:44 dedup/bam/SRR7939018.dups.bam


❯ ., "${a_unmap_pre_bam}"
-rw-rw---- 1 kalavatt 966 Jun 11 10:44 dedup/bam/SRR7939018.unmapped.bam


❯ zcat "${a_dedup_pre_pairs}" | head -100
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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
#samheader: @PG ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
#samheader: @PG ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
#samheader: @PG ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort     VN:1.0.2
#samheader: @PG ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.nodups.pairs.gz --output-sam dedup/bam/SRR7939018.nodups.bam PP:pairtools_dedup      VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
SRR7939018.44042564     I       1       I       15064   +       -       UU      48      13
SRR7939018.44810319     I       7       I       1001    +       +       UU      28      46
SRR7939018.29094541     I       7       I       1292    +       -       UU      28      13
SRR7939018.17270740     I       8       I       2024    +       +       UU      21      13
SRR7939018.55685650     I       8       I       9446    +       -       UU      28      60
SRR7939018.20572273     I       10      I       130     +       +       UU      35      53
SRR7939018.14854904     I       10      I       318     +       -       UU      35      60
SRR7939018.25573455     I       10      I       558     +       +       UU      35      11
SRR7939018.34992310     I       10      I       887     +       +       UU      35      35
SRR7939018.1104427      I       10      I       31959   +       -       UU      35      60
SRR7939018.35158773     I       11      I       865     +       +       UU      39      35
SRR7939018.22989844     I       12      I       219     +       -       UU      42      57
SRR7939018.33126366     I       12      I       119112  +       -       UU      42      60
SRR7939018.18616690     I       13      I       280     +       -       UU      42      20
SRR7939018.50678971     I       29      I       407     +       -       UU      60      39
SRR7939018.10119014     I       36      I       470     +       -       UU      60      6
SRR7939018.9636000      I       38      I       194     +       -       UU      60      18
SRR7939018.43976050     I       38      I       229129  -       -       UU      2       12
SRR7939018.56159970     I       39      I       2441    +       -       UU      60      35
SRR7939018.35458836     I       40      I       89      +       -       UU      60      60
SRR7939018.54943727     I       41      I       178     +       +       UU      60      57
SRR7939018.35434398     I       41      I       321     +       +       UU      60      60
SRR7939018.19718640     I       41      I       395     +       +       UU      60      60
SRR7939018.27890433     I       41      I       1731    +       +       UU      60      15
SRR7939018.13293960     I       41      I       38151   -       +       UU      18      60
SRR7939018.16006081     I       43      I       242     +       -       UU      60      60
SRR7939018.50825843     I       52      I       336     -       +       UU      28      60
SRR7939018.8625963      I       55      I       319     -       +       UU      28      60
SRR7939018.18404752     I       56      I       479     -       +       UU      28      39
SRR7939018.5344196      I       56      I       33715   -       -       UU      22      60
SRR7939018.19358281     I       58      I       2936    -       -       UU      13      60
SRR7939018.62948413     I       58      I       27756   -       +       UU      32      32
SRR7939018.62698375     I       60      I       75259   -       +       UU      18      60
SRR7939018.57525614     I       62      I       333     -       -       UU      39      25
SRR7939018.63561884     I       62      I       9772    -       -       UU      39      60
SRR7939018.54429866     I       62      I       228205  -       -       UU      42      55
SRR7939018.11337172     I       63      I       3225    +       +       UU      60      60
SRR7939018.32883053     I       64      I       4341    +       -       UU      60      60
SRR7939018.41612980     I       66      I       289     -       -       UU      44      27
SRR7939018.20486679     I       66      I       47606   -       +       UU      42      60
SRR7939018.4271037      I       68      I       500     +       -       UU      60      60
SRR7939018.13346597     I       72      I       4371    -       +       UU      53      60
SRR7939018.24593858     I       72      I       7008    -       -       UU      37      60
SRR7939018.41263687     I       73      I       49428   +       -       UU      60      60
SRR7939018.34067598     I       77      I       298     +       -       UU      53      35
SRR7939018.7777574      I       77      I       1223    -       -       UU      60      9
SRR7939018.41918892     I       77      I       2410    -       -       UU      60      13
SRR7939018.36976831     I       78      I       228     +       -       UU      60      60
SRR7939018.11605183     I       78      I       1068    +       -       UU      60      9
SRR7939018.61330774     I       78      I       4018    +       -       UU      60      60
SRR7939018.58174255     I       79      I       1330    +       -       UU      60      20
SRR7939018.54185633     I       79      I       1369    +       -       UU      60      35
SRR7939018.32333692     I       79      I       207738  +       +       UU      60      39
SRR7939018.30478651     I       81      I       95      -       +       UU      52      50
SRR7939018.15936606     I       81      I       5173    -       +       UU      60      60


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
#samheader: @PG ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
#samheader: @PG ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
#samheader: @PG ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort     VN:1.0.2
#samheader: @PG ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.dups.pairs.gz --output-sam dedup/bam/SRR7939018.dups.bam     PP:pairtools_dedup      VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
SRR7939018.21   !       0       !       0       -       -       MM      0       0
SRR7939018.22   !       0       !       0       -       -       MM      0       0
SRR7939018.30   !       0       !       0       -       -       MM      0       0
SRR7939018.48   !       0       !       0       -       -       MM      0       0
SRR7939018.49   !       0       !       0       -       -       MM      0       0
SRR7939018.53   !       0       !       0       -       -       MM      0       0
SRR7939018.57   !       0       !       0       -       -       MM      0       0
SRR7939018.66   !       0       !       0       -       -       MM      0       0
SRR7939018.69   !       0       !       0       -       -       MM      0       0
SRR7939018.97   !       0       !       0       -       -       MM      0       0
SRR7939018.102  !       0       !       0       -       -       MM      0       0
SRR7939018.111  !       0       !       0       -       -       MM      0       0
SRR7939018.113  !       0       !       0       -       -       MM      0       0
SRR7939018.114  !       0       !       0       -       -       MM      0       0
SRR7939018.118  !       0       !       0       -       -       MM      0       0
SRR7939018.123  !       0       !       0       -       -       MM      0       0
SRR7939018.145  !       0       !       0       -       -       MM      0       0
SRR7939018.157  !       0       !       0       -       -       MM      0       0
SRR7939018.163  !       0       !       0       -       -       MM      0       0
SRR7939018.177  !       0       !       0       -       -       MM      0       0
SRR7939018.180  !       0       !       0       -       -       MM      0       0
SRR7939018.182  !       0       !       0       -       -       MM      0       0
SRR7939018.189  !       0       !       0       -       -       MM      0       0
SRR7939018.192  !       0       !       0       -       -       MM      0       0
SRR7939018.194  !       0       !       0       -       -       MM      0       0
SRR7939018.205  !       0       !       0       -       -       MM      0       0
SRR7939018.209  !       0       !       0       -       -       MM      0       0
SRR7939018.211  !       0       !       0       -       -       MM      0       0
SRR7939018.213  !       0       !       0       -       -       MM      0       0
SRR7939018.217  !       0       !       0       -       -       MM      0       0
SRR7939018.222  !       0       !       0       -       -       MM      0       0
SRR7939018.224  !       0       !       0       -       -       MM      0       0
SRR7939018.226  !       0       !       0       -       -       MM      0       0
SRR7939018.229  !       0       !       0       -       -       MM      0       0
SRR7939018.244  !       0       !       0       -       -       MM      0       0
SRR7939018.245  !       0       !       0       -       -       MM      0       0
SRR7939018.246  !       0       !       0       -       -       MM      0       0
SRR7939018.248  !       0       !       0       -       -       MM      0       0
SRR7939018.249  !       0       !       0       -       -       MM      0       0
SRR7939018.259  !       0       !       0       -       -       MM      0       0
SRR7939018.265  !       0       !       0       -       -       MM      0       0
SRR7939018.274  !       0       !       0       -       -       MM      0       0
SRR7939018.282  !       0       !       0       -       -       MM      0       0
SRR7939018.290  !       0       !       0       -       -       MM      0       0
SRR7939018.300  !       0       !       0       -       -       MM      0       0
SRR7939018.302  !       0       !       0       -       -       MM      0       0
SRR7939018.305  !       0       !       0       -       -       MM      0       0
SRR7939018.320  !       0       !       0       -       -       MM      0       0
SRR7939018.324  !       0       !       0       -       -       MM      0       0
SRR7939018.334  !       0       !       0       -       -       MM      0       0
SRR7939018.335  !       0       !       0       -       -       MM      0       0
SRR7939018.344  !       0       !       0       -       -       MM      0       0
SRR7939018.352  !       0       !       0       -       -       MM      0       0
SRR7939018.353  !       0       !       0       -       -       MM      0       0
SRR7939018.357  !       0       !       0       -       -       MM      0       0


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
#samheader: @PG ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
#samheader: @PG ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
#samheader: @PG ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort     VN:1.0.2
#samheader: @PG ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.unmapped.pairs.gz --output-sam dedup/bam/SRR7939018.unmapped.bam     PP:pairtools_dedup      VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
SRR7939018.52075119     I       7       I       1001    +       +       DD      28      46
SRR7939018.38253176     I       10      I       887     +       +       DD      35      35
SRR7939018.53629809     I       12      I       219     +       -       DD      42      57
SRR7939018.10654261     I       36      I       470     +       -       DD      60      6
SRR7939018.19343374     I       38      I       194     +       -       DD      60      18
SRR7939018.36012536     I       43      I       242     +       -       DD      60      60
SRR7939018.63614734     I       55      I       319     -       +       DD      28      60
SRR7939018.36401061     I       56      I       479     -       +       DD      28      39
SRR7939018.62429218     I       66      I       47606   -       +       DD      10      60
SRR7939018.7898023      I       68      I       500     +       -       DD      60      39
SRR7939018.53406646     I       77      I       298     +       -       DD      53      35
SRR7939018.34162306     I       89      I       296     +       -       DD      53      35
SRR7939018.59045054     I       94      I       314     +       -       DD      48      60
SRR7939018.30154835     I       95      I       338     +       -       DD      39      35
SRR7939018.20996579     I       95      I       499     +       -       DD      50      42
SRR7939018.59592323     I       99      I       401     +       -       DD      50      21
SRR7939018.35616453     I       105     I       83      +       -       DD      21      60
SRR7939018.45451111     I       105     I       83      +       -       DD      21      60
SRR7939018.17962042     I       114     I       321     -       -       DD      60      60
SRR7939018.52299744     I       120     I       298     +       -       DD      60      35
SRR7939018.31295356     I       120     I       370     +       -       DD      60      35
SRR7939018.61236758     I       139     I       321     -       +       DD      60      60
SRR7939018.56782141     I       142     I       674     -       -       DD      50      12
SRR7939018.42393988     I       160     I       797     -       +       DD      60      15
SRR7939018.55135043     I       160     I       797     -       +       DD      60      15
SRR7939018.35839585     I       167     I       510     -       +       DD      32      6
SRR7939018.57488794     I       167     I       510     -       +       DD      32      4
SRR7939018.14394214     I       169     I       440     +       -       DD      60      60
SRR7939018.58505042     I       169     I       445     +       -       DD      27      60
SRR7939018.59485586     I       172     I       297     +       -       DD      27      35
SRR7939018.27830998     I       172     I       445     +       -       DD      57      60
SRR7939018.61245537     I       179     I       393     +       -       DD      60      60
SRR7939018.11959452     I       180     I       320     +       -       DD      33      60
SRR7939018.53570294     I       201     I       403     +       +       DD      60      60
SRR7939018.56752385     I       209     I       458     -       -       DD      18      57
SRR7939018.50029313     I       219     I       642     +       -       DD      22      39
SRR7939018.60162163     I       221     I       482     -       -       DD      57      35
SRR7939018.51488270     I       228     I       25      -       +       DD      60      14
SRR7939018.30499851     I       228     I       375     -       +       DD      60      32
SRR7939018.35864288     I       231     I       3183    +       +       DD      20      60
SRR7939018.49506811     I       237     I       1575    -       -       DD      60      28
SRR7939018.26816023     I       238     I       1306    +       +       DD      32      60
SRR7939018.6589357      I       240     I       445     +       -       DD      32      60
SRR7939018.63986761     I       243     I       52816   +       +       DD      32      60
SRR7939018.56001168     I       256     I       475     +       -       DD      39      4
SRR7939018.8788749      I       257     I       199     +       -       DD      42      15
SRR7939018.65950633     I       261     I       98      -       +       DD      35      50
SRR7939018.63890386     I       261     I       286     -       +       DD      35      42
SRR7939018.40701191     I       262     I       548     -       -       DD      39      35
SRR7939018.45983272     I       262     I       548     -       -       DD      39      35
SRR7939018.42202510     I       267     I       448     +       -       DD      60      60
SRR7939018.50009947     I       267     I       540     +       -       DD      60      35
SRR7939018.55868442     I       267     I       540     +       -       DD      60      35
SRR7939018.22092198     I       268     I       7631    -       +       DD      22      60
SRR7939018.42055616     I       271     I       383     +       +       DD      60      50
```
</details>
<br />

<a id="examine-the-unique-pairs"></a>
##### Examine the unique pairs
<details>
<summary><i>Printed: Examine the unique pairs</i></summary>

```txt
❯ zcat "${a_dedup_pre_pairs}" | grep -v "#" | head -300
SRR7939018.44042564     I       1       I       15064   +       -       UU      48      13
SRR7939018.44810319     I       7       I       1001    +       +       UU      28      46
SRR7939018.29094541     I       7       I       1292    +       -       UU      28      13
SRR7939018.17270740     I       8       I       2024    +       +       UU      21      13
SRR7939018.55685650     I       8       I       9446    +       -       UU      28      60
SRR7939018.20572273     I       10      I       130     +       +       UU      35      53
SRR7939018.14854904     I       10      I       318     +       -       UU      35      60
SRR7939018.25573455     I       10      I       558     +       +       UU      35      11
SRR7939018.34992310     I       10      I       887     +       +       UU      35      35
SRR7939018.1104427      I       10      I       31959   +       -       UU      35      60
SRR7939018.35158773     I       11      I       865     +       +       UU      39      35
SRR7939018.22989844     I       12      I       219     +       -       UU      42      57
SRR7939018.33126366     I       12      I       119112  +       -       UU      42      60
SRR7939018.18616690     I       13      I       280     +       -       UU      42      20
SRR7939018.50678971     I       29      I       407     +       -       UU      60      39
SRR7939018.10119014     I       36      I       470     +       -       UU      60      6
SRR7939018.9636000      I       38      I       194     +       -       UU      60      18
SRR7939018.43976050     I       38      I       229129  -       -       UU      2       12
SRR7939018.56159970     I       39      I       2441    +       -       UU      60      35
SRR7939018.35458836     I       40      I       89      +       -       UU      60      60
SRR7939018.54943727     I       41      I       178     +       +       UU      60      57
SRR7939018.35434398     I       41      I       321     +       +       UU      60      60
SRR7939018.19718640     I       41      I       395     +       +       UU      60      60
SRR7939018.27890433     I       41      I       1731    +       +       UU      60      15
SRR7939018.13293960     I       41      I       38151   -       +       UU      18      60
SRR7939018.16006081     I       43      I       242     +       -       UU      60      60
SRR7939018.50825843     I       52      I       336     -       +       UU      28      60
SRR7939018.8625963      I       55      I       319     -       +       UU      28      60
SRR7939018.18404752     I       56      I       479     -       +       UU      28      39
SRR7939018.5344196      I       56      I       33715   -       -       UU      22      60
SRR7939018.19358281     I       58      I       2936    -       -       UU      13      60
SRR7939018.62948413     I       58      I       27756   -       +       UU      32      32
SRR7939018.62698375     I       60      I       75259   -       +       UU      18      60
SRR7939018.57525614     I       62      I       333     -       -       UU      39      25
SRR7939018.63561884     I       62      I       9772    -       -       UU      39      60
SRR7939018.54429866     I       62      I       228205  -       -       UU      42      55
SRR7939018.11337172     I       63      I       3225    +       +       UU      60      60
SRR7939018.32883053     I       64      I       4341    +       -       UU      60      60
SRR7939018.41612980     I       66      I       289     -       -       UU      44      27
SRR7939018.20486679     I       66      I       47606   -       +       UU      42      60
SRR7939018.4271037      I       68      I       500     +       -       UU      60      60
SRR7939018.13346597     I       72      I       4371    -       +       UU      53      60
SRR7939018.24593858     I       72      I       7008    -       -       UU      37      60
SRR7939018.41263687     I       73      I       49428   +       -       UU      60      60
SRR7939018.34067598     I       77      I       298     +       -       UU      53      35
SRR7939018.7777574      I       77      I       1223    -       -       UU      60      9
SRR7939018.41918892     I       77      I       2410    -       -       UU      60      13
SRR7939018.36976831     I       78      I       228     +       -       UU      60      60
SRR7939018.11605183     I       78      I       1068    +       -       UU      60      9
SRR7939018.61330774     I       78      I       4018    +       -       UU      60      60
SRR7939018.58174255     I       79      I       1330    +       -       UU      60      20
SRR7939018.54185633     I       79      I       1369    +       -       UU      60      35
SRR7939018.32333692     I       79      I       207738  +       +       UU      60      39
SRR7939018.30478651     I       81      I       95      -       +       UU      52      50
SRR7939018.15936606     I       81      I       5173    -       +       UU      60      60
SRR7939018.39027485     I       88      I       56075   -       +       UU      60      60
SRR7939018.31861861     I       88      I       107563  -       +       UU      60      60
SRR7939018.26002914     I       89      I       296     +       -       UU      53      35
SRR7939018.46658462     I       89      I       318     +       -       UU      60      28
SRR7939018.24703715     I       89      I       964     -       +       UU      60      39
SRR7939018.34060015     I       93      I       194     +       -       UU      54      18
SRR7939018.4599895      I       94      I       314     +       -       UU      48      60
SRR7939018.22066078     I       94      I       996     +       -       UU      48      8
SRR7939018.3480101      I       95      I       338     +       -       UU      39      33
SRR7939018.29817538     I       95      I       411     +       +       UU      2       50
SRR7939018.12120171     I       95      I       499     +       -       UU      50      60
SRR7939018.56703503     I       96      I       463     +       +       UU      50      60
SRR7939018.2893773      I       99      I       401     +       -       UU      50      21
SRR7939018.50311998     I       104     I       4760    -       +       UU      60      60
SRR7939018.8198197      I       105     I       83      +       -       UU      21      60
SRR7939018.46628911     I       108     I       238     +       +       UU      39      32
SRR7939018.54704375     I       108     I       256     +       -       UU      39      60
SRR7939018.31780843     I       108     I       411     +       +       UU      39      50
SRR7939018.45965058     I       112     I       10      -       +       UU      60      35
SRR7939018.15594546     I       112     I       261     +       -       UU      53      35
SRR7939018.33827262     I       112     I       407     +       -       UU      53      39
SRR7939018.88645        I       112     I       230127  +       +       UU      15      2
SRR7939018.2342447      I       114     I       321     -       -       UU      60      60
SRR7939018.33953        I       114     I       1052    +       -       UU      60      39
SRR7939018.16129580     I       116     I       10      -       +       UU      60      35
SRR7939018.6945655      I       116     I       62      -       -       UU      60      39
SRR7939018.18958897     I       116     I       6531    -       +       UU      60      60
SRR7939018.36806590     I       117     I       66815   -       +       UU      60      60
SRR7939018.56325226     I       120     I       67      +       -       UU      60      42
SRR7939018.48930140     I       120     I       298     +       -       UU      60      35
SRR7939018.10294309     I       120     I       370     +       -       UU      60      35
SRR7939018.149574       I       122     I       329     +       -       UU      60      53
SRR7939018.30608017     I       122     I       440     +       -       UU      60      60
SRR7939018.42054658     I       128     I       556     -       +       UU      39      11
SRR7939018.18870615     I       129     I       77      -       -       UU      60      60
SRR7939018.63830453     I       130     I       306     +       -       UU      53      60
SRR7939018.27872423     I       130     I       318     +       -       UU      53      60
SRR7939018.64264442     I       130     I       361     +       -       UU      53      42
SRR7939018.46489678     I       130     I       499     +       -       UU      53      42
SRR7939018.38483937     I       130     I       598     +       -       UU      53      11
SRR7939018.44672941     I       130     I       4231    +       -       UU      53      60
SRR7939018.8174511      I       131     I       266     +       -       UU      53      22
SRR7939018.63069824     I       131     I       270     +       -       UU      48      59
SRR7939018.63360991     I       131     I       408     +       -       UU      53      1
SRR7939018.35055818     I       131     I       516     +       -       UU      53      53
SRR7939018.41132537     I       131     I       2363    +       -       UU      53      60
SRR7939018.53010615     I       132     I       964     +       +       UU      39      39
SRR7939018.50255224     I       135     I       8633    +       +       UU      46      60
SRR7939018.34795673     I       139     I       321     -       +       UU      60      60
SRR7939018.41341751     I       142     I       318     +       -       UU      32      60
SRR7939018.55317485     I       142     I       408     -       -       UU      50      35
SRR7939018.45767801     I       142     I       674     -       -       UU      50      12
SRR7939018.44856945     I       144     I       1       -       +       UU      15      21
SRR7939018.57480364     I       144     I       372     +       -       UU      24      35
SRR7939018.60244328     I       148     I       8314    -       +       UU      50      60
SRR7939018.62030183     I       149     I       340     +       +       UU      15      60
SRR7939018.50687203     I       149     I       58674   +       +       UU      15      60
SRR7939018.14735998     I       153     I       9       -       +       UU      35      13
SRR7939018.10348915     I       153     I       38      +       +       UU      15      60
SRR7939018.11559411     I       153     I       67      +       -       UU      15      60
SRR7939018.57507662     I       153     I       314     +       -       UU      27      60
SRR7939018.51634879     I       153     I       484     +       -       UU      15      35
SRR7939018.20823598     I       159     I       5       -       +       UU      46      48
SRR7939018.49019958     I       159     I       1065    -       -       UU      46      9
SRR7939018.7089964      I       160     I       797     -       +       UU      60      15
SRR7939018.49430764     I       161     I       393     +       -       UU      22      60
SRR7939018.32117170     I       163     I       342     +       -       UU      32      32
SRR7939018.44825194     I       164     I       144     +       -       UU      27      50
SRR7939018.9190308      I       167     I       510     -       +       UU      32      6
SRR7939018.41564659     I       168     I       306     +       -       UU      60      42
SRR7939018.38567586     I       168     I       440     +       -       UU      50      60
SRR7939018.58143382     I       169     I       445     +       -       UU      27      60
SRR7939018.1218818      I       172     I       297     +       -       UU      27      35
SRR7939018.37292189     I       174     I       360     +       -       UU      57      39
SRR7939018.62262963     I       178     I       965     +       +       UU      57      25
SRR7939018.40100680     I       179     I       179     +       +       UU      42      53
SRR7939018.18013213     I       179     I       393     +       -       UU      60      60
SRR7939018.40530226     I       179     I       997     +       -       UU      60      60
SRR7939018.17438715     I       179     I       1519    +       +       UU      60      52
SRR7939018.2072227      I       180     I       318     +       -       UU      60      46
SRR7939018.64470435     I       182     I       159     +       -       UU      60      60
SRR7939018.43306138     I       185     I       347     -       +       UU      42      60
SRR7939018.636925       I       186     I       22109   +       -       UU      60      35
SRR7939018.18893333     I       187     I       448     +       +       UU      60      50
SRR7939018.33701049     I       190     I       4166    +       +       UU      60      60
SRR7939018.32232023     I       190     I       70094   +       +       UU      60      60
SRR7939018.53297799     I       191     I       46260   +       +       UU      60      60
SRR7939018.40600493     I       194     I       702     -       -       UU      18      22
SRR7939018.54428661     I       196     I       1872    -       +       UU      15      4
SRR7939018.24526425     I       197     I       499     +       -       UU      60      42
SRR7939018.29763149     I       199     I       1423    -       -       UU      27      12
SRR7939018.40043700     I       199     I       3516    +       +       UU      60      60
SRR7939018.14444090     I       201     I       403     +       +       UU      60      60
SRR7939018.60875057     I       201     I       456     +       +       UU      60      35
SRR7939018.35249835     I       203     I       1396    +       -       UU      60      32
SRR7939018.15001816     I       203     I       6184    +       -       UU      60      60
SRR7939018.34494724     I       204     I       482     +       -       UU      60      35
SRR7939018.22859704     I       209     I       458     -       -       UU      18      57
SRR7939018.47000044     I       209     I       34714   -       -       UU      33      60
SRR7939018.63597093     I       211     I       393     +       -       UU      39      60
SRR7939018.1622372      I       211     I       997     +       -       UU      39      60
SRR7939018.474429       I       213     I       499     -       +       UU      35      48
SRR7939018.20506996     I       219     I       642     +       -       UU      22      39
SRR7939018.53054840     I       221     I       482     -       -       UU      57      35
SRR7939018.5192888      I       228     I       25      -       +       UU      60      14
SRR7939018.54103083     I       228     I       67      -       +       UU      60      60
SRR7939018.58302728     I       228     I       112     -       +       UU      60      53
SRR7939018.11802973     I       228     I       375     -       +       UU      60      32
SRR7939018.13131256     I       228     I       1317    -       +       UU      60      42
SRR7939018.61381899     I       229     I       61832   -       -       UU      60      60
SRR7939018.43463684     I       230     I       66      -       -       UU      60      42
SRR7939018.37234934     I       231     I       1       -       +       UU      60      48
SRR7939018.57215855     I       231     I       1507    +       -       UU      22      28
SRR7939018.21538317     I       231     I       3183    +       +       UU      20      60
SRR7939018.27062170     I       231     I       5328    -       -       UU      60      60
SRR7939018.30514503     I       232     I       516     +       -       UU      22      53
SRR7939018.25735139     I       237     I       304     -       +       UU      60      22
SRR7939018.16656470     I       237     I       1268    +       -       UU      32      9
SRR7939018.35412212     I       237     I       1575    -       -       UU      60      28
SRR7939018.45068006     I       237     I       14967   -       +       UU      60      35
SRR7939018.57443737     I       238     I       196     +       -       UU      32      27
SRR7939018.35540452     I       238     I       388     +       -       UU      33      60
SRR7939018.738378       I       238     I       413     +       +       UU      32      42
SRR7939018.49658035     I       238     I       1013    +       +       UU      32      13
SRR7939018.18455078     I       238     I       1306    +       +       UU      32      60
SRR7939018.25425454     I       239     I       447     +       -       UU      32      60
SRR7939018.50160736     I       239     I       1145    +       -       UU      32      60
SRR7939018.29347329     I       240     I       58204   +       +       UU      32      60
SRR7939018.47720593     I       241     I       412     +       -       UU      15      50
SRR7939018.27920289     I       242     I       657     -       -       UU      60      28
SRR7939018.28354716     I       243     I       52816   +       +       UU      32      60
SRR7939018.46556463     I       247     I       624     +       -       UU      35      35
SRR7939018.30258755     I       247     I       1070    -       -       UU      60      9
SRR7939018.31082534     I       249     I       5864    -       +       UU      60      60
SRR7939018.27987036     I       255     I       112     -       +       UU      57      27
SRR7939018.50639585     I       256     I       196     +       -       UU      39      15
SRR7939018.25112590     I       256     I       475     +       -       UU      39      4
SRR7939018.37697195     I       256     I       561     +       -       UU      39      7
SRR7939018.18628405     I       256     I       4844    -       +       UU      60      60
SRR7939018.64068573     I       260     I       9673    -       +       UU      60      60
SRR7939018.36512445     I       261     I       98      -       +       UU      35      50
SRR7939018.53763682     I       261     I       130     -       +       UU      35      54
SRR7939018.11082149     I       261     I       286     -       +       UU      35      42
SRR7939018.395757       I       261     I       1300    -       +       UU      35      60
SRR7939018.36878402     I       261     I       1503    +       -       UU      53      8
SRR7939018.58859396     I       261     I       151795  -       +       UU      35      60
SRR7939018.9188285      I       262     I       548     -       -       UU      39      35
SRR7939018.54906449     I       264     I       565     +       +       UU      57      30
SRR7939018.6384391      I       264     I       1119    -       -       UU      22      42
SRR7939018.22854810     I       265     I       1030    -       +       UU      22      8
SRR7939018.12209119     I       265     I       30528   -       -       UU      22      60
SRR7939018.24964457     I       267     I       267     +       +       UU      60      60
SRR7939018.7234736      I       267     I       448     +       -       UU      60      60
SRR7939018.19510743     I       267     I       540     +       -       UU      60      35
SRR7939018.13899556     I       267     I       17657   +       +       UU      60      13
SRR7939018.38503770     I       268     I       877     +       +       UU      60      18
SRR7939018.474499       I       268     I       7631    -       +       UU      22      60
SRR7939018.55837536     I       269     I       462     -       -       UU      22      42
SRR7939018.21073549     I       269     I       1068    +       -       UU      60      9
SRR7939018.22540568     I       270     I       17997   +       +       UU      60      15
SRR7939018.19685544     I       271     I       383     +       +       UU      60      50
SRR7939018.50078671     I       272     I       149     -       +       UU      22      15
SRR7939018.25382176     I       272     I       448     +       -       UU      60      48
SRR7939018.33536302     I       272     I       511     +       -       UU      60      46
SRR7939018.4328848      I       276     I       388     +       -       UU      60      60
SRR7939018.11189274     I       279     I       964     +       +       UU      53      39
SRR7939018.15295337     I       280     I       618     -       +       UU      39      12
SRR7939018.9615117      I       281     I       9123    -       +       UU      22      60
SRR7939018.9583435      I       283     I       500     -       +       UU      22      35
SRR7939018.46278305     I       284     I       1096    -       +       UU      4       60
SRR7939018.41995560     I       284     I       3837    +       +       UU      50      60
SRR7939018.42126681     I       284     I       40796   +       -       UU      50      60
SRR7939018.60069005     I       286     I       646     -       -       UU      32      35
SRR7939018.2693106      I       286     I       1556    +       +       UU      42      19
SRR7939018.16225453     I       287     I       508     +       -       UU      39      35
SRR7939018.22091177     I       289     I       554     +       -       UU      35      6
SRR7939018.27010956     I       289     I       2411    -       -       UU      39      13
SRR7939018.28786476     I       290     I       636     +       -       UU      35      39
SRR7939018.33956231     I       292     I       203     +       -       UU      35      13
SRR7939018.15585603     I       292     I       450     +       +       UU      35      42
SRR7939018.64208972     I       294     I       350     -       +       UU      35      50
SRR7939018.8013045      I       297     I       298     -       +       UU      35      15
SRR7939018.58440622     I       297     I       566     -       +       UU      35      35
SRR7939018.37769305     I       298     I       121     -       +       UU      35      60
SRR7939018.56583569     I       301     I       221     +       -       UU      27      57
SRR7939018.16125087     I       302     I       453     -       -       UU      35      60
SRR7939018.62353867     I       304     I       620     +       -       UU      22      26
SRR7939018.18152373     I       304     I       2170    -       +       UU      35      6
SRR7939018.66151970     I       306     I       118     -       +       UU      42      60
SRR7939018.4371675      I       307     I       8       -       +       UU      46      28
SRR7939018.17515347     I       309     I       1942    -       -       UU      53      27
SRR7939018.7312079      I       309     I       33506   -       +       UU      53      60
SRR7939018.19509623     I       309     I       187437  -       -       UU      53      4
SRR7939018.17206555     I       310     I       506     +       -       UU      35      35
SRR7939018.21284547     I       310     I       33072   -       -       UU      53      60
SRR7939018.5039839      I       314     I       389     -       +       UU      60      60
SRR7939018.58846147     I       314     I       1395    -       -       UU      60      32
SRR7939018.39041406     I       316     I       2677    +       +       UU      57      46
SRR7939018.59515106     I       317     I       377     -       +       UU      60      32
SRR7939018.53267260     I       317     I       437     -       +       UU      60      42
SRR7939018.63746396     I       317     I       479     -       +       UU      60      60
SRR7939018.12127032     I       317     I       598     -       -       UU      60      11
SRR7939018.48867141     I       317     I       1105    -       -       UU      60      9
SRR7939018.41904466     I       317     I       27906   -       -       UU      60      60
SRR7939018.28431320     I       318     I       147     -       +       UU      60      27
SRR7939018.27754454     I       318     I       154     -       +       UU      60      19
SRR7939018.44608924     I       318     I       169     -       +       UU      60      53
SRR7939018.25325734     I       318     I       410     -       -       UU      60      7
SRR7939018.34611243     I       318     I       493     -       +       UU      60      35
SRR7939018.48190964     I       318     I       550     -       -       UU      60      35
SRR7939018.42699900     I       318     I       2076    -       +       UU      60      8
SRR7939018.62489139     I       318     I       7046    -       -       UU      60      60
SRR7939018.5634300      I       319     I       504     -       -       UU      60      60
SRR7939018.5582342      I       319     I       2367    +       -       UU      60      60
SRR7939018.50433185     I       319     I       4632    +       +       UU      60      60
SRR7939018.13165688     I       321     I       172     +       +       UU      60      57
SRR7939018.31301430     I       321     I       492     +       -       UU      60      53
SRR7939018.26911284     I       321     I       4041    +       +       UU      60      60
SRR7939018.16104906     I       321     I       8763    +       +       UU      60      60
SRR7939018.17597296     I       322     I       119     -       -       UU      60      60
SRR7939018.52698739     I       322     I       110955  +       -       UU      39      60
SRR7939018.5236090      I       323     I       5908    -       +       UU      60      60
SRR7939018.54645427     I       324     I       579     -       +       UU      60      32
SRR7939018.171339       I       324     I       671     +       -       UU      60      12
SRR7939018.55582591     I       324     I       2797    -       -       UU      60      60
SRR7939018.15787174     I       329     I       149     -       +       UU      53      15
SRR7939018.25588817     I       329     I       3194    +       +       UU      38      60
SRR7939018.44478098     I       329     I       4012    -       -       UU      39      60
SRR7939018.20785039     I       330     I       512     +       +       UU      42      7
SRR7939018.36435828     I       330     I       637     -       -       UU      53      39
SRR7939018.3993763      I       330     I       1306    -       +       UU      53      60
SRR7939018.62229931     I       330     I       2414    -       -       UU      53      13
SRR7939018.36302256     I       331     I       610     -       -       UU      53      16
SRR7939018.22970716     I       331     I       6442    -       +       UU      53      60
SRR7939018.20883050     I       333     I       455     -       +       UU      50      35
SRR7939018.8896863      I       333     I       1608    -       +       UU      50      2
SRR7939018.30464575     I       333     I       22903   -       +       UU      50      4
SRR7939018.57984848     I       335     I       27366   +       +       UU      60      53
SRR7939018.57772590     I       336     I       914     +       +       UU      60      60
SRR7939018.46639408     I       338     I       12630   +       -       UU      60      11
SRR7939018.52855934     I       342     I       207     -       +       UU      32      48
SRR7939018.55843917     I       342     I       220     -       +       UU      32      22
SRR7939018.43567249     I       342     I       237     -       -       UU      32      60
SRR7939018.25152659     I       342     I       30346   -       -       UU      32      60
SRR7939018.65852975     I       343     I       117     -       +       UU      28      60


❯ #  Count number of unique pairs type in "${a_dedup_pre_pairs}"
❯ zcat "${a_dedup_pre_pairs}" \
>     | grep -v "^#" \
>     | cut -f 8 \
>     | sort \
>     | uniq -c
      22 RU
      16 UR
30984355 UU


❯ #  What are the RU and UR pair types?
❯ zcat "${a_dedup_pre_pairs}" | grep "RU\|UR"
SRR7939018.16158752     II      72123   II      72123   +       +       RU      60      60
SRR7939018.40527682     II      406931  XII     460098  -       -       UR      60      60
SRR7939018.29449561     IV      54363   IV      54363   -       -       RU      59      60
SRR7939018.52130110     IV      244807  IV      1082239 -       -       RU      60      60
SRR7939018.33602764     IV      585500  IV      585685  +       +       RU      60      60
SRR7939018.54938585     IV      1339408 IV      1339408 +       +       RU      60      60
SRR7939018.32721452     IV      521979  XI      633439  -       +       RU      60      60
SRR7939018.16406425     IX      75357   VII     720586  -       -       RU      60      60
SRR7939018.59846141     Mito    5261    Mito    5261    -       -       UR      60      60
SRR7939018.46681173     Mito    30009   Mito    24889   +       -       RU      60      39
SRR7939018.44962128     Mito    37916   Mito    37916   +       +       RU      60      60
SRR7939018.5497732      Mito    65713   Mito    65962   -       -       UR      48      60
SRR7939018.60807036     Mito    71798   Mito    71798   -       -       RU      60      60
SRR7939018.54748364     V       45827   I       4913    +       -       RU      60      60
SRR7939018.52165771     V       508957  V       508411  -       -       RU      60      60
SRR7939018.19656596     V       513648  XV      491777  +       +       UR      60      60
SRR7939018.26325668     VII     753242  VII     753343  +       -       UR      60      32
SRR7939018.25575558     VII     753242  VII     753361  +       -       UR      60      60
SRR7939018.13637676     VII     753242  VII     753368  +       -       UR      60      60
SRR7939018.62500214     VII     753242  VII     753377  +       -       UR      60      60
SRR7939018.37662090     VII     753242  VII     753388  +       -       UR      60      60
SRR7939018.58241551     VII     753242  VII     753593  +       -       UR      60      60
SRR7939018.32226842     VII     753246  VII     753328  +       -       UR      60      60
SRR7939018.43412802     VII     753344  VII     753246  -       +       RU      35      60
SRR7939018.29130431     VII     753352  VII     753227  -       +       UR      60      60
SRR7939018.19039978     VII     753368  VII     753246  -       +       RU      60      60
SRR7939018.37537334     VII     753690  VII     753246  -       +       RU      60      60
SRR7939018.51422729     VIII    319445  XVI     562547  +       +       RU      60      60
SRR7939018.23912930     XI      449843  XI      446776  +       -       RU      60      60
SRR7939018.12206387     XI      474554  XIV     496800  +       -       UR      60      60
SRR7939018.24847876     XII     203285  IV      443010  +       -       UR      60      60
SRR7939018.17080411     XII     89681   XII     89884   +       -       RU      60      60
SRR7939018.15206540     XII     155687  XII     155668  +       +       RU      60      60
SRR7939018.2094756      XII     566825  XII     575243  -       +       RU      60      60
SRR7939018.35947817     XII     949457  XII     955731  -       +       RU      60      60
SRR7939018.13294734     XIII    414344  XIII    366009  +       +       UR      60      60
SRR7939018.43331180     XIV     363194  XIV     363194  -       -       RU      60      60
SRR7939018.39649628     XV      130908  XV      131076  +       -       UR      60      60
```
</details>
<br />

<a id="check-the-stats-outfile"></a>
##### Check the stats outfile
`#TODO` `#QUESTION` Is this [`pairtools dedup`](#code-7) stats outfile different from the [`pairtools parse`](#code-5) stats outfile?

<details>
<summary><i>Printed: Check the stats outfile</i></summary>

```txt
❯ ., "${a_dedup_stats}"
-rw-rw---- 1 kalavatt 13K Jun 11 10:44 stats/SRR7939018.dedup.stats.txt


❯ cat "${a_dedup_stats}"
total   66144150
total_unmapped  16715069
total_single_sided_mapped       11476331
total_mapped    37952750
total_dups      6968357
total_nodups    30984393
cis     17685258
trans   13299135
pair_types/MM   14039715
pair_types/MN   701106
pair_types/NM   558055
pair_types/NN   1415484
pair_types/MU   3912017
pair_types/NU   2065026
pair_types/WW   709
pair_types/MR   20
pair_types/UM   3497691
pair_types/UN   2001525
pair_types/RM   52
pair_types/UU   30984355
pair_types/DD   6968357
pair_types/RU   22
pair_types/UR   16
cis_1kb+        11262647
cis_2kb+        9121879
cis_4kb+        7300383
cis_10kb+       5295025
cis_20kb+       4029888
cis_40kb+       2951120
summary/frac_cis        0.5707795534351762
summary/frac_cis_1kb+   0.36349419528728544
summary/frac_cis_2kb+   0.2944023786426928
summary/frac_cis_4kb+   0.2356148464809364
summary/frac_cis_10kb+  0.17089329456930138
summary/frac_cis_20kb+  0.13006186695346914
summary/frac_cis_40kb+  0.0952453707903847
summary/frac_dups       0.1836061154988769
summary/complexity_naive        90272388.0382411
chrom_freq/I/I  318963
chrom_freq/I/IV 19383
chrom_freq/I/II 17780
chrom_freq/I/III        17461
chrom_freq/I/IX 19093
chrom_freq/I/VII        18502
chrom_freq/I/VIII       17824
chrom_freq/I/VI 17799
chrom_freq/I/V  15176
chrom_freq/I/X  19734
chrom_freq/I/Mito       1037
chrom_freq/I/XII        18380
chrom_freq/I/XIV        17980
chrom_freq/I/XI 17268
chrom_freq/I/XIII       16901
chrom_freq/I/XV 17555
chrom_freq/I/XVI        17229
chrom_freq/II/I 17623
chrom_freq/II/II        1198104
chrom_freq/II/III       28042
chrom_freq/II/IV        118339
chrom_freq/II/IX        40377
chrom_freq/II/Mito      3699
chrom_freq/II/V 51581
chrom_freq/II/VI        24327
chrom_freq/II/VII       92801
chrom_freq/II/VIII      51201
chrom_freq/II/X 64545
chrom_freq/II/XI        58780
chrom_freq/II/XII       80855
chrom_freq/II/XIII      78424
chrom_freq/II/XIV       66134
chrom_freq/II/XV        93316
chrom_freq/II/XVI       80956
chrom_freq/III/III      450121
chrom_freq/III/II       27745
chrom_freq/III/I        17292
chrom_freq/III/IV       32362
chrom_freq/III/IX       22967
chrom_freq/III/V        24892
chrom_freq/III/Mito     1416
chrom_freq/III/VII      28915
chrom_freq/III/VIII     24810
chrom_freq/III/VI       20896
chrom_freq/III/X        27246
chrom_freq/III/XII      27144
chrom_freq/III/XI       25118
chrom_freq/III/XIII     29115
chrom_freq/III/XIV      29294
chrom_freq/III/XV       28288
chrom_freq/III/XVI      29497
chrom_freq/IV/II        118325
chrom_freq/IV/I 19242
chrom_freq/IV/IV        2283259
chrom_freq/IV/III       32579
chrom_freq/IV/IX        57191
chrom_freq/IV/V 77125
chrom_freq/IV/Mito      6729
chrom_freq/IV/VII       156371
chrom_freq/IV/VI        28431
chrom_freq/IV/VIII      77696
chrom_freq/IV/X 96722
chrom_freq/IV/XI        90170
chrom_freq/IV/XII       143936
chrom_freq/IV/XIII      129857
chrom_freq/IV/XIV       108306
chrom_freq/IV/XV        162056
chrom_freq/IV/XVI       130769
chrom_freq/IX/I 19156
chrom_freq/IX/II        40720
chrom_freq/IX/III       23348
chrom_freq/IX/IV        57284
chrom_freq/IX/IX        631695
chrom_freq/IX/V 31300
chrom_freq/IX/VI        21848
chrom_freq/IX/VII       48028
chrom_freq/IX/Mito      2025
chrom_freq/IX/VIII      30875
chrom_freq/IX/X 38993
chrom_freq/IX/XI        34711
chrom_freq/IX/XII       41627
chrom_freq/IX/XIII      41653
chrom_freq/IX/XIV       38289
chrom_freq/IX/XV        47050
chrom_freq/IX/XVI       42299
chrom_freq/Mito/Mito    47042
chrom_freq/Mito/IV      5408
chrom_freq/Mito/II      3010
chrom_freq/Mito/IX      1623
chrom_freq/Mito/III     1184
chrom_freq/Mito/I       846
chrom_freq/Mito/XII     5442
chrom_freq/Mito/VII     3909
chrom_freq/Mito/XV      3898
chrom_freq/Mito/XIII    3432
chrom_freq/Mito/XVI     3694
chrom_freq/Mito/XIV     2829
chrom_freq/Mito/X       2719
chrom_freq/Mito/XI      2458
chrom_freq/Mito/VIII    2144
chrom_freq/Mito/V       2013
chrom_freq/Mito/VI      1069
chrom_freq/V/II 51974
chrom_freq/V/I  15090
chrom_freq/V/IV 77418
chrom_freq/V/III        25105
chrom_freq/V/IX 31481
chrom_freq/V/V  793146
chrom_freq/V/Mito       2631
chrom_freq/V/VI 20287
chrom_freq/V/VII        62889
chrom_freq/V/VIII       36424
chrom_freq/V/X  45999
chrom_freq/V/XI 43054
chrom_freq/V/XII        56358
chrom_freq/V/XIII       54881
chrom_freq/V/XIV        47032
chrom_freq/V/XV 63491
chrom_freq/V/XVI        57574
chrom_freq/VI/I 17593
chrom_freq/VI/IV        29055
chrom_freq/VI/II        24246
chrom_freq/VI/III       20613
chrom_freq/VI/VI        388984
chrom_freq/VI/IX        21874
chrom_freq/VI/V 20409
chrom_freq/VI/Mito      1271
chrom_freq/VI/VII       26438
chrom_freq/VI/VIII      20939
chrom_freq/VI/X 25727
chrom_freq/VI/XII       24041
chrom_freq/VI/XI        23663
chrom_freq/VI/XIII      23948
chrom_freq/VI/XV        25603
chrom_freq/VI/XIV       23703
chrom_freq/VI/XVI       24016
chrom_freq/VII/II       92545
chrom_freq/VII/I        18570
chrom_freq/VII/III      28925
chrom_freq/VII/IV       156092
chrom_freq/VII/IX       47353
chrom_freq/VII/V        62314
chrom_freq/VII/Mito     4807
chrom_freq/VII/VII      1575331
chrom_freq/VII/VI       26395
chrom_freq/VII/VIII     61139
chrom_freq/VII/X        78244
chrom_freq/VII/XI       72809
chrom_freq/VII/XII      106604
chrom_freq/VII/XIII     99757
chrom_freq/VII/XIV      82910
chrom_freq/VII/XV       120348
chrom_freq/VII/XVI      102465
chrom_freq/VIII/II      51300
chrom_freq/VIII/I       17523
chrom_freq/VIII/IV      77708
chrom_freq/VIII/III     24926
chrom_freq/VIII/IX      30868
chrom_freq/VIII/V       36948
chrom_freq/VIII/Mito    2556
chrom_freq/VIII/VII     61322
chrom_freq/VIII/VI      21097
chrom_freq/VIII/VIII    783493
chrom_freq/VIII/X       46110
chrom_freq/VIII/XI      41362
chrom_freq/VIII/XII     55110
chrom_freq/VIII/XIII    52688
chrom_freq/VIII/XIV     46605
chrom_freq/VIII/XV      59915
chrom_freq/VIII/XVI     53370
chrom_freq/X/II 64911
chrom_freq/X/I  19825
chrom_freq/X/IV 97202
chrom_freq/X/III        27243
chrom_freq/X/IX 39003
chrom_freq/X/V  46186
chrom_freq/X/VI 25561
chrom_freq/X/Mito       3426
chrom_freq/X/VII        78285
chrom_freq/X/VIII       45948
chrom_freq/X/X  1088728
chrom_freq/X/XI 55049
chrom_freq/X/XII        66527
chrom_freq/X/XIII       67205
chrom_freq/X/XIV        59266
chrom_freq/X/XV 75011
chrom_freq/X/XVI        68679
chrom_freq/XI/I 17357
chrom_freq/XI/II        59247
chrom_freq/XI/III       24724
chrom_freq/XI/IV        90081
chrom_freq/XI/IX        34927
chrom_freq/XI/V 42758
chrom_freq/XI/Mito      3022
chrom_freq/XI/VI        23570
chrom_freq/XI/VII       73211
chrom_freq/XI/VIII      41219
chrom_freq/XI/X 55201
chrom_freq/XI/XI        966888
chrom_freq/XI/XII       61071
chrom_freq/XI/XIII      62707
chrom_freq/XI/XIV       55319
chrom_freq/XI/XV        71360
chrom_freq/XI/XVI       65554
chrom_freq/XII/II       81136
chrom_freq/XII/I        18160
chrom_freq/XII/III      26894
chrom_freq/XII/IV       143059
chrom_freq/XII/IX       40865
chrom_freq/XII/V        55828
chrom_freq/XII/Mito     6569
chrom_freq/XII/VII      106714
chrom_freq/XII/VI       23474
chrom_freq/XII/VIII     54024
chrom_freq/XII/X        65408
chrom_freq/XII/XI       61005
chrom_freq/XII/XII      1684921
chrom_freq/XII/XIII     89952
chrom_freq/XII/XIV      74333
chrom_freq/XII/XV       108611
chrom_freq/XII/XVI      90371
chrom_freq/XIII/II      78244
chrom_freq/XIII/I       17201
chrom_freq/XIII/III     28972
chrom_freq/XIII/IV      130420
chrom_freq/XIII/IX      41593
chrom_freq/XIII/V       54413
chrom_freq/XIII/Mito    4145
chrom_freq/XIII/VI      23984
chrom_freq/XIII/VII     99222
chrom_freq/XIII/VIII    53299
chrom_freq/XIII/X       66980
chrom_freq/XIII/XI      62898
chrom_freq/XIII/XII     89599
chrom_freq/XIII/XIII    1360931
chrom_freq/XIII/XIV     71472
chrom_freq/XIII/XV      101567
chrom_freq/XIII/XVI     87623
chrom_freq/XIV/I        17948
chrom_freq/XIV/II       67088
chrom_freq/XIV/III      29211
chrom_freq/XIV/IV       107717
chrom_freq/XIV/IX       37879
chrom_freq/XIV/V        47418
chrom_freq/XIV/Mito     3498
chrom_freq/XIV/VII      83421
chrom_freq/XIV/VI       23216
chrom_freq/XIV/VIII     46955
chrom_freq/XIV/X        59860
chrom_freq/XIV/XI       55571
chrom_freq/XIV/XII      74659
chrom_freq/XIV/XIII     72036
chrom_freq/XIV/XIV      1167659
chrom_freq/XIV/XV       82867
chrom_freq/XIV/XVI      72815
chrom_freq/XV/I 17219
chrom_freq/XV/II        93454
chrom_freq/XV/III       28431
chrom_freq/XV/IV        163073
chrom_freq/XV/IX        46643
chrom_freq/XV/V 63107
chrom_freq/XV/Mito      4873
chrom_freq/XV/VII       120436
chrom_freq/XV/VI        25605
chrom_freq/XV/VIII      60278
chrom_freq/XV/X 74970
chrom_freq/XV/XI        71660
chrom_freq/XV/XII       109632
chrom_freq/XV/XIII      101387
chrom_freq/XV/XIV       82656
chrom_freq/XV/XV        1597401
chrom_freq/XV/XVI       103083
chrom_freq/XVI/II       80955
chrom_freq/XVI/I        17004
chrom_freq/XVI/III      28926
chrom_freq/XVI/IV       131060
chrom_freq/XVI/IX       42860
chrom_freq/XVI/V        57334
chrom_freq/XVI/VI       23632
chrom_freq/XVI/Mito     4245
chrom_freq/XVI/VII      102042
chrom_freq/XVI/VIII     53168
chrom_freq/XVI/X        69056
chrom_freq/XVI/XI       64341
chrom_freq/XVI/XII      90951
chrom_freq/XVI/XIII     86979
chrom_freq/XVI/XIV      72701
chrom_freq/XVI/XV       103525
chrom_freq/XVI/XVI      1348592
dist_freq/0-1/+-        290
dist_freq/0-1/-+        298
dist_freq/0-1/--        110893
dist_freq/0-1/++        110723
dist_freq/1-2/+-        762
dist_freq/1-2/-+        712
dist_freq/1-2/--        302
dist_freq/1-2/++        270
dist_freq/2-3/+-        604
dist_freq/2-3/-+        566
dist_freq/2-3/--        50
dist_freq/2-3/++        51
dist_freq/3-6/+-        2414
dist_freq/3-6/-+        2428
dist_freq/3-6/--        147
dist_freq/3-6/++        153
dist_freq/6-10/+-       3332
dist_freq/6-10/-+       3542
dist_freq/6-10/--       83
dist_freq/6-10/++       82
dist_freq/10-18/+-      6285
dist_freq/10-18/-+      6632
dist_freq/10-18/--      199
dist_freq/10-18/++      199
dist_freq/18-32/+-      12309
dist_freq/18-32/-+      12425
dist_freq/18-32/--      325
dist_freq/18-32/++      398
dist_freq/32-56/+-      26508
dist_freq/32-56/-+      26459
dist_freq/32-56/--      5348
dist_freq/32-56/++      5295
dist_freq/56-100/+-     76773
dist_freq/56-100/-+     76851
dist_freq/56-100/--     34249
dist_freq/56-100/++     34143
dist_freq/100-178/+-    353988
dist_freq/100-178/-+    354702
dist_freq/100-178/--    151883
dist_freq/100-178/++    150834
dist_freq/178-316/+-    555295
dist_freq/178-316/-+    556061
dist_freq/178-316/--    243876
dist_freq/178-316/++    244187
dist_freq/316-562/+-    368178
dist_freq/316-562/-+    368509
dist_freq/316-562/--    361037
dist_freq/316-562/++    359370
dist_freq/562-1000/+-   449605
dist_freq/562-1000/-+   451846
dist_freq/562-1000/--   446420
dist_freq/562-1000/++   444720
dist_freq/1000-1778/+-  451299
dist_freq/1000-1778/-+  449793
dist_freq/1000-1778/--  449526
dist_freq/1000-1778/++  448115
dist_freq/1778-3162/+-  395193
dist_freq/1778-3162/-+  395463
dist_freq/1778-3162/--  395437
dist_freq/1778-3162/++  394405
dist_freq/3162-5623/+-  343779
dist_freq/3162-5623/-+  344673
dist_freq/3162-5623/--  345025
dist_freq/3162-5623/++  344432
dist_freq/5623-10000/+- 302576
dist_freq/5623-10000/-+ 302200
dist_freq/5623-10000/-- 303150
dist_freq/5623-10000/++ 302556
dist_freq/10000-17783/+-        266511
dist_freq/10000-17783/-+        265251
dist_freq/10000-17783/--        266163
dist_freq/10000-17783/++        266272
dist_freq/17783-31623/+-        233493
dist_freq/17783-31623/-+        232919
dist_freq/17783-31623/--        233564
dist_freq/17783-31623/++        232944
dist_freq/31623-56234/+-        204497
dist_freq/31623-56234/-+        203860
dist_freq/31623-56234/--        203660
dist_freq/31623-56234/++        203787
dist_freq/56234-100000/+-       177379
dist_freq/56234-100000/-+       177301
dist_freq/56234-100000/--       177454
dist_freq/56234-100000/++       176451
dist_freq/100000-177828/+-      153308
dist_freq/100000-177828/-+      154001
dist_freq/100000-177828/--      154101
dist_freq/100000-177828/++      153892
dist_freq/177828-316228/+-      128702
dist_freq/177828-316228/-+      128470
dist_freq/177828-316228/--      128946
dist_freq/177828-316228/++      128938
dist_freq/316228-562341/+-      96693
dist_freq/316228-562341/-+      97272
dist_freq/316228-562341/--      96583
dist_freq/316228-562341/++      96314
dist_freq/562341-1000000/+-     54855
dist_freq/562341-1000000/-+     55048
dist_freq/562341-1000000/--     55289
dist_freq/562341-1000000/++     54993
dist_freq/1000000-1778279/+-    9108
dist_freq/1000000-1778279/-+    8969
dist_freq/1000000-1778279/--    9047
dist_freq/1000000-1778279/++    8990
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
dist_freq/100000000-177827941/+-        0
dist_freq/100000000-177827941/-+        0
dist_freq/100000000-177827941/--        0
dist_freq/100000000-177827941/++        0
dist_freq/177827941-316227766/+-        0
dist_freq/177827941-316227766/-+        0
dist_freq/177827941-316227766/--        0
dist_freq/177827941-316227766/++        0
dist_freq/316227766-562341325/+-        0
dist_freq/316227766-562341325/-+        0
dist_freq/316227766-562341325/--        0
dist_freq/316227766-562341325/++        0
dist_freq/562341325-1000000000/+-       0
dist_freq/562341325-1000000000/-+       0
dist_freq/562341325-1000000000/--       0
dist_freq/562341325-1000000000/++       0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```
</details>
<br />
</details>
<br />

<a id="notes"></a>
#### Notes
<details>
<summary><i>Notes: Run pairtools dedup</i></summary>

It appears that, in the calls to [`pairtools split`](#code-7), alignments/reads are not being written to bams. It appears that the bam header is written (see below), but the bam body is not (see below)&mdash;it seems a bit of compressed text is written to the body.
```txt
❯ samtools view "${a_dedup_pre_bam}"


❯ samtools view "${a_dup_pre_bam}"


❯ samtools view "${a_unmap_pre_bam}"


❯ zcat "${a_dedup_pre_bam}"
BAM@SQ  SN:I    LN:230218
@SQ     SN:II   LN:813184
@SQ     SN:III  LN:316620
@SQ     SN:IV   LN:1531933
@SQ     SN:V    LN:576874
@SQ     SN:VI   LN:270161
@SQ     SN:VII  LN:1090940
@SQ     SN:VIII LN:562643
@SQ     SN:IX   LN:439888
@SQ     SN:X    LN:745751
@SQ     SN:XI   LN:666816
@SQ     SN:XII  LN:1078177
@SQ     SN:XIII LN:924431
@SQ     SN:XIV  LN:784333
@SQ     SN:XV   LN:1091291
@SQ     SN:XVI  LN:948066
@SQ     SN:Mito LN:85779
@PG     ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
@PG     ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
@PG     ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
@PG     ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
@PG     ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort       VN:1.0.2
@PG     ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.nodups.pairs.gz --output-sam dedup/bam/SRR7939018.nodups.bam PP:pairtools_dedup      VN:1.0.2
@PG     ID:samtools.1   PN:samtools     PP:pairtools_split      VN:1.16.1       CL:samtools view -bS -@ 7 -
IJIIh
     IIIIV`VjVIQVII|VIIIIXPXa
                             XI,
XIIsXIII


❯ zcat "${a_dup_pre_bam}"
BAM@SQ  SN:I    LN:230218
@SQ     SN:II   LN:813184
@SQ     SN:III  LN:316620
@SQ     SN:IV   LN:1531933
@SQ     SN:V    LN:576874
@SQ     SN:VI   LN:270161
@SQ     SN:VII  LN:1090940
@SQ     SN:VIII LN:562643
@SQ     SN:IX   LN:439888
@SQ     SN:X    LN:745751
@SQ     SN:XI   LN:666816
@SQ     SN:XII  LN:1078177
@SQ     SN:XIII LN:924431
@SQ     SN:XIV  LN:784333
@SQ     SN:XV   LN:1091291
@SQ     SN:XVI  LN:948066
@SQ     SN:Mito LN:85779
@PG     ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
@PG     ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
@PG     ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
@PG     ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
@PG     ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort       VN:1.0.2
@PG     ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.dups.pairs.gz --output-sam dedup/bam/SRR7939018.dups.bam     PP:pairtools_dedup      VN:1.0.2
@PG     ID:samtools.1   PN:samtools     PP:pairtools_split      VN:1.16.1       CL:samtools view -bS -@ 7 -
IJIIh
     IIIIV`VjVIQVII|VIIIIXPXa
                             XI,
XIIsXIII


❯ zcat "${a_unmap_pre_bam}"
BAM@SQ  SN:I    LN:230218
@SQ     SN:II   LN:813184
@SQ     SN:III  LN:316620
@SQ     SN:IV   LN:1531933
@SQ     SN:V    LN:576874
@SQ     SN:VI   LN:270161
@SQ     SN:VII  LN:1090940
@SQ     SN:VIII LN:562643
@SQ     SN:IX   LN:439888
@SQ     SN:X    LN:745751
@SQ     SN:XI   LN:666816
@SQ     SN:XII  LN:1078177
@SQ     SN:XIII LN:924431
@SQ     SN:XIV  LN:784333
@SQ     SN:XV   LN:1091291
@SQ     SN:XVI  LN:948066
@SQ     SN:Mito LN:85779
@PG     ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 16 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
@PG     ID:samtools     PN:samtools     PP:bwa  VN:1.16.1       CL:samtools view -@ 16 -S -b
@PG     ID:pairtools_parse      PN:pairtools_parse      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse -o pairs/SRR7939018.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --drop-sam --drop-seq --output-stats stats/SRR7939018.stats.txt --assembly S288C_R64-3-1 --no-flip --add-columns mapq --walks-policy mask bams/SRR7939018.bam  PP:samtools     VN:1.0.2
@PG     ID:pairtools_sort       PN:pairtools_sort       CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 16 --tmpdir /fh/scratch/delete30/tsukiyama_t --output pairs/SRR7939018.sort.txt.gz pairs/SRR7939018.txt.gz  PP:pairtools_parse      VN:1.0.2
@PG     ID:pairtools_dedup      PN:pairtools_dedup      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 16 --max-mismatch 3 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats stats/SRR7939018.dedup.stats.txt pairs/SRR7939018.sort.txt.gz    PP:pairtools_sort       VN:1.0.2
@PG     ID:pairtools_split      PN:pairtools_split      CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs dedup/pairs/SRR7939018.unmapped.pairs.gz --output-sam dedup/bam/SRR7939018.unmapped.bam     PP:pairtools_dedup      VN:1.0.2
@PG     ID:samtools.1   PN:samtools     PP:pairtools_split      VN:1.16.1       CL:samtools view -bS -@ 7 -
IJIIh
     IIIIV`VjVIQVII|VIIIIXPXa
                             XI,
XIIsXIII
```

`#TODO` Make a minimal example to reproduce the problem and [file an issue with the `pairtools` team](https://github.com/open2c/pairtools/issues).
</details>
<br />

<a id="5-run-pairtools-select"></a>
### 5. Run `pairtools select`
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Run pairtools select</i></summary>

```bash
#!/bin/bash

#  Check the documentation ----------------------------------------------------
```
</details>
<br />

<a id="printed-7"></a>
#### Printed
<details>
<summary><i>Printed: Run pairtools select</i></summary>

<a id="check-the-documentation-3"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt


```
</details>
<br />

<a id="pairtools-select"></a>
##### `pairtools select`
<details>
<summary><i>Printed: pairtools select</i></summary>

```txt


```
</details>
<br />
</details>
<br />

<a id="6-run-pairtools-stats"></a>
### 6. Run `pairtools stats`
Is this any different from collecting stats when running [`pairtools dedup`](#code-7) or [`pairtools parse`](#code-5)?

<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: 5. Run pairtools stats</i></summary>

```bash
#!/bin/bash

#  Check the documentation ----------------------------------------------------
pairtools stats --help


#  Do a trial run of pairtools stats ------------------------------------------

```
</details>
<br />

<a id="printed-8"></a>
#### Printed
<details>
<summary><i>Printed: 5. Run pairtools stats</i></summary>

<a id="check-the-documentation-4"></a>
##### Check the documentation
<details>
<summary><i>Printed: Check the documentation</i></summary>

```txt
❯ pairtools stats --help
Usage: pairtools stats [OPTIONS] [INPUT_PATH]...

  Calculate pairs statistics.

  INPUT_PATH : by default, a .pairs/.pairsam file to calculate statistics. If
  not provided, the input is read from stdin. If --merge is specified, then
  INPUT_PATH is interpreted as an arbitrary number of stats files to merge.

  The files with paths ending with .gz/.lz4 are decompressed by bgzip/lz4c.

Options:
  -o, --output TEXT               output stats tsv file.
  --merge                         If specified, merge multiple input stats
                                  files instead of calculating statistics of a
                                  .pairs/.pairsam file. Merging is performed
                                  via summation of all overlapping statistics.
                                  Non-overlapping statistics are appended to
                                  the end of the file. Supported for tsv stats
                                  with single filter.
  --with-chromsizes / --no-chromsizes
                                  If enabled, will store sizes of chromosomes
                                  from the header of the pairs file in the
                                  stats file.
  --yaml / --no-yaml              Output stats in yaml format instead of
                                  table.
  --bytile-dups / --no-bytile-dups
                                  If enabled, will analyse by-tile duplication
                                  statistics to estimate library complexity
                                  more accurately. Requires parent_readID
                                  column to be saved by dedup (will be ignored
                                  otherwise) Saves by-tile stats into
                                  --output_bytile-stats stream, or regular
                                  output if --output_bytile-stats is not
                                  provided.
  --output-bytile-stats TEXT      output file for tile duplicate statistics.
                                  If file exists, it will be open in the
                                  append mode. If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4c-compressed.
                                  By default, by-tile duplicate statistics are
                                  not printed. Note that the readID and
                                  parent_readID should be provided and contain
                                  tile information for this option.
  --filter TEXT                   Filters with conditions to apply to the data
                                  (similar to `pairtools select`). For non-
                                  YAML output only the first filter will be
                                  reported. Example: pairtools stats --yaml
                                  --filter 'unique:(pair_type=="UU")' --filter
                                  'close:(pair_type=="UU") and
                                  (abs(pos1-pos2)<10)' test.pairs
  --engine TEXT                   Engine for regular expression parsing.
                                  Python will provide you regex functionality,
                                  while pandas does not accept custom
                                  funtctions and works faster.
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
</details>
<br />

<a id="7-load-pairs-to-cooler"></a>
### 7. Load pairs to cooler
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: 6. Load pairs to cooler</i></summary>

```bash
#!/bin/bash


```
</details>
<br />

<a id="printed-9"></a>
#### Printed
<details>
<summary><i>Printed: 6. Load pairs to cooler</i></summary>

```txt


```
</details>
<br />
