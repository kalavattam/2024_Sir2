
`rough-draft_ingest-files_HiGlass.md`
<br />
<br />

<a id="9-ingest-files-for-higlass"></a>
### 9. Ingest files for HiGlass
<a id="code-34"></a>
#### Code
<details>
<summary><i>Code: Ingest files for HiGlass</i></summary>

```bash
#!/bin/bash

#  Run on WorkMac (local)
run_check=FALSE
[[ "${run_check}" == TRUE ]] &&
    {
        docker exec higlass-container python higlass-server/manage.py

        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --help
    }


#  Load mcool files: This is work for quick, rough-draft assessments ----------
rough_Q=FALSE
[[ "${rough_Q}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR7939018.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_G1=FALSE
[[ "${rough_G1}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR11893107.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_G2_M=FALSE
[[ ${rough_G2_M} == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR11893084-SRR11893085.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

#  Test my "${rough_G2_M}" .mcool against the publicly available .mcool
rough_G2_M_GSE151553=TRUE
[[ ${rough_G2_M_GSE151553} == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/GSE151553_A364_merged.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_size=FALSE
[[ "${rough_size}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/S288C_reference_sequence_R64-3-1_20210421.size \
                --filetype chromsizes-tsv \
                --datatype chromsizes

        # curl http://localhost:8888/api/v1/tilesets/
    }

rough_Q_rDNA=TRUE
[[ "${rough_Q_rDNA}" == TRUE ]] &&
    {
        docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename /data/SRR7939018.standard-rDNA.mcool \
                --filetype cooler \
                --datatype matrix

        # curl http://localhost:8888/api/v1/tilesets/
    }


#  Work, 2023-0807 ------------------------------------------------------------
conda activate chromatin_env

#  Initialize function for ingesting mcool files
ingest_mcool() {
    docker exec higlass-container \
            python higlass-server/manage.py ingest_tileset \
                --filename "/data/${1}" \
                --filetype cooler \
                --datatype matrix
}


aggregate_bed() {
    clodius aggregate bedfile \
        --assembly "sacCer3" \
        --output-file "${1/bed/db}" \
        --chromsizes-filename "${2:-S288C_reference_sequence_R64-3-1_20210421.size}" \
        "${1}"
}


ingest_bed() {
    docker exec higlass-container \
        python higlass-server/manage.py ingest_tileset \
           --filename "/data/${1}" \
           --filetype beddb \
           --datatype bedlike \
           --coordSystem sacCer3
}


export -f load_mcool
export -f aggregate_bed
export -f ingest_bed


#  Ingest "updated" mcool files
updated_Q=FALSE
updated_G2M=FALSE
updated_G1=FALSE
[[ "${updated_Q}" == TRUE ]] \
    && ingest_mcool MC-2019_Q_WT_repM.standard-rDNA-complete.mcool
[[ "${updated_G2M}" == TRUE ]] \
    && ingest_mcool MC-2020_nz_WT_repM.standard-rDNA-complete.mcool
[[ "${updated_G1}" == TRUE ]] \
    && ingest_mcool MC-2020_30C-a15_WT_repM.standard-rDNA-complete.mcool


#  Aggregate and ingest gene track file
agg_rep_coding_ncRNA=FALSE
[[ "${agg_rep_coding_ncRNA}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

ing_rep_coding_ncRNA=FALSE
[[ "${ing_rep_coding_ncRNA}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.db
    #ACCIDENT #DELETE #TODO
    # && ingest_bed Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

agg_rep_coding_non_pancRNA=FALSE
[[ "${agg_rep_coding_non_pancRNA}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.bed

ing_rep_coding_non_pancRNA=FALSE
[[ "${ing_rep_coding_non_pancRNA}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.db

agg_rep_coding_noncoding=FALSE
[[ "${agg_rep_coding_noncoding}" == TRUE ]] \
    && aggregate_bed Greenlaw-et-al_representative-non-coding-transcriptome.bed

ing_rep_coding_noncoding=FALSE
[[ "${ing_rep_coding_noncoding}" == TRUE ]] \
    && ingest_bed Greenlaw-et-al_representative-non-coding-transcriptome.db

agg_S_cerevisiae_gene=TRUE
[[ "${agg_S_cerevisiae_gene}" == TRUE ]] \
    && aggregate_bed Saccharomyces_cerevisiae.R64-1-1.108.gene.bed

ing_S_cerevisiae_gene=TRUE
[[ "${ing_S_cerevisiae_gene}" == TRUE ]] \
    && ingest_bed Saccharomyces_cerevisiae.R64-1-1.108.gene.db

run_check=TRUE
[[ "${run_check}" == TRUE ]] && curl http://localhost:8888/api/v1/tilesets/


#  Work, 2023-0713, 2023-0807 -------------------------------------------------
docker exec higlass-container \
    python higlass-server/manage.py --help

docker exec higlass-container \
    python higlass-server/manage.py ingest_tileset --help

clodius --help

clodius aggregate --help

clodius aggregate bedfile --help

clodius aggregate bedgraph --help

clodius aggregate bedfile \
    --output-file "${outfile}" \
    --assembly "${assembly}" \

#  Step #1: Convert gtfs of interest into beds
gtf2bed \
    < Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf \
    > Greenlaw-et-al_non-collapsed-non-coding-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf \
    > Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.bed

gtf2bed \
    < Greenlaw-et-al_representative-non-coding-transcriptome.gtf \
    > Greenlaw-et-al_representative-non-coding-transcriptome.bed

gtf2bed \
    < processed_features-intergenic_sense-antisense.gtf \
    > processed_features-intergenic_sense-antisense.bed

gtf2bed \
    < processed_features-intergenic_sense.gtf \
    > processed_features-intergenic_sense.bed

cat Saccharomyces_cerevisiae.R64-1-1.108.gtf \
    | awk '{ if ($0 ~ "transcript_id") print $0; else print $0" transcript_id \"\";"; }' \
    | gtf2bed - \
        > Saccharomyces_cerevisiae.R64-1-1.108.bed

#IMPORTANT (2023-0807)
cat Saccharomyces_cerevisiae.R64-1-1.108.bed \
    | awk '{ if ($8 ~ "gene") { print $0 } }' \
        > Saccharomyces_cerevisiae.R64-1-1.108.gene.bed

cat Saccharomyces_cerevisiae.R64-1-1.108.bed | head

#  Step #2: Aggregate bed files for use with HiGlass
clodius aggregate bedfile \
    --assembly "sacCer3" \
    --output-file Saccharomyces_cerevisiae.R64-1-1.108.db \
    --chromsizes-filename S288C_reference_sequence_R64-3-1_20210421.size \
    Saccharomyces_cerevisiae.R64-1-1.108.bed

#  Step #3: Ingest the aggregated bed files
docker exec higlass-container \
    python higlass-server/manage.py ingest_tileset \
       --filename /data/Saccharomyces_cerevisiae.R64-1-1.108.db \
       --filetype beddb \
       --datatype bedlike \
       --coordSystem sacCer3

rough_gene_track=TRUE
[[ "${rough_gene_track}" == TRUE ]] &&
    {

    }
```
</details>
<br />
