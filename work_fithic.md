
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
<br />

## Build workflow for running `FitHiC`
### Initial work
#### Code
<details>
<summary><i>Code: Build workflow for running `FitHiC`: Initial work</i></summary>

```bash
#!/bin/bash

#  For testing, limit the contacts to a small chromosome, e.g., I
chr="${1}"
cool="${2}"
pct="${3}"
res="${4}"
type="${5}"
tmpdir="${6}"
outdir="${7}"
map="${8:=1}"
name="${9}"
dist_up="${10}"
dist_dn="${11}"


#  Create interactions file:
#+ - The second and fifth fields can be any integer; they're' not needed in
#+   most cases.
#+ - The first field is the chromosome name or number.
#+ - The third field is the coordinate of the midpoint of the fragment on that
#+   chromosome.
#+ - The fourth field is the total number of observed mid-range reads (contact
#+   counts) that involve the specified fragment.
#+ - The fields can be separated by space or tab.
#+ - All possible fragments need to be listed in this file.
#+ 
#+ Example (excluding the header, which is not needed in the file):
#+ +-----+------------+-------------+--------------------------+-----------------+
#+ | chr | extraField | fragmentMid | marginalizedContactCount | mappable? (0/1) |
#+ +-----+------------+-------------+--------------------------+-----------------+
#+ |  1  |     0      |    15000    |            234           |        1        |
#+ |  1  |     0      |    25000    |             0            |        0        |
#+ | ... |    ...     |     ...     |            ...           |       ...       |
#+ +-----+------------+-------------+--------------------------+-----------------+
cooler dump --join -r "${chr}" "${cool}" \
    | awk 'BEGIN { OFS="\t"; FS="\t" } { print $1,$2,$4,$5,$7 }' \
    | gzip > "all_int.txt.gz"


#  Create fragments file:
#+ - This file contains a list of mid-range contacts between the
#+   fragments/windows/meta-fragments listed in the above interactions file.
#+ - Each fragment is represented by its chromosome and midpoint coordinate.
#+ - Each line has five fields.
#+ - The first two fields represent the first fragment.
#+ - The following two fields represent the second fragment.
#+ - The fifth field corresponds to the numbers of contacts between the two
#+   fragments.
#+ - The fields can be separated by space or tab.
#+ - Only fragment pairs with non-zero contact counts should be listed in this
#+   file.
#+ 
#+ Example:
#+ +------+--------------+------+--------------+--------------+
#+ | chr1 | fragmentMid1 | chr2 | fragmentMid2 | contactCount |
#+ +------+--------------+------+--------------+--------------+
#+ |  1   |    15000     |  1   |    35000     |      23      |
#+ |  1   |    15000     |  1   |    55000     |      12      |
#+ | ...  |     ...      | ...  |     ...      |      ...     |
#+ +------+--------------+------+--------------+--------------+
zcat "${chr}_int.txt.gz" \
    | awk 'BEGIN { OFS="\t"; FS="\t" } { a[$1"\t0\t"$2]+=$5; a[$3"\t0\t"$4]+=$5; } END { for (coord in a) { print coord, a[coord],1 }}' \
    | sort -k1,2n \
    | gzip > "${chr}_frag.txt.gz"


#  Generate a file of bias vector values for use with FitHiC2
python HiCKRy.py \
    -i "${chr}_int.txt.gz" \
    -f "${chr}_frag.txt.gz" \
    -x "${pct}" \
    -o "${chr}_KRbias.txt.gz"


#  Run FitHiC2
fithic \
    --interactions "${chr}_int.txt.gz" \
    --fragments "${chr}_frag.txt.gz" \
    --outdir "${outdir}" \
    --resolution ${res} \
    --biases "${chr}_KRbias.txt.gz" \
    --contactType "${type}" \
    --mappabilityThres "${map}" \
    --lib "${name}" \
    --upperbound "${dist_up}" \
    --lowerbound "${dist_dn}"


# ❯ fithic --help
# usage: fithic [-h] -i INTERSFILE -f FRAGSFILE -o OUTDIR -r RESOLUTION [-t BIASFILE] [-p NOOFPASSES] [-b NOOFBINS] [-m MAPPABILITYTHRESHOLD] [-l LIBNAME] [-U DISTUPTHRES] [-L DISTLOWTHRES] [-v]
#               [-x CONTACTTYPE] [-tL BIASLOWERBOUND] [-tU BIASUPPERBOUND] [-V]
#
# Check the help flag
#
# options:
#   -h, --help            show this help message and exit
#   -i INTERSFILE, --interactions INTERSFILE
#                         REQUIRED: interactions between fragment pairs are read from INTERSFILE
#   -f FRAGSFILE, --fragments FRAGSFILE
#                         REQUIRED: midpoints (or start indices) of the fragments are read from FRAGSFILE
#   -o OUTDIR, --outdir OUTDIR
#                         REQUIRED: where the output files will be written
#   -r RESOLUTION, --resolution RESOLUTION
#                         REQUIRED: If the files are fixed size, please supply the resolution of the dataset here; otherwise, please use a value of 0 if the data is not fixed size.
#   -t BIASFILE, --biases BIASFILE
#                         RECOMMENDED: biases calculated by ICE or KR norm for each locus are read from BIASFILE
#   -p NOOFPASSES, --passes NOOFPASSES
#                         OPTIONAL: number of spline passes to run Default is 1
#   -b NOOFBINS, --noOfBins NOOFBINS
#                         OPTIONAL: number of equal-occupancy (count) bins. Default is 100
#   -m MAPPABILITYTHRESHOLD, --mappabilityThres MAPPABILITYTHRESHOLD
#                         OPTIONAL: minimum number of hits per locus that has to exist to call it mappable. DEFAULT is 1.
#   -l LIBNAME, --lib LIBNAME
#                         OPTIONAL: Name of the library that is analyzed to be used for name of file prefixes . DEFAULT is fithic
#   -U DISTUPTHRES, --upperbound DISTUPTHRES
#                         OPTIONAL: upper bound on the intra-chromosomal distance range (unit: base pairs). DEFAULT no limit. STRONGLY suggested to have a limit for large genomes, such as human/mouse.
#                         ex. '1000000, 5000000, etc.'
#   -L DISTLOWTHRES, --lowerbound DISTLOWTHRES
#                         OPTIONAL: lower bound on the intra-chromosomal distance range (unit: base pairs). DEFAULT no limit. Suggested limit is 2x the resolution of the input files
#   -v, --visual          OPTIONAL: use this flag for generating plots. DEFAULT is False.
#   -x CONTACTTYPE, --contactType CONTACTTYPE
#                         OPTIONAL: use this flag to determine which chromosomal regions to study (intraOnly, interOnly, All) DEFAULT is intraOnly
#   -tL BIASLOWERBOUND, --biasLowerBound BIASLOWERBOUND
#                         OPTIONAL: this flag is used to determine the lower bound of bias values to discard. DEFAULT is 0.5
#   -tU BIASUPPERBOUND, --biasUpperBound BIASUPPERBOUND
#                         OPTIONAL: this flag is used to determine the upper bound of bias values to discard. DEFAULT is 2
#   -V, --version         Print version and exit


# #  Dump all interactions and process with awk in a single step, avoiding the
# #+ creation of a large temporary file
# cooler dump --join "${cool_file}" \
#     | awk 'BEGIN { OFS="\t"; FS="\t" } { print $1,$2,$4,$5,$7 }' \
#     | gzip > "all_int.txt.gz"
```
</details>
<br />

