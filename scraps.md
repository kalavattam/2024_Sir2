
## Test: Working with pairs files
<u>Goal</u>: Add rDNA-associated pairs records to deduplicated pairs files

### Run an initial assessment of the non-deduplicated files
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

### Notes
<details>
<summary><i>Notes: TBD</i></summary>

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

#### On what the pair types are
- *doesn't really matter right now* `#LATER`
</details>
<br />
<br />

## Work out the logic to isolate rDNA pairs
### Review awk [tutorial #1](https://towardsdatascience.com/mastering-file-and-text-manipulation-with-awk-utility-65fc09d56bef)
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

### Review awk [tutorial #2](https://www.tim-dennis.com/data/tech/2016/08/09/using-awk-filter-rows.html) and begin writing usable logic
#### Code
<details>
<summary><i>Code: Review awk tutorial #2 and begin writing usable logic</i></summary>

```bash
#!/bin/bash

#  Return lines when more complicated condition is met ========================
#+ ...in which chrom1 (field/column 2) has value "XII" and pos1
#+ (field/column 3) has values between 451575 and 468931


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


#HERE
#  Filter rows based on field values ------------------------------------------
cat "${df}" \
    | tail --lines=+46 \
    | awk '{
        if(($2 == "XII") || ($4 == "XII"))
        { print $0 }
    }' \
    | head -40


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

#  This seems to be working; let's make it more readable and direct the stream
#+ to a temporary file, rDNA-tmp.txt, that we can check manually
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
        > "rDNA-tmp.txt"

#  This isn't quite right: I don't see records for when chrom2 is XII and
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

#QUESTION
#  Are we picking up pairs for the condition in which XII pos1 is between
#+ "left" and "right" AND XII pos2 is greater than "right"?
[[ -f "${outfile/.txt/.check.txt}" ]] && rm "${outfile/.txt/.check.txt}"
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

#NOTE
#  I mean, we capture 1044 lines that meet this condition, but that seems low to me.
#+ Basically, I want to make sure I'm capturing all interactions in which one of the read pairs is within the 50-padded rDNA locus, and I'm worried my logic is missing some things, in particular as it pertains intra-XII non-rDNA interactions. Are there really so few interactions between the rDNA locus and right side of XII? What about between the rDNA locus and the left side of XII? #TODO #TOBECONTINUED #TONIGHT or, more likely, #TOMORROW
```
</details>
<br />

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

#### Printed
<details>
<summary><i>Printed: Review awk tutorial #2 and begin writing usable logic</i></summary>

