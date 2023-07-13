
`rough-draft_determine-analysis-strategy_rDNA-Micro-C.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Test: Working with pairs files](#test-working-with-pairs-files)
    1. [Run an initial assessment of the non-deduplicated files](#run-an-initial-assessment-of-the-non-deduplicated-files)
        1. [Code](#code)
    1. [Printed](#printed)
    1. [Notes](#notes)
        1. [On what and where the columns are](#on-what-and-where-the-columns-are)
        1. [On what the pair types are](#on-what-the-pair-types-are)
1. [Work out the logic to isolate rDNA pairs](#work-out-the-logic-to-isolate-rdna-pairs)
    1. [Review awk tutorial #1](#review-awk-tutorial-1)
        1. [Code](#code-1)
        1. [Printed](#printed-1)
    1. [Review awk tutorial #2](#review-awk-tutorial-2)
        1. [Code](#code-2)
        1. [Printed](#printed-2)
    1. [Begin to write and test usable logic](#begin-to-write-and-test-usable-logic)
        1. [Code](#code-3)
        1. [Printed](#printed-3)
1. [Slouching toward obtaining and processing rDNA multimappers](#slouching-toward-obtaining-and-processing-rdna-multimappers)
    1. [Tests in which I had not yet determined how to retain multimappers](#tests-in-which-i-had-not-yet-determined-how-to-retain-multimappers)
        1. [Check that we have deduplicated rDNA read pairs](#check-that-we-have-deduplicated-rdna-read-pairs)
            1. [Code](#code-4)
            1. [Printed](#printed-4)
            1. [Notes](#notes-1)
            1. [Scraps](#scraps)
    1. [Work after I had determined a strategy to retain rDNA multimappers](#work-after-i-had-determined-a-strategy-to-retain-rdna-multimappers)
        1. [Check that we have deduplicated rDNA read pairs](#check-that-we-have-deduplicated-rdna-read-pairs-1)
            1. [Code](#code-5)
            1. [Printed](#printed-5)
            1. [Notes](#notes-2)
    1. [Implement logic for creation of deduplicated "`standard-rDNA-complete`" files](#implement-logic-for-creation-of-deduplicated-standard-rdna-complete-files)
        1. [So, what's the next step?](#so-whats-the-next-step)
            1. [Notes](#notes-3)
        1. [Updates to the naming scheme](#updates-to-the-naming-scheme)
            1. [Notes](#notes-4)
        1. [Clean up directory, then re-copy in only necessary files](#clean-up-directory-then-re-copy-in-only-necessary-files)
            1. [Code](#code-6)
            1. [Printed](#printed-6)
        1. [Run the actual processing](#run-the-actual-processing)
            1. [Code](#code-7)
                1. [1. Exclude rDNA-associated cis and trans interactions from "standard"](#1-exclude-rdna-associated-cis-and-trans-interactions-from-standard)
                1. [2. Retain only rDNA-associated cis and trans interactions in "keep-MM"](#2-retain-only-rdna-associated-cis-and-trans-interactions-in-keep-mm)
                1. [3. Concatenate "standard-no-rDNA" and "rDNA-only" files](#3-concatenate-standard-no-rdna-and-rdna-only-files)
                1. [4. Copy file to remote, then run `pairtools sort`](#4-copy-file-to-remote-then-run-pairtools-sort)
                1. [5. Troubleshoot the re-headering of pairs files](#5-troubleshoot-the-re-headering-of-pairs-files)
                1. [6. Test that "`0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz`" can be re-headered](#6-test-that-0x_compsrr7939018standard-no-rdnanodupspairsgz-can-be-re-headered)
            1. [Printed](#printed-7)
                1. [1. Exclude rDNA-associated cis and trans interactions from "standard"](#1-exclude-rdna-associated-cis-and-trans-interactions-from-standard-1)
                1. [2. Retain only rDNA-associated cis and trans interactions in "keep-MM"](#2-retain-only-rdna-associated-cis-and-trans-interactions-in-keep-mm-1)
                1. [3. Concatenate "standard-no-rDNA" and "keep-MM rDNA-only" files](#3-concatenate-standard-no-rdna-and-keep-mm-rdna-only-files)
                1. [4. Copy file to remote, then run `pairtools sort`](#4-copy-file-to-remote-then-run-pairtools-sort-1)
                1. [5. Troubleshoot the re-headering of pairs files](#5-troubleshoot-the-re-headering-of-pairs-files-1)
                1. [6. Test that "`0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz`" can be re-headered](#6-test-that-0x_compsrr7939018standard-no-rdnanodupspairsgz-can-be-re-headered-1)
            1. [Scraps](#scraps-1)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="test-working-with-pairs-files"></a>
## Test: Working with pairs files
<u>Goal</u>: Add rDNA-associated pairs records to deduplicated pairs files

<a id="run-an-initial-assessment-of-the-non-deduplicated-files"></a>
### Run an initial assessment of the non-deduplicated files
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Run an initial assessment of the non-deduplicated files</i></summary>

```bash
#!/bin/bash

#  Run tests on WorkMac, local
cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    echo "cd'ing failed; check on this..."


#  Look at the file containing duplicates -------------------------------------
ls -lhaFG SRR7939018.dups.pairs.gz

zcat < SRR7939018.dups.pairs.gz | head

zcat < SRR7939018.dups.pairs.gz | wc -l

#  Decompress the file, then manually inspect it
zcat < SRR7939018.dups.pairs.gz > SRR7939018.dups.pairs.txt

ls -lhaFG SRR7939018.dups.pairs.txt

#  What does the header look like?
cat SRR7939018.dups.pairs.txt | head -45

cat SRR7939018.dups.pairs.txt | head -45 | tail -1

#NOTE #QUESTION
#  Upon manual inspection, it looks like pair information (exclusively
#+ non-empty chrom1 and chrom2) are not maintained in this file: Is this the
#+ file for unmapped pairs and it has been assigned an incorrect name?


#  Look at the file that *should be* containing unmapped pairs ----------------
ls -lhaFG SRR7939018.unmapped.pairs.gz

zcat < SRR7939018.unmapped.pairs.gz | head

zcat < SRR7939018.unmapped.pairs.gz | wc -l

#  Decompress the file, then manually inspect it
zcat < SRR7939018.unmapped.pairs.gz > SRR7939018.unmapped.pairs.txt

ls -lhaFG SRR7939018.unmapped.pairs.txt

#  What does the header look like?
cat SRR7939018.unmapped.pairs.txt | head -45

cat SRR7939018.unmapped.pairs.txt | head -45 | tail -1


#NOTE #ANSWER
#  Yes, you misnamed the two files: "unmapped" should be "dups" and vice versa:
#+ "dups" should be "unmapped"
#+ 
#+ #DONE #IMPORTANT Correct your rough-draft pipeline/processing code


#  For the time being, manually correct the filenames -------------------------
rm *.pairs.txt

mv SRR7939018.unmapped.pairs.gz SRR7939018.dups0.pairs.gz

mv SRR7939018.dups.pairs.gz SRR7939018.unmapped.pairs.gz

mv SRR7939018.dups0.pairs.gz SRR7939018.dups.pairs.gz

zcat < SRR7939018.dups.pairs.gz > SRR7939018.dups.pairs.txt
```
</details>
<br />

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Run an initial assessment of the non-deduplicated files</i></summary>

```txt
❯ #  Run tests on WorkMac, local


❯ cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
cmdor>     echo "cd'ing failed; check on this..."


❯ #  Look at the file containing duplicates -------------------------------------


❯ ls -lhaFG SRR7939018.dups.pairs.gz
-rwx------  1 kalavatt  staff   213M Jul  6 12:41 SRR7939018.dups.pairs.gz*


❯ zcat < SRR7939018.dups.pairs.gz | head
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


❯ zcat < SRR7939018.dups.pairs.gz | wc -l
 28199743


❯ #  Decompress the file, then manually inspect it


❯ zcat < SRR7939018.dups.pairs.gz > SRR7939018.dups.pairs.txt


❯ ls -lhaFG SRR7939018.dups.pairs.txt
-rw-r--r--  1 kalavatt  staff   1.7G Jul  9 08:23 SRR7939018.dups.pairs.txt


❯ #  What does the header look like?


❯ cat SRR7939018.dups.pairs.txt | head -45
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
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_aln/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.dups.pairs.gz  PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2


❯ cat SRR7939018.dups.pairs.txt | head -45 | tail -1
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2


❯ #NOTE #QUESTION
❯ #  Upon manual inspection, it looks like pair information (exclusively
❯ #+ non-empty chrom1 and chrom2) are not maintained in this file: Is this the
❯ #+ file for unmapped pairs and it has been assigned an incorrect name?


❯ #  Look at the file that *should be* containing unmapped pairs ----------------


❯ ls -lhaFG SRR7939018.unmapped.pairs.gz
-rwx------  1 kalavatt  staff   157M Jul  6 12:41 SRR7939018.unmapped.pairs.gz*


❯ zcat < SRR7939018.unmapped.pairs.gz | head
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


❯ zcat < SRR7939018.unmapped.pairs.gz | wc -l
 6749432


❯ #  Decompress the file, then manually inspect it


❯ zcat < SRR7939018.unmapped.pairs.gz > SRR7939018.unmapped.pairs.txt


❯ ls -lhaFG SRR7939018.unmapped.pairs.txt
-rw-r--r--  1 kalavatt  staff   603M Jul  9 08:49 SRR7939018.unmapped.pairs.txt


❯ #  What does the header look like?


❯ cat SRR7939018.unmapped.pairs.txt | head -45
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
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_aln/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.unmapped.pairs.gz  PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2


❯ cat SRR7939018.unmapped.pairs.txt | head -45 | tail -1
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2


❯ #NOTE #ANSWER
❯ #  Yes, you misnamed the two files: "unmapped" should be "dups" and vice versa:
❯ #+ "dups" should be "unmapped"
❯ #+
❯ #+ #TODO #IMPORTANT Correct your rough-draft pipeline/processing code


❯ #  For the time being, manually correct the filenames -------------------------


❯ rm *.pairs.txt


❯ mv SRR7939018.unmapped.pairs.gz SRR7939018.dups0.pairs.gz


❯ mv SRR7939018.dups.pairs.gz SRR7939018.unmapped.pairs.gz


❯ mv SRR7939018.dups0.pairs.gz SRR7939018.dups.pairs.gz


❯ zcat < SRR7939018.dups.pairs.gz > SRR7939018.dups.pairs.txt
```
</details>
<br />

<a id="notes"></a>
### Notes
<details>
<summary><i>Notes: Run an initial assessment of the non-deduplicated files</i></summary>

<a id="on-what-and-where-the-columns-are"></a>
#### On what and where the columns are
- column 02: chrom1
- column 03: pos1 (chrom1 5' position)
- column 04: chrom2
- column 05: pos2 (chrom2 5' position)
- column 08: pair_type
- column 09: walk_pair_index
- column 10: walk_pair_type
- column 11: pos51 (chrom1 5' position)
- column 12: pos52 (chrom2 5' position)
- column 13: pos31 (chrom1 3' position)
- column 14: pos32 (chrom2 3' position)
- column 15: mapq1
- column 16: mapq2
- column 17: mismatches1
- column 18: mismatches2

<a id="on-what-the-pair-types-are"></a>
#### On what the pair types are
- *doesn't really matter right now* `#LATER`
</details>
<br />
<br />

<a id="work-out-the-logic-to-isolate-rdna-pairs"></a>
## Work out the logic to isolate rDNA pairs
<a id="review-awk-tutorial-1"></a>
### Review awk [tutorial #1](https://towardsdatascience.com/mastering-file-and-text-manipulation-with-awk-utility-65fc09d56bef)
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Review awk tutorial #1</i></summary>

```bash
#!/bin/bash

#  Get situated ---------------------------------------------------------------
cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
    echo "cd'ing failed; check on this..."

df="SRR7939018.dups.pairs.txt"


#  Run awk {print} for each record (i.e., just print the stream) --------------
awk '{ print }' "${df}" | head


#  Print the first two columns ------------------------------------------------
awk '{ print $1 "\t" $2 }' "${df}" | head -50

#NOTE
#  $1 and $2 represent, respectively, columns 1 and 2


#  Add line numbers at the start of each line ---------------------------------
awk -v count=0 '{ print ++count " " $0 }' "${df}" | head -50

#NOTE
#  Here, we define a variable as count and increment it when reading each line,
#+ printing it at the first of the line.
#+ 
#+ Also, $0 represents the whole line

#  We can remove "-v count=0"; "count" will be implicitly defined as 0
awk '{ print ++count " " $0 }' "${df}" | head -50


#  Only print line if pos1 is gt 450000 ---------------------------------------
cat "${df}" | awk '{ if ($3 > 450000) print $0 }' | head -100 | tail -50


#  Generate a report of how many records there are for chrom1 -----------------
cat "${df}" \
    | tail --lines=+46 \
    | awk '
        { dict[$2] += 1 }
        END { for (key in dict) { print key, dict[key] } }
    '

#NOTE
#  Here, we have a dictionary named "dict". For each line, the key is the
#+ second column entry (chrom1), and we increase its value by 1. After the
#+ "END" keyword, we can write the "END" block commands, which are optional
#+ commands to run after commands in the implicit BEGIN block
#+ ("{ dict[$2] += 1 }"). In the END block, we loop on the dictionary and print
#+ its (key, value) pairs. Keys are chrom1 values, values are associated
#+ tallies.
#+ 
#+ Also, with "tail --lines=+46", we're specifying that we want to skip the
#+ first 46 lines of the dataframe.


#  Calculate the pos1 average -------------------------------------------------
cat "${df}" | awk '{ pos1_sum += $3 } END { print pos1_sum/NR }'

#NOTE
#  "NR" is a built-in variable that stores the current record number. So, in
#+ the END block, it will be equal to the total number of records (lines).


#  Only print records when chrom1 contain the character 'X' -------------------
cat "${df}" | awk '$2 ~ /[X]/ { print $0 }' | head -50

#NOTE
#  Here, we specify that the column 2 value should match the regular expression
#+ [X].


#  Define a function to add a column if pos1 is lt or gt than 450000 ----------
cat "${df}" \
    | awk '
        function age_func(age) {
            if (pos1 < 450000) {
                return "lt"
            }
            return "gt"
        }
        { print $0 "\t" age_func($2) }
    ' \
    | tail --lines=+46 \
    | head -50
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Review awk tutorial #1</i></summary>

```txt
❯ #  Get situated ---------------------------------------------------------------


❯ cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" ||
cmdor>     echo "cd'ing failed; check on this..."


❯ df="SRR7939018.dups.pairs.txt"


❯ #  Run awk {print} for each record (i.e., just print the stream) --------------


❯ awk '{ print }' "${df}" | head
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


❯ #  Print the first two columns ------------------------------------------------


❯ awk '{ print $1 "\t" $2 }' "${df}" | head -50
##  pairs
#sorted:    chr1-chr2-pos1-pos2
#shape: whole
#genome_assembly:   S288C_R64-3-1
#chromsize: I
#chromsize: II
#chromsize: III
#chromsize: IV
#chromsize: V
#chromsize: VI
#chromsize: VII
#chromsize: VIII
#chromsize: IX
#chromsize: X
#chromsize: XI
#chromsize: XII
#chromsize: XIII
#chromsize: XIV
#chromsize: XV
#chromsize: XVI
#chromsize: Mito
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @SQ
#samheader: @PG
#samheader: @PG
#samheader: @PG
#samheader: @PG
#samheader: @PG
#samheader: @PG
#columns:   readID
SRR7939018.52075119 I
SRR7939018.38253176 I
SRR7939018.53629809 I
SRR7939018.10654261 I
SRR7939018.19343374 I


❯ #NOTE
❯ #  $1 and $2 represent, respectively, columns 1 and 2


❯ #  Add line numbers at the start of each line ---------------------------------


❯ awk -v count=0 '{ print ++count " " $0 }' "${df}" | head -50
1 ## pairs format v1.0.0
2 #sorted: chr1-chr2-pos1-pos2
3 #shape: whole matrix
4 #genome_assembly: S288C_R64-3-1
5 #chromsize: I 230218
6 #chromsize: II 813184
7 #chromsize: III 316620
8 #chromsize: IV 1531933
9 #chromsize: V 576874
10 #chromsize: VI 270161
11 #chromsize: VII 1090940
12 #chromsize: VIII 562643
13 #chromsize: IX 439888
14 #chromsize: X 745751
15 #chromsize: XI 666816
16 #chromsize: XII 1078177
17 #chromsize: XIII 924431
18 #chromsize: XIV 784333
19 #chromsize: XV 1091291
20 #chromsize: XVI 948066
21 #chromsize: Mito 85779
22 #samheader: @SQ  SN:I    LN:230218
23 #samheader: @SQ  SN:II   LN:813184
24 #samheader: @SQ  SN:III  LN:316620
25 #samheader: @SQ  SN:IV   LN:1531933
26 #samheader: @SQ  SN:V    LN:576874
27 #samheader: @SQ  SN:VI   LN:270161
28 #samheader: @SQ  SN:VII  LN:1090940
29 #samheader: @SQ  SN:VIII LN:562643
30 #samheader: @SQ  SN:IX   LN:439888
31 #samheader: @SQ  SN:X    LN:745751
32 #samheader: @SQ  SN:XI   LN:666816
33 #samheader: @SQ  SN:XII  LN:1078177
34 #samheader: @SQ  SN:XIII LN:924431
35 #samheader: @SQ  SN:XIV  LN:784333
36 #samheader: @SQ  SN:XV   LN:1091291
37 #samheader: @SQ  SN:XVI  LN:948066
38 #samheader: @SQ  SN:Mito LN:85779
39 #samheader: @PG  ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
40 #samheader: @PG  ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
41 #samheader: @PG  ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_aln/SRR7939018.bam  PP:samtools VN:1.0.2
42 #samheader: @PG  ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
43 #samheader: @PG  ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
44 #samheader: @PG  ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.unmapped.pairs.gz  PP:pairtools_dedup  VN:1.0.2
45 #columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
46 SRR7939018.52075119  I   7   I   1001    +   +   DD  1   R1-2    7   1001    56  1050    28  46
47 SRR7939018.38253176  I   10  I   887 +   +   DD  1   R1-2    10  887 59  936 35  35
48 SRR7939018.53629809  I   12  I   219 +   -   DD  1   R1-2    12  219 61  170 42  57
49 SRR7939018.10654261  I   36  I   470 +   -   DD  1   R1-2    36  470 78  421 60  6
50 SRR7939018.19343374  I   38  I   194 +   -   DD  1   R1-2    38  194 87  145 60  18


