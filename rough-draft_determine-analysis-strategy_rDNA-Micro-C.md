
`rough-draft_determine-analysis-strategy_rDNA-Micro-C.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Test: Working with pairs files](#test-working-with-pairs-files)
    1. [Run an initial assessment of the non-deduplicated files](#run-an-initial-assessment-of-the-non-deduplicated-files)
        1. [Code](#code)
    1. [Notes](#notes)
        1. [On what and where the columns are](#on-what-and-where-the-columns-are)
        1. [On what the pair types are](#on-what-the-pair-types-are)
1. [Work out the logic to isolate rDNA pairs](#work-out-the-logic-to-isolate-rdna-pairs)
    1. [Review awk tutorial #1](#review-awk-tutorial-1)
        1. [Code](#code-1)
    1. [Review awk tutorial #2](#review-awk-tutorial-2)
        1. [Code](#code-2)
    1. [Begin to write and test usable logic](#begin-to-write-and-test-usable-logic)
        1. [Code](#code-3)
1. [Slouching toward obtaining and processing rDNA multimappers](#slouching-toward-obtaining-and-processing-rdna-multimappers)
    1. [Tests in which I had not yet determined how to retain multimappers](#tests-in-which-i-had-not-yet-determined-how-to-retain-multimappers)
        1. [Check that we have deduplicated rDNA read pairs](#check-that-we-have-deduplicated-rdna-read-pairs)
            1. [Code](#code-4)
            1. [Notes](#notes-1)
            1. [Scraps](#scraps)
    1. [Work after I had determined a strategy to retain rDNA multimappers](#work-after-i-had-determined-a-strategy-to-retain-rdna-multimappers)
        1. [Check that we have deduplicated rDNA read pairs](#check-that-we-have-deduplicated-rdna-read-pairs-1)
            1. [Code](#code-5)
            1. [Notes](#notes-2)
    1. [Implement logic for creation of deduplicated "`standard-rDNA-complete`" files](#implement-logic-for-creation-of-deduplicated-standard-rdna-complete-files)
        1. [So, what's the next step?](#so-whats-the-next-step)
            1. [Notes](#notes-3)
        1. [Updates to the naming scheme](#updates-to-the-naming-scheme)
            1. [Notes](#notes-4)
        1. [Clean up directory, then re-copy in only necessary files](#clean-up-directory-then-re-copy-in-only-necessary-files)
            1. [Code](#code-6)
            1. [Printed](#printed)
        1. [Run the actual processing](#run-the-actual-processing)
            1. [Code](#code-7)
                1. [1. Exclude rDNA-associated cis and trans interactions from "standard"](#1-exclude-rdna-associated-cis-and-trans-interactions-from-standard)
                1. [2. Retain only rDNA-associated cis and trans interactions in "keep-MM"](#2-retain-only-rdna-associated-cis-and-trans-interactions-in-keep-mm)
                1. [3. Concatenate "standard-no-rDNA" and "rDNA-only" files](#3-concatenate-standard-no-rdna-and-rdna-only-files)
                1. [4. Copy file to remote, then run `pairtools sort`](#4-copy-file-to-remote-then-run-pairtools-sort)
                1. [5. Troubleshoot the re-headering of pairs files](#5-troubleshoot-the-re-headering-of-pairs-files)
                1. [6. Test that "`0X_comp/SRR7939018.standard-no-rDNA.nodups.pairs.gz`" can be re-headered](#6-test-that-0x_compsrr7939018standard-no-rdnanodupspairsgz-can-be-re-headered)
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

<a id="printed"></a>
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
