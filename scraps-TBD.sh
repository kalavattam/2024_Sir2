#!/bin/bash

pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l

# ❯ pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# 26606247
#
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 35134181
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 43719118
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
# 48181260
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# read failed
# reader reader_read_block: bug encountered
# 49580650

#  Move above to TBD-2
mv MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz TBD-2/
mv MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz TBD-2/
mv MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz TBD-2/
mv MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz TBD-2/
mv MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz TBD-2/

#  All but the last were fine--pick up with troubleshooting this tomorrow

#  Retesting...
# ❯ pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# 26606246
#
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 35134180
# 
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 43719117
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
# 48181259
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# 49580763

#  Looks like this is finally solved; document the reasons (you think) why and how tomorrow
#+ 
#+ See if the current approach can be extended duplicates
mkdir TBD-3-OK/
mv MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz TBD-3-OK/
mv MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz TBD-3-OK/
mv MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz TBD-3-OK/
mv MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz TBD-3-OK/
mv MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz TBD-3-OK/


#  Making the files following TBD-3-OK/ above
# ❯ pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# 26606246
#
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 35134180
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.nodups.pairs.gz | wc -l
# 43719117
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
# 48181259
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.nodups.pairs.gz | wc -l
# 49580763

pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.dups.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.dups.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.dups.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.dups.pairs.gz | wc -l
pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.dups.pairs.gz | wc -l


# ❯ pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.dups.pairs.gz | wc -l
# 2406924
#
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.dups.pairs.gz | wc -l
# 3502907
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.dups.pairs.gz | wc -l
# 4185410
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.dups.pairs.gz | wc -l
# 5309105
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.dups.pairs.gz | wc -l
# 8574084

pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.mapped.pairs.gz | wc -l
pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.mapped.pairs.gz | wc -l

# ❯ pbgzip -dc MC-2020_nz_WT_rep1.keep-MM-0.mapped.pairs.gz | wc -l
# 29013133
#
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.keep-MM-0.mapped.pairs.gz | wc -l
# 38637050
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.keep-MM-0.mapped.pairs.gz | wc -l
# 47904490
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l
# 56755306
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.keep-MM-0.mapped.pairs.gz | wc -l
# 54889831

find . \
      -newermt "2023-10-05 13:28:00" \
    ! -newermt "2023-10-08 16:13:00" \
        | xargs rm -rf
.,f


pbgzip -dc MC-2020_nz_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l

# ❯ pbgzip -dc MC-2020_nz_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
# 61740389
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.keep-MM-0.nodups.pairs.gz | wc -l
# 93299843

pbgzip -dc MC-2020_nz_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l

# ❯ pbgzip -dc MC-2020_nz_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l
# 67650148
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.keep-MM-0.mapped.pairs.gz | wc -l
# 102794286

pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2020_nz_WT_rep1.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_rep1.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2020_nz_WT_rep2.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_nz_WT_rep2.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l

pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.mapped.pairs.gz | wc -l
pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.nodups.pairs.gz | wc -l


# ❯ pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 54590143
# ❯ pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 53846960
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 80491566
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 80015061
# ❯ pbgzip -dc MC-2020_nz_WT_rep1.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 23396270
# ❯ pbgzip -dc MC-2020_nz_WT_rep1.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 23089624
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 31193874
# ❯ pbgzip -dc MC-2020_nz_WT_rep2.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 30757371
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 37740777
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep2.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 37520885
# ❯ pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 43780484
# ❯ pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 41652844
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 42750790
# ❯ pbgzip -dc MC-2020_30C-a15_WT_rep1.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 42494211

# ❯ pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 54590143
# ❯ pbgzip -dc MC-2020_nz_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 53846960
#
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 80491566
# ❯ pbgzip -dc MC-2020_30C-a15_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 80015061
#
# ❯ pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.mapped.pairs.gz | wc -l
# 43780484
# ❯ pbgzip -dc MC-2019_Q_WT_repM.standard-rDNA-complete.nodups.pairs.gz | wc -l
# 41652844