❯ #NOTE
❯ #  Here, we define a variable as count and increment it when reading each line,
❯ #+ printing it at the first of the line.
❯ #+
❯ #+ Also, $0 represents the whole line


❯ #  We can remove "-v count=0"; "count" will be implicitly defined as 0


❯ awk '{ print ++count " " $0 }' "${df}" | head -50
1 ## pairs format v1.0.0
2 #sorted: chr1-chr2-pos1-pos2
3 #shape: whole matrix
4 #genome_assembly: S288C_R64-3-1
5 #chromsize: I 230218
6 #chromsize: II 813184
7 #chromsize: III 316620
8 #chromsize: IV 1531933
9 #chromsize: V 576874
10 #chromsize: VI 270161
11 #chromsize: VII 1090940
12 #chromsize: VIII 562643
13 #chromsize: IX 439888
14 #chromsize: X 745751
15 #chromsize: XI 666816
16 #chromsize: XII 1078177
17 #chromsize: XIII 924431
18 #chromsize: XIV 784333
19 #chromsize: XV 1091291
20 #chromsize: XVI 948066
21 #chromsize: Mito 85779
22 #samheader: @SQ  SN:I    LN:230218
23 #samheader: @SQ  SN:II   LN:813184
24 #samheader: @SQ  SN:III  LN:316620
25 #samheader: @SQ  SN:IV   LN:1531933
26 #samheader: @SQ  SN:V    LN:576874
27 #samheader: @SQ  SN:VI   LN:270161
28 #samheader: @SQ  SN:VII  LN:1090940
29 #samheader: @SQ  SN:VIII LN:562643
30 #samheader: @SQ  SN:IX   LN:439888
31 #samheader: @SQ  SN:X    LN:745751
32 #samheader: @SQ  SN:XI   LN:666816
33 #samheader: @SQ  SN:XII  LN:1078177
34 #samheader: @SQ  SN:XIII LN:924431
35 #samheader: @SQ  SN:XIV  LN:784333
36 #samheader: @SQ  SN:XV   LN:1091291
37 #samheader: @SQ  SN:XVI  LN:948066
38 #samheader: @SQ  SN:Mito LN:85779
39 #samheader: @PG  ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 8 -SP /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/bwa/S288C_R64-3-1.fa /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_1.fastq.gz /home/kalavatt/tsukiyamalab/kalavatt/2023_rDNA/data/PRJNA493742/SRR7939018_2.fastq.gz
40 #samheader: @PG  ID:samtools PN:samtools PP:bwa  VN:1.16.1   CL:samtools view -@ 8 -S -b
41 #samheader: @PG  ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_aln/SRR7939018.bam  PP:samtools VN:1.0.2
42 #samheader: @PG  ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
43 #samheader: @PG  ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
44 #samheader: @PG  ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.unmapped.pairs.gz  PP:pairtools_dedup  VN:1.0.2
45 #columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
46 SRR7939018.52075119  I   7   I   1001    +   +   DD  1   R1-2    7   1001    56  1050    28  46
47 SRR7939018.38253176  I   10  I   887 +   +   DD  1   R1-2    10  887 59  936 35  35
48 SRR7939018.53629809  I   12  I   219 +   -   DD  1   R1-2    12  219 61  170 42  57
49 SRR7939018.10654261  I   36  I   470 +   -   DD  1   R1-2    36  470 78  421 60  6
50 SRR7939018.19343374  I   38  I   194 +   -   DD  1   R1-2    38  194 87  145 60  18


❯ #  Only print line if pos1 is gt 450000 ---------------------------------------


❯ cat "${df}" | awk '{ if ($3 > 450000) print $0 }' | head -100 | tail -50
SRR7939018.14237491 II  453587  I   68318   +   -   DD  1   R1-2    453587  68318   453636  68269   60  60
SRR7939018.24464620 II  453970  I   42329   +   -   DD  1   R1-2    453970  42329   454019  42280   60  60
SRR7939018.61123057 II  454878  I   80137   -   -   DD  1   R1-2    454878  80137   454829  80088   60  60
SRR7939018.64613303 II  454878  I   80137   -   -   DD  1   R1-2    454878  80137   454829  80088   60  60
SRR7939018.53083965 II  454981  I   184587  +   -   DD  1   R1-2    454981  184587  455030  184538  60  60
SRR7939018.60960140 II  455261  I   49666   -   +   DD  1   R1-2    455261  49666   455212  49715   60  60
SRR7939018.45230526 II  455317  I   33919   -   +   DD  1   R1-2    455317  33919   455272  33968   60  60
SRR7939018.63993820 II  455745  I   55479   -   +   DD  1   R1-2    455745  55479   455696  55529   60  60
SRR7939018.43792523 II  456304  I   182156  -   +   DD  1   R1-2    456304  182156  456255  182205  60  60
SRR7939018.60559622 II  456979  I   135633  -   +   DD  1   R1-2    456979  135633  456930  135682  60  60      T:G:27:135676:44
SRR7939018.54967728 II  457410  I   124929  -   -   DD  1   R1-2    457410  124929  457361  124880  60  60      G:T:40:124923:44
SRR7939018.43035269 II  457436  I   115098  -   -   DD  1   R1-2    457436  115098  457387  115049  60  60
SRR7939018.45439037 II  458281  I   122970  +   +   DD  1   R1-2    458281  122970  458330  123019  60  60  C:T:38:458316:36
SRR7939018.26122945 II  459259  I   98408   -   +   DD  1   R1-2    459259  98408   459210  98457   60  60
SRR7939018.59883643 II  459259  I   98408   -   +   DD  1   R1-2    459259  98408   459210  98457   60  60
SRR7939018.61787363 II  459470  I   9799    +   -   DD  1   R1-2    459470  9799    459519  9750    60  60
SRR7939018.54571921 II  460116  I   50093   +   -   DD  1   R1-2    460116  50093   460165  50044   60  60
SRR7939018.38328212 II  460158  I   27485   +   -   DD  1   R1-2    460158  27485   460194  27436   60  15
SRR7939018.41603724 II  461263  I   113347  -   +   DD  1   R1-2    461263  113347  461214  113396  60  60
SRR7939018.45628963 II  461274  I   61798   +   -   DD  1   R1-2    461274  61798   461323  61749   60  60
SRR7939018.51262591 II  461274  I   61798   +   -   DD  1   R1-2    461274  61798   461323  61749   60  60
SRR7939018.63581981 II  461438  I   189951  -   -   DD  1   R1-2    461438  189951  461389  189902  60  60
SRR7939018.62242222 II  461623  I   277 +   -   DD  1   R1-2    461623  277 461672  228 60  22
SRR7939018.46157685 II  461772  I   154498  -   -   DD  1   R1-2    461772  154498  461723  154449  60  60
SRR7939018.52611908 II  462420  I   112621  -   +   DD  1   R1-2    462420  112621  462371  112670  60  60
SRR7939018.52741244 II  462555  I   115064  +   -   DD  1   R1-2    462555  115064  462604  115015  60  60
SRR7939018.19565705 II  463140  I   475 -   -   DD  1   R1-2    463140  475 463091  426 60  4
SRR7939018.57144942 II  463314  I   185502  +   -   DD  1   R1-2    463314  185502  463344  185453  60  60
SRR7939018.46157825 II  463426  I   127648  +   +   DD  1   R1-2    463426  127648  463475  127697  60  60
SRR7939018.46065967 II  463704  I   206290  +   -   DD  1   R1-2    463704  206290  463753  206259  60  31
SRR7939018.50098562 II  464238  I   41470   -   +   DD  1   R1-2    464238  41470   464189  41519   35  60
SRR7939018.40521288 II  464528  I   32424   -   +   DD  1   R1-2    464528  32424   464479  32473   60  60
SRR7939018.36371257 II  464735  I   28349   +   +   DD  1   R1-2    464735  28349   464784  28390   60  60
SRR7939018.58600854 II  464735  I   28349   +   +   DD  1   R1-2    464735  28349   464784  28390   60  60
SRR7939018.14698292 II  464892  I   52226   -   -   DD  1   R1-2    464892  52226   464843  52192   60  60
SRR7939018.64452426 II  465715  I   7788    -   -   DD  1   R1-2    465715  7788    465666  7758    60  60
SRR7939018.33597286 II  465867  I   106158  +   -   DD  1   R1-2    465867  106158  465916  106109  60  60
SRR7939018.51567926 II  466323  I   131697  -   +   DD  1   R1-2    466323  131697  466293  131746  60  60
SRR7939018.55596560 II  466323  I   131697  -   +   DD  1   R1-2    466323  131697  466293  131746  60  60
SRR7939018.47078489 II  466825  I   128234  -   -   DD  1   R1-2    466825  128234  466776  128196  60  60
SRR7939018.49885197 II  466825  I   128234  -   -   DD  1   R1-2    466825  128234  466776  128196  60  60
SRR7939018.66592188 II  466825  I   128234  -   -   DD  1   R1-2    466825  128234  466776  128196  60  60
SRR7939018.4121789  II  467056  I   177193  -   -   DD  1   R1-2    467056  177193  467007  177144  60  60
SRR7939018.19287999 II  468269  I   40626   +   +   DD  1   R1-2    468269  40626   468318  40675   60  60
SRR7939018.30711856 II  468269  I   40626   +   +   DD  1   R1-2    468269  40626   468318  40675   60  60
SRR7939018.28036525 II  468300  I   90438   -   -   DD  1   R1-2    468300  90438   468251  90389   60  60
SRR7939018.28394603 II  468657  I   112520  +   +   DD  1   R1-2    468657  112520  468706  112569  60  60      C:A:38:112553:34
SRR7939018.62726049 II  468691  I   153542  -   +   DD  1   R1-2    468691  153542  468642  153591  60  60
SRR7939018.30451727 II  469320  I   8900    -   -   DD  1   R1-2    469320  8900    469271  8851    60  60
SRR7939018.43360126 II  469483  I   33817   -   -   DD  1   R1-2    469483  33817   469440  33768   60  60


❯ #  Generate a report of how many records there are for chrom1 -----------------


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk '
pipe pipe quote>         { dict[$2] += 1 }
pipe pipe quote>         END { for (key in dict) { print key, dict[key] } }
pipe pipe quote>     '
XI 374760
IX 257637
XII 664945
XVI 510350
XV 595690
VIII 314828
XIV 441686
Mito 17181
I 127597
VII 589418
V 320307
II 462680
X 415222
VI 160124
III 182712
XIII 511948
IV 802302


❯ #NOTE
❯ #  Here, we have a dictionary named "dict". For each line, the key is the
❯ #+ second column entry (chrom1), and we increase its value by 1. After the
❯ #+ "END" keyword, we can write the "END" block commands, which are optional
❯ #+ commands to run after commands in the implicit BEGIN block
❯ #+ ("{ dict[$2] += 1 }"). In the END block, we loop on the dictionary and print
❯ #+ its (key, value) pairs. Keys are chrom1 values, values are associated
❯ #+ tallies.
❯ #+
❯ #+ Also, with "tail --lines=+46", we're specifying that we want to skip the
❯ #+ first 46 lines of the dataframe.


❯ #  Calculate the pos1 average -------------------------------------------------


❯ cat "${df}" | awk '{ pos1_sum += $3 } END { print pos1_sum/NR }'
447354


❯ #NOTE
❯ #  "NR" is a built-in variable that stores the current record number. So, in
❯ #+ the END block, it will be equal to the total number of records (lines).


❯ #  Only print records when chrom1 contain the character 'X' -------------------


❯ cat "${df}" | awk '$2 ~ /[X]/ { print $0 }' | head -50
#chromsize: IX 439888
#chromsize: X 745751
#chromsize: XI 666816
#chromsize: XII 1078177
#chromsize: XIII 924431
#chromsize: XIV 784333
#chromsize: XV 1091291
#chromsize: XVI 948066
SRR7939018.66658598 IX  9   I   921 +   +   DD  1   R1-2    9   921 38  970 8   60
SRR7939018.58305096 IX  15  I   124317  +   -   DD  1   R1-2    15  124317  63  124268  11  60
SRR7939018.43631354 IX  19657   I   20134   -   -   DD  1   R1-2    19657   20134   19608   20085   60  60
SRR7939018.36745485 IX  19711   I   36213   -   -   DD  1   R1-2    19711   36213   19662   36164   15  60
SRR7939018.62164291 IX  19714   I   190680  +   -   DD  1   R1-2    19714   190680  19763   190648  13  60
SRR7939018.58984906 IX  19730   I   192093  -   -   DD  1   R1-2    19730   192093  19681   192044  18  60
SRR7939018.50833750 IX  19734   I   29654   -   +   DD  1   R1-2    19734   29654   19685   29703   35  60
SRR7939018.51246125 IX  20271   I   186415  -   +   DD  1   R1-2    20271   186415  20222   186464  15  60
SRR7939018.40905882 IX  20325   I   12713   -   +   DD  1   R1-2    20325   12713   20276   12762   39  11
SRR7939018.64394488 IX  20343   I   14602   -   -   DD  1   R1-2    20343   14602   20294   14553   39  35
SRR7939018.16536655 IX  20472   I   37074   +   +   DD  1   R1-2    20472   37074   20521   37123   35  60
SRR7939018.20754901 IX  20472   I   37074   +   +   DD  1   R1-2    20472   37074   20521   37123   35  60
SRR7939018.29957664 IX  20472   I   37074   +   +   DD  1   R1-2    20472   37074   20521   37123   35  60
SRR7939018.27358489 IX  20748   I   191789  +   -   DD  1   R1-2    20748   191789  20797   191740  13  60
SRR7939018.57586420 IX  20768   I   96944   +   +   DD  1   R1-2    20768   96944   20817   96993   13  60
SRR7939018.37740214 IX  20810   I   198068  -   -   DD  1   R1-2    20810   198068  20761   198031  13  60
SRR7939018.45420751 IX  20878   I   36546   +   +   DD  1   R1-2    20878   36546   20927   36595   35  60
SRR7939018.20470841 IX  23673   I   142673  -   +   DD  1   R1-2    23673   142673  23624   142722  60  60
SRR7939018.64425973 IX  23774   I   77396   -   +   DD  1   R1-2    23774   77396   23725   77445   60  60
SRR7939018.34904689 IX  23813   I   48916   -   -   DD  1   R1-2    23813   48916   23764   48867   46  60
SRR7939018.52360824 IX  23813   I   48916   -   -   DD  1   R1-2    23813   48916   23764   48867   46  60
SRR7939018.39126400 IX  23848   I   148691  -   +   DD  1   R1-2    23848   148691  23799   148740  60  60
SRR7939018.44047987 IX  23888   I   106528  -   -   DD  1   R1-2    23888   106528  23844   106479  60  60
SRR7939018.32754444 IX  23912   I   133547  -   -   DD  1   R1-2    23912   133547  23863   133514  35  60
SRR7939018.56009420 IX  24127   I   88  -   -   DD  1   R1-2    24127   88  24078   39  60  60
SRR7939018.49111131 IX  24159   I   84918   -   -   DD  1   R1-2    24159   84918   24110   84869   60  60
SRR7939018.45523582 IX  24322   I   12575   -   +   DD  1   R1-2    24322   12575   24273   12624   60  11
SRR7939018.61906764 IX  24322   I   12575   -   +   DD  1   R1-2    24322   12575   24273   12624   60  11
SRR7939018.51693875 IX  24327   I   185697  -   +   DD  1   R1-2    24327   185697  24278   185746  60  60
SRR7939018.46680785 IX  24496   I   10784   -   -   DD  1   R1-2    24496   10784   24447   10735   53  60
SRR7939018.44065874 IX  24510   I   206529  +   +   DD  1   R1-2    24510   206529  24559   206575  35  4       C:T:40:206569:44
SRR7939018.15157468 IX  24523   I   179407  -   +   DD  1   R1-2    24523   179407  24474   179446  15  60      A:T:40:179424:18
SRR7939018.53602620 IX  24537   I   177682  +   -   DD  1   R1-2    24537   177682  24586   177633  53  60
SRR7939018.15318910 IX  24654   I   29271   -   -   DD  1   R1-2    24654   29271   24605   29229   60  60
SRR7939018.36119711 IX  24692   I   46788   +   +   DD  1   R1-2    24692   46788   24741   46827   60  60
SRR7939018.61854264 IX  24774   I   177290  -   +   DD  1   R1-2    24774   177290  24725   177339  60  60  T:G:13:24748:24 T:C:13:177300:11
SRR7939018.33661677 IX  24842   I   39631   +   -   DD  1   R1-2    24842   39631   24891   39582   60  60
SRR7939018.40293528 IX  24842   I   39631   +   -   DD  1   R1-2    24842   39631   24891   39582   60  60
SRR7939018.64145588 IX  24842   I   39631   +   -   DD  1   R1-2    24842   39631   24891   39582   60  60
SRR7939018.34145648 IX  24892   I   33960   +   -   DD  1   R1-2    24892   33960   24939   33911   60  60
SRR7939018.39464195 IX  24892   I   33960   +   -   DD  1   R1-2    24892   33960   24939   33911   60  60
SRR7939018.65293886 IX  24895   I   89839   +   +   DD  1   R1-2    24895   89839   24944   89883   60  60


❯ #NOTE
❯ #  Here, we specify that the column 2 value should match the regular expression
❯ #+ [X].


❯ #  Define a function to add a column if pos1 is lt or gt than 450000 ----------


cat "${df}" \
    | awk '
        function age_func(age) {
            if (pos1 < 450000) {
                return "lt"
            }
            return "gt"
        }
        { print $0 "\t" age_func($2) }
    ' \
    | tail --lines=+46 \
    | head -50
```
</details>
<br />

<a id="review-awk-tutorial-2"></a>
### Review awk [tutorial #2](https://www.tim-dennis.com/data/tech/2016/08/09/using-awk-filter-rows.html)
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Review awk tutorial #2</i></summary>

```bash
#!/bin/bash

#  Return lines when more complicated condition is met ========================
#+ ...in which chrom1 (field/column 2) has value "XII" and pos1
#+ (field/column 3) has values between 451575 and 468931
df=SRR7939018.dups.pairs.txt


#  Return how many fields (columns) are in our dataframe ----------------------
cat "${df}" \
    | tail --lines=+46 \
    | awk '{ print ++count " " NF }' \
    | head -20

