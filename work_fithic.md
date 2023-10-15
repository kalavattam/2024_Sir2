
`work_fithic.md`
<br />
<br />

## Install `FitHiC` environments
### Create a KrisMac `FitHiC` environment
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

### Create a `rhino`/`gizmo` `FitHiC` environment
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
```
</details>
<br />
<br />

## Establish and run workflow for `FitHiC` analyses
### Code
<details>
<summary><i>Code: Establish and run workflow for `FitHiC` analyses</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
function change_dir() {
    local dir="${1}"

    if [[ -z "${dir}" ]]; then
        echo "Error: No directory provided."
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
    if [[ "${CONDA_DEFAULT_ENV}" != "${env}" ]]; then
        if [[ ${CONDA_DEFAULT_ENV} != base ]]; then
            conda deactivate
        fi

        source activate "${env}"
    fi
}


function check_requirements() {
    local requirements=("$@")
    local tag="is not installed or not in the system's PATH"

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
    if ! command -v python &> /dev/null; then
        echo "Error: Python is not installed or not in the system's PATH."
        return 1
    fi

    if [[ "$(python -c 'import sys; print(sys.version_info[0])')" -ne 3 ]]; then
        echo "Error: Python 3 is required."
        return 1
    fi

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
        
Creates a FitHiC2 interactions file from a given .cool file. 
If a region is specified, interactions are extracted for that region only.
Operations can optionally be performed in a specified scratch directory.

Options:
  -h, --help         Display this help message
  -c, --cool-file    Specify the .cool file
  -o, --out-file     Specify the output file
  -r, --region       Specify the region (optional)
  -s, --scratch-dir  Specify a scratch directory (optional)

Dependencies:
  cooler: Required for processing .cool files

Example #1:
  create_ia_file \\
      -c some.cool \\
      -o some_ia.txt

Example #2:
  create_ia_file \\
      -c another.cool \\
      -o another_ia.txt \\
      -r I \\
      -s /path/to/scratch

Note:
  The output file will be in bedpe format.

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
            -r|--region) region="${2}"; shift 2 ;;
            -s|--scratch-dir) scratch="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    if ! check_requirements cooler; then return 1; fi
    if ! check_files "exist" "${cool}"; then return 1; fi
    if ! check_files "not_exist" "${out}"; then return 1; fi

    local region_option=""
    if [[ -n "${region}" ]]; then
        local region_option="--join -r ${region}"
    else
        local region_option="--join"
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

Options:
  -h, --help         Display this help message
  -i, --ia-file      Specify the interactions file
  -o, --out-file     Specify the output file
  -s, --scratch-dir  Specify a scratch directory (optional)

Dependencies:
  bash utilities awk, gunzip, and sort: Required for processing, sorting data

Example #1:
  create_frag_file \\
      -i some_ia.txt.gz \\
      -o some_frag.txt.gz

Example #2:
  create_frag_file \\
      -i another_ia.txt.gz \\
      -o another_frag.txt.gz \\
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


generate_bias_vec() {
    local pct=0.05
    local hickry=""
    local ia=""
    local frag=""
    local out=""
    local help=$(
cat << EOM
Usage: generate_bias_vec -p PERCENTILE -i INT_FILE -f FRAG_FILE -o OUT_FILE -k HICKRY_PATH
        
Generates a bias vector file using FitHiC2's HiCKRy.py.

Options:
  -h, --help         Display this help message
  -k, --hickry-path  Specify the path to HiCKRy.py
  -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
  -i, --ia-file      Specify the interactions file
  -f, --frag-file    Specify the fragment file
  -o, --out-file     Specify the output file

Dependencies:
  - Python
  - HiCKRy.py

Example:
  generate_bias_vec \\
      -k /path/to/HiCKRy.py \\
      -p 0.05 \\
      -i some_ia.txt.gz \\
      -f some_frag.txt.gz \\
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


main() {
    local region=""
    local cool=""
    local pct=0.05  # Default value
    local ia=""
    local frag=""
    local out=""
    local hickry=""
    local scratch=""
    local help=$(
cat << EOM
Usage: main -c COOL_FILE -i IA_FILE -f FRAG_FILE -o OUT_FILE -H HICKRY_PATH \\
  [-p PERCENT] [-r REGION] [-s SCRATCH_DIR]
        
This function integrates the creation of interaction and fragment files, the
generation of a bias vector, and other functionalities.

Options:
  -h, --help         Display this help message
  -c, --cool-file    Specify the .cool file
  -i, --ia-file      Specify the interactions file
  -f, --frag-file    Specify the fragment file
  -o, --out-file     Specify the output file for bias vector
  -H, --hickry-path  Specify the path to HiCKRy.py
  -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
  -r, --region       Specify the region (optional)
  -s, --scratch-dir  Specify a scratch directory (optional)

Example #1:
  main \\
      -c some.cool \\
      -i some_ia.txt \\
      -f some_frag.txt \\
      -o some_bias.txt \\
      -H /path/to/HiCKRy.py

Example #2:
  main \\
      -c another.cool \\
      -i another_ia.txt \\
      -f another_frag.txt \\
      -o another_bias.txt \\
      -H /path/to/HiCKRy.py \\
      -p 0.10 \\
      -r XII \\
      -s /path/to/scratch
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -c|--cool-file) cool="${2}"; shift 2 ;;
            -i|--ia-file) ia="${2}"; shift 2 ;;
            -f|--frag-file) frag="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            -H|--hickry-path) hickry="${2}"; shift 2 ;;
            -p|--percent) pct="${2}"; shift 2 ;;
            -r|--region) region="${2}"; shift 2 ;;
            -s|--scratch-dir) scratch="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    # Validate required parameters
    if [[ -z "${cool}" ]]; then
        echo "Error: Missing .cool file. Use -c or --cool-file to specify it."
        local missing_params=true
    fi

    if [[ -z "${ia}" ]]; then
        echo "Error: Missing interactions file. Use -i or --ia-file to specify it."
        local missing_params=true
    fi

    if [[ -z "${frag}" ]]; then
        echo "Error: Missing fragment file. Use -f or --frag-file to specify it."
        local missing_params=true
    fi

    if [[ -z "${out}" ]]; then
        echo "Error: Missing output file for bias vector. Use -o or --out-file to specify it."
        local missing_params=true
    fi

    if [[ -z "${hickry}" ]]; then
        echo "Error: Missing path to HiCKRy.py. Use -H or --hickry-path to specify it."
        local missing_params=true
    fi

    if ${missing_params}; then echo "${help}"; return 1; fi

    # Create interactions file
    if ! create_ia_file -c "${cool}" -o "${ia}" -r "${region}"; then
        echo "Error: Failed to create interactions file."
        return 1
    fi

    # Create fragments file
    if ! create_frag_file -i "${ia}" -o "${frag}" -s "${scratch}"; then
        echo "Error: Failed to create fragment file."
        return 1
    fi

    # Generate bias vector values
    if ! generate_bias_vec -H "${hickry}" -p "${pct}" -i "${ia}" -f "${frag}" -o "${out}"; then
        echo "Error: Failed to generate bias vector."
        return 1
    fi

    echo "All tasks completed successfully."
    return 0
}


#  Configure work environment, directories, and variables =====================
unset A_dirs && typeset -A A_dirs
unset a_dirs && typeset -a a_dirs
A_dirs["11_cooler_genome_KR-filt-0.4"]="13_FitHiC2_genome_KR-filt-0.4"; a_dirs+=( "11_cooler_genome_KR-filt-0.4" )
A_dirs["11_cooler_genome_KR-filt-0.4_whole-matrix"]="13_FitHiC2_genome_KR-filt-0.4_whole-matrix"; a_dirs+=( "11_cooler_genome_KR-filt-0.4_whole-matrix" )
A_dirs["11_cooler_XII_KR-filt-0.4"]="13_FitHiC2_XII_KR-filt-0.4"; a_dirs+=( "11_cooler_XII_KR-filt-0.4" )

unset A_prefix && typeset -A A_prefix
unset a_prefix && typeset -a a_prefix
A_prefix["MC-2020_30C-a15_WT_repM"]="G1"; a_prefix+=( "MC-2020_30C-a15_WT_repM" )
A_prefix["MC-2019_Q_WT_repM"]="Q"; a_prefix+=( "MC-2019_Q_WT_repM" )
A_prefix["MC-2020_nz_WT_repM"]="G2"; a_prefix+=( "MC-2020_nz_WT_repM" )

check_array=false
if $check_array; then
    for key in "${a_dirs[@]}"; do
        echo -e "key\t${key}\nvalue\t${A_dirs[${key}]}\n"
    done
fi

dir_in="${a_dirs[0]}"
dir_out="${A_dirs[${dir_in}]}"
phase="Q"
res=6400
file_in=$(
    find \
        "${dir_in}" \
        -maxdepth 1 \
        -type f \
        -name "MC*${phase}*${res}*cool"
        -name "MC*${res}*cool"
)

for key in "${!A_prefix[@]}"; do  # Corrected this line
    echo -e "key\t${key}\nvalue\t${A_prefix[$key]}\n"

    run_conditional_statement=true
    if ${run_conditional_statement}; then
        if [[ "${file_in}" =~ "${key}" ]]; then
            prefix="${A_prefix[${key}]}"  # Corrected this line
            file_out=$(
                echo "${file_in/.cool/.ia.txt.gz}" \
                    | sed -E -e 's:11_cooler:13_FitHiC2:g' \
                             -e 's:.standard-rDNA-complete.mapped::g' \
                             -e 's:downsample:ds:g' \
                             -e "s:${key}:${prefix}:g"
            )
        fi
    fi
done

check_file_out=false
if ${check_file_out}; then echo "${file_out}"; fi

chr="XII"
scratch="/fh/scratch/delete30/tsukiyama_t"
HiCKRy="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/src/fithic/fithic/utils"
type="intraOnly"

check_variables=true
if ${check_variables}; then
cat << EOC
  dir_in  ${dir_in}
 dir_out  ${dir_out}
   phase  ${phase}
     res  ${res}
 file_in  ${file_in}
file_out  ${file_out}
     chr  ${chr}
 scratch  ${scratch}
  HiCKRy  ${HiCKRy}
    type  ${type}
EOC
fi


#  Execute main tasks =========================================================
# #  Start interactive job
# grabnode  # 1, 20, 1, N

#  Go to work directory
change_dir \
    "${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process"

#  Source work environment containing cooler
activate_env pairtools_env

#  Make outfile directories
for dir in "${!A_dirs[@]}"; do
    if [[ ! -d "${A_dirs[${dir}]}" ]]; then
        mkdir -p "${A_dirs[${dir}]}/err_out"
    else
        echo "Outfile directory ${A_dirs[${dir}]} exists."
    fi
done

#  Step #1. Create FitHiC2 interactions text file
create_ia_file \
    -c "$(pwd)/${file_in}" \
    -o "$(pwd)/${file_out%.ia.txt.gz}.${chr}.ia.txt.gz" \
    -r "${chr}" \
    -s "${scratch}"

#  Step #2. Create FitHiC2 fragments text file
create_frag_file \
    -i "$(pwd)/${file_out%.ia.txt.gz}.${chr}.ia.txt.gz" \
    -o "$(pwd)/${file_out%.ia.txt.gz}.${chr}.frag.txt.gz" \
    -s "${scratch}"

#  Step #3. Generate bias vector needed to run FitHiC2
activate_env fithic_env

generate_bias_vec \
    -k "${HiCKRy}" \
    -p 0.05 \
    -i "$(pwd)/${file_out%.ia.txt.gz}.${chr}.ia.txt.gz" \
    -f "$(pwd)/${file_out%.ia.txt.gz}.${chr}.frag.txt.gz" \
    -o "$(pwd)/${file_out%.ia.txt.gz}.${chr}.bias.txt.gz"

#  Step #4. Run FitHiC2
fithic \
    --interactions "$(pwd)/${file_out%.ia.txt.gz}.${chr}.ia.txt.gz" \
    --fragments "$(pwd)/${file_out%.ia.txt.gz}.${chr}.frag.txt.gz" \
    --outdir "$(pwd)/$(dirname "${file_out}")" \
    --resolution "${res}" \
    --biases "$(pwd)/${file_out%.ia.txt.gz}.${chr}.bias.txt.gz" \
    --contactType "${type}" \
    --mappabilityThres "${map:-1}" \
    --lib "$(basename "${file_out%.ia.txt.gz}").${chr}"
```
</details>
<br />
<br />

## Help messages
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