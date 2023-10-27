
`work_fithic.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Install `FitHiC` environments](#install-fithic-environments)
    1. [Create a KrisMac `FitHiC` environment](#create-a-krismac-fithic-environment)
        1. [Printed](#printed)
    1. [Create a `rhino`/`gizmo` `FitHiC` environment](#create-a-rhinogizmo-fithic-environment)
        1. [Printed](#printed-1)
1. [Establish, test, and run workflow for `FitHiC` analyses](#establish-test-and-run-workflow-for-fithic-analyses)
    1. [Initialize functions](#initialize-functions)
        1. [Code](#code)
    1. [Configure work environment, directories, and variables](#configure-work-environment-directories-and-variables)
        1. [Code](#code-1)
    1. [Establish and test workflow](#establish-and-test-workflow)
        1. [Code](#code-2)
        1. [Printed](#printed-2)
            1. [Workflow test 2023-1026: rDNA cis and rDNA trans interactions, etc.](#workflow-test-2023-1026-rdna-cis-and-rdna-trans-interactions-etc)
            1. [Workflow test 2023-1026: mito-free and rDNA interactions, etc.](#workflow-test-2023-1026-mito-free-and-rdna-interactions-etc)
    1. [Run workflow proper](#run-workflow-proper)
        1. [Code](#code-3)
        1. [Printed](#printed-3)
            1. [Run workflow test, 2023-1025: Steps #1&ndash;3](#run-workflow-test-2023-1025-steps-1ndash3)
            1. [Run workflow test, 2023-1025: Steps #4&ndash;6](#run-workflow-test-2023-1025-steps-4ndash6)
1. [Help messages](#help-messages)
    1. [Printed](#printed-4)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="install-fithic-environments"></a>
## Install `FitHiC` environments
<a id="create-a-krismac-fithic-environment"></a>
### Create a KrisMac `FitHiC` environment
<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Create a KrisMac `FitHiC` environment</i></summary>

```txt
❯ mamba create -n fithic_env -c bioconda fithic

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


Looking for: ['fithic']

bioconda/osx-64                                      4.3MB @   3.3MB/s  1.4s
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change
bioconda/noarch                                      4.7MB @   2.5MB/s  2.0s
pkgs/r/noarch                                        1.3MB @ 661.3kB/s  0.5s
pkgs/main/osx-64                                     5.8MB @   2.8MB/s  2.2s
conda-forge/noarch                                  14.2MB @   4.6MB/s  3.4s
conda-forge/osx-64                                  31.4MB @   5.0MB/s  6.9s
Transaction

  Prefix: /Users/kalavattam/miniconda3/envs/fithic_env

  Updating specs:

   - fithic


  Package               Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────

  + brotli                1.1.0  h0dc2134_1          conda-forge/osx-64       20kB
  + brotli-bin            1.1.0  h0dc2134_1          conda-forge/osx-64       17kB
  + bzip2                 1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + ca-certificates   2023.7.22  h8857fd0_0          conda-forge/osx-64     Cached
  + certifi           2023.7.22  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + contourpy             1.1.1  py312h49ebfd2_1     conda-forge/osx-64      230kB
  + cycler               0.12.1  pyhd8ed1ab_0        conda-forge/noarch       13kB
  + fithic                2.0.8  pyhdfd78af_1        bioconda/noarch          24kB
  + fonttools            4.43.1  py312h41838bb_0     conda-forge/osx-64        3MB
  + freetype             2.12.1  h60636b9_2          conda-forge/osx-64     Cached
  + joblib                1.3.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + kiwisolver            1.4.5  py312h49ebfd2_1     conda-forge/osx-64       60kB
  + lcms2                  2.15  hd6ba6f3_3          conda-forge/osx-64      225kB
  + lerc                  4.0.0  hb486fe8_0          conda-forge/osx-64     Cached
  + libblas               3.9.0  18_osx64_openblas   conda-forge/osx-64     Cached
  + libbrotlicommon       1.1.0  h0dc2134_1          conda-forge/osx-64       67kB
  + libbrotlidec          1.1.0  h0dc2134_1          conda-forge/osx-64       30kB
  + libbrotlienc          1.1.0  h0dc2134_1          conda-forge/osx-64      299kB
  + libcblas              3.9.0  18_osx64_openblas   conda-forge/osx-64     Cached
  + libcxx               16.0.6  hd57cbcb_0          conda-forge/osx-64     Cached
  + libdeflate             1.19  ha4e1b8e_0          conda-forge/osx-64       69kB
  + libexpat              2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + libffi                3.4.2  h0d85af4_5          conda-forge/osx-64     Cached
  + libgfortran           5.0.0  13_2_0_h97931a8_1   conda-forge/osx-64     Cached
  + libgfortran5         13.2.0  h2873a65_1          conda-forge/osx-64     Cached
  + libjpeg-turbo         3.0.0  h0dc2134_1          conda-forge/osx-64      580kB
  + liblapack             3.9.0  18_osx64_openblas   conda-forge/osx-64     Cached
  + libopenblas          0.3.24  openmp_h48a4ad5_0   conda-forge/osx-64     Cached
  + libpng               1.6.39  ha978bb4_0          conda-forge/osx-64     Cached
  + libsqlite            3.43.2  h92b6c6a_0          conda-forge/osx-64      885kB
  + libtiff               4.6.0  h684deea_2          conda-forge/osx-64      267kB
  + libwebp-base          1.3.2  h0dc2134_0          conda-forge/osx-64     Cached
  + libxcb                 1.15  hb7f2c08_0          conda-forge/osx-64     Cached
  + libzlib              1.2.13  h8a1eda9_5          conda-forge/osx-64     Cached
  + llvm-openmp          17.0.2  hff08bdf_0          conda-forge/osx-64      305kB
  + matplotlib-base       3.8.0  py312h1fe5000_2     conda-forge/osx-64        8MB
  + munkres               1.0.7  py_1                bioconda/noarch        Cached
  + ncurses                 6.4  hf0c8a7f_0          conda-forge/osx-64     Cached
  + numpy                1.26.0  py312h5df92dc_0     conda-forge/osx-64        7MB
  + openjpeg              2.5.0  ha4da562_3          conda-forge/osx-64     Cached
  + openssl               3.1.3  h8a1eda9_0          conda-forge/osx-64        2MB
  + packaging              23.2  pyhd8ed1ab_0        conda-forge/noarch       49kB
  + pillow               10.0.1  py312h0c3ac74_2     conda-forge/osx-64       46MB
  + pip                  23.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pthread-stubs           0.4  hc929b4f_1001       conda-forge/osx-64     Cached
  + pyparsing             3.1.1  pyhd8ed1ab_0        conda-forge/noarch       90kB
  + python               3.12.0  h30d4d87_0_cpython  conda-forge/osx-64       15MB
  + python-dateutil       2.8.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python_abi             3.12  4_cp312             conda-forge/osx-64        6kB
  + readline                8.2  h9e318b2_1          conda-forge/osx-64     Cached
  + scikit-learn          1.3.1  py312h5e37b4f_1     conda-forge/osx-64        9MB
  + scipy                1.11.3  py312h2c2f0bb_1     conda-forge/osx-64       16MB
  + setuptools           68.2.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + six                  1.16.0  pyh6c4a22f_0        conda-forge/noarch     Cached
  + sortedcontainers      2.4.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + threadpoolctl         3.2.0  pyha21a80b_0        conda-forge/noarch     Cached
  + tk                   8.6.13  hef22860_0          conda-forge/osx-64        3MB
  + tzdata                2023c  h71feb2d_0          conda-forge/noarch     Cached
  + wheel                0.41.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xorg-libxau          1.0.11  h0dc2134_0          conda-forge/osx-64     Cached
  + xorg-libxdmcp         1.1.3  h35c211d_0          conda-forge/osx-64     Cached
  + xz                    5.2.6  h775f41a_0          conda-forge/osx-64     Cached
  + zstd                  1.5.5  h829000d_0          conda-forge/osx-64     Cached

  Summary:

  Install: 63 packages

  Total download: 111MB

────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
libdeflate                                          69.0kB @ 431.5kB/s  0.2s
python_abi                                           6.5kB @  35.2kB/s  0.2s
libjpeg-turbo                                      579.7kB @   3.0MB/s  0.2s
libbrotlicommon                                     67.5kB @ 348.8kB/s  0.2s
llvm-openmp                                        304.6kB @   1.4MB/s  0.2s
libtiff                                            266.5kB @   1.1MB/s  0.1s
kiwisolver                                          60.2kB @ 234.3kB/s  0.1s
packaging                                           49.5kB @ 191.7kB/s  0.1s
brotli                                              19.5kB @  72.0kB/s  0.1s
contourpy                                          229.6kB @ 839.4kB/s  0.1s
libbrotlidec                                        30.3kB @  91.2kB/s  0.1s
tk                                                   3.3MB @   3.6MB/s  0.6s
libsqlite                                          885.2kB @ 802.9kB/s  0.2s
brotli-bin                                          16.7kB @  13.2kB/s  0.2s
cycler                                              13.5kB @  10.3kB/s  0.0s
scikit-learn                                         8.6MB @   4.6MB/s  1.6s
libbrotlienc                                       299.1kB @ 148.8kB/s  0.2s
matplotlib-base                                      7.8MB @   2.9MB/s  1.4s
openssl                                              2.3MB @ 749.4kB/s  0.4s
numpy                                                7.0MB @   2.0MB/s  1.5s
python                                              14.5MB @   4.1MB/s  3.3s
fonttools                                            2.7MB @ 736.3kB/s  0.5s
pyparsing                                           89.5kB @  24.7kB/s  0.1s
fithic                                              23.5kB @   6.4kB/s  0.1s
lcms2                                              224.9kB @  60.4kB/s  0.1s
scipy                                               15.6MB @   3.6MB/s  4.0s
pillow                                              46.1MB @   9.0MB/s  4.9s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate fithic_env

To deactivate an active environment, use

     $ mamba deactivate
```
</details>
<br />

<a id="create-a-rhinogizmo-fithic-environment"></a>
### Create a `rhino`/`gizmo` `FitHiC` environment
<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Create a `rhino`/`gizmo` `FitHiC` environment</i></summary>

```txt
❯ mamba create -n fithic_env -c bioconda fithic

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


Looking for: ['fithic']

pkgs/main/linux-64                                            No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
bioconda/linux-64                                    5.2MB @   4.1MB/s  1.4s
bioconda/noarch                                      4.7MB @   3.3MB/s  1.6s
conda-forge/noarch                                  14.2MB @   6.6MB/s  2.6s
conda-forge/linux-64                                35.0MB @   6.2MB/s  6.3s
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/fithic_env

  Updating specs:

   - fithic


  Package               Version  Build                Channel                    Size
───────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex           0.1  conda_forge          conda-forge/linux-64     Cached
  + _openmp_mutex           4.5  2_gnu                conda-forge/linux-64     Cached
  + brotli                1.1.0  hd590300_1           conda-forge/linux-64     Cached
  + brotli-bin            1.1.0  hd590300_1           conda-forge/linux-64     Cached
  + bzip2                 1.0.8  h7f98852_4           conda-forge/linux-64     Cached
  + ca-certificates   2023.7.22  hbcca054_0           conda-forge/linux-64     Cached
  + certifi           2023.7.22  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + contourpy             1.1.1  py312h8572e83_1      conda-forge/linux-64      234kB
  + cycler               0.12.1  pyhd8ed1ab_0         conda-forge/noarch         13kB
  + fithic                2.0.8  pyhdfd78af_1         bioconda/noarch            24kB
  + fonttools            4.43.1  py312h98912ed_0      conda-forge/linux-64        3MB
  + freetype             2.12.1  h267a509_2           conda-forge/linux-64     Cached
  + joblib                1.3.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + kiwisolver            1.4.5  py312h8572e83_1      conda-forge/linux-64       72kB
  + lcms2                  2.15  hb7c19ff_3           conda-forge/linux-64      240kB
  + ld_impl_linux-64       2.40  h41732ed_0           conda-forge/linux-64     Cached
  + lerc                  4.0.0  h27087fc_0           conda-forge/linux-64     Cached
  + libblas               3.9.0  18_linux64_openblas  conda-forge/linux-64     Cached
  + libbrotlicommon       1.1.0  hd590300_1           conda-forge/linux-64     Cached
  + libbrotlidec          1.1.0  hd590300_1           conda-forge/linux-64     Cached
  + libbrotlienc          1.1.0  hd590300_1           conda-forge/linux-64     Cached
  + libcblas              3.9.0  18_linux64_openblas  conda-forge/linux-64     Cached
  + libdeflate             1.19  hd590300_0           conda-forge/linux-64       67kB
  + libexpat              2.5.0  hcb278e6_1           conda-forge/linux-64     Cached
  + libffi                3.4.2  h7f98852_5           conda-forge/linux-64     Cached
  + libgcc-ng            13.2.0  h807b86a_2           conda-forge/linux-64     Cached
  + libgfortran-ng       13.2.0  h69a702a_2           conda-forge/linux-64     Cached
  + libgfortran5         13.2.0  ha4646dd_2           conda-forge/linux-64     Cached
  + libgomp              13.2.0  h807b86a_2           conda-forge/linux-64     Cached
  + libjpeg-turbo         3.0.0  hd590300_1           conda-forge/linux-64      619kB
  + liblapack             3.9.0  18_linux64_openblas  conda-forge/linux-64     Cached
  + libnsl                2.0.0  hd590300_1           conda-forge/linux-64     Cached
  + libopenblas          0.3.24  pthreads_h413a1c8_0  conda-forge/linux-64     Cached
  + libpng               1.6.39  h753d276_0           conda-forge/linux-64     Cached
  + libsqlite            3.43.2  h2797004_0           conda-forge/linux-64     Cached
  + libstdcxx-ng         13.2.0  h7e041cc_2           conda-forge/linux-64     Cached
  + libtiff               4.6.0  ha9c0a0a_2           conda-forge/linux-64      283kB
  + libuuid              2.38.1  h0b41bf4_0           conda-forge/linux-64     Cached
  + libwebp-base          1.3.2  hd590300_0           conda-forge/linux-64     Cached
  + libxcb                 1.15  h0b41bf4_0           conda-forge/linux-64     Cached
  + libzlib              1.2.13  hd590300_5           conda-forge/linux-64     Cached
  + matplotlib-base       3.8.0  py312he5832f3_2      conda-forge/linux-64        8MB
  + munkres               1.0.7  py_1                 bioconda/noarch          Cached
  + ncurses                 6.4  hcb278e6_0           conda-forge/linux-64     Cached
  + numpy                1.26.0  py312heda63a1_0      conda-forge/linux-64        7MB
  + openjpeg              2.5.0  h488ebb8_3           conda-forge/linux-64     Cached
  + openssl               3.1.3  hd590300_0           conda-forge/linux-64     Cached
  + packaging              23.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pillow               10.0.1  py312hf3581a9_2      conda-forge/linux-64       46MB
  + pip                  23.2.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pthread-stubs           0.4  h36c2ea0_1001        conda-forge/linux-64     Cached
  + pyparsing             3.1.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + python               3.12.0  hab00c5b_0_cpython   conda-forge/linux-64       32MB
  + python-dateutil       2.8.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + python_abi             3.12  4_cp312              conda-forge/linux-64        6kB
  + readline                8.2  h8228510_1           conda-forge/linux-64     Cached
  + scikit-learn          1.3.1  py312h394d371_1      conda-forge/linux-64        9MB
  + scipy                1.11.3  py312heda63a1_1      conda-forge/linux-64       16MB
  + setuptools           68.2.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + six                  1.16.0  pyh6c4a22f_0         conda-forge/noarch       Cached
  + sortedcontainers      2.4.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + threadpoolctl         3.2.0  pyha21a80b_0         conda-forge/noarch       Cached
  + tk                   8.6.13  h2797004_0           conda-forge/linux-64     Cached
  + tzdata                2023c  h71feb2d_0           conda-forge/noarch       Cached
  + wheel                0.41.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + xorg-libxau          1.0.11  hd590300_0           conda-forge/linux-64     Cached
  + xorg-libxdmcp         1.1.3  h7f98852_0           conda-forge/linux-64     Cached
  + xz                    5.2.6  h166bdaf_0           conda-forge/linux-64     Cached
  + zstd                  1.5.5  hfc55251_0           conda-forge/linux-64     Cached

  Summary:

  Install: 69 packages

  Total download: 123MB