#NOTE
#  Value varies from 16 to 18; if the values did not vary, then could pipe to
#+ uniq to return a single value
#+ 
#+ Also, "NF" is a built-in variable that stores information for the number of
#+ fields (columns)

#  "less" through the dataframe stream
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        cat "${df}" \
            | tail --lines=+46 \
            | less -N
    }


#  Use awk to search for a specific thing: a number we know exists ------------
cat "${df}" | awk '/451575/' | head

#NOTE
#  If we don't specify what fields to print out, awk will print the whole line
#+ that matches the search by default


#  Filter rows based on field values ------------------------------------------
cat "${df}" \
    | tail --lines=+46 \
    | awk '{
        if(($2 == "XII") || ($4 == "XII"))
        { print $0 }
    }' \
    | head -40
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Review awk tutorial #2</i></summary>

```txt
❯ #  Return lines when more complicated condition is met ========================
❯ #+ ...in which chrom1 (field/column 2) has value "XII" and pos1
❯ #+ (field/column 3) has values between 451575 and 468931


❯ df=SRR7939018.dups.pairs.txt


❯ #  Return how many fields (columns) are in our dataframe ----------------------


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk '{ print ++count " " NF }' \
pipe pipe>     | head -20
1 16
2 16
3 16
4 16
5 16
6 16
7 16
8 16
9 18
10 16
11 16
12 16
13 16
14 16
15 16
16 16
17 17
18 17
19 16
20 16


❯ #NOTE
❯ #  Value varies from 16 to 18; if the values did not vary, then could pipe to
❯ #+ uniq to return a single value
❯ #+
❯ #+ Also, "NF" is a built-in variable that stores information for the number of
❯ #+ fields (columns)


❯ #  "less" through the dataframe stream


❯ run=FALSE
❯ [[ "${run}" == TRUE ]] &&
cmdand>     {
cmdand cursh>         cat "${df}" \
cmdand cursh>             | tail --lines=+46 \
cmdand cursh pipe>             | less -N
cmdand cursh>     }


❯ #  Use awk to search for a specific thing: a number we know exists ------------


❯ cat "${df}" | awk '/451575/' | head
SRR7939018.54515756 II  687998  II  686001  +   -   DD  1   R1-2    687998  686001  688047  685952  60  60      G:C:27:685984:33
SRR7939018.45157505 II  755220  II  755134  +   -   DD  1   R1-2    755220  755134  755269  755085  60  60
SRR7939018.45157503 II  149708  IV  526675  +   +   DD  1   R1-2    149708  526675  149757  526724  60  60
SRR7939018.6984472  II  451575  Mito    37278   -   +   DD  1   R1-2    451575  37278   451526  37327   60  60
SRR7939018.34515757 II  85810   XIII    816201  +   +   DD  1   R1-2    85810   816201  85859   816250  60  60
SRR7939018.45157540 III 174627  I   109555  +   -   DD  1   R1-2    174627  109555  174676  109506  60  60
SRR7939018.45157538 III 42978   III 46767   -   +   DD  1   R1-2    42978   46767   42929   46809   60  60
SRR7939018.24515750 IV  177289  IV  177322  -   +   DD  1   R1-2    177289  177322  177240  177371  60  60      C:T:40:177329:8,A:G:40:177362:41
SRR7939018.45157550 IV  804863  IV  807640  -   +   DD  1   R1-2    804863  807640  804814  807686  1   60
SRR7939018.45157516 IV  901355  IV  897022  +   -   DD  1   R1-2    901355  897022  901404  896973  60  60


❯ #NOTE
❯ #  If we don't specify what fields to print out, awk will print the whole line
❯ #+ that matches the search by default


❯ #  Filter rows based on field values ------------------------------------------


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk '{
pipe pipe quote>         if(($2 == "XII") || ($4 == "XII"))
pipe pipe quote>         { print $0 }
pipe pipe quote>     }' \
pipe pipe>     | head -40
SRR7939018.23081466 I   46  XII 1063531 +   -   DD  1   R1-2    46  1063531 95  1063482 60  60
SRR7939018.50260165 I   67  XII 460221  -   -   DD  1   R1-2    67  460221  18  460172  42  60
SRR7939018.60888874 I   77  XII 540984  -   +   DD  1   R1-2    77  540984  28  541033  60  60  A:C:13:33:6
SRR7939018.59824978 I   104 XII 5771    +   -   DD  1   R1-2    104 5771    147 5737    48  7
SRR7939018.41945915 I   163 XII 1065040 -   +   DD  1   R1-2    163 1065040 123 1065083 8   31  G:A:38:135:22,C:T:40:140:27
SRR7939018.47114780 I   168 XII 1063334 -   -   DD  1   R1-2    168 1063334 119 1063285 60  60
SRR7939018.45956070 I   238 XII 634063  +   +   DD  1   R1-2    238 634063  287 634098  32  60
SRR7939018.31739477 I   262 XII 1049413 -   +   DD  1   R1-2    262 1049413 213 1049462 32  60
SRR7939018.66083278 I   267 XII 79  +   -   DD  1   R1-2    267 79  316 30  60  14  C:A:38:315:49   A:C:2:32:3,A:C:2:39:10,A:C:2:46:17
SRR7939018.45412085 I   289 XII 340761  -   -   DD  1   R1-2    289 340761  240 340712  32  60
SRR7939018.57852015 I   357 XII 576307  -   -   DD  1   R1-2    357 576307  308 576258  28  60
SRR7939018.7313216  I   360 XII 1063551 -   -   DD  1   R1-2    360 1063551 311 1063502 39  22
SRR7939018.46428479 I   367 XII 5717    +   -   DD  1   R1-2    367 5717    416 5688    39  3
SRR7939018.56560266 I   384 XII 1065035 +   +   DD  1   R1-2    384 1065035 433 1065084 53  42      T:G:32:1065083:49
SRR7939018.65313347 I   402 XII 949437  -   -   DD  1   R1-2    402 949437  353 949406  42  60
SRR7939018.12961638 I   423 XII 1064829 +   +   DD  1   R1-2    423 1064829 472 1064878 3   15
SRR7939018.56976102 I   437 XII 28247   -   +   DD  1   R1-2    437 28247   388 28290   60  60  C:G:40:395:8
SRR7939018.65266541 I   437 XII 28247   -   +   DD  1   R1-2    437 28247   388 28290   60  60  C:G:40:395:8
SRR7939018.25625072 I   443 XII 932394  -   -   DD  1   R1-2    443 932394  394 932345  60  60  C:G:40:395:2    G:A:40:932369:25
SRR7939018.64791186 I   445 XII 254950  -   -   DD  1   R1-2    445 254950  396 254901  60  60  C:G:40:395:0
SRR7939018.44048738 I   446 XII 1065041 -   +   DD  1   R1-2    446 1065041 397 1065079 60  16
SRR7939018.16333219 I   448 XII 1064222 -   -   DD  1   R1-2    448 1064222 399 1064173 60  8       T:C:38:1064183:11,T:A:40:1064194:22,A:C:38:1064220:48
SRR7939018.30830855 I   448 XII 1064222 -   -   DD  1   R1-2    448 1064222 399 1064173 60  8       T:C:40:1064183:11,T:A:40:1064194:22,A:C:32:1064220:48
SRR7939018.46615254 I   867 XII 71  -   -   DD  1   R1-2    867 71  818 22  15  17      A:C:13:27:6
SRR7939018.63133739 I   889 XII 985720  -   -   DD  1   R1-2    889 985720  854 985671  25  60
SRR7939018.36786180 I   908 XII 280646  -   +   DD  1   R1-2    908 280646  859 280695  39  60
SRR7939018.54360105 I   908 XII 280646  -   +   DD  1   R1-2    908 280646  859 280695  39  60
SRR7939018.59328538 I   919 XII 459975  -   -   DD  1   R1-2    919 459975  870 459926  35  60
SRR7939018.38509619 I   934 XII 394115  +   -   DD  1   R1-2    934 394115  983 394066  5   60  C:T:38:936:3,T:C:40:947:14,C:T:40:967:34,T:C:40:970:37
SRR7939018.56699149 I   982 XII 206001  +   -   DD  1   R1-2    982 206001  1031    205952  53  60
SRR7939018.31140889 I   1007    XII 11671   +   +   DD  1   R1-2    1007    11671   1042    11720   35  18      T:C:38:11671:1
SRR7939018.17225846 I   1056    XII 896226  +   -   DD  1   R1-2    1056    896226  1105    896177  9   60
SRR7939018.12757524 I   1196    XII 24754   +   +   DD  1   R1-2    1196    24754   1245    24803   9   60
SRR7939018.22265578 I   1275    XII 1064162 +   +   DD  1   R1-2    1275    1064162 1324    1064211 13  12      T:C:40:1064183:22,T:A:40:1064194:33
SRR7939018.49634025 I   1289    XII 200489  +   +   DD  1   R1-2    1289    200489  1338    200538  60  60  G:T:40:1302:14
SRR7939018.43715687 I   1300    XII 827830  +   +   DD  1   R1-2    1300    827830  1349    827879  60  60
SRR7939018.53797835 I   1318    XII 11251   +   -   DD  1   R1-2    1318    11251   1367    11213   39  3
SRR7939018.55147883 I   1335    XII 68898   -   +   DD  1   R1-2    1335    68898   1293    68947   60  60
SRR7939018.35843499 I   1352    XII 957534  -   +   DD  1   R1-2    1352    957534  1303    957566  60  60
SRR7939018.55862767 I   1357    XII 1038870 +   +   DD  1   R1-2    1357    1038870 1392    1038919 23  60
```
</details>
<br />

<a id="begin-to-write-and-test-usable-logic"></a>
### Begin to write and test usable logic
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Begin to write and test usable logic</i></summary>

```bash
#!/bin/bash

#  Return lines when more complicated condition is met (cont.) ================
#  Filter rows based on field values (cont.) ----------------------------------
cat "${df}" \
    | tail --lines=+46 \
    | awk '{
        if( \
            (($2 == "XII") || ($4 == "XII")) && \
            (($11 >= (451575 - 51)) && ($14 <= (468931 + 51))) \
        )
        { print $0 }
    }' \
    | head -40

#NOTE
#  The above logic is in the direction of what we want but is not actually what
#+ we want because
#+ (a) we only care about the conditions for $11 and $13 if $2 is "XII", and
#+ (b) we only care about the conditions for $12 and $14 if $4 is "XII";
#+ (c) if both $2 and $4 is "XII", then we care about the respective conditions
#+     for fields $11 through $14

#QUESTION #1
#  So what does the correct logic look like?
cat "${df}" \
    | tail --lines=+46 \
    | awk '{
        if(( \
            ($2 == "XII") && \
            (($11 >= 451524) && ($13 <= 468982)) \
        ) || ( \
            ($2 == "XII") && \
            (($12 >= 451524) && ($14 <= 468982)) \
        ))
        { print $0 }
    }' \
    | head -500

#ANSWER #1
#  This seems to be working; let's make it more readable and direct the stream
#+ to a temporary file, rDNA-tmp.txt, that we can check manually
outfile="rDNA-tmp.txt"
[[ -f "${outfile}" ]] && rm "${outfile}"

cat "${df}" \
    | tail --lines=+46 \
    | awk \
        -v left=451524 \
        -v right=468982 \
        '{
            if(( \
                ($2 == "XII") && \
                (($11 >= left) && ($13 <= right)) \
            ) || ( \
                ($2 == "XII") && \
                (($12 >= left) && ($14 <= right)) \
            ))
            { print $0 }
        }' \
        > "${outfile}"

#  This isn't quite right? I don't see records for when chrom2 is XII and
#+ chrom1 is not. Does the following work?
outfile="rDNA-tmp.txt"
[[ -f "${outfile}" ]] && rm "${outfile}"

cat "${df}" \
    | tail --lines=+46 \
    | awk \
        -v left=451524 \
        -v right=468982 \
        '{
            if(( \
                ($2 == "XII") && \
                (($11 >= left) && ($13 <= right)) \
            ) || ( \
                ($4 == "XII") && \
                (($12 >= left) && ($14 <= right)) \
            ))
            { print $0 }
        }' \
        > "${outfile}"

#QUESTION #2
#  Are we picking up pairs for the condition in which XII pos1 is between
#+ "left" and "right" AND XII pos2 is greater than "right"?
run_check=FALSE
[[ "${run_check}" == TRUE ]] &&
    {
        [[ -f "${outfile/.txt/.check.txt}" ]] && \
            rm "${outfile/.txt/.check.txt}"

        cat "${outfile}" \
            | awk \
                -v left=451524 \
                -v right=468982 \
                '{
                    if(( \
                        ($2 == "XII") && \
                        (($11 >= left) && ($13 <= right)) \
                    ) && ( \
                        ($4 == "XII") && \
                        (($12 >= right) || ($14 >= right)) \
                    ))
                    { print $0 }
                }' \
            | sort -k5,5n -k3,3n \
                > "${outfile/.txt/.check.txt}"
    }

#ANSWER #2
#  I mean, we capture 1044 lines that meet this condition, but that seems low
#+ to me.
#+ 
#+ Basically, I want to make sure I'm capturing all interactions in which one
#+ of the read pairs is within the 50-padded rDNA locus, and I'm worried my
#+ logic is missing some things, in particular as it pertains intra-XII non-
#+ rDNA interactions. Are there really so few interactions between the rDNA
#+ locus and right side of XII? What about between the rDNA locus and the left
#+ side of XII? #TODO #TOMORROW


#  More tests following a code and logic review -------------------------------
#+ The following day:
#+     After a ChatGPT code review, the following does the trick (basically, I
#+     got the implementation correct above, but what I wrote was a bit more
#+     complicated than necessary):
df=SRR7939018.dups.pairs.txt
outfile="rDNA-tmp-2.txt"  # echo "${outfile}"
[[ -f "${outfile}" ]] && rm "${outfile}"

run_check=FALSE
[[ "${run_check}" == TRUE ]] &&
    {
        cat "${df}" | tail --lines=+46 | head
    }

cat "${df}" \
    | tail --lines=+46 \
    | awk \
        -v left=451526 \
        -v right=468980 \
        '( \
            $2 == "XII" && $11 >= left && $11 <= right \
        ) || ( \
            $4 == "XII" && $12 >= left && $12 <= right \
        )' \
        > "${outfile}"

#  NOTE
#+ Not the change to the left- and right-most genomic coordinates: My initial
#+ work to take into account the counting system and read length was a bit off;
#+ here an explanation:
#+ 
#+ If the 5' position of a 50-bp read begins at coordinate 468931 in a 0-based
#+ coordinate system (which is what pairtools paired reads use), we can
#+ calculate the 3' position (end position) by adding the length of the read
#+ minus 1 to the starting position.
#+ 
#+ In this case, the read is 50 bases long, so to find the 3' position:
#+ - 3' position = 5' position + (read length - 1)
#+ - 3' position = 468931 + (50 - 1) = 468980
#+ 
#+ Therefore, the 3' position (end position) of the read would be 468980 in the
#+ 0-based coordinate system.
#+ 
#+ Likewise, if the 3' position of a 50-bp read is 451575 in a 0-based
#+ coordinate system, we can calculate the 5' position (start position) by
#+ subtracting the length of the read minus 1 from the ending position.
#+ 
#+ In this case, the read is 50 bases long, so to find the 5' position:
#+ 
#+ - 5' position = 3' position - (read length - 1)
#+ - 5' position = 451575 - (50 - 1) = 451526
#+ 
#+ Therefore, the 5' position (start position) of the read would be 451526 in
#+ the 0-based coordinate system.


#QUESTION #3
#  Are *-tmp.txt and *-tmp-2.txt identical?
cmp --silent *-tmp.txt *-tmp-2.txt \
    && echo "Files are the same" \
    || echo "Files are different"
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Begin to write and test usable logic</i></summary>

```txt
❯ #  Return lines when more complicated condition is met (cont.) ================


