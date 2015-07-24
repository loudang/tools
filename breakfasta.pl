#! usr/bin/perl

use strict;
use warnings;
use Getopt::Long;

my $help;
my $filename;
my $output;

GetOptions(
    'help'          => \$help,
    'filename:s'    => \$filename,
);

if ($help) { _usage(); }

my $input = $ARGV[0] or die "requires input file. type '-help' for usage.\n";###fasta file to break
my $dir = $ARGV[1] or die "requires output directory. type '-help' for usage.\n";###output directory

open(my $fh, $input) or die "Cannot open file $input\n";

while (my $line = <$fh>){
    chomp $line;
    if ($line =~ /^>/){
        my @name = split(/[>\s]/, $line);
        if ($filename){
            $output = $ARGV[1].$filename.$name[1].".fa";
        } else {
            $output = $ARGV[1].$name[1].".fa";
        }
        print "creating: ".$output."\n";
        open(CHR, '>', $output) or die;
    }
    print CHR $line."\n";
}

sub _usage{
    
print <<"USAGE";
    
    This script is used to separate each sequence in a FASTA file into separate files.
    
    to use:
    
        "perl /path/to/breakfasta.pl [FASTA file] [OUTPUT DIRECTORY]"
    
    to generate files starting with the same name:
    
        "perl /path/to/breakfasta.pl [FASTA file] [OUTPUT DIRECTORY] -filename [filename]"

USAGE
    
exit;
}