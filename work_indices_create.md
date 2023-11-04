
`#work_indices_create.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Download and process `S288C_reference_genome_R64-3-1_20210421.tgz`](#download-and-process-s288c_reference_genome_r64-3-1_20210421tgz)
    1. [Get situated](#get-situated)
        1. [Code](#code)
    1. [Download and decompress the tarred directory](#download-and-decompress-the-tarred-directory)
        1. [Code](#code-1)
        1. [Notes](#notes)
    1. [Process *S. cerevisiae* fasta and gff3 files](#process-s-cerevisiae-fasta-and-gff3-files)
        1. [Notes](#notes-1)
1. [Make indices](#make-indices)
    1. [Code](#code-2)
    1. [Printed](#printed)
1. [Create `chrom.sizes` file](#create-chromsizes-file)
    1. [Code](#code-3)
    1. [Printed](#printed-1)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="download-and-process-s288c_reference_genome_r64-3-1_20210421tgz"></a>
## Download and process [`S288C_reference_genome_R64-3-1_20210421.tgz`](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases)
<a id="get-situated"></a>
### Get situated
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

cd "${HOME}/genomes" || echo "cd'ing failed; check on this..."
```
</details>
<br />

<a id="download-and-decompress-the-tarred-directory"></a>
### Download and decompress the tarred directory
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Download and decompress the tarred directory</i></summary>

```bash
#!/bin/bash

run=false
if ${run}; then
    url_1="http://sgd-archive.yeastgenome.org/sequence"
    url_2="S288C_reference/genome_releases"
    f_tgz="S288C_reference_genome_R64-3-1_20210421.tgz"

    curl "${url_1}/${url_2}/${f_tgz}" > "${f_tgz}"

    tar -xzf "${f_tgz}"

    ls -lhaFG
fi
```
</details>
<br />

<a id="notes"></a>
#### Notes
<details>
<summary><i>Notes: Download and decompress the tarred directory</i></summary>

