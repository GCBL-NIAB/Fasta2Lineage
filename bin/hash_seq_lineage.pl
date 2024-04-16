#!/usr/bin/perl

my %hash_contig=();
my @contig_name=();
my %hash_access=();
my %hash_taxa=();
open(FILE, $ARGV[0]);				# $ARGV[0]= sequence file

#perl hash_seq_lineage.pl contigs.fa contig_blast_result.txt nucl_gb.accession2taxid ncbi_lineages_2021-04-18.csv >result.txt

$seq="0"; $name="";
while ($line=<FILE>){


chomp $line;

if ($line=~/^>/) { 	
			$seqlength= length($seq);  if ($seqlength >1){$hash_contig{$name}[0]=$seqlength; push @contig_name,$name; }
			@seqname=split(/\s+/, $'); $seq=""; $name=$seqname[0]; 
			next;	
		}
			

$seq=$seq.$line;


}

push @contig_name,$name;
if ($seqlength >1){$hash_contig{$name}[0]=$seqlength;}
#$seqlength= length($seq); 	&PARSER ($seqlength, $name);

close (FILE);
#print "all sequence length calculated\n";




open(FILE1, $ARGV[1]);	# $ARGV[1]= blastoutput in outfmt 7
my $check=0;
while (my $line1=<FILE1>){


if($line1=~/^#/){ next;}
my @accession1 =split(/\s+/,$line1);

if (exists $hash_access{$accession1[1]}){ next;}
else{	$hash_access{$accession1[1]}=""; }


}

close (FILE1);
#print "all acession name extracted\n";





open(ID, $ARGV[2]);           # $ARGV[2]= accession2taxaid

while (my $row=<ID>){

chomp $row;

@accession=split(/\s+/,$row);


if (exists $hash_access{$accession[1]}) { $hash_access{$accession[1]}=  $accession[2]  ; $hash_taxa {$accession[2]}="";    next;}




}

close (ID);
#print "all taxaID extracted\n";




open(LIN, $ARGV[3]);             # $ARGV[3]= Taxonomy file ncbilineage


while (my $lineage=<LIN>){

chomp $lineage;
@taxo=split(/,/,$lineage);

if (exists $hash_taxa {$taxo[0]}) {  		$hash_taxa{$taxo[0]}=$lineage;

						

						    }


}
close(LIN);
#print "all lineage extracted\n";




foreach $morsel(keys %hash_access){
		#$a=$hash_access{$morsel};

  $hash_access{$morsel}=$hash_taxa {$hash_access{$morsel}};



}

close (ID);
#print "all accession to lineage extracted\n";















open(FILE1, $ARGV[1]);	# $ARGV[1]= blastoutput in outfmt 7
my $check=0;
while (my $line1=<FILE1>){
#print "pandey\n";
chomp $line1;
if ($line1=~/^# Query:/){	@query=split(/\s+/,$line1); 	print "#$query[2]\t$hash_contig{$query[2]}[0]\n";
				if (exists $hash_contig{$query[2]}){
							 $line1=<FILE1>;  $line1=<FILE1> ;
							 chomp$line1;																		
	                       			 if ($line1=~/hits/) {print"#0\t$line1\t$hash_contig{$query[2]}[0]\n"; $check=0; next;}
	                       			 
	                       			 else{$line1=<FILE1>; print"$line1";$check=2;next; } 
	                      				 
	                       			
	                       			
	                       			}
	                       
	                 } 	
	
	

	
																				    
if ($check==2){ my @subject =split(/\s+/,$line1);
                if (exists $hash_contig{$subject[0]}) { 
                				 
                				my $ratio= $subject[3]/$hash_contig{$subject[0]}[0]; # alignment length/total length
        	        			if ($ratio  >0.0) { print"#*@subject\n"; $check=0;  # 0.0 can be 0.5 for minimum 50% query coverage
        	        					if (exists $hash_access{$subject[1]}){  print "$subject[0],$hash_access{$subject[1]}\n"; }
        	        			}
        	        		else {$check=0;print "###@subject\n"; next;}
                																																																																																																																																																																																																																													
                			}   
                			else{$check=0;}		
                			
         	 }



}


close (FILE1);







