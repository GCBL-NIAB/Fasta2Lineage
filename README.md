# Prerequisite 
<br/>

#### 1. ncbitax2lin
> If not, install using **pip3 install -U ncbitax2lin** (>python3.7 required)
#### 2. NCBI-BLAST

# Installation
<br/>

* Download the package & extract using 

> tar -xzvf Fasta2Lineage.tar.gz

**or**

* Download using git clone

> git clone --recursive https://github.com/AS11-git/Genome_wide_annotation_Bos_indicus.git

<br/>
<br/>

> cd Fasta2Lineage

* Download  taxonomy files from NCBI and put in lib folder
> wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

> mkdir -p lib && tar zxf taxdump.tar.gz -C ./lib

> ncbitax2lin --nodes-file lib/nodes.dmp --names-file lib/names.dmp

> gunzip ncbi_lineages_2021-05-26.csv.gz ./lib/

> wget  https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/nucl_gb.accession2taxid.gz

> gunzip nucl_gb.accession2taxid.gz ./lib/


### If the NT database is downloaded in system, go to the configuration section and provide a path in **configuration file**.
#### Else create NT BLAST database 
> mkdir database && cd database

> wget https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz

> gunzip nt.gz

> makeblastdb -in nt -input_type fasta -dbtype nucl -max_file_sz 4000000000 -out ./database/nt

> rm nt