❯ #  Filter rows based on field values (cont.) ----------------------------------


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk '{
pipe pipe quote>         if( \
pipe pipe quote>             (($2 == "XII") || ($4 == "XII")) && \
pipe pipe quote>             (($11 >= (451575 - 51)) && ($14 <= (468931 + 51))) \
pipe pipe quote>         )
pipe pipe quote>         { print $0 }
pipe pipe quote>     }' \
pipe pipe>     | head -40
SRR7939018.56045172 II  451684  XII 374843  +   -   DD  1   R1-2    451684  374843  451733  374804  60  60
SRR7939018.65679004 II  451684  XII 374843  +   -   DD  1   R1-2    451684  374843  451733  374804  60  60
SRR7939018.41876606 II  451813  XII 239616  +   +   DD  1   R1-2    451813  239616  451862  239665  60  60
SRR7939018.66585246 II  451865  XII 404621  +   -   DD  1   R1-2    451865  404621  451914  404572  60  60
SRR7939018.55873769 II  451953  XII 261832  -   -   DD  1   R1-2    451953  261832  451904  261783  60  60
SRR7939018.55447416 II  452034  XII 388772  -   +   DD  1   R1-2    452034  388772  451991  388821  60  60
SRR7939018.17888176 II  452120  XII 421095  +   -   DD  1   R1-2    452120  421095  452162  421046  60  60
SRR7939018.58844820 II  452120  XII 421095  +   -   DD  1   R1-2    452120  421095  452162  421046  60  60
SRR7939018.64217248 II  452495  XII 62973   +   +   DD  1   R1-2    452495  62973   452544  63022   60  60
SRR7939018.41152490 II  452698  XII 389871  -   +   DD  1   R1-2    452698  389871  452649  389920  60  60
SRR7939018.57727498 II  452766  XII 235097  +   +   DD  1   R1-2    452766  235097  452815  235126  60  60
SRR7939018.36715168 II  453069  XII 312052  +   +   DD  1   R1-2    453069  312052  453118  312093  60  60
SRR7939018.30869723 II  453172  XII 174027  -   -   DD  1   R1-2    453172  174027  453123  173978  60  60      C:G:2:174010:33
SRR7939018.42201496 II  453461  XII 74579   +   -   DD  1   R1-2    453461  74579   453494  74530   60  60
SRR7939018.52786115 II  453461  XII 74579   +   -   DD  1   R1-2    453461  74579   453494  74530   60  60
SRR7939018.49485416 II  453471  XII 104724  +   -   DD  1   R1-2    453471  104724  453520  104675  60  60
SRR7939018.39389053 II  453515  XII 197410  -   +   DD  1   R1-2    453515  197410  453466  197459  60  60
SRR7939018.57613835 II  453532  XII 281518  -   -   DD  1   R1-2    453532  281518  453483  281474  60  60
SRR7939018.48054554 II  454047  XII 182417  +   +   DD  1   R1-2    454047  182417  454096  182466  60  60      T:G:40:182436:20
SRR7939018.28373541 II  454078  XII 401516  -   +   DD  1   R1-2    454078  401516  454044  401565  60  60
SRR7939018.54966002 II  454078  XII 401516  -   +   DD  1   R1-2    454078  401516  454044  401565  60  60      A:T:13:401520:5
SRR7939018.36810061 II  454082  XII 338358  +   -   DD  1   R1-2    454082  338358  454131  338309  60  60
SRR7939018.50364589 II  454125  XII 274295  +   -   DD  1   R1-2    454125  274295  454174  274252  60  60
SRR7939018.16078146 II  454232  XII 459835  -   +   DD  1   R1-2    454232  459835  454183  459884  60  60
SRR7939018.31524513 II  454304  XII 109229  -   +   DD  1   R1-2    454304  109229  454255  109269  60  60      A:G:38:109243:15
SRR7939018.48345152 II  454304  XII 109229  -   +   DD  1   R1-2    454304  109229  454255  109269  60  60      A:G:40:109243:15
SRR7939018.45805260 II  454347  XII 299825  +   +   DD  1   R1-2    454347  299825  454396  299874  60  60      A:G:40:299832:8,T:C:38:299833:9
SRR7939018.13738956 II  454429  XII 405029  -   +   DD  1   R1-2    454429  405029  454380  405078  60  60  C:T:40:454379:0
SRR7939018.49949611 II  454481  XII 29941   +   +   DD  1   R1-2    454481  29941   454530  29990   60  60
SRR7939018.63903643 II  454524  XII 432346  +   +   DD  1   R1-2    454524  432346  454573  432395  60  60
SRR7939018.45158244 II  454571  XII 182595  +   -   DD  1   R1-2    454571  182595  454620  182546  60  60
SRR7939018.59548020 II  454595  XII 460547  -   -   DD  1   R1-2    454595  460547  454560  460498  60  60
SRR7939018.43013788 II  454602  XII 406806  -   +   DD  1   R1-2    454602  406806  454553  406856  60  60
SRR7939018.57956583 II  454616  XII 252907  -   -   DD  1   R1-2    454616  252907  454567  252858  60  60
SRR7939018.60361848 II  454764  XII 266354  +   +   DD  1   R1-2    454764  266354  454813  266403  60  60  T:A:13:454763:0 T:G:27:266379:26
SRR7939018.31016430 II  454794  XII 81872   +   +   DD  1   R1-2    454794  81872   454843  81921   60  60
SRR7939018.50926930 II  454794  XII 460060  +   -   DD  1   R1-2    454794  460060  454843  460016  60  60
SRR7939018.61023911 II  454798  XII 163872  +   -   DD  1   R1-2    454798  163872  454847  163823  60  60
SRR7939018.22540540 II  454892  XII 55995   -   -   DD  1   R1-2    454892  55995   454843  55946   60  60
SRR7939018.61698103 II  454913  XII 459994  -   -   DD  1   R1-2    454913  459994  454864  459945  60  60


❯ #NOTE
❯ #  The above logic is in the direction of what we want but is not actually what
❯ #+ we want because
❯ #+ (a) we only care about the conditions for $11 and $13 if $2 is "XII", and
❯ #+ (b) we only care about the conditions for $12 and $14 if $4 is "XII";
❯ #+ (c) if both $2 and $4 is "XII", then we care about the respective conditions
❯ #+     for fields $11 through $14


❯ #QUESTION #1
❯ #  So what does the correct logic look like?


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk '{
pipe pipe quote>         if(( \
pipe pipe quote>             ($2 == "XII") && \
pipe pipe quote>             (($11 >= 451524) && ($13 <= 468982)) \
pipe pipe quote>         ) || ( \
pipe pipe quote>             ($2 == "XII") && \
pipe pipe quote>             (($12 >= 451524) && ($14 <= 468982)) \
pipe pipe quote>         ))
pipe pipe quote>         { print $0 }
pipe pipe quote>     }' \
pipe pipe>     | head -500
SRR7939018.63166949 XII 459752  I   61281   +   +   DD  1   R1-2    459752  61281   459801  61330   8   60
SRR7939018.40828734 XII 459804  I   143765  -   +   DD  1   R1-2    459804  143765  459755  143814  18  60
SRR7939018.50728185 XII 459832  I   158601  +   -   DD  1   R1-2    459832  158601  459881  158552  60  60
SRR7939018.26595707 XII 459835  I   153380  +   +   DD  1   R1-2    459835  153380  459884  153429  60  60
SRR7939018.25690470 XII 459838  I   61548   +   -   DD  1   R1-2    459838  61548   459887  61499   60  60
SRR7939018.40970756 XII 459838  I   61548   +   -   DD  1   R1-2    459838  61548   459887  61499   60  60
SRR7939018.47458575 XII 459838  I   87594   +   +   DD  1   R1-2    459838  87594   459887  87643   60  60
SRR7939018.36944452 XII 459842  I   87621   +   +   DD  1   R1-2    459842  87621   459891  87670   60  60
SRR7939018.57635905 XII 459842  I   174372  +   -   DD  1   R1-2    459842  174372  459891  174323  60  60
SRR7939018.48119520 XII 459852  I   112834  +   +   DD  1   R1-2    459852  112834  459901  112883  60  60
SRR7939018.30109429 XII 459852  I   180379  +   +   DD  1   R1-2    459852  180379  459901  180428  60  60
SRR7939018.42574013 XII 459852  I   180379  +   +   DD  1   R1-2    459852  180379  459901  180428  60  60
SRR7939018.29183919 XII 459868  I   51015   +   +   DD  1   R1-2    459868  51015   459917  51064   60  60
SRR7939018.28461637 XII 459869  I   71817   +   +   DD  1   R1-2    459869  71817   459918  71866   60  60
SRR7939018.17758539 XII 459869  I   79360   +   +   DD  1   R1-2    459869  79360   459918  79409   60  60
SRR7939018.59869136 XII 459869  I   115063  +   -   DD  1   R1-2    459869  115063  459918  115014  60  60
SRR7939018.55405809 XII 459869  I   178853  +   -   DD  1   R1-2    459869  178853  459918  178804  60  60
...


❯ #ANSWER #1
❯ #  This seems to be working; let's make it more readable and direct the stream
❯ #+ to a temporary file, rDNA-tmp.txt, that we can check manually


❯ outfile="rDNA-tmp.txt"


❯ [[ -f "${outfile}" ]] && rm "${outfile}"


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk \
pipe pipe>         -v left=451524 \
pipe pipe>         -v right=468982 \
pipe pipe>         '{
pipe pipe quote>             if(( \
pipe pipe quote>                 ($2 == "XII") && \
pipe pipe quote>                 (($11 >= left) && ($13 <= right)) \
pipe pipe quote>             ) || ( \
pipe pipe quote>                 ($2 == "XII") && \
pipe pipe quote>                 (($12 >= left) && ($14 <= right)) \
pipe pipe quote>             ))
pipe pipe quote>             { print $0 }
pipe pipe quote>         }' \
pipe pipe>         > "${outfile}"


❯ #  This isn't quite right? I don't see records for when chrom2 is XII and
❯ #+ chrom1 is not. Does the following work?


❯ outfile="rDNA-tmp.txt"


❯ [[ -f "${outfile}" ]] && rm "${outfile}"


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk \
pipe pipe>         -v left=451524 \
pipe pipe>         -v right=468982 \
pipe pipe>         '{
pipe pipe quote>             if(( \
pipe pipe quote>                 ($2 == "XII") && \
pipe pipe quote>                 (($11 >= left) && ($13 <= right)) \
pipe pipe quote>             ) || ( \
pipe pipe quote>                 ($4 == "XII") && \
pipe pipe quote>                 (($12 >= left) && ($14 <= right)) \
pipe pipe quote>             ))
pipe pipe quote>             { print $0 }
pipe pipe quote>         }' \
pipe pipe>         > "${outfile}"


❯ #QUESTION #2
❯ #  Are we picking up pairs for the condition in which XII pos1 is between
❯ #+ "left" and "right" AND XII pos2 is greater than "right"?


❯ run_check=FALSE


❯ [[ "${run_check}" == TRUE ]] &&
cmdand>     {
cmdand cursh>         [[ -f "${outfile/.txt/.check.txt}" ]] && \
cmdand cursh cmdand>             rm "${outfile/.txt/.check.txt}"
cmdand cursh>
cmdand cursh>         cat "${outfile}" \
cmdand cursh>             | awk \
cmdand cursh pipe>                 -v left=451524 \
cmdand cursh pipe>                 -v right=468982 \
cmdand cursh pipe>                 '{
cmdand cursh pipe quote>                     if(( \
cmdand cursh pipe quote>                         ($2 == "XII") && \
cmdand cursh pipe quote>                         (($11 >= left) && ($13 <= right)) \
cmdand cursh pipe quote>                     ) && ( \
cmdand cursh pipe quote>                         ($4 == "XII") && \
cmdand cursh pipe quote>                         (($12 >= right) || ($14 >= right)) \
cmdand cursh pipe quote>                     ))
cmdand cursh pipe quote>                     { print $0 }
cmdand cursh pipe quote>                 }' \
cmdand cursh pipe>             | sort -k5,5n -k3,3n \
cmdand cursh pipe pipe>                 > "${outfile/.txt/.check.txt}"
cmdand cursh>     }


❯ #ANSWER #2
❯ #  I mean, we capture 1044 lines that meet this condition, but that seems low
❯ #+ to me.
❯ #+
❯ #+ Basically, I want to make sure I'm capturing all interactions in which one
❯ #+ of the read pairs is within the 50-padded rDNA locus, and I'm worried my
❯ #+ logic is missing some things, in particular as it pertains intra-XII non-
❯ #+ rDNA interactions. Are there really so few interactions between the rDNA
❯ #+ locus and right side of XII? What about between the rDNA locus and the left
❯ #+ side of XII? #TODO #TOMORROW


❯ #  More tests following a code and logic review -------------------------------


❯ #+ The following day:
❯ #+     After a ChatGPT code review, the following does the trick (basically, I
❯ #+     got the implementation correct above, but what I wrote was a bit more
❯ #+     complicated than necessary):


❯ df=SRR7939018.dups.pairs.txt


❯ outfile="rDNA-tmp-2.txt"  # echo "${outfile}"


❯ [[ -f "${outfile}" ]] && rm "${outfile}"


❯ run_check=FALSE


❯ [[ "${run_check}" == TRUE ]] &&
cmdand>     {
cmdand cursh>         cat "${df}" | tail --lines=+46 | head
cmdand cursh>     }


❯ cat "${df}" \
>     | tail --lines=+46 \
pipe>     | awk \
pipe pipe>         -v left=451526 \
pipe pipe>         -v right=468980 \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && $11 >= left && $11 <= right \
pipe pipe quote>         ) || ( \
pipe pipe quote>             $4 == "XII" && $12 >= left && $12 <= right \
pipe pipe quote>         )' \
pipe pipe>         > "${outfile}"


❯ #  NOTE
❯ #+ Not the change to the left- and right-most genomic coordinates: My initial
❯ #+ work to take into account the counting system and read length was a bit off;
❯ #+ here an explanation:
❯ #+ 
❯ #+ If the 5' position of a 50-bp read begins at coordinate 468931 in a 0-based
❯ #+ coordinate system (which is what pairtools paired reads use), we can
❯ #+ calculate the 3' position (end position) by adding the length of the read
❯ #+ minus 1 to the starting position.
❯ #+ 
❯ #+ In this case, the read is 50 bases long, so to find the 3' position:
❯ #+ - 3' position = 5' position + (read length - 1)
❯ #+ - 3' position = 468931 + (50 - 1) = 468980
❯ #+ 
❯ #+ Therefore, the 3' position (end position) of the read would be 468980 in the
❯ #+ 0-based coordinate system.
❯ #+ 
❯ #+ Likewise, if the 3' position of a 50-bp read is 451575 in a 0-based
❯ #+ coordinate system, we can calculate the 5' position (start position) by
❯ #+ subtracting the length of the read minus 1 from the ending position.
❯ #+ 
❯ #+ In this case, the read is 50 bases long, so to find the 5' position:
❯ #+ 
❯ #+ - 5' position = 3' position - (read length - 1)
❯ #+ - 5' position = 451575 - (50 - 1) = 451526
❯ #+ 
❯ #+ Therefore, the 5' position (start position) of the read would be 451526 in
❯ #+ the 0-based coordinate system.


❯ #QUESTION #3
❯ #  Are *-tmp.txt and *-tmp-2.txt identical?


❯ cmp --silent *-tmp.txt *-tmp-2.txt \
>     && echo "Files are the same" \
cmdand>     || echo "Files are different"
Files are the same
```
</details>
<br />
<br />

<a id="slouching-toward-obtaining-and-processing-rdna-multimappers"></a>
## Slouching toward obtaining and processing rDNA multimappers
<a id="tests-in-which-i-had-not-yet-determined-how-to-retain-multimappers"></a>
### Tests in which I had not yet determined how to retain multimappers
<a id="check-that-we-have-deduplicated-rdna-read-pairs"></a>
#### Check that we have deduplicated rDNA read pairs
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Check that we have deduplicated rDNA read pairs</i></summary>

```bash
#!/bin/bash

#  Pull all XII records from the dataframe ------------------------------------
nodups="SRR7939018.nodups.pairs.gz"
nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"
[[ -f "${nodups_12}" ]] && rm "${nodups_12}"

zcat < "${nodups}" \
    | tail --lines=+46 \
    | awk '($2 == "XII" || $4 == "XII")' \
        > "${nodups_12}"


#  Manually survey rDNA-tmp-2.txt versus SRR7939018.dups.pairs.XII.txt,
#+ working to answer the question, "Are rDNA records truly not amid the
#+ deduplicated records?"
ls -lhaFG "${nodups}"
ls -lhaFG "${nodups_12}"

zcat < "${nodups}" | tail --lines=+46 | wc -l
cat < "${nodups_12}" | wc -l

#NOTE
#  This is a bit difficult to check because there are numerous records
#+ at/around XII:460000 present in SRR7939018.dups.pairs.XII.txt; I should
#+ (a) '($2 == "XII" || $4 == "XII")' records and also
#+ (b) filter only those records that are before the rDNA locus padded start
#+     AND after the rDNA locus padded end, which would look a bit like
#+     '(($11 <= left && $11 >= right) && ($12 <= left && $12 >= right))'
#+ 
#+ In practice, this is the call to awk (I think):
#+ awk '( \
#+     ( \
#+         $2 == "XII" && $11 <= left && $11 >= right \
#+     ) || ( \
#+         $4 == "XII" && $12 <= left && $12 >= right \
#+     ) \
#+ )'
nodups="SRR7939018.nodups.pairs.gz"
nodups_12_rDNA="${nodups/.pairs.gz/.pairs.XII.no-rDNA.txt}"
[[ -f "${nodups_12_rDNA}" ]] && rm "${nodups_12_rDNA}"

zcat < "${nodups}" \
    | tail --lines=+46 \
    | awk \
        -v left=451526 \
        -v right=468980 \
        '( \
            $2 == "XII" && ($11 <= left || $11 >= right) \
        ) || ( \
            $4 == "XII" && ($12 <= left || $12 >= right) \
        )' \
    > "${nodups_12_rDNA}"

#  Manually survey rDNA-tmp-2.txt versus SRR7939018.dups.pairs.XII.no-rDNA.txt
ls -lhaFG "${nodups}"
ls -lhaFG "${nodups_12_rDNA}"

zcat < "${nodups}" | tail --lines=+46 | wc -l
cat < "${nodups_12_rDNA}" | wc -l

#NOTE
#  Rows like this survive the filtering:
#+ SRR7939018.7779171  XII 459949  XII 255723  -   +   UU  1   R1-2    459949  255723  459900  255772  60  60      
#+ 
#+ Because $2/$11 is gt left AND lf right, I want it to be excluded. So, do I
#+ need to change the '||' in ') || ( \' to '&&'?
#+ 
#+ I think so. I think to need stream the data through awk, the first time
#+ using the updated logic (in which '||' becomes "&&") and the second time
#+ using the previous logic.
le=451526
ri=468980
nodups="SRR7939018.nodups.pairs.gz"
nodups_12_rDNA_comp="${nodups/.pairs.gz/.pairs.XII.no-rDNA-complete.txt}"
[[ -f "${nodups_12_rDNA_comp}" ]] && rm "${nodups_12_rDNA_comp}"

zcat < "${nodups}" \
    | tail --lines=+46 \
    | awk \
        -v left="${le}" \
        -v right="${ri}" \
        '( \
            $2 == "XII" && ($11 <= left || $11 >= right) \
        ) && ( \
            $4 == "XII" && ($12 <= left || $12 >= right) \
        )' \
    | awk \
        -v left="${le}" \
        -v right="${ri}" \
        '( \
            $2 == "XII" && ($11 <= left || $11 >= right) \
        ) || ( \
            $4 == "XII" && ($12 <= left || $12 >= right) \
        )' \
    > "${nodups_12_rDNA_comp}"

#  Manually survey rDNA-tmp-2.txt versus
#+ SRR7939018.dups.pairs.XII.no-rDNA-complete.txt
ls -lhaFG "${nodups}"
ls -lhaFG "${nodups_12_rDNA}"
ls -lhaFG "${nodups_12_rDNA_comp}"

zcat < "${nodups}" | tail --lines=+46 | wc -l
cat < "${nodups_12_rDNA}" | wc -l
cat < "${nodups_12_rDNA_comp}" | wc -l

#  While we're looking at things, get a version of the dataframe for all
#+ records associated with XII
nodups="SRR7939018.nodups.pairs.gz"
nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"

zcat < "${nodups}" \
    | tail --lines=+46 \
    | awk '($2 == "XII" || $4 == "XII")' \
        > "${nodups_12}"

```
</details>
<br />

<a id="printed-4"></a>
##### Printed
<details>
<summary><i>Printed: Check that we have deduplicated rDNA read pairs</i></summary>

```txt
❯ #  Pull all XII records from the dataframe ------------------------------------


❯ nodups="SRR7939018.nodups.pairs.gz"


❯ nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"


❯ [[ -f "${nodups_12}" ]] && rm "${nodups_12}"


❯ zcat < "${nodups}" \
>     | tail --lines=+46 \
pipe>     | awk '($2 == "XII" || $4 == "XII")' \
pipe pipe>         > "${nodups_12}"