───────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libtiff                                            283.2kB @   3.0MB/s  0.1s
libjpeg-turbo                                      618.6kB @   6.3MB/s  0.1s
libdeflate                                          67.1kB @ 595.9kB/s  0.1s
python_abi                                           6.4kB @  51.8kB/s  0.1s
lcms2                                              239.7kB @   1.6MB/s  0.2s
fonttools                                            2.7MB @   9.6MB/s  0.2s
cycler                                              13.5kB @  36.9kB/s  0.1s
matplotlib-base                                      7.8MB @  17.9MB/s  0.3s
contourpy                                          233.6kB @ 463.3kB/s  0.2s
fithic                                              23.5kB @  41.6kB/s  0.1s
kiwisolver                                          72.1kB @ 104.0kB/s  0.2s
scipy                                               16.0MB @  22.8MB/s  0.6s
numpy                                                7.5MB @   9.1MB/s  0.3s
python                                              32.1MB @  36.0MB/s  0.8s
scikit-learn                                         9.5MB @  10.5MB/s  0.2s
pillow                                              46.4MB @  45.4MB/s  0.9s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate fithic_env

To deactivate an active environment, use

     $ mamba deactivate


❯ mamba install -c anaconda networkx

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


Looking for: ['networkx']

anaconda/noarch                                    462.0kB @   2.2MB/s  0.2s
anaconda/linux-64                                    3.1MB @   3.8MB/s  0.9s
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
bioconda/linux-64                                    5.2MB @   3.7MB/s  1.5s
bioconda/noarch                                      4.7MB @   2.3MB/s  2.0s
conda-forge/noarch                                  14.2MB @   5.0MB/s  3.2s
conda-forge/linux-64                                35.0MB @   6.3MB/s  6.1s

Pinned packages:
  - python 3.12.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/fithic_env

  Updating specs:

   - networkx
   - ca-certificates
   - certifi
   - openssl


  Package               Version  Build            Channel                Size
───────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────

  + networkx              2.7.1  pyhd3eb1b0_0     anaconda/noarch         2MB

  Change:
───────────────────────────────────────────────────────────────────────────────

  - certifi           2023.7.22  pyhd8ed1ab_0     conda-forge
  + certifi           2023.7.22  py312h06a4308_1  anaconda/linux-64     160kB

  Upgrade:
───────────────────────────────────────────────────────────────────────────────

  - ca-certificates   2023.7.22  hbcca054_0       conda-forge
  + ca-certificates  2023.08.22  h06a4308_0       anaconda/linux-64     133kB

  Summary:

  Install: 1 packages
  Change: 1 packages
  Upgrade: 1 packages

  Total download: 2MB

───────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
ca-certificates                                    132.7kB @   1.2MB/s  0.1s
networkx                                             1.6MB @   6.6MB/s  0.2s
certifi                                            159.6kB @ 381.1kB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
<br />

<a id="establish-test-and-run-workflow-for-fithic-analyses"></a>
## Establish, test, and run workflow for `FitHiC` analyses
<a id="initialize-functions"></a>
### Initialize functions
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Initialize functions</i></summary>

