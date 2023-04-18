#!/bin/bash
## 04.18.23 blast Pgen against Mactra quadragularis Genome on Mox
#SBATCH --job-name=blasting_mactra_on_pgen
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=05-00:00:00
## Memory per node
#SBATCH --mem=100G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ocattau@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/srlab/ocattau

/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/makeblastdb \
-in /gscratch/srlab/ocattau/clamdata/GCA_025267735.1_ASM2526773v1_genomic.fna \
-dbtype nucl \
-out /gscratch/srlab/ocattau/clamdata/blastdb2/mactra_db_genome

/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/blastn \
-query /gscratch/srlab/ocattau/clamdata/Panopea-generosa-v1.0.a4.gene.fasta \
-db /gscratch/srlab/ocattau/clamdata/blastdb2/mercenaria_db_genome \
-out /gscratch/srlab/ocattau/clamdata/blast_output/Pgenerosa_mactra_db_genome_blastn.tab \
-evalue 1E-20 \
-num_threads 30 \
-max_target_seqs 1 \
-max_hsps 1 \
-outfmt 6