### Updated work
#### Code
<details>
<summary><i>Code: Build workflow for running `FitHiC`: Updated work</i></summary>

```bash
#!/bin/bash

#  Initialize functions =======================================================
create_ia_file() {
    local region=""
    local cool=""
    local out=""
    local help=$(
cat << EOM
Usage: create_ia_file -c COOL_FILE -o OUT_FILE [-r REGION]
        
Creates an interactions file in bedpe format from a given .cool file. 
If a region is specified, interactions are extracted for that region only.

Options:
  -h, --help       Display this help message
  -c, --cool-file  Specify the .cool file
  -o, --out-file   Specify the output file
  -r, --region     Specify the region (optional)

Dependencies:
  - cooler: Required for processing .cool files

Example:
  create_ia_file \\
      -c some.cool \\
      -o some_ia.txt \\
      -r I

Note:
  The output file will be in bedpe format.
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -c|--cool-file) cool="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            -r|--region) region="${2}"; shift 2 ;;
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    local tag="is not installed or not in the system's PATH"
    if ! command -v cooler &> /dev/null; then
        echo "Error: cooler ${tag}."
        return 1
    fi

    if [[ -z "${cool}" || ! -f "${cool}" ]]; then
        echo "Error: .cool file is required and should exist."
        return 1
    fi

    if [[ -z "${out}" ]]; then
        echo "Error: Output file name is required."
        return 1
    elif [[ -f "${out}" ]]; then
        echo "Error: Output file ${out} already exists."
        return 1
    fi

    local region_option=""
    if [[ -n "${region}" ]]; then
        region_option="--join -r ${region}"
    else
        region_option="--join"
    fi

    if [[ "${out: -3}" == ".gz" ]]; then
        if ! command -v gzip &> /dev/null; then
            echo "Error: gzip ${tag}."
            return 1
        fi
        write_cmd="gzip"
    else
        write_cmd="cat"
    fi

    cooler dump ${region_option} "${cool}" \
        | awk 'BEGIN { 
                OFS="\t";
                FS="\t" 
            } { 
                print $1, $2, $4, $5, $7 
            }' \
        | ${write_cmd} > "${out}"

    if [[ $? -eq 0 ]]; then
        echo "Interactions file ${out} was created successfully."
        return 0
    else
        echo "Error: Failed to create interactions file."
        return 1
    fi
}


function create_frag_file() {
    local ia=""
    local out=""
    local help=$(
cat << EOM
Usage: create_frag_file -i INT_FILE -o OUT_FILE
        
Creates a fragment file from a given interactions file.

Options:
  -h, --help      Display this help message
  -i, --ia-file   Specify the interactions file
  -o, --out-file  Specify the output file

Dependencies:
  - bash utilities awk, gunzip, and sort: Required for processing and sorting
    data

Example:
  create_frag_file \\
      -i some_ia.txt.gz \\
      -o some_frag.txt.gz
EOM
    )

    if [[ -z "${1}" ]]; then echo "${help}"; return 0; fi
    while [[ "$#" -gt 0 ]]; do
        case "${1}" in
            -h|--help) echo "${help}"; return 0 ;;
            -i|--ia-file) ia="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            *) echo "Unknown param passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    local tag="is not installed or not in the system's PATH"
    if ! command -v awk &> /dev/null; then
        echo "Error: awk ${tag}."
        return 1
    fi

    if ! command -v sort &> /dev/null; then
        echo "Error: sort ${tag}."
        return 1
    fi

    if [[ -z "${ia}" ]]; then
        echo "Error: Input file name is required."
        return 1
    elif [[ ! -f "${ia}" ]]; then
        echo "Error: ${ia} does not exist."
        return 1
    fi

    if [[ "${ia: -3}" == ".gz" ]]; then
        if ! command -v gunzip &> /dev/null; then
            echo "Error: gunzip ${tag}."
            return 1
        fi
        read_cmd="gunzip -c"
    else
        read_cmd="cat"
    fi

    if [[ -z "${out}" ]]; then
        echo "Error: Output file name is required."
        return 1
    elif [[ -f "${out}" ]]; then
        echo "Error: Output file ${out} already exists."
        return 1
    elif [[ "${ia}" == "${out}" ]]; then
        echo "Error: Input file and output file should not be the same."
        return 1
    fi

    if [[ "${out: -3}" == ".gz" ]]; then
        if ! command -v gzip &> /dev/null; then
            echo "Error: gzip ${tag}."
            return 1
        fi
        write_cmd="gzip"
    else
        write_cmd="cat"
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

    echo "Fragment file ${out} was created successfully."
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
Usage: gen_bias_vec -p PERCENTILE -i INT_FILE -f FRAG_FILE -o OUT_FILE -H HICKRY_PATH
        
Generates a bias vector file using FitHiC2's HiCKRy.py.

Options:
  -h, --help         Display this help message
  -H, --hickry-path  Specify the path to HiCKRy.py
  -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
  -i, --ia-file     Specify the interactions file
  -f, --frag-file    Specify the fragment file
  -o, --out-file     Specify the output file

Dependencies:
  - Python
  - HiCKRy.py

Example:
  gen_bias_vec \\
      -H /path/to/HiCKRy.py \\
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
            -H|--hickry-path) hickry="${2}"; shift 2 ;;
            -p|--percent) pct="${2}"; shift 2 ;;
            -i|--ia-file) ia="${2}"; shift 2 ;;
            -f|--frag-file) frag="${2}"; shift 2 ;;
            -o|--out-file) out="${2}"; shift 2 ;;
            *) echo "Unknown param passed: ${1}"; echo "${help}"; return 1 ;;
        esac
    done

    if ! command -v python &> /dev/null; then
        echo "Error: Python is not installed or not in the system's PATH."
        return 1
    fi

    if [[ "$(python -c 'import sys; print(sys.version_info[0])')" -ne 3 ]]; then
        echo "Error: Python 3 is required."
        return 1
    fi

    if ! command -v bc &> /dev/null; then
        echo "Error: bc is not installed or not in the system's PATH."
        return 1
    fi

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

    # if [[ -z "${pct}" ]]; then
    #     echo "Error: Percent (of sparse matrix diagonal to remove) is required."
    #     return 1
    # fi

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

    if [[ -z "${ia}" || ! -f "${ia}" ]]; then
        echo "Error: Interactions file is required and should exist."
        return 1
    fi

    if [[ -z "${frag}" || ! -f "${frag}" ]]; then
        echo "Error: Fragment file is required and should exist."
        return 1
    fi

    if [[ -z "${out}" ]]; then
        echo "Error: Output file name is required."
        return 1
    elif [[ -f "${out}" ]]; then
        echo "Error: Output file ${out} already exists."
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
    local help=$(
cat << EOM
Usage: main -c COOL_FILE -i IA_FILE -f FRAG_FILE -o OUT_FILE -H HICKRY_PATH [-p PERCENT] [-r REGION]
        
This script integrates the creation of interaction and fragment files, 
the generation of a bias vector, and other functionalities.

Options:
  -h, --help         Display this help message
  -c, --cool-file    Specify the .cool file
  -i, --ia-file      Specify the interactions file
  -f, --frag-file    Specify the fragment file
  -o, --out-file     Specify the output file for bias vector
  -H, --hickry-path  Specify the path to HiCKRy.py
  -p, --percent      Specify percent of sparse matrix diagonal to remove (default: 0.05)
  -r, --region       Specify the region (optional)

Example:
  main \\
      -c some.cool \\
      -i some_ia.txt \\
      -f some_frag.txt \\
      -o some_bias.txt \\
      -H /path/to/HiCKRy.py \\
      -p 0.05 \\
      -r I
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
            *) echo "Unknown parameter passed: ${1}"; return 1 ;;
        esac
    done

    # Create interactions file
    if ! create_ia_file -c "${cool}" -o "${ia}" -r "${region}"; then
        echo "Error: Failed to create interactions file."
        return 1
    fi

    # Create fragments file
    if ! create_frag_file -i "${ia}" -o "${frag}"; then
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

# Call the main function with all arguments passed to the script
main "$@"

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