```bash
#!/bin/bash

function change_dir() {
    local dir="${1}"
    local help=$(
cat << EOM
Usage: change_dir [directory]

Change the current working directory to the one specified.

change_dir() checks if a directory is provided (as an argument), exists, and is
accessible, and then changes to it.

Positional argument:
  directory  The directory to change to
EOM
    )

    if [[ "${dir}" == "-h" || "${dir}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory provided."
        echo "${help}"
        return 1
    fi

    if [[ -d "${dir}" ]]; then
        cd "${dir}" ||
            {
                echo "Error: Failed to change to ${dir} even though it exists."
                return 1
            }
    else
        echo "Error: Directory ${dir} does not exist."
        return 1
    fi
}


function activate_env() {
    local env="${1}"
    local help=$(
cat << EOM
Usage: activate_env [environment]

Activate a specified Conda environment.

If another environment is already active, then activate_env() deactivates it
before activating the desired one.

Positional argument:
  environment  The name of the Conda environment to activate
EOM
    )

    if [[ "${env}" == "-h" || "${env}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if ! check_requirements conda; then return 1; fi

    if [[ -z "${env}" ]]; then
        echo "Error: No environment provided."
        echo "${help}"
        return 1
    fi

    if ! conda info --envs | grep -q "^${env} *"; then
        echo "Error: The environment '${env}' is not found. Please provide a"
        echo "       valid Conda environment name."
        return 1
    fi

    if [[ "${CONDA_DEFAULT_ENV}" != "${env}" ]]; then
        if [[ ${CONDA_DEFAULT_ENV} != base ]]; then
            conda deactivate
        fi

        source activate "${env}"
    fi

    return 0
}


function check_requirements() {
    local requirements=("$@")
    local tag="is not installed or not in the system's PATH"
    local help=$(
cat << EOM
Usage: check_requirements [command_1] [command_2] ...

Checks that the specified commands are available on the system.

check_requirements() iterates over all given commands and checks that they can
be executed, ensuring all required dependencies are installed.

Positional arguments:
  command_1, command_2, ...  The command(s) to check for installation,
                             availability in the system's PATH.

Example #1:
  check_requirements fithic python

Example #2:
  check_requirements cooler
EOM
    )

    if [[ "${requirements[0]}" == "-h" || "${requirements[0]}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[ -z "${requirements[@]}" ]]; then
        echo "Error: No command(s) provided."
        echo "${help}"
        return 1
    fi

    for req in "${requirements[@]}"; do
        if ! command -v "${req}" &> /dev/null; then
            echo "Error: ${req} ${tag}."
            return 1
        fi
    done

    return 0
}


function check_files() {
    local operation="${1}"
    shift
    local files=("$@")
    local help=$(
cat << EOM
Usage: check_files [operation] [file1] [file2] ...

Check the existence or non-existence of specified files.

check_files() supports two operations: "exist" to check if files exist, and
"not_exist" to check if files do not exist.

Positional arguments:
  operation          "exist" to check if files exist, "not_exist" to check if
                     files do not exist
  file1, file2, ...  The file(s) to check

Example:
  check_files exist "\${some_file}"
  check_files not_exist "\${array_of_files[@]}"
EOM
    )

    if [[ "${operation}" == "-h" || "${operation}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if [[  -z "${operation}" ]]; then
        echo "Error: No operation provided."
        echo "${help}"
        return 1
    fi

    if [[ -z "${files[@]}" ]]; then
        echo "Error: No file(s) provided."
        echo "${help}"
        return 1
    fi

    for file in "${files[@]}"; do
        if [[ "${operation}" == "exist" && ! -f "${file}" ]]; then
            echo "Error: ${file} does not exist."
            return 1
        elif [[ "${operation}" == "not_exist" && -f "${file}" ]]; then
            echo "Error: ${file} already exists."
            return 1
        fi
    done

    return 0
}


function check_python_version() {
    local help=$(
cat << EOM
Usage: check_python_version

Ensures that Python is installed, and its version is 3.x.

Example:
  check_python_version

Notes:
  This function is essential for scripts or applications that rely on
  Python 3.x features or libraries. It checks if Python is installed and
  accessible via the system's PATH, and verifies that the installed Python
  version is 3.x.
  
  If Python is not installed or not in the system's PATH, or if the installed
  Python version is not 3.x, the function will print an error message and
  return 1.
EOM
    )

    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        echo "${help}"
        return 0
    fi

    if ! command -v python &> /dev/null; then
        echo "Error: Python is not installed or not in the system's PATH."
        echo "${help}"
        return 1
    fi

    local python_version=$(python -c 'import sys; print(sys.version_info[0])')
    if [[ "${python_version}" -ne 3 ]]; then
        echo "Error: Python 3 is required, but Python ${python_version} is installed."
        echo "${help}"
        return 1
    fi

    echo "Python 3 is installed and accessible."
    return 0
}


function create_ia_file() {
    local cool=""
    local out=""
    local mito_free_out=""
    local rDNA_out=""
    local rDNA_cis_out=""
    local rDNA_trans_out=""
    local region=""
    # local keep_rDNA_self=false
    local scratch=""
    local write_cmd="cat"
    local help=$(
cat << EOM
Usage: create_ia_file -c COOL_FILE -o OUT_FILE [-m MITO_FREE_OUT_FILE]
       [-d RDNA_OUT_FILE] [-i RDNA_CIS_OUT_FILE] [-t RDNA_TRANS_OUT_FILE]
       [-r REGION] [-s SCRATCH_DIR]

Creates a FitHiC2 interactions file from a given .cool file. The output file
will be in bedpe format.

If a region is specified (optional), interactions are extracted for that region
only. The region can be specified as (1) a Roman numeral (I-XVI) for specific
chromosomes; (2) chr:start-end, where start and end are bp coordinates for a 
given Roman numeral chromosome; (3) "genome-trans", "genome_trans", or
"genome" for the entire genome; (4) "XII-all" and "XII_all" for the entire
genome (used for experiments that specifically examine XII-associated cis and
trans interactions); and (5) "XII-cis" and "XII_cis" for chromosome XII (used
for experiments that specifically examine XII-associated cis interactions).

Operations can optionally be performed in a specified scratch directory.

An additional optional argument (-m or --mito-free-out-file) allows for the
creation of a second output file that excludes interactions where columns 1
or 3 are "Mito", thereby filtering out mitochondrial interactions, which tend
to be noise.

An additional optional argument (-d or --rDNA-out-file) enables the creation of
a third output file that specifically retains interactions involving the rDNA
region on chromosome XII (positions 451400 to 469200). This option filters the
mito-free output to include only those interactions where at least one end maps
to this specified rDNA region. This feature is useful for focusing on
interactions originating from the rDNA locus. Note that this option requires
the --mito-free-out-file to be specified, as it operates on the mito-free
output.

Two further optional arguments, --rDNA-trans-out-file (-t) and
--rDNA-cis-out-file (-i), allow for more specific filtering of rDNA
interactions. The --rDNA-trans-out-file argument creates an output file
containing only trans interactions that originate from the rDNA region. This
means one end of the interaction is within the rDNA region on chromosome XII,
and the other end is on a different chromosome. This filter is particularly
useful for homing in on genome-wide interactions originating from the rDNA
locus.

Similarly, the --rDNA-cis-out-file argument creates an output file containing
only cis interactions that originate from the rDNA region. In this case, both
ends of the interaction are within the specified rDNA region on chromosome XII.
This filter is crucial for understanding the local chromatin dynamics
originating from the rDNA locus.

Note that both --rDNA-trans-out-file and --rDNA-cis-out-file require the
--mito-free-out-file and --rDNA-out-file switches to be specified. They operate
on the rDNA-filtered output to further segregate the interactions into trans
and cis categories, respectively.

create_ia_file() checks for required dependencies, validates input files, and
handles errors appropriately.

Options:
  -h, --help                 Display this help message.
  -c, --cool-file            Specify the .cool file.
  -o, --out-file             Specify the output file.
  -m, --mito-free-out-file   Specify the output file for interactions excluding
                             those where columns 1 or 3 are "Mito" (optional).
  -d, --rDNA-out-file        Specify the output file for interactions retaining
                             only rDNA interactions. Requires the specification
                             of --mito-free-out-file. This option filters the
                             mito-free output to include only interactions (cis
                             and trans) where at least one end maps to the rDNA
                             region on chromosome XII (positions 451400 to
                             469200).
  -i, --rDNA-cis-out-file    Specify the output file for rDNA-originating cis
                             interactions only. Requires --mito-free-out-file
                             and --rDNA-out-file to be specified.
  -t, --rDNA-trans-out-file  Specify the output file for rDNA-originating trans
                             interactions only. Requires --mito-free-out-file
                             and --rDNA-out-file to be specified.
  -r, --region               Specify the region (optional); accepts Roman 
                             numerals I-XVI; chr:start-end; "genome-trans",
                             "genome_trans", "genome", or "XII-all" for the
                             entire genome; or "XII-cis" for chromosome XII
                             only.
  -s, --scratch-dir          Specify a scratch directory (optional).

Dependencies:
  cooler: Required for processing .cool files
  awk:    Required for processing text streams

Note:
  In this function, we work with "fragment starts" rather than "fragment
  midpoints" as specified in the FitHiC2 documentation (e.g., as shown in the
  file example below). Per the authors of FitHiC2, "as long as what you have in
  [the interaction counts] file matches the fragments file," this approach 
  "should all be fine." For details, see the following URLs:
      - github.com/ay-lab/fithic/issues/26
      - groups.google.com/g/fithic/c/VBFukh28v8A/m/mF9wR6dSAQAJ

Example #1:
  create_ia_file
      -c some.cool
      -o some_ia.txt

Example #2:
  create_ia_file
      -c another.cool
      -o another_ia.txt.gz
      -r "I"
      -s /path/to/scratch

Example #3:
  create_ia_file
      -c and_another.cool
      -o and_another_ia.txt.gz
      -r "genome-trans"
      -s /path/to/scratch

Example #4:
  create_ia_file
      -c other.cool
      -o other_ia.txt
      -r "XII:451000-469000"

Example #5:
  create_ia_file
      -c yet_another.cool
      -o yet_another_ia.txt
      -m yet_another_ia.sans_mito.txt
      -r "genome"
      -s /path/to/scratch

Example #6:
  create_ia_file
      -c yet_another_other.cool
      -o yet_another_other_ia.txt.gz
      -m yet_another_other_ia.sans_mito.txt.gz
      -d yet_another_other_ia.rDNA.txt.gz
      -r "XII-all"

Example #7:
  create_ia_file
      -c sample.cool
      -o sample_ia.txt.gz
      -m sample_ia.mito-free.txt.gz
      -d sample_ia.rDNA.txt.gz
      -i sample_ia.rDNA_cis.txt.gz
      -r "XII-all"
      -s /path/to/scratch

Example #8:
  create_ia_file
      -c example.cool
      -o example_ia.txt.gz
      -m example_ia.mito-free.txt.gz
      -d example_ia.rDNA.txt
      -t example_ia.rDNA_trans.txt
      -r "XII-all"
      -s /path/to/scratch

Example #9"
  create_ia_file
      -c dataset.cool
      -o dataset_ia.txt.gz
      -m dataset_ia.sans_mito.txt.gz
      -d dataset_ia.rDNA.txt.gz
      -t dataset_ia.rDNA_trans.txt.gz
      -i dataset_ia.rDNA_cis.txt.gz
      -r "genome"

FitHiC2 interactions file example (header not in file):
  +-----+------------+-------------+--------------------------+-----------------+
  | chr | extraField | fragmentMid | marginalizedContactCount | mappable? (0/1) |
  +-----+------------+-------------+--------------------------+-----------------+
  |  1  |     0      |    15000    |            234           |        1        |
  |  1  |     0      |    25000    |             0            |        0        |
  | ... |    ...     |     ...     |            ...           |       ...       |
  +-----+------------+-------------+--------------------------+-----------------+

From the FitHiC2 GitHub repo documentation:
  The interactions file contains a list of mid-range contacts between the
  fragments/windows/meta-fragments listed in the first file above. Each
  fragment will be represented by its chromosome and midpoint coordinate. Each
  line will have 5 fields. The first two will represent first fragment, the
  following two will represent the second and the fifth field will correspond
  to number of contacts between these two fragments. The fields can be
  separated by space or tab. Only the fragment pairs with non-zero contact
  counts are listed in this file.

#TODO:
  - Argument to retain only rDNA self-interactions
  - Logic to exit function with error if user selects a specific region
    -r|--region and also selects -m|--mito-free-out-file or -d|--rDNA-out-file
    if -m or -d is not applicable to the region
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -c|--cool-file) cool="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            -m|--mito-free-out-file) mito_free_out="${2}"; shift 2 ;;
            -d|--rDNA-out-file) rDNA_out="${2}"; shift 2 ;;
            -i|--rDNA-cis-out-file) rDNA_cis_out="${2}"; shift 2 ;;
            -t|--rDNA-trans-out-file) rDNA_trans_out="${2}"; shift 2 ;;
            -r|--region) 
                region="${2}"
                if [[ "${region}" == "XII-cis" || "${region}" == "XII_cis" ]]; then
                    region="XII"
                elif [[ "${region}" == "XII-all" || "${region}" == "XII_all" ]]; then
                    region="genome-trans"
                fi
                shift 2 
                ;;
            -s|--scratch-dir) scratch="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements cooler awk; then return 1; fi
    if ! check_files "exist" "${cool}"; then return 1; fi
    if ! check_files "not_exist" "${out}"; then return 1; fi

    local region_option=""
    if [[ -n "${region}" ]]; then
        #  Check if the region parameter matches specific strings for the entire
        #+ genome
        if [[ 
               "${region}" == "genome-trans" \
            || "${region}" == "genome_trans" \
            || "${region}" == "genome" 
        ]]; then
            echo "Note: The option '-r ${region}' is used. Interactions will be extracted for the entire genome."
            
            #CODEREVIEW
            #  Once a variable is declared as local at its first occurrence, it
            #+ remains local to that function for all subsequent assignments or
            #+ modifications
            region_option="--join"
        else
            region_option="--join -r ${region}"
        fi
    else
        region_option="--join"
    fi

    if [[ "${out: -3}" == ".gz" ]]; then
        if ! check_requirements gzip; then return 1; fi
        local write_cmd="gzip"
    fi

    local out_final="${out}"
    local mito_free_out_final="${mito_free_out}"
    local rDNA_out_final="${rDNA_out}"
    local rDNA_cis_out_final="${rDNA_cis_out}"
    local rDNA_trans_out_final="${rDNA_trans_out}"
    if [[ -n "${scratch}" ]]; then
        if [[ ! -d "${scratch}" || ! -w "${scratch}" ]]; then
            echo "Error: The scratch directory ${scratch} does not exist or is not writable."
            return 1
        fi

        if ! cp "${cool}" "${scratch}/"; then
            echo "Error: Failed to copy $(basename "${cool}") to the scratch directory ${scratch}."
            return 1
        fi

        local cool="${scratch}/$(basename ${cool})"
        local out="${scratch}/$(basename ${out})"
        local mito_free_out="${scratch}/$(basename "${mito_free_out}")"
        local rDNA_out="${scratch}/$(basename "${rDNA_out}")"
        local rDNA_cis_out="${scratch}/$(basename "${rDNA_cis_out}")"
        local rDNA_trans_out="${scratch}/$(basename "${rDNA_trans_out}")"
    fi

    #  Not actually getting the fragment midpoints; instead, getting the
    #+ fragment starts, which "as long as what you have in [the interaction
    #+ counts] file matches the fragments file ... should all be fine." See
    #+     - github.com/ay-lab/fithic/issues/26
    #+     - groups.google.com/g/fithic/c/VBFukh28v8A/m/mF9wR6dSAQAJ
    if ! cooler dump ${region_option} "${cool}" \
        | awk 'BEGIN { 
                OFS="\t";
                FS="\t" 
            } { 
                print $1, $2, $4, $5, $7
             }' \
        | ${write_cmd} > "${out}"
    then
        echo "Error: Failed to create interactions file."
        return 1
    fi

    ### NEW CODE ###
    #  Filter out "Mito" interactions if the -m option is used
    if [[ -n "${mito_free_out}" ]]; then
        local mito_free_read_cmd="cat"
        local mito_free_write_cmd="cat"

        #  Check if the input file is gzipped
        if [[ "${out: -3}" == ".gz" ]]; then
            mito_free_read_cmd="zcat"
        fi

        #  Check if the mito-free output file should be gzipped
        if [[ "${mito_free_out: -3}" == ".gz" ]]; then
            mito_free_write_cmd="gzip"
        fi

        #  Apply an awk filter to exclude "Mito"-associated records; use the
        #+ appropriate commands to read and write files, gzipped or not
        if ! ${mito_free_read_cmd} "${out}" \
            | awk -F '\t' '{
                if ($1 != "Mito" && $3 != "Mito") { print $0 }
            }' \
            | ${mito_free_write_cmd} \
                > "${mito_free_out}"
        then
            echo "Error: Failed to create mito-free interactions file."
            return 1
        fi

        echo "Mito-free interactions file $(basename "${mito_free_out}") was created successfully."
    fi

    if [[ -n "${rDNA_out}" ]]; then
        local rDNA_read_cmd="cat"
        local rDNA_write_cmd="cat"
        
        #  Exit with code 1 if --rDNA-out-file is called without
        #+ --mito-free-out-file
        if [[ -z "${mito_free_out}" ]]; then
            echo "Error: --rDNA-out-file requires --mito-free-out-file to be specified."
            return 1
        fi

        #  Check if the input file is gzipped
        if [[ "${mito_free_out: -3}" == ".gz" ]]; then
            rDNA_read_cmd="zcat"
        fi

        #  Check if the mito-free output file should be gzipped
        if [[ "${rDNA_out: -3}" == ".gz" ]]; then
            rDNA_write_cmd="gzip"
        fi

        #  Apply the awk filter to create the rDNA interactions file; use the
        #+ appropriate commands to read and write files, gzipped or not
        if ! ${rDNA_read_cmd} "${mito_free_out}" \
            | awk -F'\t' '{
                if ((($1 == "XII" && $2 >= 451400 && $2 <= 469200) && ($3 != "XII" || ($3 == "XII" && ($4 < 451400 || $4 > 469200)))) ||
                    (($3 == "XII" && $4 >= 451400 && $4 <= 469200) && ($1 != "XII" || ($1 == "XII" && ($2 < 451400 || $2 > 469200)))))
                    print
            }' \
            | ${rDNA_write_cmd} \
                > "${rDNA_out}"
        then
            echo "Error: Failed to create rDNA interactions file."
            return 1
        fi

        echo "rDNA interactions file $(basename "${rDNA_out}") was created successfully."
    fi
    ### NEW CODE ###

    ### NEWER CODE ###
    if [[ -n "${rDNA_cis_out}" ]]; then
        local rDNA_cis_read_cmd="cat"
        local rDNA_cis_write_cmd="cat"
        
        #  Check for rDNA cis outfile
        if [[ -z "${mito_free_out}" ]] || [[ -z "${rDNA_out}" ]]; then
            echo "Error: --rDNA-cis-out-file requires both --mito-free-out-file and --rDNA-out-file to be specified."
            return 1
        fi

        if [[ "${rDNA_out: -3}" == ".gz" ]]; then
            rDNA_cis_read_cmd="zcat"
        fi

        if [[ "${rDNA_cis_out: -3}" == ".gz" ]]; then
            rDNA_cis_write_cmd="gzip"
        fi

        #  Apply awk filter for rDNA-originating cis interactions
        if ! ${rDNA_cis_read_cmd} "${rDNA_out}" \
            | awk -F '\t' '{ if ($1 == "XII" && $3 == "XII") print }' \
            | ${rDNA_cis_write_cmd} \
                > "${rDNA_cis_out}"
        then
            echo "Error: Failed to create rDNA cis interactions file."
            return 1
        fi

        echo "rDNA cis interactions file $(basename "${rDNA_cis_out}") was created successfully."
    fi
    
    if [[ -n "${rDNA_trans_out}" ]]; then
        local rDNA_trans_read_cmd="cat"
        local rDNA_trans_write_cmd="cat"
        
        #  Check for rDNA trans outfile
        if [[ -z "${mito_free_out}" ]] || [[ -z "${rDNA_out}" ]]; then
            echo "Error: --rDNA-trans-out-file requires both --mito-free-out-file and --rDNA-out-file to be specified."
            return 1
        fi

        if [[ "${rDNA_out: -3}" == ".gz" ]]; then
            rDNA_trans_read_cmd="zcat"
        fi

        if [[ "${rDNA_trans_out: -3}" == ".gz" ]]; then
            rDNA_trans_write_cmd="gzip"
        fi

        # Apply awk filter for rDNA-originating trans interactions
        if ! ${rDNA_trans_read_cmd} "${rDNA_out}" \
            | awk -F'\t' '{
                if ((($1 == "XII" && $2 >= 451400 && $2 <= 469200) && $3 != "XII") ||
                    (($3 == "XII" && $4 >= 451400 && $4 <= 469200) && $1 != "XII"))
                    print
            }' \
            | ${rDNA_trans_write_cmd} \
                > "${rDNA_trans_out}"
        then
            echo "Error: Failed to create rDNA trans interactions file."
            return 1
        fi

        echo "rDNA trans interactions file $(basename "${rDNA_trans_out}") was created successfully."
    fi
    ### NEWER CODE ###

    #  If both the -m and -f options are used, retain only those interactions
    #+ that originate from the rDNA locus 
    if [[ -n "${scratch}" ]]; then
        #  Copy outfile from scratch to user-specified storage directory
        if ! cp "${out}" "${out_final}"; then
            echo "Error: Failed to copy the interactions file from scratch to the output directory."
            return 1
        fi

        ### NEW CODE ###
        #  If it was created, then copy the mito-free outfile to the user-
        #+ specified storage directory
        if [[ -n "${mito_free_out}" ]]; then
            if ! cp "${mito_free_out}" "${mito_free_out_final}"; then
                echo "Error: Failed to copy the mito-free interactions file from scratch to the output directory."
                return 1
            fi
        fi

        #  If it was created, then copy the rDNA outfile to the user-specified
        #+ storage directory
        if [[ -n "${rDNA_out}" ]]; then
            if ! cp "${rDNA_out}" "${rDNA_out_final}"; then
                echo "Error: Failed to copy the rDNA interactions file from scratch to the output directory."
                return 1
            fi
        fi
        ### NEW CODE ###

        ### NEWER CODE ###
        if [[ -n "${rDNA_cis_out}" ]]; then
            if ! cp "${rDNA_cis_out}" "${rDNA_cis_out_final}"; then
                echo "Error: Failed to copy the cis rDNA interactions file from scratch to the output directory."
                return 1
            fi
        fi

        if [[ -n "${rDNA_trans_out}" ]]; then
            if ! cp "${rDNA_trans_out}" "${rDNA_trans_out_final}"; then
                echo "Error: Failed to copy the trans rDNA interactions file from scratch to the output directory."
                return 1
            fi
        fi
        ### NEWER CODE ###

        #  Remove specific .cool from the scratch directory
        if [[ -e "${cool}" ]]; then
            if ! rm "${cool}"; then
                echo "Warning: Failed to clean up the cool file $(basename "${cool}") in the scratch directory. Please remove the file manually."
            fi
        else
            echo "Warning: The cool file $(basename "${cool}") does not exist in the scratch directory. No cleanup needed."
        fi

        #  Remove specific .bedpe outfile from the scratch directory
        if [[ -e "${out}" ]]; then
            if ! rm "${out}"; then
                echo "Warning: Failed to clean up the interactions file $(basename "${out}") in the scratch directory. Please remove the file manually."
            fi
        else
            echo "Warning: The interactions file $(basename "${out}") does not exist in the scratch directory. No cleanup needed."
        fi
    fi

    # if [[ $? -eq 0 ]]; then
    #     echo "Interactions file ${out_final} was created successfully."
    #     return 0
    # else
    #     echo "Error: Failed to create interactions file."
    #     return 1
    # fi

    #  If it exists, then remove the mito-free outfile from the scratch
    #+ directory
    if [[ -n "${mito_free_out}" && -e "${mito_free_out_final}" ]]; then
        if ! rm "${mito_free_out}"; then
            echo "Warning: Failed to clean up the mito-free interactions file $(basename "${mito_free_out}") in the scratch directory. Please remove the file manually."
        fi
    fi

    # if [[ $? -eq 0 ]]; then
    #     echo "Interactions file ${mito_free_out} was created successfully."
    #     return 0
    # else
    #     echo "Error: Failed to create mito-free interactions file."
    #     return 1
    # fi

    #CODEREVIEW
    #  The final checks for the exit status (if [[ $? -eq 0 ]]; then) after the
    #+ removal of files from the scratch directory might be redundant or
    #+ misplaced. The $? variable captures the exit status of the last command
    #+ executed, which in this case would be rm commands for cleanup. This
    #+ might not reflect the overall success of the function. Consider revising
    #+ this to focus on the success of the main file creation processes.

    if [[ -n "${rDNA_out}" && -e "${rDNA_out_final}" ]]; then
        if ! rm "${rDNA_out}"; then
            echo "Warning: Failed to clean up the rDNA interactions file $(basename "${rDNA_out}") in the scratch directory. Please remove the file manually."
        fi
    fi

    if [[ -n "${rDNA_cis_out}" && -e "${rDNA_cis_out_final}" ]]; then
        if ! rm "${rDNA_cis_out}"; then
            echo "Warning: Failed to clean up the cis rDNA interactions file $(basename "${rDNA_cis_out}") in the scratch directory. Please remove the file manually."
        fi
    fi

    if [[ -n "${rDNA_trans_out}" && -e "${rDNA_trans_out_final}" ]]; then
        if ! rm "${rDNA_trans_out}"; then
            echo "Warning: Failed to clean up the trans rDNA interactions file $(basename "${rDNA_trans_out}") in the scratch directory. Please remove the file manually."
        fi
    fi
}


function create_frag_file() {
    local ia=""
    local out=""
    local scratch=""
    local help=$(
cat << EOM
Usage: create_frag_file -i IA_FILE -o OUT_FILE [-s SCRATCH_DIR]
        
Creates a FitHiC2 fragment file from a given FitHiC2 interactions file.

Operations can optionally be performed in a specified scratch directory.

create_frag_file() checks for the existence of required utilities and handles
errors.

Options:
  -h, --help         Display this help message
  -i, --ia-file      Specify the interactions file
  -o, --out-file     Specify the output file
  -s, --scratch-dir  Specify a scratch directory (optional)

Dependencies:
  bash utilities awk, gunzip, and sort: Required for processing, sorting data

Example #1:
  create_frag_file
      -i some_ia.txt.gz
      -o some_frag.txt.gz

Example #2:
  create_frag_file
      -i another_ia.txt.gz
      -o another_frag.txt.gz
      -s /path/to/scratch

FitHiC2 fragment file example (header not in file):
  +------+--------------+------+--------------+--------------+
  | chr1 | fragmentMid1 | chr2 | fragmentMid2 | contactCount |
  +------+--------------+------+--------------+--------------+
  |  1   |    15000     |  1   |    35000     |      23      |
  |  1   |    15000     |  1   |    55000     |      12      |
  | ...  |     ...      | ...  |     ...      |      ...     |
  +------+--------------+------+--------------+--------------+

From the FitHiC2 GitHub repo documentation:
  The -f argument is used to pass in a full path to what we deem a 'fragments
  file,' Each line will have 5 entries. The second and fifth fields can be any
  integer as they are not needed in most cases. The first field is the
  chromosome name or number, the third field is the coordinate of the midpoint
  of the fragment on that chromosome, the fourth field is the total number of
  observed mid-range reads (contact counts) that involve the specified
  fragment. The fields can be separated by space or tab. All possible fragments
  need to be listed in this file.
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -i|--ia-file) ia="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            -s|--scratch-dir) scratch="${2}"; shift 2 ;;
            *) echo "Unknown param passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    if ! check_requirements awk sort; then return 1; fi
    if ! check_files "exist" "${ia}"; then return 1; fi
    if ! check_files "not_exist" "${out}"; then return 1; fi

    if [[ "${ia}" == "${out}" ]]; then
        echo "Error: Input file and output file should not be the same."
        return 1
    fi

    local read_cmd=""
    local write_cmd=""
    local out_final="${out}"

    if [[ "${ia: -3}" == ".gz" ]]; then
        if ! check_requirements gunzip; then return 1; fi
        local read_cmd="gunzip -c"
    else
        local read_cmd="cat"
    fi

    if [[ "${out: -3}" == ".gz" ]]; then
        if ! check_requirements gzip; then return 1; fi
        local write_cmd="gzip"
    else
        local write_cmd="cat"
    fi

    if [[ -n "${scratch}" ]]; then
        if [[ ! -d "${scratch}" || ! -w "${scratch}" ]]; then
            echo "Error: The scratch directory ${scratch} does not exist or is not writable."
            return 1
        fi

        if ! cp "${ia}" "${scratch}/"; then
            echo "Error: Failed to copy ${ia} to the scratch directory ${scratch}."
            return 1
        fi

        local ia="${scratch}/$(basename ${ia})"
        local out="${scratch}/$(basename ${out})"
    fi

    ${read_cmd} "${ia}" \
        | awk 'BEGIN { 
                OFS="\t"; 
                FS="\t" 
            } 
            { 
                a[$1"\t0\t"$2]+=$5; 
                a[$3"\t0\t"$4]+=$5; 
            } 
            END { 
                for (coord in a) { 
                    print coord, a[coord], 1 
                }
            }' \
        | sort -k1,2n \
        | ${write_cmd} > "${out}"

    if [[ -n "${scratch}" ]]; then
        if ! cp "${out}" "${out_final}"; then
            echo "Error: Failed to copy the fragment file to the output directory."
            return 1
        fi

        if ! rm "${ia}"; then
            echo "Warning: Failed to clean up the interactions file ${ia} in the scratch directory."
            echo "         Please remove the file manually."
        fi

        if ! rm "${out}"; then
            echo "Warning: Failed to clean up the fragment file ${out} in the scratch directory."
            echo "         Please remove the file manually."
        fi
    fi

    echo "Fragment file ${out_final} was created successfully."
    return 0
}


generate_bias_vector() {
    local pct=0.05
    local hickry=""
    local ia=""
    local frag=""
    local out=""
    local help=$(
cat << EOM
Usage: generate_bias_vector -p PERCENTILE -i INT_FILE -f FRAG_FILE -o OUT_FILE -k HICKRY_PATH
        
Generates a bias vector file using FitHiC2's HiCKRy.py.

generate_bias_vector() validates the input parameters, checks for required
dependencies, and handles errors.

Options:
  -h, --help         Display this help message
  -k, --hickry-path  Specify the path to HiCKRy.py
  -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
  -i, --ia-file      Specify the interactions file
  -f, --frag-file    Specify the fragment file
  -o, --out-file     Specify the output file

Dependencies:
  Python
  HiCKRy.py

Example:
  generate_bias_vector
      -k /path/to/HiCKRy.py
      -p 0.05
      -i some_ia.txt.gz
      -f some_frag.txt.gz
      -o some_bias.txt.gz
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -k|--hickry-path) hickry="${2}"; shift 2 ;;
            -p|--percent) pct="${2}"; shift 2 ;;
            -i|--ia-file) ia="${2}"; shift 2 ;;
            -f|--frag-file) frag="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            *) echo "Unknown param passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    if ! check_python_version; then return 1; fi
    if ! check_requirements bc; then return 1; fi

    if [[ -z "${hickry}" ]]; then
        echo "Error: The path to HiCKRy.py is required."
        return 1
    fi

    #  Check if the path to HiCKRy.py is a directory
    if [[ -d "${hickry}" ]]; then
        hickry="${hickry%/}/HiCKRy.py"  # Append HiCKRy.py to the path
    elif [[ ! -f "${hickry}" ]]; then
        echo "Error: ${hickry} is not a valid file or directory."
        return 1
    fi

    if [[ ! -x "${hickry}" ]]; then
        echo "Error: HiCKRy.py is not executable or does not have execute permissions."
        return 1
    fi

    if ! check_files "exist" "${ia}" "${frag}"; then return 1; fi
    if ! check_files "not_exist" "${out}"; then return 1; fi

    if [[ ! "${pct}" =~ ^0\.[0-9]+$ ]]; then
        echo "Error: Percent should be a decimal number between 0 and 1."
        return 1
    elif [[ "$(bc <<< "${pct} < 0")" -eq 1 ]]; then
        echo "Error: Percent cannot be <0; it must be between 0 and 1."
        return 1
    elif [[ "$(bc <<< "${pct} > 1")" -eq 1 ]]; then
        echo "Error: Percent cannot be >1; it must be between 0 and 1."
        return 1
    fi

    python "${hickry}" \
        -i "${ia}" \
        -f "${frag}" \
        -x "${pct}" \
        -o "${out}"

    if [[ $? -eq 0 ]]; then
        echo "Bias vector file ${out} was created successfully."
        return 0
    else
        echo "Error: Failed to create bias vector file."
        return 1
    fi
}


function filter_significances_file() {
    local input_file=""
    local output_file=""
    local q_thresh=0.05
    local help=$(
cat << EOM
Usage: filter_significances_file -i INPUT_FILE -o OUTPUT_FILE [-q Q_VALUE_THRESHOLD]
        
Filters a gzipped FitHiC2 significances file based on a specified q-value threshold.

Options:
  -h, --help                Display this help message
  -i, --input-file          Specify the gzipped input significances file
  -o, --output-file         Specify the gzipped output file for filtered results
  -q, --q-value-threshold   Specify the q-value threshold for filtering (default: 0.05)

Dependencies:
  gzip: Required for processing gzipped files
  awk:  Required for processing text streams

Example:
  filter_significances_file
      -i some.significances.txt.gz
      -o some.significances.filt.txt.gz
      -q 0.05
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -i|--input-file) input_file="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -q|--q-value-threshold) q_thresh="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements awk gzip; then return 1; fi
    if ! check_files "exist" "${input_file}"; then return 1; fi
    if ! check_files "not_exist" "${output_file}"; then return 1; fi

    local read_cmd="cat"
    local write_cmd="cat"
    if [[ "${input_file}" == *.gz ]]; then read_cmd="gunzip -c"; fi
    if [[ "${output_file}" == *.gz ]]; then write_cmd="gzip"; fi

    ${read_cmd} "${input_file}" \
        | awk -v threshold="${q_thresh}" 'BEGIN { 
            OFS="\t" 
        } NR==1 { 
            print $0 
        } NR>1 && $7 <= threshold { 
            print $0 
        }' \
        | ${write_cmd} > "${output_file}"

    if [[ $? -eq 0 ]]; then
        echo "Filtered file ${output_file} was created successfully."
        return 0
    else
        echo "Error: Failed to create filtered file."
        return 1
    fi
}


function create_bedpe_file() {
    local input_file=""
    local output_file=""
    local res=""
    local color_1="255,0,0"
    local color_2="255,255,0"
    local color_3="0,255,0"
    local color_4="0,255,255"
    local color_5="0,0,255"
    local threshold_1=5
    local threshold_2=10
    local threshold_3=50
    local threshold_4=100
    local in_region_check="yes"
    local chromosome="XII"
    local start=435000
    local end=500000
    local help=$(
cat << EOM
Usage: create_bedpe_file -i INPUT_FILE -o OUTPUT_FILE -r RESOLUTION 
                         [-c1 COLOR_1] [-c2 COLOR_2] [-c3 COLOR_3] [-c4 COLOR_4] [-c5 COLOR_5]
                         [-t1 THRESHOLD_1] [-t2 THRESHOLD_2] [-t3 THRESHOLD_3] [-t4 THRESHOLD_4]
        
Creates a bedpe file with color annotations based on the significance values.

Options:
  -h, --help          Display this help message
  -i, --input-file    Specify the input file
  -o, --output-file   Specify the output bedpe file
  -r, --resolution    Specify the resolution
  -c1, --color-1      Specify the first RGB color (default: 255,0,0 (red))
  -c2, --color-2      Specify the second RGB color (default: 255,255,0 (yellow))
  -c3, --color-3      Specify the third RGB color (default: 0,255,0 (green))
  -c4, --color-4      Specify the fourth RGB color (default: 0,255,255 (cyan))
  -c5, --color-5      Specify the fifth RGB color (default: 0,0,255 (blue))
  -t1, --threshold-1  Specify the first -log10(q) threshold (default: 5; below t1 = c1; above t1 = c2)
  -t2, --threshold-2  Specify the second -log10(q) threshold (default: 10; above t2 = c3)
  -t3, --threshold-3  Specify the third -log10(q) threshold (default: 50; above t3 = c4)
  -t4, --threshold-4  Specify the fourth -log10(q) threshold (default: 100; above t4 = c5)
  -n, --in-region     Specify whether to perform in-region check (default: yes)
  -c, --chromosome    Specify the chromosome for in-region check (default: XII)
  -s, --start         Specify the start position for in-region check (default: 435000)
  -e, --end           Specify the end position for in-region check (default: 500000)

Dependencies:
  gzip: Required for processing gzipped in- and outfiles
  awk:  Required for processing text streams

Note:
  Values passed to -r|--resolution and -t?|--threshold-? must be positive
  integers.

  If not provided, then create_bedpe_file() attempts to extract the resolution
  from the input file name:

    if [[ -z "\${res}" ]]; then
        #  Extract resolution from the input file name if not provided
        if [[ "\${input_file}" =~ .res([0-9]+). ]]; then
            res="\${BASH_REMATCH[1]}"
            echo "Resolution not provided. Extracted resolution \${res} from the input file name."
        else
            echo "Error: Resolution is not provided and could not be extracted from the input file name."
            return 1
        fi
    fi

Example #1:
  create_bedpe_file
      -i some.significances.filt.txt.gz
      -o some.significances.filt.bedpe

Example #2:
  create_bedpe_file
      -i some_other.significances.filt.txt.gz
      -o some_other.bedpe
      -r 5000
      -c1 "255,0,0"
      -c2 "255,255,0"
      -c3 "0,255,0"
      -c4 "0,255,255"
      -c5 "0,0,255"
      -t1 5
      -t2 10
      -t3 50
      -t4 100
      -n "no"

Example #3:
  create_bedpe_file
      -i "another.significances.filt.txt.gz"
      -o "another.bedpe"
      -r 6400
      -c1 "255,0,0"
      -c2 "255,255,0"
      -c3 "0,255,0"
      -c4 "0,255,255"
      -c5 "0,0,255"
      -t1 10
      -t2 20
      -t3 50
      -t4 100
      -n "yes"
      -c "XII"
      -s 450000
      -e 470000
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -i|--input-file) input_file="${2}"; shift 2 ;;
            -o|--output-file) output_file="${2}"; shift 2 ;;
            -r|--resolution) res="${2}"; shift 2 ;;
            -c1|--color-1) color_1="${2}"; shift 2 ;;
            -c2|--color-2) color_2="${2}"; shift 2 ;;
            -c3|--color-3) color_3="${2}"; shift 2 ;;
            -c4|--color-4) color_4="${2}"; shift 2 ;;
            -c5|--color-5) color_5="${2}"; shift 2 ;;
            -t1|--threshold-1) threshold_1="${2}"; shift 2 ;;
            -t2|--threshold-2) threshold_2="${2}"; shift 2 ;;
            -t3|--threshold-3) threshold_3="${2}"; shift 2 ;;
            -t4|--threshold-4) threshold_4="${2}"; shift 2 ;;
            -n|--in-region) in_region_check="${2,,}"; shift 2 ;;
            -c|--chromosome) chromosome="${2}"; shift 2 ;;
            -s|--start) start="${2}"; shift 2 ;;
            -e|--end) end="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements awk gzip; then return 1; fi
    if ! check_files "exist" "${input_file}"; then return 1; fi
    if ! check_files "not_exist" "${output_file}"; then return 1; fi

    if [[ -z "${res}" ]]; then
        #  Extract resolution from the input file name if not provided
        if [[ "${input_file}" =~ .res([0-9]+). ]]; then
            res="${BASH_REMATCH[1]}"
            echo "Resolution not provided. Extracted resolution ${res} from the input file name."
        else
            echo "Error: Resolution is not provided and could not be extracted from the input file name."
            return 1
        fi
    fi

    #  Validate resolution and thresholds
    for num in "${res}" "${threshold_1}" "${threshold_2}" "${threshold_3}" "${threshold_4}"; do
        if ! [[ ${num} =~ ^[0-9]+$ ]]; then
            echo "Error: Invalid number format: ${num}. Please provide a positive integer."
            return 1
        fi
    done

    #  Validate color format
    for color in "${color_1}" "${color_2}" "${color_3}" "${color_4}" "${color_5}"; do
        if ! [[ ${color} =~ ^[0-9]{1,3},[0-9]{1,3},[0-9]{1,3}$ ]]; then
            echo "Error: Invalid color format: ${color}. Please use the format R,G,B."
            return 1
        fi
    done

    local read_cmd="cat"
    local write_cmd="cat"
    if [[ "${input_file}" == *.gz ]]; then read_cmd="gunzip -c"; fi
    if [[ "${output_file}" == *.gz ]]; then write_cmd="gzip"; fi

    ${read_cmd} "${input_file}" \
        | awk \
            -v res="${res}" \
            -v c1="${color_1}" -v c2="${color_2}" -v c3="${color_3}" \
            -v c4="${color_4}" -v c5="${color_5}" \
            -v t1="${threshold_1}" -v t2="${threshold_2}" \
            -v t3="${threshold_3}" -v t4="${threshold_4}" \
            -v check="${in_region_check}" \
            -v chr="${chromosome}" -v start="${start}" -v end="${end}" \
            'BEGIN { 
                FS = "\t"; OFS="\t" 
            } NR>1 { 
                color=c1;
                if (-log($7)/log(10) > t1) color=c2;
                if (-log($7)/log(10) > t2) color=c3;
                if (-log($7)/log(10) > t3) color=c4;
                if (-log($7)/log(10) > t4) color=c5;
                in_region = "FALSE";
                if (check == "yes" && (($1 == chr && $2 >= start && $2 <= end) || 
                    ($3 == chr && $4 >= start && $4 <= end))) in_region = "TRUE";
                print $1, $2, $2+res, $3, $4, $4+res, \
                      $1"_"$2"_"$2+res"__"$3"_"$4"_"$4+res, \
                      -log($7)/log(10), ".", ".", color, in_region
            }' \
        | ${write_cmd} > "${output_file}"

    if [[ $? -eq 0 ]]; then
        echo "Bedpe file ${output_file} was created successfully."
        return 0
    else
        echo "Error: Failed to create bedpe file."
        return 1
    fi
}


# main() {
#     local region=""
#     local cool=""
#     local pct=0.05  # Default value
#     local ia=""
#     local frag=""
#     local out=""
#     local hickry=""
#     local scratch=""
#     local help=$(
# cat << EOM
# Usage: main -c COOL_FILE -i IA_FILE -f FRAG_FILE -o OUT_FILE -H HICKRY_PATH \\
#   [-p PERCENT] [-r REGION] [-s SCRATCH_DIR]
#        
# This function integrates the creation of interaction and fragment files, the
# generation of a bias vector, and other functionalities.
#
# main() validates the input parameters and handles errors.
#
# Options:
#   -h, --help         Display this help message
#   -c, --cool-file    Specify the .cool file
#   -i, --ia-file      Specify the interactions file
#   -f, --frag-file    Specify the fragment file
#   -o, --out-file     Specify the output file for bias vector
#   -H, --hickry-path  Specify the path to HiCKRy.py
#   -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
#   -r, --region       Specify the region (optional)
#   -s, --scratch-dir  Specify a scratch directory (optional)
#
# Example #1:
#   main
#       -c some.cool
#       -i some_ia.txt
#       -f some_frag.txt
#       -o some_bias.txt
#       -H /path/to/HiCKRy.py
#
# Example #2:
#   main
#       -c another.cool
#       -i another_ia.txt
#       -f another_frag.txt
#       -o another_bias.txt
#       -H /path/to/HiCKRy.py
#       -p 0.10
#       -r XII
#       -s /path/to/scratch
# EOM
#     )
#
#     if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
#     while [[ "$#" -gt 0 ]]; do
#         case "${1}" in
#             -h|--help) echo "${help}"; return 0 ;;
#             -c|--cool-file) cool="${2}"; shift 2 ;;
#             -i|--ia-file) ia="${2}"; shift 2 ;;
#             -f|--frag-file) frag="${2}"; shift 2 ;;
#             -o|--out-file) out="${2}"; shift 2 ;;
#             -H|--hickry-path) hickry="${2}"; shift 2 ;;
#             -p|--percent) pct="${2}"; shift 2 ;;
#             -r|--region) region="${2}"; shift 2 ;;
#             -s|--scratch-dir) scratch="${2}"; shift 2 ;;
#             *) echo "Unknown parameter passed: ${1}"; return 1 ;;
#         esac
#     done
#
#     # Validate required parameters
#     if [[ -z "${cool}" ]]; then
#         echo "Error: Missing .cool file. Use -c or --cool-file to specify it."
#         local missing_params=true
#     fi
#
#     if [[ -z "${ia}" ]]; then
#         echo "Error: Missing interactions file. Use -i or --ia-file to specify it."
#         local missing_params=true
#     fi
#
#     if [[ -z "${frag}" ]]; then
#         echo "Error: Missing fragment file. Use -f or --frag-file to specify it."
#         local missing_params=true
#     fi
#
#     if [[ -z "${out}" ]]; then
#         echo "Error: Missing output file for bias vector. Use -o or --out-file to specify it."
#         local missing_params=true
#     fi
#
#     if [[ -z "${hickry}" ]]; then
#         echo "Error: Missing path to HiCKRy.py. Use -H or --hickry-path to specify it."
#         local missing_params=true
#     fi
#
#     if ${missing_params}; then echo "${help}"; return 1; fi
#
#     # Create interactions file
#     if ! create_ia_file -c "${cool}" -o "${ia}" -r "${region}"; then
#         echo "Error: Failed to create interactions file."
#         return 1
#     fi
#
#     # Create fragments file
#     if ! create_frag_file -i "${ia}" -o "${frag}" -s "${scratch}"; then
#         echo "Error: Failed to create fragment file."
#         return 1
#     fi
#
#     # Generate bias vector values
#     if ! generate_bias_vector -H "${hickry}" -p "${pct}" -i "${ia}" -f "${frag}" -o "${out}"; then
#         echo "Error: Failed to generate bias vector."
#         return 1
#     fi
#
#     echo "All tasks completed successfully."
#     return 0
# }
```
</details>
<br />

