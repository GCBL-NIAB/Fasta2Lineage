# Prerequisite 
<br/>

#### 1. ncbitax2lin
> install using **pip3 install -U ncbitax2lin** (>python3.7 required)
#### 2. NCBI-BLAST

# Installation
<br/>

* Download the package & extract using 

> tar -xzvf Fasta2Lineage.tar.gz

**or**

* Download using git clone

> git clone --recursive https://github.com/GCBL-NIAB/Fasta2Lineage.git
<br/>
<br/>
<br/>

> cd Fasta2Lineage

* Download  taxonomy files from NCBI and put them in the lib folder
> wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

> mkdir -p lib && tar zxf taxdump.tar.gz -C ./lib

> ncbitax2lin --nodes-file lib/nodes.dmp --names-file lib/names.dmp

> gunzip ncbi_lineages_\*.csv.gz && mv ncbi_lineages_\*.csv ./lib/ncbi_lineages.csv                   

> wget  https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/nucl_gb.accession2taxid.gz

> gunzip nucl_gb.accession2taxid.gz && mv nucl_gb.accession2taxid ./lib/


### If the NT database is downloaded in the system, go to the configuration section and provide a path in **configuration file**.

#### Otherwise create NT BLAST database 
> mkdir database && cd database

> wget https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz

> gunzip nt.gz

> makeblastdb -in nt -input_type fasta -dbtype nucl -max_file_sz 4000000000 -out ./database/nt

> rm nt

# Configuration
<br/>

* Open the configuration file and make changes in the "parameter section". Provide path of NT database if database are already available and other parameters as per available computational resources.


> perl configuration.pl


# Run

> fasta2lineage input.fasta > output.fasta



