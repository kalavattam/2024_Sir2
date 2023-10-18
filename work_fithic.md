
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
1. [Establish and run workflow for `FitHiC` analyses](#establish-and-run-workflow-for-fithic-analyses)
    1. [Code](#code)
1. [Help messages](#help-messages)
    1. [Printed](#printed-2)

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

<a id="establish-and-run-workflow-for-fithic-analyses"></a>
## Establish and run workflow for `FitHiC` analyses
<a id="code"></a>
### Code
<details>
<summary><i>Code: Establish and run workflow for `FitHiC` analyses</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
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
    local region=""
    local cool=""
    local out=""
    local scratch=""
    local help=$(
cat << EOM
Usage: create_ia_file -c COOL_FILE -o OUT_FILE [-r REGION] [-s SCRATCH_DIR]
        
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

create_ia_file() checks for required dependencies, validates input files, and
handles errors appropriately.

Options:
  -h, --help         Display this help message
  -c, --cool-file    Specify the .cool file
  -o, --out-file     Specify the output file
  -r, --region       Specify the region (optional); accepts Roman numerals
                     I-XVI; chr:start-end; or "genome-trans", "genome_trans",
                     or "genome" for the entire genome
  -s, --scratch-dir  Specify a scratch directory (optional)

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
      -o another_ia.txt
      -r I
      -s /path/to/scratch

Example #3:
  create_ia_file
      -c and_another.cool
      -o and_another_ia.txt
      -r "genome-trans"
      -s /path/to/scratch

Example #4:
  create_ia_file
      -c other.cool
      -o other_ia.txt
      -r "XII:451000-469000"
      -s /path/to/scratch

FitHiC2 interactions file example (header not in file):
  +-----+------------+-------------+--------------------------+-----------------+
  | chr | extraField | fragmentMid | marginalizedContactCount | mappable? (0/1) |
  +-----+------------+-------------+--------------------------+-----------------+
  |  1  |     0      |    15000    |            234           |        1        |
  |  1  |     0      |    25000    |             0            |        0        |
  | ... |    ...     |     ...     |            ...           |       ...       |
  +-----+------------+-------------+--------------------------+-----------------+
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -c|--cool-file) cool="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
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
    else
        local write_cmd="cat"
    fi

    local out_final="${out}"
    if [[ -n "${scratch}" ]]; then
        if [[ ! -d "${scratch}" || ! -w "${scratch}" ]]; then
            echo "Error: The scratch directory ${scratch} does not exist or is not writable."
            return 1
        fi

        if ! cp "${cool}" "${scratch}/"; then
            echo "Error: Failed to copy ${cool} to the scratch directory ${scratch}."
            return 1
        fi

        local cool="${scratch}/$(basename ${cool})"
        local out="${scratch}/$(basename ${out})"
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

    if [[ -n "${scratch}" ]]; then
        #  Copy outfile from scratch to user-specified storage directory
        if ! cp "${out}" "${out_final}"; then
            echo "Error: Failed to copy the interactions file to the output directory."
            return 1
        fi

        #  Remove specific .cool from the scratch directory
        if [[ -e "${cool}" ]]; then
            if ! rm "${cool}"; then
                echo "Warning: Failed to clean up the cool file ${cool} in the scratch directory."
                echo "         Please remove the file manually."
            fi
        else
            echo "Warning: The cool file ${cool} does not exist in the scratch directory. No cleanup needed."
        fi

        #  Remove specific .bedpe outfile from the scratch directory
        if [[ -e "${out}" ]]; then
            if ! rm "${out}"; then
                echo "Warning: Failed to clean up the interactions file ${out} in the scratch directory."
                echo "         Please remove the file manually."
            fi
        else
            echo "Warning: The interactions file ${out} does not exist in the scratch directory. No cleanup needed."
        fi
    fi

    if [[ $? -eq 0 ]]; then
        echo "Interactions file ${out_final} was created successfully."
        return 0
    else
        echo "Error: Failed to create interactions file."
        return 1
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
      -o some.significances.filtered.txt.gz
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
  -h, --help                Display this help message
  -i, --input-file          Specify the input file
  -o, --output-file         Specify the output bedpe file
  -r, --resolution          Specify the resolution
  -c1, --color-1            Specify the first RGB color (default: 255,0,0 (red))
  -c2, --color-2            Specify the second RGB color (default: 255,255,0 (yellow))
  -c3, --color-3            Specify the third RGB color (default: 0,255,0 (green))
  -c4, --color-4            Specify the fourth RGB color (default: 0,255,255 (cyan))
  -c5, --color-5            Specify the fifth RGB color (default: 0,0,255 (blue))
  -t1, --threshold-1        Specify the first -log10(q) threshold (default: 5; below t1 = c1; above t1 = c2)
  -t2, --threshold-2        Specify the second -log10(q) threshold (default: 10; above t2 = c3)
  -t3, --threshold-3        Specify the third -log10(q) threshold (default: 50; above t3 = c4)
  -t4, --threshold-4        Specify the fourth -log10(q) threshold (default: 100; above t4 = c5)
  -n, --in-region           Specify whether to perform in-region check (default: yes)
  -c, --chromosome          Specify the chromosome for in-region check (default: XII)
  -s, --start               Specify the start position for in-region check (default: 435000)
  -e, --end                 Specify the end position for in-region check (default: 500000)

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


#  Configure work environment, directories, and variables =====================
#  Main code ------------------------------------------------------------------
#  Populate associative arrays ----------------------------
unset A_dirs A_prefix
typeset -A A_dirs A_prefix

A_dirs["11_cooler_genome_KR-filt-0.4"]="13_FitHiC2_genome_KR-filt-0.4"
A_dirs["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"
A_dirs["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"

A_prefix["MC-2020_30C-a15_WT_repM"]="G1"
A_prefix["MC-2019_Q_WT_repM"]="Q"
A_prefix["MC-2020_nz_WT_repM"]="G2"


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
unset resolutions && typeset -a resolutions=(800 1600 3200 5000 6400)
unset regions && typeset -a regions=("XII-cis" "XII-all" "genome-trans")

scratch="/fh/scratch/delete30/tsukiyama_t"
HiCKRy="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"

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


#  Execute main tasks =========================================================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source initial work environment that allows access to cooler
activate_env pairtools_env

#  Set up test parameters
set_up_test_parameters=true
check_variables=true
if ${set_up_test_parameters}; then
    unset A_dirs A_prefix
    typeset -A A_dirs A_prefix
    # A_dirs["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"
    A_dirs["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"
    
    # A_prefix["MC-2019_Q_WT_repM"]="Q"
    # A_prefix["MC-2020_30C-a15_WT_repM"]="G1"
    A_prefix["MC-2020_nz_WT_repM"]="G2"

    # unset resolutions && typeset -a resolutions=(5000)
    unset resolutions && typeset -a resolutions=(1600)

    # unset regions && typeset -a regions=("genome-trans")
    unset regions && typeset -a regions=("XII-cis")

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
                # echo "${file_in}"

                if [[ ! -z "${file_in}" ]]; then
                    for region in "${regions[@]}"; do
                        if [[ "${region}" == "XII-cis" ]]; then
                            type="intraOnly"
                        elif [[ "${region}" == "XII-all" ]]; then
                            type="All"
                        elif [[ "${region}" == "genome-trans" ]]; then
                            type="interOnly"
                            # type="All"
                        fi
                    done

                    for key in "${!A_prefix[@]}"; do
                        prefix="${A_prefix[${key}]}"
                        
                        debug=false
                        [[ ${debug} == true ]] \
                            && echo -e "key\t${key}\nvalue\t${prefix}\n"

                        run_conditional_statement=true
                        if ${run_conditional_statement}; then
                            if [[ "${file_in}" =~ "${key}" ]]; then
                                file_out="$(
                                    echo "${file_in%.cool}" \
                                        | sed -E -e 's:11_cooler:13_FitHiC2:g' \
                                                 -e 's:.standard-rDNA-complete.mapped::g' \
                                                 -e 's:downsample:ds:g' \
                                                 -e "s:${key}:${prefix}:g"
                                ).${region}"
                                # echo "${file_out}"
                            fi
                        fi
                    done

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
                    sleep 0.1
                fi
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


#  Run workflow -------------------------------------------
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

check_command_5=true
run_command_5=true

check_command_6=true
run_command_6=true

run_workflow=true
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
<br />

<a id="help-messages"></a>
## Help messages
<a id="printed-2"></a>
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