<a id="configure-work-environment-directories-and-variables"></a>
### Configure work environment, directories, and variables
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Configure work environment, directories, and variables</i></summary>

```bash
#!/bin/bash

#NOTE This chunk can be cut
#  Populate associative arrays ----------------------------
unset A_dirs A_prefix
typeset -A A_dirs A_prefix

A_dirs=(
    ["11_cooler_genome_KR-filt-0.4"]="13_FitHiC2_genome_KR-filt-0.4"
    ["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"
    # ["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"
)

A_prefix=(
    ["MC-2020_30C-a15_WT_repM"]="G1"
    ["MC-2019_Q_WT_repM"]="Q"
    ["MC-2020_nz_WT_repM"]="G2"
)

#  Check associative arrays
check_array=true
[[ ${check_array} == true ]] &&
    {
        for key in "${!A_dirs[@]}"; do
            echo """
              key  ${key}
            value  ${A_dirs[${key}]}
            """
        done
    }

check_array=true
[[ ${check_array} == true ]] &&
    {
        for key in "${!A_prefix[@]}"; do
            echo """
              key  ${key}
            value  ${A_prefix[${key}]}
            """
        done
    }


#  Initialize other configurations ------------------------
# unset resolutions && typeset -a resolutions=(800 1600 3200 5000 6400)
unset resolutions && typeset -a resolutions=(1600)

# unset regions && typeset -a regions=("XII-cis" "XII-all" "genome-trans")
unset regions && typeset -a regions=("XII-all")

scratch="/fh/scratch/delete30/tsukiyama_t"
HiCKRy="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"

#NOTE This is test code
iter=0
for dir_in in "${!A_dirs[@]}"; do
    dir_out="${A_dirs[${dir_in}]}"  # echo "${dir_out}"

    debug=false
    [[ ${debug} == true ]] && echo "dir_out=${dir_out}"

    for phase in "${!A_prefix[@]}"; do
        for res in "${resolutions[@]}"; do
            # res="${resolutions[0]}"  # echo "${res}"
            (( iter++ ))

            file_in=$(
                find \
                    "${dir_in}" \
                    -maxdepth 1 \
                    -type f \
                    -name "${phase}*.${res}.*cool"
            )

            if [[ ! -z "${file_in}" ]]; then
                for key in "${!A_prefix[@]}"; do
                    prefix="${A_prefix[${key}]}"
                    
                    debug=false
                    [[ ${debug} == true ]] \
                        && echo -e "key\t${key}\nvalue\t${prefix}\n"

                    run_conditional_statement=true
                    if ${run_conditional_statement}; then
                        if [[ "${file_in}" =~ "${key}" ]]; then
                            file_out=$(
                                echo "${file_in%.cool}" \
                                    | sed -E -e 's:11_cooler:13_FitHiC2:g' \
                                             -e 's:.standard-rDNA-complete.mapped::g' \
                                             -e 's:downsample:ds:g' \
                                             -e "s:${key}:${prefix}:g"
                            )
                        fi
                    fi
                done

                for region in "${regions[@]}"; do
                    if [[ "${region}" == "XII-cis" ]]; then
                        type="intraOnly"
                    elif [[ "${region}" == "XII-all" ]]; then
                        type="all"
                    elif [[ "${region}" == "genome-trans" ]]; then
                        type="interOnly"
                    fi

                    echo """
                    iter .............................. ${iter}
                    dir_in ............................ ${dir_in}
                    dir_out ........................... ${dir_out}
                    phase ............................. ${phase}
                    resolution ........................ ${res}
                    file_in ........................... ${file_in}
                    file_out .......................... ${file_out}
                    region ............................ ${region}
                    type .............................. ${type}
                    scratch ........................... ${scratch}
                    HiCKRy ............................ ${HiCKRy}
                    """
                    sleep 0.1
                done
            fi
        done
    done
done
```
</details>
<br />

