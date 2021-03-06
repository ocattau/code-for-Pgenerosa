
# Final Link to cleaned count data with Go terms [pgenerosa larval gene annotations](https://gannet.fish.washington.edu/gigas/data/pgenerosa_larvae_cleaned.tab)

## Read table output from cleaned file
```{r]
read.table(file="https://raw.githubusercontent.com/ocattau/code/main/pgenerosa_larvae_cleaned.tab")
```

## Download kallisto output from gannet
```{r}
countMatrix<-read.table(file="https://gannet.fish.washington.edu/gigas/analyses/output_01/abundance.tsv", header=TRUE)
head(countMatrix)
```
## Download blast output from gannet
```{r}
blast_data<-read.table(file="https://gannet.fish.washington.edu/gigas/Panopea-generosa-uniprot_blastx.tab")
names(blast_data)[1]<-"target_id" #renamed to match countMATRIX data
names(blast_data)[2]<-"identifiers" #renamed to search in swiss prot 
```
## clean data before searching for go terms
```{r}
library(dplyr)
library(tidyr)
#merging target_ids to count Matrix to get identifies for swissprot
generosa_counts<-full_join(blast_data, countMatrix, by = "target_id")
generosa_counts<-generosa_counts[-c(3:12)] # not every target ID has a protein identifier...could be an issue later on....
generosa_counts[complete.cases(generosa_counts),] 
#blast_data<-read.csv(file="/Users/oliviacattau/Documents/analysis/code/generosa_counts.csv")#lost count data due to excel stupidity
generosa_counts$identifiers<-sub("\\.\\d+$", "", generosa_counts$identifiers) #removed decial place
cols_to_check = 2
print (generosa_counts[cols_to_check])
identifiers_only<-as.data.frame(generosa_counts[2])
write.csv(identifiers_only, file="/Users/oliviacattau/Documents/analysis/code/pgenerosa/Pgenerosa/identifiers_for_uniprot_go_terms.csv")
```
## Go to Uniprot website and grab all go terms
```{r}
#download data from UNIPROT website
[link to Uniprot website](https://www.uniprot.org/uniprot/?query=*&fil=reviewed%3Ayes) 
#loaded into gannet and pulled down
uniprot_all_reviewed<-read.csv(file="https://gannet.fish.washington.edu/gigas/uniprot-reviewed_yes.tab", sep='\t', header=TRUE)
```

## How to join tables by identifiers 
```{r}
names(uniprot_all_reviewed)[1]<-"identifiers" #renamed
pgenerosa_proteins<-full_join(generosa_counts, uniprot_all_reviewed, by ="identifiers")
pgenerosa_cleaned<-pgenerosa_proteins[-c(3:12)] #removed unlabeled columns 
#sort by est_counts, remove na's
pgenerosa_sorted<-pgenerosa_cleaned[order(pgenerosa_cleaned$est_counts, na.last=TRUE, decreasing=TRUE),]
is.na(pgenerosa_sorted)
pgenerosa_na_removed<-pgenerosa_sorted[complete.cases(pgenerosa_sorted), ]
#make file smaller before exporting later 
```
## clean up data by removing counts < 10
```{r}
pgenerosa_scrubbed<-subset(pgenerosa_na_removed, est_counts >=10)
write.table(pgenerosa_scrubbed, file="/Users/oliviacattau/Documents/GitHub/code/pgenerosa_larvae_cleaned.tab")
```
## push to Gannet
```{r}
rsync -avP /Users/oliviacattau/Documents/GitHub/code/pgenerosa_larvae_cleaned.tab ocattau@gannet.fish.washington.edu:/volume2/web/gigas/data
```
