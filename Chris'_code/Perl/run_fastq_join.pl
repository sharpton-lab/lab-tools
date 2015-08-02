#!/usr/bin/perl

#####################
#                   #
# run_fastq_join.pl #
#                   #
#####################

#Need to make a usage statement 
#Requires input directory (@ARGV[0])

use strict; use warnings;
 
my $fqdir   = $ARGV[0];
#my $out_dir = @ARGV[1];

opendir(DIR, $fqdir) or die $!;


my @files;
  

while ( my $file = readdir(DIR) ){
	
	if ( $file =~ m/^\./ ) {
		next; 
	}elsif ( $file !~ m/\.fastq/ ){
		next;
	}else{
		if ( $file =~ m/\_R1\_/ ) { 
			chomp $file;
			push ( @files, $file );
		}else{
			next;
		}
	}
}

#print @files;

close(DIR); 



foreach my $file (@files){
	
	chomp $file; 
	my $forward = $file;
	my @rev_arr = split("\_R1\_", $file    );
	my $reverse = join ("\_R2\_", @rev_arr ); 
	my $base = $rev_arr[0];
#	system("pandaseq -f $fqdir/$forward -r $fqdir/$reverse -T 10 -L 600 -t 0.90 > $base\_joined.fasta"); 
	system("fastq-join $fqdir/$forward $fqdir/$reverse -o fastq_joined/$base.%.fastq");
}
	
	
__END__
	