<a id="establish-and-test-workflow"></a>
### Establish and test workflow
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Establish and test workflow</i></summary>

```bash
#!/bin/bash

#  Execute main (test) tasks ==================================================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source initial work environment that allows access to cooler
activate_env pairtools_env

#  Set up test parameters (#TODO Use the chunk to submit jobs to the scheduler)
set_up_test_parameters=true
check_variables=true
check_array=false
debug=false
if ${set_up_test_parameters}; then
    unset A_dirs a_dirs A_prefix a_prefix
    typeset -A A_dirs A_prefix
    typeset -a a_dirs a_prefix
    
    a_dirs=(
        "11_cooler_genome_KR-filt-0.4_whole-matrix"
        # "11_cooler_XII_KR-filt-0.4"
    )

    A_dirs=(
        ["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"
        # ["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"
    )

    a_prefix=(
        "MC-2019_Q_WT_repM"
        "MC-2020_30C-a15_WT_repM"
        "MC-2020_nz_WT_repM"
    )

    A_prefix=(
        ["MC-2019_Q_WT_repM"]="Q"
        ["MC-2020_30C-a15_WT_repM"]="G1"
        ["MC-2020_nz_WT_repM"]="G2"
    )

    if ${check_array}; then
        for i in "${a_dirs[@]}"; do
              key="${i}"
            value="${A_dirs[${key}]}"

            echo """
              key  ${key}
            value  ${value}
            """
        done
    fi

    if ${check_array}; then
        for i in "${a_prefix[@]}"; do
              key="${i}"
            value="${A_prefix[${key}]}"

            echo """
              key  ${key}
            value  ${value}
            """
        done
    fi

    # unset resolutions && typeset -a resolutions=(5000)
    unset resolutions && typeset -a resolutions=(1600)

    # unset regions && typeset -a regions=("genome-trans")
    # unset regions && typeset -a regions=("XII-cis")
    unset regions && typeset -a regions=("XII-all")

    scratch="/fh/scratch/delete30/tsukiyama_t"                          # echo "${scratch}"
    HiCKRy="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"
    HiCKRy_pct=0.05                                                     # echo "${HiCKRy_pct}"
    
    c1="255,0,0"                                                        # echo "${c1}"
    c2="255,255,0"                                                      # echo "${c2}"
    c3="0,255,0"                                                        # echo "${c3}"
    c4="0,255,255"                                                      # echo "${c4}"
    c5="0,0,255"                                                        # echo "${c5}"
    t1=5                                                                # echo "${t1}"
    t2=10                                                               # echo "${t2}"
    t3=50                                                               # echo "${t3}"
    t4=100                                                              # echo "${t4}"
    
    iter=0
    for dir_in in "${a_dirs[@]}"; do
        # dir_in=${a_dirs[0]}                                           # echo "${dir_in}"
        dir_out="${A_dirs[${dir_in}]}"                                  # echo "${dir_out}"

        [[ ${debug} == true ]] \
            && echo "dir_out=${dir_out}"

        for phase in "${a_prefix[@]}"; do
            # phase="${a_prefix[0]}"                                    # echo "${phase}"
            prefix="${A_prefix[${phase}]}"                              # echo "${prefix}"

            [[ ${debug} == true ]] \
                && echo -e "key\t${phase}\nvalue\t${prefix}\n"

            for res in "${resolutions[@]}"; do
                # res="${resolutions[0]}"                               # echo "${res}"

                file_in=$(
                    find \
                        "${dir_in}" \
                        -maxdepth 1 \
                        -type f \
                        -name "${phase}*.${res}.*cool"
                    )                                                   # echo "${file_in}"

                for region in "${regions[@]}"; do
                    # region="${regions[0]}"                            # echo "${region}"
                    if [[ "${region}" == "XII-cis" ]]; then
                        type="intraOnly"
                    elif [[ "${region}" == "XII-all" ]]; then
                        type="All"
                    elif [[ "${region}" == "genome-trans" ]]; then
                        type="interOnly"
                    fi                                                  # echo "${type}"
                
                    if [[ "${file_in}" =~ "${phase}" ]]; then
                        file_out="$(
                            echo "${file_in%.cool}" \
                                | sed -E -e 's:11_cooler:13_FitHiC2:g' \
                                         -e 's:.standard-rDNA-complete.mapped::g' \
                                         -e 's:downsample:ds:g' \
                                         -e "s:${phase}:${prefix}:g"
                        ).${region}"                                    # echo "${file_out}"
                    fi
                    
                    (( iter++ ))

                    if ${check_variables}; then
                        echo """
                        iter .............................. ${iter}
                        dir_in ............................ ${dir_in}
                        dir_out ........................... ${dir_out}
                        phase ............................. ${phase}
                        prefix ............................ ${prefix}
                        resolution ........................ ${res}
                        region ............................ ${region}
                        type .............................. ${type}
                        file_in ........................... ${file_in}
                        file_out .......................... ${file_out}
                        scratch ........................... ${scratch}
                        HiCKRy ............................ ${HiCKRy}
                        HiCKRy_pct ........................ ${HiCKRy_pct}
                        """
                    fi
                done
                
                sleep 0.1
            done
        done
    done
fi


#  Make outfile directories -------------------------------
make_outfile_directories=false
if ${make_outfile_directories}; then
    for dir in "${!A_dirs[@]}"; do
        if [[ ! -d "${A_dirs[${dir}]}" ]]; then
            mkdir -p "${A_dirs[${dir}]}/err_out"
        else
            echo "Outfile directory ${A_dirs[${dir}]} exists."
        fi
    done
fi


#  Test workflow ------------------------------------------
run_workflow=true

run_env_change_1=true

check_command_1=true
run_command_1=true

check_command_2=true
run_command_2=true

run_env_change_2=true

check_command_3=true
run_command_3=true

check_command_4=true
run_command_4=true

check_command_5=false
run_command_5=false

check_command_6=false
run_command_6=false

if ${run_workflow}; then
    #  Step #1. Create FitHiC2 interactions text file
    [[ ${run_env_change_1} == true ]] \
        && activate_env pairtools_env \
        || true

    if ${check_command_1}; then
        echo """
        #  Step #1. Create FitHiC2 interactions text file

        create_ia_file \\
            -c "$(pwd)/${file_in}" \\
            -o "$(pwd)/${file_out}.ia.txt.gz" \\
            -m "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
            -d "$(pwd)/${file_out}.rDNA.ia.txt.gz" \\
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
            -t "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
            -r "${region}" \\
            -s "${scratch}"
        """
    fi

    if ${run_command_1}; then
        create_ia_file \
            -c "$(pwd)/${file_in}" \
            -o "$(pwd)/${file_out}.ia.txt.gz" \
            -m "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
            -d "$(pwd)/${file_out}.rDNA.ia.txt.gz" \
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
            -t "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
            -r "${region}" \
            -s "${scratch}"
    fi

    #  Step #2. Create FitHiC2 fragments text file
    if ${check_command_2}; then
        echo """
        #  Step #2. Create FitHiC2 fragments text file

        create_frag_file \\
            -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
            -o "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
            -s "${scratch}"

        create_frag_file \\
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
            -o "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
            -s "${scratch}"

        create_frag_file \\
            -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
            -o "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
            -s "${scratch}"
        """
    fi

    if ${run_command_2}; then
        create_frag_file \
            -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
            -o "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
            -s "${scratch}"

        create_frag_file \
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
            -o "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
            -s "${scratch}"

        create_frag_file \
            -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
            -o "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
            -s "${scratch}"
    fi


    #  Step #3. Generate bias vector needed to run FitHiC2
    [[ ${run_env_change_2} == true ]] \
        && activate_env fithic_env \
        || true

    if ${check_command_3}; then
        echo """
        #  Step #3. Generate bias vector needed to run FitHiC2

        generate_bias_vector \\
            -k "${HiCKRy}" \\
            -p "${HiCKRy_pct}" \\
            -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
            -f "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
            -o "$(pwd)/${file_out}.mito-free.bias.txt.gz"

        generate_bias_vector \\
            -k "${HiCKRy}" \\
            -p "${HiCKRy_pct}" \\
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
            -f "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
            -o "$(pwd)/${file_out}.rDNA_cis.bias.txt.gz"

        generate_bias_vector \\
            -k "${HiCKRy}" \\
            -p "${HiCKRy_pct}" \\
            -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
            -f "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
            -o "$(pwd)/${file_out}.rDNA_trans.bias.txt.gz"
        """
    fi

    if ${run_command_3}; then
        generate_bias_vector \
            -k "${HiCKRy}" \
            -p "${HiCKRy_pct}" \
            -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
            -f "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
            -o "$(pwd)/${file_out}.mito-free.bias.txt.gz"

        generate_bias_vector \
            -k "${HiCKRy}" \
            -p "${HiCKRy_pct}" \
            -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
            -f "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
            -o "$(pwd)/${file_out}.rDNA_cis.bias.txt.gz"

        generate_bias_vector \
            -k "${HiCKRy}" \
            -p "${HiCKRy_pct}" \
            -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
            -f "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
            -o "$(pwd)/${file_out}.rDNA_trans.bias.txt.gz"
    fi


    #  Step #4. Run FitHiC2
    if ${check_command_4}; then
        echo """
        #  Step #4. Run FitHiC2

        fithic \\
            --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
            --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
            --outdir "$(pwd)/$(dirname "${file_out}")" \\
            --resolution "${res}" \\
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
            --contactType "${type}" \\
            --mappabilityThres "${map:-1}" \\
            --biasLowerBound "${lower:-0.01}" \\
            --biasUpperBound "${higher:-1000}" \\
            --lib "$(basename "${file_out}").mito-free" \\
            --visual

        fithic \\
            --interactions "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
            --fragments "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
            --outdir "$(pwd)/$(dirname "${file_out}")" \\
            --resolution "${res}" \\
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
            --contactType "${type}" \\
            --mappabilityThres "${map:-1}" \\
            --biasLowerBound "${lower:-0.01}" \\
            --biasUpperBound "${higher:-1000}" \\
            --lib "$(basename "${file_out}").rDNA_cis" \\
            --visual

        fithic \\
            --interactions "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
            --fragments "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
            --outdir "$(pwd)/$(dirname "${file_out}")" \\
            --resolution "${res}" \\
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
            --contactType "${type}" \\
            --mappabilityThres "${map:-1}" \\
            --biasLowerBound "${lower:-0.01}" \\
            --biasUpperBound "${higher:-1000}" \\
            --lib "$(basename "${file_out}").rDNA_trans" \\
            --visual
        """
    fi

    if ${run_command_4}; then
        fithic \
            --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
            --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
            --outdir "$(pwd)/$(dirname "${file_out}")" \
            --resolution "${res}" \
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
            --contactType "${type}" \
            --mappabilityThres "${map:-1}" \
            --biasLowerBound "${lower:-0.01}" \
            --biasUpperBound "${higher:-1000}" \
            --lib "$(basename "${file_out}").mito-free" \
            --visual

        fithic \
            --interactions "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
            --fragments "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
            --outdir "$(pwd)/$(dirname "${file_out}")" \
            --resolution "${res}" \
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
            --contactType "${type}" \
            --mappabilityThres "${map:-1}" \
            --biasLowerBound "${lower:-0.01}" \
            --biasUpperBound "${higher:-1000}" \
            --lib "$(basename "${file_out}").rDNA_cis" \
            --visual

        #ERROR 2023-1026
        # fithic \
        #     --interactions "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
        #     --fragments "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
        #     --outdir "$(pwd)/$(dirname "${file_out}")" \
        #     --resolution "${res}" \
        #     --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
        #     --contactType "${type}" \
        #     --mappabilityThres "${map:-1}" \
        #     --biasLowerBound "${lower:-0.01}" \
        #     --biasUpperBound "${higher:-1000}" \
        #     --lib "$(basename "${file_out}").rDNA_trans" \
        #     --visual

        fithic \
            --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
            --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
            --outdir "$(pwd)/$(dirname "${file_out}")" \
            --resolution "${res}" \
            --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
            --contactType "interOnly" \
            --mappabilityThres "${map:-1}" \
            --biasLowerBound "${lower:-0.01}" \
            --biasUpperBound "${higher:-1000}" \
            --lib "$(basename "${file_out}").mito-free-interOnly" \
            --visual
    fi

    #  Step #5. Filter significances file to exclude insignificant contacts
    if ${check_command_5}; then
        echo """
        #  Step #5. Filter significances file to exclude insignificant contacts

        filter_significances_file \\
            --input-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.txt.gz" \\
            --output-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \\
            --q-value-threshold "${q:-"0.05"}"
        """
    fi

    if ${run_command_5}; then
        filter_significances_file \
            --input-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.txt.gz" \
            --output-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \
            --q-value-threshold "${q:-"0.05"}"

        filter_significances_file \
            --input-file "$(pwd)/${file_out}.mito-free-interOnly.spline_pass1.res${res}.significances.txt.gz" \
            --output-file "$(pwd)/${file_out}.mito-free-interOnly.spline_pass1.res${res}.significances.filt.txt.gz" \
            --q-value-threshold "${q:-"0.05"}"
    fi

    #  Step #6. Create bedpe "arcs" file from filtered significances file
    if ${check_command_6}; then
        echo """
        #  Step #6. Create bedpe \"arcs\" file from filtered significances file

        create_bedpe_file \\
            -i "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \\
            -o "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.bedpe" \\
            -r "${res}" \\
            -c1 "${c1}" \\
            -c2 "${c2}" \\
            -c3 "${c3}" \\
            -c4 "${c4}" \\
            -c5 "${c5}" \\
            -t1 "${t1}" \\
            -t2 "${t2}" \\
            -t3 "${t3}" \\
            -t4 "${t4}"
        """
    fi

    if ${run_command_6}; then
        create_bedpe_file \
            -i "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \
            -o "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.bedpe" \
            -r "${res}" \
            -c1 "${c1}" \
            -c2 "${c2}" \
            -c3 "${c3}" \
            -c4 "${c4}" \
            -c5 "${c5}" \
            -t1 "${t1}" \
            -t2 "${t2}" \
            -t3 "${t3}" \
            -t4 "${t4}"
    fi

    # #NOTE
    # #  This and accompanying script CombineNearbyInteraction.py need
    # #+ debugging; will be too time-consuming to do this now myself
    # if ${run_command_X}; then
    #     "${HiCKRy}/merge-filter.sh" \
    #         "$(pwd)/${file_out}.spline_pass1.res${res}.significances.txt.gz" \
    #         "${res}" \
    #         "$(pwd)/${file_out}.spline_pass1.res${res}.significances.merge-filter.bed" \
    #         "0.05" \
    #         "/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"
    # fi
    #
    # if ${run_command_X}; then
    #     ${HiCKRy}/visualize-UCSC.sh \
    #         "$(pwd)/${file_out}.spline_pass1.res5000.significances.txt.gz" \
    #         "$(pwd)/${file_out}.spline_pass1.res5000.significances.bed" \
    #         "0.05"
    # fi
fi
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<a id="workflow-test-2023-1026-rdna-cis-and-rdna-trans-interactions-etc"></a>
##### Workflow test 2023-1026: rDNA cis and rDNA trans interactions, etc.
<details>
<summary><i>Printed: Workflow test 2023-1026: rDNA cis and rDNA trans interactions, etc.</i></summary>

```txt
❯ if ${check_command_1}; then
>         echo """
>         #  Step #1. Create FitHiC2 interactions text file
> 
>         create_ia_file \\
>             -c "$(pwd)/${file_in}" \\
>             -o "$(pwd)/${file_out}.ia.txt.gz" \\
>             -m "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
>             -d "$(pwd)/${file_out}.rDNA.ia.txt.gz" \\
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
>             -t "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
>             -r "${region}" \\
>             -s "${scratch}"
>         """
>     fi