See [`work_download-process_genomes-S-cerevisiae-S-pombe.md`](../2023-0406_tutorial_ChIP-seq_analysis/work_download-process_genomes-S-cerevisiae-S-pombe.md) section [<i>Download *S. cerevisiae* fastas, gff3</i>](../2023-0406_tutorial_ChIP-seq_analysis/work_download-process_genomes-S-cerevisiae-S-pombe.md#download-s-cerevisiae-fastas-gff3) for details on how [`S288C_reference_genome_R64-3-1_20210421.tgz`](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases) was downloaded and decompressed.
</details>
<br />

<a id="process-s-cerevisiae-fasta-and-gff3-files"></a>
### Process *S. cerevisiae* fasta and gff3 files
<a id="notes-1"></a>
#### Notes
<details>
<summary><i>Notes: Process S. cerevisiae fasta and gff3 files</i></summary>

See [`work_download-process_genomes-S-cerevisiae-S-pombe.md`](../2023-0406_tutorial_ChIP-seq_analysis/work_download-process_genomes-S-cerevisiae-S-pombe.md) section [<i>Prepare *S. cerevisiae* fasta, gff3 for concatenation with *S. pombe*</i>](../2023-0406_tutorial_ChIP-seq_analysis/work_download-process_genomes-S-cerevisiae-S-pombe.md#prepare-s-cerevisiae-fasta-gff3-for-concatenation-with-s-pombe) for details on how the *S. cerevisiae* fasta and gff3 was "prepared"&mdash;e.g., how the chromosome names in the files were given shorter and/or clearer names.
</details>
<br />
<br />

<a id="make-indices"></a>
## Make indices
<a id="code-2"></a>
### Code
<details>
<summary><i>Code: Make indices</i></summary>

```bash
#!/bin/bash

#  Get situated ---------------------------------------------------------------
tmux new -s processing
# tmux a -t processing

grabnode  # 16

module purge
ml SAMtools/1.17-GCC-12.2.0

cd "Saccharomyces_cerevisiae/" || echo "cd'ing failed; check on this..."


#  Index "processed" fasta file -----------------------------------------------
cd "fasta-processed/" || echo "cd'ing failed; check on this..."

if [[ ! -f "S288C_reference_sequence_R64-3-1_20210421.fa" ]]; then
    gzip -dk "S288C_reference_sequence_R64-3-1_20210421.fa.gz"
fi

samtools faidx "S288C_reference_sequence_R64-3-1_20210421.fa"

run=false
if ${run}; then
    if [[
        -f "S288C_reference_sequence_R64-3-1_20210421.fa.fai" && \
        -f "S288C_reference_sequence_R64-3-1_20210421.fa" && \
        -f "S288C_reference_sequence_R64-3-1_20210421.fa.gz"
    ]]; then
        rm "S288C_reference_sequence_R64-3-1_20210421.fa"
    fi
fi

cd ..


#  Create bowtie2 indices from "processed", indexed fasta file-----------------
if [[ ! -d bowtie2 ]]; then mkdir bowtie2; fi

module purge
ml Bowtie2/2.4.4-GCC-11.2.0

bowtie2-build \
    fasta-processed/S288C_reference_sequence_R64-3-1_20210421.fa \
    bowtie2/S288C_R64-3-1 \
        1> >(tee -a bowtie2/S288C_R64-3-1.stdout.txt) \
        2> >(tee -a bowtie2/S288C_R64-3-1.stderr.txt)


#  Create bwa indices from "processed", indexed fasta file---------------------
if [[ ! -d bwa ]]; then mkdir bwa; fi
cd "bwa" ||
    echo "cd'ing failed; check on this..."

module purge
ml BWA/0.7.17-GCCcore-11.2.0

cp ../fasta-processed/S288C_reference_sequence_R64-3-1_20210421.{fa,fa.fai} .
mv S288C_reference_sequence_R64-3-1_20210421.fa S288C_R64-3-1.fa
mv S288C_reference_sequence_R64-3-1_20210421.fa.fai S288C_R64-3-1.fa.fai

bwa index S288C_R64-3-1.fa \
    1> >(tee -a S288C_R64-3-1.stdout.txt) \
    2> >(tee -a S288C_R64-3-1.stderr.txt)


#  How does everything look? --------------------------------------------------
cd .. && ls -lhaFG ./*
```
</details>
<br />

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Make indices</i></summary>

```txt
❯ bowtie2-build \
>     fasta-processed/S288C_reference_sequence_R64-3-1_20210421.fa \
>     bowtie2/S288C_R64-3-1 \
>         1> >(tee -a bowtie2/S288C_R64-3-1.stdout.txt) \
>         2> >(tee -a bowtie2/S288C_R64-3-1.stderr.txt)
Settings:
  Output files: "bowtie2/S288C_R64-3-1.*.bt2"
  Line rate: 6 (line is 64 bytes)
  Lines per side: 1 (side is 64 bytes)
  Offset rate: 4 (one in 16)
  FTable chars: 10
  Strings: unpacked
  Max bucket size: default
  Max bucket size, sqrt multiplier: default
  Max bucket size, len divisor: 4
  Difference-cover sample period: 1024
  Endianness: little
  Actual local endianness: little
  Sanity checking: disabled
  Assertions: disabled
  Random seed: 0
  Sizeofs: void*:8, int:4, long:8, size_t:8
Input files DNA, FASTA:
  fasta-processed/S288C_reference_sequence_R64-3-1_20210421.fa
Reading reference sizes
Building a SMALL index
  Time reading reference sizes: 00:00:00
Calculating joined length
Writing header
Reserving space for joined string
Joining reference sequences
  Time to join reference sequences: 00:00:00
bmax according to bmaxDivN setting: 3039276
Using parameters --bmax 2279457 --dcv 1024
  Doing ahead-of-time memory usage test
  Passed!  Constructing with these parameters: --bmax 2279457 --dcv 1024
Constructing suffix-array element generator
Building DifferenceCoverSample
  Building sPrime
  Building sPrimeOrder
  V-Sorting samples
  V-Sorting samples time: 00:00:00
  Allocating rank array
  Ranking v-sort output
  Ranking v-sort output time: 00:00:00
  Invoking Larsson-Sadakane on ranks
  Invoking Larsson-Sadakane on ranks time: 00:00:00
  Sanity-checking and returning
Building samples
Reserving space for 12 sample suffixes
Generating random suffixes
QSorting 12 sample offsets, eliminating duplicates
QSorting sample offsets, eliminating duplicates time: 00:00:00
Multikey QSorting 12 samples
  (Using difference cover)
  Multikey QSorting samples time: 00:00:00
Calculating bucket sizes
Splitting and merging
  Splitting and merging time: 00:00:00
Avg bucket size: 1.73673e+06 (target: 2279456)
Converting suffix-array elements to index image
Allocating ftab, absorbFtab
Entering Ebwt loop
Getting block 1 of 7
  Reserving size (2279457) for bucket 1
  Calculating Z arrays for bucket 1
  Entering block accumulator loop for bucket 1:
  bucket 1: 10%
  bucket 1: 20%
  bucket 1: 30%
  bucket 1: 40%
  bucket 1: 50%
  bucket 1: 60%
  bucket 1: 70%
  bucket 1: 80%
  bucket 1: 90%
  bucket 1: 100%
  Sorting block of length 1917483 for bucket 1
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1917484 for bucket 1
Getting block 2 of 7
  Reserving size (2279457) for bucket 2
  Calculating Z arrays for bucket 2
  Entering block accumulator loop for bucket 2:
  bucket 2: 10%
  bucket 2: 20%
  bucket 2: 30%
  bucket 2: 40%
  bucket 2: 50%
  bucket 2: 60%
  bucket 2: 70%
  bucket 2: 80%
  bucket 2: 90%
  bucket 2: 100%
  Sorting block of length 1565107 for bucket 2
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1565108 for bucket 2
Getting block 3 of 7
  Reserving size (2279457) for bucket 3
  Calculating Z arrays for bucket 3
  Entering block accumulator loop for bucket 3:
  bucket 3: 10%
  bucket 3: 20%
  bucket 3: 30%
  bucket 3: 40%
  bucket 3: 50%
  bucket 3: 60%
  bucket 3: 70%
  bucket 3: 80%
  bucket 3: 90%
  bucket 3: 100%
  Sorting block of length 2077071 for bucket 3
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 2077072 for bucket 3
Getting block 4 of 7
  Reserving size (2279457) for bucket 4
  Calculating Z arrays for bucket 4
  Entering block accumulator loop for bucket 4:
  bucket 4: 10%
  bucket 4: 20%
  bucket 4: 30%
  bucket 4: 40%
  bucket 4: 50%
  bucket 4: 60%
  bucket 4: 70%
  bucket 4: 80%
  bucket 4: 90%
  bucket 4: 100%
  Sorting block of length 1959963 for bucket 4
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1959964 for bucket 4
Getting block 5 of 7
  Reserving size (2279457) for bucket 5
  Calculating Z arrays for bucket 5
  Entering block accumulator loop for bucket 5:
  bucket 5: 10%
  bucket 5: 20%
  bucket 5: 30%
  bucket 5: 40%
  bucket 5: 50%
  bucket 5: 60%
  bucket 5: 70%
  bucket 5: 80%
  bucket 5: 90%
  bucket 5: 100%
  Sorting block of length 1858740 for bucket 5
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1858741 for bucket 5
Getting block 6 of 7
  Reserving size (2279457) for bucket 6
  Calculating Z arrays for bucket 6
  Entering block accumulator loop for bucket 6:
  bucket 6: 10%
  bucket 6: 20%
  bucket 6: 30%
  bucket 6: 40%
  bucket 6: 50%
  bucket 6: 60%
  bucket 6: 70%
  bucket 6: 80%
  bucket 6: 90%
  bucket 6: 100%
  Sorting block of length 630502 for bucket 6
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 630503 for bucket 6
Getting block 7 of 7
  Reserving size (2279457) for bucket 7
  Calculating Z arrays for bucket 7
  Entering block accumulator loop for bucket 7:
  bucket 7: 10%
  bucket 7: 20%
  bucket 7: 30%
  bucket 7: 40%
  bucket 7: 50%
  bucket 7: 60%
  bucket 7: 70%
  bucket 7: 80%
  bucket 7: 90%
  bucket 7: 100%
  Sorting block of length 2148233 for bucket 7
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 2148234 for bucket 7
Exited Ebwt loop
fchr[A]: 0
fchr[C]: 3766349
fchr[G]: 6086925
fchr[T]: 8404025
fchr[$]: 12157105
Exiting Ebwt::buildToDisk()
Returning from initFromVector
Wrote 8247196 bytes to primary EBWT file: bowtie2/S288C_R64-3-1.1.bt2
Wrote 3039284 bytes to secondary EBWT file: bowtie2/S288C_R64-3-1.2.bt2
Re-opening _in1 and _in2 as input streams
Returning from Ebwt constructor
Headers:
    len: 12157105
    bwtLen: 12157106
    sz: 3039277
    bwtSz: 3039277
    lineRate: 6
    offRate: 4
    offMask: 0xfffffff0
    ftabChars: 10
    eftabLen: 20
    eftabSz: 80
    ftabLen: 1048577
    ftabSz: 4194308
    offsLen: 759820
    offsSz: 3039280
    lineSz: 64
    sideSz: 64
    sideBwtSz: 48
    sideBwtLen: 192
    numSides: 63319
    numLines: 63319
    ebwtTotLen: 4052416
    ebwtTotSz: 4052416
    color: 0
    reverse: 0
Total time for call to driver() for forward index: 00:00:05
Reading reference sizes
  Time reading reference sizes: 00:00:00
Calculating joined length
Writing header
Reserving space for joined string
Joining reference sequences
  Time to join reference sequences: 00:00:00
  Time to reverse reference sequence: 00:00:00
bmax according to bmaxDivN setting: 3039276
Using parameters --bmax 2279457 --dcv 1024
  Doing ahead-of-time memory usage test
  Passed!  Constructing with these parameters: --bmax 2279457 --dcv 1024
Constructing suffix-array element generator
Building DifferenceCoverSample
  Building sPrime
  Building sPrimeOrder
  V-Sorting samples
  V-Sorting samples time: 00:00:00
  Allocating rank array
  Ranking v-sort output
  Ranking v-sort output time: 00:00:00
  Invoking Larsson-Sadakane on ranks
  Invoking Larsson-Sadakane on ranks time: 00:00:00
  Sanity-checking and returning
Building samples
Reserving space for 12 sample suffixes
Generating random suffixes
QSorting 12 sample offsets, eliminating duplicates
QSorting sample offsets, eliminating duplicates time: 00:00:00
Multikey QSorting 12 samples
  (Using difference cover)
  Multikey QSorting samples time: 00:00:00
Calculating bucket sizes
Splitting and merging
  Splitting and merging time: 00:00:00
Split 1, merged 6; iterating...
Splitting and merging
  Splitting and merging time: 00:00:00
Split 1, merged 1; iterating...
Splitting and merging
  Splitting and merging time: 00:00:00
Split 1, merged 0; iterating...
Splitting and merging
  Splitting and merging time: 00:00:00
Split 1, merged 1; iterating...
Splitting and merging
  Splitting and merging time: 00:00:00
Split 1, merged 1; iterating...
Avg bucket size: 1.35079e+06 (target: 2279456)
Converting suffix-array elements to index image
Allocating ftab, absorbFtab
Entering Ebwt loop
Getting block 1 of 9
  Reserving size (2279457) for bucket 1
  Calculating Z arrays for bucket 1
  Entering block accumulator loop for bucket 1:
  bucket 1: 10%
  bucket 1: 20%
  bucket 1: 30%
  bucket 1: 40%
  bucket 1: 50%
  bucket 1: 60%
  bucket 1: 70%
  bucket 1: 80%
  bucket 1: 90%
  bucket 1: 100%
  Sorting block of length 1589220 for bucket 1
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1589221 for bucket 1
Getting block 2 of 9
  Reserving size (2279457) for bucket 2
  Calculating Z arrays for bucket 2
  Entering block accumulator loop for bucket 2:
  bucket 2: 10%
  bucket 2: 20%
  bucket 2: 30%
  bucket 2: 40%
  bucket 2: 50%
  bucket 2: 60%
  bucket 2: 70%
  bucket 2: 80%
  bucket 2: 90%
  bucket 2: 100%
  Sorting block of length 2409030 for bucket 2
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 2409031 for bucket 2
Getting block 3 of 9
  Reserving size (2279457) for bucket 3
  Calculating Z arrays for bucket 3
  Entering block accumulator loop for bucket 3:
  bucket 3: 10%
  bucket 3: 20%
  bucket 3: 30%
  bucket 3: 40%
  bucket 3: 50%
  bucket 3: 60%
  bucket 3: 70%
  bucket 3: 80%
  bucket 3: 90%
  bucket 3: 100%
  Sorting block of length 1342 for bucket 3
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1343 for bucket 3
Getting block 4 of 9
  Reserving size (2279457) for bucket 4
  Calculating Z arrays for bucket 4
  Entering block accumulator loop for bucket 4:
  bucket 4: 10%
  bucket 4: 20%
  bucket 4: 30%
  bucket 4: 40%
  bucket 4: 50%
  bucket 4: 60%
  bucket 4: 70%
  bucket 4: 80%
  bucket 4: 90%
  bucket 4: 100%
  Sorting block of length 683815 for bucket 4
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 683816 for bucket 4
Getting block 5 of 9
  Reserving size (2279457) for bucket 5
  Calculating Z arrays for bucket 5
  Entering block accumulator loop for bucket 5:
  bucket 5: 10%
  bucket 5: 20%
  bucket 5: 30%
  bucket 5: 40%
  bucket 5: 50%
  bucket 5: 60%
  bucket 5: 70%
  bucket 5: 80%
  bucket 5: 90%
  bucket 5: 100%
  Sorting block of length 1634827 for bucket 5
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1634828 for bucket 5
Getting block 6 of 9
  Reserving size (2279457) for bucket 6
  Calculating Z arrays for bucket 6
  Entering block accumulator loop for bucket 6:
  bucket 6: 10%
  bucket 6: 20%
  bucket 6: 30%
  bucket 6: 40%
  bucket 6: 50%
  bucket 6: 60%
  bucket 6: 70%
  bucket 6: 80%
  bucket 6: 90%
  bucket 6: 100%
  Sorting block of length 1268132 for bucket 6
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 1268133 for bucket 6
Getting block 7 of 9
  Reserving size (2279457) for bucket 7
  Calculating Z arrays for bucket 7
  Entering block accumulator loop for bucket 7:
  bucket 7: 10%
  bucket 7: 20%
  bucket 7: 30%
  bucket 7: 40%
  bucket 7: 50%
  bucket 7: 60%
  bucket 7: 70%
  bucket 7: 80%
  bucket 7: 90%
  bucket 7: 100%
  Sorting block of length 1573649 for bucket 7
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 1573650 for bucket 7
Getting block 8 of 9
  Reserving size (2279457) for bucket 8
  Calculating Z arrays for bucket 8
  Entering block accumulator loop for bucket 8:
  bucket 8: 10%
  bucket 8: 20%
  bucket 8: 30%
  bucket 8: 40%
  bucket 8: 50%
  bucket 8: 60%
  bucket 8: 70%
  bucket 8: 80%
  bucket 8: 90%
  bucket 8: 100%
  Sorting block of length 937177 for bucket 8
  (Using difference cover)
  Sorting block time: 00:00:01
Returning block of 937178 for bucket 8
Getting block 9 of 9
  Reserving size (2279457) for bucket 9
  Calculating Z arrays for bucket 9
  Entering block accumulator loop for bucket 9:
  bucket 9: 10%
  bucket 9: 20%
  bucket 9: 30%
  bucket 9: 40%
  bucket 9: 50%
  bucket 9: 60%
  bucket 9: 70%
  bucket 9: 80%
  bucket 9: 90%
  bucket 9: 100%
  Sorting block of length 2059905 for bucket 9
  (Using difference cover)
  Sorting block time: 00:00:00
Returning block of 2059906 for bucket 9
Exited Ebwt loop
fchr[A]: 0
fchr[C]: 3766349
fchr[G]: 6086925
fchr[T]: 8404025
fchr[$]: 12157105
Exiting Ebwt::buildToDisk()
Returning from initFromVector
Wrote 8247196 bytes to primary EBWT file: bowtie2/S288C_R64-3-1.rev.1.bt2
Wrote 3039284 bytes to secondary EBWT file: bowtie2/S288C_R64-3-1.rev.2.bt2
Re-opening _in1 and _in2 as input streams
Returning from Ebwt constructor
Headers:
    len: 12157105
    bwtLen: 12157106
    sz: 3039277
    bwtSz: 3039277
    lineRate: 6
    offRate: 4
    offMask: 0xfffffff0
    ftabChars: 10
    eftabLen: 20
    eftabSz: 80
    ftabLen: 1048577
    ftabSz: 4194308
    offsLen: 759820
    offsSz: 3039280
    lineSz: 64
    sideSz: 64
    sideBwtSz: 48
    sideBwtLen: 192
    numSides: 63319
    numLines: 63319
    ebwtTotLen: 4052416
    ebwtTotSz: 4052416
    color: 0
    reverse: 1
Total time for backward call to driver() for mirror index: 00:00:06


❯ bwa index S288C_R64-3-1.fa \
>     1> >(tee -a S288C_R64-3-1.stdout.txt) \
>     2> >(tee -a S288C_R64-3-1.stderr.txt)
[bwa_index] Pack FASTA... 0.09 sec
[bwa_index] Construct BWT for the packed sequence...
[bwa_index] 3.98 seconds elapse.
[bwa_index] Update BWT... 0.05 sec
[bwa_index] Pack forward-only FASTA... 0.06 sec
[bwa_index] Construct SA from BWT and Occ... 1.16 sec
[main] Version: 0.7.17-r1188
[main] CMD: bwa index S288C_R64-3-1.fa
[main] Real time: 5.506 sec; CPU: 5.351 sec


❯ cd .. && .,s
-rw-rw---- 1 kalavatt 20M May 29 08:53 ./S288C_reference_genome_R64-3-1_20210421.tgz

./bowtie2:
total 31M
drwxrwx--- 2 kalavatt  314 Jun 10 14:33 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-rw---- 1 kalavatt 7.9M Jun 10 14:33 S288C_R64-3-1.1.bt2
-rw-rw---- 1 kalavatt 2.9M Jun 10 14:33 S288C_R64-3-1.2.bt2
-rw-rw---- 1 kalavatt  161 Jun 10 14:33 S288C_R64-3-1.3.bt2
-rw-rw---- 1 kalavatt 2.9M Jun 10 14:33 S288C_R64-3-1.4.bt2
-rw-rw---- 1 kalavatt 7.9M Jun 10 14:33 S288C_R64-3-1.rev.1.bt2
-rw-rw---- 1 kalavatt 2.9M Jun 10 14:33 S288C_R64-3-1.rev.2.bt2
-rw-rw---- 1 kalavatt   23 Jun 10 14:33 S288C_R64-3-1.stderr.txt
-rw-rw---- 1 kalavatt  13K Jun 10 14:33 S288C_R64-3-1.stdout.txt

./bwa:
total 25M
drwxrwx--- 2 kalavatt  345 Jun 10 14:42 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-rw---- 1 kalavatt  12M Jun 10 14:40 S288C_R64-3-1.fa
-rw-rw---- 1 kalavatt   14 Jun 10 14:42 S288C_R64-3-1.fa.amb
-rw-rw---- 1 kalavatt  515 Jun 10 14:42 S288C_R64-3-1.fa.ann
-rw-rw---- 1 kalavatt  12M Jun 10 14:42 S288C_R64-3-1.fa.bwt
-rw-rw---- 1 kalavatt  415 Jun 10 14:40 S288C_R64-3-1.fa.fai
-rw-rw---- 1 kalavatt 2.9M Jun 10 14:42 S288C_R64-3-1.fa.pac
-rw-rw---- 1 kalavatt 5.8M Jun 10 14:42 S288C_R64-3-1.fa.sa
-rw-rw---- 1 kalavatt  370 Jun 10 14:42 S288C_R64-3-1.stderr.txt
-rw-rw---- 1 kalavatt  370 Jun 10 14:42 S288C_R64-3-1.stdout.txt

./fasta:
total 15M
drwxr-x--- 2 kalavatt  413 May 29 08:54 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-r----- 1 kalavatt 3.6M Apr 27  2021 gene_association_R64-3-1_20210421.sgd.gz
-rw-r----- 1 kalavatt 1.1M Apr 21  2021 NotFeature_R64-3-1_20210421.fasta.gz
-rw-r----- 1 kalavatt 3.7M Apr 21  2021 orf_coding_all_R64-3-1_20210421.fasta.gz
-rw-r----- 1 kalavatt 2.6M Apr 21  2021 orf_trans_all_R64-3-1_20210421.fasta.gz
-rw-r----- 1 kalavatt 187K Apr 21  2021 other_features_genomic_R64-3-1_20210421.fasta.gz
-rw-r----- 1 kalavatt  42K Apr 27  2021 rna_coding_R64-3-1_20210421.fasta.gz
-rw-r----- 1 kalavatt 3.7M Apr 21  2021 S288C_reference_sequence_R64-3-1_20210421.fsa.gz

./fasta-processed:
total 9.8M
drwxrwx--- 2 kalavatt  193 Jun 10 14:39 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-rw---- 1 kalavatt  12M May 29 09:58 S288C_reference_sequence_R64-3-1_20210421.fa
-rw-rw---- 1 kalavatt  415 Jun 10 14:26 S288C_reference_sequence_R64-3-1_20210421.fa.fai
-rw-rw---- 1 kalavatt 3.7M May 29 09:58 S288C_reference_sequence_R64-3-1_20210421.fa.gz

./gff3:
total 5.2M
drwxrwx--- 2 kalavatt   66 May 29 08:54 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-r----- 1 kalavatt 5.1M Apr 27  2021 saccharomyces_cerevisiae_R64-3-1_20210421.gff.gz

./gff3-processed:
total 1.7M
drwxrwx--- 2 kalavatt   67 May 29 10:42 ./
drwxrwx--- 8 kalavatt  217 Jun 10 14:20 ../
-rw-rw---- 1 kalavatt 1.6M May 29 10:37 saccharomyces_cerevisiae_R64-3-1_20210421.gff3.gz
```
</details>
<br />
<br />

<a id="create-chromsizes-file"></a>
## Create `chrom.sizes` file
<a id="code-3"></a>
### Code
<details>
<summary><i>Code: Create chrom.sizes file</i></summary>

```bash
#!/bin/bash

cd "${HOME}/genomes/Saccharomyces_cerevisiae/" ||
    echo "cd'ing failed; check on this..."

cut -f 1,2 \
    fasta-processed/S288C_reference_sequence_R64-3-1_20210421.fa.fai \
        > fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size

cat fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size
```
</details>
<br />

<a id="printed-1"></a>
### Printed
<details>
<summary><i>Printed: Create chrom.sizes file</i></summary>

```txt
❯ cd "${HOME}/genomes/Saccharomyces_cerevisiae/" ||
>     echo "cd'ing failed; check on this..."


❯ cut -f 1,2 \
>     fasta-processed/S288C_reference_sequence_R64-3-1_20210421.fa.fai \
>         > fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size


❯ cat fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size
I       230218
II      813184
III     316620
IV      1531933
V       576874
VI      270161
VII     1090940
VIII    562643
IX      439888
X       745751
XI      666816
XII     1078177
XIII    924431
XIV     784333
XV      1091291
XVI     948066
Mito    85779
```
</details>
<br />