❯ ls -lhaFG "${nodups}"
-rwx------  1 kalavatt  staff   748M Jul  6 12:41 SRR7939018.nodups.pairs.gz*


❯ ls -lhaFG "${nodups_12}"
-rw-r--r--  1 kalavatt  staff   351M Jul 10 08:55 SRR7939018.nodups.pairs.XII.txt


❯ #NOTE
❯ #  This is a bit difficult to check because there are numerous records
❯ #+ at/around XII:460000 present in SRR7939018.dups.pairs.XII.txt; I should
❯ #+ (a) '($2 == "XII" || $4 == "XII")' records and also
❯ #+ (b) filter only those records that are before the rDNA locus padded start
❯ #+     AND after the rDNA locus padded end, which would look a bit like
❯ #+     '(($11 <= left && $11 >= right) && ($12 <= left && $12 >= right))'
❯ #+
❯ #+ In practice, this is the call to awk (I think):
❯ #+ awk '( \
❯ #+     ( \
❯ #+         $2 == "XII" && $11 <= left && $11 >= right \
❯ #+     ) || ( \
❯ #+         $4 == "XII" && $12 <= left && $12 >= right \
❯ #+     ) \
❯ #+ )'


❯ nodups="SRR7939018.nodups.pairs.gz"


❯ nodups_12_rDNA="${nodups/.pairs.gz/.pairs.XII.no-rDNA.txt}"


❯ [[ -f "${nodups_12_rDNA}" ]] && rm "${nodups_12_rDNA}"


❯ zcat < "${nodups}" \
>     | tail --lines=+46 \
pipe>     | awk \
pipe pipe>         -v left=451526 \
pipe pipe>         -v right=468980 \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && ($11 <= left || $11 >= right) \
pipe pipe quote>         ) || ( \
pipe pipe quote>             $4 == "XII" && ($12 <= left || $12 >= right) \
pipe pipe quote>         )' \
pipe pipe>     > "${nodups_12_rDNA}"


❯ #  Manually survey rDNA-tmp-2.txt versus SRR7939018.dups.pairs.XII.no-rDNA.txt


❯ ls -lhaFG "${nodups}"
-rwx------  1 kalavatt  staff   748M Jul  6 12:41 SRR7939018.nodups.pairs.gz*


❯ ls -lhaFG "${nodups_12_rDNA}"
-rw-r--r--@ 1 kalavatt  staff   332M Jul 10 09:39 SRR7939018.nodups.pairs.XII.no-rDNA.txt


❯ zcat < "${nodups}" | tail --lines=+46 | wc -l
 31204815


❯ cat < "${nodups_12_rDNA}" | wc -l
 3667779


❯ le=451526
❯ ri=468980
❯ nodups="SRR7939018.nodups.pairs.gz"
❯ nodups_12_rDNA_comp="${nodups/.pairs.gz/.pairs.XII.no-rDNA-complete.txt}"


❯ [[ -f "${nodups_12_rDNA_comp}" ]] && rm "${nodups_12_rDNA_comp}"


❯ zcat < "${nodups}" \
>     | tail --lines=+46 \
pipe>     | awk \
pipe pipe>         -v left="${le}" \
pipe pipe>         -v right="${ri}" \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && ($11 <= left || $11 >= right) \
pipe pipe quote>         ) && ( \
pipe pipe quote>             $4 == "XII" && ($12 <= left || $12 >= right) \
pipe pipe quote>         )' \
pipe pipe>     | awk \
pipe pipe pipe>         -v left="${le}" \
pipe pipe pipe>         -v right="${ri}" \
pipe pipe pipe>         '( \
pipe pipe pipe quote>             $2 == "XII" && ($11 <= left || $11 >= right) \
pipe pipe pipe quote>         ) || ( \
pipe pipe pipe quote>             $4 == "XII" && ($12 <= left || $12 >= right) \
pipe pipe pipe quote>         )' \
pipe pipe pipe>     > "${nodups_12_rDNA_comp}"


❯ #  Manually survey rDNA-tmp-2.txt versus
❯ #+ SRR7939018.dups.pairs.XII.no-rDNA-complete.txt


❯ ls -lhaFG "${nodups}"
-rwx------  1 kalavatt  staff   748M Jul  6 12:41 SRR7939018.nodups.pairs.gz*


❯ ls -lhaFG "${nodups_12_rDNA}"
-rw-r--r--@ 1 kalavatt  staff   332M Jul 10 09:39 SRR7939018.nodups.pairs.XII.no-rDNA.txt


❯ ls -lhaFG "${nodups_12_rDNA_comp}"
-rw-r--r--  1 kalavatt  staff   151M Jul 10 10:08 SRR7939018.nodups.pairs.XII.no-rDNA-complete.txt


❯ zcat < "${nodups}" | tail --lines=+46 | wc -l
 31204815


❯ cat < "${nodups_12_rDNA}" | wc -l
 3667779


❯ cat < "${nodups_12_rDNA_comp}" | wc -l
 1655170


❯ #  While we're looking at things, get a version of the dataframe for all
❯ #+ records associated with XII


❯ nodups="SRR7939018.nodups.pairs.gz"


❯ nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"


❯ zcat < "${nodups}" \
>     | tail --lines=+46 \
pipe>     | awk '($2 == "XII" || $4 == "XII")' \
pipe pipe>         > "${nodups_12}"
```
</details>
<br />

<a id="notes-1"></a>
##### Notes
<details>
<summary><i>Notes: Check that we have deduplicated rDNA read pairs</i></summary>

OK, it seems like this is not the way to be going about things&mdash;multimapping reads have not even made it to this stage of the analysis (i.e., the [pairtools dedup](https://pairtools.readthedocs.io/en/latest/cli_tools.html#pairtools-dedup) stage). When looking `rDNA-tmp.txt`, for example, the regex '`\tXII\t461\d{3}\tXII\t461\d{3}`' cannot be found, revealing that read pairs with both mates originating in XII:461000-461999 are not present in neither `SRR7939018.dups.pairs.gz`, nor are they present in `SRR7939018.nodups.pairs.gz`

So, are they present in `SRR7939018.unmapped.pairs.gz`? No, no chromosome and position information is assigned `MM` records.

What about `SRR7939018.sort.txt.gz` (from `04_sort`)? No, in this file, `MM` records are also lacking chromosome and position information.

What about `SRR7939018.p2.txt.gz` (from `03_parse`)? No&mdash;same as above.

What about `SRR7939018.bam` (from `02_align`)?
```txt
SRR7939018.1    77      *       0       0       *       *       0       0       TNTTANNNNNNNNNNNNNNNNGCGAAGGTGANAGTTGGTTGATACTTTCA      G#<<G################<<<GGGIGGG#<<<GGGIIIIIIIIGIII      AS:i:0  XS:i:0
SRR7939018.1    141     *       0       0       *       *       0       0       ACGAATCTTNCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIGII#<G######################################      AS:i:0  XS:i:0
SRR7939018.2    77      *       0       0       *       *       0       0       TCTTTNNNNNNNNNNNNNNNANNGNAACGTTNNNNNNNANNAGNNNGCGT      GGGGG#############################################      AS:i:0  XS:i:0
SRR7939018.2    141     *       0       0       *       *       0       0       CGTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGG#############################################      AS:i:0  XS:i:0
SRR7939018.3    77      *       0       0       *       *       0       0       TGCAGGANNNNNNTNNTTNNGANTTTACGCANNNNCAGGGAAAAGTTGCT      GGGGGII######<##<<##<<#<<GGGIII####<<GGIIIIIIIIIGI      AS:i:0  XS:i:0
SRR7939018.3    141     *       0       0       *       *       0       0       ACCACNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGG#############################################      AS:i:0  XS:i:0
SRR7939018.4    77      *       0       0       *       *       0       0       ACCCACTATCCTNGCCGGTTCGGTGGCCAGCNNAAACTTTCGATTCCCCT      GGGGGIIIIIII#<GGGIIIIIIIIIIIIII##<<GGIIIIIIIIIIIII      AS:i:0  XS:i:0
SRR7939018.4    141     *       0       0       *       *       0       0       TCCTCTTCTNCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIIII#<G######################################      AS:i:0  XS:i:0
SRR7939018.5    77      *       0       0       *       *       0       0       ANACANNNNNNNNNNNNNNNNNCGTTTTATANATGAGTTATGAATTCCTT      G#################################################      AS:i:0  XS:i:0
SRR7939018.5    141     *       0       0       *       *       0       0       AAATTCGGTACCAANTCTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      A<A<AAGGGIA#######################################      AS:i:0  XS:i:0
SRR7939018.6    117     XII     451447  0       *       =       451447  0       AAAAAAATACTTAGTTGGGAGGTACTTCANNNNNNNNNNNNNNNNGACNA      IIIIIIIGIIIIIIIIIIGGIIIIGGG<<################G<<#G      MC:Z:50M        AS:i:0  XS:i:0
SRR7939018.6    185     XII     451447  0       50M     =       451447  0       AAAACTGCTCCATGAAGCAAACTGTCCGGGCAAATCCTTTCACGCTCGGG      IGG<IIGIIIIIIIIGIIIGGIIIIIIIIIIIIIIIIIGIIIIIIGGGGG      NM:i:0  MD:Z:50 AS:i:50 XS:i:50 XA:Z:XII,-460584,50M,0;
SRR7939018.7    117     XII     462547  0       *       =       462547  0       ACTTTTTCACTCTCTTTTCAAAGTTCTTTNNNNNNNNNNNNNNNNGTACT      GIIIIIIIGIIIGIIIIIIIIIIIGGG<<################GGGGG      MC:Z:9S41M      AS:i:0  XS:i:0
SRR7939018.7    185     XII     462547  0       9S41M   =       462547  0       NNNNNNNNNAGCCAGCAAAGGTGCTGGCCTCTTCCAGCCATAAGACCCCA      #########IIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGG      NM:i:0  MD:Z:41 AS:i:41 XS:i:41 XA:Z:XII,-453410,9S41M,0;
SRR7939018.8    69      II      775703  0       *       =       775703  0       AACTGNNNNNNNNNNNNNNNNAATGGAACAGATGAACTCAAAACTCCAAA      GGGGG################<<<GGIIIIIIIIIIIIIIIIIIIIIIII      MC:Z:50M        AS:i:0  XS:i:0
SRR7939018.8    137     II      775703  60      50M     =       775703  0       TGAACGTCGCTAAGCAATTGACCCATTTCAAGATCAATAACAAGGTCCGT      GGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIG      NM:i:0  MD:Z:50 AS:i:50 XS:i:0
SRR7939018.9    77      *       0       0       *       *       0       0       AGGCANNNNNNNNNNNNNNNACCTTAATGTGNTACTTATGGTACATATAT      GGGGG###############<<<GGIIIIII#<GGGIGIGIGIIIIIIII      AS:i:0  XS:i:0
SRR7939018.9    141     *       0       0       *       *       0       0       TGTCTATGGCCCGGNCGANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GAGGGIIIIIIIII#<<G################################      AS:i:0  XS:i:0
SRR7939018.10   117     II      10203   0       *       =       10203   0       GATTAGTTTCGAACTTTTNAGGGGAATCTGNNNNNNNNNNNNNNNATTCT      IIIIIIIIIIIIGIGGG<#IIIIIGGG<<<###############GGGGG      MC:Z:12S38M     AS:i:0  XS:i:0
SRR7939018.10   185     II      10203   60      12S38M  =       10203   0       NNNNNNNNNNNNTATTACNNCACTGCTGATCGGTCTCGTTCTTCATCTCT      ############IGGG<<##GGIIIIIIIIIIIIIIIIGIIIIIIGGGGG      NM:i:2  MD:Z:6C0G30     AS:i:34 XS:i:0
SRR7939018.11   77      *       0       0       *       *       0       0       TTGAGCCNNNNNNGNNCCNNAATGACTTCGANTTTGTCCACCGGGTTGGC      GGGGGIG######<##<<##<<GGGIGIIIG#<<GGGGGGIIIIIIIIII      AS:i:0  XS:i:0
SRR7939018.11   141     *       0       0       *       *       0       0       AAGGAGGATGCCAAGCCAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIIIIIIIIIIIIII###############################      AS:i:0  XS:i:0
SRR7939018.12   77      *       0       0       *       *       0       0       TGCCATANNNNNNGNACANNGAATGAGTCATNTCCACACCTAAAAATGTG      GAAAAGA######<#...##<<<AGAAGGGI#<GGGGGGGGIGIIGAGGG      AS:i:0  XS:i:0
SRR7939018.12   141     *       0       0       *       *       0       0       TGTGTCTGTAAGAGATAGAATCNNCNTNNNNNNNNNNNNNNNNNNNNNNN      GGGGGGGIIIIIGGIIIIGGIG############################      AS:i:0  XS:i:0
SRR7939018.13   117     VIII    212696  0       *       =       212696  0       TTATCCGATGTGACGCTGCAGCTTCTCAATNATATNCNNNNANGCTTTGA      GGAG<GGGGGG.GGA.GGGAGG<.GGA<..#..<<#<####.#IGAAGAG      MC:Z:9S41M      AS:i:0  XS:i:0
SRR7939018.13   185     VIII    212696  0       9S41M   =       212696  0       NNNNNNNNNGGAAGTTAATTAATTCGCTGAACATTTTATGTGATGATTGA      #########GGGIGGGGIGGG<GGGGIGGIIIIGIIIIGGGGGGAGAGAG      NM:i:0  MD:Z:41 AS:i:41 XS:i:41 XA:Z:VIII,-214694,9S41M,0;
SRR7939018.14   117     XII     459277  0       *       =       459277  0       GTGGACAGAGGAAAAGGTNCGAGGGCAGGGACGTAATCAACGCAAGCTGA      GGGGGGGIIGGGGGGA<<#IGGGGGGGGGIIGIGGGGIGAGG.<GAAGAG      MC:Z:12S38M     AS:i:0  XS:i:0
SRR7939018.14   185     XII     459277  0       12S38M  =       459277  0       NNNNNNNNNNNNCCGTCANNATCGCCCGCATCCGGTGCCGTAAATGCAAA      #############GG<<.##GIGGGGGIIIIGIIIGGAGAGGGIIGGAGG      NM:i:2  MD:Z:6T0T30     AS:i:34 XS:i:34 XA:Z:XII,-468414,12S38M,2;
SRR7939018.15   65      II      734242  60      50M     =       735917  1676    AGACTACTAATCTCGGAGTACATTTTCTGCAAGGCGGTGATATAACTCTG      GAGGAGIGIAGAGGGGGGGGGGGGGIGGGGIIIIIIGGIIGGIGGGGGGG      NM:i:0  MD:Z:50 MC:Z:44M6S      AS:i:50 XS:i:0
SRR7939018.15   129     II      735917  60      44M6S   =       734242  -1676   ATGTAGCATCGTGATCGTAGAAGTAGCCATTGTTACTGTATCGGNNNNNN      AAGAAGGGIIIGGAGGGGIIIIGGGGGGIGIGGAAGGGGGIIIG######      NM:i:0  MD:Z:44 MC:Z:50M        AS:i:44 XS:i:0
SRR7939018.16   97      I       188716  0       50M     =       188921  244     TTGCTCAAGGCAGCGGAGATCGAACGACAAGCTCAGGAAAATTACTGGCG      GAGA.<<AGGAAGGGGGGGIIGIGGIGGGIGIIIIII.AGIIGGIIGGIG      NM:i:0  MD:Z:50 MC:Z:11S39M     AS:i:50 XS:i:50 XA:Z:VII,+404296,50M,0;
SRR7939018.16   145     I       188921  60      11S39M  =       188716  -244    NNNNNNNNNNNTGGACCCATTTGCTGAACAAAGTGGTTCATTGCCTACCT      ###########GGGGGGGGAAGGGA.GGGGGIIGGGAAGGGGGGGGAGGA      NM:i:0  MD:Z:39 MC:Z:50M        AS:i:39 XS:i:0
SRR7939018.17   121     V       15002   60      50M     =       15002   0       GTTGATCAATTGCGATTTNAACACACATTTTCAAATGTCATTTTGCGCTT      IIIIIIIIIIIIIIGGG<#IIIIIIIIIIIIIIIIIIIIIIIIIIGGGGG      NM:i:1  MD:Z:18T31      AS:i:48 XS:i:0
SRR7939018.17   181     V       15002   0       *       =       15002   0       NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNTATNTTTGATATTGGTGA      ################################GG<#IIGIIIIIIGGGGG      MC:Z:50M        AS:i:0  XS:i:0
SRR7939018.18   65      XIII    906996  60      50M     =       904641  -2356   GTACCTTTCGTTAAGGCGAATTTTCTGGACCATGCGCAGATCTGATCCAA      AGGGAGGIIIIIIGGGGIGGIAGGIGGGGGIIIIIIIGIIIGGIIGIIGI      NM:i:0  MD:Z:50 MC:Z:44M6S      AS:i:50 XS:i:0
SRR7939018.18   129     XIII    904641  60      44M6S   =       906996  2356    GGGACAATGGTCCCTTTTTGAGAAAATGTTGTAGGCTTGGCCATNNNNNN      GAGAGGIIGIGGGGIGAGGIIGAGIGGIGGGGGGGIIG<GGIGA######      NM:i:0  MD:Z:44 MC:Z:50M        AS:i:44 XS:i:0
SRR7939018.19   77      *       0       0       *       *       0       0       CCTTCTTATAACAGCTTTACGGGAGATTGTGNTGCAATTTGCTCAACATC      GGGGGIIIIIIIIIIIIIIGIIIIIIIIIII#<GGIIIIIIIIIIIIIII      AS:i:0  XS:i:0
SRR7939018.19   141     *       0       0       *       *       0       0       TGACACTAGTTATAAAATTGATNNANNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIIIIIIIIIIIIIIIII############################      AS:i:0  XS:i:0
SRR7939018.20   73      IV      801779  60      46M4S   =       801779  0       TTCATCTTCTCCAGAGCTACTCTCAGTACTTNCCCCTGAGACTGATAAGC      GGGGGIIGIIIIIIIIIIIIIIIIGGGGIII#<<GGGIGIIIIIIIIIII      NM:i:1  MD:Z:31T14      AS:i:44 XS:i:0
SRR7939018.20   133     IV      801779  0       *       =       801779  0       TCTCAATTGTGCCGNAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN      GGGGGIIIIIIIII####################################      MC:Z:46M4S      AS:i:0  XS:i:0
SRR7939018.21   81      XII     462755  0       9S41M   =       462333  -463    AGCGGTTCTAGGCCTTTGAAACGGAGCTTCCCCATCTCTTAGGATCGACT      IIIIIIIIIIIIGIGIIIGGIGIGIGGGGGIIIIIIIIIGIIIGGGGGGG      NM:i:0  MD:Z:41 MC:Z:44M6S      AS:i:41 XS:i:41 XA:Z:XII,-453618,9S41M,0;
SRR7939018.21   161     XII     462333  0       44M6S   =       462755  463     ACGCCCGCTGCGTCTGACCAAGGCCCTCACTACCCGACCCTTAGNNNNNN      GGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIGGGGGII.AGGGG######      NM:i:0  MD:Z:44 MC:Z:9S41M      AS:i:44 XS:i:44 XA:Z:XII,+453196,44M6S,0;
SRR7939018.22   97      XII     466279  0       50M     =       490062  23833   TGGAGCTGGAATTACCGCGGCTGCTGGCACCAGACTTGCCCTCCAATTGT      GGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII      NM:i:0  MD:Z:50 MC:Z:50M        AS:i:50 XS:i:50 XA:Z:XII,+457142,50M,0;
SRR7939018.22   145     XII     490062  0       50M     =       466279  -23833  CTTCGCGGCAATGCCTGATCAGACAGCCGCAAAAACAAATTATCCGAATG      IGIIIIIIIIGGIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGGGG      NM:i:1  MD:Z:36C13      MC:Z:50M        AS:i:45 XS:i:45 XA:Z:XII,-452094,50M,1;XII,-461231,50M,1;
SRR7939018.23
```

It's not super clear what I can do with this... Well, I have sent an email to Seungsoo Kim, the analyst who did the Micro-C analyses for the 2019 *Mol Cell* paper. Before digging into this even deeper, let's take a break until we here back from him. We risk wasting time on a solution that has already been discovered, and which just needs to be communicated.

However, if I were to continue on, I think my next steps would be to...
- Identify, tally, and define the flags present in the `SRR7939018.bam`
- Look into how I can isolate <u>paired</u> alignments (*cis* and *trans*) associated with XII, then subset those for records with at least one mate in the padded rDNA locus
- From there... it's not so clear how to do this within the pairtools framework&mdash;this is where input from Seungsoo Kim could be helpful
    + It may be that I need to switch away from `bwa mem`/`pairtools`

Also, for the time being, leave the temporary files in `2023-0307_work_Micro-C_align-process`.
</details>
<br />

<a id="scraps"></a>
##### Scraps
<details>
<summary><i>Scraps: Check that we have deduplicated rDNA read pairs</i></summary>

- In `SRR7939018.nodups.pairs.XII.txt`, the regex '`XII\t461\d{3}`' matches nothing.
- In `rDNA-tmp.txt`,
    + the regex '`XII\t461\d{3}`' matches nothing
    + the regex '`XII\t462\d{3}`' matches nothing
    + the regex '`XII\t463\d{3}`' matches nothing
    + the regex '`XII\t464\d{3}`' matches nothing
    + same with 465&ndash;488
    + however, with '`XII\t489\d{3}`', we start getting matches again
- In `SRR7939018.dups.pairs.txt`,
    + the regex '`XII\t461\d{3}`' matches nothing
    + the regex '`XII\t462\d{3}`' matches nothing
</details>
<br />
<br />

<a id="work-after-i-had-determined-a-strategy-to-retain-rdna-multimappers"></a>
### Work after I had determined a strategy to retain rDNA multimappers
<a id="check-that-we-have-deduplicated-rdna-read-pairs-1"></a>
#### Check that we have deduplicated rDNA read pairs
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Check that we have deduplicated rDNA read pairs</i></summary>

```bash
#!/bin/bash