#  Step #1. Create FitHiC2 interactions text file

create_ia_file \
    -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
    -m /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    -d /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz \
    -t /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz \
    -r XII-all \
    -s /fh/scratch/delete30/tsukiyama_t


❯ if ${run_command_1}; then
>         create_ia_file \
>             -c "$(pwd)/${file_in}" \
>             -o "$(pwd)/${file_out}.ia.txt.gz" \
>             -m "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
>             -d "$(pwd)/${file_out}.rDNA.ia.txt.gz" \
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
>             -t "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
>             -r "${region}" \
>             -s "${scratch}"
>     fi
Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
Mito-free interactions file Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz was created successfully.
rDNA interactions file Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz was created successfully.
rDNA cis interactions file Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz was created successfully.
rDNA trans interactions file Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz was created successfully.
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz'


❯ if ${check_command_2}; then
>         echo """
>         #  Step #2. Create FitHiC2 fragments text file
> 
>         create_frag_file \\
>             -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
>             -o "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
>             -s "${scratch}"
> 
>         create_frag_file \\
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
>             -o "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
>             -s "${scratch}"
> 
>         create_frag_file \\
>             -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
>             -o "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
>             -s "${scratch}"
>         """
>     fi

#  Step #2. Create FitHiC2 fragments text file

create_frag_file \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
    -s /fh/scratch/delete30/tsukiyama_t

create_frag_file \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz \
    -s /fh/scratch/delete30/tsukiyama_t

create_frag_file \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz \
    -s /fh/scratch/delete30/tsukiyama_t


❯     if ${run_command_2}; then
>         create_frag_file \
>             -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
>             -o "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
>             -s "${scratch}"
> 
>         create_frag_file \
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
>             -o "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
>             -s "${scratch}"
> 
>         create_frag_file \
>             -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
>             -o "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
>             -s "${scratch}"
>     fi
Error: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz already exists.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz was created successfully.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz was created successfully.


❯ if ${check_command_3}; then
>         echo """
>         #  Step #3. Generate bias vector needed to run FitHiC2
> 
>         generate_bias_vector \\
>             -k "${HiCKRy}" \\
>             -p "${HiCKRy_pct}" \\
>             -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
>             -f "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
>             -o "$(pwd)/${file_out}.mito-free.bias.txt.gz"
> 
>         generate_bias_vector \\
>             -k "${HiCKRy}" \\
>             -p "${HiCKRy_pct}" \\
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
>             -f "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
>             -o "$(pwd)/${file_out}.rDNA_cis.bias.txt.gz"
> 
>         generate_bias_vector \\
>             -k "${HiCKRy}" \\
>             -p "${HiCKRy_pct}" \\
>             -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\
>             -f "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
>             -o "$(pwd)/${file_out}.rDNA_trans.bias.txt.gz"
>         """
>     fi

        #  Step #3. Generate bias vector needed to run FitHiC2

        generate_bias_vector \
            -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
            -p 0.05 \
            -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
            -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
            -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz

        generate_bias_vector \
            -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
            -p 0.05 \
            -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz \
            -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz \
            -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.bias.txt.gz

        generate_bias_vector \
            -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
            -p 0.05 \
            -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz \
            -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz \
            -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.bias.txt.gz


❯     if ${run_command_3}; then
>         generate_bias_vector \
>             -k "${HiCKRy}" \
>             -p "${HiCKRy_pct}" \
>             -i "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
>             -f "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
>             -o "$(pwd)/${file_out}.mito-free.bias.txt.gz"
> 
>         generate_bias_vector \
>             -k "${HiCKRy}" \
>             -p "${HiCKRy_pct}" \
>             -i "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
>             -f "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
>             -o "$(pwd)/${file_out}.rDNA_cis.bias.txt.gz"
> 
>         generate_bias_vector \
>             -k "${HiCKRy}" \
>             -p "${HiCKRy_pct}" \
>             -i "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
>             -f "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
>             -o "$(pwd)/${file_out}.rDNA_trans.bias.txt.gz"
>     fi

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 12.839104652404785 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 355 total rows
... corresponds to all bins with less than or equal to 5314.0 total interactions
Sparse rows removed
Initial matrix size: 7108 rows and 7108 columns
New matrix size: 6752 rows and 6752 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz was created successfully.

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 0.015090227127075195 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 31 total rows
... corresponds to all bins with less than or equal to 134.0 total interactions
Sparse rows removed
Initial matrix size: 630 rows and 630 columns
New matrix size: 595 rows and 595 columns
Normalizing with KR Algorithm
/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils/HiCKRy.py:214: RuntimeWarning: invalid value encountered in multiply
  rk -= alpha * w
WARNING... Bias vector has a median outside of typical range (0.5, 2).
Consider running with a larger -x option if problems occur
Mean    0.8888888888888891
Median  0.0
Std. Dev.   7.675991610981016
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.bias.txt.gz was created successfully.

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 0.10389089584350586 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 324 total rows
... corresponds to all bins with less than or equal to 78.0 total interactions
Sparse rows removed
Initial matrix size: 6489 rows and 6489 columns
New matrix size: 6141 rows and 6141 columns
Normalizing with KR Algorithm
/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils/HiCKRy.py:214: RuntimeWarning: invalid value encountered in multiply
  rk -= alpha * w
WARNING... Bias vector has a median outside of typical range (0.5, 2).
Consider running with a larger -x option if problems occur
Mean    0.8927415626444752
Median  0.0
Std. Dev.   25.12599369473249
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.bias.txt.gz was created successfully.


❯ if ${check_command_4}; then
>         echo """
>         #  Step #4. Run FitHiC2
> 
>         fithic \\
>             --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \\
>             --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \\
>             --outdir "$(pwd)/$(dirname "${file_out}")" \\
>             --resolution "${res}" \\
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
>             --contactType "${type}" \\
>             --mappabilityThres "${map:-1}" \\
>             --biasLowerBound "${lower:-0.01}" \\
>             --biasUpperBound "${higher:-1000}" \\
>             --lib "$(basename "${file_out}").mito-free" \\
>             --visual
> 
>         fithic \\
>             --interactions "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \\
>             --fragments "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \\
>             --outdir "$(pwd)/$(dirname "${file_out}")" \\
>             --resolution "${res}" \\
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
>             --contactType "${type}" \\
>             --mappabilityThres "${map:-1}" \\
>             --biasLowerBound "${lower:-0.01}" \\
>             --biasUpperBound "${higher:-1000}" \\
>             --lib "$(basename "${file_out}").rDNA_cis" \\
>             --visual
> 
>         fithic \\
>             --interactions "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \\>             --fragments "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \\
>             --outdir "$(pwd)/$(dirname "${file_out}")" \\
>             --resolution "${res}" \\
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \\
>             --contactType "${type}" \\
>             --mappabilityThres "${map:-1}" \\
>             --biasLowerBound "${lower:-0.01}" \\
>             --biasUpperBound "${higher:-1000}" \\
>             --lib "$(basename "${file_out}").rDNA_trans" \\
>             --visual
>         """
>     fi

#  Step #4. Run FitHiC2

fithic \
    --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
    --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
    --resolution 1600 \
    --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz \
    --contactType All \
    --mappabilityThres 1 \
    --biasLowerBound 0.01 \
    --biasUpperBound 1000 \
    --lib Q.1600.ds-to-Q.XII-all.mito-free \
    --visual

fithic \
    --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz \
    --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz \
    --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
    --resolution 1600 \
    --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz \
    --contactType All \
    --mappabilityThres 1 \
    --biasLowerBound 0.01 \
    --biasUpperBound 1000 \
    --lib Q.1600.ds-to-Q.XII-all.rDNA_cis \
    --visual

