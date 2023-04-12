#!/bin/bash
## 04.12.23 blast p.generosa against mercenaria mercenaria on MOX
#SBATCH --job-name=blasting_pgen_mercenaria_041223
## Allocation Definition
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


/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/blastx \
-query /gscratch/srlab/ocattau/clamdata/Panopea-generosa-v1.0.a4.gene.fasta \
-db /gscratch/srlab/ocattau/clamdata/ncbi_dataset/data/GCF_021730395.1/rna.fna \
-out /gscratch/srlab/ocattau/clamdata/Panopea-Mercenaria_blastx.tab \
-evalue 1E-05 \
-num_threads 30 \
-max_target_seqs 1 \
-max_hsps 1 \
-outfmt 6