#  Create necessary dataframes ------------------------------------------------
nodups="SRR7939018.rDNA.nodups.pairs.gz"  # ls -lhaFG "${nodups}"
nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"  # echo "${nodups_12}"
nodups_12_no_rDNA="${nodups/.pairs.gz/.pairs.XII.no-rDNA.txt}"  # echo "${nodups_12_no_rDNA}"
nodups_12_rDNA="${nodups/.pairs.gz/.pairs.XII.rDNA.txt}"  # echo "${nodups_12_rDNA}"

[[ -f "${nodups_12}" ]] && rm "${nodups_12}"
zcat < "${nodups}" \
    | grep -v "^#" \
    | awk '($2 == "XII" || $4 == "XII")' \
        > "${nodups_12}"

[[ -f "${nodups_12_no_rDNA}" ]] && rm "${nodups_12_no_rDNA}"
zcat < "${nodups}" \
    | grep -v "^#" \
    | awk \
        -v left=451526 \
        -v right=468980 \
        '( \
            $2 == "XII" && ($11 < left || $11 > right) \
        ) || ( \
            $4 == "XII" && ($12 < left || $12 > right) \
        )' \
    > "${nodups_12_no_rDNA}"

[[ -f "${nodups_12_rDNA}" ]] && rm "${nodups_12_rDNA}"
zcat < "${nodups}" \
    | grep -v "^#" \
    | awk \
        -v left=451526 \
        -v right=468980 \
        '( \
            $2 == "XII" && $11 >= left && $11 <= right \
        ) || ( \
            $4 == "XII" && $12 >= left && $12 <= right \
        )' \
    > "${nodups_12_rDNA}"


#  Check that we have all of the dataframes
ls -lhaFG "${nodups}"
ls -lhaFG "${nodups_12}"
ls -lhaFG "${nodups_12_no_rDNA}"
ls -lhaFG "${nodups_12_rDNA}"


#  Scan through SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt ---------------------
#+ ...to see if we're truly capturing deduplicated rDNA information
#+ 
#+ #QUESTION
#+ Are we picking up more than just NTS1-2?
cat < SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt | less

#  ANSWER
#+ The initial answer is, "Yes."
#+ 
#+ ::checks some more::
#+ The answer is, "Yes." This approach does what we want.
```
</details>
<br />

<a id="printed-5"></a>
##### Printed
<details>
<summary><i>Printed: Process rDNA read pairs in "standard nodup", "rDNA nodup"</i></summary>

```txt
❯ #  Create necessary dataframes ------------------------------------------------


❯ nodups="SRR7939018.rDNA.nodups.pairs.gz"


❯ nodups_12="${nodups/.pairs.gz/.pairs.XII.txt}"


❯ nodups_12_no_rDNA="${nodups/.pairs.gz/.pairs.XII.no-rDNA.txt}"


❯ nodups_12_rDNA="${nodups/.pairs.gz/.pairs.XII.rDNA.txt}"


❯ ls -lhaFG "${nodups}"
-rwx------  1 kalavatt  staff   1.0G Jul 11 10:17 SRR7939018.rDNA.nodups.pairs.gz*


❯ echo "${nodups_12}"
SRR7939018.rDNA.nodups.pairs.XII.txt


❯ echo "${nodups_12_no_rDNA}"
SRR7939018.rDNA.nodups.pairs.XII.no-rDNA.txt


❯ echo "${nodups_12_rDNA}"
SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt


❯ zcat < "${nodups}" \
>     | grep -v "^#" \
pipe>     | head
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.17569487 I   5   I   194653  +   -   UU  1   R1-2    5   194653  57  194604  0   60
SRR7939018.47769906 I   5   I   207832  +   +   UU  1   R1-2    5   207832  54  207881  28  0
SRR7939018.3451089  I   6   I   229024  +   -   UU  1   R1-2    6   229024  55  228975  28  0
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60


❯ [[ -f "${nodups_12}" ]] && rm "${nodups_12}"


❯ zcat < "${nodups}" \
>     | grep -v "^#" \
pipe>     | awk '($2 == "XII" || $4 == "XII")' \
pipe pipe>         > "${nodups_12}"


❯ [[ -f "${nodups_12_no_rDNA}" ]] && rm "${nodups_12_no_rDNA}"


❯ zcat < "${nodups}" \
>     | grep -v "^#" \
pipe>     | awk \
pipe pipe>         -v left=451526 \
pipe pipe>         -v right=468980 \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && ($11 < left || $11 > right) \
pipe pipe quote>         ) || ( \
pipe pipe quote>             $4 == "XII" && ($12 < left || $12 > right) \
pipe pipe quote>         )' \
pipe pipe>     > "${nodups_12_no_rDNA}"


❯ [[ -f "${nodups_12_rDNA}" ]] && rm "${nodups_12_rDNA}"


❯ zcat < "${nodups}" \
>     | grep -v "^#" \
pipe>     | awk \
pipe pipe>         -v left=451526 \
pipe pipe>         -v right=468980 \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && $11 >= left && $11 <= right \
pipe pipe quote>         ) || ( \
pipe pipe quote>             $4 == "XII" && $12 >= left && $12 <= right \
pipe pipe quote>         )' \
pipe pipe>     > "${nodups_12_rDNA}"


❯ #  Check that we have all of the dataframes


❯ ls -lhaFG "${nodups}"
-rwx------  1 kalavatt  staff   1.0G Jul 11 10:17 SRR7939018.rDNA.nodups.pairs.gz*


❯ ls -lhaFG "${nodups_12}"
-rw-r--r--  1 kalavatt  staff   1.5G Jul 11 10:38 SRR7939018.rDNA.nodups.pairs.XII.txt


❯ ls -lhaFG "${nodups_12_no_rDNA}"
-rw-r--r--  1 kalavatt  staff   507M Jul 11 10:51 SRR7939018.rDNA.nodups.pairs.XII.no-rDNA.txt


❯ ls -lhaFG "${nodups_12_rDNA}"
-rw-r--r--  1 kalavatt  staff   1.2G Jul 11 11:04 SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt


❯ #  Scan through SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt ---------------------
❯ #+ ...to see if we're truly capturing deduplicated rDNA information
❯ #+ 
❯ #+ #QUESTION
❯ #+ Are we picking up more than just NTS1-2?


❯ cat < SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt | less


❯ #  ANSWER
❯ #+ The initial answer is, "Yes."
❯ #+
❯ #+ ::checks some more::
❯ #+ The answer is, "Yes." This approach does what we want.
```
</details>
<br />

<a id="notes-2"></a>
##### Notes
<details>
<summary><i>Notes: Process rDNA read pairs in "standard nodup", "rDNA nodup"</i></summary>

The Sublime text editor regex searches I did yesterday (see above) get numerous matches.
</details>
<br />

<a id="implement-logic-for-creation-of-deduplicated-standard-rdna-complete-files"></a>
### Implement logic for creation of deduplicated "`standard-rDNA-complete`" files
<a id="so-whats-the-next-step"></a>
#### So, what's the next step?
<a id="notes-3"></a>
##### Notes
<details>
<summary><i>Notes: So, what's the next step?</i></summary>

- We need to filter rDNA-associated *cis* and *trans* interactions from `SRR7939018.nodups.pairs.gz`
    + (`SRR7939018.nodups.pairs.gz` is to be renamed to `SRR7939018.standard.nodups.pairs.gz`)
    + The filtered outfile will be `SRR7939018.standard-no-rDNA.nodups.pairs.gz`
- Once we have both `SRR7939018.standard-no-rDNA.nodups.pairs.gz` and `SRR7939018.keep-MM.nodups.pairs.XII-rDNA.txt`, we will concatenate the files
    + (`SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt` will have been copied to `SRR7939018.rDNA-only.nodups.pairs.txt`)
    + The concatenated outfile will be `SRR7939018.standard-rDNA-complete.nodups.pairs.gz`
</details>
<br />

<a id="updates-to-the-naming-scheme"></a>
#### Updates to the naming scheme
<a id="notes-4"></a>
##### Notes
<details>
<summary><i>Notes: Updates to the naming scheme</i></summary>

- Files from the "standard" processing approach will have the prefix, e.g., `SRR7939018.standard`
- Files from the "retain-multimappers" ("rDNA") processing approach will have the prefix, e.g., `SRR7939018.keep-MM`
- "retain-multimappers" files processed to comprise only rDNA *cis* and *trans* interactions will have the prefix, `SRR7939018.rDNA-only`
- "standard" files processed to exclude all rDNA *cis* and *trans* interactions (e.g., those associated with NTS1-2) will have the prefix `SRR7939018.standard-no-rDNA`
- Files processed to include "`rDNA-only`" and "`standard-no-rDNA`" will have the prefix, e.g., `SRR7939018.standard-rDNA-complete`
</details>
<br />

<a id="clean-up-directory-then-re-copy-in-only-necessary-files"></a>
#### Clean up directory, then re-copy in only necessary files
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Clean up directory, then re-copy in only necessary files</i></summary>

```bash
#!/bin/bash

cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" \
    || echo "cd'ing failed; check on this..."

ls -lhaFG

rm SRR7939018.* rDNA-tmp* && echo "Removed files from above test work"

ls -lhaFG

#NOTE
#  Copied in SRR7939018.rDNA.nodups.pairs.gz and SRR7939018.nodups.pairs.gz
#+ rhino (remote)

#  Give the new files updated names (see above)
mv SRR7939018.rDNA.nodups.pairs.gz SRR7939018.keep-MM.nodups.pairs.gz
mv SRR7939018.nodups.pairs.gz SRR7939018.standard.nodups.pairs.gz

ls -lhaFG
```
</details>
<br />

<a id="printed-6"></a>
##### Printed
<details>
<summary><i>Printed: Clean up directory, then re-copy in only necessary files</i></summary>

```txt
❯ cd "${HOME}/projects-etc/2023_rDNA/results/2023-0307_work_Micro-C_align-process" \
>     || echo "cd'ing failed; check on this..."


❯ ls -lhaFG
total 32527680
drwxr-xr-x  29 kalavatt  staff   928B Jul 11 11:02 ./
drwxr-xr-x   6 kalavatt  staff   192B Jul 11 10:38 ../
-rwx------   1 kalavatt  staff   6.1G Jul  6 08:36 SRR7939018.bam*
-rwx------   1 kalavatt  staff   157M Jul  6 12:41 SRR7939018.dups.pairs.gz*
-rw-r--r--@  1 kalavatt  staff   603M Jul  9 09:23 SRR7939018.dups.pairs.txt
-rw-r--r--@  1 kalavatt  staff   151M Jul 10 10:08 SRR7939018.nodups.pairs.XII.no-rDNA-complete.txt
-rw-r--r--@  1 kalavatt  staff   332M Jul 10 09:39 SRR7939018.nodups.pairs.XII.no-rDNA.txt
-rw-r--r--@  1 kalavatt  staff   351M Jul 10 10:54 SRR7939018.nodups.pairs.XII.txt
-rwx------   1 kalavatt  staff   748M Jul  6 12:41 SRR7939018.nodups.pairs.gz*
-rwx------   1 kalavatt  staff   1.3G Jul  6 11:25 SRR7939018.p2.txt.gz*
-rwx------   1 kalavatt  staff   187M Jul 11 10:17 SRR7939018.rDNA.dups.pairs.gz*
-rw-r--r--   1 kalavatt  staff   507M Jul 11 10:51 SRR7939018.rDNA.nodups.pairs.XII.no-rDNA.txt
-rw-r--r--@  1 kalavatt  staff   1.2G Jul 11 11:04 SRR7939018.rDNA.nodups.pairs.XII.rDNA.txt
-rw-r--r--   1 kalavatt  staff   1.5G Jul 11 10:38 SRR7939018.rDNA.nodups.pairs.XII.txt
-rwx------   1 kalavatt  staff   1.0G Jul 11 10:17 SRR7939018.rDNA.nodups.pairs.gz*
-rwx------   1 kalavatt  staff    66M Jul 11 10:17 SRR7939018.rDNA.unmapped.pairs.gz*
-rwx------   1 kalavatt  staff   1.0G Jul  6 12:22 SRR7939018.sort.txt.gz*
-rwx------   1 kalavatt  staff   213M Jul  6 12:41 SRR7939018.unmapped.pairs.gz*
drwxr-xr-x  13 kalavatt  staff   416B Jul  8 17:44 cool/
drwxr-xr-x   4 kalavatt  staff   128B Jul 11 07:12 notebook/
-rw-r--r--   1 kalavatt  staff   9.9M Jul 10 08:11 rDNA-tmp-2.txt
-rw-r--r--   1 kalavatt  staff   9.9M Jul 10 08:06 rDNA-tmp.txt
-rw-r--r--@  1 kalavatt  staff    97K Jul 11 11:43 rough-draft_determine-analysis-strategy_rDNA-Micro-C.md
-rw-r--r--@  1 kalavatt  staff   576K Jul 11 10:32 rough-draft_workflow_Micro-C_align-process.md
-rw-r--r--   1 kalavatt  staff   7.5K Jul  6 16:02 symlink-rename-H4Ac-ChIP-seq-data.txt
-rw-r--r--   1 kalavatt  staff    33K Jul  6 16:01 symlink-rename-MicroC-data.txt
-rwx------   1 kalavatt  staff   304K Jul 11 08:41 test-1000.SRR7939018.rDNA.txt.gz*
-rw-r--r--@  1 kalavatt  staff    34K Mar  7 13:06 work_docker-4dn-hic_install.md
-rw-r--r--@  1 kalavatt  staff    23K Jun 10 15:55 work_indices_create.md


❯ rm SRR7939018.* rDNA-tmp* && echo "Removed files from above test work"
Removed files from above test work


❯ ls -lhaFG
total 2432
drwxr-xr-x  11 kalavatt  staff   352B Jul 11 11:44 ./
drwxr-xr-x   6 kalavatt  staff   192B Jul 11 10:38 ../
drwxr-xr-x  13 kalavatt  staff   416B Jul  8 17:44 cool/
drwxr-xr-x   4 kalavatt  staff   128B Jul 11 07:12 notebook/
-rw-r--r--@  1 kalavatt  staff   100K Jul 11 11:45 rough-draft_determine-analysis-strategy_rDNA-Micro-C.md
-rw-r--r--@  1 kalavatt  staff   576K Jul 11 10:32 rough-draft_workflow_Micro-C_align-process.md
-rw-r--r--   1 kalavatt  staff   7.5K Jul  6 16:02 symlink-rename-H4Ac-ChIP-seq-data.txt
-rw-r--r--   1 kalavatt  staff    33K Jul  6 16:01 symlink-rename-MicroC-data.txt
-rwx------   1 kalavatt  staff   304K Jul 11 08:41 test-1000.SRR7939018.rDNA.txt.gz*
-rw-r--r--@  1 kalavatt  staff    34K Mar  7 13:06 work_docker-4dn-hic_install.md
-rw-r--r--@  1 kalavatt  staff    23K Jun 10 15:55 work_indices_create.md