fithic \
    --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz \
    --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz \
    --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
    --resolution 1600 \
    --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz \
    --contactType All \
    --mappabilityThres 1 \
    --biasLowerBound 0.01 \
    --biasUpperBound 1000 \
    --lib Q.1600.ds-to-Q.XII-all.rDNA_trans \
    --visual


❯ if ${run_command_4}; then
>         fithic \
>             --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
>             --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
>             --outdir "$(pwd)/$(dirname "${file_out}")" \
>             --resolution "${res}" \
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
>             --contactType "${type}" \
>             --mappabilityThres "${map:-1}" \
>             --biasLowerBound "${lower:-0.01}" \
>             --biasUpperBound "${higher:-1000}" \
>             --lib "$(basename "${file_out}").mito-free" \
>             --visual
> 
>         fithic \
>             --interactions "$(pwd)/${file_out}.rDNA_cis.ia.txt.gz" \
>             --fragments "$(pwd)/${file_out}.rDNA_cis.frag.txt.gz" \
>             --outdir "$(pwd)/$(dirname "${file_out}")" \
>             --resolution "${res}" \
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
>             --contactType "${type}" \
>             --mappabilityThres "${map:-1}" \
>             --biasLowerBound "${lower:-0.01}" \
>             --biasUpperBound "${higher:-1000}" \
>             --lib "$(basename "${file_out}").rDNA_cis" \
>             --visual
> 
>         fithic \
>             --interactions "$(pwd)/${file_out}.rDNA_trans.ia.txt.gz" \
>             --fragments "$(pwd)/${file_out}.rDNA_trans.frag.txt.gz" \
>             --outdir "$(pwd)/$(dirname "${file_out}")" \
>             --resolution "${res}" \
>             --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
>             --contactType "${type}" \
>             --mappabilityThres "${map:-1}" \
>             --biasLowerBound "${lower:-0.01}" \
>             --biasUpperBound "${higher:-1000}" \
>             --lib "$(basename "${file_out}").rDNA_trans" \
>             --visual
>     fi


GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.mito-free
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 1000.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 17.316243410110474
Fragments file read. Time took 0.027140140533447266
Bias file read. Time took 0.03644394874572754
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.png
Outlier threshold is... 7.757360319224687e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.qplot.png
Number of outliers is... 958
Spline fit Pass 1 completed. Time took 219.77434730529785
=========================
Fit-Hi-C completed successfully




GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.rDNA_cis
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 1000.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 0.02396225929260254
Fragments file read. Time took 0.0023956298828125
Bias file read. Time took 0.03566288948059082
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.spline_pass1.png
Outlier threshold is... 2.523086239087652e-06
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_cis.spline_pass1.qplot.png
Number of outliers is... 147
Spline fit Pass 1 completed. Time took 0.9341726303100586
=========================
Fit-Hi-C completed successfully




GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.rDNA_trans
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 1000.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 0.12334752082824707
Fragments file read. Time took 0.020450830459594727
Bias file read. Time took 0.035367727279663086
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA_trans.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Traceback (most recent call last):
  File "/home/kalavatt/miniconda3/envs/fithic_env/bin/fithic", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/home/kalavatt/miniconda3/envs/fithic_env/lib/python3.12/site-packages/fithic/fithic.py", line 342, in main
    splineXinit,splineYinit,residual,outliersline, outliersdist, FDRXinit, FDRYinit= fit_Spline(mainDic,x,y,yerr,contactCountsFile,os.path.join(outputPath,libName+".spline_pass1"),biasDic, outliersline, outliersdist, observedIntraInRangeSum, possibleIntraInRangeCount, possibleInterAllCount, observedInterAllCount, observedIntraAllSum, observedInterAllSum, biasLowerBound, biasUpperBound, resolution, 1)
                                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/kalavatt/miniconda3/envs/fithic_env/lib/python3.12/site-packages/fithic/fithic.py", line 948, in fit_Spline
    splineError=min(y)*min(y)
                ^^^^^^
ValueError: min() iterable argument is empty


❯ fithic \
>     --interactions "$(pwd)/${file_out}.mito-free.ia.txt.gz" \
>     --fragments "$(pwd)/${file_out}.mito-free.frag.txt.gz" \
>     --outdir "$(pwd)/$(dirname "${file_out}")" \
>     --resolution "${res}" \
>     --biases "$(pwd)/${file_out}.mito-free.bias.txt.gz" \
>     --contactType "interOnly" \
>     --mappabilityThres "${map:-1}" \
>     --biasLowerBound "${lower:-0.01}" \
>     --biasUpperBound "${higher:-1000}" \
>     --lib "$(basename "${file_out}").mito-free-interOnly" \
>     --visual


GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.mito-free-interOnly
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
Only inter-chromosomal regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 1000.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 17.42413353919983
Fragments file read. Time took 0.02554631233215332
Bias file read. Time took 0.0312657356262207
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free-interOnly.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Outlier threshold is... 1.1026203220643699e-07
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free-interOnly.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free-interOnly.spline_pass1.qplot.png
Number of outliers is... 131852
Spline fit Pass 1 completed. Time took 195.40946793556213
=========================
Fit-Hi-C completed successfully


❯ filter_significances_file \
>     --input-file "$(pwd)/${file_out}.mito-free-interOnly.spline_pass1.res${res}.significances.txt.gz" \
>     --output-file "$(pwd)/${file_out}.mito-free-interOnly.spline_pass1.res${res}.significances.filt.txt.gz" \
>     --q-value-threshold "${q:-"0.05"}"
Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free-interOnly.spline_pass1.res1600.significances.filt.txt.gz was created successfully.
```
</details>
<br />

<a id="workflow-test-2023-1026-mito-free-and-rdna-interactions-etc"></a>
##### Workflow test 2023-1026: mito-free and rDNA interactions, etc.
<details>
<summary><i>Printed: Workflow test 2023-1026: mito-free and rDNA (cis and trans) interactions, etc.</i></summary>

```txt
#  Step #1. Create FitHiC2 interactions text file

create_ia_file \
    -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
    -m /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    -d /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz \
    -r XII-all \
    -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
Mito-free interactions file Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz was created successfully.
rDNA interactions file Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz was created successfully.
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz'


#  Step #2. Create FitHiC2 fragments text file

create_frag_file \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
    -s /fh/scratch/delete30/tsukiyama_t

create_frag_file \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz \
    -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz was created successfully.

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz was created successfully.


#  Step #3. Generate bias vector needed to run FitHiC2

generate_bias_vector \
    -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
    -p 0.05 \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
    -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz

generate_bias_vector \
    -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
    -p 0.05 \
    -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz \
    -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz \
    -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 11.376466751098633 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 355 total rows
... corresponds to all bins with less than or equal to 5314.0 total interactions
Sparse rows removed
Initial matrix size: 7108 rows and 7108 columns
New matrix size: 6752 rows and 6752 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz was created successfully.

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 0.11100339889526367 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 355 total rows
... corresponds to all bins with less than or equal to 79.0 total interactions
Sparse rows removed
Initial matrix size: 7108 rows and 7108 columns
New matrix size: 6721 rows and 6721 columns
Normalizing with KR Algorithm
/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils/HiCKRy.py:214: RuntimeWarning: invalid value encountered in multiply
  rk -= alpha * w
WARNING... Bias vector has a median outside of typical range (0.5, 2).
Consider running with a larger -x option if problems occur
Mean    0.8911086100168822
Median  0.0
Std. Dev.   26.24067074100285
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.bias.txt.gz was created successfully.


#  Step #4. Run FitHiC2

fithic \
--interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz \
--fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz \
--outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
--resolution 1600 \
--biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz \
--contactType All \
--mappabilityThres 1 \
--biasLowerBound 0.01 \
--biasUpperBound 100 \
--lib Q.1600.ds-to-Q.XII-all.mito-free \
--visual

fithic \
--interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz \
--fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz \
--outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
--resolution 1600 \
--biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz \
--contactType All \
--mappabilityThres 1 \
--biasLowerBound 0.01 \
--biasUpperBound 100 \
--lib Q.1600.ds-to-Q.XII-all.rDNA \
--visual

GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.mito-free
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 15.934495210647583
Fragments file read. Time took 0.025197505950927734
Bias file read. Time took 0.0332791805267334
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.png
Outlier threshold is... 7.757360319224687e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.spline_pass1.qplot.png
Number of outliers is... 958
Spline fit Pass 1 completed. Time took 201.2330722808838
=========================
Fit-Hi-C completed successfully




GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.mito-free.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all.rDNA
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 0.13882851600646973
Fragments file read. Time took 0.024142742156982422
Bias file read. Time took 0.03300976753234863
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.spline_pass1.png
Outlier threshold is... 2.5714357714487317e-07
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.rDNA.spline_pass1.qplot.png
Number of outliers is... 4717
Spline fit Pass 1 completed. Time took 2.0850911140441895
=========================
Fit-Hi-C completed successfully
```
</details>
<br />

<a id="run-workflow-proper"></a>
### Run workflow proper
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Run workflow proper</i></summary>

```bash
#!/bin/bash

#  Execute main (test) tasks ==================================================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source initial work environment that allows access to cooler
activate_env pairtools_env


#  Set up necessary variables and arrays ------------------
check_variables=true
check_array=false
debug=false

run_env_change_1=false

check_command_1=false
run_command_1=false

check_command_2=false
run_command_2=false

run_env_change_2=true

check_command_3=false
run_command_3=false

check_command_4=true
run_command_4=true

check_command_5=true
run_command_5=true

check_command_6=true
run_command_6=true

unset A_dirs a_dirs A_prefix a_prefix
typeset -A A_dirs A_prefix
typeset -a a_dirs a_prefix

a_dirs=(
    "11_cooler_genome_KR-filt-0.4_whole-matrix"
    # "11_cooler_XII_KR-filt-0.4"
)

A_dirs=(
    ["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"
    # ["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"
)

a_prefix=(
    "MC-2019_Q_WT_repM"
    "MC-2020_30C-a15_WT_repM"
    "MC-2020_nz_WT_repM"
)

A_prefix=(
    ["MC-2019_Q_WT_repM"]="Q"
    ["MC-2020_30C-a15_WT_repM"]="G1"
    ["MC-2020_nz_WT_repM"]="G2"
)

if ${check_array}; then
    for i in "${a_dirs[@]}"; do
          key="${i}"
        value="${A_dirs[${key}]}"

        echo """
          key  ${key}
        value  ${value}
        """
    done
fi

if ${check_array}; then
    for i in "${a_prefix[@]}"; do
          key="${i}"
        value="${A_prefix[${key}]}"

        echo """
          key  ${key}
        value  ${value}
        """
    done
fi

# unset resolutions && typeset -a resolutions=(5000)
# unset resolutions && typeset -a resolutions=(1600 3200)
unset resolutions && typeset -a resolutions=(1600)

# unset regions && typeset -a regions=("genome-trans")
# unset regions && typeset -a regions=("XII-cis")
unset regions && typeset -a regions=("XII-all")

scratch="/fh/scratch/delete30/tsukiyama_t"
HiCKRy="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"
HiCKRy_pct=0.05

c1="255,0,0"
c2="255,255,0"
c3="0,255,0"
c4="0,255,255"
c5="0,0,255"
t1=5
t2=10
t3=50
t4=100


#  Dynamically run commands -------------------------------
iter=0
for dir_in in "${a_dirs[@]}"; do
    # dir_in=${a_dirs[0]}                                           # echo "${dir_in}"
    dir_out="${A_dirs[${dir_in}]}"                                  # echo "${dir_out}"

    [[ ${debug} == true ]] && echo "dir_out=${dir_out}"

    for phase in "${a_prefix[@]}"; do
        # phase="${a_prefix[0]}"                                    # echo "${phase}"
        prefix="${A_prefix[${phase}]}"                              # echo "${prefix}"

        [[ ${debug} == true ]] \
            && echo -e "key\t${phase}\nvalue\t${prefix}\n"

        for res in "${resolutions[@]}"; do
            # res="${resolutions[0]}"                               # echo "${res}"

            file_in=$(
                find \
                    "${dir_in}" \
                    -maxdepth 1 \
                    -type f \
                    -name "${phase}*.${res}.*cool"
                )                                                   # echo "${file_in}"

            for region in "${regions[@]}"; do
                # region="${regions[0]}"                            # echo "${region}"
                if [[ "${region}" == "XII-cis" ]]; then
                    type="intraOnly"                                # echo "${type}"
                elif [[ "${region}" == "XII-all" ]]; then
                    type="All"                                      # echo "${type}"
                elif [[ "${region}" == "genome-trans" ]]; then
                    type="interOnly"                                # echo "${type}"
                fi
            
                if [[ "${file_in}" =~ "${phase}" ]]; then
                    file_out="$(
                        echo "${file_in%.cool}" \
                            | sed -E -e 's:11_cooler:13_FitHiC2:g' \
                                     -e 's:.standard-rDNA-complete.mapped::g' \
                                     -e 's:downsample:ds:g' \
                                     -e "s:${phase}:${prefix}:g"
                    ).${region}"                                    # echo "${file_out}"
                fi
                
                (( iter++ ))

                if ${check_variables}; then
                    echo """
                    iter .............................. ${iter}
                    dir_in ............................ ${dir_in}
                    dir_out ........................... ${dir_out}
                    phase ............................. ${phase}
                    prefix ............................ ${prefix}
                    resolution ........................ ${res}
                    region ............................ ${region}
                    type .............................. ${type}
                    file_in ........................... ${file_in}
                    file_out .......................... ${file_out}
                    scratch ........................... ${scratch}
                    HiCKRy ............................ ${HiCKRy}
                    HiCKRy_pct ........................ ${HiCKRy_pct}
                    """
                fi

                #  ----------------------------------------
                #  Drawing on the the above, submit 
                #+ specific steps of the workflow to the
                #+ job scheduler
                #  ----------------------------------------
                #  Step #1. Create FitHiC2 interactions text file
                [[ ${run_env_change_1} == true ]] \
                    && activate_env pairtools_env \
                    || true

                if ${check_command_1}; then
                    echo """
                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \\
                        -c "$(pwd)/${file_in}" \\
                        -o "$(pwd)/${file_out}.ia.txt.gz" \\
                        -r "${region}" \\
                        -s "${scratch}"
                    """
                fi

                if ${run_command_1}; then
                    create_ia_file \
                        -c "$(pwd)/${file_in}" \
                        -o "$(pwd)/${file_out}.ia.txt.gz" \
                        -r "${region}" \
                        -s "${scratch}"
                fi


                #  Step #2. Create FitHiC2 fragments text file
                if ${check_command_2}; then
                    echo """
                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \\
                        -i "$(pwd)/${file_out}.ia.txt.gz" \\
                        -o "$(pwd)/${file_out}.frag.txt.gz" \\
                        -s "${scratch}"
                    """
                fi

                if ${run_command_2}; then
                    create_frag_file \
                        -i "$(pwd)/${file_out}.ia.txt.gz" \
                        -o "$(pwd)/${file_out}.frag.txt.gz" \
                        -s "${scratch}"
                fi


                #  Step #3. Generate bias vector needed to run FitHiC2
                [[ ${run_env_change_2} == true ]] \
                    && activate_env fithic_env \
                    || true

                if ${check_command_3}; then
                    echo """
                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \\
                        -k "${HiCKRy}" \\
                        -p "${HiCKRy_pct}" \\
                        -i "$(pwd)/${file_out}.ia.txt.gz" \\
                        -f "$(pwd)/${file_out}.frag.txt.gz" \\
                        -o "$(pwd)/${file_out}.bias.txt.gz"
                    """
                fi

                if ${run_command_3}; then
                    generate_bias_vector \
                        -k "${HiCKRy}" \
                        -p "${HiCKRy_pct}" \
                        -i "$(pwd)/${file_out}.ia.txt.gz" \
                        -f "$(pwd)/${file_out}.frag.txt.gz" \
                        -o "$(pwd)/${file_out}.bias.txt.gz"
                fi


                #  Step #4. Run FitHiC2
                if ${check_command_4}; then
                    echo """
                    #  Step #4. Run FitHiC2

                    fithic \\
                        --interactions "$(pwd)/${file_out}.ia.txt.gz" \\
                        --fragments "$(pwd)/${file_out}.frag.txt.gz" \\
                        --outdir "$(pwd)/$(dirname "${file_out}")" \\
                        --resolution "${res}" \\
                        --biases "$(pwd)/${file_out}.bias.txt.gz" \\
                        --contactType "${type}" \\
                        --mappabilityThres "${map:-1}" \\
                        --biasLowerBound "${lower:-0.01}" \
                        --biasUpperBound "${higher:-100}" \
                        --lib "$(basename "${file_out}")" \\
                        --visual
                    """
                fi

                if ${run_command_4}; then
                    fithic \
                        --interactions "$(pwd)/${file_out}.ia.txt.gz" \
                        --fragments "$(pwd)/${file_out}.frag.txt.gz" \
                        --outdir "$(pwd)/$(dirname "${file_out}")" \
                        --resolution "${res}" \
                        --biases "$(pwd)/${file_out}.bias.txt.gz" \
                        --contactType "${type}" \
                        --mappabilityThres "${map:-1}" \
                        --biasLowerBound "${lower:-0.01}" \
                        --biasUpperBound "${higher:-100}" \
                        --lib "$(basename "${file_out}")" \
                        --visual
                fi

                #  Step #5. Filter significances file to exclude insignificant contacts
                if ${check_command_5}; then
                    echo """
                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \\
                        --input-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.txt.gz" \\
                        --output-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \\
                        --q-value-threshold "${q:-"0.05"}"
                    """
                fi

                if ${run_command_5}; then
                    filter_significances_file \
                        --input-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.txt.gz" \
                        --output-file "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \
                        --q-value-threshold "${q:-"0.05"}"
                fi

                #  Step #6. Create bedpe "arcs" file from filtered significances file
                if ${check_command_6}; then
                    echo """
                    #  Step #6. Create bedpe \"arcs\" file from filtered significances file

                    create_bedpe_file \\
                        -i "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \\
                        -o "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.bedpe" \\
                        -r "${res}" \\
                        -c1 "${c1}" \\
                        -c2 "${c2}" \\
                        -c3 "${c3}" \\
                        -c4 "${c4}" \\
                        -c5 "${c5}" \\
                        -t1 "${t1}" \\
                        -t2 "${t2}" \\
                        -t3 "${t3}" \\
                        -t4 "${t4}"
                    """
                fi

                if ${run_command_6}; then
                    create_bedpe_file \
                        -i "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.txt.gz" \
                        -o "$(pwd)/${file_out}.spline_pass1.res${res}.significances.filt.bedpe" \
                        -r "${res}" \
                        -c1 "${c1}" \
                        -c2 "${c2}" \
                        -c3 "${c3}" \
                        -c4 "${c4}" \
                        -c5 "${c5}" \
                        -t1 "${t1}" \
                        -t2 "${t2}" \
                        -t3 "${t3}" \
                        -t4 "${t4}"
                fi
            done
            
            sleep 0.2
        done
    done
