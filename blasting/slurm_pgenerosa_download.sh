#!/bin/bash
## 10.29.21 blast p.generosa on MOX
#SBATCH --job-name=blasting_p.generosa_10.29.21
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=00-12:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ocattau@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/srlab/ocattau/p.generosa


#download geoduck transcriptome from genomic databank
curl --insecure \
-O https://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_transcriptome_v5.fasta \
mv Pgenerosa_transcriptome_v5.fasta  /gscratch/srlab/ocattau/p.generosa/