❯ #NOTE
❯ #  Copied in SRR7939018.rDNA.nodups.pairs.gz and SRR7939018.nodups.pairs.gz
❯ #+ rhino (remote)


❯ #  Give the new files updated names (see above)


❯ mv SRR7939018.rDNA.nodups.pairs.gz SRR7939018.keep-MM.nodups.pairs.gz


❯ mv SRR7939018.nodups.pairs.gz SRR7939018.standard.nodups.pairs.gz


❯ ls -lhaFG
total 3677288
drwxr-xr-x  13 kalavatt  staff   416B Jul 11 11:50 ./
drwxr-xr-x   6 kalavatt  staff   192B Jul 11 10:38 ../
-rwx------   1 kalavatt  staff   1.0G Jul 11 10:17 SRR7939018.keep-MM.nodups.pairs.gz*
-rwx------   1 kalavatt  staff   748M Jul  6 12:41 SRR7939018.standard.nodups.pairs.gz*
drwxr-xr-x  13 kalavatt  staff   416B Jul  8 17:44 cool/
drwxr-xr-x   4 kalavatt  staff   128B Jul 11 07:12 notebook/
-rw-r--r--@  1 kalavatt  staff   102K Jul 11 11:50 rough-draft_determine-analysis-strategy_rDNA-Micro-C.md
-rw-r--r--@  1 kalavatt  staff   576K Jul 11 10:32 rough-draft_workflow_Micro-C_align-process.md
-rw-r--r--   1 kalavatt  staff   7.5K Jul  6 16:02 symlink-rename-H4Ac-ChIP-seq-data.txt
-rw-r--r--   1 kalavatt  staff    33K Jul  6 16:01 symlink-rename-MicroC-data.txt
-rw-r--r--@  1 kalavatt  staff    34K Mar  7 13:06 work_docker-4dn-hic_install.md
-rw-r--r--@  1 kalavatt  staff    23K Jun 10 15:55 work_indices_create.md
```
</details>
<br />

<a id="run-the-actual-processing"></a>
#### Run the actual processing
<a id="code-7"></a>
##### Code
<details>
<summary><i>Code: Run the actual processing</i></summary>

<a id="1-exclude-rdna-associated-cis-and-trans-interactions-from-standard"></a>
###### 1. Exclude rDNA-associated cis and trans interactions from "standard"
```bash
#!/bin/bash

left=451526
right=468980

f_pre="SRR7939018"  # echo "${f_pre}"
f_post="nodups.pairs.gz"  # echo "${f_post}"
standard="${f_pre}.standard.${f_post}"  # echo "${standard}"
standard_no_rDNA="${f_pre}.standard-no-rDNA.${f_post}"  # echo "${standard_no_rDNA}"

#       IF chrom1 != "XII" && chrom2 != "XII" THEN print record
#+ ELSE IF chrom1 == "XII" && chrom2 != "XII" && pos1 != rDNA THEN print record
#+ ELSE IF chrom1 != "XII" && chrom2 == "XII" && pos2 != rDNA THEN print record
#+ ELSE IF chrom1 == "XII" && chrom2 == "XII" && pos1 != rDNA && pos2 != rDNA THEN print record
[[ -f "${standard_no_rDNA}" ]] && rm "${standard_no_rDNA}"
zcat < "${standard}" \
    | grep -v "^#" \
    | awk \
        -v left="${left}" \
        -v right="${right}" \
        '{
            if ($2 != "XII" && $4 != "XII") {  
                print $0
            } else if (($2 == "XII" && $4 != "XII") && ($11 < left || $11 > right)) {
                print $0
            } else if (($4 == "XII" && $2 != "XII") && ($12 < left || $12 > right)) {
                print $0
            } else if ($2 == "XII" && $4 == "XII" && ($11 < left || $11 > right) && ($12 < left || $12 > right)) {
                print $0
            }
        }' \
    | gzip \
        > "${standard_no_rDNA}"

#  Manually check that any XII-associated records are not rDNA-associated
[[ -f "${standard_no_rDNA/.gz/.txt}" ]] && rm "${standard_no_rDNA/.gz/.txt}"
zcat < "${standard_no_rDNA}" > "${standard_no_rDNA/.gz/.txt}"

#NOTE
#  This seems to have done the trick!
rm "${standard_no_rDNA/.gz/.txt}"
```

<a id="2-retain-only-rdna-associated-cis-and-trans-interactions-in-keep-mm"></a>
###### 2. Retain only rDNA-associated cis and trans interactions in "keep-MM"
```bash
#!/bin/bash

left=451526
right=468980

f_pre="SRR7939018"  # echo "${f_pre}"
f_post="nodups.pairs.gz"  # echo "${f_post}"
keep_MM="${f_pre}.keep-MM.${f_post}"  # ., "${keep_MM}"
rDNA_only="${f_pre}.rDNA-only.${f_post}"  # echo "${rDNA_only}"

#     IF chrom1 == "XII" && pos1 >= rDNA left && pos1 <= rDNA right
#+ OR IF chrom2 == "XII" && pos2 >= rDNA left && pos2 <= rDNA right
#+  THEN print record
[[ -f "${rDNA_only}" ]] && rm "${rDNA_only}"
zcat < "${keep_MM}" \
    | grep -v "^#" \
    | awk \
        -v left="${left}" \
        -v right="${right}" \
        '( \
            $2 == "XII" && $11 >= left && $11 <= right \
        ) || ( \
            $4 == "XII" && $12 >= left && $12 <= right \
        )' \
    | gzip \
        > "${rDNA_only}"

#  Manually check that there are only rDNA-associated records
[[ -f "${rDNA_only/.gz/.txt}" ]] && rm "${rDNA_only/.gz/.txt}"
zcat < "${rDNA_only}" > "${rDNA_only/.gz/.txt}"

#NOTE
#  This seems to have done the trick!
rm "${rDNA_only/.gz/.txt}"
```

<a id="3-concatenate-standard-no-rdna-and-rdna-only-files"></a>
###### 3. Concatenate "standard-no-rDNA" and "rDNA-only" files
```bash
#!/bin/bash

f_pre="SRR7939018"  # echo "${f_pre}"
f_post="nodups.pairs.gz"  # echo "${f_post}"
standard_no_rDNA="${f_pre}.standard-no-rDNA.${f_post}"  # ., "${standard_no_rDNA}"
rDNA_only="${f_pre}.rDNA-only.${f_post}"  # ., "${rDNA_only}"
standard_rDNA_complete="${f_pre}.standard-rDNA-complete.${f_post}"  # echo "${standard_rDNA_complete}"

cat "${standard_no_rDNA}" "${rDNA_only}" \
    > "${standard_rDNA_complete}"

zcat < "${standard_rDNA_complete}" | less
zcat < "${standard_rDNA_complete}" | less +G

#  Remove columns 17 and 18
zcat < "${standard_rDNA_complete}" \
    | awk '{ for (i = 1; i <= NF-2; i++) printf "%s ", $i; printf "\n" }' \
    | gzip \
        > sans-last-two.txt.gz

#  Dataframe needs to be tab separated
tr ' ' \\t < <(zcat < sans-last-two.txt.gz) | gzip > sans-last-two-tabs.txt.gz

zcat < sans-last-two-tabs.txt.gz | less
zcat < sans-last-two-tabs.txt.gz | less +G

#NOTE
#  The below is apparently not the way to add a header this; instead, we need
#+ to run `pairtools header generate` or `pairtools header transfer``
do_not_do=TRUE
[[ "${do_not_do}" == FALSE ]] &&
    {
        #  Add a header to the file
        zcat < "${standard}" | grep "^#" | gzip > "tmp.header.gz"
        [[ -f "tmp.header.gz" && -f "${standard_rDNA_complete}" ]] &&
            {
                cat "tmp.header.gz" "${standard_rDNA_complete}" > "tmp.file.gz"
            }

        zcat < "tmp.file.gz" | less

        [[ -f "tmp.file.gz" && -f "${standard_rDNA_complete}" ]] &&
            {
                mv -f "tmp.file.gz" "${standard_rDNA_complete}"
            }

        [[ ! -f "tmp.file.gz" ]] && rm "tmp.header.gz"

        zcat < "${standard_rDNA_complete}" | grep "^#"
    }
```

<a id="4-copy-file-to-remote-then-run-pairtools-sort"></a>
###### 4. Copy file to remote, then run `pairtools sort`
```bash
#!/bin/bash

grabnode  # 20, 8, 1, N

p_proj="${HOME}/tsukiyamalab/kalavatt/2023_rDNA"
p_exp="results/2023-0307_work_Micro-C_align-process"

cd "${p_proj}/${p_exp}" || echo "cd'ing failed; check on this..."

source activate pairtools_env

ls -lhaFG

threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"
scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"
chroms="${HOME}/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size"  # ., "${chroms}"
columns="readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,walk_pair_index,walk_pair_type,pos51,pos52,pos31,pos32,mapq1,mapq2"  # echo "${columns}"
a_transfer="05_dedup/SRR7939018.nodups.pairs.gz"  # ., "${a_transfer}"
# a_pairs="SRR7939018.standard-rDNA-complete.nodups.pairs.gz"  # echo "${a_pairs}"
a_pairs="sans-last-two-tabs.txt.gz"
a_sort="${a_pairs/.gz/.sort.gz}"  # echo "${a_sort}"

echo """
pairtools sort \\
    --nproc \"${threads}\" \\
    --tmpdir \"${scratch}\" \\
    --output \"${a_sort}\" \\
    \"${a_pairs}\" \\
        2> >(tee -a \"${a_sort%.gz}.stderr.txt\" >&2)
"""

pairtools sort \
    --nproc "${threads}" \
    --tmpdir "${scratch}" \
    --output "${a_sort}" \
    "${a_pairs}" \
        2> >(tee -a "${a_sort%.gz}.stderr.txt" >&2)
```

<a id="5-troubleshoot-the-re-headering-of-pairs-files"></a>
###### 5. Troubleshoot the re-headering of pairs files
```bash
#!/bin/bash

#  Get situated ---------------------------------------------------------------
p_work="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/0X_comp"
[[ ! $(pwd) =~ "0X" ]] && cd "${p_work}"


#  Generate non-compressed minimal example files ------------------------------
[[ -f file-without-header.txt ]] && rm file-without-header.txt
[[ -f file-with-header.txt ]] && rm file-with-header.txt

zcat < SRR7939018.standard-no-rDNA.nodups.pairs.gz | head -100 > file-without-header.txt
zcat < ../05_dedup/SRR7939018.standard.nodups.pairs.gz | head -100 > file-with-header.txt

head file-without-header.txt


#  pairtools header transfer --------------------------------------------------
pairtools header transfer \
    -o "re-headered-file.txt" \
    -r "file-with-header.txt" \
    "file-without-header.txt"

head -50 re-headered-file.txt


#  pairtools header generate --------------------------------------------------
chroms="${HOME}/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size"
columns="readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,walk_pair_index,walk_pair_type,pos51,pos52,pos31,pos32,mapq1,mapq2"

pairtools header generate \
    -o re-headered-file-2.txt \
    --chroms-path "${chroms}" \
    --pairs file-without-header.txt \
    --columns "${columns}"


#  Generate pbgzip-compressed minimal example files ---------------------------
[[ ! -f file-with-header.txt.gz ]] && pbgzip -c file-with-header.txt > file-with-header.txt.gz
[[ ! -f file-without-header.txt.gz ]] && pbgzip -c file-without-header.txt > file-without-header.txt.gz


#  Compressed file: pairtools header transfer ---------------------------------
pairtools header transfer \
    --output re-headered-file.txt.gz \
    --reference-file file-with-header.txt.gz \
    file-without-header.txt.gz
#  It works!


#  Compressed file: pairtools header generate ---------------------------------
chroms="${HOME}/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size"
columns="readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,walk_pair_index,walk_pair_type,pos51,pos52,pos31,pos32,mapq1,mapq2"

pairtools header generate \
    -o re-headered-file-2.txt.gz \
    --chroms-path "${chroms}" \
    --pairs file-without-header.txt.gz \
    --columns "${columns}"


#NOTE
#  OK, so the solution is to make sure any compression is performed with the
#+ program pbgzip, which was installed alongside pairtools and is part of the
#+ pairtools_env miniconda3 environment
#+ 
#+ We will encounter errors if we compress files with a standard program like
#+ gzip


#  Clean up -------------------------------------------------------------------
[[ ! -d test-re-headering/ ]] && mkdir test-re-headering/
mv file-with* re-headered-file* test-re-headering/
```

<a id="6-test-that-0x_compsrr7939018standard-no-rdnanodupspairsgz-can-be-re-headered"></a>
###### 6. Test that "`0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz`" can be re-headered
```bash
#!/bin/bash

#  pbgzip-compressed pairtools header transfer --------------------------------
echo """
pairtools header transfer \\
    -o \"${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}\" \\
    -r \"${a_dedup_pre_pairs}\" \\
    \"${a_comp_std}\"
"""

ls -lhaFG "${a_dedup_pre_pairs}"
ls -lhaFG "${a_comp_std}"

pairtools header transfer \
    -o "${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}" \
    -r "${a_dedup_pre_pairs}" \
    "${a_comp_std}"

pbgzip -dc < "${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}" \
    | head -50

#NOTE
#  This works!

rm SRR7939018.standard-no-rDNA.re-headered.nodups.pairs.gz
```
</details>
<br />

<a id="printed-7"></a>
##### Printed
<details>
<summary><i>Printed: Run the actual processing</i></summary>

<a id="1-exclude-rdna-associated-cis-and-trans-interactions-from-standard-1"></a>
###### 1. Exclude rDNA-associated cis and trans interactions from "standard"
```txt
❯ pairtools header transfer --help
Usage: pairtools header transfer [OPTIONS] [PAIRS_PATH]

  Transfer the header from one pairs file to another

Options:
  -o, --output TEXT          output file. If the path ends with .gz or .lz4,
                             the output is bgzip-/lz4c-compressed. By default,
                             the output is printed into stdout.
  --nproc-in INTEGER         Number of processes used by the auto-guessed
                             input decompressing command.  [default: 1]
  --nproc-out INTEGER        Number of processes used by the auto-guessed
                             output compressing command.  [default: 8]
  --cmd-in TEXT              A command to decompress the input. If provided,
                             fully overrides the auto-guessed command. Does
                             not work with stdin. Must read input from stdin
                             and print output into stdout. EXAMPLE: pbgzip -dc
                             -n 3
  --cmd-out TEXT             A command to compress the output. If provided,
                             fully overrides the auto-guessed command. Does
                             not work with stdout. Must read input from stdin
                             and print output into stdout. EXAMPLE: pbgzip -c
                             -n 8
  -r, --reference-file TEXT  Header file for transfer  [required]
  -h, --help                 Show this message and exit.


❯ left=451526


❯ right=468980


❯ f_pre="SRR7939018"


❯ f_post="nodups.pairs.gz"


❯ standard="${f_pre}.standard.${f_post}"


❯ standard_no_rDNA="${f_pre}.standard-no-rDNA.${f_post}"


❯ echo "${f_pre}"
SRR7939018


❯ echo "${f_post}"
nodups.pairs.gz


❯ echo "${standard}"
SRR7939018.standard.nodups.pairs.gz


❯ echo "${standard_no_rDNA}"
SRR7939018.standard-no-rDNA.nodups.pairs.gz


❯ #       IF chrom1 != "XII" && chrom2 != "XII" THEN print record
❯ #+ ELSE IF chrom1 == "XII" && chrom2 != "XII" && pos1 != rDNA THEN print record
❯ #+ ELSE IF chrom1 != "XII" && chrom2 == "XII" && pos2 != rDNA THEN print record
❯ #+ ELSE IF chrom1 == "XII" && chrom2 == "XII" && pos1 != rDNA && pos2 != rDNA THEN print record


❯ [[ -f "${standard_no_rDNA}" ]] && rm "${standard_no_rDNA}"


❯ zcat < "${standard}" \
>     | grep -v "^#" \
pipe>     | awk \
pipe pipe>         -v left="${left}" \
pipe pipe>         -v right="${right}" \
pipe pipe>         '{
pipe pipe quote>             if ($2 != "XII" && $4 != "XII") {
pipe pipe quote>                 print $0
pipe pipe quote>             } else if (($2 == "XII" && $4 != "XII") && ($11 < left || $11 > right)) {
pipe pipe quote>                 print $0
pipe pipe quote>             } else if (($4 == "XII" && $2 != "XII") && ($12 < left || $12 > right)) {
pipe pipe quote>                 print $0
pipe pipe quote>             } else if ($2 == "XII" && $4 == "XII" && ($11 < left || $11 > right) && ($12 < left || $12 > right)) {
pipe pipe quote>                 print $0
pipe pipe quote>             }
pipe pipe quote>         }' \
pipe pipe>     | gzip \
pipe pipe pipe>         > "${standard_no_rDNA}"


❯ #  Manually check that any XII-associated records are not rDNA-associated


❯ [[ -f "${standard_no_rDNA/.gz/.txt}" ]] && rm "${standard_no_rDNA/.gz/.txt}"


❯ zcat < "${standard_no_rDNA}" > "${standard_no_rDNA/.gz/.txt}"


❯ #NOTE
❯ #  This seems to have done the trick!


❯ rm "${standard_no_rDNA/.gz/.txt}"
```

<a id="2-retain-only-rdna-associated-cis-and-trans-interactions-in-keep-mm-1"></a>
###### 2. Retain only rDNA-associated cis and trans interactions in "keep-MM"
```txt
❯ left=451526


❯ right=468980


❯ f_pre="SRR7939018"


❯ f_post="nodups.pairs.gz"


❯ keep_MM="${f_pre}.keep-MM.${f_post}"


❯ rDNA_only="${f_pre}.rDNA-only.${f_post}"


❯ echo "${f_pre}"
SRR7939018


❯ echo "${f_post}"
nodups.pairs.gz


❯ ., "${keep_MM}"
-rwx------  1 kalavatt  staff   1.0G Jul 11 10:17 SRR7939018.keep-MM.nodups.pairs.gz*


❯ echo "${rDNA_only}"
SRR7939018.rDNA-only.nodups.pairs.gz


❯ #     IF chrom1 == "XII" && pos1 >= rDNA left && pos1 <= rDNA right
❯ #+ OR IF chrom2 == "XII" && pos2 >= rDNA left && pos2 <= rDNA right
❯ #+  THEN print record


