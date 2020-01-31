#!/usr/bin/perl -w
# vim: set sw=4 ts=4 si et:
# Copyright: GPL, Written by: Guido Socher 
my $ver="0.1";
my %mon2digit=('January'=>1,'February'=>2,'March'=>3,'April'=>4,
    'May'=>5,'June'=>6,'July'=>7,'August'=>8,'September'=>9,
    'October'=>10,'November'=>11,'December'=>12);
#
# This program is executed from a serverside include to insert automatically
# links to a pdf version of the article
#
my ($anum,$yn,$mn,$month,$file,$ldir);
#
if ($ENV{'DOCUMENT_URI'}){
    print "<!-- addedByLfPdf ver $ver -->\n";
    # DOCUMENT_URI is somthing like: /English/July2001/article207.shtml
    my @pcomp=split(/\//,$ENV{'DOCUMENT_URI'});
    exit 0 if ($#pcomp < 2);
    $file= $pcomp[$#pcomp];
    $month=$pcomp[$#pcomp-1];
    if ($month=~/^([A-Z][a-z]+)(\d\d\d\d)/){
        $mn=$1;
        $yn=$2;
        if ($mon2digit{$mn}){
            $mn=$mon2digit{$mn};
        }else{
            exit(0);
        }
    }else{
        exit(0);
    }
    $ldir=$pcomp[$#pcomp-2];
    if ($file=~/^article(\d+)/){
        $anum=$1;
    }else{
        exit(0);
    }
    my $pdffile=sprintf("lf-%04d_%02d-%04d.pdf",$yn,$mn,$anum);
    if (-r "$ldir/Archives/$pdffile"){
        print qq|<TABLE style="border-style:outset; border-width:1px" align="right" bgcolor="#ff9616" cellspacing="1"><TR><TD bgcolor="#ff9616">
        <a href="../Archives/$pdffile"><small>PDF</small></a>
        </TD></TR></TABLE>
        |;
    }
}else{
    print "<!-- LfPdf error: DOCUMENT_URI not defined -->\n";
}
__END__ 