```txt
❯ #  Return lines when more complicated condition is met ========================
❯ #+ ...in which chrom1 (field/column 2) has value "XII" and pos1
❯ #+ (field/column 3) has values between 451575 and 468931


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
SRR7939018.60100479 XII 459869  I   178853  +   -   DD  1   R1-2    459869  178853  459918  178804  60  60
SRR7939018.56516858 XII 459874  I   44762   +   -   DD  1   R1-2    459874  44762   459918  44723   60  60
SRR7939018.58339118 XII 459901  I   91390   +   +   DD  1   R1-2    459901  91390   459950  91439   60  60
SRR7939018.45799515 XII 459915  I   28940   -   +   DD  1   R1-2    459915  28940   459871  28970   60  60
SRR7939018.50760185 XII 459915  I   28940   -   +   DD  1   R1-2    459915  28940   459871  28970   60  60
SRR7939018.59540915 XII 459916  I   206309  +   -   DD  1   R1-2    459916  206309  459965  206260  60  60      C:A:40:206277:18
SRR7939018.30895769 XII 459918  I   104481  -   +   DD  1   R1-2    459918  104481  459869  104530  60  60
SRR7939018.14984718 XII 459918  I   198331  +   +   DD  1   R1-2    459918  198331  459967  198380  60  59      G:T:38:198330:0,G:T:40:198346:16,G:A:38:198350:20
SRR7939018.62991940 XII 459918  I   198331  +   +   DD  1   R1-2    459918  198331  459967  198380  60  59      G:T:38:198330:0,G:T:38:198346:16,G:A:38:198350:20
SRR7939018.37029472 XII 459928  I   86506   -   -   DD  1   R1-2    459928  86506   459879  86468   60  60
SRR7939018.24531651 XII 459939  I   67366   -   -   DD  1   R1-2    459939  67366   459890  67317   60  60
SRR7939018.62231975 XII 459941  I   94508   -   -   DD  1   R1-2    459941  94508   459892  94459   60  60
SRR7939018.51492984 XII 459941  I   130575  -   +   DD  1   R1-2    459941  130575  459892  130615  60  60
SRR7939018.47166042 XII 459950  I   68829   -   -   DD  1   R1-2    459950  68829   459901  68780   60  60
SRR7939018.48320040 XII 459954  I   191158  -   -   DD  1   R1-2    459954  191158  459905  191109  60  60
SRR7939018.45928071 XII 459958  I   47776   -   -   DD  1   R1-2    459958  47776   459909  47747   60  60
SRR7939018.62671332 XII 459965  I   65011   -   -   DD  1   R1-2    459965  65011   459916  64962   60  60
SRR7939018.27137986 XII 459965  I   145342  -   +   DD  1   R1-2    459965  145342  459916  145391  60  60  A:T:13:459961:46
SRR7939018.62012707 XII 459968  I   93034   -   +   DD  1   R1-2    459968  93034   459919  93083   60  60  G:A:13:459943:25
SRR7939018.13506543 XII 459968  I   184091  -   +   DD  1   R1-2    459968  184091  459919  184140  60  60
SRR7939018.44307074 XII 459975  I   34380   -   -   DD  1   R1-2    459975  34380   459926  34331   60  60
SRR7939018.19419961 XII 459975  I   99700   -   -   DD  1   R1-2    459975  99700   459926  99651   60  60
SRR7939018.42167066 XII 459980  I   68049   +   -   DD  1   R1-2    459980  68049   460030  68000   60  60
SRR7939018.51511130 XII 459982  I   13406   +   +   DD  1   R1-2    459982  13406   460031  13439   60  60  A:C:2:460020:39
SRR7939018.54584128 XII 459984  I   120779  +   -   DD  1   R1-2    459984  120779  460019  120730  60  60
SRR7939018.45528489 XII 459984  I   198031  +   +   DD  1   R1-2    459984  198031  460035  198080  53  60  G:T:13:460031:46
SRR7939018.44962439 XII 460000  I   151514  -   +   DD  1   R1-2    460000  151514  459951  151563  60  60
SRR7939018.39658192 XII 460004  I   9333    -   +   DD  1   R1-2    460004  9333    459955  9382    60  60
SRR7939018.61307568 XII 460014  I   123516  +   +   DD  1   R1-2    460014  123516  460058  123565  60  60
SRR7939018.60007317 XII 460015  I   25502   +   -   DD  1   R1-2    460015  25502   460064  25453   60  36      G:A:13:25487:35,G:A:13:25496:44
SRR7939018.48608284 XII 460017  I   3341    +   -   DD  1   R1-2    460017  3341    460047  3292    60  60      C:T:13:3320:29
SRR7939018.61253463 XII 460021  I   67040   +   -   DD  1   R1-2    460021  67040   460070  66991   60  60
SRR7939018.30468468 XII 460021  I   191652  +   +   DD  1   R1-2    460021  191652  460070  191701  60  60
SRR7939018.23331018 XII 460031  I   53564   +   -   DD  1   R1-2    460031  53564   460080  53519   60  60
SRR7939018.24713058 XII 460031  I   53564   +   -   DD  1   R1-2    460031  53564   460080  53519   60  60
SRR7939018.57029930 XII 460034  I   148563  +   +   DD  1   R1-2    460034  148563  460083  148612  60  60
SRR7939018.62292863 XII 460036  I   173140  +   -   DD  1   R1-2    460036  173140  460085  173091  60  60      G:T:13:173092:2
SRR7939018.54260148 XII 460057  I   249 -   +   DD  1   R1-2    460057  249 460017  298 60  35
SRR7939018.40831183 XII 460058  I   128341  +   +   DD  1   R1-2    460058  128341  460107  128390  60  60
SRR7939018.45945490 XII 460060  I   168 -   +   DD  1   R1-2    460060  168 460018  217 60  50
SRR7939018.54456978 XII 460060  I   76494   -   -   DD  1   R1-2    460060  76494   460018  76445   60  60
SRR7939018.58280450 XII 460065  I   111458  -   +   DD  1   R1-2    460065  111458  460016  111507  60  60
SRR7939018.34856440 XII 460065  I   112258  -   -   DD  1   R1-2    460065  112258  460016  112209  60  60  A:T:40:460015:0
SRR7939018.44579023 XII 460067  I   6   -   +   DD  1   R1-2    460067  6   460018  52  60  13
SRR7939018.50697877 XII 460067  I   155295  -   +   DD  1   R1-2    460067  155295  460018  155344  60  60  A:C:40:460017:0
SRR7939018.65162800 XII 460067  I   155295  -   +   DD  1   R1-2    460067  155295  460018  155344  60  60  A:C:40:460017:0
SRR7939018.53097181 XII 460067  I   168349  -   +   DD  1   R1-2    460067  168349  460018  168398  60  60
SRR7939018.9352706  XII 460067  I   182296  -   -   DD  1   R1-2    460067  182296  460018  182247  60  60
SRR7939018.23446467 XII 460067  I   182296  -   -   DD  1   R1-2    460067  182296  460018  182247  60  60
SRR7939018.50965210 XII 460073  I   41695   +   -   DD  1   R1-2    460073  41695   460114  41653   60  60
SRR7939018.29075040 XII 460074  I   32496   +   +   DD  1   R1-2    460074  32496   460123  32545   60  60
SRR7939018.48583706 XII 460074  I   40727   +   -   DD  1   R1-2    460074  40727   460123  40678   60  60
SRR7939018.59689045 XII 460074  I   68317   +   -   DD  1   R1-2    460074  68317   460114  68268   60  60  T:A:38:460078:5
SRR7939018.44078294 XII 460074  I   159525  +   +   DD  1   R1-2    460074  159525  460113  159574  60  60
SRR7939018.42096353 XII 460081  I   210160  +   +   DD  1   R1-2    460081  210160  460130  210209  60  13      G:A:40:210201:42
SRR7939018.26910485 XII 460085  I   115298  -   -   DD  1   R1-2    460085  115298  460036  115255  60  60      T:G:13:115269:15
SRR7939018.59931442 XII 460087  I   55017   -   +   DD  1   R1-2    460087  55017   460038  55066   60  60
SRR7939018.56833117 XII 460088  I   16882   -   +   DD  1   R1-2    460088  16882   460039  16923   60  25
SRR7939018.59250167 XII 460098  I   28480   -   -   DD  1   R1-2    460098  28480   460049  28433   60  60
SRR7939018.40479375 XII 460101  I   124855  -   +   DD  1   R1-2    460101  124855  460052  124904  60  60
SRR7939018.56731215 XII 460102  I   4723    -   -   DD  1   R1-2    460102  4723    460053  4674    60  60
SRR7939018.27791177 XII 460102  I   100852  -   -   DD  1   R1-2    460102  100852  460053  100803  60  60  C:T:38:460098:46
SRR7939018.9970808  XII 460103  I   54605   -   -   DD  1   R1-2    460103  54605   460060  54556   60  60
SRR7939018.56636916 XII 460104  I   141806  +   -   DD  1   R1-2    460104  141806  460153  141757  60  60      C:G:40:141764:8
SRR7939018.65450697 XII 460107  I   74460   +   -   DD  1   R1-2    460107  74460   460156  74411   60  60
SRR7939018.41219755 XII 460110  I   19306   -   -   DD  1   R1-2    460110  19306   460061  19257   60  13
SRR7939018.48941470 XII 460110  I   19306   -   -   DD  1   R1-2    460110  19306   460061  19257   60  13
SRR7939018.49182668 XII 460114  I   52605   -   +   DD  1   R1-2    460114  52605   460065  52654   60  60
SRR7939018.60916352 XII 460114  I   52605   -   +   DD  1   R1-2    460114  52605   460065  52654   60  60
SRR7939018.47166112 XII 460114  I   66868   -   -   DD  1   R1-2    460114  66868   460065  66831   60  60
SRR7939018.52501056 XII 460114  I   82210   -   +   DD  1   R1-2    460114  82210   460065  82259   60  60
SRR7939018.57486183 XII 460114  I   82210   -   +   DD  1   R1-2    460114  82210   460065  82259   60  60
SRR7939018.52450575 XII 460115  I   21766   +   +   DD  1   R1-2    460115  21766   460164  21804   60  60
SRR7939018.61252439 XII 460115  I   156078  -   +   DD  1   R1-2    460115  156078  460066  156127  60  60
SRR7939018.65670058 XII 460118  I   127043  +   -   DD  1   R1-2    460118  127043  460167  126994  60  60
SRR7939018.53297780 XII 460127  I   179300  +   -   DD  1   R1-2    460127  179300  460176  179251  60  60
SRR7939018.46215529 XII 460128  I   172630  +   -   DD  1   R1-2    460128  172630  460177  172581  60  60
SRR7939018.61890840 XII 460129  I   37414   +   +   DD  1   R1-2    460129  37414   460178  37463   60  60
SRR7939018.30855173 XII 460138  I   195254  +   -   DD  1   R1-2    460138  195254  460187  195205  60  60
SRR7939018.57140760 XII 460138  I   195254  +   -   DD  1   R1-2    460138  195254  460187  195205  60  60
SRR7939018.51668942 XII 460141  I   34646   -   -   DD  1   R1-2    460141  34646   460112  34597   60  60
SRR7939018.56652091 XII 460141  I   64372   -   +   DD  1   R1-2    460141  64372   460092  64421   60  60
SRR7939018.51095195 XII 460141  I   149548  -   -   DD  1   R1-2    460141  149548  460092  149508  60  60      T:A:40:149513:15
SRR7939018.49585074 XII 460144  I   149469  +   -   DD  1   R1-2    460144  149469  460193  149420  60  60
SRR7939018.51445391 XII 460153  I   204062  +   +   DD  1   R1-2    460153  204062  460202  204111  60  12      G:A:40:204070:9,C:T:40:204073:12
SRR7939018.26741924 XII 460154  I   12561   +   -   DD  1   R1-2    460154  12561   460203  12512   60  4       T:A:40:12545:34
SRR7939018.20226630 XII 460158  I   70497   +   -   DD  1   R1-2    460158  70497   460207  70448   60  60
SRR7939018.19811853 XII 460165  I   78306   +   +   DD  1   R1-2    460165  78306   460214  78355   60  60
SRR7939018.43023229 XII 460172  I   35716   +   -   DD  1   R1-2    460172  35716   460221  35667   60  60
SRR7939018.37550095 XII 460178  I   34249   +   +   DD  1   R1-2    460178  34249   460227  34285   60  60
SRR7939018.30785084 XII 460182  I   17273   +   -   DD  1   R1-2    460182  17273   460231  17224   60  8       T:C:40:17264:41
SRR7939018.57355713 XII 460182  I   124365  +   +   DD  1   R1-2    460182  124365  460219  124414  60  60
SRR7939018.60230335 XII 460182  I   191393  +   -   DD  1   R1-2    460182  191393  460231  191344  60  60
SRR7939018.27095857 XII 460184  I   72127   +   +   DD  1   R1-2    460184  72127   460213  72176   60  60
SRR7939018.22687011 XII 460189  I   115004  +   +   DD  1   R1-2    460189  115004  460238  115053  60  60
SRR7939018.28600284 XII 460189  I   115004  +   +   DD  1   R1-2    460189  115004  460238  115053  60  60      T:A:32:115006:3
SRR7939018.57028901 XII 460191  I   4090    +   +   DD  1   R1-2    460191  4090    460240  4139    60  60
SRR7939018.65305632 XII 460210  I   80764   -   -   DD  1   R1-2    460210  80764   460177  80715   60  60
SRR7939018.63025511 XII 460229  I   79443   +   -   DD  1   R1-2    460229  79443   460278  79394   60  60
SRR7939018.63468135 XII 460229  I   133640  +   -   DD  1   R1-2    460229  133640  460278  133591  60  60
SRR7939018.47304342 XII 460230  I   116424  +   -   DD  1   R1-2    460230  116424  460279  116375  60  60      G:T:38:116381:7
SRR7939018.3265283  XII 460231  I   131751  -   +   DD  1   R1-2    460231  131751  460189  131800  60  60
SRR7939018.40542739 XII 460238  I   12589   -   -   DD  1   R1-2    460238  12589   460189  12540   60  53
SRR7939018.42399141 XII 460238  I   91017   -   -   DD  1   R1-2    460238  91017   460189  90968   60  60  A:T:40:460188:0
SRR7939018.66346718 XII 460240  I   191119  +   -   DD  1   R1-2    460240  191119  460289  191070  60  60
SRR7939018.53729273 XII 460248  I   198097  +   -   DD  1   R1-2    460248  198097  460297  198048  60  60
SRR7939018.63149798 XII 460248  I   198097  +   -   DD  1   R1-2    460248  198097  460297  198048  60  60
SRR7939018.11775206 XII 460258  I   37957   -   -   DD  1   R1-2    460258  37957   460209  37907   60  60
SRR7939018.39355512 XII 460263  I   134823  -   +   DD  1   R1-2    460263  134823  460214  134872  60  60
SRR7939018.63952136 XII 460263  I   134823  -   +   DD  1   R1-2    460263  134823  460214  134872  60  60
SRR7939018.50984433 XII 460264  I   116047  -   -   DD  1   R1-2    460264  116047  460215  115998  60  60
SRR7939018.44324059 XII 460267  I   159628  +   -   DD  1   R1-2    460267  159628  460316  159579  60  60
SRR7939018.62749243 XII 460270  I   83278   +   -   DD  1   R1-2    460270  83278   460319  83229   60  60
SRR7939018.10011172 XII 460281  I   186457  +   -   DD  1   R1-2    460281  186457  460330  186420  60  60
SRR7939018.65846434 XII 460282  I   1029    +   +   DD  1   R1-2    460282  1029    460331  1078    60  8
SRR7939018.36765928 XII 460282  I   1574    +   -   DD  1   R1-2    460282  1574    460331  1525    60  32
SRR7939018.48986926 XII 460282  I   1574    +   -   DD  1   R1-2    460282  1574    460331  1525    60  32
SRR7939018.23257815 XII 460282  I   13497   +   +   DD  1   R1-2    460282  13497   460331  13530   60  60
SRR7939018.38520710 XII 460282  I   43438   +   +   DD  1   R1-2    460282  43438   460331  43487   60  60
SRR7939018.57683284 XII 460282  I   106909  +   -   DD  1   R1-2    460282  106909  460331  106860  60  60
SRR7939018.29207352 XII 460282  I   136845  +   +   DD  1   R1-2    460282  136845  460331  136894  60  60
SRR7939018.59431143 XII 460287  I   28202   +   -   DD  1   R1-2    460287  28202   460336  28153   60  60
SRR7939018.33125739 XII 460288  I   156206  +   -   DD  1   R1-2    460288  156206  460337  156157  60  60
SRR7939018.60651243 XII 460288  I   196776  +   -   DD  1   R1-2    460288  196776  460337  196727  60  60
SRR7939018.23577131 XII 460293  I   59898   +   -   DD  1   R1-2    460293  59898   460342  59849   60  60
SRR7939018.64179405 XII 460294  I   33300   +   +   DD  1   R1-2    460294  33300   460343  33349   60  60
SRR7939018.64113009 XII 460299  I   89289   -   -   DD  1   R1-2    460299  89289   460250  89240   60  60
SRR7939018.51803141 XII 460300  I   49838   +   -   DD  1   R1-2    460300  49838   460349  49805   60  60  A:G:38:460321:22
SRR7939018.64097890 XII 460300  I   195659  +   -   DD  1   R1-2    460300  195659  460349  195610  60  60      A:G:13:195632:23,A:G:40:195641:32
SRR7939018.53927311 XII 460301  I   1107    +   -   DD  1   R1-2    460301  1107    460350  1058    60  9
SRR7939018.2680693  XII 460301  I   77654   -   -   DD  1   R1-2    460301  77654   460252  77605   60  60
SRR7939018.58022577 XII 460301  I   97366   -   +   DD  1   R1-2    460301  97366   460252  97415   60  60
SRR7939018.58454095 XII 460303  I   13379   +   +   DD  1   R1-2    460303  13379   460352  13428   60  60
SRR7939018.25490907 XII 460303  I   191361  +   +   DD  1   R1-2    460303  191361  460342  191410  60  60
SRR7939018.38446902 XII 460311  I   177732  +   -   DD  1   R1-2    460311  177732  460360  177683  60  60
SRR7939018.37365365 XII 460313  I   9666    -   +   DD  1   R1-2    460313  9666    460264  9715    60  60
SRR7939018.65027307 XII 460313  I   9666    -   +   DD  1   R1-2    460313  9666    460264  9715    60  60
SRR7939018.41945637 XII 460315  I   178887  +   -   DD  1   R1-2    460315  178887  460364  178838  60  60
SRR7939018.65306074 XII 460316  I   119138  +   -   DD  1   R1-2    460316  119138  460365  119089  60  60
SRR7939018.19996086 XII 460325  I   152479  -   -   DD  1   R1-2    460325  152479  460282  152430  60  60
SRR7939018.48876550 XII 460325  I   152479  -   -   DD  1   R1-2    460325  152479  460282  152430  60  60
SRR7939018.27405953 XII 460326  I   156033  -   -   DD  1   R1-2    460326  156033  460277  155984  60  60
SRR7939018.45194359 XII 460328  I   48164   -   -   DD  1   R1-2    460328  48164   460279  48115   60  60
SRR7939018.42179985 XII 460328  I   90488   -   +   DD  1   R1-2    460328  90488   460279  90537   60  60
SRR7939018.61871880 XII 460329  I   1368    -   -   DD  1   R1-2    460329  1368    460280  1319    60  35
SRR7939018.62118665 XII 460338  I   31785   -   -   DD  1   R1-2    460338  31785   460289  31736   60  60
SRR7939018.53793109 XII 460338  I   153364  +   +   DD  1   R1-2    460338  153364  460387  153413  60  60
SRR7939018.52306416 XII 460341  I   34881   +   -   DD  1   R1-2    460341  34881   460390  34832   60  60
SRR7939018.31443569 XII 460347  I   27967   +   -   DD  1   R1-2    460347  27967   460396  27936   60  60  A:T:40:460383:37
SRR7939018.51121993 XII 460354  I   3185    -   +   DD  1   R1-2    460354  3185    460305  3234    60  60
SRR7939018.58225199 XII 460354  I   91964   +   -   DD  1   R1-2    460354  91964   460403  91915   60  60
SRR7939018.21064801 XII 460356  I   114959  -   +   DD  1   R1-2    460356  114959  460307  115008  60  60      A:T:38:114958:0
SRR7939018.6875037  XII 460356  I   128271  -   +   DD  1   R1-2    460356  128271  460307  128317  60  60
SRR7939018.56235248 XII 460359  I   156688  -   -   DD  1   R1-2    460359  156688  460324  156639  60  60
SRR7939018.41266066 XII 460365  I   18596   -   +   DD  1   R1-2    460365  18596   460316  18636   60  25
SRR7939018.19254342 XII 460365  I   34286   -   +   DD  1   R1-2    460365  34286   460316  34335   60  60
SRR7939018.27757242 XII 460365  I   60963   -   +   DD  1   R1-2    460365  60963   460316  61012   60  60
SRR7939018.56724485 XII 460368  I   100444  -   -   DD  1   R1-2    460368  100444  460319  100395  60  60
SRR7939018.61760481 XII 460368  I   100444  -   -   DD  1   R1-2    460368  100444  460319  100395  60  60
SRR7939018.40356315 XII 460383  I   54903   -   +   DD  1   R1-2    460383  54903   460334  54952   60  60
SRR7939018.66807308 XII 460383  I   129006  -   -   DD  1   R1-2    460383  129006  460334  128957  60  60
SRR7939018.41862743 XII 460384  I   93706   -   +   DD  1   R1-2    460384  93706   460335  93755   60  60
SRR7939018.56047497 XII 460395  I   27716   +   -   DD  1   R1-2    460395  27716   460444  27667   60  9       A:G:40:27666:0
SRR7939018.31650130 XII 460404  I   38367   +   +   DD  1   R1-2    460404  38367   460437  38416   60  60
SRR7939018.47344095 XII 460405  I   17659   +   +   DD  1   R1-2    460405  17659   460454  17708   60  13
SRR7939018.54449091 XII 460406  I   62949   +   +   DD  1   R1-2    460406  62949   460455  62998   60  60
SRR7939018.57445225 XII 460406  I   120568  +   -   DD  1   R1-2    460406  120568  460452  120519  60  60
SRR7939018.58036347 XII 460406  I   132894  +   -   DD  1   R1-2    460406  132894  460455  132845  60  60  C:G:13:460408:3
SRR7939018.58378628 XII 460408  I   169975  +   -   DD  1   R1-2    460408  169975  460457  169926  60  60
SRR7939018.64646204 XII 460413  I   10337   +   -   DD  1   R1-2    460413  10337   460462  10288   60  60
SRR7939018.65971876 XII 460413  I   77698   -   -   DD  1   R1-2    460413  77698   460384  77649   15  60
SRR7939018.37138404 XII 460415  I   88901   +   -   DD  1   R1-2    460415  88901   460464  88852   60  60  C:G:40:460439:25
SRR7939018.57214299 XII 460415  I   133966  +   +   DD  1   R1-2    460415  133966  460464  134015  60  60
SRR7939018.57806656 XII 460437  I   175403  +   -   DD  1   R1-2    460437  175403  460486  175368  60  60
SRR7939018.60232095 XII 460443  I   127947  +   -   DD  1   R1-2    460443  127947  460492  127898  60  60
SRR7939018.56698026 XII 460444  I   63531   +   +   DD  1   R1-2    460444  63531   460493  63580   60  60
SRR7939018.14409374 XII 460454  I   125413  +   -   DD  1   R1-2    460454  125413  460503  125364  60  60
SRR7939018.29536941 XII 460462  I   108644  +   -   DD  1   R1-2    460462  108644  460506  108595  60  60
SRR7939018.20016116 XII 460470  I   80244   -   -   DD  1   R1-2    460470  80244   460421  80207   60  60
SRR7939018.49670905 XII 460473  I   119506  -   -   DD  1   R1-2    460473  119506  460424  119457  60  60
SRR7939018.43240238 XII 460481  I   138240  +   -   DD  1   R1-2    460481  138240  460530  138191  60  60      G:T:40:138225:35
SRR7939018.50560445 XII 460486  I   191779  +   -   DD  1   R1-2    460486  191779  460535  191730  60  60
SRR7939018.56502705 XII 460488  I   267 +   +   DD  1   R1-2    460488  267 460537  316 60  59      A:T:40:296:30
SRR7939018.19658648 XII 460488  I   175497  -   +   DD  1   R1-2    460488  175497  460439  175546  60  60
SRR7939018.60216887 XII 460489  I   120599  +   +   DD  1   R1-2    460489  120599  460538  120648  60  60
SRR7939018.19530343 XII 460489  I   134189  +   +   DD  1   R1-2    460489  134189  460538  134234  60  60
SRR7939018.51996186 XII 460489  I   179998  +   +   DD  1   R1-2    460489  179998  460533  180047  60  51  T:A:13:460503:15    T:G:13:180003:6,T:C:13:180004:7,T:C:2:180025:28
SRR7939018.43528567 XII 460493  I   1324    +   +   DD  1   R1-2    460493  1324    460542  1369    60  60
SRR7939018.16110145 XII 460494  I   134324  +   -   DD  1   R1-2    460494  134324  460543  134292  60  60
SRR7939018.63786046 XII 460494  I   194077  +   -   DD  1   R1-2    460494  194077  460543  194028  60  60
SRR7939018.21834004 XII 460507  I   159122  -   -   DD  1   R1-2    460507  159122  460458  159073  60  60      C:T:13:159082:10
SRR7939018.35256268 XII 460513  I   115552  -   -   DD  1   R1-2    460513  115552  460464  115503  60  60
SRR7939018.19943198 XII 460514  I   48912   +   -   DD  1   R1-2    460514  48912   460563  48863   60  60
SRR7939018.39213053 XII 460514  I   48912   +   -   DD  1   R1-2    460514  48912   460563  48863   60  60
SRR7939018.63517525 XII 460514  I   56622   +   +   DD  1   R1-2    460514  56622   460563  56671   60  60
SRR7939018.17390060 XII 460514  I   58448   +   +   DD  1   R1-2    460514  58448   460563  58487   60  60
SRR7939018.29267763 XII 460514  I   58448   +   +   DD  1   R1-2    460514  58448   460563  58487   60  60
SRR7939018.45983815 XII 460533  I   144836  -   -   DD  1   R1-2    460533  144836  460493  144787  60  60      C:A:40:144810:24,T:A:40:144820:34
SRR7939018.57884939 XII 460536  I   147509  +   -   DD  1   R1-2    460536  147509  460585  147460  60  60
SRR7939018.9114746  XII 460544  I   49089   +   -   DD  1   R1-2    460544  49089   460582  49040   60  60
SRR7939018.53712551 XII 460546  I   19491   +   +   DD  1   R1-2    460546  19491   460595  19540   32  11      G:A:40:19519:29
SRR7939018.50300431 XII 460547  I   173750  +   -   DD  1   R1-2    460547  173750  460596  173701  28  60
SRR7939018.23741869 XII 460554  I   81881   +   +   DD  1   R1-2    460554  81881   460603  81930   1   60
SRR7939018.35991370 XII 460554  I   81881   +   +   DD  1   R1-2    460554  81881   460603  81930   1   60
SRR7939018.42723903 XII 460577  I   12905   -   -   DD  1   R1-2    460577  12905   460528  12856   60  18
SRR7939018.42670356 XII 460586  I   122495  -   -   DD  1   R1-2    460586  122495  460537  122446  60  60
SRR7939018.57874676 XII 460586  I   122495  -   -   DD  1   R1-2    460586  122495  460537  122446  60  60
SRR7939018.19911629 XII 460586  I   192523  -   +   DD  1   R1-2    460586  192523  460537  192571  42  46  A:T:13:460553:17    C:A:13:192549:27
SRR7939018.32040997 XII 460587  I   51533   -   -   DD  1   R1-2    460587  51533   460551  51484   21  60
SRR7939018.66455480 XII 460587  I   51533   -   -   DD  1   R1-2    460587  51533   460551  51484   21  60
SRR7939018.58255762 XII 460602  I   14063   -   +   DD  1   R1-2    460602  14063   460553  14112   4   13  G:T:27:460574:22
SRR7939018.43361618 XII 15900   II  461748  -   -   DD  1   R1-2    15900   461748  15851   461699  60  60
SRR7939018.42788745 XII 19337   II  455052  +   -   DD  1   R1-2    19337   455052  19386   455003  60  60
SRR7939018.64571756 XII 19337   II  455052  +   -   DD  1   R1-2    19337   455052  19386   455003  60  60
SRR7939018.48860365 XII 22426   II  467616  -   -   DD  1   R1-2    22426   467616  22377   467567  60  60
SRR7939018.49130720 XII 24800   II  461959  +   -   DD  1   R1-2    24800   461959  24849   461926  60  60
SRR7939018.33780979 XII 26285   II  457161  +   -   DD  1   R1-2    26285   457161  26334   457115  60  60
SRR7939018.63221199 XII 30544   II  452769  +   +   DD  1   R1-2    30544   452769  30593   452818  60  60
SRR7939018.17357044 XII 30711   II  463284  -   +   DD  1   R1-2    30711   463284  30662   463333  60  60
SRR7939018.17692295 XII 31790   II  453795  +   +   DD  1   R1-2    31790   453795  31839   453844  60  60
SRR7939018.40960445 XII 31790   II  453795  +   +   DD  1   R1-2    31790   453795  31839   453844  60  60
SRR7939018.23257796 XII 32258   II  452850  +   +   DD  1   R1-2    32258   452850  32307   452899  60  60
SRR7939018.34163181 XII 33538   II  451913  -   -   DD  1   R1-2    33538   451913  33489   451864  60  60      C:A:38:451863:0
SRR7939018.52687900 XII 33538   II  451913  -   -   DD  1   R1-2    33538   451913  33489   451864  60  60      C:A:40:451863:0
SRR7939018.65775255 XII 36934   II  464271  +   -   DD  1   R1-2    36934   464271  36983   464222  60  60
SRR7939018.9928318  XII 37654   II  456480  -   -   DD  1   R1-2    37654   456480  37622   456431  60  60
SRR7939018.55896602 XII 40033   II  452398  +   -   DD  1   R1-2    40033   452398  40082   452349  60  60
SRR7939018.55540772 XII 41740   II  468246  -   +   DD  1   R1-2    41740   468246  41691   468295  60  60
SRR7939018.53547528 XII 43400   II  452781  +   +   DD  1   R1-2    43400   452781  43449   452830  60  60  T:A:40:43411:12
SRR7939018.31639710 XII 46858   II  455762  -   +   DD  1   R1-2    46858   455762  46809   455811  60  60
SRR7939018.57878262 XII 54872   II  466538  +   +   DD  1   R1-2    54872   466538  54921   466587  60  60
SRR7939018.43444976 XII 55537   II  464927  -   +   DD  1   R1-2    55537   464927  55488   464976  60  60
SRR7939018.51172215 XII 58535   II  467466  +   +   DD  1   R1-2    58535   467466  58584   467510  60  60
SRR7939018.49746965 XII 61688   II  454812  -   +   DD  1   R1-2    61688   454812  61639   454861  60  60
SRR7939018.29392717 XII 63448   II  461149  -   +   DD  1   R1-2    63448   461149  63399   461198  60  60
SRR7939018.63439907 XII 65937   II  452782  +   +   DD  1   R1-2    65937   452782  65986   452831  60  60
SRR7939018.66830859 XII 66317   II  456985  -   -   DD  1   R1-2    66317   456985  66268   456936  60  60
SRR7939018.38283211 XII 68442   II  455218  -   -   DD  1   R1-2    68442   455218  68403   455169  60  60
SRR7939018.56896061 XII 68442   II  455218  -   -   DD  1   R1-2    68442   455218  68403   455169  60  60
SRR7939018.61150242 XII 70836   II  461323  +   -   DD  1   R1-2    70836   461323  70885   461274  60  60
SRR7939018.62779822 XII 71356   II  455271  +   -   DD  1   R1-2    71356   455271  71394   455222  60  60
SRR7939018.23030527 XII 72307   II  467402  -   -   DD  1   R1-2    72307   467402  72258   467353  60  60
SRR7939018.51584120 XII 72976   II  455903  +   -   DD  1   R1-2    72976   455903  73025   455854  60  60
SRR7939018.55276138 XII 72976   II  455903  +   -   DD  1   R1-2    72976   455903  73025   455854  60  60
SRR7939018.57687388 XII 78682   II  465765  -   -   DD  1   R1-2    78682   465765  78633   465716  60  60
SRR7939018.12553343 XII 80607   II  454776  -   +   DD  1   R1-2    80607   454776  80558   454825  60  28  G:A:2:80572:15  C:G:2:454794:19,A:G:2:454795:20,A:G:2:454797:22,A:T:2:454814:39
SRR7939018.29908494 XII 80607   II  454776  -   +   DD  1   R1-2    80607   454776  80558   454825  60  60
SRR7939018.56788707 XII 83540   II  457739  +   -   DD  1   R1-2    83540   457739  83589   457695  60  60
SRR7939018.59649809 XII 84814   II  455739  +   -   DD  1   R1-2    84814   455739  84863   455690  60  60
SRR7939018.50358254 XII 89711   II  463932  -   +   DD  1   R1-2    89711   463932  89662   463981  60  60
SRR7939018.61582139 XII 89711   II  463932  -   +   DD  1   R1-2    89711   463932  89662   463981  60  60
SRR7939018.60920512 XII 90992   II  460428  -   +   DD  1   R1-2    90992   460428  90943   460464  60  60
SRR7939018.5579821  XII 92928   II  456290  -   -   DD  1   R1-2    92928   456290  92885   456241  60  60
SRR7939018.59382803 XII 92928   II  456290  -   -   DD  1   R1-2    92928   456290  92885   456241  60  60
SRR7939018.40869415 XII 93675   II  458906  +   -   DD  1   R1-2    93675   458906  93724   458857  60  60
SRR7939018.65341682 XII 97986   II  461157  -   +   DD  1   R1-2    97986   461157  97937   461206  60  60  G:A:38:97939:3
SRR7939018.46351317 XII 98269   II  463119  -   -   DD  1   R1-2    98269   463119  98220   463070  60  60
SRR7939018.58872683 XII 98269   II  463119  -   -   DD  1   R1-2    98269   463119  98220   463070  60  60
SRR7939018.56536535 XII 98451   II  465368  +   +   DD  1   R1-2    98451   465368  98500   465417  60  60
SRR7939018.52168766 XII 100972  II  465522  -   +   DD  1   R1-2    100972  465522  100923  465571  60  60      C:A:40:465532:11
SRR7939018.46653618 XII 106036  II  453049  -   +   DD  1   R1-2    106036  453049  106007  453098  60  60
SRR7939018.43414952 XII 106043  II  455324  +   -   DD  1   R1-2    106043  455324  106092  455275  60  60
SRR7939018.54556301 XII 109804  II  454102  -   -   DD  1   R1-2    109804  454102  109755  454053  60  60  T:C:40:109764:10
SRR7939018.45859509 XII 110045  II  460078  +   +   DD  1   R1-2    110045  460078  110094  460127  60  60
SRR7939018.19275302 XII 111930  II  454023  -   +   DD  1   R1-2    111930  454023  111881  454072  60  60
SRR7939018.40085268 XII 111930  II  454023  -   +   DD  1   R1-2    111930  454023  111881  454072  60  60
SRR7939018.51842656 XII 117508  II  455716  +   -   DD  1   R1-2    117508  455716  117557  455667  60  60  T:G:13:117513:6
SRR7939018.28431077 XII 120456  II  465557  -   +   DD  1   R1-2    120456  465557  120407  465606  60  60
SRR7939018.64745497 XII 120456  II  465557  -   +   DD  1   R1-2    120456  465557  120407  465606  60  60
SRR7939018.46159982 XII 126996  II  463570  -   +   DD  1   R1-2    126996  463570  126947  463619  60  60
SRR7939018.59826626 XII 126996  II  463570  -   +   DD  1   R1-2    126996  463570  126947  463619  60  60
SRR7939018.49402926 XII 127651  II  451839  +   -   DD  1   R1-2    127651  451839  127700  451804  60  60
SRR7939018.23938252 XII 128524  II  465962  -   -   DD  1   R1-2    128524  465962  128475  465913  60  60
SRR7939018.6104118  XII 128888  II  467458  -   -   DD  1   R1-2    128888  467458  128839  467409  60  60
SRR7939018.19230267 XII 132404  II  451762  -   -   DD  1   R1-2    132404  451762  132355  451713  60  60
SRR7939018.49360127 XII 134842  II  456394  +   +   DD  1   R1-2    134842  456394  134891  456443  60  60
SRR7939018.57688158 XII 135110  II  465404  +   -   DD  1   R1-2    135110  465404  135142  465355  60  60
SRR7939018.33817744 XII 136851  II  457034  +   -   DD  1   R1-2    136851  457034  136900  456985  60  60
SRR7939018.66038527 XII 138827  II  459144  +   +   DD  1   R1-2    138827  459144  138876  459193  60  60
SRR7939018.60018919 XII 140139  II  454844  +   -   DD  1   R1-2    140139  454844  140188  454804  60  60
SRR7939018.30885263 XII 145127  II  460071  -   +   DD  1   R1-2    145127  460071  145078  460120  60  60
SRR7939018.35933350 XII 149736  II  464163  +   +   DD  1   R1-2    149736  464163  149785  464212  60  60
SRR7939018.52298382 XII 161909  II  454757  +   +   DD  1   R1-2    161909  454757  161958  454806  60  60
SRR7939018.27605583 XII 165867  II  465664  +   +   DD  1   R1-2    165867  465664  165916  465713  60  60
SRR7939018.46445822 XII 167927  II  458718  +   -   DD  1   R1-2    167927  458718  167976  458669  28  60
SRR7939018.8473367  XII 177902  II  458596  -   +   DD  1   R1-2    177902  458596  177853  458645  60  60
SRR7939018.36087059 XII 179502  II  462171  -   -   DD  1   R1-2    179502  462171  179453  462122  60  60
SRR7939018.23910245 XII 179587  II  463689  +   -   DD  1   R1-2    179587  463689  179636  463640  60  60
SRR7939018.46909030 XII 183021  II  459537  -   +   DD  1   R1-2    183021  459537  182976  459586  60  60
SRR7939018.36208392 XII 187122  II  462339  -   -   DD  1   R1-2    187122  462339  187073  462290  60  60
SRR7939018.66045755 XII 190902  II  467531  -   +   DD  1   R1-2    190902  467531  190853  467580  60  60
SRR7939018.31007848 XII 191416  II  465188  +   -   DD  1   R1-2    191416  465188  191465  465139  60  60
SRR7939018.35626271 XII 192754  II  465641  -   -   DD  1   R1-2    192754  465641  192705  465592  60  60
SRR7939018.48785789 XII 192754  II  465641  -   -   DD  1   R1-2    192754  465641  192705  465592  60  60
SRR7939018.26777537 XII 193414  II  454163  +   -   DD  1   R1-2    193414  454163  193463  454114  60  60
SRR7939018.39027045 XII 197866  II  456354  -   +   DD  1   R1-2    197866  456354  197817  456403  60  60  T:A:40:197817:1
SRR7939018.58585215 XII 203586  II  467752  +   -   DD  1   R1-2    203586  467752  203635  467703  60  60
SRR7939018.37481094 XII 204552  II  456341  -   -   DD  1   R1-2    204552  456341  204503  456292  60  60
SRR7939018.45902921 XII 210674  II  461787  -   -   DD  1   R1-2    210674  461787  210625  461738  60  60  A:T:40:210624:0
SRR7939018.50377307 XII 222670  II  467522  +   +   DD  1   R1-2    222670  467522  222719  467571  60  60
SRR7939018.52976554 XII 222801  II  463269  -   +   DD  1   R1-2    222801  463269  222752  463318  28  60
SRR7939018.22296433 XII 226264  II  458128  -   +   DD  1   R1-2    226264  458128  226215  458177  60  60
SRR7939018.10272345 XII 227323  II  459672  +   +   DD  1   R1-2    227323  459672  227372  459707  60  60
SRR7939018.37826325 XII 229516  II  452887  +   -   DD  1   R1-2    229516  452887  229565  452838  60  60
SRR7939018.36065546 XII 230046  II  463266  -   +   DD  1   R1-2    230046  463266  230011  463315  60  60
SRR7939018.46057280 XII 233749  II  463235  -   +   DD  1   R1-2    233749  463235  233718  463284  60  60
SRR7939018.4558713  XII 233817  II  468696  -   -   DD  1   R1-2    233817  468696  233768  468647  35  60
SRR7939018.28712452 XII 233959  II  453715  -   +   DD  1   R1-2    233959  453715  233910  453764  46  60
SRR7939018.33853950 XII 237568  II  453595  -   +   DD  1   R1-2    237568  453595  237519  453644  60  60      C:A:40:453599:5
SRR7939018.31291589 XII 238819  II  461382  +   -   DD  1   R1-2    238819  461382  238868  461333  60  60
SRR7939018.46014561 XII 243153  II  464103  +   +   DD  1   R1-2    243153  464103  243189  464152  27  57
SRR7939018.50861902 XII 243153  II  464103  +   +   DD  1   R1-2    243153  464103  243189  464152  27  57
SRR7939018.55485551 XII 248200  II  457523  -   -   DD  1   R1-2    248200  457523  248151  457486  60  60
SRR7939018.44793087 XII 258566  II  451700  +   +   DD  1   R1-2    258566  451700  258615  451746  60  60
SRR7939018.41008849 XII 261393  II  467677  +   +   DD  1   R1-2    261393  467677  261442  467726  60  60
SRR7939018.47075893 XII 262349  II  464333  -   -   DD  1   R1-2    262349  464333  262300  464284  60  60
SRR7939018.6083774  XII 264386  II  456027  +   +   DD  1   R1-2    264386  456027  264435  456066  60  60
SRR7939018.41678211 XII 264386  II  456027  +   +   DD  1   R1-2    264386  456027  264435  456066  60  60
SRR7939018.44723009 XII 268969  II  458033  -   +   DD  1   R1-2    268969  458033  268920  458082  60  60
SRR7939018.10330611 XII 270199  II  463141  -   -   DD  1   R1-2    270199  463141  270160  463092  60  60
SRR7939018.60544160 XII 270199  II  463141  -   -   DD  1   R1-2    270199  463141  270160  463092  60  60
SRR7939018.37265496 XII 271644  II  460479  -   -   DD  1   R1-2    271644  460479  271600  460430  60  60
SRR7939018.56616179 XII 271644  II  460479  -   -   DD  1   R1-2    271644  460479  271600  460430  60  60
SRR7939018.59170934 XII 272238  II  457390  -   +   DD  1   R1-2    272238  457390  272189  457439  60  60      T:G:13:457400:11
SRR7939018.6795225  XII 272971  II  455714  +   +   DD  1   R1-2    272971  455714  273020  455763  60  60
SRR7939018.33782527 XII 272985  II  463076  -   +   DD  1   R1-2    272985  463076  272936  463125  60  60
SRR7939018.29229509 XII 275813  II  465650  -   +   DD  1   R1-2    275813  465650  275764  465699  60  60
SRR7939018.42828958 XII 279956  II  464736  -   -   DD  1   R1-2    279956  464736  279907  464687  60  60  G:T:40:279945:39
SRR7939018.49842267 XII 281915  II  464023  +   -   DD  1   R1-2    281915  464023  281964  463974  60  60
SRR7939018.60268238 XII 282490  II  468826  +   +   DD  1   R1-2    282490  468826  282539  468875  60  60
SRR7939018.11809091 XII 283207  II  461493  +   -   DD  1   R1-2    283207  461493  283256  461453  60  60
SRR7939018.45825575 XII 283312  II  463806  -   +   DD  1   R1-2    283312  463806  283263  463855  60  60      G:T:40:463822:17
SRR7939018.29602995 XII 284132  II  458883  -   -   DD  1   R1-2    284132  458883  284083  458834  60  60
SRR7939018.66662817 XII 284132  II  458883  -   -   DD  1   R1-2    284132  458883  284083  458834  60  60
SRR7939018.20413968 XII 284292  II  461719  -   -   DD  1   R1-2    284292  461719  284243  461670  60  60
SRR7939018.11719950 XII 285455  II  463545  +   +   DD  1   R1-2    285455  463545  285504  463594  60  60
SRR7939018.50789603 XII 285455  II  463545  +   +   DD  1   R1-2    285455  463545  285504  463594  60  60
SRR7939018.17744818 XII 288277  II  465877  +   +   DD  1   R1-2    288277  465877  288326  465926  60  60
SRR7939018.50548770 XII 292933  II  455865  -   -   DD  1   R1-2    292933  455865  292884  455816  60  60
SRR7939018.54330197 XII 294895  II  467554  -   +   DD  1   R1-2    294895  467554  294846  467603  60  60      G:A:32:467588:35
SRR7939018.54731653 XII 295447  II  464750  +   -   DD  1   R1-2    295447  464750  295496  464701  60  60      T:C:13:464720:20
SRR7939018.55679697 XII 300745  II  453015  +   -   DD  1   R1-2    300745  453015  300794  452966  60  60      A:T:13:453005:40
SRR7939018.38543515 XII 302001  II  466619  +   +   DD  1   R1-2    302001  466619  302050  466663  60  60
SRR7939018.47874305 XII 302668  II  456398  +   +   DD  1   R1-2    302668  456398  302704  456447  60  60  G:C:38:302670:3
SRR7939018.65451459 XII 308499  II  456418  +   +   DD  1   R1-2    308499  456418  308548  456467  60  60
SRR7939018.42430729 XII 311527  II  454391  -   +   DD  1   R1-2    311527  454391  311478  454440  60  60
SRR7939018.52576625 XII 311527  II  454391  -   +   DD  1   R1-2    311527  454391  311478  454440  60  60
SRR7939018.16403398 XII 312291  II  456177  -   -   DD  1   R1-2    312291  456177  312242  456128  60  60
SRR7939018.51040863 XII 322184  II  465278  +   -   DD  1   R1-2    322184  465278  322233  465229  60  60
SRR7939018.43569353 XII 323842  II  468315  +   -   DD  1   R1-2    323842  468315  323891  468279  60  60
SRR7939018.56918809 XII 325689  II  455038  +   -   DD  1   R1-2    325689  455038  325738  454989  60  60
SRR7939018.56122568 XII 328802  II  452900  -   -   DD  1   R1-2    328802  452900  328753  452851  60  60
SRR7939018.44264581 XII 338263  II  455565  -   +   DD  1   R1-2    338263  455565  338214  455614  60  60  G:A:38:338261:48
SRR7939018.43532898 XII 339928  II  462784  -   +   DD  1   R1-2    339928  462784  339879  462833  60  60
SRR7939018.34686965 XII 339951  II  465468  -   +   DD  1   R1-2    339951  465468  339904  465517  60  60
SRR7939018.55385729 XII 339993  II  461316  -   -   DD  1   R1-2    339993  461316  339948  461267  60  60
SRR7939018.19815051 XII 346541  II  462921  +   -   DD  1   R1-2    346541  462921  346590  462872  60  60
SRR7939018.34264099 XII 347355  II  454989  +   +   DD  1   R1-2    347355  454989  347404  455038  60  60
SRR7939018.65135424 XII 347355  II  454989  +   +   DD  1   R1-2    347355  454989  347404  455038  60  60
SRR7939018.19514827 XII 347506  II  460414  +   -   DD  1   R1-2    347506  460414  347555  460365  60  60
SRR7939018.24931443 XII 347506  II  460414  +   -   DD  1   R1-2    347506  460414  347555  460365  60  60
SRR7939018.8726653  XII 347571  II  455890  +   +   DD  1   R1-2    347571  455890  347620  455939  60  60
SRR7939018.59732682 XII 348227  II  451958  -   -   DD  1   R1-2    348227  451958  348178  451909  60  60
SRR7939018.36934794 XII 350466  II  468738  -   +   DD  1   R1-2    350466  468738  350417  468787  60  60
SRR7939018.44954200 XII 350466  II  468738  -   +   DD  1   R1-2    350466  468738  350417  468787  60  60
SRR7939018.64087984 XII 350733  II  455735  +   -   DD  1   R1-2    350733  455735  350782  455686  60  60
SRR7939018.57772886 XII 351073  II  452094  +   +   DD  1   R1-2    351073  452094  351122  452135  60  60
SRR7939018.30660510 XII 351191  II  467303  -   -   DD  1   R1-2    351191  467303  351148  467255  60  60
SRR7939018.14184235 XII 353358  II  461263  +   -   DD  1   R1-2    353358  461263  353407  461214  60  60
SRR7939018.51844559 XII 353358  II  461263  +   -   DD  1   R1-2    353358  461263  353407  461214  60  60
SRR7939018.46717910 XII 357027  II  468956  -   -   DD  1   R1-2    357027  468956  356978  468907  60  60
SRR7939018.12719664 XII 360012  II  455077  +   -   DD  1   R1-2    360012  455077  360061  455028  60  60
SRR7939018.56931965 XII 362491  II  456139  +   -   DD  1   R1-2    362491  456139  362540  456090  60  60
SRR7939018.57230835 XII 364812  II  465269  +   +   DD  1   R1-2    364812  465269  364861  465318  60  60
SRR7939018.33855943 XII 368151  II  452591  +   +   DD  1   R1-2    368151  452591  368188  452640  60  60
SRR7939018.56062811 XII 368197  II  455649  -   +   DD  1   R1-2    368197  455649  368148  455698  60  60
SRR7939018.60683062 XII 368197  II  455649  -   +   DD  1   R1-2    368197  455649  368148  455698  60  60
SRR7939018.59716636 XII 369817  II  463250  +   +   DD  1   R1-2    369817  463250  369866  463299  60  60      C:A:38:463255:6
SRR7939018.36658686 XII 369981  II  464798  -   -   DD  1   R1-2    369981  464798  369932  464749  60  60
SRR7939018.48696631 XII 374843  II  451684  -   +   DD  1   R1-2    374843  451684  374804  451733  60  60
SRR7939018.44147642 XII 375007  II  459317  -   -   DD  1   R1-2    375007  459317  374958  459282  60  60
SRR7939018.36840692 XII 378543  II  455743  +   -   DD  1   R1-2    378543  455743  378592  455694  60  60
SRR7939018.44541673 XII 379036  II  464353  +   +   DD  1   R1-2    379036  464353  379085  464402  60  60
SRR7939018.58576090 XII 381931  II  464004  +   +   DD  1   R1-2    381931  464004  381969  464053  60  46
SRR7939018.29362668 XII 384083  II  461253  -   -   DD  1   R1-2    384083  461253  384034  461204  60  60
SRR7939018.54883651 XII 387670  II  455132  -   +   DD  1   R1-2    387670  455132  387621  455181  60  60
SRR7939018.24398283 XII 389371  II  460053  -   -   DD  1   R1-2    389371  460053  389322  460004  60  60
SRR7939018.62248145 XII 391653  II  461754  +   -   DD  1   R1-2    391653  461754  391702  461705  60  60      T:G:27:461706:2
SRR7939018.54104124 XII 392078  II  466253  -   +   DD  1   R1-2    392078  466253  392029  466302  60  60
SRR7939018.49066500 XII 392282  II  468352  -   -   DD  1   R1-2    392282  468352  392233  468303  60  60
SRR7939018.51126571 XII 393043  II  455678  -   -   DD  1   R1-2    393043  455678  392994  455629  60  60
SRR7939018.15450504 XII 393396  II  465019  -   +   DD  1   R1-2    393396  465019  393351  465068  60  60
SRR7939018.47435029 XII 400409  II  467886  -   -   DD  1   R1-2    400409  467886  400360  467837  60  60  A:T:40:400359:0
SRR7939018.64142816 XII 400480  II  467141  -   +   DD  1   R1-2    400480  467141  400431  467190  60  60
SRR7939018.31950420 XII 405526  II  452675  -   -   DD  1   R1-2    405526  452675  405477  452626  60  60      T:A:40:452625:0
SRR7939018.64469120 XII 405526  II  452675  -   -   DD  1   R1-2    405526  452675  405477  452626  60  60      T:A:38:452625:0
SRR7939018.12390563 XII 409428  II  467605  -   +   DD  1   R1-2    409428  467605  409379  467654  60  60
SRR7939018.60915028 XII 412043  II  457281  +   -   DD  1   R1-2    412043  457281  412092  457232  53  60
SRR7939018.64420698 XII 413967  II  455362  -   -   DD  1   R1-2    413967  455362  413918  455313  60  60
SRR7939018.43569936 XII 414602  II  455237  -   +   DD  1   R1-2    414602  455237  414553  455286  60  60
SRR7939018.58624738 XII 414833  II  455206  -   -   DD  1   R1-2    414833  455206  414784  455157  60  60
SRR7939018.17887581 XII 417262  II  467006  -   -   DD  1   R1-2    417262  467006  417213  466957  60  60
SRR7939018.45167772 XII 422265  II  454776  -   +   DD  1   R1-2    422265  454776  422225  454825  60  60
SRR7939018.47587941 XII 424271  II  456220  +   +   DD  1   R1-2    424271  456220  424320  456269  60  60
SRR7939018.63694278 XII 424808  II  455768  +   +   DD  1   R1-2    424808  455768  424857  455817  60  60
SRR7939018.38144761 XII 426952  II  460004  -   +   DD  1   R1-2    426952  460004  426903  460046  60  60
SRR7939018.19295726 XII 428229  II  468196  -   +   DD  1   R1-2    428229  468196  428185  468245  60  60
SRR7939018.14305249 XII 429980  II  455971  -   -   DD  1   R1-2    429980  455971  429931  455922  60  60
SRR7939018.7399580  XII 430264  II  454792  -   -   DD  1   R1-2    430264  454792  430230  454751  60  60
SRR7939018.46495454 XII 434999  II  459017  +   -   DD  1   R1-2    434999  459017  435048  458974  60  60
SRR7939018.4203425  XII 435070  II  467504  -   -   DD  1   R1-2    435070  467504  435021  467473  60  60
SRR7939018.60325388 XII 435130  II  466528  -   +   DD  1   R1-2    435130  466528  435081  466577  60  60  A:T:13:435129:49    C:G:13:466553:26
SRR7939018.62008509 XII 435130  II  466528  -   +   DD  1   R1-2    435130  466528  435081  466577  60  60  G:T:13:435105:25
SRR7939018.58410312 XII 439347  II  455525  +   -   DD  1   R1-2    439347  455525  439396  455476  60  60
SRR7939018.30113233 XII 440598  II  455273  -   +   DD  1   R1-2    440598  455273  440549  455322  60  60
SRR7939018.53517986 XII 444967  II  466249  +   -   DD  1   R1-2    444967  466249  445016  466200  60  60
SRR7939018.45906487 XII 447370  II  467196  -   +   DD  1   R1-2    447370  467196  447321  467245  60  60
SRR7939018.49979402 XII 459761  II  119631  +   -   DD  1   R1-2    459761  119631  459810  119582  42  60
SRR7939018.48830500 XII 459781  II  434929  +   -   DD  1   R1-2    459781  434929  459830  434880  57  60      A:T:2:434882:3,C:T:2:434912:33
SRR7939018.30689418 XII 459800  II  380057  -   +   DD  1   R1-2    459800  380057  459751  380106  4   60
SRR7939018.31451441 XII 459800  II  380057  -   +   DD  1   R1-2    459800  380057  459751  380106  4   60
SRR7939018.23126756 XII 459800  II  523194  -   -   DD  1   R1-2    459800  523194  459751  523145  4   60
SRR7939018.44541807 XII 459800  II  523194  -   -   DD  1   R1-2    459800  523194  459751  523145  4   60
SRR7939018.62798775 XII 459804  II  103278  -   -   DD  1   R1-2    459804  103278  459755  103244  18  60
SRR7939018.13033853 XII 459804  II  328728  -   -   DD  1   R1-2    459804  328728  459755  328687  18  60
SRR7939018.40420851 XII 459805  II  491338  -   -   DD  1   R1-2    459805  491338  459756  491289  22  60
SRR7939018.49929176 XII 459807  II  109544  -   -   DD  1   R1-2    459807  109544  459758  109495  32  60
SRR7939018.59819397 XII 459809  II  306581  -   +   DD  1   R1-2    459809  306581  459760  306630  39  60
SRR7939018.59541056 XII 459823  II  85825   -   -   DD  1   R1-2    459823  85825   459774  85776   16  60  C:A:2:459779:6,T:G:2:459785:12,T:A:2:459793:20
SRR7939018.55265045 XII 459827  II  726067  +   -   DD  1   R1-2    459827  726067  459876  726018  60  60
SRR7939018.52078452 XII 459828  II  572795  +   -   DD  1   R1-2    459828  572795  459877  572746  60  60
SRR7939018.55916073 XII 459829  II  63247   +   -   DD  1   R1-2    459829  63247   459878  63198   60  60
SRR7939018.47483168 XII 459830  II  399775  +   +   DD  1   R1-2    459830  399775  459879  399824  60  60
SRR7939018.60246474 XII 459831  II  793149  +   -   DD  1   R1-2    459831  793149  459880  793100  60  60
SRR7939018.31622403 XII 459832  II  156743  +   +   DD  1   R1-2    459832  156743  459881  156792  60  60      A:G:40:156775:33
SRR7939018.57546830 XII 459832  II  156743  +   +   DD  1   R1-2    459832  156743  459881  156792  60  60      A:G:38:156775:33
SRR7939018.54775413 XII 459832  II  746553  +   -   DD  1   R1-2    459832  746553  459881  746504  60  60
SRR7939018.64500697 XII 459835  II  403157  +   -   DD  1   R1-2    459835  403157  459884  403108  60  60
SRR7939018.40480581 XII 459837  II  692044  +   +   DD  1   R1-2    459837  692044  459886  692093  60  60      C:A:40:692082:39
SRR7939018.65284559 XII 459838  II  204771  +   -   DD  1   R1-2    459838  204771  459887  204722  60  60
SRR7939018.53414305 XII 459838  II  482158  +   +   DD  1   R1-2    459838  482158  459887  482207  60  60
SRR7939018.56705669 XII 459839  II  387843  +   +   DD  1   R1-2    459839  387843  459888  387879  60  60
SRR7939018.52300906 XII 459839  II  425809  +   +   DD  1   R1-2    459839  425809  459888  425858  60  60
SRR7939018.45740770 XII 459839  II  724598  +   +   DD  1   R1-2    459839  724598  459888  724647  60  60
SRR7939018.64586619 XII 459839  II  760783  +   +   DD  1   R1-2    459839  760783  459888  760832  60  60  C:T:13:459853:15    G:A:13:760789:7,G:T:13:760794:12
SRR7939018.47267896 XII 459842  II  98134   +   +   DD  1   R1-2    459842  98134   459891  98183   60  60
SRR7939018.51205287 XII 459842  II  199611  +   +   DD  1   R1-2    459842  199611  459891  199660  60  60
SRR7939018.49454309 XII 459842  II  237894  +   +   DD  1   R1-2    459842  237894  459891  237943  60  60
SRR7939018.10902631 XII 459842  II  276113  +   -   DD  1   R1-2    459842  276113  459891  276064  60  60
SRR7939018.43022441 XII 459842  II  376059  +   +   DD  1   R1-2    459842  376059  459891  376108  60  60
SRR7939018.30357170 XII 459842  II  582077  +   +   DD  1   R1-2    459842  582077  459891  582126  60  60
SRR7939018.55549939 XII 459842  II  739957  +   +   DD  1   R1-2    459842  739957  459891  740006  60  60  C:T:13:459860:19    G:C:13:739965:9,C:T:13:739966:10
SRR7939018.29341026 XII 459846  II  745198  +   +   DD  1   R1-2    459846  745198  459895  745247  60  60
SRR7939018.32552712 XII 459851  II  727473  +   -   DD  1   R1-2    459851  727473  459900  727424  60  60
SRR7939018.66074811 XII 459852  II  325172  +   -   DD  1   R1-2    459852  325172  459901  325123  60  60
SRR7939018.56113531 XII 459855  II  547637  +   -   DD  1   R1-2    459855  547637  459904  547588  60  60
SRR7939018.36633720 XII 459857  II  422526  +   +   DD  1   R1-2    459857  422526  459906  422575  60  60
SRR7939018.41034331 XII 459857  II  470665  +   +   DD  1   R1-2    459857  470665  459906  470714  60  60
SRR7939018.12630196 XII 459857  II  718751  +   -   DD  1   R1-2    459857  718751  459906  718721  60  60
SRR7939018.12697978 XII 459864  II  127084  +   +   DD  1   R1-2    459864  127084  459913  127133  60  60
SRR7939018.65819542 XII 459864  II  127084  +   +   DD  1   R1-2    459864  127084  459913  127133  60  60
SRR7939018.59362086 XII 459864  II  254166  +   +   DD  1   R1-2    459864  254166  459913  254215  60  60
SRR7939018.28851550 XII 459864  II  431746  +   -   DD  1   R1-2    459864  431746  459913  431697  60  60
SRR7939018.21509778 XII 459865  II  375476  +   -   DD  1   R1-2    459865  375476  459914  375427  60  60
SRR7939018.61815243 XII 459865  II  375476  +   -   DD  1   R1-2    459865  375476  459914  375427  60  60
SRR7939018.63884757 XII 459865  II  375476  +   -   DD  1   R1-2    459865  375476  459914  375427  60  60
SRR7939018.44576946 XII 459868  II  210004  +   -   DD  1   R1-2    459868  210004  459917  209955  60  60
SRR7939018.41850757 XII 459868  II  441652  +   -   DD  1   R1-2    459868  441652  459917  441605  60  60
SRR7939018.61176105 XII 459868  II  557055  +   +   DD  1   R1-2    459868  557055  459917  557104  60  60
SRR7939018.54403748 XII 459869  II  28788   +   -   DD  1   R1-2    459869  28788   459913  28739   60  60
SRR7939018.28020148 XII 459869  II  129801  +   +   DD  1   R1-2    459869  129801  459918  129850  60  60
SRR7939018.39031998 XII 459869  II  272484  +   +   DD  1   R1-2    459869  272484  459918  272533  60  60
SRR7939018.46302427 XII 459869  II  564667  +   +   DD  1   R1-2    459869  564667  459918  564711  60  60
SRR7939018.50190496 XII 459869  II  742285  +   -   DD  1   R1-2    459869  742285  459918  742236  60  60
SRR7939018.19943694 XII 459870  II  103757  +   -   DD  1   R1-2    459870  103757  459919  103714  60  60
SRR7939018.50434662 XII 459870  II  103757  +   -   DD  1   R1-2    459870  103757  459919  103714  60  60
SRR7939018.30512059 XII 459870  II  453120  +   -   DD  1   R1-2    459870  453120  459919  453071  60  60
SRR7939018.46718223 XII 459873  II  44535   +   -   DD  1   R1-2    459873  44535   459922  44486   60  60
SRR7939018.9087101  XII 459873  II  72854   +   +   DD  1   R1-2    459873  72854   459922  72903   60  60
SRR7939018.42047698 XII 459873  II  72854   +   +   DD  1   R1-2    459873  72854   459922  72903   60  60
SRR7939018.55457831 XII 459873  II  779274  +   +   DD  1   R1-2    459873  779274  459922  779323  60  60  T:G:27:459877:5 T:G:27:779275:2
SRR7939018.58640269 XII 459873  II  779274  +   +   DD  1   R1-2    459873  779274  459922  779323  60  60      T:C:40:779301:28
SRR7939018.19125532 XII 459874  II  282946  +   +   DD  1   R1-2    459874  282946  459923  282995  60  60


❯ #  This seems to be working; let's make it more readable and direct the stream
❯ #+ to a temporary file, rDNA-tmp.txt, that we can check manually


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
pipe pipe>         > "rDNA-tmp.txt"


#  This isn't quite right: I don't see records for when chrom2 is XII and
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


❯ #QUESTION
❯ #  Are we picking up pairs for the condition in which XII pos1 is between
❯ #+ "left" and "right" AND XII pos2 is greater than "right"?


❯ [[ -f "${outfile/.txt/.check.txt}" ]] && rm "${outfile/.txt/.check.txt}"
❯ cat "${outfile}" \
>     | awk \
pipe>         -v left=451524 \
pipe>         -v right=468982 \
pipe>         '{
pipe quote>             if(( \
pipe quote>                 ($2 == "XII") && \
pipe quote>                 (($11 >= left) && ($13 <= right)) \
pipe quote>             ) && ( \
pipe quote>                 ($4 == "XII") && \
pipe quote>                 (($12 >= right) || ($14 >= right)) \
pipe quote>             ))
pipe quote>             { print $0 }
pipe quote>         }' \
pipe>     | sort -k5,5n -k3,3n \
pipe pipe>         > "${outfile/.txt/.check.txt}"
```
</details>
<br />






