done
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<a id="run-workflow-test-2023-1025-steps-1ndash3"></a>
##### Run workflow test, 2023-1025: Steps #1&ndash;3
<details>
<summary><i>Printed: Run workflow test, 2023-1025: Steps #1&ndash;3</i></summary>

```txt

                    iter .............................. 1
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2019_Q_WT_repM
                    prefix ............................ Q
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 11.391151428222656 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 356 total rows
... corresponds to all bins with less than or equal to 5285.0 total interactions
Sparse rows removed
Initial matrix size: 7132 rows and 7132 columns
New matrix size: 6775 rows and 6775 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.

                    iter .............................. 2
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2020_30C-a15_WT_repM
                    prefix ............................ G1
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 9.47139048576355 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 356 total rows
... corresponds to all bins with less than or equal to 7399.0 total interactions
Sparse rows removed
Initial matrix size: 7136 rows and 7136 columns
New matrix size: 6778 rows and 6778 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.

                    iter .............................. 3
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2020_nz_WT_repM
                    prefix ............................ G2
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 3.9702727794647217 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 354 total rows
... corresponds to all bins with less than or equal to 6279.0 total interactions
Sparse rows removed
Initial matrix size: 7095 rows and 7095 columns
New matrix size: 6740 rows and 6740 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.

                    iter .............................. 4
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2019_Q_WT_repM
                    prefix ............................ Q
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/Q.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 11.281103134155273 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 356 total rows
... corresponds to all bins with less than or equal to 5285.0 total interactions
Sparse rows removed
Initial matrix size: 7132 rows and 7132 columns
New matrix size: 6775 rows and 6775 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.

                    iter .............................. 5
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2020_30C-a15_WT_repM
                    prefix ............................ G1
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/G1.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 9.580523014068604 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 356 total rows
... corresponds to all bins with less than or equal to 7399.0 total interactions
Sparse rows removed
Initial matrix size: 7136 rows and 7136 columns
New matrix size: 6778 rows and 6778 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.

                    iter .............................. 6
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2020_nz_WT_repM
                    prefix ............................ G2
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #1. Create FitHiC2 interactions text file

                    create_ia_file \
                        -c /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -r XII-all \
                        -s /fh/scratch/delete30/tsukiyama_t

Note: The option '-r genome-trans' is used. Interactions will be extracted for the entire genome.
'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool' -> '/fh/scratch/delete30/tsukiyama_t/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool'
'/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz'
Interactions file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz was created successfully.

                    #  Step #2. Create FitHiC2 fragments text file

                    create_frag_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -s /fh/scratch/delete30/tsukiyama_t

'/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz' -> '/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.ia.txt.gz'
'/fh/scratch/delete30/tsukiyama_t/G2.1600.ds-to-Q.XII-all.frag.txt.gz' -> '/home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz'
Fragment file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz was created successfully.

                    #  Step #3. Generate bias vector needed to run FitHiC2

                    generate_bias_vector \
                        -k /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils \
                        -p 0.05 \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        -f /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.bias.txt.gz

Python 3 is installed and accessible.
Creating sparse matrix...
Sparse matrix creation took 4.009113311767578 seconds
Removing 0.05 percent of most sparse bins
... corresponds to 354 total rows
... corresponds to all bins with less than or equal to 6279.0 total interactions
Sparse rows removed
Initial matrix size: 7095 rows and 7095 columns
New matrix size: 6740 rows and 6740 columns
Normalizing with KR Algorithm
Bias vector file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.bias.txt.gz was created successfully.
```
</details>
<br />

<a id="run-workflow-test-2023-1025-steps-4ndash6"></a>
##### Run workflow test, 2023-1025: Steps #4&ndash;6
<details>
<summary><i>Printed: Run workflow test, 2023-1025: Steps #4&ndash;6</i></summary>

```txt

                    iter .............................. 1
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2019_Q_WT_repM
                    prefix ............................ Q
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4 \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib Q.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 16.06958246231079
Fragments file read. Time took 0.023310184478759766
Bias file read. Time took 0.031537771224975586
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 7.726765500239298e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 1071
Spline fit Pass 1 completed. Time took 198.78543329238892
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100

Bedpe file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe was created successfully.

                    iter .............................. 2
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2020_30C-a15_WT_repM
                    prefix ............................ G1
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4 \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib G1.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be G1.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 13.691163301467896
Fragments file read. Time took 0.028168678283691406
Bias file read. Time took 0.03262066841125488
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 8.790048891130938e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 6999
Spline fit Pass 1 completed. Time took 160.0023512840271
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100

Bedpe file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe was created successfully.

                    iter .............................. 3
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4
                    phase ............................. MC-2020_nz_WT_repM
                    prefix ............................ G2
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4 \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib G2.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be G2.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 6.770993232727051
Fragments file read. Time took 0.02229619026184082
Bias file read. Time took 0.033159494400024414
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 1.5944327510518074e-07
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 13010
Spline fit Pass 1 completed. Time took 69.7379560470581
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100

Bedpe file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe was created successfully.

                    iter .............................. 4
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2019_Q_WT_repM
                    prefix ............................ Q
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib Q.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be Q.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 16.48289680480957
Fragments file read. Time took 0.025760650634765625
Bias file read. Time took 0.033824920654296875
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 7.726765500239298e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 1071
Spline fit Pass 1 completed. Time took 199.35660862922668
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100

Bedpe file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/Q.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe was created successfully.

                    iter .............................. 5
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2020_30C-a15_WT_repM
                    prefix ............................ G1
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib G1.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be G1.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 13.65437388420105
Fragments file read. Time took 0.025987625122070312
Bias file read. Time took 0.03322243690490723
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 8.790048891130938e-08
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 6999
Spline fit Pass 1 completed. Time took 160.57208442687988
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100

Bedpe file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G1.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe was created successfully.

                    iter .............................. 6
                    dir_in ............................ 11_cooler_genome_KR-filt-0.4_whole-matrix
                    dir_out ........................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix
                    phase ............................. MC-2020_nz_WT_repM
                    prefix ............................ G2
                    resolution ........................ 1600
                    region ............................ XII-all
                    type .............................. All
                    file_in ........................... 11_cooler_genome_KR-filt-0.4_whole-matrix/MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.1600.downsample-to-Q.cool
                    file_out .......................... 13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all
                    scratch ........................... /fh/scratch/delete30/tsukiyama_t
                    HiCKRy ............................ /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils
                    HiCKRy_pct ........................ 0.05


                    #  Step #4. Run FitHiC2

                    fithic \
                        --interactions /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz \
                        --fragments /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz \
                        --outdir /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix \
                        --resolution 1600 \
                        --biases /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.bias.txt.gz \
                        --contactType All \
                        --mappabilityThres 1 \
                        --lib G2.1600.ds-to-Q.XII-all \
                        --visual



GIVEN FIT-HI-C ARGUMENTS
=========================
Reading fragments file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.frag.txt.gz
Reading interactions file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.ia.txt.gz
Output path being used from /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix
Fixed size option detected... Fast version of FitHiC will be used
Resolution is 1.6 kb
Reading bias file from: /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.bias.txt.gz
The number of spline passes is 1
The number of bins is 100
The number of reads required to consider an interaction is 1
The name of the library for outputted files will be G2.1600.ds-to-Q.XII-all
Upper Distance threshold is inf
Lower Distance threshold is 0
Graphs will be outputted
All genomic regions will be analyzed
Lower bound of bias values is 0.01
Upper bound of bias values is 100.0
All arguments processed. Running FitHiC now...
=========================


Reading the contact counts file to generate bins...
Interactions file read. Time took 6.4661102294921875
Fragments file read. Time took 0.022500038146972656
Bias file read. Time took 0.03177785873413086
Writing /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.fithic_pass1.res1600.txt
Spline fit Pass 1 starting...
Plotting /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.png
Outlier threshold is... 1.5944327510518074e-07
Writing p-values and q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.significances.txt
Plotting q-values to file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.qplot.png
Number of outliers is... 13010
Spline fit Pass 1 completed. Time took 69.77412819862366
=========================
Fit-Hi-C completed successfully



                    #  Step #5. Filter significances file to exclude insignificant contacts

                    filter_significances_file \
                        --input-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.txt.gz \
                        --output-file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        --q-value-threshold 0.05

Filtered file /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz was created successfully.

                    #  Step #6. Create bedpe "arcs" file from filtered significances file

                    create_bedpe_file \
                        -i /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.txt.gz \
                        -o /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/13_FitHiC2_genome_KR-filt-0.4_whole-matrix/G2.1600.ds-to-Q.XII-all.spline_pass1.res1600.significances.filt.bedpe \
                        -r 1600 \
                        -c1 255,0,0 \
                        -c2 255,255,0 \
                        -c3 0,255,0 \
                        -c4 0,255,255 \
                        -c5 0,0,255 \
                        -t1 5 \
                        -t2 10 \
                        -t3 50 \
                        -t4 100
```
</details>
<br />
<br />

<a id="help-messages"></a>
## Help messages
<a id="printed-4"></a>
### Printed
<details>
<summary><i>Printed: Help messages</i></summary>

```txt
❯ fithic --help
usage: fithic [-h] -i INTERSFILE -f FRAGSFILE -o OUTDIR -r RESOLUTION [-t BIASFILE] [-p NOOFPASSES] [-b NOOFBINS] [-m MAPPABILITYTHRESHOLD] [-l LIBNAME] [-U DISTUPTHRES] [-L DISTLOWTHRES] [-v]
              [-x CONTACTTYPE] [-tL BIASLOWERBOUND] [-tU BIASUPPERBOUND] [-V]

Check the help flag

options:
  -h, --help            show this help message and exit
  -i INTERSFILE, --interactions INTERSFILE
                        REQUIRED: interactions between fragment pairs are read from INTERSFILE
  -f FRAGSFILE, --fragments FRAGSFILE
                        REQUIRED: midpoints (or start indices) of the fragments are read from FRAGSFILE
  -o OUTDIR, --outdir OUTDIR
                        REQUIRED: where the output files will be written
  -r RESOLUTION, --resolution RESOLUTION
                        REQUIRED: If the files are fixed size, please supply the resolution of the dataset here; otherwise, please use a value of 0 if the data is not fixed size.
  -t BIASFILE, --biases BIASFILE
                        RECOMMENDED: biases calculated by ICE or KR norm for each locus are read from BIASFILE
  -p NOOFPASSES, --passes NOOFPASSES
                        OPTIONAL: number of spline passes to run Default is 1
  -b NOOFBINS, --noOfBins NOOFBINS
                        OPTIONAL: number of equal-occupancy (count) bins. Default is 100
  -m MAPPABILITYTHRESHOLD, --mappabilityThres MAPPABILITYTHRESHOLD
                        OPTIONAL: minimum number of hits per locus that has to exist to call it mappable. DEFAULT is 1.
  -l LIBNAME, --lib LIBNAME
                        OPTIONAL: Name of the library that is analyzed to be used for name of file prefixes . DEFAULT is fithic
  -U DISTUPTHRES, --upperbound DISTUPTHRES
                        OPTIONAL: upper bound on the intra-chromosomal distance range (unit: base pairs). DEFAULT no limit. STRONGLY suggested to have a limit for large genomes, such as human/mouse.
                        ex. '1000000, 5000000, etc.'
  -L DISTLOWTHRES, --lowerbound DISTLOWTHRES
                        OPTIONAL: lower bound on the intra-chromosomal distance range (unit: base pairs). DEFAULT no limit. Suggested limit is 2x the resolution of the input files
  -v, --visual          OPTIONAL: use this flag for generating plots. DEFAULT is False.
  -x CONTACTTYPE, --contactType CONTACTTYPE
                        OPTIONAL: use this flag to determine which chromosomal regions to study (intraOnly, interOnly, All) DEFAULT is intraOnly
  -tL BIASLOWERBOUND, --biasLowerBound BIASLOWERBOUND
                        OPTIONAL: this flag is used to determine the lower bound of bias values to discard. DEFAULT is 0.5
  -tU BIASUPPERBOUND, --biasUpperBound BIASUPPERBOUND
                        OPTIONAL: this flag is used to determine the upper bound of bias values to discard. DEFAULT is 2
  -V, --version         Print version and exit
```
</details>
<br />
