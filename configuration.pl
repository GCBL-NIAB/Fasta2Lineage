#!/usr/bin/perl

use Cwd;

$fasta2lineage=cwd;

####################### Parameter section ########################
$nt_database= "$fasta2lineage/database/nt";   #change to actual blast formatted NT database path.
$e_value= "1e-20";     # user may change e_value
$max_target_seqs=1;  # user may increase the value
$thread=60;          # user may increase the value for quick result


#######################################################################################################################

open (FILE, ">fasta2lineage");

print FILE "#!/bin/bash\n\n\n";
print FILE "if [ -z \"\$1\" ]\n ";

print FILE "then\necho ERROR:No input File supplied\n    exit \nfi\n";

print FILE "rm -r $fasta2lineage/tmp 2>/dev/null\n";
print FILE "mkdir $fasta2lineage/tmp\n";
print FILE "blastn -db $nt_database -query \$1 -out $fasta2lineage/tmp/\$1_output -outfmt 7 -evalue $e_value -max_target_seqs $max_target_seqs -num_threads $thread\n";
print FILE "$fasta2lineage/bin/hash_seq_lineage.pl \$1 $fasta2lineage/tmp/\$1_output $fasta2lineage/lib/nucl_gb.accession2taxid $fasta2lineage/lib/ncbi_lineages_2021-04-18.csv\n";                  


 print FILE "rm -r $fasta2lineage/tmp 2>/dev/null\n";
close (FILE);  

`chmod 755 fasta2lineage` ;     
