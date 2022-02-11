#!/bin/bash
## 02.10.22 blast p.generosa on MOX
#SBATCH --job-name=blasting_p.generosa_02.10.22
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=05-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ocattau@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/srlab/ocattau/p.generosa #home directory


/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/blastx \ #load ncbi blastx software
-query /gscratch/srlab/ocattau/p.generosa/Pgenerosa_transcriptome_v5.fasta \ #this is the query file, should be the geoduck transcriptome
-db /gscratch/srlab/blastdbs/ncbi-sp-v5_20210224/swissprot \ #blast databse, should always be this swissprot in order to get gene annotations
-out /gscratch/srlab/ocattau/p.generosa/Panopea-generosa-uniprot_blastx.tab \ #output file 
-evalue 1E-05 \
-num_threads 30 \ #number of threads is going to be +28
-max_target_seqs 1 \
-max_hsps 1 \
-outfmt 6
