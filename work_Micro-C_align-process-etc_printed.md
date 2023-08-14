
`#work_Micro-C_align-process.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Install packages necessary for Micro-C processing, analysis](#install-packages-necessary-for-micro-c-processing-analysis)
    1. [Remote and local \(work\) installations](#remote-and-local-work-installations)
        1. [Install mamba packages](#install-mamba-packages)
            1. [Printed](#printed)
        1. [Install atria](#install-atria)
            1. [Printed](#printed-1)
        1. [Install HiGlass](#install-higlass)
            1. [Printed](#printed-2)
        1. [Install Clodius and bedops](#install-clodius-and-bedops)
            1. [Printed](#printed-3)
1. [Set up the Micro-C processing workflow](#set-up-the-micro-c-processing-workflow)
    1. [0. Get situated](#0-get-situated)
        1. [Get to work directory, initialize environment](#get-to-work-directory-initialize-environment)
            1. [Start or enter `tmux` session](#start-or-enter-tmux-session)
            1. [`grabnode`](#grabnode)
            1. [Go to work directory, initialize environment](#go-to-work-directory-initialize-environment)
                1. [Printed](#printed-4)
        1. [Symlink to and rename files of interest](#symlink-to-and-rename-files-of-interest)
            1. [Initialize variables and arrays, run checks](#initialize-variables-and-arrays-run-checks)
                1. [Printed](#printed-5)
            1. [Symlink to and rename the `fastq`s](#symlink-to-and-rename-the-fastqs)
                1. [Printed](#printed-6)
        1. [Initialize variables, create outdirectories](#initialize-variables-create-outdirectories)
            1. [What datasets do we want to work with?](#what-datasets-do-we-want-to-work-with)
                1. [Notes](#notes)
            1. [Initialize "general" variables for workflow](#initialize-general-variables-for-workflow)
                1. [Printed](#printed-7)
            1. [Initialize "specific" variables, arrays for workflow](#initialize-specific-variables-arrays-for-workflow)
            1. [Run print tests for the variables, arrays](#run-print-tests-for-the-variables-arrays)
            1. [Initialize "specific" variables, arrays for `pairtools merge`](#initialize-specific-variables-arrays-for-pairtools-merge)
            1. [Run print tests for `pairtools merge` variables, arrays](#run-print-tests-for-pairtools-merge-variables-arrays)
            1. [Initialize varibales, arrays for "`standard-rDNA-complete`" processing](#initialize-varibales-arrays-for-standard-rdna-complete-processing)
            1. [Create outdirectories if not present](#create-outdirectories-if-not-present)
                1. [Printed](#printed-8)
    1. [1. Trim `fastq` files](#1-trim-fastq-files)
        1. [Printed](#printed-9)
    1. [2. Align datasets](#2-align-datasets)
        1. [Printed](#printed-10)
    1. [3. Run `pairtools parse2`](#3-run-pairtools-parse2)
        1. [Printed](#printed-11)
            1. [Check the documentation](#check-the-documentation)
                1. [`pairtools parse`](#pairtools-parse)
                1. [`pairtools parse2`](#pairtools-parse2)
            1. [Run `pairtools parse`](#run-pairtools-parse)
            1. [Run `pairtools parse2`](#run-pairtools-parse2)
                1. [Testing the standard call to `pairtools parse2`](#testing-the-standard-call-to-pairtools-parse2)
                1. [Testing the "`keep-MM`" call to `pairtools parse2`](#testing-the-keep-mm-call-to-pairtools-parse2)
            1. [Examine the pairs outfile](#examine-the-pairs-outfile)
                1. [Testing the standard call to `pairtools parse2`](#testing-the-standard-call-to-pairtools-parse2-1)
                1. [Testing the "`keep-MM`" call to `pairtools parse2`](#testing-the-keep-mm-call-to-pairtools-parse2-1)
            1. [Examine the stats outfile](#examine-the-stats-outfile)
                1. [Testing the standard call to `pairtools parse2`](#testing-the-standard-call-to-pairtools-parse2-2)
                1. [Testing the "`keep-MM`" call to `pairtools parse2`](#testing-the-keep-mm-call-to-pairtools-parse2-2)
    1. [4. Run `pairtools sort`](#4-run-pairtools-sort)
        1. [Printed](#printed-12)
            1. [Check the documentation](#check-the-documentation-1)
            1. [Run `pairtools sort`](#run-pairtools-sort)
                1. [Testing the standard call to `pairtools parse2`](#testing-the-standard-call-to-pairtools-parse2-3)
                1. [Testing the "rDNA" call to `pairtools parse2`](#testing-the-rdna-call-to-pairtools-parse2)
            1. [Examine the sorted pairs outfile](#examine-the-sorted-pairs-outfile)
                1. [Testing the standard call to `pairtools parse2`](#testing-the-standard-call-to-pairtools-parse2-4)
                1. [Testing the "rDNA" call to `pairtools parse2`](#testing-the-rdna-call-to-pairtools-parse2-1)
    1. [5. Run `pairtools dedup` and `pairtools split`](#5-run-pairtools-dedup-and-pairtools-split)
    1. [X. Run `pairtools merge` if applicable](#x-run-pairtools-merge-if-applicable)
    1. [X. Run "`standard-rDNA-complete`" processing if applicable](#x-run-standard-rdna-complete-processing-if-applicable)
        1. [A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file](#a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file)
        1. [B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM.nodups`" file](#b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mmnodups-file)
        1. [C. Merge the "`standard.nodups`" and "`keep-MM.nodups`" files](#c-merge-the-standardnodups-and-keep-mmnodups-files)
    1. [6. Run `pairtools stats`](#6-run-pairtools-stats)
        1. [Individual pairs files](#individual-pairs-files)
    1. [7. Load pairs to cooler](#7-load-pairs-to-cooler)
        1. [Individual pairs file](#individual-pairs-file)
    1. [8. Generate a multi-resolution cooler by coarsening](#8-generate-a-multi-resolution-cooler-by-coarsening)
        1. [Cools from individual pairs files](#cools-from-individual-pairs-files)
    1. [9. Ingest files for HiGlass](#9-ingest-files-for-higlass)
        1. [Printed: TBD 1](#printed-tbd-1)
        1. [Printed: TBD 2](#printed-tbd-2)

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
<a id="printed"></a>
##### Printed
<details>
<summary><i>Printed: Install mamba packages</i></summary>

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


❯ mamba install \
>         -c conda-forge \
>             pbzip2 \
>             pigz \
>             r-tidyverse \
>             r-argparse \
>             r-plotly \
>             r-ggsci

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


Looking for: ['pbzip2', 'pigz', 'r-tidyverse', 'r-argparse', 'r-plotly', 'r-ggsci']

bioconda/noarch                                      4.3MB @   4.0MB/s  1.2s
pkgs/main/linux-64                                   5.9MB @   4.5MB/s  1.6s
bioconda/linux-64                                    5.0MB @   2.9MB/s  1.9s
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
conda-forge/noarch                                  13.2MB @   4.0MB/s  3.8s
conda-forge/linux-64                                32.9MB @   4.4MB/s  8.7s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/pairtools_env

  Updating specs:

   - pbzip2
   - pigz
   - r-tidyverse
   - r-argparse
   - r-plotly
   - r-ggsci
   - ca-certificates
   - certifi
   - openssl


  Package                      Version  Build             Channel                    Size
───────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                     1.0.1  anacondar_1       conda-forge/noarch       Cached
  + binutils_impl_linux-64        2.40  hf600244_0        conda-forge/linux-64     Cached
  + bwidget                     1.9.14  ha770c72_1        conda-forge/linux-64     Cached
  + cairo                       1.16.0  hbbf8b49_1016     conda-forge/linux-64        1MB
  + curl                         8.1.2  h409715c_0        conda-forge/linux-64       91kB
  + expat                        2.5.0  hcb278e6_1        conda-forge/linux-64     Cached
  + font-ttf-dejavu-sans-mono     2.37  hab24e00_0        conda-forge/noarch       Cached
  + font-ttf-inconsolata         3.000  h77eed37_0        conda-forge/noarch       Cached
  + font-ttf-source-code-pro     2.038  h77eed37_0        conda-forge/noarch       Cached
  + font-ttf-ubuntu               0.83  hab24e00_0        conda-forge/noarch       Cached
  + fontconfig                  2.14.2  h14ed4e7_0        conda-forge/linux-64     Cached
  + fonts-conda-ecosystem            1  0                 conda-forge/noarch       Cached
  + fonts-conda-forge                1  0                 conda-forge/noarch       Cached
  + fribidi                     1.0.10  h36c2ea0_0        conda-forge/linux-64     Cached
  + gcc_impl_linux-64           13.1.0  hc4be1a9_0        conda-forge/linux-64       54MB
  + gettext                     0.21.1  h27087fc_0        conda-forge/linux-64     Cached
  + gfortran_impl_linux-64      13.1.0  hd511a9b_0        conda-forge/linux-64       16MB
  + graphite2                   1.3.13  h58526e2_1001     conda-forge/linux-64     Cached
  + gsl                            2.7  he838d99_0        conda-forge/linux-64     Cached
  + gxx_impl_linux-64           13.1.0  hc4be1a9_0        conda-forge/linux-64       13MB
  + harfbuzz                     7.3.0  hdb3a94d_0        conda-forge/linux-64        1MB
  + icu                           72.1  hcb278e6_0        conda-forge/linux-64     Cached
  + kernel-headers_linux-64     2.6.32  he073ed8_15       conda-forge/noarch       Cached
  + libexpat                     2.5.0  hcb278e6_1        conda-forge/linux-64     Cached
  + libgcc-devel_linux-64       13.1.0  he3cc6c4_0        conda-forge/linux-64        2MB
  + libglib                     2.76.3  hebfc3b9_0        conda-forge/linux-64        3MB
  + libiconv                      1.17  h166bdaf_0        conda-forge/linux-64     Cached
  + libsanitizer                13.1.0  hfd8a6a1_0        conda-forge/linux-64        4MB
  + libstdcxx-devel_linux-64    13.1.0  he3cc6c4_0        conda-forge/linux-64        9MB
  + libxml2                     2.11.4  h0d562d8_0        conda-forge/linux-64     Cached
  + make                           4.3  hd18ef5c_1        conda-forge/linux-64     Cached
  + pandoc                      2.19.2  h32600fe_2        conda-forge/linux-64       27MB
  + pango                      1.50.14  heaa33ce_1        conda-forge/linux-64     Cached
  + pbzip2                      1.1.13  0                 conda-forge/linux-64     Cached
  + pcre2                        10.40  hc3806b6_0        conda-forge/linux-64     Cached
  + pigz                           2.6  h27826a3_0        conda-forge/linux-64     Cached
  + pixman                      0.40.0  h36c2ea0_0        conda-forge/linux-64     Cached
  + r-argparse                   2.2.2  r43hc72bb7e_1     conda-forge/noarch        158kB
  + r-askpass                      1.1  r43h57805ef_4     conda-forge/linux-64       30kB
  + r-assertthat                 0.2.1  r43hc72bb7e_4     conda-forge/noarch         72kB
  + r-backports                  1.4.1  r43h57805ef_2     conda-forge/linux-64      109kB
  + r-base                       4.3.0  hfabd6f2_1        conda-forge/linux-64       26MB
  + r-base64enc                  0.1_3  r43h57805ef_1006  conda-forge/linux-64       45kB
  + r-bit                        4.0.5  r43h57805ef_1     conda-forge/linux-64        1MB
  + r-bit64                      4.0.5  r43h57805ef_2     conda-forge/linux-64      486kB
  + r-blob                       1.2.4  r43hc72bb7e_1     conda-forge/noarch         66kB
  + r-broom                      1.0.5  r43hc72bb7e_1     conda-forge/noarch          2MB
  + r-bslib                      0.5.0  r43hc72bb7e_1     conda-forge/noarch          4MB
  + r-cachem                     1.0.8  r43h57805ef_1     conda-forge/linux-64       75kB
  + r-callr                      3.7.3  r43hc72bb7e_1     conda-forge/noarch        417kB
  + r-cellranger                 1.1.0  r43hc72bb7e_1006  conda-forge/noarch        108kB
  + r-cli                        3.6.1  r43ha503ecb_1     conda-forge/linux-64        1MB
  + r-clipr                      0.8.0  r43hc72bb7e_2     conda-forge/noarch         70kB
  + r-colorspace                 2.1_0  r43h57805ef_1     conda-forge/linux-64        2MB
  + r-conflicted                 1.2.0  r43h785f33e_1     conda-forge/noarch         63kB
  + r-cpp11                      0.4.4  r43hc72bb7e_0     conda-forge/noarch        234kB
  + r-crayon                     1.5.2  r43hc72bb7e_2     conda-forge/noarch        164kB
  + r-crosstalk                  1.2.0  r43hc72bb7e_2     conda-forge/noarch        373kB
  + r-curl                       5.0.1  r43hf9611b0_0     conda-forge/linux-64      451kB
  + r-data.table                1.14.8  r43h029312a_2     conda-forge/linux-64        2MB
  + r-dbi                        1.1.3  r43hc72bb7e_2     conda-forge/noarch        721kB
  + r-dbplyr                     2.3.2  r43hc72bb7e_1     conda-forge/noarch          1MB
  + r-digest                    0.6.31  r43ha503ecb_1     conda-forge/linux-64      192kB
  + r-dplyr                      1.1.2  r43ha503ecb_1     conda-forge/linux-64        1MB
  + r-dtplyr                     1.3.1  r43hc72bb7e_1     conda-forge/noarch        354kB
  + r-ellipsis                   0.3.2  r43h57805ef_2     conda-forge/linux-64       43kB
  + r-evaluate                    0.21  r43hc72bb7e_1     conda-forge/noarch         89kB
  + r-fansi                      1.0.4  r43h57805ef_1     conda-forge/linux-64      315kB
  + r-farver                     2.1.1  r43ha503ecb_2     conda-forge/linux-64        1MB
  + r-fastmap                    1.1.1  r43ha503ecb_1     conda-forge/linux-64       72kB
  + r-findpython                 1.0.8  r43hc72bb7e_1     conda-forge/noarch         29kB
  + r-fontawesome                0.5.1  r43hc72bb7e_1     conda-forge/noarch          1MB
  + r-forcats                    1.0.0  r43hc72bb7e_1     conda-forge/noarch        422kB
  + r-fs                         1.6.2  r43ha503ecb_1     conda-forge/linux-64      495kB
  + r-gargle                     1.5.1  r43h785f33e_0     conda-forge/noarch        707kB
  + r-generics                   0.1.3  r43hc72bb7e_2     conda-forge/noarch         91kB
  + r-ggplot2                    3.4.2  r43hc72bb7e_1     conda-forge/noarch          4MB
  + r-ggsci                      3.0.0  r43hc72bb7e_1     conda-forge/noarch          2MB
  + r-glue                       1.6.2  r43h57805ef_2     conda-forge/linux-64      151kB
  + r-googledrive                2.1.1  r43hc72bb7e_1     conda-forge/noarch          1MB
  + r-googlesheets4              1.1.1  r43h785f33e_1     conda-forge/noarch        513kB
  + r-gtable                     0.3.3  r43hc72bb7e_1     conda-forge/noarch        222kB
  + r-haven                      2.5.3  r43ha503ecb_0     conda-forge/linux-64      376kB
  + r-hexbin                    1.28.3  r43h61816a4_1     conda-forge/linux-64        2MB
  + r-highr                       0.10  r43hc72bb7e_1     conda-forge/noarch         58kB
  + r-hms                        1.1.3  r43hc72bb7e_1     conda-forge/noarch        107kB
  + r-htmltools                  0.5.5  r43ha503ecb_1     conda-forge/linux-64      355kB
  + r-htmlwidgets                1.6.2  r43hc72bb7e_1     conda-forge/noarch        423kB
  + r-httr                       1.4.6  r43hc72bb7e_1     conda-forge/noarch        483kB
  + r-ids                        1.0.1  r43hc72bb7e_3     conda-forge/noarch        127kB
  + r-isoband                    0.2.7  r43ha503ecb_2     conda-forge/linux-64        2MB
  + r-jquerylib                  0.1.4  r43hc72bb7e_2     conda-forge/noarch        305kB
  + r-jsonlite                   1.8.7  r43h57805ef_0     conda-forge/linux-64      634kB
  + r-knitr                       1.43  r43hc72bb7e_1     conda-forge/noarch          1MB
  + r-labeling                   0.4.2  r43hc72bb7e_3     conda-forge/noarch         69kB
  + r-later                      1.3.1  r43ha503ecb_1     conda-forge/linux-64      131kB
  + r-lattice                   0.21_8  r43h57805ef_1     conda-forge/linux-64        1MB
  + r-lazyeval                   0.2.2  r43h57805ef_4     conda-forge/linux-64      159kB
  + r-lifecycle                  1.0.3  r43hc72bb7e_2     conda-forge/noarch        122kB
  + r-lubridate                  1.9.2  r43h57805ef_2     conda-forge/linux-64      982kB
  + r-magrittr                   2.0.3  r43h57805ef_2     conda-forge/linux-64      209kB
  + r-mass                      7.3_60  r43h57805ef_1     conda-forge/linux-64        1MB
  + r-matrix                   1.5_4.1  r43h316c678_1     conda-forge/linux-64        4MB
  + r-memoise                    2.0.1  r43hc72bb7e_2     conda-forge/noarch         56kB
  + r-mgcv                      1.8_42  r43h316c678_2     conda-forge/linux-64        3MB
  + r-mime                        0.12  r43h57805ef_2     conda-forge/linux-64       53kB
  + r-modelr                    0.1.11  r43hc72bb7e_1     conda-forge/noarch        221kB
  + r-munsell                    0.5.0  r43hc72bb7e_1006  conda-forge/noarch        244kB
  + r-nlme                     3.1_162  r43h61816a4_1     conda-forge/linux-64        2MB
  + r-openssl                    2.0.6  r43hb353fa6_1     conda-forge/linux-64      637kB
  + r-pillar                     1.9.0  r43hc72bb7e_1     conda-forge/noarch        617kB
  + r-pkgconfig                  2.0.3  r43hc72bb7e_3     conda-forge/noarch         26kB
  + r-plotly                    4.10.2  r43hc72bb7e_1     conda-forge/noarch          3MB
  + r-prettyunits                1.1.1  r43hc72bb7e_3     conda-forge/noarch         42kB
  + r-processx                   3.8.2  r43h57805ef_0     conda-forge/linux-64      322kB
  + r-progress                   1.2.2  r43hc72bb7e_4     conda-forge/noarch         92kB
  + r-promises                 1.2.0.1  r43ha503ecb_2     conda-forge/linux-64        2MB
  + r-ps                         1.7.5  r43h57805ef_1     conda-forge/linux-64      313kB
  + r-purrr                      1.0.1  r43h57805ef_1     conda-forge/linux-64      483kB
  + r-r6                         2.5.1  r43hc72bb7e_2     conda-forge/noarch         90kB
  + r-ragg                       1.2.5  r43h85cdef0_2     conda-forge/linux-64      438kB
  + r-rappdirs                   0.3.3  r43h57805ef_2     conda-forge/linux-64       52kB
  + r-rcolorbrewer               1.1_3  r43h785f33e_2     conda-forge/noarch         68kB
  + r-rcpp                      1.0.10  r43ha503ecb_1     conda-forge/linux-64        2MB
  + r-readr                      2.1.4  r43ha503ecb_1     conda-forge/linux-64      820kB
  + r-readxl                     1.4.2  r43ha5c9fba_1     conda-forge/linux-64      758kB
  + r-rematch                    1.0.1  r43hc72bb7e_1006  conda-forge/noarch         21kB
  + r-rematch2                   2.1.2  r43hc72bb7e_3     conda-forge/noarch         54kB
  + r-reprex                     2.0.2  r43hc72bb7e_2     conda-forge/noarch        502kB
  + r-rlang                      1.1.1  r43ha503ecb_1     conda-forge/linux-64        2MB
  + r-rmarkdown                   2.23  r43hc72bb7e_0     conda-forge/noarch          2MB
  + r-rstudioapi                  0.14  r43hc72bb7e_2     conda-forge/noarch        293kB
  + r-rvest                      1.0.3  r43hc72bb7e_2     conda-forge/noarch        214kB
  + r-sass                       0.4.6  r43ha503ecb_1     conda-forge/linux-64        2MB
  + r-scales                     1.2.1  r43hc72bb7e_2     conda-forge/noarch        595kB
  + r-selectr                    0.4_2  r43hc72bb7e_3     conda-forge/noarch        421kB
  + r-stringi                   1.7.12  r43hc0c3e09_2     conda-forge/linux-64      898kB
  + r-stringr                    1.5.0  r43h785f33e_1     conda-forge/noarch        296kB
  + r-sys                        3.4.2  r43h57805ef_1     conda-forge/linux-64       49kB
  + r-systemfonts                1.0.4  r43haf97adc_2     conda-forge/linux-64      255kB
  + r-textshaping                0.3.6  r43h24cd192_6     conda-forge/linux-64      110kB
  + r-tibble                     3.2.1  r43h57805ef_2     conda-forge/linux-64      612kB
  + r-tidyr                      1.3.0  r43ha503ecb_1     conda-forge/linux-64        1MB
  + r-tidyselect                 1.2.0  r43hc72bb7e_1     conda-forge/linux-64      215kB
  + r-tidyverse                  2.0.0  r43h785f33e_1     conda-forge/noarch        425kB
  + r-timechange                 0.2.0  r43ha503ecb_1     conda-forge/linux-64      201kB
  + r-tinytex                     0.45  r43hc72bb7e_1     conda-forge/noarch        142kB
  + r-tzdb                       0.4.0  r43ha503ecb_1     conda-forge/linux-64      537kB
  + r-utf8                       1.2.3  r43h57805ef_1     conda-forge/linux-64      143kB
  + r-uuid                       1.1_0  r43h57805ef_2     conda-forge/linux-64       52kB
  + r-vctrs                      0.6.3  r43ha503ecb_0     conda-forge/linux-64        1MB
  + r-viridislite                0.4.2  r43hc72bb7e_1     conda-forge/noarch          1MB
  + r-vroom                      1.6.3  r43ha503ecb_1     conda-forge/linux-64      890kB
  + r-withr                      2.5.0  r43hc72bb7e_2     conda-forge/noarch        239kB
  + r-xfun                        0.39  r43ha503ecb_1     conda-forge/linux-64      424kB
  + r-xml2                       1.3.4  r43h1ad5fc0_2     conda-forge/linux-64      302kB
  + r-yaml                       2.3.7  r43h57805ef_1     conda-forge/linux-64      116kB
  + sed                            4.8  he412f7d_0        conda-forge/linux-64     Cached
  + sysroot_linux-64              2.12  he073ed8_15       conda-forge/noarch       Cached
  + tktable                       2.10  hb7b940f_3        conda-forge/linux-64     Cached
  + xorg-kbproto                 1.0.7  h7f98852_1002     conda-forge/linux-64     Cached
  + xorg-libice                 1.0.10  h7f98852_0        conda-forge/linux-64     Cached
  + xorg-libsm                   1.2.3  hd9c2040_1000     conda-forge/linux-64     Cached
  + xorg-libx11                  1.8.6  h8ee46fc_0        conda-forge/linux-64      829kB
  + xorg-libxext                 1.3.4  h0b41bf4_2        conda-forge/linux-64     Cached
  + xorg-libxrender             0.9.11  hd590300_0        conda-forge/linux-64       38kB
  + xorg-libxt                   1.3.0  hd590300_0        conda-forge/linux-64      380kB
  + xorg-renderproto            0.11.1  h7f98852_1002     conda-forge/linux-64     Cached
  + xorg-xextproto               7.3.0  h0b41bf4_1003     conda-forge/linux-64     Cached
  + xorg-xproto                 7.0.31  h7f98852_1007     conda-forge/linux-64     Cached

  Upgrade:
───────────────────────────────────────────────────────────────────────────────────────────

  - libtiff                      4.5.0  ha587672_6        conda-forge
  + libtiff                      4.5.1  h8b53f26_0        conda-forge/linux-64      418kB

  Summary:

  Install: 170 packages
  Upgrade: 1 packages

  Total download: 242MB

───────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
curl                                                90.7kB @ 931.5kB/s  0.1s
libgcc-devel_linux-64                                2.4MB @  12.8MB/s  0.2s
libsanitizer                                         4.1MB @  20.2MB/s  0.3s
libtiff                                            418.2kB @   1.6MB/s  0.3s
libstdcxx-devel_linux-64                             9.2MB @  35.5MB/s  0.3s
r-jsonlite                                         634.1kB @   1.6MB/s  0.1s
r-data.table                                         1.9MB @   4.1MB/s  0.2s
r-xfun                                             424.5kB @ 921.6kB/s  0.1s
cairo                                                1.1MB @   2.3MB/s  0.5s
r-uuid                                              52.5kB @  93.9kB/s  0.1s
r-rcpp                                               2.0MB @   3.1MB/s  0.2s
r-fansi                                            314.8kB @ 475.7kB/s  0.1s
r-fs                                               494.9kB @ 744.8kB/s  0.1s
r-stringi                                          897.5kB @   1.1MB/s  0.1s
r-glue                                             151.4kB @ 187.9kB/s  0.1s
r-base64enc                                         45.4kB @  56.3kB/s  0.2s
r-bit64                                            486.0kB @ 515.0kB/s  0.1s
r-askpass                                           29.9kB @  31.6kB/s  0.2s
r-nlme                                               2.3MB @   2.2MB/s  0.3s
r-openssl                                          637.2kB @ 605.5kB/s  0.1s
r-mgcv                                               3.2MB @   2.8MB/s  0.2s
r-pkgconfig                                         26.4kB @  23.0kB/s  0.1s
r-crayon                                           164.1kB @ 142.6kB/s  0.1s
gfortran_impl_linux-64                              15.9MB @  12.4MB/s  1.1s
r-withr                                            238.9kB @ 185.3kB/s  0.1s
r-findpython                                        29.4kB @  22.8kB/s  0.1s
r-r6                                                90.4kB @  70.0kB/s  0.1s
r-munsell                                          244.1kB @ 174.0kB/s  0.1s
r-lifecycle                                        121.6kB @  86.6kB/s  0.2s
r-memoise                                           55.9kB @  39.7kB/s  0.2s
r-ids                                              126.9kB @  90.2kB/s  0.2s
r-gtable                                           222.2kB @ 138.7kB/s  0.2s
r-scales                                           595.3kB @ 370.9kB/s  0.2s
r-conflicted                                        63.2kB @  39.3kB/s  0.2s
r-gargle                                           706.6kB @ 439.2kB/s  0.3s
r-textshaping                                      109.9kB @  61.4kB/s  0.2s
r-tidyselect                                       215.4kB @ 120.1kB/s  0.2s
r-purrr                                            483.3kB @ 269.3kB/s  0.2s
r-ragg                                             438.1kB @ 243.8kB/s  0.3s
r-selectr                                          421.1kB @ 215.3kB/s  0.2s
r-htmlwidgets                                      423.2kB @ 216.1kB/s  0.2s
r-reprex                                           501.9kB @ 256.0kB/s  0.2s
r-tibble                                           612.4kB @ 312.1kB/s  0.3s
r-forcats                                          422.4kB @ 197.3kB/s  0.2s
r-dtplyr                                           354.5kB @ 165.0kB/s  0.2s
r-base                                              25.7MB @  11.4MB/s  2.1s
r-dbplyr                                             1.1MB @ 484.4kB/s  0.3s
xorg-libxt                                         380.1kB @ 167.9kB/s  0.1s
r-ps                                               312.7kB @ 130.6kB/s  0.2s
r-sys                                               49.0kB @  20.5kB/s  0.1s
r-colorspace                                         2.5MB @   1.0MB/s  0.2s
r-utf8                                             142.7kB @  57.1kB/s  0.1s
r-farver                                             1.4MB @ 568.4kB/s  0.2s
r-ggplot2                                            4.1MB @   1.7MB/s  0.6s
r-digest                                           192.4kB @  73.9kB/s  0.2s
r-lazyeval                                         158.6kB @  60.9kB/s  0.2s
r-magrittr                                         208.9kB @  78.2kB/s  0.2s
r-cachem                                            75.2kB @  26.9kB/s  0.1s
r-later                                            131.2kB @  46.9kB/s  0.1s
r-ellipsis                                          42.7kB @  15.3kB/s  0.2s
r-htmltools                                        354.8kB @ 126.8kB/s  0.2s
r-rcolorbrewer                                      68.3kB @  23.1kB/s  0.2s
r-rstudioapi                                       293.1kB @  99.0kB/s  0.2s
r-viridislite                                        1.3MB @ 439.6kB/s  0.2s
r-tinytex                                          142.4kB @  48.0kB/s  0.2s
r-knitr                                              1.3MB @ 415.3kB/s  0.2s
r-timechange                                       200.7kB @  64.3kB/s  0.2s
r-tzdb                                             537.1kB @ 171.9kB/s  0.2s
r-systemfonts                                      254.7kB @  78.3kB/s  0.3s
r-hms                                              107.2kB @  32.9kB/s  0.1s
r-pillar                                           617.4kB @ 189.5kB/s  0.2s
r-stringr                                          295.6kB @  90.7kB/s  0.2s
r-cellranger                                       108.3kB @  31.7kB/s  0.2s
r-googledrive                                        1.2MB @ 350.7kB/s  0.2s
r-rvest                                            213.6kB @  62.3kB/s  0.2s
r-googlesheets4                                    512.7kB @ 149.5kB/s  0.3s
r-rappdirs                                          52.1kB @  14.5kB/s  0.0s
r-rlang                                              1.5MB @ 415.9kB/s  0.0s
harfbuzz                                             1.4MB @ 394.2kB/s  0.1s
r-cpp11                                            233.8kB @  63.3kB/s  0.0s
r-evaluate                                          89.3kB @  24.0kB/s  0.0s
r-matrix                                             3.9MB @   1.1MB/s  0.1s
r-fontawesome                                        1.3MB @ 343.9kB/s  0.1s
r-curl                                             450.8kB @ 118.5kB/s  0.2s
gxx_impl_linux-64                                   13.3MB @   3.5MB/s  0.3s
r-httr                                             482.8kB @ 126.0kB/s  0.0s
r-generics                                          90.7kB @  23.6kB/s  0.1s
r-processx                                         322.5kB @  83.9kB/s  0.0s
r-vctrs                                              1.2MB @ 318.6kB/s  0.1s
r-vroom                                            889.8kB @ 228.5kB/s  0.1s
r-rmarkdown                                          2.0MB @ 517.3kB/s  0.1s
gcc_impl_linux-64                                   54.2MB @  13.8MB/s  1.9s
r-readxl                                           757.8kB @ 187.2kB/s  0.2s
r-tidyverse                                        425.2kB @ 105.0kB/s  0.2s
xorg-libxrender                                     37.8kB @   9.3kB/s  0.0s
r-ggsci                                              2.2MB @ 542.0kB/s  0.2s
r-bslib                                              4.3MB @   1.0MB/s  0.3s
r-fastmap                                           72.3kB @  17.6kB/s  0.1s
r-yaml                                             116.0kB @  28.2kB/s  0.1s
r-dbi                                              720.9kB @ 174.4kB/s  0.0s
r-highr                                             57.5kB @  13.9kB/s  0.0s
r-labeling                                          68.6kB @  16.6kB/s  0.0s
r-callr                                            417.0kB @ 100.2kB/s  0.0s
r-mime                                              52.9kB @  12.6kB/s  0.1s
r-plotly                                             2.9MB @ 679.5kB/s  0.1s
r-xml2                                             302.0kB @  71.2kB/s  0.2s
r-mass                                               1.1MB @ 266.8kB/s  0.0s
r-bit                                                1.1MB @ 254.1kB/s  0.1s
r-lubridate                                        981.6kB @ 224.1kB/s  0.3s
r-rematch                                           21.4kB @   4.9kB/s  0.1s
pandoc                                              27.1MB @   6.2MB/s  0.2s
r-progress                                          92.3kB @  20.7kB/s  0.1s
r-dplyr                                              1.4MB @ 313.3kB/s  0.3s
r-rematch2                                          54.2kB @  12.1kB/s  0.0s
r-backports                                        109.2kB @  24.3kB/s  0.0s
r-crosstalk                                        372.8kB @  82.7kB/s  0.1s
r-argparse                                         158.4kB @  35.1kB/s  0.1s
r-assertthat                                        71.6kB @  15.8kB/s  0.0s
r-prettyunits                                       42.2kB @   9.3kB/s  0.0s
r-blob                                              65.8kB @  14.5kB/s  0.0s
r-modelr                                           220.6kB @  48.4kB/s  0.0s
xorg-libx11                                        828.5kB @ 181.5kB/s  0.0s
r-cli                                                1.3MB @ 273.1kB/s  0.0s
r-hexbin                                             1.6MB @ 347.8kB/s  0.3s
r-promises                                           1.5MB @ 334.4kB/s  0.0s
r-lattice                                            1.3MB @ 290.4kB/s  0.1s
r-jquerylib                                        305.5kB @  66.1kB/s  0.1s
r-haven                                            376.3kB @  81.0kB/s  0.0s
r-isoband                                            1.6MB @ 348.6kB/s  0.1s
r-clipr                                             69.7kB @  14.7kB/s  0.1s
r-readr                                            820.3kB @ 173.2kB/s  0.1s
libglib                                              2.7MB @ 563.4kB/s  0.1s
r-tidyr                                              1.1MB @ 241.0kB/s  0.0s
r-broom                                              1.8MB @ 374.0kB/s  0.4s
r-sass                                               2.3MB @ 472.5kB/s  0.3s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="install-atria"></a>
#### Install [atria](https://github.com/cihga39871/Atria)
<a id="printed-1"></a>
##### Printed
<details>
<summary><i>Printed: Install atria</i></summary>

```txt
❯ wget "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz"
--2023-01-15 14:01:46--  https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz
Resolving julialang-s3.julialang.org (julialang-s3.julialang.org)... 151.101.42.49, 2a04:4e42:a::561
Connecting to julialang-s3.julialang.org (julialang-s3.julialang.org)|151.101.42.49|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 130873886 (125M) [application/x-tar]
Saving to: ‘julia-1.8.5-linux-x86_64.tar.gz’

julia-1.8.5-linux-x86_64.tar.gz                                        100%[===========================================================================================================================================================================>] 124.81M  6.11MB/s    in 14s

2023-01-15 14:02:00 (8.88 MB/s) - ‘julia-1.8.5-linux-x86_64.tar.gz’ saved [130873886/130873886]


❯ tar zxvf julia-1.8.5-linux-x86_64.tar.gz
...


❯ vi ~/.bashrc


❯ which julia
/home/kalavatt/julia-1.8.5/bin/julia


❯ cd "${HOME}/2023_rDNA" ||
>     echo "cd'ing failed; check on this..."


❯ [[ -d software/ ]] || mkdir software/


❯ cd software/ || echo "cd'ing failed; check on this..."
/home/kalavatt/2023_rDNA/software


❯ git clone "https://github.com/cihga39871/Atria.git"
Cloning into 'Atria'...
remote: Enumerating objects: 960, done.
remote: Counting objects: 100% (117/117), done.
remote: Compressing objects: 100% (82/82), done.
remote: Total 960 (delta 67), reused 64 (delta 35), pack-reused 843
Receiving objects: 100% (960/960), 1.92 MiB | 20.53 MiB/s, done.
Resolving deltas: 100% (651/651), done.


❯ cd Atria/
/home/kalavatt/2023_rDNA/software/Atria


❯ julia build_atria.jl
pigz 2.6
  Activating project at `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/software/Atria`
Precompiling project...
  1 dependency successfully precompiled in 8 seconds. 28 already precompiled.
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
  No Changes to `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/Project.toml`
  No Changes to `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/Manifest.toml`
✔ [02m:42s] PackageCompiler: compiling base system image (incremental=false)
Precompiling project...
  29 dependencies successfully precompiled in 70 seconds
[ Info: PackageCompiler: Executing /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/test/runtests.jl => /tmp/jl_packagecompiler_j1Ljva/jl_JAU3KM
@SRR7243169.1 1 length=301
ACCCAAGGCGTGCTCGTAGGATTTGTCGACATAGTCGATCAGACCTTCGTCCAGCGGCCAGGCGTTAACCTGACCTTCCCAATCGTCGATGATGGTGTTGCCGAAGCGGAACACTTCACTTTGCAGGTACGGCACGCGCGCGGCGACCCAGGCAGCCTTGGCGGCTTTCAGGGTCTCGGCGTTCGGCCTGTCTCTTATACACATCTCCGAGCCCACGAGCCGTAGAGGAATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAGACAAGCACTCTATACATCCGTCTCACCCGATACACTCC
+SRR7243169.1 1 length=301
CCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGDGGGGGGDGGGGGGGGCGGGGGGGGGGGGGGGGFGGGGGGFGGGGGGGGGGGGGGFGGGEDGG>GFFGGGGDGGGDGFGG7;)9C>DF3B4)76676:@DF?F?>D@F3=FFFF?=<6*600)07).)0.)818)))**0=***))0((.**)0))0.7*/62(
┌ Info: read simulation: output files
│   r1 = "peReadSimulated.R1.fastq"
└   r2 = "peReadSimulated.R2.fastq"
┌ Info: read simulation: all done
└   elapsed = 11.413524150848389
usage: runtests.jl [-o PREF] [-x REPEAT] [-a SEQ] [-A SEQ]
                   [-s SEQ-LENGTH]
                   [-i INSERT-SIZE-RANGE [INSERT-SIZE-RANGE...]]
                   [-S SUBSITUTION-RATE [SUBSITUTION-RATE...]]
                   [-I INSERTION-RATE [INSERTION-RATE...]]
                   [-D DELETION-RATE [DELETION-RATE...]] [-h]

optional arguments:
  -h, --help            show this help message and exit

output:
  -o, --prefix PREF     prefix of output fastq files (default:
                        "read_simulation")

simulation:
  -x, --repeat REPEAT   repeat times for each case (type: Int64,
                        default: 30000)
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -s, --seq-length SEQ-LENGTH
                        a given sequence length; simulated sequence
                        length might be 1 base more than the value
                        because of simulated phasing error (type:
                        Int64, default: 100)
  -i, --insert-size-range INSERT-SIZE-RANGE [INSERT-SIZE-RANGE...]
                        range of insert size (type: Int64, default:
                        [80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100,
                        102, 104, 106, 108, 110, 112, 114, 116, 118,
                        120])
  -S, --subsitution-rate SUBSITUTION-RATE [SUBSITUTION-RATE...]
                        subsitution rate per base. it is random for
                        each base. error type includs mismatch (type:
                        Float64, default: [0.001, 0.002, 0.003, 0.004,
                        0.005])
  -I, --insertion-rate INSERTION-RATE [INSERTION-RATE...]
                        insertion rate; number of arg should be the
                        same as --subsitution-rate (type: Float64,
                        default: [1.0e-5, 2.0e-5, 3.0e-5, 4.0e-5,
                        5.0e-5])
  -D, --deletion-rate DELETION-RATE [DELETION-RATE...]
                        deletion rate; number of arg should be the
                        same as --subsitution-rate (type: Float64,
                        default: [1.0e-5, 2.0e-5, 3.0e-5, 4.0e-5,
                        5.0e-5])

┌ Info: read random trim: start
│   file1 = "peReadSimulated.R1.fastq"
└   file2 = "peReadSimulated.R2.fastq"
┌ Info: read random trim: all done
└   elapsed = 1.6224110126495361
usage: atria randtrim [-h] R1_FASTQ R2_FASTQ

positional arguments:
  R?_FASTQ      input fastqs. caution: raw fastq has to be
                generated by `atria simulate`.

optional arguments:
  -h, --help  show this help message and exit

pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -R peReadSimulated.R2.randtrim.fastq.gz -c 8 --compress gz --check-identifier -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.gz"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.randtrim.atria.fastq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 210000/210000 pairs; wrote 89003/89003 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.gz"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.randtrim.atria.fastq.gz"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -c 8 --compress gz -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = false
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = false
[ Info: Cycle 1: read 210000/210000 pairs; wrote 149161/149161; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.gz"
pigz 2.6
┌ Info: peReadSimulated.R1.randtrim.fastq.gz:
│  Top 5 adapters detected in the first 210000 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │     15429 │ 0.995949 │
│ │ AGATCGGAAGAGCTCG │     14727 │ 0.875106 │
│ │ GATCGGAAGAGCACAC │     10149 │  0.93524 │
│ │ AGATCGGAAGAGCGGT │        47 │    0.875 │
│ │ AGATCGGAAGAGCGTC │        44 │  0.87642 │
└ └──────────────────┴───────────┴──────────┘
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -R peReadSimulated.R2.randtrim.fastq.gz -c 8 --compress bz2 --check-identifier -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.bz2"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.randtrim.atria.fastq.bz2"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 210000/210000 pairs; wrote 89003/89003 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.bz2"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.randtrim.atria.fastq.bz2"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -c 8 --compress bz2 -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.bz2"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = false
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = false
[ Info: Cycle 1: read 210000/210000 pairs; wrote 149161/149161; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.randtrim.atria.fastq.bz2"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.fastq -R peReadSimulated.R2.fastq --polyG --enable-complexity-filtration -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.fastq"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.atria.fastq"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 188282/188282 pairs; wrote 188281/188281 pairs; (copied 0/0 reads)
[ Info: Cycle 2: read 21718/210000 pairs; wrote 21718/209999 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.fastq"
└   read2 = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R2.atria.fastq"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.2"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.fastq --polyG --enable-complexity-filtration -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.fastq"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = true
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = true
[ Info: Cycle 1: read 188282/188282 pairs; wrote 188278/188278; (copied 0/0)
[ Info: Cycle 2: read 21718/210000 pairs; wrote 21718/209996; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.fastq"
pigz 2.6
[ Warning: Skip completed analysis: /tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.log.json (use --force to disable the feature)
pigz 2.6
[ Warning: Skip completed analysis: /tmp/jl_R6JYTaVKJG/peReadSimulated.R1.atria.log.json (use --force to disable the feature)
pigz 2.6
┌ Info: peReadSimulated.R1.fastq:
│  Top 5 adapters detected in the first 188282 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │     29957 │ 0.996647 │
│ │ AGATCGGAAGAGCTCG │     28595 │ 0.875146 │
│ │ GATCGGAAGAGCACAC │     19997 │ 0.935128 │
│ │ AGATCGGAAGAGCGGT │        96 │    0.875 │
│ │ AGATCGGAAGAGCGTC │        92 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
usage: atria [-t INT] [--log2-chunk-size INDEX] [-f]
             -r R1-FASTQ [R1-FASTQ...] [-R [R2-FASTQ...]] [-o PATH]
             [-g AUTO|NO|GZ|GZIP|BZ2|BZIP2] [--check-identifier]
             [--detect-adapter] [--polyG] [--polyT] [--polyA]
             [--polyC] [--poly-length POLY-LENGTH]
             [--poly-mismatch-per-16mer INT] [--no-adapter-trim]
             [-a SEQ] [-A SEQ] [-T INT] [-d INT] [-D INT] [-s INT]
             [--trim-score-pe FLOAT] [--trim-score-se FLOAT] [-l INT]
             [--stats] [--no-consensus]
             [--kmer-tolerance-consensus INT]
             [--min-ratio-mismatch FLOAT] [--overlap-score FLOAT]
             [--prob-diff FLOAT] [-C INT] [-c INT] [--no-quality-trim]
             [-q INT] [--quality-kmer INT] [--quality-format FORMAT]
             [--no-tail-n-trim] [-n INT] [--no-length-filtration]
             [--length-range INT:INT] [--enable-complexity-filtration]
             [--min-complexity FLOAT] [-p INT] [--version] [-h]

Atria v3.2.2

optional arguments:
  -t, --threads INT     use INT threads to process one sample
                        (multi-threading parallel). (type: Int64,
                        default: 1)
  --log2-chunk-size INDEX
                        read at most 2^INDEX bits each time. Suggest
                        to process 200,000 reads each time. Reduce
                        INDEX to lower the memory usage. (type: Int64,
                        default: 26)
  -f, --force           force to analyze all samples; not skip
                        completed ones
  --version             show version information and exit
  -h, --help            show this help message and exit

input/output: input read 1 and read 2 should be in the same order:
  -r, --read1 R1-FASTQ [R1-FASTQ...]
                        input read 1 fastq file(s), or single-end
                        fastq files
  -R, --read2 [R2-FASTQ...]
                        input read 2 fastq file(s) (paired with
                        R1-FASTQ)
  -o, --output-dir PATH
                        store output files and stats to PATH (default:
                        "/tmp/jl_R6JYTaVKJG")
  -g, --compress AUTO|NO|GZ|GZIP|BZ2|BZIP2
                        compression methods for output files (AUTO:
                        same as input, NO: no compression, GZ|GZIP:
                        gzip with `pigz`, BZ2|BZIP2: bzip2 with
                        `pbzip2`) (default: "AUTO")
  --check-identifier    check whether the identifiers of r1 and r2 are
                        the same
  --detect-adapter      detect possible adapters for each sample only

poly X tail trimming:
  --polyG               enable trimming poly G tails
  --polyT               enable trimming poly T tails
  --polyA               enable trimming poly A tails
  --polyC               enable trimming poly C tails
  --poly-length POLY-LENGTH
                        the minimum length of poly X (type: Int64,
                        default: 10)
  --poly-mismatch-per-16mer INT
                        the number of mismatch allowed in 16 mer poly
                        X (type: Int64, default: 2)

adapter trimming (after polyX trimming):
  --no-adapter-trim     disable adapter and pair-end trimming
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -T, --kmer-tolerance INT
                        # of mismatch allowed in 16-mers adapter and
                        pair-end matching (type: Int64, default: 2)
  -d, --pe-adapter-diff INT
                        (FOR PAIRED END) number of bases allowed when
                        disconcordance found between adapter and
                        pair-end search (type: Int64, default: 0)
  -D, --r1-r2-diff INT  (FOR PAIRED END) number of bases allowed when
                        the insert sizes of r1 and r2 are different
                        (type: Int64, default: 0)
  -s, --kmer-n-match INT
                        (FOR PAIRED END) if n base matched [0-16] is
                        less than INT, loosen matches will be made
                        based on the match with the highest n base
                        match (type: Int64, default: 9)
  --trim-score-pe FLOAT
                        (FOR PAIRED END) if final score [0-32] of read
                        pair is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  --trim-score-se FLOAT
                        (FOR SINGLE END) if final score [0-16] of read
                        is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  -l, --tail-length INT
                        (FOR PAIRED END) if the adapter is in the tail
                        region, and insert size of pe match is smaller
                        than this region, do not trim the read. (type:
                        Int64, default: 12)
  --stats               (DEV ONLY) write stats to description lines of
                        r2 reads.

consensus/merging in adapter trimming (FOR PAIRED END):
  --no-consensus        disable generating consensus paired reads. If
                        adapter trimming is disabled, consensus
                        calling is not performed even the flag is not
                        set.
  --kmer-tolerance-consensus INT
                        # of mismatch allowed in 16-mers matching in
                        consensus calling (type: Int64, default: 10)
  --min-ratio-mismatch FLOAT
                        if the ratio of mismatch of the overlapped
                        region is less than FLOAT, skip consensus
                        calling. (type: Float64, default: 0.28)
  --overlap-score FLOAT
                        if no adapter was found, scan the tails of the
                        paired reads. Then, if the maximum score of
                        the overlapped 16-mers are less than FLOAT,
                        skip consensus calling for the read pair. If
                        adapters were found, this step is ignored.
                        (type: Float64, default: 0.0)
  --prob-diff FLOAT     when doing consensus calling, if the bases
                        were not complementary, the base with the
                        higher quality probability is selected unless
                        the quality probability difference are less
                        than FLOAT (type: Float64, default: 0.0)

hard clipping: trim a fixed length (after adapter trimming):
  -C, --clip-after INT  hard clip the 3' tails to contain only INT
                        bases. 0 to disable. (type: Int64, default: 0)
  -c, --clip5 INT       remove the first INT bases from 5' end. (type:
                        Int64, default: 0)

quality trimming: trim the tail when the average quality of bases in
a sliding window is low (after hard clipping):
  --no-quality-trim     skip quality trimming
  -q, --quality-score INT
                        threshold of quality score; 0 means turn off
                        quality trimming (type: Int64, default: 20)
  --quality-kmer INT    trim the tail once found the average quality
                        of bases in a sliding window is low (type:
                        Int64, default: 5)
  --quality-format FORMAT
                        the format of the quality score (Illumina1.3,
                        Illumina1.8, Sanger, Illumina1.5, Solexa); or
                        the ASCII number when quality score == 0
                        (default: "33")

N trimming (after quality trimming):
  --no-tail-n-trim      disable removing NNNNN tail.
  -n, --max-n INT       # N allowed in each read; N tails not included
                        if --no-tail-n-trim; INT<0 to disable (type:
                        Int64, default: 15)

length filtration (after N trimming):
  --no-length-filtration
                        disable length filtration
  --length-range INT:INT
                        length range of good reads; format is min:max
                        (default: "50:500")

read complexity filtration (after length filtration):
  --enable-complexity-filtration
                        enable complexity filtration
  --min-complexity FLOAT
                        complexity threshold (type: Float64, default:
                        0.3)

legacy arguments:
  -p, --procs INT       ignored (multi-proc is disabled) (default:
                        "1")

Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li,
Atria: an ultra-fast and accurate trimmer for adapter and quality
trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

usage: atria [-t INT] [--log2-chunk-size INDEX] [-f]
             -r R1-FASTQ [R1-FASTQ...] [-R [R2-FASTQ...]] [-o PATH]
             [-g AUTO|NO|GZ|GZIP|BZ2|BZIP2] [--check-identifier]
             [--detect-adapter] [--polyG] [--polyT] [--polyA]
             [--polyC] [--poly-length POLY-LENGTH]
             [--poly-mismatch-per-16mer INT] [--no-adapter-trim]
             [-a SEQ] [-A SEQ] [-T INT] [-d INT] [-D INT] [-s INT]
             [--trim-score-pe FLOAT] [--trim-score-se FLOAT] [-l INT]
             [--stats] [--no-consensus]
             [--kmer-tolerance-consensus INT]
             [--min-ratio-mismatch FLOAT] [--overlap-score FLOAT]
             [--prob-diff FLOAT] [-C INT] [-c INT] [--no-quality-trim]
             [-q INT] [--quality-kmer INT] [--quality-format FORMAT]
             [--no-tail-n-trim] [-n INT] [--no-length-filtration]
             [--length-range INT:INT] [--enable-complexity-filtration]
             [--min-complexity FLOAT] [-p INT] [--version] [-h]

Atria v3.2.2

optional arguments:
  -t, --threads INT     use INT threads to process one sample
                        (multi-threading parallel). (type: Int64,
                        default: 1)
  --log2-chunk-size INDEX
                        read at most 2^INDEX bits each time. Suggest
                        to process 200,000 reads each time. Reduce
                        INDEX to lower the memory usage. (type: Int64,
                        default: 26)
  -f, --force           force to analyze all samples; not skip
                        completed ones
  --version             show version information and exit
  -h, --help            show this help message and exit

input/output: input read 1 and read 2 should be in the same order:
  -r, --read1 R1-FASTQ [R1-FASTQ...]
                        input read 1 fastq file(s), or single-end
                        fastq files
  -R, --read2 [R2-FASTQ...]
                        input read 2 fastq file(s) (paired with
                        R1-FASTQ)
  -o, --output-dir PATH
                        store output files and stats to PATH (default:
                        "/tmp/jl_R6JYTaVKJG")
  -g, --compress AUTO|NO|GZ|GZIP|BZ2|BZIP2
                        compression methods for output files (AUTO:
                        same as input, NO: no compression, GZ|GZIP:
                        gzip with `pigz`, BZ2|BZIP2: bzip2 with
                        `pbzip2`) (default: "AUTO")
  --check-identifier    check whether the identifiers of r1 and r2 are
                        the same
  --detect-adapter      detect possible adapters for each sample only

poly X tail trimming:
  --polyG               enable trimming poly G tails
  --polyT               enable trimming poly T tails
  --polyA               enable trimming poly A tails
  --polyC               enable trimming poly C tails
  --poly-length POLY-LENGTH
                        the minimum length of poly X (type: Int64,
                        default: 10)
  --poly-mismatch-per-16mer INT
                        the number of mismatch allowed in 16 mer poly
                        X (type: Int64, default: 2)

adapter trimming (after polyX trimming):
  --no-adapter-trim     disable adapter and pair-end trimming
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -T, --kmer-tolerance INT
                        # of mismatch allowed in 16-mers adapter and
                        pair-end matching (type: Int64, default: 2)
  -d, --pe-adapter-diff INT
                        (FOR PAIRED END) number of bases allowed when
                        disconcordance found between adapter and
                        pair-end search (type: Int64, default: 0)
  -D, --r1-r2-diff INT  (FOR PAIRED END) number of bases allowed when
                        the insert sizes of r1 and r2 are different
                        (type: Int64, default: 0)
  -s, --kmer-n-match INT
                        (FOR PAIRED END) if n base matched [0-16] is
                        less than INT, loosen matches will be made
                        based on the match with the highest n base
                        match (type: Int64, default: 9)
  --trim-score-pe FLOAT
                        (FOR PAIRED END) if final score [0-32] of read
                        pair is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  --trim-score-se FLOAT
                        (FOR SINGLE END) if final score [0-16] of read
                        is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  -l, --tail-length INT
                        (FOR PAIRED END) if the adapter is in the tail
                        region, and insert size of pe match is smaller
                        than this region, do not trim the read. (type:
                        Int64, default: 12)
  --stats               (DEV ONLY) write stats to description lines of
                        r2 reads.

consensus/merging in adapter trimming (FOR PAIRED END):
  --no-consensus        disable generating consensus paired reads. If
                        adapter trimming is disabled, consensus
                        calling is not performed even the flag is not
                        set.
  --kmer-tolerance-consensus INT
                        # of mismatch allowed in 16-mers matching in
                        consensus calling (type: Int64, default: 10)
  --min-ratio-mismatch FLOAT
                        if the ratio of mismatch of the overlapped
                        region is less than FLOAT, skip consensus
                        calling. (type: Float64, default: 0.28)
  --overlap-score FLOAT
                        if no adapter was found, scan the tails of the
                        paired reads. Then, if the maximum score of
                        the overlapped 16-mers are less than FLOAT,
                        skip consensus calling for the read pair. If
                        adapters were found, this step is ignored.
                        (type: Float64, default: 0.0)
  --prob-diff FLOAT     when doing consensus calling, if the bases
                        were not complementary, the base with the
                        higher quality probability is selected unless
                        the quality probability difference are less
                        than FLOAT (type: Float64, default: 0.0)

hard clipping: trim a fixed length (after adapter trimming):
  -C, --clip-after INT  hard clip the 3' tails to contain only INT
                        bases. 0 to disable. (type: Int64, default: 0)
  -c, --clip5 INT       remove the first INT bases from 5' end. (type:
                        Int64, default: 0)

quality trimming: trim the tail when the average quality of bases in
a sliding window is low (after hard clipping):
  --no-quality-trim     skip quality trimming
  -q, --quality-score INT
                        threshold of quality score; 0 means turn off
                        quality trimming (type: Int64, default: 20)
  --quality-kmer INT    trim the tail once found the average quality
                        of bases in a sliding window is low (type:
                        Int64, default: 5)
  --quality-format FORMAT
                        the format of the quality score (Illumina1.3,
                        Illumina1.8, Sanger, Illumina1.5, Solexa); or
                        the ASCII number when quality score == 0
                        (default: "33")

N trimming (after quality trimming):
  --no-tail-n-trim      disable removing NNNNN tail.
  -n, --max-n INT       # N allowed in each read; N tails not included
                        if --no-tail-n-trim; INT<0 to disable (type:
                        Int64, default: 15)

length filtration (after N trimming):
  --no-length-filtration
                        disable length filtration
  --length-range INT:INT
                        length range of good reads; format is min:max
                        (default: "50:500")

read complexity filtration (after length filtration):
  --enable-complexity-filtration
                        enable complexity filtration
  --min-complexity FLOAT
                        complexity threshold (type: Float64, default:
                        0.3)

legacy arguments:
  -p, --procs INT       ignored (multi-proc is disabled) (default:
                        "1")

Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li,
Atria: an ultra-fast and accurate trimmer for adapter and quality
trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

┌ Info: read simulation stats: start
└   input = "peReadSimulated.R1.atria.fastq.r12"
┌ Info: read simulation stats: output
│   detail = "peReadSimulated.R1.atria.fastq.r12.stat-detail.tsv"
└   summary = "peReadSimulated.R1.atria.fastq.r12.stat.tsv"
┌ Info: read simulation stats: all done
└   elapsed = 3.174762010574341
usage: atria readstat [-h] FASTQS...

positional arguments:
  FASTQS      input trimmed fastqs. caution: raw fastq has to be
              generated by `atria simulate`. If multiple, two by two are considered paired.

optional arguments:
  -h, --help  show this help message and exit

Rscript (R) version 4.3.0 (2023-04-21)

  Atria v3.2.2
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡

  An ultra-fast and accurate adapter and quality trimming software designed for paired-end sequencing data.

  If you use Atria, please cite

  │  Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li, Atria: an ultra-fast and accurate trimmer for adapter and quality trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

  Github: https://github.com/cihga39871/Atria

  Usage
  =======

  Try atria -h or atria --help for more information.

  Input and Output
  ––––––––––––––––––

  The input files should be paired-end FastQ(.gz|.bz2) files (in the same order), or single-end fastqs:

    1. Read 1 files: -r X_R1.FQ Y_R1.FQ.GZ ...

    2. Read 2 files (optional): -R X_R2.FQ Y_R2.FQ.GZ ...

  Output all files to a directory: -o PATH or --output-dir PATH. Default is the current directory.

  Atria skips completed analysis by default. Use -f or --force to disable the feature.

  Trimming methods
  ––––––––––––––––––

  Atria integrated several trimming and read filtration methods. It does the following sequentially.

    1. Poly X Tail Trimming: remove remove poly-X tails.
       suggest to enable --polyG for Illumina NextSeq/NovaSeq data.
       • enable: --polyG, --polyT, --polyA, and/or --polyC (default: disabled)
       • trim poly X tail if length > INT: --poly-length 10

    2. Adapter Trimming
       • specify read 1 adapter: -a SEQ or --adapter1 SEQ (default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA)
       • specify read 2 adapter: -A SEQ or --adapter2 SEQ (default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT) (if paired-end)
       • disable: --no-adapter-trim
       • if adapter is unknown, use --detect-adapter.

    3. Paired-end Consensus Calling: the overlapped regions of read pairs are checked and corrected. It is available only when input files are paired-end and Adapter Trimming is on.
       • disable: --no-consensus

    4. Hard Clip 3' end: resize reads to a fixed length by discarding extra bases in 3' end.
       • specify the number of bases to keep: -C INT or --clip-after INT (default: disabled)

    5. Hard Clip 5' end: remove the first INT bases from 5' end.
       • specify the number of bases to remove: -c INT or --clip5 INT (default: disabled)

    6. Quality Trimming: trim low-quality tails. (Trimming read tails when the average quality of bases in a sliding window is low.)
       • specify average quality threshold: -q 20 or --quality-score 20 (default: 20)
       • specify sliding window length: --quality-kmer 5 (default: 5)
       • specify FastQ quality format: --quality-format Illumina1.8, or --quality-format 33 (default: 33, ie. Illumina1.8)
       • disable: --no-quality-trim

    7. Tail N Trimming: trim N tails.
       • disable: --no-tail-n-trim

    8. N Filtration: discard a read pair if the number of N in one read is greater than a certain amount. N tails are ignored if Tail N Trimming is on.
       • specify # N allowed in each read: -n 15 or --max-n 15 (default: 15)
       • disable: -n -1 or --max-n -1

    9. Read Length Filtration: filter read pair length in a range.
       • specify read length range: --length-range 50:500 (default: 50:500)
       • disable: --no-length-filtration

    10. Read Complexity Filtration: filter reads with low complexity.
       Complexity is the percentage of base that is different from its next base.
       • enable: --enable-complexity-filtration (default: disabled)
       • specify complexity threshold: --min-complexity 0.3 (default: 0.3)

  Parallel (multi-threading) computing
  ––––––––––––––––––––––––––––––––––––––

    1. Specify number of threads to use: -t 8 or --threads 8. (Default: 8)

    2. If memory is not sufficient, use --log2-chunk-size INT where INT is from 23 to 25. Memory usage reduces exponentially as it decreases.
Available programs:
    atria       Pair-end trimming software (default)
    simulate    Generate artificial pair-end reads
    randtrim    Randomly trim R1 or R2 at a random position
    readstat    Collect trimming statistics
                    (reads should be generated by `atria simulate`)
    statplot    Plot trimming statistics
                    (`Rscript` in PATH required)
    test        Test Atria program
    p | prog    Show this program list

[ Info: Precompiling/test passed without errors.
Test Summary: | Pass  Total     Time
Atria         |   96     96  1m27.5s
[ Info: PackageCompiler: Done
✔ [05m:08s] PackageCompiler: compiling nonincremental system image
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libatomic.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libatomic.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so.6: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so.6: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
[ Info: Success. Atria is installed at ./app-3.2.2/bin/atria
pigz 2.6


❯ alias atria="\${HOME}/tsukiyamalab/kalavatt/2023_rDNA/software/Atria/app-3.2.2/bin/atria"


❯ atria

  Atria v3.2.2
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡

  An ultra-fast and accurate adapter and quality trimming software designed for paired-end sequencing data.

  If you use Atria, please cite

  │  Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li, Atria: an ultra-fast and accurate trimmer for adapter and quality trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

  Github: https://github.com/cihga39871/Atria

  Usage
  =======

  Try atria -h or atria --help for more information.

  Input and Output
  ––––––––––––––––––

  The input files should be paired-end FastQ(.gz|.bz2) files (in the same order), or single-end fastqs:

    1. Read 1 files: -r X_R1.FQ Y_R1.FQ.GZ ...

    2. Read 2 files (optional): -R X_R2.FQ Y_R2.FQ.GZ ...

  Output all files to a directory: -o PATH or --output-dir PATH. Default is the current directory.

  Atria skips completed analysis by default. Use -f or --force to disable the feature.

  Trimming methods
  ––––––––––––––––––

  Atria integrated several trimming and read filtration methods. It does the following sequentially.

    1. Poly X Tail Trimming: remove remove poly-X tails.
       suggest to enable --polyG for Illumina NextSeq/NovaSeq data.
       • enable: --polyG, --polyT, --polyA, and/or --polyC (default: disabled)
       • trim poly X tail if length > INT: --poly-length 10

    2. Adapter Trimming
       • specify read 1 adapter: -a SEQ or --adapter1 SEQ (default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA)
       • specify read 2 adapter: -A SEQ or --adapter2 SEQ (default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT) (if paired-end)
       • disable: --no-adapter-trim
       • if adapter is unknown, use --detect-adapter.

    3. Paired-end Consensus Calling: the overlapped regions of read pairs are checked and corrected. It is available only when input files are paired-end and Adapter Trimming is on.
       • disable: --no-consensus

    4. Hard Clip 3' end: resize reads to a fixed length by discarding extra bases in 3' end.
       • specify the number of bases to keep: -C INT or --clip-after INT (default: disabled)

    5. Hard Clip 5' end: remove the first INT bases from 5' end.
       • specify the number of bases to remove: -c INT or --clip5 INT (default: disabled)

    6. Quality Trimming: trim low-quality tails. (Trimming read tails when the average quality of bases in a sliding window is low.)
       • specify average quality threshold: -q 20 or --quality-score 20 (default: 20)
       • specify sliding window length: --quality-kmer 5 (default: 5)
       • specify FastQ quality format: --quality-format Illumina1.8, or --quality-format 33 (default: 33, ie. Illumina1.8)
       • disable: --no-quality-trim

    7. Tail N Trimming: trim N tails.
       • disable: --no-tail-n-trim

    8. N Filtration: discard a read pair if the number of N in one read is greater than a certain amount. N tails are ignored if Tail N Trimming is on.
       • specify # N allowed in each read: -n 15 or --max-n 15 (default: 15)
       • disable: -n -1 or --max-n -1

    9. Read Length Filtration: filter read pair length in a range.
       • specify read length range: --length-range 50:500 (default: 50:500)
       • disable: --no-length-filtration

    10. Read Complexity Filtration: filter reads with low complexity.
       Complexity is the percentage of base that is different from its next base.
       • enable: --enable-complexity-filtration (default: disabled)
       • specify complexity threshold: --min-complexity 0.3 (default: 0.3)

  Parallel (multi-threading) computing
  ––––––––––––––––––––––––––––––––––––––

    1. Specify number of threads to use: -t 8 or --threads 8. (Default: 8)

    2. If memory is not sufficient, use --log2-chunk-size INT where INT is from 23 to 25. Memory usage reduces exponentially as it decreases.
```
</details>
<br />

<a id="install-higlass"></a>
#### Install HiGlass
<a id="printed-2"></a>
##### Printed
<details>
<summary><i>Printed: Install HiGlass</i></summary>

```txt
❯ docker pull higlass/higlass-docker
Using default tag: latest
latest: Pulling from higlass/higlass-docker
d5fd17ec1767: Pulling fs layer
6422b34437d1: Pulling fs layer
73ba2a1f7dde: Pulling fs layer
be7b46dd5fea: Pull complete
8e49199e85ef: Pull complete
c4bc881d58e8: Pull complete
7e92b57a2901: Pull complete
73494564efa9: Pull complete
25a49216c3dd: Pull complete
7e56303d188d: Pull complete
cb397a031840: Pull complete
47426cb8475b: Pull complete
18d1fff970dc: Pull complete
31cd83a82e3a: Pull complete
6e212c033c2f: Pull complete
858c081be2ec: Pull complete
c0ebabb2a4c6: Pull complete
f34c90f97dee: Pull complete
8f70b9cc5016: Pull complete
7b2a69766534: Pull complete
664b2e582166: Pull complete
00999032f45f: Pull complete
005726487002: Pull complete
6a95d91a5ea2: Pull complete
1b6b1e33ec51: Pull complete
7faf3b9639a6: Pull complete
7ed67a9571e7: Pull complete
4874337f42dd: Pull complete
dbf7f0095fb7: Pull complete
8eacd44b5df6: Pull complete
28c526f559b7: Pull complete
c85cc3debbfa: Pull complete
a24258ad5e79: Pull complete
7c824922df97: Pull complete
986f0c2fd500: Pull complete
b8e6ea53c571: Pull complete
ccd504d2c3ab: Pull complete
bba21be499c8: Pull complete
7d1666b76740: Pull complete
1827f5e2fb4c: Pull complete
ddace0d6fcbb: Pull complete
c667579fa023: Pull complete
f75751a34098: Pull complete
4bdd777d5874: Pull complete
d444e5b29dfc: Pull complete
7105c723ac40: Pull complete
bda2027762ed: Pull complete
165027e61dac: Pull complete
88d1b18b6097: Pull complete
b33c77120c03: Pull complete
3afed2112162: Pull complete
238d8bcf1bcd: Pull complete
b121772f90f5: Pull complete
4d1268299691: Pull complete
1c919e8bfe46: Pull complete
ec711eb804c9: Pull complete
8af1fb80bb3d: Pull complete
49e91ddf8a4d: Pull complete
c3c1bcf5271a: Pull complete
1959dce88875: Pull complete
283fcf5322e1: Pull complete
9b159be10719: Pull complete
2266b7eb1b79: Pull complete
3e027315972d: Pull complete
3c326248b97d: Pull complete
Digest: sha256:44086069ee7d4d3f6f3f0012569789ec138f42b84aa44357826c0b6753eb28de
Status: Downloaded newer image for higlass/higlass-docker:latest
docker.io/higlass/higlass-docker:latest


❯ docker run \
>     --detach \
>     --publish 8888:80 \
>     --volume "${p_proj}/${p_data}":/data \
>     --volume /tmp:/tmp \
>     --name higlass-container \
>     higlass/higlass-docker
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
5397123fc9c47ee2692fe0dd886e5fcf25964337da3b3a8319bfb74f282d7ebb


❯ #  Check the mounts


❯ docker exec higlass-container ls /tmp
Sublime Text.4cff18d2bab96a93366319a9e0fa060d.5708d8b708dcd64d09ce50548896f0ba.sock
com.apple.launchd.La7pS0GCfq
com.snowsoftware.Inventory.stderr
com.snowsoftware.Inventory.stdout
nginx-stderr---supervisor-16ir53mh.log
nginx-stdout---supervisor-xb5wb32h.log
powerlog
uwsgi-stderr---supervisor-039wh_6o.log
uwsgi-stdout---supervisor-yhwmdgo2.log


❯ docker exec higlass-container ls /data
SRR7939018.mcool
db.sqlite3
log
```
</details>
<br />
<br />

<a id="install-clodius-and-bedops"></a>
#### Install [Clodius](https://github.com/higlass/clodius) and [bedops](http://bedops.readthedocs.io/)
<a id="printed-3"></a>
##### Printed
<details>
<summary><i>Printed: Install Clodius and bedops</i></summary>

```txt
❯ [[ "${CONDA_DEFAULT_ENV}" != "pairtools_env" ]] \
>     && source activate "pairtools_env" \
>     || conda activate "pairtools_env"


❯ [[ "${install_clodius}" == TRUE ]] && pip install clodius
Collecting clodius
  Downloading clodius-0.20.1-py2.py3-none-any.whl (82 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 82.6/82.6 kB 1.8 MB/s eta 0:00:00
Requirement already satisfied: click>=7 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (8.1.3)
Requirement already satisfied: cooler>0.9.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (0.9.2)
Requirement already satisfied: dask in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (2023.6.0)
Requirement already satisfied: h5py in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (3.8.0)
Collecting negspy (from clodius)
  Downloading negspy-0.2.24.tar.gz (1.7 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 15.6 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Requirement already satisfied: numpy in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (1.23.5)
Requirement already satisfied: pandas>=1.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (2.0.2)
Collecting pybbi>=0.2.0 (from clodius)
  Downloading pybbi-0.3.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.2/3.2 MB 16.7 MB/s eta 0:00:00
Collecting pydantic (from clodius)
  Downloading pydantic-2.0.2-py3-none-any.whl (359 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 359.1/359.1 kB 19.0 MB/s eta 0:00:00
Requirement already satisfied: pyfaidx in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (0.7.2.1)
Requirement already satisfied: pysam in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (0.21.0)
Requirement already satisfied: requests in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (2.31.0)
Collecting slugid (from clodius)
  Downloading slugid-2.0.0-py2.py3-none-any.whl (8.2 kB)
Requirement already satisfied: sortedcontainers in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from clodius) (2.4.0)
Collecting tqdm (from clodius)
  Downloading tqdm-4.65.0-py3-none-any.whl (77 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 77.1/77.1 kB 2.9 MB/s eta 0:00:00
Requirement already satisfied: scipy>=0.16 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (1.10.1)
Requirement already satisfied: cytoolz in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (0.12.0)
Requirement already satisfied: multiprocess in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (0.70.14)
Requirement already satisfied: asciitree in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (0.3.3)
Requirement already satisfied: pyyaml in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (6.0)
Requirement already satisfied: simplejson in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (3.19.1)
Requirement already satisfied: python-dateutil>=2.8.2 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pandas>=1.0->clodius) (2.8.2)
Requirement already satisfied: pytz>=2020.1 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pandas>=1.0->clodius) (2023.3)
Requirement already satisfied: tzdata>=2022.1 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pandas>=1.0->clodius) (2023.3)
Requirement already satisfied: cloudpickle>=1.5.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (2.2.1)
Requirement already satisfied: fsspec>=2021.09.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (2023.6.0)
Requirement already satisfied: packaging>=20.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (23.1)
Requirement already satisfied: partd>=1.2.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (1.4.0)
Requirement already satisfied: toolz>=0.10.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (0.12.0)
Requirement already satisfied: importlib-metadata>=4.13.0 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from dask->clodius) (6.6.0)
Collecting annotated-types>=0.4.0 (from pydantic->clodius)
  Downloading annotated_types-0.5.0-py3-none-any.whl (11 kB)
Collecting pydantic-core==2.1.2 (from pydantic->clodius)
  Downloading pydantic_core-2.1.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 59.2 MB/s eta 0:00:00
Requirement already satisfied: typing-extensions>=4.6.1 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pydantic->clodius) (4.6.3)
Requirement already satisfied: six in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pyfaidx->clodius) (1.16.0)
Requirement already satisfied: setuptools in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from pyfaidx->clodius) (67.7.2)
Collecting cython (from pysam->clodius)
  Downloading Cython-0.29.36-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_24_x86_64.whl (1.9 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.9/1.9 MB 48.9 MB/s eta 0:00:00
Requirement already satisfied: charset-normalizer<4,>=2 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from requests->clodius) (3.1.0)
Requirement already satisfied: idna<4,>=2.5 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from requests->clodius) (3.4)
Requirement already satisfied: urllib3<3,>=1.21.1 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from requests->clodius) (2.0.3)
Requirement already satisfied: certifi>=2017.4.17 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from requests->clodius) (2023.5.7)
Requirement already satisfied: zipp>=0.5 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from importlib-metadata>=4.13.0->dask->clodius) (3.15.0)
Requirement already satisfied: locket in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from partd>=1.2.0->dask->clodius) (1.0.0)
Requirement already satisfied: dill>=0.3.6 in /home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages (from multiprocess->cooler>0.9.0->clodius) (0.3.6)
Building wheels for collected packages: negspy
  Building wheel for negspy (setup.py) ... done
  Created wheel for negspy: filename=negspy-0.2.24-py3-none-any.whl size=1725345 sha256=d08e093a356c6f23d8a70a2ab3f65a67348126504cba3b02f47e0777db137578
  Stored in directory: /home/kalavatt/.cache/pip/wheels/4c/01/07/77d7b941e82a624da932e7745bb9a1265418559a23b7bec627
Successfully built negspy
Installing collected packages: slugid, negspy, tqdm, pydantic-core, pybbi, cython, annotated-types, pydantic, clodius
Successfully installed annotated-types-0.5.0 clodius-0.20.1 cython-0.29.36 negspy-0.2.24 pybbi-0.3.5 pydantic-2.0.2 pydantic-core-2.1.2 slugid-2.0.0 tqdm-4.65.0


❯ [[ "${install_bedops}" == TRUE ]] && mamba install -c bioconda bedops

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


Looking for: ['bedops']

bioconda/noarch                                      4.5MB @   4.1MB/s  1.3s
pkgs/main/linux-64                                   5.9MB @   4.3MB/s  1.6s
pkgs/main/noarch                                   851.4kB @ 510.3kB/s  0.3s
pkgs/r/noarch                                                 No change
bioconda/linux-64                                    5.1MB @   2.9MB/s  1.9s
pkgs/r/linux-64                                               No change
conda-forge/noarch                                  13.3MB @   3.9MB/s  3.7s
conda-forge/linux-64                                33.0MB @   4.2MB/s  8.6s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/pairtools_env

  Updating specs:

   - bedops
   - ca-certificates
   - certifi
   - openssl


  Package   Version  Build       Channel               Size
─────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────

  + bedops   2.4.41  h4ac6f70_1  bioconda/linux-64     11MB

  Summary:

  Install: 1 packages

  Total download: 11MB

─────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
bedops

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```

*Local (WorkMac&mdash;not MacBook) installation in `gff3_env`*
```txt
❯ pip install clodius
Collecting clodius
  Downloading clodius-0.20.1-py2.py3-none-any.whl (82 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 82.6/82.6 kB 2.4 MB/s eta 0:00:00
Collecting h5py
  Downloading h5py-3.9.0-cp310-cp310-macosx_10_9_x86_64.whl (3.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.2/3.2 MB 28.3 MB/s eta 0:00:00
Collecting dask
  Downloading dask-2023.7.0-py3-none-any.whl (1.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 65.2 MB/s eta 0:00:00
Collecting click>=7
  Downloading click-8.1.5-py3-none-any.whl (98 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 98.1/98.1 kB 12.6 MB/s eta 0:00:00
Requirement already satisfied: numpy in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from clodius) (1.24.2)
Collecting pydantic
  Downloading pydantic-2.0.2-py3-none-any.whl (359 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 359.1/359.1 kB 31.9 MB/s eta 0:00:00
Collecting negspy
  Downloading negspy-0.2.24.tar.gz (1.7 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 72.8 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Collecting cooler>0.9.0
  Downloading cooler-0.9.2-py2.py3-none-any.whl (103 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.9/103.9 kB 14.7 MB/s eta 0:00:00
Collecting pybbi>=0.2.0
  Downloading pybbi-0.3.5-cp310-cp310-macosx_10_9_x86_64.whl (2.5 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.5/2.5 MB 3.7 MB/s eta 0:00:00
Collecting slugid
  Downloading slugid-2.0.0-py2.py3-none-any.whl (8.2 kB)
Collecting sortedcontainers
  Downloading sortedcontainers-2.4.0-py2.py3-none-any.whl (29 kB)
Requirement already satisfied: pysam in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from clodius) (0.20.0)
Collecting pandas>=1.0
  Downloading pandas-2.0.3-cp310-cp310-macosx_10_9_x86_64.whl (11.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 11.8/11.8 MB 73.1 MB/s eta 0:00:00
Collecting requests
  Downloading requests-2.31.0-py3-none-any.whl (62 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.6/62.6 kB 7.4 MB/s eta 0:00:00
Collecting tqdm
  Downloading tqdm-4.65.0-py3-none-any.whl (77 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 77.1/77.1 kB 8.5 MB/s eta 0:00:00
Collecting pyfaidx
  Downloading pyfaidx-0.7.2.1-py3-none-any.whl (28 kB)
Collecting scipy>=0.16
  Downloading scipy-1.11.1-cp310-cp310-macosx_10_9_x86_64.whl (37.2 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 37.2/37.2 MB 68.1 MB/s eta 0:00:00
Collecting multiprocess
  Downloading multiprocess-0.70.14-py310-none-any.whl (134 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.3/134.3 kB 15.6 MB/s eta 0:00:00
Collecting asciitree
  Downloading asciitree-0.3.3.tar.gz (4.0 kB)
  Preparing metadata (setup.py) ... done
Requirement already satisfied: pyyaml in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from cooler>0.9.0->clodius) (6.0)
Collecting simplejson
  Downloading simplejson-3.19.1-cp310-cp310-macosx_10_9_x86_64.whl (76 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 76.4/76.4 kB 8.7 MB/s eta 0:00:00
Collecting cytoolz
  Downloading cytoolz-0.12.1-cp310-cp310-macosx_10_9_x86_64.whl (409 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 409.9/409.9 kB 41.7 MB/s eta 0:00:00
Collecting pytz>=2020.1
  Downloading pytz-2023.3-py2.py3-none-any.whl (502 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 502.3/502.3 kB 46.0 MB/s eta 0:00:00
Collecting tzdata>=2022.1
  Downloading tzdata-2023.3-py2.py3-none-any.whl (341 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 341.8/341.8 kB 38.7 MB/s eta 0:00:00
Requirement already satisfied: python-dateutil>=2.8.2 in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from pandas>=1.0->clodius) (2.8.2)
Requirement already satisfied: importlib-metadata>=4.13.0 in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from dask->clodius) (6.3.0)
Collecting toolz>=0.10.0
  Downloading toolz-0.12.0-py3-none-any.whl (55 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 55.8/55.8 kB 6.5 MB/s eta 0:00:00
Collecting partd>=1.2.0
  Downloading partd-1.4.0-py3-none-any.whl (18 kB)
Collecting cloudpickle>=1.5.0
  Downloading cloudpickle-2.2.1-py3-none-any.whl (25 kB)
Collecting fsspec>=2021.09.0
  Downloading fsspec-2023.6.0-py3-none-any.whl (163 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 163.8/163.8 kB 22.4 MB/s eta 0:00:00
Requirement already satisfied: packaging>=20.0 in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from dask->clodius) (23.1)
Collecting pydantic-core==2.1.2
  Downloading pydantic_core-2.1.2-cp310-cp310-macosx_10_7_x86_64.whl (1.5 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.5/1.5 MB 65.2 MB/s eta 0:00:00
Collecting annotated-types>=0.4.0
  Downloading annotated_types-0.5.0-py3-none-any.whl (11 kB)
Collecting typing-extensions>=4.6.1
  Downloading typing_extensions-4.7.1-py3-none-any.whl (33 kB)
Requirement already satisfied: setuptools in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from pyfaidx->clodius) (67.6.1)
Requirement already satisfied: six in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from pyfaidx->clodius) (1.16.0)
Requirement already satisfied: certifi>=2017.4.17 in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from requests->clodius) (2023.5.7)
Collecting idna<4,>=2.5
  Downloading idna-3.4-py3-none-any.whl (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.5/61.5 kB 7.1 MB/s eta 0:00:00
Collecting urllib3<3,>=1.21.1
  Downloading urllib3-2.0.3-py3-none-any.whl (123 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 123.6/123.6 kB 14.9 MB/s eta 0:00:00
Collecting charset-normalizer<4,>=2
  Downloading charset_normalizer-3.2.0-cp310-cp310-macosx_10_9_x86_64.whl (126 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 126.4/126.4 kB 12.7 MB/s eta 0:00:00
Requirement already satisfied: zipp>=0.5 in /Users/kalavatt/mambaforge/envs/gff3_env/lib/python3.10/site-packages (from importlib-metadata>=4.13.0->dask->clodius) (3.15.0)
Collecting locket
  Downloading locket-1.0.0-py2.py3-none-any.whl (4.4 kB)
Collecting dill>=0.3.6
  Downloading dill-0.3.6-py3-none-any.whl (110 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 110.5/110.5 kB 12.6 MB/s eta 0:00:00
Building wheels for collected packages: negspy, asciitree
  Building wheel for negspy (setup.py) ... done
  Created wheel for negspy: filename=negspy-0.2.24-py3-none-any.whl size=1725345 sha256=13b048a349cdb6763e6e3dcb3a866c4ba292dbd0a9659b71610df00ee31fa36b
  Stored in directory: /Users/kalavatt/Library/Caches/pip/wheels/4c/01/07/77d7b941e82a624da932e7745bb9a1265418559a23b7bec627
  Building wheel for asciitree (setup.py) ... done
  Created wheel for asciitree: filename=asciitree-0.3.3-py3-none-any.whl size=5034 sha256=d496e403f0686077c3d61c8e94f4ddf21b425713ec0113881800002f0ae93dc2
  Stored in directory: /Users/kalavatt/Library/Caches/pip/wheels/7f/4e/be/1171b40f43b918087657ec57cf3b81fa1a2e027d8755baa184
Successfully built negspy asciitree
Installing collected packages: sortedcontainers, slugid, pytz, negspy, asciitree, urllib3, tzdata, typing-extensions, tqdm, toolz, simplejson, scipy, pyfaidx, pybbi, locket, idna, h5py, fsspec, dill, cloudpickle, click, charset-normalizer, annotated-types, requests, pydantic-core, partd, pandas, multiprocess, cytoolz, pydantic, dask, cooler, clodius
Successfully installed annotated-types-0.5.0 asciitree-0.3.3 charset-normalizer-3.2.0 click-8.1.5 clodius-0.20.1 cloudpickle-2.2.1 cooler-0.9.2 cytoolz-0.12.1 dask-2023.7.0 dill-0.3.6 fsspec-2023.6.0 h5py-3.9.0 idna-3.4 locket-1.0.0 multiprocess-0.70.14 negspy-0.2.24 pandas-2.0.3 partd-1.4.0 pybbi-0.3.5 pydantic-2.0.2 pydantic-core-2.1.2 pyfaidx-0.7.2.1 pytz-2023.3 requests-2.31.0 scipy-1.11.1 simplejson-3.19.1 slugid-2.0.0 sortedcontainers-2.4.0 toolz-0.12.0 tqdm-4.65.0 typing-extensions-4.7.1 tzdata-2023.3 urllib3-2.0.3


❯ mamba install -c bioconda bedops

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


Looking for: ['bedops']

bioconda/osx-64                                      4.2MB @   4.5MB/s  1.0s
bioconda/noarch                                      4.5MB @   4.3MB/s  1.2s
pkgs/main/osx-64                                     5.6MB @   4.7MB/s  1.3s
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                   851.4kB @ 620.4kB/s  0.5s
conda-forge/noarch                                  13.3MB @   4.6MB/s  3.2s
conda-forge/osx-64                                  29.7MB @   4.6MB/s  7.2s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - bedops
   - ca-certificates
   - certifi
   - openssl


  Package                     Version  Build               Channel                  Size
──────────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────────

  + bedops                     2.4.41  h85dcccf_1          bioconda/osx-64          13MB
  + htslib                       1.17  h567f53e_1          bioconda/osx-64           2MB
  + samtools                     1.17  h25dfcfb_1          bioconda/osx-64         463kB

  Change:
──────────────────────────────────────────────────────────────────────────────────────────

  - bioconductor-rtracklayer   1.58.0  r42h6e925bd_1       bioconda
  + bioconductor-rtracklayer   1.58.0  r42h4bb2b61_2       bioconda/osx-64           6MB
  - krb5                       1.20.1  h0165f36_0          conda-forge
  + krb5                       1.20.1  h049b76e_0          conda-forge/osx-64     Cached
  - sigtool                     0.1.3  h57ddcff_0          conda-forge
  + sigtool                     0.1.3  h88f4db0_0          conda-forge/osx-64     Cached

  Upgrade:
──────────────────────────────────────────────────────────────────────────────────────────

  - curl                       7.87.0  haf73cf8_0          conda-forge
  + curl                       7.88.1  h6df9250_1          conda-forge/osx-64      143kB
  - libcurl                    7.87.0  haf73cf8_0          conda-forge
  + libcurl                    7.88.1  h6df9250_1          conda-forge/osx-64      344kB
  - libnghttp2                 1.51.0  h0dd9d14_0          conda-forge
  + libnghttp2                 1.52.0  he2ab024_0          conda-forge/osx-64     Cached
  - libssh2                    1.10.0  h7535e13_3          conda-forge
  + libssh2                    1.11.0  hd019ec5_0          conda-forge/osx-64     Cached
  - openssl                    1.1.1t  hfd90126_0          conda-forge
  + openssl                     3.1.1  h8a1eda9_1          conda-forge/osx-64     Cached
  - python                     3.10.0  h1248fe1_3_cpython  conda-forge
  + python                    3.10.10  he7542f4_0_cpython  conda-forge/osx-64       12MB
  - r-openssl                   2.0.5  r42h13d56fc_0       conda-forge
  + r-openssl                   2.0.6  r42hc61a7e2_1       conda-forge/osx-64      633kB

  Downgrade:
──────────────────────────────────────────────────────────────────────────────────────────

  - mysql-connector-c          6.1.11  h0f02589_1007       conda-forge
  + mysql-connector-c           6.1.6  2                   bioconda/osx-64           7MB
  - ucsc-liftover                 377  h516baf0_2          bioconda
  + ucsc-liftover                 366  h1341992_0          bioconda/osx-64           2MB

  Summary:

  Install: 3 packages
  Change: 3 packages
  Upgrade: 7 packages
  Downgrade: 2 packages

  Total download: 43MB

──────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libcurl                                            344.2kB @   6.1MB/s  0.1s
curl                                               143.3kB @   2.3MB/s  0.1s
samtools                                           462.8kB @   4.5MB/s  0.0s
r-openssl                                          633.5kB @   6.0MB/s  0.1s
htslib                                               2.5MB @  15.9MB/s  0.1s
ucsc-liftover                                        2.2MB @   4.2MB/s  0.5s
bioconductor-rtracklayer                             5.5MB @  10.1MB/s  0.4s
python                                              12.0MB @  21.7MB/s  0.6s
mysql-connector-c                                    6.9MB @  11.6MB/s  0.6s
bedops                                              12.9MB @  16.7MB/s  0.7s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />


<a id="set-up-the-micro-c-processing-workflow"></a>
## Set up the Micro-C processing workflow
<a id="0-get-situated"></a>
### 0. Get situated
<a id="get-to-work-directory-initialize-environment"></a>
#### Get to work directory, initialize environment
<a id="start-or-enter-tmux-session"></a>
##### Start or enter `tmux` session
<a id="grabnode"></a>
##### `grabnode`
<a id="go-to-work-directory-initialize-environment"></a>
##### Go to work directory, initialize environment
<a id="printed-4"></a>
###### Printed
<details>
<summary><i>Printed: Go to work directory, initialize environment</i></summary>

```txt
❯ #LOAD


❯ p_base="${HOME}/tsukiyamalab/kalavatt"


❯ p_proj="2023_rDNA/results/2023-0307_work_Micro-C_align-process"


❯ cd "${p_base}/${p_proj}" || echo "cd'ing failed; check on this..."


❯ [[ "${CONDA_DEFAULT_ENV}" != "pairtools_env" ]] \
>     && source activate pairtools_env \
>     || conda activate pairtools_env
```
</details>
<br />

<a id="symlink-to-and-rename-files-of-interest"></a>
#### Symlink to and rename files of interest
<a id="initialize-variables-and-arrays-run-checks"></a>
##### Initialize variables and arrays, run checks
<a id="printed-5"></a>
###### Printed
<details>
<summary><i>Printed: Symlink to and rename files of interest</i></summary>

```txt
❯ p_Mol_Cell_2019="${HOME}/2023_rDNA_data/PRJNA493742"
❯ p_eLife_2020="${HOME}/2023_rDNA_data/PRJNA636358"
❯ p_eLife_2021="${HOME}/2023_rDNA_data/PRJNA702747"


❯ ls -1 "${p_Mol_Cell}"
md5sum
n_char
PRJNA493742.SRR.txt.gz
PRJNA493742.tsv.gz
SRR7939017_1.fastq.gz
SRR7939017_2.fastq.gz
SRR7939018_1.fastq.gz
SRR7939018_2.fastq.gz
SRR7939019_1.fastq.gz
SRR7939019_2.fastq.gz
SRR7939020_1.fastq.gz
SRR7939020_2.fastq.gz


❯ ls -1 "${p_eLife_2020}"
md5sum
n_char
PRJNA636358.SRR.txt.gz
PRJNA636358.tsv.gz
SRR11893084_1.fastq.gz
SRR11893084_2.fastq.gz
SRR11893085_1.fastq.gz
SRR11893085_2.fastq.gz
SRR11893086_1.fastq.gz
SRR11893086_2.fastq.gz
SRR11893087_1.fastq.gz
SRR11893087_2.fastq.gz
SRR11893088_1.fastq.gz
SRR11893088_2.fastq.gz
SRR11893089_1.fastq.gz
SRR11893089_2.fastq.gz
SRR11893090_1.fastq.gz
SRR11893090_2.fastq.gz
SRR11893091_1.fastq.gz
SRR11893091_2.fastq.gz
SRR11893092_1.fastq.gz
SRR11893092_2.fastq.gz
SRR11893093_1.fastq.gz
SRR11893093_2.fastq.gz
SRR11893094_1.fastq.gz
SRR11893094_2.fastq.gz
SRR11893095_1.fastq.gz
SRR11893095_2.fastq.gz
SRR11893096_1.fastq.gz
SRR11893096_2.fastq.gz
SRR11893097_1.fastq.gz
SRR11893097_2.fastq.gz
SRR11893098_1.fastq.gz
SRR11893098_2.fastq.gz
SRR11893099_1.fastq.gz
SRR11893099_2.fastq.gz
SRR11893100_1.fastq.gz
SRR11893100_2.fastq.gz
SRR11893101_1.fastq.gz
SRR11893101_2.fastq.gz
SRR11893102_1.fastq.gz
SRR11893102_2.fastq.gz
SRR11893103_1.fastq.gz
SRR11893103_2.fastq.gz
SRR11893104_1.fastq.gz
SRR11893104_2.fastq.gz
SRR11893105_1.fastq.gz
SRR11893105_2.fastq.gz
SRR11893106_1.fastq.gz
SRR11893106_2.fastq.gz
SRR11893107_1.fastq.gz
SRR11893107_2.fastq.gz
SRR11893109_1.fastq.gz
SRR11893109_2.fastq.gz


❯ ls -1 "${p_eLife_2021}"
md5sum
n_char
PRJNA702747.SRR.txt.gz
PRJNA702747.tsv.gz
SRR13736654_1.fastq.gz
SRR13736654_2.fastq.gz
SRR13736655_1.fastq.gz
SRR13736655_2.fastq.gz
SRR13736656_1.fastq.gz
SRR13736656_2.fastq.gz
SRR13736657_1.fastq.gz
SRR13736657_2.fastq.gz
SRR13736658_1.fastq.gz
SRR13736658_2.fastq.gz
SRR13736659_1.fastq.gz
SRR13736659_2.fastq.gz
SRR13736660_1.fastq.gz
SRR13736660_2.fastq.gz
SRR13736661_1.fastq.gz
SRR13736661_2.fastq.gz


❯ unset A_eLife_2020 && typeset -A A_eLife_2020
❯ unset a_eLife_2020 && typeset -a a_eLife_2020
❯ A_eLife_2020["SRR11893084"]="MC-2020_nz_WT_rep1"; a_eLife_2020="SRR11893084"
❯ A_eLife_2020["SRR11893085"]="MC-2020_nz_WT_rep2"; a_eLife_2020="SRR11893085"
❯ A_eLife_2020["SRR11893086"]="MC-2020_nz_MCD1-AID_rep1"; a_eLife_2020="SRR11893086"
❯ A_eLife_2020["SRR11893087"]="MC-2020_nz_MCD1-AID_rep2"; a_eLife_2020="SRR11893087"
❯ A_eLife_2020["SRR11893088"]="MC-2020_nz_BRN1-AID_rep1"; a_eLife_2020="SRR11893088"
❯ A_eLife_2020["SRR11893089"]="MC-2020_nz_BRN1-AID_rep2"; a_eLife_2020="SRR11893089"
❯ A_eLife_2020["SRR11893090"]="MC-2020_nz_MCD1-AID-BRN1-AID_rep1"; a_eLife_2020="SRR11893090"
❯ A_eLife_2020["SRR11893091"]="MC-2020_nz_MCD1-AID-BRN1-AID_rep2"; a_eLife_2020="SRR11893091"
❯ A_eLife_2020["SRR11893092"]="MC-2020_nz_WPL1-AID_rep1"; a_eLife_2020="SRR11893092"
❯ A_eLife_2020["SRR11893093"]="MC-2020_nz_WPL1-AID_rep2"; a_eLife_2020="SRR11893093"
❯ A_eLife_2020["SRR11893094"]="MC-2020_nz_PDS5-AID_rep0"; a_eLife_2020="SRR11893094"
❯ A_eLife_2020["SRR11893095"]="MC-2020_30C-a15_WT_rep1"; a_eLife_2020="SRR11893095"
❯ A_eLife_2020["SRR11893096"]="MC-2020_30C-a15_WT_rep2"; a_eLife_2020="SRR11893096"
❯ A_eLife_2020["SRR11893107"]="MC-2020_23C-a15_WT_rep0"; a_eLife_2020="SRR11893107"


❯ unset A_Mol_Cell_2019 && typeset -A A_Mol_Cell_2019
❯ unset a_Mol_Cell_2019 && typeset -a a_Mol_Cell_2019
❯ A_Mol_Cell_2019["SRR7939017"]="MC-2019_log_WT_repM"; a_Mol_Cell_2019="MC_log_WT_repM"
❯ A_Mol_Cell_2019["SRR7939018"]="MC-2019_Q_WT_repM"; a_Mol_Cell_2019="MC_Q_WT_repM"


❯ unset A_eLife_2021 && typeset -A A_eLife_2021
❯ unset a_eLife_2021 && typeset -A a_eLife_2021
❯ A_eLife_2021["SRR13736655"]="MC-2021_log_WT_repM"; a_eLife_2021="MC-2021_log_WT_repM"
❯ A_eLife_2021["SRR13736659"]="MC-2021_Q_WT_repM"; a_eLife_2021="MC-2021_Q_WT_repM"


❯ for i in "${!A_eLife_2020[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_eLife_2020[${i}]}"
>     echo ""
> 
>     ls -lhaFG "${p_eLife_2020}/${i}_1.fastq.gz"
>     ls -lhaFG "${p_eLife_2020}/${i}_2.fastq.gz"
>     echo ""
> done
  key  SRR11893107
value  MC-2020_23C-a15_WT_rep0

-rw-rw---- 1 kalavatt 2.4G Mar  2 22:03 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893107_1.fastq.gz
-rw-rw---- 1 kalavatt 2.8G Mar  2 22:03 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893107_2.fastq.gz

  key  SRR11893089
value  MC-2020_nz_BRN1-AID_rep2

-rw-rw---- 1 kalavatt 2.1G Mar  1 22:16 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893089_1.fastq.gz
-rw-rw---- 1 kalavatt 2.2G Mar  1 22:16 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893089_2.fastq.gz

  key  SRR11893088
value  MC-2020_nz_BRN1-AID_rep1

-rw-rw---- 1 kalavatt 2.0G Mar  1 23:15 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893088_1.fastq.gz
-rw-rw---- 1 kalavatt 2.1G Mar  1 23:15 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893088_2.fastq.gz

  key  SRR11893085
value  MC-2020_nz_WT_rep2

-rw-rw---- 1 kalavatt 2.3G Mar  1 20:02 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_1.fastq.gz
-rw-rw---- 1 kalavatt 2.5G Mar  1 20:01 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_2.fastq.gz

  key  SRR11893084
value  MC-2020_nz_WT_rep1

-rw-rw---- 1 kalavatt 2.3G Mar  2 00:24 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_1.fastq.gz
-rw-rw---- 1 kalavatt 2.1G Mar  2 00:24 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_2.fastq.gz

  key  SRR11893087
value  MC-2020_nz_MCD1-AID_rep2

-rw-rw---- 1 kalavatt 2.0G Mar  1 18:34 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893087_1.fastq.gz
-rw-rw---- 1 kalavatt 2.2G Mar  1 18:34 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893087_2.fastq.gz

  key  SRR11893086
value  MC-2020_nz_MCD1-AID_rep1

-rw-rw---- 1 kalavatt 2.2G Mar  1 21:07 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893086_1.fastq.gz
-rw-rw---- 1 kalavatt 2.4G Mar  1 21:07 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893086_2.fastq.gz

  key  SRR11893096
value  MC-2020_30C-a15_WT_rep2

-rw-rw---- 1 kalavatt 2.8G Mar  2 09:18 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_1.fastq.gz
-rw-rw---- 1 kalavatt 3.5G Mar  2 09:17 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_2.fastq.gz

  key  SRR11893094
value  MC-2020_nz_PDS5-AID_rep0

-rw-rw---- 1 kalavatt 2.8G Mar  2 01:38 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893094_1.fastq.gz
-rw-rw---- 1 kalavatt 3.0G Mar  2 01:38 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893094_2.fastq.gz

  key  SRR11893095
value  MC-2020_30C-a15_WT_rep1

-rw-rw---- 1 kalavatt 3.0G Mar  2 04:00 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_1.fastq.gz
-rw-rw---- 1 kalavatt 3.3G Mar  2 04:00 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_2.fastq.gz

  key  SRR11893092
value  MC-2020_nz_WPL1-AID_rep1

-rw-rw---- 1 kalavatt 2.4G Mar  2 05:04 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893092_1.fastq.gz
-rw-rw---- 1 kalavatt 2.7G Mar  2 05:04 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893092_2.fastq.gz

  key  SRR11893093
value  MC-2020_nz_WPL1-AID_rep2

-rw-rw---- 1 kalavatt 2.7G Mar  2 06:15 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893093_1.fastq.gz
-rw-rw---- 1 kalavatt 3.0G Mar  2 06:15 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893093_2.fastq.gz

  key  SRR11893090
value  MC-2020_nz_MCD1-AID-BRN1-AID_rep1

-rw-rw---- 1 kalavatt 2.7G Mar  2 07:34 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893090_1.fastq.gz
-rw-rw---- 1 kalavatt 2.8G Mar  2 07:34 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893090_2.fastq.gz

  key  SRR11893091
value  MC-2020_nz_MCD1-AID-BRN1-AID_rep2

-rw-rw---- 1 kalavatt 1.8G Mar  2 02:29 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893091_1.fastq.gz
-rw-rw---- 1 kalavatt 1.9G Mar  2 02:29 /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893091_2.fastq.gz


❯ for i in "${!A_Mol_Cell_2019[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_Mol_Cell_2019[${i}]}"
>     echo ""
> 
>     ls -lhaFG "${p_Mol_Cell_2019}/${i}_1.fastq.gz"
>     ls -lhaFG "${p_Mol_Cell_2019}/${i}_2.fastq.gz"
>     echo ""
> done
  key  SRR7939018
value  MC-2019_Q_WT_repM

-rw-rw---- 1 kalavatt 2.3G Mar  1 21:39 /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_1.fastq.gz
-rw-rw---- 1 kalavatt 2.3G Mar  1 21:38 /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_2.fastq.gz

  key  SRR7939017
value  MC-2019_log_WT_repM

-rw-rw---- 1 kalavatt 9.7G Mar  2 01:55 /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939017_1.fastq.gz
-rw-rw---- 1 kalavatt 9.9G Mar  2 01:56 /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939017_2.fastq.gz


❯ for i in "${!A_eLife_2021[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_eLife_2021[${i}]}"
>     echo ""
> 
>     ls -lhaFG "${p_eLife_2021}/${i}_1.fastq.gz"
>     ls -lhaFG "${p_eLife_2021}/${i}_2.fastq.gz"
>     echo ""
> done
  key  SRR13736659
value  MC-2021_Q_WT_repM

-rw-rw---- 1 kalavatt 5.7G Jul  6 23:33 /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736659_1.fastq.gz
-rw-rw---- 1 kalavatt 5.7G Jul  6 23:32 /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736659_2.fastq.gz

  key  SRR13736655
value  MC-2021_log_WT_repM

-rw-rw---- 1 kalavatt 9.8G Jul  7 01:12 /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736655_1.fastq.gz
-rw-rw---- 1 kalavatt 9.9G Jul  7 01:12 /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736655_2.fastq.gz
```
</details>
<br />

<a id="symlink-to-and-rename-the-fastqs"></a>
##### Symlink to and rename the `fastq`s
<a id="printed-6"></a>
###### Printed
<details>
<summary><i>Printed: Symlink to and rename the fastqs</i></summary>

```txt
❯ [[ $(pwd) =~ "2023-0307_work_Micro-C_align-process" ]] \
>     && cd "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"


❯ [[ ! -d "sym/" ]] && mkdir -p "sym/"
mkdir: created directory 'sym/'


❯ for i in "${!A_eLife_2020[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_eLife_2020[${i}]}"
>     echo ""
> 
>     ln -s "${p_eLife_2020}/${i}_1.fastq.gz" "sym/${A_eLife_2020[${i}]}_R1.fastq.gz"
>     ln -s "${p_eLife_2020}/${i}_2.fastq.gz" "sym/${A_eLife_2020[${i}]}_R2.fastq.gz"
>     echo ""
> done
  key  SRR11893107
value  MC-2020_23C-a15_WT_rep0


  key  SRR11893089
value  MC-2020_nz_BRN1-AID_rep2


  key  SRR11893088
value  MC-2020_nz_BRN1-AID_rep1


  key  SRR11893085
value  MC-2020_nz_WT_rep2


  key  SRR11893084
value  MC-2020_nz_WT_rep1


  key  SRR11893087
value  MC-2020_nz_MCD1-AID_rep2


  key  SRR11893086
value  MC-2020_nz_MCD1-AID_rep1


  key  SRR11893096
value  MC-2020_30C-a15_WT_rep2


  key  SRR11893094
value  MC-2020_nz_PDS5-AID_rep0


  key  SRR11893095
value  MC-2020_30C-a15_WT_rep1


  key  SRR11893092
value  MC-2020_nz_WPL1-AID_rep1


  key  SRR11893093
value  MC-2020_nz_WPL1-AID_rep2


  key  SRR11893090
value  MC-2020_nz_MCD1-AID-BRN1-AID_rep1


  key  SRR11893091
value  MC-2020_nz_MCD1-AID-BRN1-AID_rep2


❯ for i in "${!A_Mol_Cell_2019[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_Mol_Cell_2019[${i}]}"
>     echo ""
> 
>     ln -s "${p_Mol_Cell_2019}/${i}_1.fastq.gz" "sym/${A_Mol_Cell_2019[${i}]}_R1.fastq.gz"
>     ln -s "${p_Mol_Cell_2019}/${i}_2.fastq.gz" "sym/${A_Mol_Cell_2019[${i}]}_R2.fastq.gz"
>     echo ""
> done
  key  SRR7939018
value  MC-2019_Q_WT_repM


  key  SRR7939017
value  MC-2019_log_WT_repM


❯ for i in "${!A_eLife_2021[@]}"; do
>     echo "  key  ${i}"
>     echo "value  ${A_eLife_2021[${i}]}"
>     echo ""
> 
>     ln -s "${p_eLife_2021}/${i}_1.fastq.gz" "sym/${A_eLife_2021[${i}]}_R1.fastq.gz"
>     ln -s "${p_eLife_2021}/${i}_2.fastq.gz" "sym/${A_eLife_2021[${i}]}_R2.fastq.gz"
>     echo ""
> done
  key  SRR13736659
value  MC-2021_Q_WT_repM


  key  SRR13736655
value  MC-2021_log_WT_repM


❯ ls -lhaFG sym/
total 1.1M
drwxrws---  2 kalavatt 1.9K Aug  3 15:03 ./
drwxrws--- 12 kalavatt  578 Aug  3 14:59 ../
lrwxrwxrwx  1 kalavatt   63 Aug  3 15:03 MC-2019_log_WT_repM_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939017_1.fastq.gz
lrwxrwxrwx  1 kalavatt   63 Aug  3 15:03 MC-2019_log_WT_repM_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939017_2.fastq.gz
lrwxrwxrwx  1 kalavatt   63 Aug  3 15:03 MC-2019_Q_WT_repM_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_1.fastq.gz
lrwxrwxrwx  1 kalavatt   63 Aug  3 15:03 MC-2019_Q_WT_repM_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_23C-a15_WT_rep0_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893107_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_23C-a15_WT_rep0_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893107_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_30C-a15_WT_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_30C-a15_WT_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_30C-a15_WT_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_30C-a15_WT_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_BRN1-AID_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893088_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_BRN1-AID_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893088_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_BRN1-AID_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893089_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_BRN1-AID_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893089_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID-BRN1-AID_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893090_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID-BRN1-AID_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893090_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID-BRN1-AID_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893091_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID-BRN1-AID_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893091_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893086_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893086_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893087_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_MCD1-AID_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893087_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_PDS5-AID_rep0_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893094_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_PDS5-AID_rep0_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893094_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WPL1-AID_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893092_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WPL1-AID_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893092_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WPL1-AID_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893093_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WPL1-AID_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893093_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WT_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WT_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WT_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2020_nz_WT_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2021_log_WT_repM_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736655_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2021_log_WT_repM_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736655_2.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2021_Q_WT_repM_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736659_1.fastq.gz
lrwxrwxrwx  1 kalavatt   64 Aug  3 15:03 MC-2021_Q_WT_repM_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA702747/SRR13736659_2.fastq.gz
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
<a id="printed-7"></a>
###### Printed
<details>
<summary><i>Printed: Initialize "general" variables for workflow</i></summary>

```txt
❯ #LOAD


❯ #  Initialize array of samples to work with
❯ unset stem && typeset -a stem
❯ stem+=( "MC-2019_Q_WT_repM" )        #INITIAL
❯ stem+=( "MC-2020_30C-a15_WT_rep1" )  #INITIAL
❯ stem+=( "MC-2020_30C-a15_WT_rep2" )  #INITIAL
❯ stem+=( "MC-2020_nz_WT_rep1" )       #INITIAL
❯ stem+=( "MC-2020_nz_WT_rep2" )       #INITIAL


❯ #  Initialize arrays of samples to merge
❯ unset to_merge && typeset -a to_merge
❯ to_merge+=( "MC-2020_30C-a15_WT" )
❯ to_merge+=( "MC-2020_nz_WT" )


❯ run_check=TRUE
❯ [[ "${run_check[@]}" == TRUE ]] &&
>     {
>         for i in "${stem[@]}"; do
>             ls -lhaFG "sym/${i}_R1.fastq.gz"
>             ls -lhaFG "sym/${i}_R2.fastq.gz"
>             echo ""
>         done
>     }
lrwxrwxrwx 1 kalavatt 63 Aug  3 15:03 sym/MC-2019_Q_WT_repM_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_1.fastq.gz
lrwxrwxrwx 1 kalavatt 63 Aug  3 15:03 sym/MC-2019_Q_WT_repM_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA493742/SRR7939018_2.fastq.gz

lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_30C-a15_WT_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_1.fastq.gz
lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_30C-a15_WT_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893095_2.fastq.gz

lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_30C-a15_WT_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_1.fastq.gz
lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_30C-a15_WT_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893096_2.fastq.gz

lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_nz_WT_rep1_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_1.fastq.gz
lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_nz_WT_rep1_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893084_2.fastq.gz

lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_nz_WT_rep2_R1.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_1.fastq.gz
lrwxrwxrwx 1 kalavatt 64 Aug  3 15:03 sym/MC-2020_nz_WT_rep2_R2.fastq.gz -> /home/kalavatt/2023_rDNA_data/PRJNA636358/SRR11893085_2.fastq.gz


❯ #  CPU and scratch storage settings
❯ threads="8"                                 # echo "${threads}"
❯ scratch="/fh/scratch/delete30/tsukiyama_t"  # ., "${scratch}"  


❯ #  Settings to run "standard", "rDNA", and "combination" operations
❯ pro_std=TRUE
❯ pro_rDNA=TRUE
❯ pro_comp=TRUE


❯ #  Initialize variables for left- and right-most positions to be considered for
❯ #+ the rDNA locus on XII
❯ rDNA_pos_l=451526  # echo "${rDNA_pos_l}"
❯ rDNA_pos_r=468980  # echo "${rDNA_pos_r}"


❯ [[ "${print_test}" == TRUE ]] &&
>     {
>         echo """
>         General variables for workflow
>         ==============================
>            threads=${threads}
>            scratch=${scratch}
> 
>            pro_std=${pro_std}
>           pro_rDNA=${pro_rDNA}
>           pro_comp=${pro_comp}
> 
>         rDNA_pos_l=${rDNA_pos_l}
>         rDNA_pos_r=${rDNA_pos_r}
>         """
>     }

        General variables for workflow
        ==============================
           threads=8
           scratch=/fh/scratch/delete30/tsukiyama_t

           pro_std=TRUE
          pro_rDNA=TRUE
          pro_comp=TRUE

        rDNA_pos_l=451526
        rDNA_pos_r=468980
```
</details>
<br />

<a id="initialize-specific-variables-arrays-for-workflow"></a>
##### Initialize "specific" variables, arrays for workflow
<a id="run-print-tests-for-the-variables-arrays"></a>
##### Run print tests for the variables, arrays
<a id="initialize-specific-variables-arrays-for-pairtools-merge"></a>
##### Initialize "specific" variables, arrays for `pairtools merge`
<a id="run-print-tests-for-pairtools-merge-variables-arrays"></a>
##### Run print tests for `pairtools merge` variables, arrays
<a id="initialize-varibales-arrays-for-standard-rdna-complete-processing"></a>
##### Initialize varibales, arrays for "`standard-rDNA-complete`" processing
<a id="create-outdirectories-if-not-present"></a>
##### Create outdirectories if not present
<a id="printed-8"></a>
###### Printed
<details>
<summary><i>Printed: Create outdirectories if not present</i></summary>

```txt
❯ [[ ! -d "${d_trim}" ]] && mkdir -p "${d_trim}/err_out"
mkdir: created directory '01_trim'
mkdir: created directory '01_trim/err_out'


❯ [[ ! -d "${d_bam}" ]] && mkdir -p "${d_bam}/err_out"
mkdir: created directory '02_align'
mkdir: created directory '02_align/err_out'


❯ [[ ! -d "${d_pairs}" ]] && mkdir -p "${d_pairs}/err_out"
mkdir: created directory '03_parse'
mkdir: created directory '03_parse/err_out'


❯ [[ ! -d "${d_sort}" ]] && mkdir -p "${d_sort}/err_out"
mkdir: created directory '04_sort'
mkdir: created directory '04_sort/err_out'


❯ [[ ! -d "${d_stats}" ]] && mkdir -p "${d_stats}/err_out"
mkdir: created directory '06_stats'
mkdir: created directory '06_stats/err_out'


❯ [[ ! -d "${d_dedup}" ]] && mkdir -p "${d_dedup}/err_out"
mkdir: created directory '05_dedup'
mkdir: created directory '05_dedup/err_out'


❯ [[ ! -d "${d_cload}" ]] && mkdir -p "${d_cload}/err_out"
mkdir: created directory '07_cload'
mkdir: created directory '07_cload/err_out'


❯ [[ ! -d "${d_zoom}" ]] && mkdir -p "${d_zoom}/err_out"
mkdir: created directory '08_zoom'
mkdir: created directory '08_zoom/err_out'
```
</details>
<br />

<a id="1-trim-fastq-files"></a>
### 1. Trim `fastq` files
<a id="printed-9"></a>
#### Printed
<details>
<summary><i>Printed: 1. Trim fastq files</i></summary>

```txt
❯ #  Perform adapter trimming of fastqs with Atria


❯ run=TRUE


❯ [[ "${run}" == TRUE ]] &&
>     {
>         for (( i = 0; i < ${#stem[@]}; i++ )); do
>             # i=0
> 
>             [[ ! -f "${a_afq_1[${i}]}" && ! -f "${a_afq_2[${i}]}" ]] &&
>                 {
>                     job_name="${d_trim}.${stem[${i}]}"
> 
> #HEREDOC
> sbatch << EOF
> #!/bin/bash
> 
> #SBATCH --job-name=${job_name}
> #SBATCH --nodes=1
> #SBATCH --cpus-per-task=${threads}
> #SBATCH --error="${d_trim}/err_out/${job_name}.%A.stderr.txt"
> #SBATCH --output="${d_trim}/err_out/${job_name}.%A.stdout.txt"
> 
> "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/Atria/app-3.2.2/bin/atria" \
>     -t "${threads}" \
>     -r "${a_fq_1[${i}]}" \
>     -R "${a_fq_2[${i}]}" \
>     -o "${d_trim}" \
>     --no-length-filtration
> 
> #  Store logs in err_out/
> if compgen -G ${d_trim}/*.{log,log.json} > /dev/null; then
>     mv ${d_trim}/*.{log,log.json} "${d_trim}/err_out"
> fi
> EOF
>                 } ||
>                 echo "Trimmed fastqs exist; skipping \"Step #1: Trim fastq files\""
>         done
>     }
Submitted batch job 25460470
Submitted batch job 25460471
Submitted batch job 25460472
Submitted batch job 25460473
Submitted batch job 25460474


❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
          25460470 campus-ne 01_trim. kalavatt  R       5:03      1 gizmok131 8
          25460471 campus-ne 01_trim. kalavatt  R       5:03      1 gizmok137 8
          25460472 campus-ne 01_trim. kalavatt  R       5:03      1 gizmok142 8
          25460473 campus-ne 01_trim. kalavatt  R       5:03      1 gizmok135 8
          25460474 campus-ne 01_trim. kalavatt  R       5:03      1 gizmok135 8
```
</details>
<br />

<a id="2-align-datasets"></a>
### 2. Align datasets
<a id="printed-10"></a>
#### Printed
<details>
<summary><i>Printed: 2. Align datasets</i></summary>

```txt
❯ [[ $(command -v bwa > /dev/null) ]] ||
>     {
>         module purge
>         ml BWA/0.7.17-GCCcore-11.2.0 SAMtools/1.16.1-GCC-11.2.0
>     }


❯ #  These calls to bwa mem and samtools are incorrect --------------------------
❯ #  pairtools parse expects bams unsorted after bwa mem alignment, which are in
❯ #+ QNAME order, so *don't* run the following chunk, which sees the bwa mem
❯ #+ stream piped to samtools sort for coordinate-based sorting; more info:
❯ #+ github.com/open2c/pairtools/issues/178#issuecomment-1554866847
❯ do_not_do=TRUE
❯ [[ "${do_not_do}" == FALSE ]] &&
>     {
>         {
>             bwa mem \
>                 -t "${threads}" \
>                 -SP "${a_index}" "${a_fq_1}" "${a_fq_2}" \
>                     | samtools sort \
>                         -@ ${threads} \
>                         -O bam \
>                         -o "${a_bam}"
> 
>             if [[ -f "${a_bam}" ]]; then
>                 samtools index \
>                     -@ "${threads}" \
>                     "${a_bam}"
>             fi
>         } \
>             2> >(tee -a "${d_bam}/err_out/$(basename ${a_bam} .bam).stderr.txt" >&2)
>     }


❯ #  These calls to bwa mem and samtools are correct ----------------------------
❯ print_test=TRUE
❯ [[ "${print_test}" == TRUE ]] &&
>     {
>         for (( i = 0; i < ${#stem[@]}; i++ )); do
>             # i=1
> 
>             [[ ! -f "${a_bam[${i}]}" ]] &&
>                 {
>                     job_name="${d_bam}.${stem[${i}]}"
> 
> echo """
> #HEREDOC
> sbatch << EOF
> #!/bin/bash
> 
> #SBATCH --job-name=${job_name}
> #SBATCH --nodes=1
> #SBATCH --cpus-per-task=${threads}
> #SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
> #SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"
> 
> bwa mem \\
>     -t \"${threads}\" \\
>     -SP \\
>     \"${a_index}\" \\
>     \"${a_afq_1[${i}]}\" \\
>     \"${a_afq_2[${i}]}\" \\
>         | samtools view \\
>             -@ ${threads} \\
>             -S -b \\
>                 > \"${a_bam[${i}]}\"
> 
> if [[ -f \"${a_bam}\" ]]; then
>     samtools index \\
>         -@ ${threads} \\
>         \"${a_bam[${i}]}\"
> fi
> EOF
> """
>                 } ||
>                 echo "bam exists; skipping \"Step #2: Align datasets\""
>         done
>     }

#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=02_align.MC-2019_Q_WT_repM
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=02_align/err_out/02_align.MC-2019_Q_WT_repM.%A.stderr.txt
#SBATCH --output=02_align/err_out/02_align.MC-2019_Q_WT_repM.%A.stdout.txt

bwa mem \
    -t "8" \
    -SP \
    "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
    "01_trim/MC-2019_Q_WT_repM_R1.atria.fastq.gz" \
    "01_trim/MC-2019_Q_WT_repM_R2.atria.fastq.gz" \
        | samtools view \
            -@ 8 \
            -S -b \
                > "02_align/MC-2019_Q_WT_repM.bam"

if [[ -f "02_align/MC-2019_Q_WT_repM.bam" ]]; then
    samtools index \
        -@ 8 \
        "02_align/MC-2019_Q_WT_repM.bam"
fi
EOF


#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=02_align.MC-2020_30C-a15_WT_rep1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=02_align/err_out/02_align.MC-2020_30C-a15_WT_rep1.%A.stderr.txt
#SBATCH --output=02_align/err_out/02_align.MC-2020_30C-a15_WT_rep1.%A.stdout.txt

bwa mem \
    -t "8" \
    -SP \
    "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
    "01_trim/MC-2020_30C-a15_WT_rep1_R1.atria.fastq.gz" \
    "01_trim/MC-2020_30C-a15_WT_rep1_R2.atria.fastq.gz" \
        | samtools view \
            -@ 8 \
            -S -b \
                > "02_align/MC-2020_30C-a15_WT_rep1.bam"

if [[ -f "02_align/MC-2019_Q_WT_repM.bam" ]]; then
    samtools index \
        -@ 8 \
        "02_align/MC-2020_30C-a15_WT_rep1.bam"
fi
EOF


#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=02_align.MC-2020_30C-a15_WT_rep2
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=02_align/err_out/02_align.MC-2020_30C-a15_WT_rep2.%A.stderr.txt
#SBATCH --output=02_align/err_out/02_align.MC-2020_30C-a15_WT_rep2.%A.stdout.txt

bwa mem \
    -t "8" \
    -SP \
    "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
    "01_trim/MC-2020_30C-a15_WT_rep2_R1.atria.fastq.gz" \
    "01_trim/MC-2020_30C-a15_WT_rep2_R2.atria.fastq.gz" \
        | samtools view \
            -@ 8 \
            -S -b \
                > "02_align/MC-2020_30C-a15_WT_rep2.bam"

if [[ -f "02_align/MC-2019_Q_WT_repM.bam" ]]; then
    samtools index \
        -@ 8 \
        "02_align/MC-2020_30C-a15_WT_rep2.bam"
fi
EOF


#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=02_align.MC-2020_nz_WT_rep1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=02_align/err_out/02_align.MC-2020_nz_WT_rep1.%A.stderr.txt
#SBATCH --output=02_align/err_out/02_align.MC-2020_nz_WT_rep1.%A.stdout.txt

bwa mem \
    -t "8" \
    -SP \
    "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
    "01_trim/MC-2020_nz_WT_rep1_R1.atria.fastq.gz" \
    "01_trim/MC-2020_nz_WT_rep1_R2.atria.fastq.gz" \
        | samtools view \
            -@ 8 \
            -S -b \
                > "02_align/MC-2020_nz_WT_rep1.bam"

if [[ -f "02_align/MC-2019_Q_WT_repM.bam" ]]; then
    samtools index \
        -@ 8 \
        "02_align/MC-2020_nz_WT_rep1.bam"
fi
EOF


#HEREDOC
sbatch << EOF
#!/bin/bash

#SBATCH --job-name=02_align.MC-2020_nz_WT_rep2
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=02_align/err_out/02_align.MC-2020_nz_WT_rep2.%A.stderr.txt
#SBATCH --output=02_align/err_out/02_align.MC-2020_nz_WT_rep2.%A.stdout.txt

bwa mem \
    -t "8" \
    -SP \
    "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa" \
    "01_trim/MC-2020_nz_WT_rep2_R1.atria.fastq.gz" \
    "01_trim/MC-2020_nz_WT_rep2_R2.atria.fastq.gz" \
        | samtools view \
            -@ 8 \
            -S -b \
                > "02_align/MC-2020_nz_WT_rep2.bam"

if [[ -f "02_align/MC-2019_Q_WT_repM.bam" ]]; then
    samtools index \
        -@ 8 \
        "02_align/MC-2020_nz_WT_rep2.bam"
fi
EOF


❯ #  Run the calls to bwa mem and samtools
❯ run=TRUE
❯ [[ "${run}" == TRUE ]] &&
>     {
>         for (( i = 0; i < ${#stem[@]}; i++ )); do
>             # i=1
> 
>             [[ ! -f "${a_bam[${i}]}" ]] &&
>                 {
>                     job_name="${d_bam}.${stem[${i}]}"
> 
> # echo """
> # #HEREDOC
> # sbatch << EOF
> # #!/bin/bash
> #
> # #SBATCH --job-name=${job_name}
> # #SBATCH --nodes=1
> # #SBATCH --cpus-per-task=${threads}
> # #SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
> # #SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"
> #
> # bwa mem \\
> #     -t \"${threads}\" \\
> #     -SP \\
> #     \"${a_index}\" \\
> #     \"${a_afq_1[${i}]}\" \\
> #     \"${a_afq_2[${i}]}\" \\
> #         | samtools view \\
> #             -@ ${threads} \\
> #             -S -b \\
> #                 > \"${a_bam[${i}]}\"
> #
> # if [[ -f \"${a_bam}\" ]]; then
> #     samtools index \\
> #         -@ ${threads} \\
> #         \"${a_bam[${i}]}\"
> # fi
> # EOF
> # """
> 
> #HEREDOC
> sbatch << EOF
> #!/bin/bash
> 
> #SBATCH --job-name=${job_name}
> #SBATCH --nodes=1
> #SBATCH --cpus-per-task=${threads}
> #SBATCH --error="${d_bam}/err_out/${job_name}.%A.stderr.txt"
> #SBATCH --output="${d_bam}/err_out/${job_name}.%A.stdout.txt"
> 
> bwa mem \
>     -t "${threads}" \
>     -SP \
>     "${a_index}" \
>     "${a_afq_1[${i}]}" \
>     "${a_afq_2[${i}]}" \
>         | samtools view \
>             -@ ${threads} \
>             -S -b \
>                 > "${a_bam[${i}]}"
> 
> if [[ -f "${a_bam}" ]]; then
>     samtools index \
>         -@ ${threads} \
>         "${a_bam[${i}]}"
> fi
> EOF
>                 } ||
>                 echo "bam exists; skipping \"Step #2: Align datasets\""
>         done
>     }
Submitted batch job 25476290
Submitted batch job 25476291
Submitted batch job 25476292
Submitted batch job 25476293
Submitted batch job 25476294
```
</details>
<br />

<a id="3-run-pairtools-parse2"></a>
### 3. Run `pairtools parse2`
<a id="printed-11"></a>
#### Printed
<details>
<summary><i>Printed: 3. Run pairtools parse</i></summary>

<a id="check-the-documentation"></a>
##### Check the documentation
<a id="pairtools-parse"></a>
###### `pairtools parse`
<details>
<summary><i>Printed: Check the documentation: pairtools parse</i></summary>

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

<a id="pairtools-parse2"></a>
###### `pairtools parse2`
<details>
<summary><i>Printed: Check the documentation: pairtools parse2</i></summary>

```
❯ pairtools parse2 --help
Usage: pairtools parse2 [OPTIONS] [SAM_PATH]

  Extracts pairs from .sam/.bam data with complex walks, make .pairs. SAM_PATH
  : an input .sam/.bam file with paired-end or single-end sequence alignments
  of Hi-C (or Hi-C-like) molecules. If the path ends with .bam, the input is
  decompressed from bam with samtools. By default, the input is read from
  stdin.

Options:
  -c, --chroms-path TEXT          Chromosome order used to flip
                                  interchromosomal mates: path to a
                                  chromosomes file (e.g. UCSC chrom.sizes or
                                  similar) whose first column lists scaffold
                                  names. Any scaffolds not listed will be
                                  ordered lexicographically following the
                                  names provided.  [required]
  -o, --output TEXT               output file with pairs.  If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed.By default, the output
                                  is printed into stdout.
  --report-position [junction|read|walk|outer]
                                  Reported position of alignments in pairs of
                                  complex walks (pos columns).  Each alignment
                                  in .bam/.sam Hi-C-like data has two ends,
                                  and you can report one or another depending
                                  of the position of alignment on a read or in
                                  a pair.

                                  "junction" - inner ends of sequential
                                  alignments in each pair, aka ligation
                                  junctions (complex walks default), "read" -
                                  5'-end of alignments relative to R1 or R2
                                  read coordinate system (as in traditional
                                  Hi-C), "walk" - 5'-end of alignments
                                  relative to the whole walk coordinate
                                  system, "outer" - outer ends of sequential
                                  alignments in each pair.
  --report-orientation [pair|read|walk|junction]
                                  Reported orientataion of pairs in complex
                                  walk (strand columns). Each alignment in
                                  .bam/.sam Hi-C-like data has orientation,
                                  and you can report it relative to the read,
                                  pair or whole walk coordinate system.

                                  "pair" - orientation as if each pair in
                                  complex walk was sequenced independently
                                  from the outer ends or molecule (as in
                                  traditional Hi-C, also complex walks
                                  default), "read" - orientation defined by
                                  the read (R1 or R2 read coordinate system),
                                  "walk" - orientation defined by the walk
                                  coordinate system, "junction" - reversed
                                  "pair" orientation, as if pair was sequenced
                                  in both directions starting from the
                                  junction
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10) to
                                  store in the pairs header.
  --min-mapq INTEGER              The minimal MAPQ score to consider a read as
                                  uniquely mapped.  [default: 1]
  --max-inter-align-gap INTEGER   Read segments that are not covered by any
                                  alignment and longer than the specified
                                  value are treated as "null" alignments.
                                  These null alignments convert otherwise
                                  linear alignments into walks, and affect how
                                  they get reported as a Hi-C pair.  [default:
                                  20]
  --max-insert-size INTEGER       When searching for overlapping ends of left
                                  and right read (R1 and R2), this sets the
                                  minimal distance when two alignments on the
                                  same strand and chromosome are considered
                                  part of the same fragment (and thus reported
                                  as the same alignment and not a pair). For
                                  traditional Hi-C with long restriction
                                  fragments and shorter molecules after
                                  ligation+sonication, this can be the
                                  expected molecule size. For complex walks
                                  with short restriction fragments, this can
                                  be the expected restriction fragment size.
                                  Note that unsequenced insert is *terra
                                  incognita* and might contain unsequenced DNA
                                  (including ligations) in it. This parameter
                                  is ignored in --single-end mode.   [default:
                                  500]
  --dedup-max-mismatch INTEGER    Allowed mismatch between intramolecular
                                  alignments to detect readthrough duplicates.
                                  Pairs with both sides mapped within this
                                  distance (bp) from each other are considered
                                  duplicates.   [default: 3]
  --single-end                    If specified, the input is single-end. Never
                                  use this for paired-end data, because R1
                                  read will be omitted. If single-end data is
                                  provided, but parameter is unset, the pairs
                                  will be generated, but may contain
                                  artificial UN pairs.
  --expand / --no-expand          If specified, perform combinatorial
                                  expansion on the pairs. Combinatorial
                                  expansion is a way to increase the number of
                                  contacts in you data, assuming that all DNA
                                  fragments in the same molecule (read) are in
                                  contact. Expanded pairs have modified pair
                                  type, 'E{separation}_{pair type}'
  --max-expansion-depth INTEGER   Works in combination with --expand. Maximum
                                  number of segments separating pair. By
                                  default, expanding all possible
                                  pairs.Setting the number will limit the
                                  expansion depth and enforce contacts from
                                  the same side of the read.
  --add-pair-index                If specified, parse2 will report pair index
                                  in the walk as additional columns (R1, R2,
                                  R1&R2 or R1-R2). See documentation: https://
                                  pairtools.readthedocs.io/en/latest/parsing.h
                                  tml#rescuing-complex-walks For combinatorial
                                  expanded pairs, two numbers will be
                                  reported: original pair index of the left
                                  and right segments.
  --flip / --no-flip              If specified, flip pairs in genomic order
                                  and instead preserve the order in which they
                                  were sequenced. Note that no flip is
                                  recommended for analysis of walks because it
                                  will override the order of alignments in
                                  pairs. Flip is required for appropriate
                                  deduplication of sorted pairs. Flip is not
                                  required for cooler cload, which runs
                                  flipping internally.
  --add-columns TEXT              Report extra columns describing alignments
                                  Possible values (can take multiple values as
                                  a comma-separated list): a SAM tag (any pair
                                  of uppercase letters) or mapq, pos5, pos3,
                                  cigar, read_len, matched_bp, algn_ref_span,
                                  algn_read_span, dist_to_5, dist_to_3, seq,
                                  mismatches.
  --drop-readid / --keep-readid   If specified, do not add read ids to the
                                  output. By default, keep read ids. Useful
                                  for long walks analysis.
  --readid-transform TEXT         A Python expression to modify read IDs.
                                  Useful when read IDs differ between the two
                                  reads of a pair. Must be a valid Python
                                  expression that uses variables called readID
                                  and/or i (the 0-based index of the read pair
                                  in the bam file) and returns a new value,
                                  e.g. "readID[:-2]+'_'+str(i)". Make sure
                                  that transformed readIDs remain unique!
  --drop-seq / --keep-seq         Remove sequences and PHREDs from the sam
                                  fields by default. Kept otherwise.
  --drop-sam / --keep-sam         Do not add sams to the output by default.
                                  Kept otherwise.
  --output-parsed-alignments TEXT
                                  output file with all parsed alignments (one
                                  alignment per line). Useful for debugging
                                  and analysis of walks. If file exists, it
                                  will be open in the append mode. If the path
                                  ends with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed. By default, not used.
  --output-stats TEXT             output file for various statistics of pairs
                                  file.  By default, statistics is not
                                  generated.
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

<a id="run-pairtools-parse"></a>
##### Run `pairtools parse`
<details>
<summary><i>Printed: Run pairtools parse</i></summary>

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


❯ [[ "${run}" == TRUE ]] &&
>     {
>         pairtools parse \
>             -o "${a_pairs}" \
>             -c "${a_size}" \
>             --drop-sam \
>             --drop-seq \
>             --output-stats "${a_stats}" \
>             --assembly "${assembly}" \
>             --no-flip \
>             --add-columns mapq \
>             --walks-policy mask \
>             "${a_bam}" \
>                 2> >(tee -a "${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).stderr.txt" >&2)
>     }
[E::idx_find_and_load] Could not retrieve index file for '02_align/SRR7939018.bam'
WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/stats.py:888: RuntimeWarning: divide by zero encountered in double_scalars
  complexity = float(nseq / seq_to_complexity)  # clean np.int64 data type
```
</details>
<br />

<a id="run-pairtools-parse2"></a>
##### Run `pairtools parse2`
<details>
<summary><i>Printed: Run pairtools parse2</i></summary>

<a id="testing-the-standard-call-to-pairtools-parse2"></a>
###### Testing the standard call to `pairtools parse2`
```txt
❯ [[ "${test}" == TRUE ]] &&
>     {
>         echo """
>         pairtools parse2 \\
>             -o \"${a_pairs%.txt.gz}.p2.txt.gz\" \\
>             -c \"${a_size}\" \\
>             --report-position outer \\
>             --report-orientation pair \\
>             --assembly \"${assembly}\" \\
>             --dedup-max-mismatch \"${max_mismatch}\" \\
>             --expand \\
>             --add-pair-index \\
>             --no-flip \\
>             --add-columns pos5,pos3,mapq,mismatches \\
>             --drop-seq \\
>             --drop-sam \\
>             --output-stats \"${a_stats%.txt}.p2.txt\" \\
>             --nproc-in \"${threads}\" \\
>             --nproc-out \"${threads}\" \\
>             \"${a_bam}\" \\
>                 2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).p2.stderr.txt\" >&2)
>         """
>     }

        pairtools parse2 \
            -o "03_parse/SRR7939018.p2.txt.gz" \
            -c "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size" \
            --report-position outer \
            --report-orientation pair \
            --assembly "S288C_R64-3-1" \
            --dedup-max-mismatch "0" \
            --expand \
            --add-pair-index \
            --no-flip \
            --add-columns pos5,pos3,mapq,mismatches \
            --drop-seq \
            --drop-sam \
            --output-stats "0X_stats/SRR7939018.stats.p2.txt" \
            --nproc-in "8" \
            --nproc-out "8" \
            "02_align/SRR7939018.bam" \
                2> >(tee -a "03_parse/err_out/SRR7939018.p2.stderr.txt" >&2)


❯ [[ "${test}" == TRUE ]] &&
>     {
>         pairtools parse2 \
>             -o "${a_pairs%.txt.gz}.p2.txt.gz" \
>             -c "${a_size}" \
>             --report-position outer \
>             --report-orientation pair \
>             --assembly "${assembly}" \
>             --dedup-max-mismatch "${max_mismatch}" \
>             --expand \
>             --add-pair-index \
>             --no-flip \
>             --add-columns pos5,pos3,mapq,mismatches \
>             --drop-seq \
>             --drop-sam \
>             --output-stats "${a_stats%.txt}.p2.txt" \
>             --nproc-in "${threads}" \
>             --nproc-out "${threads}" \
>             "${a_bam}" \
>                 2> >(tee -a "${d_pairs}/err_out/$(basename ${a_pairs} .txt.gz).p2.stderr.txt" >&2)
>     }
[E::idx_find_and_load] Could not retrieve index file for '02_align/SRR7939018.bam'
WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/stats.py:888: RuntimeWarning: divide by zero encountered in double_scalars
  complexity = float(nseq / seq_to_complexity)  # clean np.int64 data type
```

<a id="testing-the-keep-mm-call-to-pairtools-parse2"></a>
###### Testing the "`keep-MM`" call to `pairtools parse2`
```txt
❯ #DONE Can save space by excluding "mismatches" in --add-columns


❯ print_test=TRUE


❯ [[ "${print_test}" == TRUE && -f "${a_bam}" && ! -f "${a_pairs}" ]] &&
>     {
>         echo """
>         pairtools parse2 \\
>             -o \"${a_pairs}\" \\
>             -c \"${a_size}\" \\
>             --report-position outer \\
>             --report-orientation pair \\
>             --assembly \"${assembly}\" \\
>             --min-mapq \"${min_mapq}\" \\
>             --dedup-max-mismatch \"${max_mismatch}\" \\
>             --expand \\
>             --add-pair-index \\
>             --no-flip \\
>             --add-columns pos5,pos3,mapq \\
>             --drop-seq \\
>             --drop-sam \\
>             --output-stats \"${a_stats}\" \\
>             --nproc-in \"${threads}\" \\
>             --nproc-out \"${threads}\" \\
>             \"${a_bam}\" \\
>                 2> >(tee -a \"${d_pairs}/err_out/${f_pre}.stderr.txt\" >&2)
>         """
>     } ||
>     {
>         echo "Warning: \"Step #3: Run pairtools parse\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }

        pairtools parse2 \
            -o "03_parse/SRR7939018.rDNA.txt.gz" \
            -c "/home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size" \
            --report-position outer \
            --report-orientation pair \
            --assembly "S288C_R64-3-1" \
            --min-mapq "0" \
            --dedup-max-mismatch "0" \
            --expand \
            --add-pair-index \
            --no-flip \
            --add-columns pos5,pos3,mapq \
            --drop-seq \
            --drop-sam \
            --output-stats "06_stats/SRR7939018.rDNA.stats.txt" \
            --nproc-in "8" \
            --nproc-out "8" \
            "02_align/SRR7939018.bam" \
                2> >(tee -a "03_parse/err_out/SRR7939018.rDNA.stderr.txt" >&2)


❯ #NOTE pairtools parse2 is quite time-consuming in comparison to pairtools parse


❯ [[ -f "${a_bam}" && ! -f "${a_pairs}" ]] &&
>     {
>         pairtools parse2 \
>             -o "${a_pairs}" \
>             -c "${a_size}" \
>             --report-position outer \
>             --report-orientation pair \
>             --assembly "${assembly}" \
>             --min-mapq "${min_mapq}" \
>             --dedup-max-mismatch "${max_mismatch}" \
>             --expand \
>             --add-pair-index \
>             --no-flip \
>             --add-columns pos5,pos3,mapq \
>             --drop-seq \
>             --drop-sam \
>             --output-stats "${a_stats}" \
>             --nproc-in "${threads}" \
>             --nproc-out "${threads}" \
>             "${a_bam}" \
>                 2> >(tee -a "${d_pairs}/err_out/${f_pre}.stderr.txt" >&2)
>     } ||
>     {
>         echo "Warning: \"Step #3: Run pairtools parse\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
[E::idx_find_and_load] Could not retrieve index file for '02_align/SRR7939018.bam'
WARNING:py.warnings:/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/stats.py:888: RuntimeWarning: divide by zero encountered in double_scalars
  complexity = float(nseq / seq_to_complexity)  # clean np.int64 data type
```
</details>
<br />

<a id="examine-the-pairs-outfile"></a>
##### Examine the pairs outfile
<details>
<summary><i>Printed: Examine the pairs outfile</i></summary>

<a id="testing-the-standard-call-to-pairtools-parse2-1"></a>
###### Testing the standard call to `pairtools parse2`
```txt
❯ zcat "${a_pairs}" | wc -l
66838465


❯ samtools view -c "${a_bam}"
133674984


❯ samtools view "${a_bam}" | head
SRR7939018.1    77  *   0   0   *   *   0   0   TNTTANNNNNNNNNNNNNNNNGCGAAGGTGANAGTTGGTTGATACTTTCA  G#<<G################<<<GGGIGGG#<<<GGGIIIIIIIIGIII  AS:i:0  XS:i:0
SRR7939018.1    141 *   0   0   *   *   0   0   ACGAATCTTNCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGGIGII#<G######################################  AS:i:0  XS:i:0
SRR7939018.2    77  *   0   0   *   *   0   0   TCTTTNNNNNNNNNNNNNNNANNGNAACGTTNNNNNNNANNAGNNNGCGT  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.2    141 *   0   0   *   *   0   0   CGTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.3    77  *   0   0   *   *   0   0   TGCAGGANNNNNNTNNTTNNGANTTTACGCANNNNCAGGGAAAAGTTGCT  GGGGGII######<##<<##<<#<<GGGIII####<<GGIIIIIIIIIGI  AS:i:0  XS:i:0
SRR7939018.3    141 *   0   0   *   *   0   0   ACCACNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.4    77  *   0   0   *   *   0   0   ACCCACTATCCTNGCCGGTTCGGTGGCCAGCNNAAACTTTCGATTCCCCT  GGGGGIIIIIII#<GGGIIIIIIIIIIIIII##<<GGIIIIIIIIIIIII  AS:i:0  XS:i:0
SRR7939018.4    141 *   0   0   *   *   0   0   TCCTCTTCTNCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGGIIII#<G######################################  AS:i:0  XS:i:0
SRR7939018.5    77  *   0   0   *   *   0   0   ANACANNNNNNNNNNNNNNNNNCGTTTTATANATGAGTTATGAATTCCTT  G#################################################  AS:i:0  XS:i:0
SRR7939018.5    141 *   0   0   *   *   0   0   AAATTCGGTACCAANTCTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  A<A<AAGGGIA#######################################  AS:i:0  XS:i:0


❯ n_lines="$(zcat "${a_pairs}" | wc -l)"


❯ echo $(( n_lines - 41 ))  # Subtract header, column-name lines
66838424


❯ n_pairs="$(samtools view -c "${a_bam}")"


❯ echo $(( n_pairs / 2 ))
66837492


❯ echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing from "${a_pairs}"?
-973


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
SRR7939018.1    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.3    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.4    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.5    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.6    !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.7    !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.8    !   0   II  775703  -   +   NU  1   R1-2    0   775703  0   775752  0   60
SRR7939018.9    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.10   !   0   II  10240   -   -   NU  1   R1-2    0   10240   0   10203   0   60      C:N:2:10208:18,G:N:2:10209:19
SRR7939018.11   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.12   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.13   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.14   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.15   II  734242  II  735917  +   +   UU  1   R1-2    734242  735917  734291  735960  60  60
SRR7939018.16   !   0   I   188959  -   -   MU  1   R1-2    0   188959  0   188921  0   60
SRR7939018.17   V   15051   !   0   -   -   UN  1   R1-2    15051   0   15002   0   60  0   T:N:2:15019:18
SRR7939018.18   XIII    906996  XIII    904641  +   +   UU  1   R1-2    906996  904641  907045  904684  60  60
SRR7939018.19   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.20   IV  801779  !   0   +   -   UN  1   R1-2    801779  0   801824  0   60  0   T:N:2:801809:31
SRR7939018.21   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.22   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.23   XII 754749  IX  110448  -   -   UU  1   R1-2    754749  110448  754700  110399  60  60      A:N:2:110398:0,A:N:2:110399:1
SRR7939018.24   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.25   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.26   !   0   XII 460048  -   +   NU  1   R1-2    0   460048  0   460097  0   60
SRR7939018.27   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.28   VII 890436  VII 882095  -   -   UU  1   R1-2    890436  882095  890407  882046  60  60
SRR7939018.29   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.30   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.31   V   41387   V   41544   -   +   UU  1   R1-2    41387   41544   41338   41593   60  60      C:G:13:41581:38
SRR7939018.32   XIV 583189  III 105899  -   +   UU  1   R1-2    583189  105899  583140  105948  60  60
SRR7939018.33   V   375302  V   345311  +   +   UU  1   R1-2    375302  345311  375351  345345  60  60
SRR7939018.34   !   0   II  715798  -   -   MU  1   R1-2    0   715798  0   715749  0   60
SRR7939018.35   II  713403  XIII    881948  -   -   UU  1   R1-2    713403  881948  713354  881899  60  60
SRR7939018.36   !   0   IV  1042066 -   -   NU  1   R1-2    0   1042066 0   1042017 0   60
SRR7939018.37   XII 492804  XIII    479967  -   +   UU  1   R1-2    492804  479967  492755  480016  60  60
SRR7939018.38   V   143625  !   0   +   -   UM  1   R1-2    143625  0   143674  0   60  0
SRR7939018.39   !   0   XII 531643  -   +   NU  1   R1-2    0   531643  0   531692  0   60
SRR7939018.40   !   0   XIII    743635  -   +   NU  1   R1-2    0   743635  0   743684  0   60
SRR7939018.41   IV  424676  IV  424576  -   +   UU  1   R1-2    424676  424576  424647  424610  60  60
SRR7939018.42   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.43   !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.44   XV  194630  XV  195049  -   -   UU  1   R1-2    194630  195049  194581  195000  28  60  T:N:2:194610:30,G:N:2:194611:31,G:N:2:194614:34,G:N:2:194615:35,G:N:2:194617:37,C:N:2:194618:38,A:N:2:194619:39,G:N:2:194620:40,A:N:2:194621:41,A:N:2:194622:42,C:N:2:194623:43,T:N:2:194624:44
SRR7939018.45   !   0   X   49753   -   -   MU  1   R1-2    0   49753   0   49704   0   60
SRR7939018.46   XIII    706297  XIII    705554  -   -   UU  1   R1-2    706297  705554  706248  705505  34  60  C:N:2:706277:30,A:N:2:706278:31,T:N:2:706282:35,A:N:2:706284:37,T:N:2:706285:38,T:N:2:706286:39,T:N:2:706287:40,C:N:2:706288:41,C:N:2:706289:42
SRR7939018.47   XII 973906  XII 974873  -   -   UU  1   R1-2    973906  974873  973865  974824  52  60  G:N:2:973891:35,T:N:2:973893:37,A:N:2:973894:38,G:N:2:973895:39,C:N:2:973896:40,G:N:2:973898:42
SRR7939018.48   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.49   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.50   VII 466949  !   0   +   -   UN  1   R1-2    466949  0   466998  0   60  0
SRR7939018.51   VII 451782  V   204170  -   +   UU  1   R1-2    451782  204170  451733  204219  60  60
SRR7939018.52   XIII    86591   XIII    84823   -   -   UU  1   R1-2    86591   84823   86542   84774   60  60
SRR7939018.53   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.54   IV  496721  IV  354274  +   -   UU  1   R1-2    496721  354274  496770  354225  60  60  A:C:13:496733:13
SRR7939018.55   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.56   !   0   II  58112   -   +   MU  1   R1-2    0   58112   0   58161   0   60
SRR7939018.57   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.58   V   315210  IV  344786  -   +   UU  1   R1-2    315210  344786  315161  344835  60  60
SRR7939018.59   !   0   XII 460368  -   -   MU  1   R1-2    0   460368  0   460319  0   60


❯ zcat "${a_pairs}" | tail -100
SRR7939018.66836973 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66836974 X   698537  !   0   -   -   UN  1   R1-2    698537  0   698488  0   60  0
SRR7939018.66836975 XII 459943  !   0   -   -   UN  1   R1-2    459943  0   459894  0   60  0
SRR7939018.66836976 IV  784040  !   0   -   -   UN  1   R1-2    784040  0   784002  0   60  0
SRR7939018.66836977 XII 416967  !   0   -   -   UN  1   R1-2    416967  0   416918  0   60  0
SRR7939018.66836978 XI  267795  !   0   -   -   UN  1   R1-2    267795  0   267746  0   60  0
SRR7939018.66836979 XII 299855  !   0   -   -   UN  1   R1-2    299855  0   299806  0   60  0
SRR7939018.66836980 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66836981 XI  488216  !   0   +   -   UN  1   R1-2    488216  0   488265  0   60  0   A:N:2:488241:26,A:N:2:488242:27,T:N:2:488243:28,A:N:2:488244:29,T:N:2:488245:30
SRR7939018.66836982 XIV 81040   !   0   -   -   UN  1   R1-2    81040   0   80991   0   60  0   T:N:2:81009:19,G:N:2:81010:20,G:N:2:81011:21,T:N:2:81012:22,T:N:2:81013:23
SRR7939018.66836983 VIII    78157   !   0   -   -   UN  1   R1-2    78157   0   78108   0   60  0   A:N:2:78126:19,A:N:2:78127:20,C:N:2:78128:21,A:N:2:78129:22,C:N:2:78130:23
SRR7939018.66836984 XIII    59626   !   0   -   -   UN  1   R1-2    59626   0   59577   0   60  0   T:N:2:59595:19,T:N:2:59596:20,C:N:2:59597:21,C:N:2:59598:22,T:N:2:59599:23
SRR7939018.66836985 XII 459804  XII 460129  -   +   UU  1   R1-2    459804  460129  459755  460159  18  60
SRR7939018.66836986 XII 788963  XII 831886  -   +   UU  1   R1-2    788963  831886  788914  831935  60  60
SRR7939018.66836987 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66836988 IV  117724  IV  120256  +   +   UU  1   R1-2    117724  120256  117773  120305  60  60
SRR7939018.66836989 VII 484733  VII 523183  -   +   UU  1   R1-2    484733  523183  484684  523232  60  60
SRR7939018.66836990 XII 771037  IV  50585   +   -   UU  1   R1-2    771037  50585   771078  50536   60  60
SRR7939018.66836991 II  447150  II  435629  +   +   UU  1   R1-2    447150  435629  447199  435678  60  60      G:T:40:435671:43
SRR7939018.66836992 I   80736   !   0   +   -   UN  1   R1-2    80736   0   80785   0   60  0
SRR7939018.66836993 X   570149  II  619866  -   -   UU  1   R1-2    570149  619866  570100  619817  60  60
SRR7939018.66836994 IV  1249665 IV  1269898 -   +   UU  1   R1-2    1249665 1269898 1249616 1269947 60  60      C:T:13:1269931:34
SRR7939018.66836995 XIV 620123  !   0   -   -   UN  1   R1-2    620123  0   620074  0   60  0   C:A:13:620121:48
SRR7939018.66836996 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66836997 XIV 551720  XIV 548489  -   -   UU  1   R1-2    551720  548489  551671  548440  60  60
SRR7939018.66836998 !   0   XV  719682  -   +   MU  1   R1-2    0   719682  0   719731  0   60
SRR7939018.66836999 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837000 XII 106700  XII 106928  +   -   UU  1   R1-2    106700  106928  106749  106879  60  60
SRR7939018.66837001 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837002 XV  534163  X   560148  -   -   UU  1   R1-2    534163  560148  534129  560099  60  60
SRR7939018.66837003 VI  180898  !   0   -   -   UN  1   R1-2    180898  0   180849  0   60  0
SRR7939018.66837004 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837005 VII 33694   !   0   -   -   UN  1   R1-2    33694   0   33645   0   60  0
SRR7939018.66837006 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837007 IV  787343  !   0   -   -   UN  1   R1-2    787343  0   787294  0   60  0
SRR7939018.66837008 XV  918029  !   0   +   -   UN  1   R1-2    918029  0   918078  0   60  0
SRR7939018.66837009 VI  131646  !   0   -   -   UN  1   R1-2    131646  0   131597  0   60  0
SRR7939018.66837010 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837011 VII 798455  !   0   -   -   UN  1   R1-2    798455  0   798406  0   60  0
SRR7939018.66837012 XVI 372160  !   0   +   -   UN  1   R1-2    372160  0   372209  0   60  0
SRR7939018.66837013 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837014 XIII    62745   !   0   -   -   UN  1   R1-2    62745   0   62696   0   60  0
SRR7939018.66837015 XIV 670465  !   0   -   -   UN  1   R1-2    670465  0   670416  0   60  0
SRR7939018.66837016 III 220877  !   0   +   -   UN  1   R1-2    220877  0   220926  0   60  0
SRR7939018.66837017 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837018 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837019 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837020 XII 1056596 !   0   +   -   UN  1   R1-2    1056596 0   1056645 0   60  0   A:N:2:1056621:26,A:N:2:1056622:27,C:N:2:1056623:28,G:N:2:1056624:29,C:N:2:1056625:30
SRR7939018.66837021 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837022 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837023 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837024 VII 445502  !   0   -   -   UN  1   R1-2    445502  0   445453  0   44  0   G:N:2:445452:0,A:N:2:445471:19,G:N:2:445472:20,A:N:2:445473:21,G:N:2:445474:22,C:N:2:445475:23,A:N:2:445476:24,G:N:2:445477:25
SRR7939018.66837025 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837026 V   344269  !   0   -   -   UN  1   R1-2    344269  0   344220  0   41  0   G:N:2:344219:0,T:N:2:344220:1,A:N:2:344238:19,T:N:2:344239:20,G:N:2:344240:21,A:N:2:344241:22,A:N:2:344242:23,A:N:2:344243:24,G:N:2:344244:25
SRR7939018.66837027 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837028 XVI 860558  XIV 715069  -   -   UU  1   R1-2    860558  715069  860509  715020  60  60
SRR7939018.66837029 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837030 XVI 614393  XIV 342834  -   +   UU  1   R1-2    614393  342834  614344  342880  60  60
SRR7939018.66837031 X   532857  X   532857  +   +   UU  1   R1-2    532857  532857  532906  532906  60  60      G:T:40:532886:30
SRR7939018.66837032 !   0   XI  551230  -   +   MU  1   R1-2    0   551230  0   551279  0   60
SRR7939018.66837033 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837034 VIII    480083  VIII    479866  -   -   UU  1   R1-2    480083  479866  480034  479829  60  60
SRR7939018.66837035 XI  206780  V   498989  +   -   UU  1   R1-2    206780  498989  206829  498949  60  60
SRR7939018.66837036 XII 459832  !   0   +   -   UM  1   R1-2    459832  0   459881  0   60  0
SRR7939018.66837037 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837038 !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837039 XV  722564  VIII    365579  -   -   UU  1   R1-2    722564  365579  722515  365530  60  60
SRR7939018.66837040 VI  231378  VI  232979  +   -   UU  1   R1-2    231378  232979  231427  232930  60  60
SRR7939018.66837041 XII 699439  VII 20989   -   +   UU  1   R1-2    699439  20989   699390  21038   60  60
SRR7939018.66837042 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837043 IX  72498   !   0   -   -   UN  1   R1-2    72498   0   72449   0   60  0
SRR7939018.66837044 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837045 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837046 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837047 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837048 IV  1138433 !   0   -   -   UN  1   R1-2    1138433 0   1138384 0   60  0
SRR7939018.66837049 XI  76783   !   0   +   -   UN  1   R1-2    76783   0   76817   0   60  0
SRR7939018.66837050 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837051 XIII    805272  !   0   -   -   UN  1   R1-2    805272  0   805223  0   60  0   T:G:27:805248:26
SRR7939018.66837052 XV  347294  !   0   -   -   UN  1   R1-2    347294  0   347245  0   60  0   G:N:2:347263:19,C:N:2:347264:20
SRR7939018.66837053 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837054 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837055 XIV 672789  !   0   -   -   UN  1   R1-2    672789  0   672740  0   60  0   T:N:2:672758:19,A:N:2:672759:20,A:N:2:672760:21,T:N:2:672761:22,T:N:2:672762:23
SRR7939018.66837056 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837057 X   505727  !   0   +   -   UN  1   R1-2    505727  0   505776  0   51  0   G:N:2:505752:26,T:N:2:505753:27,C:N:2:505754:28,T:N:2:505755:29,G:N:2:505756:30,T:C:2:505773:47
SRR7939018.66837058 XV  776053  !   0   -   -   UN  1   R1-2    776053  0   776004  0   60  0   G:N:2:776022:19,T:N:2:776023:20,T:N:2:776024:21,A:N:2:776025:22,A:N:2:776026:23
SRR7939018.66837059 V   337272  !   0   +   -   UN  1   R1-2    337272  0   337321  0   48  0   G:N:2:337295:24,T:N:2:337296:25,G:N:2:337297:26,G:N:2:337298:27,C:N:2:337299:28,T:N:2:337300:29,C:N:2:337301:30
SRR7939018.66837060 VI  245305  !   0   +   -   UN  1   R1-2    245305  0   245354  0   48  0   A:N:2:245328:24,A:N:2:245329:25,A:N:2:245330:26,T:N:2:245331:27,A:N:2:245332:28,T:N:2:245333:29,C:N:2:245334:30
SRR7939018.66837061 XI  431995  !   0   -   -   UN  1   R1-2    431995  0   431946  0   41  0   T:N:2:431945:0,A:N:2:431946:1,G:N:2:431964:19,G:N:2:431965:20,T:N:2:431966:21,T:N:2:431967:22,T:N:2:431968:23,T:N:2:431969:24,G:N:2:431970:25
SRR7939018.66837062 !   0   !   0   -   -   NM  1   R1-2    0   0   0   0   0   0
SRR7939018.66837063 XI  570081  XI  570724  -   +   UU  1   R1-2    570081  570724  570032  570773  60  60  G:A:40:570048:17,G:N:2:570075:44
SRR7939018.66837064 !   0   XIV 364616  -   +   NU  1   R1-2    0   364616  0   364665  0   60
SRR7939018.66837065 XIII    294265  XIII    119732  -   -   UU  1   R1-2    294265  119732  294216  119683  60  60  T:N:2:294259:44
SRR7939018.66837066 X   61461   X   61292   -   -   UU  1   R1-2    61461   61292   61412   61243   60  60  G:N:2:61455:44
SRR7939018.66837067 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837068 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837069 !   0   !   0   -   -   MN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837070 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837071 VII 391704  !   0   -   -   UN  1   R1-2    391704  0   391667  0   60  0   A:N:2:391698:44
SRR7939018.66837072 IX  143298  !   0   +   -   UN  1   R1-2    143298  0   143347  0   55  0   T:N:2:143302:5,G:N:2:143323:26,A:N:2:143324:27,T:N:2:143325:28,A:N:2:143326:29,T:N:2:143327:30
```

<a id="testing-the-keep-mm-call-to-pairtools-parse2-1"></a>
###### Testing the "`keep-MM`" call to `pairtools parse2`
```txt
❯ run_check=TRUE


❯ [[ "${run_check}" == TRUE && -f "${a_pairs}" ]] &&
>     {
>         ., "${a_pairs}"
> 
>         zcat "${a_pairs}" | wc -l
>         samtools view -c "${a_bam}"
> 
>         samtools view "${a_bam}" | head
> 
>         n_lines="$(zcat "${a_pairs}" | wc -l)"
>         echo $(( n_lines - 41 ))  # Subtract header, column-name lines
> 
>         n_pairs="$(samtools view -c "${a_bam}")"
>         echo $(( n_pairs / 2 ))
> 
>         echo $(( $(( n_pairs / 2 )) - n_lines ))  # Pairs missing?
> 
>         zcat "${a_pairs}" | head -100
>         zcat "${a_pairs}" | tail -100
>     } ||
>     {
>         echo "Warning: \"run_check\" for pairs outfile did not run;"
>         echo "         \"\${a_pairs}\" not found"
>         echo "Stopping the operation because you need to check on this..."
>     }
-rw-rw---- 1 kalavatt 1.6G Jul 11 08:50 03_parse/SRR7939018.rDNA.txt.gz


66838675


133674984


SRR7939018.1    77  *   0   0   *   *   0   0   TNTTANNNNNNNNNNNNNNNNGCGAAGGTGANAGTTGGTTGATACTTTCA  G#<<G################<<<GGGIGGG#<<<GGGIIIIIIIIGIII  AS:i:0  XS:i:0
SRR7939018.1    141 *   0   0   *   *   0   0   ACGAATCTTNCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGGIGII#<G######################################  AS:i:0  XS:i:0
SRR7939018.2    77  *   0   0   *   *   0   0   TCTTTNNNNNNNNNNNNNNNANNGNAACGTTNNNNNNNANNAGNNNGCGT  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.2    141 *   0   0   *   *   0   0   CGTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.3    77  *   0   0   *   *   0   0   TGCAGGANNNNNNTNNTTNNGANTTTACGCANNNNCAGGGAAAAGTTGCT  GGGGGII######<##<<##<<#<<GGGIII####<<GGIIIIIIIIIGI  AS:i:0  XS:i:0
SRR7939018.3    141 *   0   0   *   *   0   0   ACCACNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGG#############################################  AS:i:0  XS:i:0
SRR7939018.4    77  *   0   0   *   *   0   0   ACCCACTATCCTNGCCGGTTCGGTGGCCAGCNNAAACTTTCGATTCCCCT  GGGGGIIIIIII#<GGGIIIIIIIIIIIIII##<<GGIIIIIIIIIIIII  AS:i:0  XS:i:0
SRR7939018.4    141 *   0   0   *   *   0   0   TCCTCTTCTNCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  GGGGGIIII#<G######################################  AS:i:0  XS:i:0
SRR7939018.5    77  *   0   0   *   *   0   0   ANACANNNNNNNNNNNNNNNNNCGTTTTATANATGAGTTATGAATTCCTT  G#################################################  AS:i:0  XS:i:0
SRR7939018.5    141 *   0   0   *   *   0   0   AAATTCGGTACCAANTCTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN  A<A<AAGGGIA#######################################  AS:i:0  XS:i:0


66838634


66837492


-1183


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.rDNA.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 0 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.rDNA.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.1    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.3    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.4    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.5    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.6    !   0   XII 451496  -   -   NU  1   R1-2    0   451496  0   451447  0   0
SRR7939018.7    !   0   XII 462587  -   -   NU  1   R1-2    0   462587  0   462547  0   0
SRR7939018.8    !   0   II  775703  -   +   NU  1   R1-2    0   775703  0   775752  0   60
SRR7939018.9    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.10   !   0   II  10240   -   -   NU  1   R1-2    0   10240   0   10203   0   60
SRR7939018.11   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.12   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.13   !   0   VIII    212736  -   -   NU  1   R1-2    0   212736  0   212696  0   0
SRR7939018.14   !   0   XII 459314  -   -   NU  1   R1-2    0   459314  0   459277  0   0
SRR7939018.15   II  734242  II  735917  +   +   UU  1   R1-2    734242  735917  734291  735960  60  60
SRR7939018.16   I   188716  I   188959  +   -   UU  1   R1-2    188716  188959  188765  188921  0   60
SRR7939018.17   V   15051   !   0   -   -   UN  1   R1-2    15051   0   15002   0   60  0
SRR7939018.18   XIII    906996  XIII    904641  +   +   UU  1   R1-2    906996  904641  907045  904684  60  60
SRR7939018.19   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.20   IV  801779  !   0   +   -   UN  1   R1-2    801779  0   801824  0   60  0
SRR7939018.21   XII 462795  XII 462333  -   +   UU  1   R1-2    462795  462333  462755  462376  0   0
SRR7939018.22   XII 466279  XII 490111  +   -   UU  1   R1-2    466279  490111  466328  490062  0   0
SRR7939018.23   XII 754749  IX  110448  -   -   UU  1   R1-2    754749  110448  754700  110399  60  60
SRR7939018.24   !   0   XIV 4199    -   -   NU  1   R1-2    0   4199    0   4150    0   0
SRR7939018.25   !   0   XII 490277  -   -   NU  1   R1-2    0   490277  0   490228  0   0
SRR7939018.26   !   0   XII 460048  -   +   NU  1   R1-2    0   460048  0   460097  0   60
SRR7939018.27   !   0   XII 453244  -   -   NU  1   R1-2    0   453244  0   453195  0   0
SRR7939018.28   VII 890436  VII 882095  -   -   UU  1   R1-2    890436  882095  890407  882046  60  60
SRR7939018.29   !   0   XII 463595  -   -   NU  1   R1-2    0   463595  0   463546  0   0
SRR7939018.30   XII 462505  XII 466348  +   -   UU  1   R1-2    462505  466348  462554  466299  0   0
SRR7939018.31   V   41387   V   41544   -   +   UU  1   R1-2    41387   41544   41338   41593   60  60
SRR7939018.32   XIV 583189  III 105899  -   +   UU  1   R1-2    583189  105899  583140  105948  60  60
SRR7939018.33   V   375302  V   345311  +   +   UU  1   R1-2    375302  345311  375351  345345  60  60
SRR7939018.34   XII 464607  II  715798  -   -   UU  1   R1-2    464607  715798  464558  715749  0   60
SRR7939018.35   II  713403  XIII    881948  -   -   UU  1   R1-2    713403  881948  713354  881899  60  60
SRR7939018.36   !   0   IV  1042066 -   -   NU  1   R1-2    0   1042066 0   1042017 0   60
SRR7939018.37   XII 492804  XIII    479967  -   +   UU  1   R1-2    492804  479967  492755  480016  60  60
SRR7939018.38   V   143625  VII 573765  +   +   UU  1   R1-2    143625  573765  143674  573814  60  0
SRR7939018.39   !   0   XII 531643  -   +   NU  1   R1-2    0   531643  0   531692  0   60
SRR7939018.40   !   0   XIII    743635  -   +   NU  1   R1-2    0   743635  0   743684  0   60
SRR7939018.41   IV  424676  IV  424576  -   +   UU  1   R1-2    424676  424576  424647  424610  60  60
SRR7939018.42   !   0   XII 465739  -   +   NU  1   R1-2    0   465739  0   465788  0   0
SRR7939018.43   !   0   XII 457114  -   +   NU  1   R1-2    0   457114  0   457163  0   0
SRR7939018.44   XV  194630  XV  195049  -   -   UU  1   R1-2    194630  195049  194581  195000  28  60
SRR7939018.45   XVI 944169  X   49753   -   -   UU  1   R1-2    944169  49753   944120  49704   0   60
SRR7939018.46   XIII    706297  XIII    705554  -   -   UU  1   R1-2    706297  705554  706248  705505  34  60
SRR7939018.47   XII 973906  XII 974873  -   -   UU  1   R1-2    973906  974873  973865  974824  52  60
SRR7939018.48   XII 456501  XII 467516  +   +   UU  1   R1-2    456501  467516  456550  467565  0   0
SRR7939018.49   XII 466633  XII 452838  -   -   UU  1   R1-2    466633  452838  466584  452789  0   0
SRR7939018.50   VII 466949  !   0   +   -   UN  1   R1-2    466949  0   466998  0   60  0
SRR7939018.51   VII 451782  V   204170  -   +   UU  1   R1-2    451782  204170  451733  204219  60  60
SRR7939018.52   XIII    86591   XIII    84823   -   -   UU  1   R1-2    86591   84823   86542   84774   60  60
SRR7939018.53   X   10172   VIII    4688    -   +   UU  1   R1-2    10172   4688    10123   4737    0   0
SRR7939018.54   IV  496721  IV  354274  +   -   UU  1   R1-2    496721  354274  496770  354225  60  60
SRR7939018.55   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.56   XII 453154  II  58112   +   +   UU  1   R1-2    453154  58112   453203  58161   0   60
SRR7939018.57   XII 463389  XII 463595  -   -   UU  1   R1-2    463389  463595  463340  463546  0   0
SRR7939018.58   V   315210  IV  344786  -   +   UU  1   R1-2    315210  344786  315161  344835  60  60
SRR7939018.59   XII 461112  XII 460368  -   -   UU  1   R1-2    461112  460368  461083  460319  0   60


SRR7939018.66836973 XII 461999  !   0   -   -   UN  1   R1-2    461999  0   461950  0   0   0
SRR7939018.66836974 X   698537  !   0   -   -   UN  1   R1-2    698537  0   698488  0   60  0
SRR7939018.66836975 XII 459943  !   0   -   -   UN  1   R1-2    459943  0   459894  0   60  0
SRR7939018.66836976 IV  784040  !   0   -   -   UN  1   R1-2    784040  0   784002  0   60  0
SRR7939018.66836977 XII 416967  !   0   -   -   UN  1   R1-2    416967  0   416918  0   60  0
SRR7939018.66836978 XI  267795  !   0   -   -   UN  1   R1-2    267795  0   267746  0   60  0
SRR7939018.66836979 XII 299855  !   0   -   -   UN  1   R1-2    299855  0   299806  0   60  0
SRR7939018.66836980 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66836981 XI  488216  !   0   +   -   UN  1   R1-2    488216  0   488265  0   60  0
SRR7939018.66836982 XIV 81040   !   0   -   -   UN  1   R1-2    81040   0   80991   0   60  0
SRR7939018.66836983 VIII    78157   !   0   -   -   UN  1   R1-2    78157   0   78108   0   60  0
SRR7939018.66836984 XIII    59626   !   0   -   -   UN  1   R1-2    59626   0   59577   0   60  0
SRR7939018.66836985 XII 459804  XII 460129  -   +   UU  1   R1-2    459804  460129  459755  460159  18  60
SRR7939018.66836986 XII 788963  XII 831886  -   +   UU  1   R1-2    788963  831886  788914  831935  60  60
SRR7939018.66836987 XII 451646  XII 452114  -   -   UU  1   R1-2    451646  452114  451597  452065  0   0
SRR7939018.66836988 IV  117724  IV  120256  +   +   UU  1   R1-2    117724  120256  117773  120305  60  60
SRR7939018.66836989 VII 484733  VII 523183  -   +   UU  1   R1-2    484733  523183  484684  523232  60  60
SRR7939018.66836990 XII 771037  IV  50585   +   -   UU  1   R1-2    771037  50585   771078  50536   60  60
SRR7939018.66836991 II  447150  II  435629  +   +   UU  1   R1-2    447150  435629  447199  435678  60  60
SRR7939018.66836992 I   80736   !   0   +   -   UN  1   R1-2    80736   0   80785   0   60  0
SRR7939018.66836993 X   570149  II  619866  -   -   UU  1   R1-2    570149  619866  570100  619817  60  60
SRR7939018.66836994 IV  1249665 IV  1269898 -   +   UU  1   R1-2    1249665 1269898 1249616 1269947 60  60
SRR7939018.66836995 XIV 620123  !   0   -   -   UN  1   R1-2    620123  0   620074  0   60  0
SRR7939018.66836996 XII 462569  XII 466291  -   +   UU  1   R1-2    462569  466291  462520  466336  0   0
SRR7939018.66836997 XIV 551720  XIV 548489  -   -   UU  1   R1-2    551720  548489  551671  548440  60  60
SRR7939018.66836998 XII 460678  XV  719682  -   +   UU  1   R1-2    460678  719682  460629  719731  0   60
SRR7939018.66836999 IV  757519  IV  759383  +   +   UU  1   R1-2    757519  759383  757568  759432  0   0
SRR7939018.66837000 XII 106700  XII 106928  +   -   UU  1   R1-2    106700  106928  106749  106879  60  60
SRR7939018.66837001 VIII    546169  XIII    185740  +   +   UU  1   R1-2    546169  185740  546218  185789  0   0
SRR7939018.66837002 XV  534163  X   560148  -   -   UU  1   R1-2    534163  560148  534129  560099  60  60
SRR7939018.66837003 VI  180898  !   0   -   -   UN  1   R1-2    180898  0   180849  0   60  0
SRR7939018.66837004 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837005 VII 33694   !   0   -   -   UN  1   R1-2    33694   0   33645   0   60  0
SRR7939018.66837006 V   436120  !   0   +   -   UN  1   R1-2    436120  0   436169  0   0   0
SRR7939018.66837007 IV  787343  !   0   -   -   UN  1   R1-2    787343  0   787294  0   60  0
SRR7939018.66837008 XV  918029  !   0   +   -   UN  1   R1-2    918029  0   918078  0   60  0
SRR7939018.66837009 VI  131646  !   0   -   -   UN  1   R1-2    131646  0   131597  0   60  0
SRR7939018.66837010 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837011 VII 798455  !   0   -   -   UN  1   R1-2    798455  0   798406  0   60  0
SRR7939018.66837012 XVI 372160  !   0   +   -   UN  1   R1-2    372160  0   372209  0   60  0
SRR7939018.66837013 XII 452538  !   0   -   -   UN  1   R1-2    452538  0   452493  0   0   0
SRR7939018.66837014 XIII    62745   !   0   -   -   UN  1   R1-2    62745   0   62696   0   60  0
SRR7939018.66837015 XIV 670465  !   0   -   -   UN  1   R1-2    670465  0   670416  0   60  0
SRR7939018.66837016 III 220877  !   0   +   -   UN  1   R1-2    220877  0   220926  0   60  0
SRR7939018.66837017 XII 463762  !   0   -   -   UN  1   R1-2    463762  0   463725  0   0   0
SRR7939018.66837018 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837019 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837020 XII 1056596 !   0   +   -   UN  1   R1-2    1056596 0   1056645 0   60  0
SRR7939018.66837021 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837022 XII 462037  !   0   -   -   UN  1   R1-2    462037  0   461988  0   0   0
SRR7939018.66837023 XII 462739  !   0   +   -   UN  1   R1-2    462739  0   462788  0   0   0
SRR7939018.66837024 VII 445502  !   0   -   -   UN  1   R1-2    445502  0   445453  0   44  0
SRR7939018.66837025 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837026 V   344269  !   0   -   -   UN  1   R1-2    344269  0   344220  0   41  0
SRR7939018.66837027 VI  1288    IV  515317  +   +   UU  1   R1-2    1288    515317  1337    515366  0   0
SRR7939018.66837028 XVI 860558  XIV 715069  -   -   UU  1   R1-2    860558  715069  860509  715020  60  60
SRR7939018.66837029 XII 454673  XII 466159  -   -   UU  1   R1-2    454673  466159  454624  466130  0   0
SRR7939018.66837030 XVI 614393  XIV 342834  -   +   UU  1   R1-2    614393  342834  614344  342880  60  60
SRR7939018.66837031 X   532857  X   532857  +   +   UU  1   R1-2    532857  532857  532906  532906  60  60
SRR7939018.66837032 IX  432775  XI  551230  -   +   UU  1   R1-2    432775  551230  432726  551279  0   60
SRR7939018.66837033 XII 485729  XII 457093  +   -   UU  1   R1-2    485729  457093  485778  457044  0   0
SRR7939018.66837034 VIII    480083  VIII    479866  -   -   UU  1   R1-2    480083  479866  480034  479829  60  60
SRR7939018.66837035 XI  206780  V   498989  +   -   UU  1   R1-2    206780  498989  206829  498949  60  60
SRR7939018.66837036 XII 459832  XII 489361  +   +   UU  1   R1-2    459832  489361  459881  489410  60  0
SRR7939018.66837037 XII 457994  XII 467614  +   -   UU  1   R1-2    457994  467614  458043  467565  0   0
SRR7939018.66837038 XII 466598  XII 465689  -   +   UU  1   R1-2    466598  465689  466549  465738  0   0
SRR7939018.66837039 XV  722564  VIII    365579  -   -   UU  1   R1-2    722564  365579  722515  365530  60  60
SRR7939018.66837040 VI  231378  VI  232979  +   -   UU  1   R1-2    231378  232979  231427  232930  60  60
SRR7939018.66837041 XII 699439  VII 20989   -   +   UU  1   R1-2    699439  20989   699390  21038   60  60
SRR7939018.66837042 XII 468458  !   0   +   -   UN  1   R1-2    468458  0   468507  0   0   0
SRR7939018.66837043 IX  72498   !   0   -   -   UN  1   R1-2    72498   0   72449   0   60  0
SRR7939018.66837044 XII 461133  !   0   -   -   UN  1   R1-2    461133  0   461084  0   0   0
SRR7939018.66837045 XII 455052  !   0   -   -   UN  1   R1-2    455052  0   455003  0   0   0
SRR7939018.66837046 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837047 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837048 IV  1138433 !   0   -   -   UN  1   R1-2    1138433 0   1138384 0   60  0
SRR7939018.66837049 XI  76783   !   0   +   -   UN  1   R1-2    76783   0   76817   0   60  0
SRR7939018.66837050 XII 465976  !   0   -   -   UN  1   R1-2    465976  0   465927  0   0   0
SRR7939018.66837051 XIII    805272  !   0   -   -   UN  1   R1-2    805272  0   805223  0   60  0
SRR7939018.66837052 XV  347294  !   0   -   -   UN  1   R1-2    347294  0   347245  0   60  0
SRR7939018.66837053 VI  3409    !   0   -   -   UN  1   R1-2    3409    0   3360    0   0   0
SRR7939018.66837054 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837055 XIV 672789  !   0   -   -   UN  1   R1-2    672789  0   672740  0   60  0
SRR7939018.66837056 XII 465584  !   0   +   -   UN  1   R1-2    465584  0   465633  0   0   0
SRR7939018.66837057 X   505727  !   0   +   -   UN  1   R1-2    505727  0   505776  0   51  0
SRR7939018.66837058 XV  776053  !   0   -   -   UN  1   R1-2    776053  0   776004  0   60  0
SRR7939018.66837059 V   337272  !   0   +   -   UN  1   R1-2    337272  0   337321  0   48  0
SRR7939018.66837060 VI  245305  !   0   +   -   UN  1   R1-2    245305  0   245354  0   48  0
SRR7939018.66837061 XI  431995  !   0   -   -   UN  1   R1-2    431995  0   431946  0   41  0
SRR7939018.66837062 !   0   XII 467225  -   -   NU  1   R1-2    0   467225  0   467176  0   0
SRR7939018.66837063 XI  570081  XI  570724  -   +   UU  1   R1-2    570081  570724  570032  570773  60  60
SRR7939018.66837064 !   0   XIV 364616  -   +   NU  1   R1-2    0   364616  0   364665  0   60
SRR7939018.66837065 XIII    294265  XIII    119732  -   -   UU  1   R1-2    294265  119732  294216  119683  60  60
SRR7939018.66837066 X   61461   X   61292   -   -   UU  1   R1-2    61461   61292   61412   61243   60  60
SRR7939018.66837067 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837068 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837069 XVI 806796  !   0   +   -   UN  1   R1-2    806796  0   806845  0   0   0
SRR7939018.66837070 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.66837071 VII 391704  !   0   -   -   UN  1   R1-2    391704  0   391667  0   60  0
SRR7939018.66837072 IX  143298  !   0   +   -   UN  1   R1-2    143298  0   143347  0   55  0
```
</details>
<br />

<a id="examine-the-stats-outfile"></a>
##### Examine the stats outfile
<details>
<summary><i>Printed: Examine the stats outfile</i></summary>

<a id="testing-the-standard-call-to-pairtools-parse2-2"></a>
###### Testing the standard call to `pairtools parse2`
```txt
❯ #  Examine the stats outfile --------------------------------------------------


❯ ., "${a_stats}"
-rw-rw---- 1 kalavatt 13K Jul  6 09:47 0X_stats/SRR7939018.stats.txt


❯ cat "${a_stats}" | wc -l
478


❯ cat "${a_stats}"
total   66837072
total_unmapped  16715069
total_single_sided_mapped   12175353
total_mapped    37946650
total_dups  0
total_nodups    37946650
cis 21805569
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
cis_1kb+    13696397
cis_2kb+    11084751
cis_4kb+    8867917
cis_10kb+   6430276
cis_20kb+   4893887
cis_40kb+   3583599
summary/frac_cis    0.574637523997507
summary/frac_cis_1kb+   0.36093823828980953
summary/frac_cis_2kb+   0.292114086487213
summary/frac_cis_4kb+   0.23369433138366627
summary/frac_cis_10kb+  0.16945569635264246
summary/frac_cis_20kb+  0.12896756367162845
summary/frac_cis_40kb+  0.09443782257458827
summary/frac_dups   0.0
summary/complexity_naive    inf
chrom_freq/II/II    1465313
chrom_freq/XIII/XIII    1664936
chrom_freq/XII/IX   49624
chrom_freq/VII/VII  1926887
chrom_freq/V/V  971439
chrom_freq/XIV/III  35446
chrom_freq/II/XIII  95218
chrom_freq/XII/XIII 109260
chrom_freq/IV/IV    2792457
chrom_freq/XV/XV    1953665
chrom_freq/XII/XII  2222339
chrom_freq/VII/V    75601
chrom_freq/V/IV 94311
chrom_freq/VIII/XI  50059
chrom_freq/III/III  553079
chrom_freq/XVI/XIV  88260
chrom_freq/XVI/XVI  1648978
chrom_freq/XVI/IV   159162
chrom_freq/II/XI    71532
chrom_freq/XIV/XIV  1429089
chrom_freq/IV/XI    109496
chrom_freq/X/XI 66947
chrom_freq/IV/XIV   131765
chrom_freq/XV/II    113349
chrom_freq/XIII/VI  29220
chrom_freq/XV/V 76513
chrom_freq/IV/XV    196812
chrom_freq/VII/III  34954
chrom_freq/VI/IV    35190
chrom_freq/XI/XI    1182238
chrom_freq/VIII/VIII    959185
chrom_freq/II/Mito  4316
chrom_freq/IX/IX    774155
chrom_freq/XI/VII   88922
chrom_freq/XIV/XIII 87417
chrom_freq/X/X  1332782
chrom_freq/X/VIII   55679
chrom_freq/IV/V 93716
chrom_freq/XVI/XV   125602
chrom_freq/IV/VII   189626
chrom_freq/II/VI    29454
chrom_freq/VII/XV   145964
chrom_freq/III/X    32997
chrom_freq/V/VII    76216
chrom_freq/VIII/XII 67252
chrom_freq/II/I 21417
chrom_freq/XV/XIV   100492
chrom_freq/X/IV 118057
chrom_freq/VII/XIII 121086
chrom_freq/XVI/V    69410
chrom_freq/XII/XV   131879
chrom_freq/III/XIII 35231
chrom_freq/XI/XII   74098
chrom_freq/VI/VI    476873
chrom_freq/I/VII    22476
chrom_freq/II/VII   112808
chrom_freq/V/X  55883
chrom_freq/IX/I 23326
chrom_freq/XI/IX    42366
chrom_freq/I/I  392321
chrom_freq/V/XI 52244
chrom_freq/XIII/XV  123556
chrom_freq/XV/XII   133116
chrom_freq/XIII/X   81456
chrom_freq/II/XIV   80427
chrom_freq/XI/X 66961
chrom_freq/XIII/VIII    64674
chrom_freq/III/VII  35131
chrom_freq/XIV/IV   131102
chrom_freq/VII/I    22586
chrom_freq/XI/IV    109273
chrom_freq/Mito/Mito    59833
chrom_freq/I/XV 21358
chrom_freq/II/XV    113441
chrom_freq/IX/XIV   46561
chrom_freq/XIII/II  95169
chrom_freq/VII/X    95400
chrom_freq/XII/XI   73981
chrom_freq/XII/VIII 65531
chrom_freq/XV/IV    198098
chrom_freq/X/V  56153
chrom_freq/XI/III   30034
chrom_freq/XIV/VI   28126
chrom_freq/XVI/XIII 105458
chrom_freq/VIII/XVI 64386
chrom_freq/XI/XV    86634
chrom_freq/XV/IX    56832
chrom_freq/VII/IV   189354
chrom_freq/XIII/I   20851
chrom_freq/XIII/VII 120575
chrom_freq/V/XII    68441
chrom_freq/IV/VI    34487
chrom_freq/XI/V 51953
chrom_freq/X/VII    95235
chrom_freq/IV/X 117621
chrom_freq/VII/XII  129336
chrom_freq/XIII/IV  158196
chrom_freq/VI/VIII  25400
chrom_freq/XVI/VIII 64628
chrom_freq/X/XV 90816
chrom_freq/VIII/IX  37342
chrom_freq/XIII/XIV 86943
chrom_freq/V/XV 77356
chrom_freq/I/VIII   21631
chrom_freq/XVI/VII  123818
chrom_freq/XII/VII  129706
chrom_freq/XVI/XI   77962
chrom_freq/II/X 78451
chrom_freq/IV/XVI   158690
chrom_freq/XIII/XII 108932
chrom_freq/VII/IX   57350
chrom_freq/VII/II   112148
chrom_freq/IV/IX    69480
chrom_freq/V/VIII   44465
chrom_freq/XIV/XV   100728
chrom_freq/V/III    30431
chrom_freq/X/I  23979
chrom_freq/III/V    30262
chrom_freq/XIV/II   81437
chrom_freq/IV/II    143736
chrom_freq/XV/VIII  73415
chrom_freq/IV/XII   174675
chrom_freq/XII/XVI  109312
chrom_freq/VIII/V   44900
chrom_freq/X/XII    80691
chrom_freq/X/IX 47382
chrom_freq/XI/Mito  3564
chrom_freq/IX/II    49604
chrom_freq/XV/XIII  123134
chrom_freq/XV/VII   146251
chrom_freq/VIII/XIII    64069
chrom_freq/VIII/VII 74460
chrom_freq/XV/XVI   124960
chrom_freq/V/XVI    69695
chrom_freq/VIII/II  62368
chrom_freq/XV/XI    87107
chrom_freq/VIII/XV  72816
chrom_freq/XV/I 21026
chrom_freq/VIII/XIV 56602
chrom_freq/XIII/IX  50686
chrom_freq/XVI/II   98177
chrom_freq/II/IV    143442
chrom_freq/IX/V 38066
chrom_freq/VIII/VI  25651
chrom_freq/VI/IX    26532
chrom_freq/XII/IV   173816
chrom_freq/V/XIII   66696
chrom_freq/II/IX    49202
chrom_freq/XIII/XI  76390
chrom_freq/II/III   33941
chrom_freq/I/III    21249
chrom_freq/XII/II   98557
chrom_freq/V/I  18278
chrom_freq/XVI/X    83888
chrom_freq/XIII/XVI 106160
chrom_freq/I/XIII   20588
chrom_freq/VII/XIV  100959
chrom_freq/IX/VI    26582
chrom_freq/X/XIV    71847
chrom_freq/II/XVI   98131
chrom_freq/VI/X 31224
chrom_freq/III/XVI  35118
chrom_freq/IV/VIII  94548
chrom_freq/XI/XVI   77782
chrom_freq/III/XII  32911
chrom_freq/VII/XI   88660
chrom_freq/X/VI 31002
chrom_freq/VII/XVI  124431
chrom_freq/III/IX   27788
chrom_freq/XII/V    67869
chrom_freq/XIV/VIII 57121
chrom_freq/XIV/VII  101263
chrom_freq/XII/XIV  90368
chrom_freq/II/VIII  62247
chrom_freq/XI/XIV   67003
chrom_freq/XIV/X    72729
chrom_freq/VII/VIII 74212
chrom_freq/VIII/IV  94409
chrom_freq/X/XIII   81432
chrom_freq/IX/VII   58437
chrom_freq/III/XI   30616
chrom_freq/XIV/V    57490
chrom_freq/XV/X 90912
chrom_freq/III/VIII 30053
chrom_freq/III/XIV  35551
chrom_freq/XI/II    71608
chrom_freq/IX/XVI   51320
chrom_freq/VI/II    29502
chrom_freq/IV/I 23395
chrom_freq/V/II 63119
chrom_freq/VIII/I   21145
chrom_freq/VII/VI   32097
chrom_freq/IX/III   28277
chrom_freq/XI/VIII  50068
chrom_freq/V/IX 38121
chrom_freq/II/V 62746
chrom_freq/XIV/XI   67420
chrom_freq/I/XIV    21734
chrom_freq/XIII/V   66069
chrom_freq/XVI/III  35195
chrom_freq/XVI/IX   51931
chrom_freq/X/XVI    83079
chrom_freq/V/XIV    56969
chrom_freq/VI/XII   29236
chrom_freq/IX/IV    69460
chrom_freq/IX/XI    42068
chrom_freq/XIV/XII  90908
chrom_freq/III/VI   25421
chrom_freq/XVI/XII  110512
chrom_freq/XI/VI    28582
chrom_freq/XII/X    79339
chrom_freq/I/II 21678
chrom_freq/VI/XV    31012
chrom_freq/IV/XIII  157821
chrom_freq/IX/X 47445
chrom_freq/XIII/III 35332
chrom_freq/X/II 78771
chrom_freq/Mito/VII 4641
chrom_freq/IX/XII   50706
chrom_freq/VI/I 21371
chrom_freq/III/XV   34268
chrom_freq/IX/Mito  2360
chrom_freq/I/VI 21537
chrom_freq/VI/VII   32215
chrom_freq/XII/I    22097
chrom_freq/IX/XV    57317
chrom_freq/VI/V 24849
chrom_freq/XV/III   34514
chrom_freq/XII/VI   28460
chrom_freq/VI/XIV   28802
chrom_freq/XV/VI    31115
chrom_freq/III/II   33581
chrom_freq/II/XII   98113
chrom_freq/IX/XIII  50698
chrom_freq/VI/III   25080
chrom_freq/XIV/I    21835
chrom_freq/I/IV 23672
chrom_freq/IX/VIII  37577
chrom_freq/IV/III   39415
chrom_freq/VIII/X   55936
chrom_freq/X/III    33104
chrom_freq/I/X  23940
chrom_freq/V/VI 24717
chrom_freq/III/IV   39289
chrom_freq/I/XII    22277
chrom_freq/XVI/VI   28674
chrom_freq/XIV/XVI  87797
chrom_freq/XIV/IX   46127
chrom_freq/VI/XI    28741
chrom_freq/VI/XIII  29116
chrom_freq/XI/XIII  76312
chrom_freq/XI/I 21108
chrom_freq/Mito/X   3261
chrom_freq/VII/Mito 5624
chrom_freq/VI/XVI   28615
chrom_freq/X/Mito   4013
chrom_freq/XIV/Mito 4074
chrom_freq/Mito/VIII    2567
chrom_freq/I/IX 23221
chrom_freq/III/I    20939
chrom_freq/I/V  18448
chrom_freq/VI/Mito  1508
chrom_freq/VIII/III 30229
chrom_freq/IV/Mito  7912
chrom_freq/Mito/IV  6422
chrom_freq/XVI/I    20656
chrom_freq/Mito/XII 6351
chrom_freq/I/XI 20830
chrom_freq/III/Mito 1644
chrom_freq/I/XVI    20520
chrom_freq/Mito/XI  2942
chrom_freq/Mito/XIII    4068
chrom_freq/Mito/XV  4564
chrom_freq/XII/III  32702
chrom_freq/XVI/Mito 4962
chrom_freq/V/Mito   3082
chrom_freq/XV/Mito  5701
chrom_freq/Mito/II  3521
chrom_freq/XIII/Mito    4860
chrom_freq/Mito/I   1003
chrom_freq/Mito/XIV 3339
chrom_freq/Mito/IX  1924
chrom_freq/VIII/Mito    3016
chrom_freq/XII/Mito 7670
chrom_freq/Mito/XVI 3989
chrom_freq/Mito/III 1421
chrom_freq/Mito/VI  1237
chrom_freq/Mito/V   2434
chrom_freq/I/Mito   1189
dist_freq/0-1/+-    370
dist_freq/0-1/-+    381
dist_freq/0-1/--    130066
dist_freq/0-1/++    130074
dist_freq/1-2/+-    942
dist_freq/1-2/-+    882
dist_freq/1-2/--    353
dist_freq/1-2/++    373
dist_freq/2-3/+-    767
dist_freq/2-3/-+    717
dist_freq/2-3/--    59
dist_freq/2-3/++    85
dist_freq/3-6/+-    3057
dist_freq/3-6/-+    2984
dist_freq/3-6/--    177
dist_freq/3-6/++    232
dist_freq/6-10/+-   4287
dist_freq/6-10/-+   4411
dist_freq/6-10/--   97
dist_freq/6-10/++   154
dist_freq/10-18/+-  7906
dist_freq/10-18/-+  8229
dist_freq/10-18/--  263
dist_freq/10-18/++  332
dist_freq/18-32/+-  15653
dist_freq/18-32/-+  15581
dist_freq/18-32/--  461
dist_freq/18-32/++  658
dist_freq/32-56/+-  34043
dist_freq/32-56/-+  33666
dist_freq/32-56/--  6743
dist_freq/32-56/++  6964
dist_freq/56-100/+- 100061
dist_freq/56-100/-+ 99290
dist_freq/56-100/-- 42826
dist_freq/56-100/++ 43818
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
dist_freq/10000-17783/+-    323321
dist_freq/10000-17783/-+    322248
dist_freq/10000-17783/--    323182
dist_freq/10000-17783/++    323371
dist_freq/17783-31623/+-    283955
dist_freq/17783-31623/-+    282811
dist_freq/17783-31623/--    283803
dist_freq/17783-31623/++    282692
dist_freq/31623-56234/+-    248193
dist_freq/31623-56234/-+    247435
dist_freq/31623-56234/--    247400
dist_freq/31623-56234/++    247332
dist_freq/56234-100000/+-   215392
dist_freq/56234-100000/-+   215323
dist_freq/56234-100000/--   215836
dist_freq/56234-100000/++   214441
dist_freq/100000-177828/+-  186292
dist_freq/100000-177828/-+  187082
dist_freq/100000-177828/--  186890
dist_freq/100000-177828/++  186702
dist_freq/177828-316228/+-  156160
dist_freq/177828-316228/-+  156239
dist_freq/177828-316228/--  156601
dist_freq/177828-316228/++  156465
dist_freq/316228-562341/+-  117611
dist_freq/316228-562341/-+  118332
dist_freq/316228-562341/--  117318
dist_freq/316228-562341/++  116868
dist_freq/562341-1000000/+- 66659
dist_freq/562341-1000000/-+ 66844
dist_freq/562341-1000000/-- 66949
dist_freq/562341-1000000/++ 66604
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
dist_freq/100000000-177827941/+-    0
dist_freq/100000000-177827941/-+    0
dist_freq/100000000-177827941/--    0
dist_freq/100000000-177827941/++    0
dist_freq/177827941-316227766/+-    0
dist_freq/177827941-316227766/-+    0
dist_freq/177827941-316227766/--    0
dist_freq/177827941-316227766/++    0
dist_freq/316227766-562341325/+-    0
dist_freq/316227766-562341325/-+    0
dist_freq/316227766-562341325/--    0
dist_freq/316227766-562341325/++    0
dist_freq/562341325-1000000000/+-   0
dist_freq/562341325-1000000000/-+   0
dist_freq/562341325-1000000000/--   0
dist_freq/562341325-1000000000/++   0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```

<a id="testing-the-keep-mm-call-to-pairtools-parse2-2"></a>
###### Testing the "`keep-MM`" call to `pairtools parse2`
```txt
❯ run_check=TRUE


❯ [[ "${run_check}" == TRUE && -f "${a_stats}" ]] &&
>     {
>         ., "${a_stats}"
> 
>         cat "${a_stats}" | wc -l
> 
>         cat "${a_stats}"
>     } ||
>     {
>         echo "Warning: \"run_check\" for stats outfile did not run;"
>         echo "         \"\${a_pairs}\" not found"
>         echo "Stopping the operation because you need to check on this..."
>     }
-rw-rw---- 1 kalavatt 12K Jul 11 08:50 06_stats/SRR7939018.rDNA.stats.txt


468


total   66838634
total_unmapped  1415484
total_single_sided_mapped   5569632
total_mapped    59853518
total_dups  0
total_nodups    59853518
cis 37410003
trans   22443515
pair_types/NN   1415484
pair_types/NU   2623331
pair_types/UU   59853518
pair_types/UN   2946301
cis_1kb+    26576217
cis_2kb+    22511996
cis_4kb+    18173328
cis_10kb+   10117880
cis_20kb+   6521751
cis_40kb+   4368275
summary/frac_cis    0.6250259675630094
summary/frac_cis_1kb+   0.4440209679905532
summary/frac_cis_2kb+   0.3761181757102398
summary/frac_cis_4kb+   0.3036300723376026
summary/frac_cis_10kb+  0.16904403179776334
summary/frac_cis_20kb+  0.10896186586726615
summary/frac_cis_40kb+  0.07298276101331254
summary/frac_dups   0.0
summary/complexity_naive    inf
chrom_freq/II/II    1500911
chrom_freq/I/I  444835
chrom_freq/XIII/XIII    1706399
chrom_freq/XII/XII  16959985
chrom_freq/XII/IX   107248
chrom_freq/VII/VII  1983053
chrom_freq/V/V  1000243
chrom_freq/XIV/III  46967
chrom_freq/XII/II   186226
chrom_freq/II/XIII  113301
chrom_freq/XII/XIII 215154
chrom_freq/V/VII    96206
chrom_freq/IV/IV    2984180
chrom_freq/XV/XV    2012343
chrom_freq/XVI/X    109407
chrom_freq/VII/V    99291
chrom_freq/X/VIII   78339
chrom_freq/V/IV 128492
chrom_freq/VIII/XI  60424
chrom_freq/III/III  586997
chrom_freq/XVI/XIV  110803
chrom_freq/XVI/XII  228307
chrom_freq/XVI/XVI  1713772
chrom_freq/VIII/IV  123708
chrom_freq/XVI/IV   198102
chrom_freq/II/XI    77885
chrom_freq/XIV/XIV  1480913
chrom_freq/IV/XI    125041
chrom_freq/X/XI 78846
chrom_freq/XV/IX    72947
chrom_freq/IV/XIV   167526
chrom_freq/XV/II    131517
chrom_freq/XIII/VIII    83914
chrom_freq/XIII/VI  36279
chrom_freq/XV/V 93325
chrom_freq/IV/XV    245324
chrom_freq/XII/VI   68488
chrom_freq/VII/III  46883
chrom_freq/VI/IV    51487
chrom_freq/XI/XI    1200213
chrom_freq/VIII/VIII    1059525
chrom_freq/II/Mito  4731
chrom_freq/IX/IX    820664
chrom_freq/XI/VII   98866
chrom_freq/XIV/XIII 106758
chrom_freq/X/XII    172954
chrom_freq/IX/XII   109987
chrom_freq/X/X  1396997
chrom_freq/VI/XII   69689
chrom_freq/IV/V 122001
chrom_freq/XVI/XV   163477
chrom_freq/IV/VII   237875
chrom_freq/II/VI    37092
chrom_freq/V/II 81117
chrom_freq/V/XII    145041
chrom_freq/VII/XV   173500
chrom_freq/III/X    44344
chrom_freq/X/VII    120403
chrom_freq/VIII/XII 147625
chrom_freq/II/I 29800
chrom_freq/XV/XIV   123067
chrom_freq/X/IV 163812
chrom_freq/VII/XIII 144727
chrom_freq/XVI/V    89279
chrom_freq/XII/XIV  183793
chrom_freq/XII/VII  256240
chrom_freq/XV/IV    246114
chrom_freq/XII/XV   257106
chrom_freq/III/XIII 44702
chrom_freq/XI/XII   139064
chrom_freq/XIV/X    93673
chrom_freq/III/XII  78527
chrom_freq/VI/VI    494142
chrom_freq/I/VII    34502
chrom_freq/II/VII   138309
chrom_freq/V/X  75062
chrom_freq/IX/I 30568
chrom_freq/XI/IX    49175
chrom_freq/XI/XVI   87646
chrom_freq/V/XI 58900
chrom_freq/XII/XVI  222476
chrom_freq/XIII/XV  148159
chrom_freq/XV/XII   264564
chrom_freq/XIII/X   102640
chrom_freq/II/XIV   96687
chrom_freq/XI/X 79205
chrom_freq/III/VII  47145
chrom_freq/XIV/IV   166852
chrom_freq/VII/I    34103
chrom_freq/XI/IV    125071
chrom_freq/Mito/Mito    64831
chrom_freq/I/XV 30465
chrom_freq/II/XV    132304
chrom_freq/XIV/XII  187443
chrom_freq/IX/XIV   59372
chrom_freq/XIII/II  112557
chrom_freq/VII/XIV  123750
chrom_freq/VII/X    120856
chrom_freq/XII/XI   137073
chrom_freq/XII/VIII 146331
chrom_freq/X/V  76120
chrom_freq/XI/III   40708
chrom_freq/XIV/VI   43609
chrom_freq/XVI/XIII 134976
chrom_freq/VIII/XVI 87027
chrom_freq/XI/XV    95599
chrom_freq/VII/IV   239554
chrom_freq/XIII/I   29575
chrom_freq/XIII/VII 145069
chrom_freq/XV/III   46814
chrom_freq/X/XV 114884
chrom_freq/IV/VI    50068
chrom_freq/XI/V 58590
chrom_freq/IV/X 162548
chrom_freq/VII/XII  258175
chrom_freq/XIII/IV  193802
chrom_freq/VI/VIII  35945
chrom_freq/XVI/VIII 87454
chrom_freq/VIII/IX  51320
chrom_freq/XIII/XIV 106897
chrom_freq/V/XV 94192
chrom_freq/I/VIII   52092
chrom_freq/XVI/VII  155251
chrom_freq/XV/VII   174257
chrom_freq/IV/XII   355884
chrom_freq/VIII/XIV 73824
chrom_freq/III/IX   34834
chrom_freq/XIII/XII 217727
chrom_freq/XVI/XI   87716
chrom_freq/II/X 96268
chrom_freq/IV/XVI   198041
chrom_freq/XII/IV   347625
chrom_freq/VII/IX   77410
chrom_freq/VII/II   137263
chrom_freq/IV/IX    89390
chrom_freq/X/XIV    92793
chrom_freq/II/XII   190319
chrom_freq/V/VIII   60450
chrom_freq/XIV/XV   123522
chrom_freq/V/III    38740
chrom_freq/X/I  33870
chrom_freq/III/V    38571
chrom_freq/XIV/II   97075
chrom_freq/IV/II    181493
chrom_freq/III/XI   41216
chrom_freq/V/XIV    73294
chrom_freq/XII/X    168402
chrom_freq/XV/VIII  92831
chrom_freq/VIII/V   61419
chrom_freq/X/IX 72175
chrom_freq/XVI/III  46840
chrom_freq/XI/Mito  3799
chrom_freq/IX/II    59716
chrom_freq/XV/XIII  148386
chrom_freq/VIII/XIII    82830
chrom_freq/VIII/VII 98302
chrom_freq/XV/XVI   161423
chrom_freq/I/XI 25868
chrom_freq/V/XVI    89196
chrom_freq/VIII/II  79128
chrom_freq/XV/XI    95885
chrom_freq/VIII/XV  91756
chrom_freq/XV/I 29817
chrom_freq/XIII/IX  61105
chrom_freq/V/IX 49941
chrom_freq/XVI/II   120836
chrom_freq/II/IV    179133
chrom_freq/IX/V 50573
chrom_freq/VIII/VI  36637
chrom_freq/XIV/XVI  111688
chrom_freq/VI/IX    34288
chrom_freq/V/XIII   83950
chrom_freq/II/IX    59068
chrom_freq/VIII/X   78244
chrom_freq/XIII/XI  83755
chrom_freq/II/III   42406
chrom_freq/I/III    27353
chrom_freq/V/I  25848
chrom_freq/XIII/XVI 135828
chrom_freq/I/XIII   29848
chrom_freq/IX/VI    34471
chrom_freq/XII/V    143455
chrom_freq/II/XVI   121772
chrom_freq/VI/X 41942
chrom_freq/III/XVI  46774
chrom_freq/IV/VIII  124079
chrom_freq/IX/IV    89502
chrom_freq/VII/XI   98287
chrom_freq/X/VI 41811
chrom_freq/IX/VIII  51710
chrom_freq/VII/XVI  155761
chrom_freq/IX/XV    73454
chrom_freq/III/II   42042
chrom_freq/XIV/VIII 74811
chrom_freq/XIV/VII  124538
chrom_freq/II/VIII  79060
chrom_freq/XI/XIV   75402
chrom_freq/XIV/XI   75569
chrom_freq/VII/VIII 96277
chrom_freq/XIII/V   83214
chrom_freq/X/XIII   102294
chrom_freq/IX/VII   79038
chrom_freq/XIV/V    72930
chrom_freq/XV/X 115687
chrom_freq/III/VIII 41077
chrom_freq/III/XIV  46802
chrom_freq/XI/II    78103
chrom_freq/IX/XVI   64326
chrom_freq/XVI/VI   37615
chrom_freq/VI/II    37435
chrom_freq/IV/I 39997
chrom_freq/VIII/I   51326
chrom_freq/XII/I    55742
chrom_freq/I/II 29404
chrom_freq/VII/VI   43762
chrom_freq/IX/III   35289
chrom_freq/XI/VIII  60658
chrom_freq/II/V 77992
chrom_freq/I/XIV    30478
chrom_freq/XVI/IX   64990
chrom_freq/X/XVI    108233
chrom_freq/XII/III  76739
chrom_freq/IX/XI    48946
chrom_freq/III/VI   31787
chrom_freq/X/III    44125
chrom_freq/XI/VI    32433
chrom_freq/IX/X 72615
chrom_freq/VI/XV    40893
chrom_freq/IV/XIII  193348
chrom_freq/I/XVI    30753
chrom_freq/I/IV 38766
chrom_freq/I/XII    57037
chrom_freq/XIII/III 44460
chrom_freq/X/II 95904
chrom_freq/Mito/VII 5193
chrom_freq/XV/VI    41221
chrom_freq/VI/I 27093
chrom_freq/III/XV   46500
chrom_freq/IX/Mito  2769
chrom_freq/I/V  26078
chrom_freq/I/VI 27075
chrom_freq/VI/VII   43084
chrom_freq/VI/V 34419
chrom_freq/VI/XIV   44123
chrom_freq/IX/XIII  60900
chrom_freq/VI/III   31298
chrom_freq/XIV/I    30215
chrom_freq/XI/XIII  84100
chrom_freq/I/IX 30250
chrom_freq/IV/III   57860
chrom_freq/V/VI 33007
chrom_freq/I/X  34264
chrom_freq/III/IV   58198
chrom_freq/VI/XIII  36051
chrom_freq/VIII/III 40963
chrom_freq/XII/Mito 32602
chrom_freq/XIV/IX   58729
chrom_freq/VI/XI    32646
chrom_freq/XI/I 26283
chrom_freq/Mito/X   3782
chrom_freq/VII/Mito 6311
chrom_freq/VI/XVI   37615
chrom_freq/X/Mito   4636
chrom_freq/XIV/Mito 4592
chrom_freq/Mito/VIII    3091
chrom_freq/III/I    27293
chrom_freq/VI/Mito  1717
chrom_freq/IV/Mito  9001
chrom_freq/Mito/IV  7367
chrom_freq/Mito/XII 27684
chrom_freq/XVI/I    30426
chrom_freq/III/Mito 1894
chrom_freq/Mito/XI  3111
chrom_freq/Mito/XIII    4525
chrom_freq/Mito/XV  5056
chrom_freq/XVI/Mito 5603
chrom_freq/V/Mito   3499
chrom_freq/XV/Mito  6321
chrom_freq/Mito/II  3876
chrom_freq/XIII/Mito    5377
chrom_freq/Mito/I   1265
chrom_freq/Mito/XIV 3773
chrom_freq/Mito/IX  2287
chrom_freq/VIII/Mito    3572
chrom_freq/Mito/V   2778
chrom_freq/Mito/XVI 4516
chrom_freq/Mito/III 1611
chrom_freq/Mito/VI  1432
chrom_freq/I/Mito   1527
dist_freq/0-1/+-    704
dist_freq/0-1/-+    644
dist_freq/0-1/--    132518
dist_freq/0-1/++    133229
dist_freq/1-2/+-    1622
dist_freq/1-2/-+    1432
dist_freq/1-2/--    389
dist_freq/1-2/++    427
dist_freq/2-3/+-    1339
dist_freq/2-3/-+    1144
dist_freq/2-3/--    105
dist_freq/2-3/++    162
dist_freq/3-6/+-    4891
dist_freq/3-6/-+    4561
dist_freq/3-6/--    331
dist_freq/3-6/++    385
dist_freq/6-10/+-   6866
dist_freq/6-10/-+   6510
dist_freq/6-10/--   331
dist_freq/6-10/++   386
dist_freq/10-18/+-  12889
dist_freq/10-18/-+  12386
dist_freq/10-18/--  781
dist_freq/10-18/++  824
dist_freq/18-32/+-  25294
dist_freq/18-32/-+  23527
dist_freq/18-32/--  1468
dist_freq/18-32/++  1632
dist_freq/32-56/+-  52216
dist_freq/32-56/-+  49218
dist_freq/32-56/--  10117
dist_freq/32-56/++  10071
dist_freq/56-100/+- 148032
dist_freq/56-100/-+ 139691
dist_freq/56-100/-- 55080
dist_freq/56-100/++ 54082
dist_freq/100-178/+-    688346
dist_freq/100-178/-+    663576
dist_freq/100-178/--    232015
dist_freq/100-178/++    226106
dist_freq/178-316/+-    989943
dist_freq/178-316/-+    945255
dist_freq/178-316/--    377060
dist_freq/178-316/++    369978
dist_freq/316-562/+-    662883
dist_freq/316-562/-+    624238
dist_freq/316-562/--    564772
dist_freq/316-562/++    545190
dist_freq/562-1000/+-   841872
dist_freq/562-1000/-+   793038
dist_freq/562-1000/--   722990
dist_freq/562-1000/++   691240
dist_freq/1000-1778/+-  941184
dist_freq/1000-1778/-+  872849
dist_freq/1000-1778/--  794067
dist_freq/1000-1778/++  751426
dist_freq/1778-3162/+-  1001023
dist_freq/1778-3162/-+  912728
dist_freq/1778-3162/--  826619
dist_freq/1778-3162/++  781835
dist_freq/3162-5623/+-  1064151
dist_freq/3162-5623/-+  956127
dist_freq/3162-5623/--  951530
dist_freq/3162-5623/++  891895
dist_freq/5623-10000/+- 1392276
dist_freq/5623-10000/-+ 1266637
dist_freq/5623-10000/-- 1591815
dist_freq/5623-10000/++ 1462175
dist_freq/10000-17783/+-    721075
dist_freq/10000-17783/-+    681728
dist_freq/10000-17783/--    1004092
dist_freq/10000-17783/++    912356
dist_freq/17783-31623/+-    443261
dist_freq/17783-31623/-+    421981
dist_freq/17783-31623/--    429360
dist_freq/17783-31623/++    413494
dist_freq/31623-56234/+-    353226
dist_freq/31623-56234/-+    327303
dist_freq/31623-56234/--    357798
dist_freq/31623-56234/++    304430
dist_freq/56234-100000/+-   241365
dist_freq/56234-100000/-+   240268
dist_freq/56234-100000/--   242494
dist_freq/56234-100000/++   239413
dist_freq/100000-177828/+-  224069
dist_freq/100000-177828/-+  223582
dist_freq/100000-177828/--  227512
dist_freq/100000-177828/++  226114
dist_freq/177828-316228/+-  202788
dist_freq/177828-316228/-+  200623
dist_freq/177828-316228/--  206557
dist_freq/177828-316228/++  206156
dist_freq/316228-562341/+-  162250
dist_freq/316228-562341/-+  160694
dist_freq/316228-562341/--  165470
dist_freq/316228-562341/++  163206
dist_freq/562341-1000000/+- 84874
dist_freq/562341-1000000/-+ 86428
dist_freq/562341-1000000/-- 87635
dist_freq/562341-1000000/++ 87319
dist_freq/1000000-1778279/+-    15762
dist_freq/1000000-1778279/-+    15653
dist_freq/1000000-1778279/--    18694
dist_freq/1000000-1778279/++    18850
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
dist_freq/100000000-177827941/+-    0
dist_freq/100000000-177827941/-+    0
dist_freq/100000000-177827941/--    0
dist_freq/100000000-177827941/++    0
dist_freq/177827941-316227766/+-    0
dist_freq/177827941-316227766/-+    0
dist_freq/177827941-316227766/--    0
dist_freq/177827941-316227766/++    0
dist_freq/316227766-562341325/+-    0
dist_freq/316227766-562341325/-+    0
dist_freq/316227766-562341325/--    0
dist_freq/316227766-562341325/++    0
dist_freq/562341325-1000000000/+-   0
dist_freq/562341325-1000000000/-+   0
dist_freq/562341325-1000000000/--   0
dist_freq/562341325-1000000000/++   0
dist_freq/562341325+/+- 0
dist_freq/562341325+/-+ 0
dist_freq/562341325+/-- 0
dist_freq/562341325+/++ 0
```
</details>
<br />
</details>
<br />

<a id="4-run-pairtools-sort"></a>
### 4. Run `pairtools sort`
<a id="printed-12"></a>
#### Printed
<details>
<summary><i>Printed: 4. Run pairtools sort</i></summary>

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

<a id="run-pairtools-sort"></a>
##### Run `pairtools sort`
<details>
<summary><i>Printed: Run pairtools sort</i></summary>

<a id="testing-the-standard-call-to-pairtools-parse2-3"></a>
###### Testing the standard call to `pairtools parse2`
```txt
❯ [[ "${run}" == TRUE ]] &&
>     {
>         echo """
>             pairtools sort \\
>                 --nproc \"${threads}\" \\
>                 --tmpdir \"${scratch}\" \\
>                 --output \"${a_sort}\" \\
>                 \"${a_pairs}\" \\
>                     2> >(tee -a \"${d_pairs}/err_out/$(basename ${a_sort} .txt.gz).stderr.txt\" >&2)
>             """
>     }

            pairtools sort \
                --nproc "8" \
                --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
                --output "04_sort/SRR7939018.sort.txt.gz" \
                "03_parse/SRR7939018.p2.txt.gz" \
                    2> >(tee -a "03_parse/err_out/SRR7939018.sort.stderr.txt" >&2)

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

<a id="testing-the-rdna-call-to-pairtools-parse2"></a>
###### Testing the "rDNA" call to `pairtools parse2`
```txt
❯ print_test=TRUE


❯ [[ "${print_test}" == TRUE && -f "${a_pairs}" && ! -f "${a_sort}" ]] &&
>     {
>         echo """
>             pairtools sort \\
>                 --nproc \"${threads}\" \\
>                 --tmpdir \"${scratch}\" \\
>                 --output \"${a_sort}\" \\
>                 \"${a_pairs}\" \\
>                     2> >(tee -a \"${d_pairs}/err_out/${f_sort%.txt.gz}.stderr.txt\" >&2)
>         """
>     } ||
>     {
>         echo "Warning: \"Step #4: Run pairtools sort\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }

            pairtools sort \
                --nproc "8" \
                --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
                --output "04_sort/SRR7939018.rDNA.sort.txt.gz" \
                "03_parse/SRR7939018.rDNA.txt.gz" \
                    2> >(tee -a "03_parse/err_out/SRR7939018.rDNA.sort.stderr.txt" >&2)


❯ [[ "${run}" == TRUE && -f "${a_pairs}" && ! -f "${a_sort}" ]] &&
>     {
>         pairtools sort \
>             --nproc "${threads}" \
>             --tmpdir "${scratch}" \
>             --output "${a_sort}" \
>             "${a_pairs}" \
>                 2> >(tee -a "${d_pairs}/err_out/${f_sort%.txt.gz}.stderr.txt" >&2)
>     } ||
>     {
>         echo "Warning: \"Step #4: Run pairtools sort\" did not run"
>         echo "Stopping the operation because you need to check on this..."
>     }
```
</details>
<br />

<a id="examine-the-sorted-pairs-outfile"></a>
##### Examine the sorted pairs outfile
<details>
<summary><i>Printed: Examine the sorted pairs outfile</i></summary>

<a id="testing-the-standard-call-to-pairtools-parse2-4"></a>
###### Testing the standard call to `pairtools parse2`
```txt
❯ ., "${a_sort}"
-rw-rw---- 1 kalavatt 1.1G Jul  6 12:22 04_sort/SRR7939018.sort.txt.gz


❯ n_lines="$(zcat "${a_sort}" | wc -l)"


❯ echo "${n_lines}"
66838467


❯ echo $(( n_lines - 43 ))  # Subtract header, column-name lines
66838424


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
SRR7939018.21   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.22   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.30   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.48   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.49   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.53   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.57   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.66   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.69   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.97   !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.102  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.111  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.113  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.114  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.118  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.123  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.145  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.157  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.163  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.177  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.180  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.182  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.189  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.192  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.194  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.205  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.209  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.211  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.213  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.217  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.222  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.224  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.226  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.229  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.244  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.245  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.246  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.248  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.249  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.259  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.265  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.274  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.282  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.290  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.300  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.302  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.305  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.320  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.324  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.334  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.335  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.344  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.352  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.353  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.357  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.362  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0
SRR7939018.363  !   0   !   0   -   -   MM  1   R1-2    0   0   0   0   0   0


❯ zcat "${a_sort}" | tail -100
SRR7939018.12222092 XVI 943124  XVI 940121  +   -   UU  1   R1-2    943124  940121  943173  940072  12  60
SRR7939018.17730638 XVI 943124  XVI 943284  +   -   UU  1   R1-2    943124  943284  943173  943235  12  8
SRR7939018.28190237 XVI 943126  XVI 296448  +   +   UU  1   R1-2    943126  296448  943175  296497  12  60
SRR7939018.42388777 XVI 943126  XVI 930027  +   -   UU  1   R1-2    943126  930027  943175  929978  12  60
SRR7939018.11062244 XVI 943129  XVI 935399  +   -   UU  1   R1-2    943129  935399  943178  935350  12  60      A:G:32:935398:49
SRR7939018.61202518 XVI 943130  XVI 144840  +   -   UU  1   R1-2    943130  144840  943179  144791  12  60
SRR7939018.48308777 XVI 943130  XVI 799410  +   -   UU  1   R1-2    943130  799410  943179  799361  12  60
SRR7939018.34327409 XVI 943130  XVI 881804  +   -   UU  1   R1-2    943130  881804  943169  881755  13  60
SRR7939018.20157644 XVI 943130  XVI 910666  +   -   UU  1   R1-2    943130  910666  943179  910617  12  60
SRR7939018.64721363 XVI 943130  XVI 910666  +   -   UU  1   R1-2    943130  910666  943179  910617  12  60
SRR7939018.40232783 XVI 943130  XVI 923663  +   -   UU  1   R1-2    943130  923663  943179  923614  12  60
SRR7939018.8345170  XVI 943130  XVI 941359  +   -   UU  1   R1-2    943130  941359  943179  941310  12  60
SRR7939018.38299718 XVI 943130  XVI 941359  +   -   UU  1   R1-2    943130  941359  943179  941310  12  60
SRR7939018.58639867 XVI 943132  XVI 799642  +   -   UU  1   R1-2    943132  799642  943181  799593  12  60
SRR7939018.11233681 XVI 943133  XVI 367084  +   -   UU  1   R1-2    943133  367084  943174  367035  24  60
SRR7939018.28316258 XVI 943133  XVI 367084  +   -   UU  1   R1-2    943133  367084  943174  367035  24  60
SRR7939018.43779838 XVI 943133  XVI 931562  +   -   UU  1   R1-2    943133  931562  943182  931513  12  60
SRR7939018.22958595 XVI 943134  XVI 331028  +   +   UU  1   R1-2    943134  331028  943169  331077  5   60  G:T:38:943133:0
SRR7939018.64388114 XVI 943134  XVI 331028  +   +   UU  1   R1-2    943134  331028  943169  331077  5   60  G:T:38:943133:0
SRR7939018.66226745 XVI 943138  XVI 927987  +   +   UU  1   R1-2    943138  927987  943187  928036  12  60
SRR7939018.17100354 XVI 943140  XVI 393603  +   -   UU  1   R1-2    943140  393603  943189  393554  12  60      C:A:40:393571:18
SRR7939018.40115862 XVI 943140  XVI 942522  +   -   UU  1   R1-2    943140  942522  943189  942483  12  24
SRR7939018.374637   XVI 943144  XVI 28983   +   -   UU  1   R1-2    943144  28983   943193  28934   12  60
SRR7939018.34595812 XVI 943150  XVI 405335  +   -   UU  1   R1-2    943150  405335  943199  405286  12  60
SRR7939018.38203156 XVI 943150  XVI 405335  +   -   UU  1   R1-2    943150  405335  943199  405286  12  60
SRR7939018.43448376 XVI 943152  XVI 185898  +   +   UU  1   R1-2    943152  185898  943201  185945  60  60  A:T:13:943162:11,C:A:2:943183:32
SRR7939018.18440278 XVI 943156  XVI 733072  +   +   UU  1   R1-2    943156  733072  943205  733101  12  60
SRR7939018.48164343 XVI 943156  XVI 898872  +   -   UU  1   R1-2    943156  898872  943205  898823  12  60
SRR7939018.25351579 XVI 943157  XVI 721512  +   -   UU  1   R1-2    943157  721512  943206  721475  12  60
SRR7939018.39628631 XVI 943165  XVI 34242   +   +   UU  1   R1-2    943165  34242   943214  34291   1   60  T:A:40:943213:49
SRR7939018.16423456 XVI 943165  XVI 458280  +   +   UU  1   R1-2    943165  458280  943214  458310  1   60  T:A:38:943213:49
SRR7939018.13797015 XVI 943165  XVI 821885  +   -   UU  1   R1-2    943165  821885  943214  821836  1   60
SRR7939018.63594573 XVI 943169  XVI 672482  -   -   UU  1   R1-2    943169  672482  943120  672433  3   60
SRR7939018.23074715 XVI 943169  XVI 938317  -   +   UU  1   R1-2    943169  938317  943120  938366  3   60
SRR7939018.28098084 XVI 943169  XVI 940539  -   +   UU  1   R1-2    943169  940539  943120  940588  3   60      A:C:38:940538:0
SRR7939018.55298794 XVI 943169  XVI 942626  -   +   UU  1   R1-2    943169  942626  943120  942675  3   11
SRR7939018.24350670 XVI 943170  XVI 935546  -   +   UU  1   R1-2    943170  935546  943121  935595  7   60
SRR7939018.57333295 XVI 943172  XVI 641892  -   +   UU  1   R1-2    943172  641892  943123  641941  7   60
SRR7939018.40032321 XVI 943172  XVI 941818  -   -   UU  1   R1-2    943172  941818  943123  941769  7   60
SRR7939018.10215472 XVI 943173  XVI 534074  -   -   UU  1   R1-2    943173  534074  943124  534025  12  60
SRR7939018.61020666 XVI 943173  XVI 913530  -   +   UU  1   R1-2    943173  913530  943124  913579  12  60
SRR7939018.29073419 XVI 943173  XVI 942843  -   -   UU  1   R1-2    943173  942843  943124  942794  12  60
SRR7939018.35378144 XVI 943178  XVI 105800  -   +   UU  1   R1-2    943178  105800  943129  105849  12  60
SRR7939018.5151187  XVI 943178  XVI 765972  -   +   UU  1   R1-2    943178  765972  943129  766021  12  60
SRR7939018.50299456 XVI 943178  XVI 899697  -   -   UU  1   R1-2    943178  899697  943129  899648  12  60
SRR7939018.19428870 XVI 943179  XVI 190396  -   -   UU  1   R1-2    943179  190396  943130  190347  12  60
SRR7939018.34211276 XVI 943180  XVI 943249  -   +   UU  1   R1-2    943180  943249  943131  943298  12  6
SRR7939018.3637158  XVI 943185  XVI 896258  -   -   UU  1   R1-2    943185  896258  943136  896209  12  60
SRR7939018.43194678 XVI 943185  XVI 896258  -   -   UU  1   R1-2    943185  896258  943136  896209  12  60
SRR7939018.17366006 XVI 943191  XVI 943191  -   -   UU  1   R1-2    943191  943191  943142  943142  12  11      G:T:38:943187:46
SRR7939018.7106523  XVI 943193  XVI 929605  -   +   UU  1   R1-2    943193  929605  943144  929640  12  60
SRR7939018.27269317 XVI 943193  XVI 941934  -   +   UU  1   R1-2    943193  941934  943144  941983  12  60
SRR7939018.18682055 XVI 943201  XVI 925742  -   +   UU  1   R1-2    943201  925742  943152  925791  12  60
SRR7939018.44911277 XVI 943201  XVI 925742  -   +   UU  1   R1-2    943201  925742  943152  925791  12  60
SRR7939018.47303683 XVI 943207  XVI 940235  -   -   UU  1   R1-2    943207  940235  943158  940186  12  60
SRR7939018.44434948 XVI 943210  XVI 727879  -   -   UU  1   R1-2    943210  727879  943161  727830  12  60
SRR7939018.39129918 XVI 943213  XVI 85349   -   -   UU  1   R1-2    943213  85349   943164  85300   5   60
SRR7939018.1005707  XVI 943213  XVI 941254  -   +   UU  1   R1-2    943213  941254  943164  941303  5   60
SRR7939018.53338781 XVI 943213  XVI 942649  -   -   UU  1   R1-2    943213  942649  943164  942604  5   10
SRR7939018.26548532 XVI 943213  XVI 943123  -   +   UU  1   R1-2    943213  943123  943164  943170  5   19
SRR7939018.52983436 XVI 943214  XVI 938492  -   +   UU  1   R1-2    943214  938492  943165  938541  1   60
SRR7939018.24809697 XVI 943214  XVI 943244  -   +   UU  1   R1-2    943214  943244  943165  943293  1   3   T:A:40:943189:25    C:A:40:943252:9,C:T:40:943256:13
SRR7939018.43321177 XVI 943240  XVI 940713  +   -   UU  1   R1-2    943240  940713  943289  940664  6   60
SRR7939018.63738901 XVI 943245  XVI 943245  +   +   UU  1   R1-2    943245  943245  943294  943294  6   6
SRR7939018.49365027 XVI 943251  XVI 942811  +   -   UU  1   R1-2    943251  942811  943300  942762  6   1
SRR7939018.3148879  XVI 943252  XVI 622916  +   +   UU  1   R1-2    943252  622916  943301  622965  6   60
SRR7939018.39477980 XVI 943254  XVI 915272  +   -   UU  1   R1-2    943254  915272  943303  915223  6   60
SRR7939018.49811209 XVI 943254  XVI 915272  +   -   UU  1   R1-2    943254  915272  943303  915223  6   60
SRR7939018.36545703 XVI 943256  XVI 901139  +   -   UU  1   R1-2    943256  901139  943290  901090  12  60
SRR7939018.34945858 XVI 943266  XVI 638344  -   +   UU  1   R1-2    943266  638344  943217  638393  8   60
SRR7939018.48274581 XVI 943266  XVI 900173  -   -   UU  1   R1-2    943266  900173  943217  900143  8   60
SRR7939018.62805509 XVI 943269  XVI 942325  -   -   UU  1   R1-2    943269  942325  943220  942276  8   60
SRR7939018.62823641 XVI 943269  XVI 942325  -   -   UU  1   R1-2    943269  942325  943220  942276  8   60
SRR7939018.31047266 XVI 943290  XVI 918029  -   -   UU  1   R1-2    943290  918029  943241  917980  6   60
SRR7939018.62262490 XVI 943291  XVI 931384  -   +   UU  1   R1-2    943291  931384  943242  931433  5   60  T:A:13:943290:49    A:C:2:931430:47
SRR7939018.27584084 XVI 946238  XVI 297878  +   +   UU  1   R1-2    946238  297878  946287  297927  15  60
SRR7939018.29255091 XVI 946238  XVI 297878  +   +   UU  1   R1-2    946238  297878  946287  297927  15  60
SRR7939018.7242477  XVI 946241  XVI 937840  +   -   UU  1   R1-2    946241  937840  946290  937791  15  60
SRR7939018.37241679 XVI 946241  XVI 937840  +   -   UU  1   R1-2    946241  937840  946290  937791  15  60
SRR7939018.38484100 XVI 946241  XVI 937840  +   -   UU  1   R1-2    946241  937840  946290  937791  13  60  A:G:13:946264:24
SRR7939018.13124921 XVI 946242  XVI 730898  +   -   UU  1   R1-2    946242  730898  946291  730849  15  60
SRR7939018.48115804 XVI 946249  XVI 946249  +   +   UU  1   R1-2    946249  946249  946298  946291  7   15
SRR7939018.987072   XVI 946250  XVI 900167  +   +   UU  1   R1-2    946250  900167  946299  900216  6   60
SRR7939018.29612869 XVI 946250  XVI 900167  +   +   UU  1   R1-2    946250  900167  946299  900216  6   60
SRR7939018.4422013  XVI 946250  XVI 946250  +   +   UU  1   R1-2    946250  946250  946288  946286  8   16      A:C:38:946276:27
SRR7939018.37280808 XVI 946253  XVI 937718  +   -   UU  1   R1-2    946253  937718  946302  937669  2   60  A:C:13:946280:28
SRR7939018.50168664 XVI 946253  XVI 937718  +   -   UU  1   R1-2    946253  937718  946302  937669  6   60
SRR7939018.65747920 XVI 946253  XVI 937718  +   -   UU  1   R1-2    946253  937718  946302  937669  6   60
SRR7939018.39634147 XVI 946289  XVI 340211  -   -   UU  1   R1-2    946289  340211  946240  340162  15  60
SRR7939018.52212008 XVI 946289  XVI 340211  -   -   UU  1   R1-2    946289  340211  946240  340162  15  60
SRR7939018.61910153 XVI 946289  XVI 340211  -   -   UU  1   R1-2    946289  340211  946240  340162  15  60
SRR7939018.33097797 XVI 946290  XVI 47785   -   -   UU  1   R1-2    946290  47785   946241  47736   15  60
SRR7939018.20675152 XVI 946291  XVI 242176  -   -   UU  1   R1-2    946291  242176  946242  242127  15  60
SRR7939018.48906274 XVI 946291  XVI 906900  -   +   UU  1   R1-2    946291  906900  946242  906949  15  60
SRR7939018.36276575 XVI 946291  XVI 940004  -   +   UU  1   R1-2    946291  940004  946242  940053  15  60
SRR7939018.5626478  XVI 946293  XVI 908572  -   -   UU  1   R1-2    946293  908572  946244  908523  8   60
SRR7939018.65350763 XVI 946297  XVI 239919  -   -   UU  1   R1-2    946297  239919  946248  239870  7   60
SRR7939018.30035267 XVI 946297  XVI 939701  -   -   UU  1   R1-2    946297  939701  946248  939652  7   60
SRR7939018.55113867 XVI 946300  XVI 939782  -   +   UU  1   R1-2    946300  939782  946251  939827  7   60
SRR7939018.57420183 XVI 946300  XVI 939782  -   +   UU  1   R1-2    946300  939782  946251  939827  7   60
```

<a id="testing-the-rdna-call-to-pairtools-parse2-1"></a>
###### Testing the "rDNA" call to `pairtools parse2`
```txt
❯ [[ "${run_check}" == TRUE && -f "${a_sort}" ]] &&
>     {
>         ., "${a_sort}"
> 
>         n_lines="$(zcat "${a_sort}" | wc -l)"
>         echo "${n_lines}"
>         echo $(( n_lines - 43 ))  # Subtract header, column-name lines
> 
>         zcat "${a_sort}" | head -100
>         zcat "${a_sort}" | tail -100
>     } ||
>     {
>         echo "Warning: \"run_check\" for sort outfile did not run;"
>         echo "         \"\${a_sort}\" not found"
>         echo "Stopping the operation because you need to check on this..."
>     }
-rw-rw---- 1 kalavatt 1.2G Jul 11 09:29 04_sort/SRR7939018.rDNA.sort.txt.gz


66838677


66838634


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
#samheader: @PG ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
#samheader: @PG ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.rDNA.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 0 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.rDNA.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.rDNA.sort.txt.gz 03_parse/SRR7939018.rDNA.txt.gz PP:pairtools_parse2 VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.1    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.3    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.4    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.5    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.9    !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.11   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.12   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.19   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.55   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.99   !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.155  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.271  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.273  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.285  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.355  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.417  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.432  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.444  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.446  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.484  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.701  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.714  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.749  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.812  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.872  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.916  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.935  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.969  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.971  !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1000 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1011 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1077 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1121 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1148 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1209 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1244 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1276 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1284 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1285 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1286 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1287 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1294 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1330 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1472 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1525 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1621 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1753 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1758 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1800 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1936 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1941 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.1968 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2036 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2065 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2267 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0
SRR7939018.2284 !   0   !   0   -   -   NN  1   R1-2    0   0   0   0   0   0


SRR7939018.15300874 XVI 947712  XVI 930436  -   +   UU  1   R1-2    947712  930436  947663  930485  0   60
SRR7939018.22054267 XVI 947715  XVI 899130  -   -   UU  1   R1-2    947715  899130  947677  899081  0   60
SRR7939018.39558951 XVI 947716  XVI 123 +   +   UU  1   R1-2    947716  123 947754  172 0   0
SRR7939018.26744595 XVI 947720  XVI 444 -   -   UU  1   R1-2    947720  444 947671  395 0   0
SRR7939018.12049584 XVI 947720  XVI 2839    -   -   UU  1   R1-2    947720  2839    947671  2790    0   0
SRR7939018.30238931 XVI 947720  XVI 946771  -   +   UU  1   R1-2    947720  946771  947671  946820  0   0
SRR7939018.44774089 XVI 947726  XVI 255 -   +   UU  1   R1-2    947726  255 947677  288 0   0
SRR7939018.38378045 XVI 947727  XVI 459 -   -   UU  1   R1-2    947727  459 947678  410 0   0
SRR7939018.2555596  XVI 947728  XVI 64264   -   -   UU  1   R1-2    947728  64264   947679  64215   0   60
SRR7939018.53976375 XVI 947728  XVI 946677  -   +   UU  1   R1-2    947728  946677  947679  946726  0   0
SRR7939018.41021847 XVI 947731  XVI 944884  -   +   UU  1   R1-2    947731  944884  947682  944933  0   0
SRR7939018.56180419 XVI 947731  XVI 946408  -   +   UU  1   R1-2    947731  946408  947682  946457  0   0
SRR7939018.30581186 XVI 947732  XVI 935592  -   -   UU  1   R1-2    947732  935592  947683  935543  0   60
SRR7939018.44918109 XVI 947735  XVI 1094    -   +   UU  1   R1-2    947735  1094    947686  1143    0   0
SRR7939018.2112218  XVI 947735  XVI 946957  -   +   UU  1   R1-2    947735  946957  947686  947006  0   0
SRR7939018.36600723 XVI 947735  XVI 947042  -   +   UU  1   R1-2    947735  947042  947686  947091  0   0
SRR7939018.21193421 XVI 947735  XVI 947351  -   +   UU  1   R1-2    947735  947351  947686  947400  0   0
SRR7939018.34541508 XVI 947735  XVI 947547  -   +   UU  1   R1-2    947735  947547  947694  947596  0   0
SRR7939018.3094935  XVI 947736  XVI 946739  -   +   UU  1   R1-2    947736  946739  947687  946788  0   0
SRR7939018.13692072 XVI 947737  XVI 244 -   +   UU  1   R1-2    947737  244 947688  293 0   0
SRR7939018.37125391 XVI 947742  XVI 2830    -   -   UU  1   R1-2    947742  2830    947693  2781    0   0
SRR7939018.1713641  XVI 947743  XVI 947557  -   +   UU  1   R1-2    947743  947557  947714  947606  0   0
SRR7939018.20537911 XVI 947745  XVI 5968    -   +   UU  1   R1-2    947745  5968    947696  6014    0   0
SRR7939018.31431190 XVI 947745  XVI 5987    -   +   UU  1   R1-2    947745  5987    947696  6036    0   0
SRR7939018.63873295 XVI 947745  XVI 947024  -   +   UU  1   R1-2    947745  947024  947696  947073  0   0
SRR7939018.44028584 XVI 947746  XVI 2845    -   -   UU  1   R1-2    947746  2845    947697  2796    0   0
SRR7939018.30722295 XVI 947746  XVI 4794    -   +   UU  1   R1-2    947746  4794    947707  4843    0   0
SRR7939018.19292663 XVI 947749  XVI 946947  +   +   UU  1   R1-2    947749  946947  947798  946996  0   0
SRR7939018.16608710 XVI 947750  XVI 231 -   +   UU  1   R1-2    947750  231 947701  280 0   0
SRR7939018.6087183  XVI 947750  XVI 4119    +   -   UU  1   R1-2    947750  4119    947799  4070    0   0
SRR7939018.6629247  XVI 947750  XVI 944638  -   +   UU  1   R1-2    947750  944638  947701  944687  0   0
SRR7939018.35337440 XVI 947750  XVI 945756  -   +   UU  1   R1-2    947750  945756  947701  945805  0   0
SRR7939018.38667740 XVI 947750  XVI 945922  -   -   UU  1   R1-2    947750  945922  947701  945873  0   0
SRR7939018.4999269  XVI 947754  XVI 947129  -   +   UU  1   R1-2    947754  947129  947705  947178  0   0
SRR7939018.8852493  XVI 947755  XVI 1776    +   -   UU  1   R1-2    947755  1776    947797  1727    0   0
SRR7939018.18280726 XVI 947759  XVI 5653    -   -   UU  1   R1-2    947759  5653    947710  5604    0   0
SRR7939018.58843144 XVI 947761  XVI 945135  -   +   UU  1   R1-2    947761  945135  947712  945184  0   0
SRR7939018.47684897 XVI 947762  XVI 219 -   +   UU  1   R1-2    947762  219 947713  258 0   0
SRR7939018.6455432  XVI 947762  XVI 947366  -   +   UU  1   R1-2    947762  947366  947713  947415  0   0
SRR7939018.14992281 XVI 947771  XVI 211 -   +   UU  1   R1-2    947771  211 947722  254 0   0
SRR7939018.24316732 XVI 947775  XVI 946228  -   -   UU  1   R1-2    947775  946228  947726  946179  0   0
SRR7939018.52729150 XVI 947779  XVI 1623    -   +   UU  1   R1-2    947779  1623    947730  1672    0   0
SRR7939018.66430762 XVI 947782  XVI 3541    +   -   UU  1   R1-2    947782  3541    947831  3492    0   0
SRR7939018.65036734 XVI 947782  XVI 55545   -   -   UU  1   R1-2    947782  55545   947733  55496   0   60
SRR7939018.27527307 XVI 947785  XVI 943827  +   -   UU  1   R1-2    947785  943827  947834  943778  0   0
SRR7939018.17704600 XVI 947795  XVI 947616  -   -   UU  1   R1-2    947795  947616  947746  947567  0   0
SRR7939018.28376120 XVI 947796  XVI 185 -   +   UU  1   R1-2    947796  185 947747  234 0   0
SRR7939018.61305615 XVI 947796  XVI 934813  +   +   UU  1   R1-2    947796  934813  947845  934862  0   60
SRR7939018.13462119 XVI 947802  XVI 110237  -   +   UU  1   R1-2    947802  110237  947757  110286  0   60
SRR7939018.17519247 XVI 947802  XVI 315593  +   +   UU  1   R1-2    947802  315593  947851  315628  0   60
SRR7939018.19519705 XVI 947803  XVI 94869   -   +   UU  1   R1-2    947803  94869   947754  94918   0   60
SRR7939018.41804937 XVI 947804  XVI 527143  +   +   UU  1   R1-2    947804  527143  947853  527183  0   60
SRR7939018.41915556 XVI 947805  XVI 534 +   +   UU  1   R1-2    947805  534 947854  583 0   0
SRR7939018.7235130  XVI 947810  XVI 1959    +   +   UU  1   R1-2    947810  1959    947857  2008    0   0
SRR7939018.26132222 XVI 947812  XVI 945505  -   -   UU  1   R1-2    947812  945505  947763  945456  0   0
SRR7939018.27371714 XVI 947820  XVI 112 +   +   UU  1   R1-2    947820  112 947869  161 0   0
SRR7939018.32042375 XVI 947820  XVI 6154    +   -   UU  1   R1-2    947820  6154    947869  6120    0   0
SRR7939018.40651228 XVI 947824  XVI 5034    +   +   UU  1   R1-2    947824  5034    947864  5083    0   0
SRR7939018.36919264 XVI 947825  XVI 945489  +   -   UU  1   R1-2    947825  945489  947874  945440  0   0
SRR7939018.56658848 XVI 947826  XVI 945024  +   +   UU  1   R1-2    947826  945024  947865  945073  0   0
SRR7939018.54735256 XVI 947829  XVI 876808  +   +   UU  1   R1-2    947829  876808  947867  876857  0   60
SRR7939018.57118911 XVI 947829  XVI 944282  +   -   UU  1   R1-2    947829  944282  947870  944247  0   0
SRR7939018.34561979 XVI 947838  XVI 659934  -   -   UU  1   R1-2    947838  659934  947801  659896  0   60
SRR7939018.31789113 XVI 947848  XVI 947644  -   -   UU  1   R1-2    947848  947644  947818  947595  0   0
SRR7939018.58854975 XVI 947850  XVI 947659  -   -   UU  1   R1-2    947850  947659  947817  947610  0   0
SRR7939018.42049028 XVI 947857  XVI 2250    -   +   UU  1   R1-2    947857  2250    947819  2299    0   0
SRR7939018.35526272 XVI 947858  XVI 37510   -   -   UU  1   R1-2    947858  37510   947809  37468   0   60
SRR7939018.3188236  XVI 947863  XVI 541389  -   +   UU  1   R1-2    947863  541389  947814  541438  0   60
SRR7939018.39069102 XVI 947870  XVI 947537  -   +   UU  1   R1-2    947870  947537  947821  947586  0   0
SRR7939018.40935939 XVI 947872  XVI 943600  -   +   UU  1   R1-2    947872  943600  947823  943649  0   0
SRR7939018.3174564  XVI 947881  XVI 944217  -   -   UU  1   R1-2    947881  944217  947832  944168  0   0
SRR7939018.53785472 XVI 947908  XVI 480303  +   -   UU  1   R1-2    947908  480303  947957  480254  0   60
SRR7939018.32299757 XVI 947920  XVI 615802  +   +   UU  1   R1-2    947920  615802  947962  615851  0   60
SRR7939018.60532040 XVI 947925  XVI 947466  +   -   UU  1   R1-2    947925  947466  947974  947417  0   0
SRR7939018.29476799 XVI 947927  XVI 1878    +   +   UU  1   R1-2    947927  1878    947976  1927    0   0
SRR7939018.61864910 XVI 947927  XVI 5938    +   +   UU  1   R1-2    947927  5938    947976  5987    0   0
SRR7939018.26353689 XVI 947928  XVI 943151  +   -   UU  1   R1-2    947928  943151  947977  943102  0   0
SRR7939018.14135443 XVI 947938  XVI 943151  +   -   UU  1   R1-2    947938  943151  947978  943102  0   0
SRR7939018.40748053 XVI 947939  XVI 1780    +   +   UU  1   R1-2    947939  1780    947988  1829    0   0
SRR7939018.18318155 XVI 947953  XVI 1092    -   +   UU  1   R1-2    947953  1092    947904  1141    0   0
SRR7939018.58185231 XVI 947954  XVI 943226  +   -   UU  1   R1-2    947954  943226  948003  943177  0   0
SRR7939018.62682302 XVI 947960  XVI 943169  +   -   UU  1   R1-2    947960  943169  948009  943120  0   3
SRR7939018.28739614 XVI 947965  XVI 14981   -   -   UU  1   R1-2    947965  14981   947924  14947   0   0
SRR7939018.60831163 XVI 947966  XVI 830 +   -   UU  1   R1-2    947966  830 948003  781 0   0
SRR7939018.13657775 XVI 947976  XVI 2532    -   +   UU  1   R1-2    947976  2532    947929  2581    0   0
SRR7939018.28289543 XVI 947977  XVI 946093  -   +   UU  1   R1-2    947977  946093  947941  946142  0   0
SRR7939018.32032767 XVI 947979  XVI 6461    -   -   UU  1   R1-2    947979  6461    947948  6412    0   0
SRR7939018.24385848 XVI 947979  XVI 7972    -   +   UU  1   R1-2    947979  7972    947930  8021    0   0
SRR7939018.64278414 XVI 947989  XVI 11720   -   -   UU  1   R1-2    947989  11720   947940  11689   0   0
SRR7939018.40750230 XVI 947989  XVI 934215  -   +   UU  1   R1-2    947989  934215  947940  934264  0   60
SRR7939018.7460305  XVI 947997  XVI 926910  -   -   UU  1   R1-2    947997  926910  947948  926861  0   60
SRR7939018.8085969  XVI 947998  XVI 888148  +   +   UU  1   R1-2    947998  888148  948047  888197  0   60
SRR7939018.11754662 XVI 948000  XVI 5993    -   -   UU  1   R1-2    948000  5993    947951  5944    0   0
SRR7939018.28301497 XVI 948000  XVI 6784    +   -   UU  1   R1-2    948000  6784    948049  6735    0   0
SRR7939018.52825527 XVI 948001  XVI 377649  -   -   UU  1   R1-2    948001  377649  947952  377600  0   4
SRR7939018.46682345 XVI 948004  XVI 7722    -   +   UU  1   R1-2    948004  7722    947965  7771    0   0
SRR7939018.60582144 XVI 948018  XVI 927305  -   -   UU  1   R1-2    948018  927305  947989  927256  0   60
SRR7939018.53544399 XVI 948018  XVI 932249  -   +   UU  1   R1-2    948018  932249  947969  932298  0   60
SRR7939018.32398550 XVI 948022  XVI 943953  -   +   UU  1   R1-2    948022  943953  947973  944002  0   0
SRR7939018.38300170 XVI 948034  XVI 1219    -   -   UU  1   R1-2    948034  1219    947985  1170    0   0
```
</details>
<br />
</details>
<br />

<a id="5-run-pairtools-dedup-and-pairtools-split"></a>
### 5. Run `pairtools dedup` and `pairtools split`
<br />

<a id="x-run-pairtools-merge-if-applicable"></a>
### X. Run `pairtools merge` if applicable
<br />

<a id="x-run-standard-rdna-complete-processing-if-applicable"></a>
### X. Run "`standard-rDNA-complete`" processing if applicable
<a id="a-exclude-rdna-associated-cis-and-trans-interactions-from-standardnodups-file"></a>
#### A. Exclude rDNA-associated *cis* and *trans* interactions from "`standard.nodups`" file
<a id="b-exclude-all-but-rdna-associated-cis-and-trans-interactions-from-keep-mmnodups-file"></a>
#### B. Exclude all but rDNA-associated *cis* and *trans* interactions from "`keep-MM.nodups`" file
<a id="c-merge-the-standardnodups-and-keep-mmnodups-files"></a>
#### C. Merge the "`standard.nodups`" and "`keep-MM.nodups`" files
<br />

<a id="6-run-pairtools-stats"></a>
### 6. Run `pairtools stats`
<a id="individual-pairs-files"></a>
#### Individual pairs files
<br />

<a id="7-load-pairs-to-cooler"></a>
### 7. Load pairs to cooler
<a id="individual-pairs-file"></a>
#### Individual pairs file
<br />

<a id="8-generate-a-multi-resolution-cooler-by-coarsening"></a>
### 8. Generate a multi-resolution cooler by coarsening
<a id="cools-from-individual-pairs-files"></a>
#### Cools from individual pairs files
<br />

<a id="9-ingest-files-for-higlass"></a>
### 9. Ingest files for HiGlass
<a id="printed-tbd-1"></a>
#### Printed: TBD 1
<details>
<summary><i>Printed: TBD</i></summary>

```txt
❯ docker exec higlass-container \
>     python higlass-server/manage.py --help

docker exec higlass-container \
    python higlass-server/manage.py ingest_tileset --help

Type 'manage.py help <subcommand>' for help on a specific subcommand.

Available subcommands:

[auth]
    changepassword
    createsuperuser

[contenttypes]
    remove_stale_contenttypes

[django]
    check
    compilemessages
    createcachetable
    dbshell
    diffsettings
    dumpdata
    flush
    inspectdb
    loaddata
    makemessages
    makemigrations
    migrate
    sendtestemail
    shell
    showmigrations
    sqlflush
    sqlmigrate
    sqlsequencereset
    squashmigrations
    startapp
    startproject
    test
    testserver

[guardian]
    clean_orphan_obj_perms

[rest_framework]
    generateschema

[sessions]
    clearsessions

[staticfiles]
    collectstatic
    findstatic
    runserver

[tilesets]
    delete_tileset
    ingest_tileset
    list_tilesets
    modify_tileset


❯ docker exec higlass-container \
>     python higlass-server/manage.py ingest_tileset --help
usage: manage.py ingest_tileset [-h] [--filename FILENAME]
                                [--indexfile INDEXFILE] [--datatype DATATYPE]
                                [--filetype FILETYPE]
                                [--coordSystem COORDSYSTEM]
                                [--coordSystem2 COORDSYSTEM2] [--uid UID]
                                [--name NAME] [--project-name PROJECT_NAME]
                                [--no-upload] [--version] [-v {0,1,2,3}]
                                [--settings SETTINGS]
                                [--pythonpath PYTHONPATH] [--traceback]
                                [--no-color] [--force-color]

optional arguments:
  -h, --help            show this help message and exit
  --filename FILENAME
  --indexfile INDEXFILE
  --datatype DATATYPE
  --filetype FILETYPE
  --coordSystem COORDSYSTEM
  --coordSystem2 COORDSYSTEM2
  --uid UID
  --name NAME
  --project-name PROJECT_NAME
  --no-upload           Skip upload
  --version             show program's version number and exit
  -v {0,1,2,3}, --verbosity {0,1,2,3}
                        Verbosity level; 0=minimal output, 1=normal output,
                        2=verbose output, 3=very verbose output
  --settings SETTINGS   The Python path to a settings module, e.g.
                        "myproject.settings.main". If this isn't provided, the
                        DJANGO_SETTINGS_MODULE environment variable will be
                        used.
  --pythonpath PYTHONPATH
                        A directory to add to the Python path, e.g.
                        "/home/djangoprojects/myproject".
  --traceback           Raise on CommandError exceptions
  --no-color            Don't colorize the command output.
  --force-color         Force colorization of the command output.


❯ clodius --help
Usage: clodius [OPTIONS] COMMAND [ARGS]...

Options:
  -h, --help  Show this message and exit.

Commands:
  aggregate  Aggregate a data file so that it stores the data at multiple...
  convert    Aggregate a data file so that it stores the data at multiple...


❯ clodius aggregate --help
Usage: clodius aggregate [OPTIONS] COMMAND [ARGS]...

  Aggregate a data file so that it stores the data at multiple resolutions.

Options:
  -h, --help  Show this message and exit.

Commands:
  bedfile
  bedgraph
  bedpe     Aggregate bedpe files
  geojson   Aggregate a geojson file
  multivec  Aggregate a multivec file


❯ clodius aggregate bedfile --help
Usage: clodius aggregate bedfile [OPTIONS] FILEPATH

Options:
  -o, --output-file TEXT      The default output file name to use. If this
                              isn't specified, clodius will replace the
                              current extension with .multires.bed
  -a, --assembly TEXT         The genome assembly that this file was created
                              against
  --importance-column TEXT    The column (1-based) containing information
                              about how important that row is. If it's absent,
                              then use the length of the region. If the value
                              is equal to `random`, then a random value will
                              be used for the importance (effectively leading
                              to random sampling)
  --has-header / --no-header  Does this file have a header that we should
                              ignore
  --chromosome TEXT           Only extract values for a particular chromosome.
                              Use all chromosomes if not set.
  --max-per-tile INTEGER      The maximum number of entries to store per tile
  --tile-size INTEGER         The number of nucleotides that the highest
                              resolution tiles should span. This determines
                              the maximum zoom level
  --delimiter TEXT
  --chromsizes-filename TEXT  A file containing chromosome sizes and order
  --offset INTEGER            Apply an offset to all the coordinates in this
                              file
  -h, --help                  Show this message and exit.


❯ clodius aggregate bedgraph --help
Usage: clodius aggregate bedgraph [OPTIONS] FILEPATH

Options:
  -o, --output-file TEXT          The default output file name to use. If this
                                  isn't specified, clodius will replace the
                                  current extension with .hitile
  -a, --assembly [h37rv|hg38|danRer10|GCA_000001215.4_Release_6_plus_ISO1_MT_genomic|test3chroms|gorGor5|hg19|dm6|mm9|test|grch37-lite|ce11|sacCer3|GCF_000005845.2_ASM584v2_genomic|canFam3|galGal5|mm10|b37|galGal6|hs37d5|rheMac8|rn6|mm9b|grch37|panTro5|dm3|GCA_000001405.15_GRCh38_genomic]
                                  The genome assembly that this file was
                                  created against
  --chromosome TEXT               Only extract values for a particular
                                  chromosome. Use all chromosomes if not set.
  -t, --tile-size INTEGER         The number of data points in each tile. Used
                                  to determine the number of zoom levels to
                                  create.
  -c, --chunk-size INTEGER        How many values to aggregate at once.
                                  Specified as a power of two multiplier of
                                  the tile size
  --chromosome-col INTEGER        The column number (1-based) which contains
                                  the chromosome name
  --from-pos-col INTEGER          The column number (1-based) which contains
                                  the starting position
  --to-pos-col INTEGER            The column number (1-based) which contains
                                  the ending position
  --value-col INTEGER             The column number (1-based) which contains
                                  the actual value position
  --has-header / --no-header      Does this file have a header that we should
                                  ignore
  --method [sum|average]          The method used to aggregate values (e.g.
                                  sum, average...)
  --nan-value TEXT                The string to use as a NaN value
  --transform [none|exp2]         The method used to aggregate values (e.g.
                                  sum, average...)
  --count-nan                     Simply count the number of nan values in the
                                  file
  --closed-interval               Treat the to column as a closed interval
  --chromsizes-filename TEXT      A file containing chromosome sizes and order
  -z, --zoom-step INTEGER         The number of intermediate aggregation
                                  levels to omit
  -h, --help                      Show this message and exit.


❯ #  Step #1: Convert gtfs of interest into beds


❯ gtf2bed \
>     < Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf \
>     > Greenlaw-et-al_non-collapsed-non-coding-transcriptome.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf \
>     > Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf \
>     > Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf \
>     > Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < Greenlaw-et-al_representative-non-coding-transcriptome.gtf \
>     > Greenlaw-et-al_representative-non-coding-transcriptome.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < processed_features-intergenic_sense-antisense.gtf \
>     > processed_features-intergenic_sense-antisense.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ gtf2bed \
>     < processed_features-intergenic_sense.gtf \
>     > processed_features-intergenic_sense.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ cat Saccharomyces_cerevisiae.R64-1-1.108.gtf \
>     | awk '{ if ($0 ~ "transcript_id") print $0; else print $0" transcript_id \"\";"; }' \
pipe>     | gtf2bed - \
pipe pipe>         > Saccharomyces_cerevisiae.R64-1-1.108.bed
Warning: If your Wiggle data is a significant portion of available system memory, use the --max-mem and --sort-tmpdir options, or use --do-not-sort to disable post-conversion sorting. See --help for more information.


❯ #  Step #2: Aggregate bed files for use with HiGlass


❯ clodius aggregate bedfile \
>     --assembly "sacCer3" \
>     --output-file Saccharomyces_cerevisiae.R64-1-1.108.db \
>     --chromsizes-filename S288C_reference_sequence_R64-3-1_20210421.size \
>     Saccharomyces_cerevisiae.R64-1-1.108.bed
delimiter: None
output_file: Saccharomyces_cerevisiae.R64-1-1.108.db header: <map object at 0x112e59870>
max_per_tile: 100
counter: 0 9276
counter: 1000 75
counter: 2000 2247
counter: 3000 3
counter: 4000 3
counter: 5000 1284
counter: 6000 396
counter: 7000 3
counter: 8000 519
counter: 9000 3
counter: 10000 858
counter: 11000 162
counter: 12000 678
counter: 13000 1554
counter: 14000 2118
counter: 15000 3
counter: 16000 5314
counter: 17000 3
counter: 18000 1086
counter: 19000 1866
counter: 20000 675
counter: 21000 906
counter: 22000 3
counter: 23000 3
counter: 24000 2481
counter: 25000 1704
counter: 26000 879
counter: 27000 121
counter: 28000 3
counter: 29000 726
counter: 30000 2019
counter: 31000 1128
counter: 32000 3
counter: 33000 1656
counter: 34000 3
counter: 35000 2484
counter: 36000 3
counter: 37000 735
counter: 38000 3
counter: 39000 3
counter: 40000 1071
counter: 41000 1359
```
</details>
<br />

<a id="printed-tbd-2"></a>
#### Printed: TBD 2
<details>
<summary><i>Printed: Ingest files for HiGlass</i></summary>

```txt
❯ docker exec higlass-container python higlass-server/manage.py

Type 'manage.py help <subcommand>' for help on a specific subcommand.

Available subcommands:

[auth]
    changepassword
    createsuperuser

[contenttypes]
    remove_stale_contenttypes

[django]
    check
    compilemessages
    createcachetable
    dbshell
    diffsettings
    dumpdata
    flush
    inspectdb
    loaddata
    makemessages
    makemigrations
    migrate
    sendtestemail
    shell
    showmigrations
    sqlflush
    sqlmigrate
    sqlsequencereset
    squashmigrations
    startapp
    startproject
    test
    testserver

[guardian]
    clean_orphan_obj_perms

[rest_framework]
    generateschema

[sessions]
    clearsessions

[staticfiles]
    collectstatic
    findstatic
    runserver

[tilesets]
    delete_tileset
    ingest_tileset
    list_tilesets
    modify_tileset


❯ docker exec higlass-container \
>     python higlass-server/manage.py ingest_tileset \
>         --help
usage: manage.py ingest_tileset [-h] [--filename FILENAME]
                                [--indexfile INDEXFILE] [--datatype DATATYPE]
                                [--filetype FILETYPE]
                                [--coordSystem COORDSYSTEM]
                                [--coordSystem2 COORDSYSTEM2] [--uid UID]
                                [--name NAME] [--project-name PROJECT_NAME]
                                [--no-upload] [--version] [-v {0,1,2,3}]
                                [--settings SETTINGS]
                                [--pythonpath PYTHONPATH] [--traceback]
                                [--no-color] [--force-color]

optional arguments:
  -h, --help            show this help message and exit
  --filename FILENAME
  --indexfile INDEXFILE
  --datatype DATATYPE
  --filetype FILETYPE
  --coordSystem COORDSYSTEM
  --coordSystem2 COORDSYSTEM2
  --uid UID
  --name NAME
  --project-name PROJECT_NAME
  --no-upload           Skip upload
  --version             show program's version number and exit
  -v {0,1,2,3}, --verbosity {0,1,2,3}
                        Verbosity level; 0=minimal output, 1=normal output,
                        2=verbose output, 3=very verbose output
  --settings SETTINGS   The Python path to a settings module, e.g.
                        "myproject.settings.main". If this isn't provided, the
                        DJANGO_SETTINGS_MODULE environment variable will be
                        used.
  --pythonpath PYTHONPATH
                        A directory to add to the Python path, e.g.
                        "/home/djangoprojects/myproject".
  --traceback           Raise on CommandError exceptions
  --no-color            Don't colorize the command output.
  --force-color         Force colorization of the command output.


❯ [[ "${rough_Q}" == TRUE ]]
❯ docker exec higlass-container \
>     python higlass-server/manage.py ingest_tileset \
>         --filename /data/SRR7939018.mcool \
>         --filetype cooler \
>         --datatype matrix


❯ [[ "${rough_G1}" == TRUE ]]
❯ docker exec higlass-container \
>     python higlass-server/manage.py ingest_tileset \
>         --filename /data/SRR11893107.mcool \
>         --filetype cooler \
>         --datatype matrix


❯ rough_G2_M=TRUE
❯ [[ ${rough_G2_M} == TRUE ]] &&
> {
>     docker exec higlass-container \
>         python higlass-server/manage.py ingest_tileset \
>             --filename /data/SRR11893084-SRR11893085.mcool \
>             --filetype cooler \
>             --datatype matrix
>
>     # curl http://localhost:8888/api/v1/tilesets/
> }


❯ [[ "${rough_size}" == TRUE ]]
❯ docker exec higlass-container \
>     python higlass-server/manage.py ingest_tileset \
>     --filename /data/S288C_reference_sequence_R64-3-1_20210421.size \
>     --filetype chromsizes-tsv \
>     --datatype chromsizes


❯ rough_Q_rDNA=TRUE
❯ [[ "${rough_Q_rDNA}" == TRUE ]] &&
cmdand>     {
cmdand cursh>         docker exec higlass-container \
cmdand cursh>             python higlass-server/manage.py ingest_tileset \
cmdand cursh>                 --filename /data/SRR7939018.standard-rDNA.mcool \
cmdand cursh>                 --filetype cooler \
cmdand cursh>                 --datatype matrix
cmdand cursh>
cmdand cursh>         # curl http://localhost:8888/api/v1/tilesets/
cmdand cursh>     }


❯ curl http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz > refGene.txt.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 7855k  100 7855k    0     0  18.9M      0 --:--:-- --:--:-- --:--:-- 18.9M
```
</details>
<br />
