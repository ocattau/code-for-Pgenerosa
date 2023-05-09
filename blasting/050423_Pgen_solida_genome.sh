#!/bin/bash
## 05.04.23 blast Pgen against S. solida Genome on Mox
#SBATCH --job-name=blasting_solida_on_Pgen_genome
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=00-01:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ocattau@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/srlab/ocattau

/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/makeblastdb \
-in /gscratch/srlab/ocattau/clamdata/ncbi_dataset/data/ncbi_dataset/data/GCA_947247005.1/GCA_947247005.1_xbSpiSoli1.1_genomic.fna \
-dbtype nucl \
-out /gscratch/srlab/ocattau/clamdata/blastdb2/solida_db_genome

/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/blastn \
-query /gscratch/srlab/ocattau/clamdata/Panopea-generosa-v1.0.a4.gene.fasta \
-db /gscratch/srlab/ocattau/clamdata/blastdb2/solida_db_genome \
-out /gscratch/srlab/ocattau/clamdata/blast_output/solida_db_genome_blastn.tab \
-evalue 1E-20 \
-num_threads 30 \
-max_target_seqs 1 \
-max_hsps 1 \
-outfmt 6