❯ [[ -f "${rDNA_only}" ]] && rm "${rDNA_only}"


❯ zcat < "${keep_MM}" \
>     | grep -v "^#" \
pipe>     | awk \
pipe pipe>         -v left="${left}" \
pipe pipe>         -v right="${right}" \
pipe pipe>         '( \
pipe pipe quote>             $2 == "XII" && $11 >= left && $11 <= right \
pipe pipe quote>         ) || ( \
pipe pipe quote>             $4 == "XII" && $12 >= left && $12 <= right \
pipe pipe quote>         )' \
pipe pipe>     | gzip \
pipe pipe pipe>         > "${rDNA_only}"


❯ #  Manually check that there are only rDNA-associated records


❯ [[ -f "${rDNA_only/.gz/.txt}" ]] && rm "${rDNA_only/.gz/.txt}"


❯ zcat < "${rDNA_only}" > "${rDNA_only/.gz/.txt}"


❯ #NOTE
❯ #  This seems to have done the trick!


❯ rm "${rDNA_only/.gz/.txt}"
```

<a id="3-concatenate-standard-no-rdna-and-keep-mm-rdna-only-files"></a>
###### 3. Concatenate "standard-no-rDNA" and "keep-MM rDNA-only" files
```txt
❯ f_pre="SRR7939018"  # echo "${f_pre}"


❯ f_post="nodups.pairs.gz"  # echo "${f_post}"


❯ standard_no_rDNA="${f_pre}.standard-no-rDNA.${f_post}"  # ., "${standard_no_rDNA}"


❯ rDNA_only="${f_pre}.rDNA-only.${f_post}"  # ., "${rDNA_only}"


❯ standard_rDNA_complete="${f_pre}.standard-rDNA-complete.${f_post}"  # echo "${standard_rDNA_complete}"


❯ echo "${f_pre}"
SRR7939018


❯ echo "${f_post}"
nodups.pairs.gz


❯ ., "${standard_no_rDNA}"
-rw-r--r--@ 1 kalavatt  staff   706M Jul 11 12:49 SRR7939018.standard-no-rDNA.nodups.pairs.gz


❯ ., "${rDNA_only}"
-rw-r--r--  1 kalavatt  staff   230M Jul 11 13:21 SRR7939018.rDNA-only.nodups.pairs.gz


❯ echo "${standard_rDNA_complete}"
SRR7939018.standard-rDNA-complete.nodups.pairs.gz


❯ cat "${standard_no_rDNA}" "${rDNA_only}" \
>     > "${standard_rDNA_complete}"


❯ zcat < "${standard_rDNA_complete}" | less


❯ zcat < "${standard_rDNA_complete}" | less +G


❯ #  Add a header to the file


❯ zcat < "${standard}" | grep "^#" | gzip > "tmp.header.gz"


❯ [[ -f "tmp.header.gz" && -f "${standard_rDNA_complete}" ]] &&
cmdand>     {
cmdand cursh>         cat "tmp.header.gz" "${standard_rDNA_complete}" > "tmp.file.gz"
cmdand cursh>     }


❯ zcat < "tmp.file.gz" | less


❯ [[ -f "tmp.file.gz" && -f "${standard_rDNA_complete}" ]] &&
cmdand>     {
cmdand cursh>         mv -f "tmp.file.gz" "${standard_rDNA_complete}"
cmdand cursh>     }


❯ [[ ! -f "tmp.file.gz" ]] && rm "tmp.header.gz"


❯ zcat < "${standard_rDNA_complete}" | grep "^#"
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
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.p2.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq,mismatches --drop-seq --drop-sam --output-stats 0X_stats/SRR7939018.stats.p2.txt --nproc-in 8 --nproc-out 8 02_aln/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.sort.txt.gz 03_parse/SRR7939018.p2.txt.gz    PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 0X_stats/SRR7939018.dedup.stats.txt 04_sort/SRR7939018.sort.txt.gz PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/pairs/SRR7939018.nodups.pairs.gz    PP:pairtools_dedup  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2 mismatches1 mismatches2
```

<a id="4-copy-file-to-remote-then-run-pairtools-sort-1"></a>
###### 4. Copy file to remote, then run `pairtools sort`
```txt
❯ p_proj="${HOME}/tsukiyamalab/kalavatt/2023_rDNA"


❯ p_exp="results/2023-0307_work_Micro-C_align-process"


❯ cd "${p_proj}/${p_exp}" || echo "cd'ing failed; check on this..."


❯ source activate pairtools_env


❯ ls -lhaFG
total 1.2G
drwxrws--- 10 kalavatt  510 Jul 11 13:45 ./
drwxrws---  5 kalavatt  212 Jul 11 08:42 ../
drwxrws---  3 kalavatt  391 Jul  8 10:54 01_trim/
drwxrws---  3 kalavatt  156 Jul  8 10:56 02_align/
drwxrws---  3 kalavatt  249 Jul 11 08:43 03_parse/
drwxrws---  3 kalavatt  233 Jul 11 09:24 04_sort/
drwxrws---  3 kalavatt  766 Jul 11 10:08 05_dedup/
drwxrws---  2 kalavatt 1.1K Jul 11 10:08 06_stats/
drwxrws---  3 kalavatt  236 Jul  8 16:11 07_cload/
drwxrws---  3 kalavatt  211 Jul  8 16:23 08_zoom/
-rw-rw----  1 kalavatt 936M Jul 11 13:38 SRR7939018.standard-rDNA-complete.nodups.pairs.gz
-rw-rw----  1 kalavatt 7.6K Jul  8 09:33 symlink-rename-H4Ac-ChIP-seq-data.txt
-rw-rw----  1 kalavatt  34K Jul  8 09:33 symlink-rename-MicroC-data.txt
-rw-rw----  1 kalavatt  34K Jul  6 16:52 work_docker-4dn-hic_install.md
-rw-rw----  1 kalavatt  23K Jul  6 16:52 work_indices_create.md
-rw-rw----  1 kalavatt 399K Jul  8 09:33 work_Micro-C_align-process.md


❯ threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"


❯ scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"


❯ a_transfer="05_dedup/SRR7939018.nodups.pairs.gz"  # ., "${a_transfer}"


❯ a_pairs="SRR7939018.standard-rDNA-complete.nodups.pairs.gz"  # echo "${a_pairs}"


❯ a_sort="${a_pairs/.gz/.sort.gz}"  # echo "${a_sort}"


❯ echo "${threads}"
8


❯ echo "${scratch}"
/fh/scratch/delete30/tsukiyama_t


❯ ., "${a_transfer}"
-rw-rw---- 1 kalavatt 748M Jul  6 12:41 05_dedup/SRR7939018.nodups.pairs.gz


❯ echo "${a_pairs}"
SRR7939018.standard-rDNA-complete.nodups.pairs.gz


❯ echo "${a_sort}"
SRR7939018.standard-rDNA-complete.nodups.pairs.sort.gz


❯ echo """
> pairtools sort \\
>     --nproc \"${threads}\" \\
>     --tmpdir \"${scratch}\" \\
>     --output \"${a_sort}\" \\
>     \"${a_pairs}\" \\
>         2> >(tee -a \"${a_sort%.gz}.stderr.txt\" >&2)
> """

pairtools sort \
    --nproc "8" \
    --tmpdir "/fh/scratch/delete30/tsukiyama_t" \
    --output "SRR7939018.standard-rDNA-complete.nodups.pairs.sort.gz" \
    "SRR7939018.standard-rDNA-complete.nodups.pairs.gz" \
        2> >(tee -a "SRR7939018.standard-rDNA-complete.nodups.pairs.sort.stderr.txt" >&2)


(Run on a pairs file that doesn't have a header)
❯ pairtools sort \
>     --nproc "${threads}" \
>     --tmpdir "${scratch}" \
>     --output "${a_sort}" \
>     "${a_pairs}" \
>         2> >(tee -a "${a_sort%.gz}.stderr.txt" >&2)
invalid block header
reader reader_read_block: bug encountered
WARNING:pairtools:Headerless input, please, add the header by `pairtools header generate` or `pairtools header transfer`
Traceback (most recent call last):
  File "/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools", line 11, in <module>
    sys.exit(cli())
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/cli/__init__.py", line 183, in wrapper
    return func(*args, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/cli/sort.py", line 70, in sort
    sort_py(pairs_path, output, nproc, tmpdir, memory, compress_program, **kwargs)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/cli/sort.py", line 89, in sort_py
    header = headerops.append_new_pg(header, ID=UTIL_NAME, PN=UTIL_NAME)
  File "/home/kalavatt/miniconda3/envs/pairtools_env/lib/python3.10/site-packages/pairtools/lib/headerops.py", line 346, in append_new_pg
    raise Exception("Input file is not valid .pairs, has no header or is empty.")
Exception: Input file is not valid .pairs, has no header or is empty.


(Run on a pairs file that *does* have a header)
```

<a id="5-troubleshoot-the-re-headering-of-pairs-files-1"></a>
###### 5. Troubleshoot the re-headering of pairs files
```txt
❯ #  Get situated ---------------------------------------------------------------


❯ p_work="${HOME}/tsukiyamalab/kalavatt/2023_rDNA/results/2023-0307_work_Micro-C_align-process/0X_comp"


❯ [[ ! $(pwd) =~ "0X" ]] && cd "${p_work}"


❯ #  Generate non-compressed minimal example files ------------------------------


❯ [[ -f file-without-header.txt ]] && rm file-without-header.txt


1 ❯ [[ -f file-with-header.txt ]] && rm file-with-header.txt


1 ❯ zcat < SRR7939018.standard-no-rDNA.nodups.pairs.gz | head -100 > file-without-header.txt


❯ zcat < ../05_dedup/SRR7939018.standard.nodups.pairs.gz | head -100 > file-with-header.txt


❯ head file-without-header.txt
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13
SRR7939018.55685650 I   8   I   9446    +   -   UU  1   R1-2    8   9446    57  9397    28  60
SRR7939018.20572273 I   10  I   130 +   +   UU  1   R1-2    10  130 59  179 35  53
SRR7939018.14854904 I   10  I   318 +   -   UU  1   R1-2    10  318 59  269 35  60
SRR7939018.25573455 I   10  I   558 +   +   UU  1   R1-2    10  558 59  607 35  11
SRR7939018.34992310 I   10  I   887 +   +   UU  1   R1-2    10  887 59  936 35  35
SRR7939018.1104427  I   10  I   31959   +   -   UU  1   R1-2    10  31959   59  31910   35  60


❯ #  pairtools header transfer --------------------------------------------------


❯ pairtools header transfer \
>     -o "re-headered-file.txt" \
>     -r "file-with-header.txt" \
>     "file-without-header.txt"


❯ head -50 re-headered-file.txt
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
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.standard.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.standard.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.standard.sort.txt.gz 03_parse/SRR7939018.standard.txt.gz PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 06_stats/SRR7939018.standard.dedup.stats.txt 04_sort/SRR7939018.standard.sort.txt.gz   PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/SRR7939018.standard.nodups.pairs.gzPP:pairtools_dedup   VN:1.0.2
#samheader: @PG ID:pairtools_header PN:pairtools_header CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools header transfer -o re-headered-file.txt -r file-with-header.txt file-without-header.txt   PP:pairtools_split  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13


❯ #  pairtools header generate --------------------------------------------------


❯ chroms="${HOME}/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size"


❯ columns="readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,walk_pair_index,walk_pair_type,pos51,pos52,pos31,pos32,mapq1,mapq2"


❯ pairtools header generate \
>     -o re-headered-file-2.txt \
>     --chroms-path "${chroms}" \
>     --pairs file-without-header.txt \
>     --columns "${columns}"


❯ #  Generate pbgzip-compressed minimal example files ---------------------------


❯ [[ ! -f file-with-header.txt.gz ]] && pbgzip -c file-with-header.txt > file-with-header.txt.gz


❯ [[ ! -f file-without-header.txt.gz ]] && pbgzip -c file-without-header.txt > file-without-header.txt.gz


❯ #  Compressed file: pairtools header generate ---------------------------------


❯ chroms="${HOME}/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size"


❯ columns="readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,walk_pair_index,walk_pair_type,pos51,pos52,pos31,pos32,mapq1,mapq2"


❯ pairtools header generate \
>     -o re-headered-file-2.txt.gz \
>     --chroms-path "${chroms}" \
>     --pairs file-without-header.txt.gz \
>     --columns "${columns}"


❯ #NOTE
❯ #  OK, so the solution is to make sure any compression is performed with the
❯ #+ program pbgzip, which was installed alongside pairtools and is part of the
❯ #+ pairtools_env miniconda3 environment
❯ #+
❯ #+ We will encounter errors if we compress files with a standard program like
❯ #+ gzip


❯ #  Clean up -------------------------------------------------------------------


❯ [[ ! -d test-re-headering/ ]] && mkdir test-re-headering/
mkdir: created directory 'test-re-headering/'


❯ mv file-with* re-headered-file* test-re-headering/
'file-with-header.txt' -> 'test-re-headering/file-with-header.txt'
'file-with-header.txt.gz' -> 'test-re-headering/file-with-header.txt.gz'
'file-without-header.txt' -> 'test-re-headering/file-without-header.txt'
'file-without-header.txt.gz' -> 'test-re-headering/file-without-header.txt.gz'
're-headered-file-2.txt' -> 'test-re-headering/re-headered-file-2.txt'
're-headered-file-2.txt.gz' -> 'test-re-headering/re-headered-file-2.txt.gz'
're-headered-file.txt' -> 'test-re-headering/re-headered-file.txt'
're-headered-file.txt.gz' -> 'test-re-headering/re-headered-file.txt.gz'
```

<a id="6-test-that-0x_compsrr7939018standard-no-rdnanodupspairsgz-can-be-re-headered-1"></a>
###### 6. Test that "`0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz`" can be re-headered
```txt
❯ #  pbgzip-compressed pairtools header transfer --------------------------------


❯ echo """
> pairtools header transfer \\
>     -o \"${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}\" \\
>     -r \"${a_dedup_pre_pairs}\" \\
>     \"${a_comp_std}\"
> """

pairtools header transfer \
    -o "0X_comp/SRR7939018.standard-no-rDNA.re-headered.nodups.pairs.gz" \
    -r "05_dedup/SRR7939018.standard.nodups.pairs.gz" \
    "0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz"


❯ ls -lhaFG "${a_dedup_pre_pairs}"
-rw-rw---- 1 kalavatt 683M Jul 12 09:24 05_dedup/SRR7939018.standard.nodups.pairs.gz


❯ ls -lhaFG "${a_comp_std}"
-rw-rw---- 1 kalavatt 671M Jul 12 15:16 0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz


❯ pairtools header transfer \
>     -o "${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}" \
>     -r "${a_dedup_pre_pairs}" \
>     "${a_comp_std}"


❯ pbgzip -dc < "${a_comp_std/.nodups.pairs.gz/.re-headered.nodups.pairs.gz}" \
>     | head -50
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
#samheader: @PG ID:pairtools_parse2 PN:pairtools_parse2 CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools parse2 -o 03_parse/SRR7939018.standard.txt.gz -c /home/kalavatt/tsukiyamalab/kalavatt/genomes/Saccharomyces_cerevisiae/fasta-processed/S288C_reference_sequence_R64-3-1_20210421.size --report-position outer --report-orientation pair --assembly S288C_R64-3-1 --min-mapq 1 --dedup-max-mismatch 0 --expand --add-pair-index --no-flip --add-columns pos5,pos3,mapq --drop-seq --drop-sam --output-stats 06_stats/SRR7939018.standard.stats.txt --nproc-in 8 --nproc-out 8 02_align/SRR7939018.bam  PP:samtools VN:1.0.2
#samheader: @PG ID:pairtools_sort   PN:pairtools_sort   CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools sort --nproc 8 --tmpdir /fh/scratch/delete30/tsukiyama_t --output 04_sort/SRR7939018.standard.sort.txt.gz 03_parse/SRR7939018.standard.txt.gz PP:pairtools_parse2 VN:1.0.2
#samheader: @PG ID:pairtools_dedup  PN:pairtools_dedup  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools dedup --n-proc 8 --max-mismatch 0 --mark-dups --output /dev/fd/63 --output-unmapped /dev/fd/62 --output-dups /dev/fd/61 --output-stats 06_stats/SRR7939018.standard.dedup.stats.txt 04_sort/SRR7939018.standard.sort.txt.gz   PP:pairtools_sort   VN:1.0.2
#samheader: @PG ID:pairtools_split  PN:pairtools_split  CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools split --output-pairs 05_dedup/SRR7939018.standard.nodups.pairs.gzPP:pairtools_dedup   VN:1.0.2
#samheader: @PG ID:pairtools_header PN:pairtools_header CL:/home/kalavatt/miniconda3/envs/pairtools_env/bin/pairtools header transfer -o 0X_comp/SRR7939018.standard-no-rDNA.re-headered.nodups.pairs.gz -r 05_dedup/SRR7939018.standard.nodups.pairs.gz 0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz    PP:pairtools_split  VN:1.0.2
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type walk_pair_index walk_pair_type pos51 pos52 pos31 pos32 mapq1 mapq2
SRR7939018.44042564 I   1   I   15064   +   -   UU  1   R1-2    1   15064   48  15015   48  13
SRR7939018.44810319 I   7   I   1001    +   +   UU  1   R1-2    7   1001    56  1050    28  46
SRR7939018.29094541 I   7   I   1292    +   -   UU  1   R1-2    7   1292    56  1243    28  13
SRR7939018.17270740 I   8   I   2024    +   +   UU  1   R1-2    8   2024    41  2073    21  13


❯ #NOTE
❯ #  This works!


❯ rm SRR7939018.standard-no-rDNA.re-headered.nodups.pairs.gz
```
</details>
<br />

<a id="scraps-1"></a>
##### Scraps
<details>
<summary><i>Scraps: ...</i></summary>

```bash
#!/bin/bash

# [[ -f "${standard_no_rDNA}" ]] && rm "${standard_no_rDNA}"
# zcat < "${standard}" \
#     | grep -v "^#" \
#     | awk \
#         -v left=451526 \
#         -v right=468980 \
#         '( \
#             $2 == "XII" && ($11 < left || $11 > right) \
#         ) || ( \
#             $4 == "XII" && ($12 < left || $12 > right) \
#         )' \
#     > "${standard_no_rDNA}"
```
</details>
<br />