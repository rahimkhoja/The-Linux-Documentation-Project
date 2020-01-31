#!/usr/bin/perl -w
# vim: set sw=4 ts=4 si et:
# Copyright: GPL, Written by: Guido Socher <guido.socher at linuxfocus.org>
my $ver="1.5";
#
# This program is executed from a serverside include to insert automatically
# links to the different languages an articel is availabe in.
# The link is inserted if the file exists in that language and the
# size is bigger than 2Kb.
#
my @languages=('English','Castellano','ChineseGB','Deutsch',
               'Francais','Italiano','Nederlands','Portugues','Indonesian',
               'Russian','Turkce','Korean','Arabic','Polish','Serbian');
#
my %text=('Deutsch'=>'Dieses Dokument ist verf&uuml;bar auf:',
'Nederlands'=>'Dit document is beschikbaar in:',
'English'=>'This document is available in:',
'Francais'=>'Ce document est disponible en:',
'Italiano'=>'Questo documento &egrave; disponibile in:',
'Turkce'=>'Bu makalenin farklý dillerde bulunduðu adresler:',
'Russian'=>'ÜÔÁ ÓÔÒÁÎÉÃÁ ÄÏÓÔÕÐÎÁ ÎÁ ÓÌÅÄÕÀÝÉÈ ÑÚÙËÁÈ:',
'Portugues'=>'Este artigo est&aacute; dispon&iacute;vel em:',
'Castellano'=>'Este documento est&aacute; disponible en los siguientes idiomas:',
'Polish'=>'Ten dokument jest dostêpny w nastêpuj±cych jêzykach:'
);
my ($k,$s,$availtxt,$file,$origlang);
#
if ($ENV{'DOCUMENT_URI'}){
    print "<!-- addedByLfdynahead ver $ver -->";
    # DOCUMENT_URI is somthing like: /English/July2001/article207.shtml
    my @pcomp=split(/\//,$ENV{'DOCUMENT_URI'});
    exit 0 if ($#pcomp < 2);
    print "<TABLE ALIGN=\"right\" border=0><TR><TD ALIGN=\"right\"><FONT SIZE=\"-1\" FACE=\"Arial,Helvetica\">";
    my $month_and_sfile=$pcomp[$#pcomp-1] . "/" . $pcomp[$#pcomp];
    $origlang=$pcomp[$#pcomp-2];
    if ($text{$origlang}){
        $availtxt=$text{$origlang};
    }else{
        $availtxt=$text{'English'};
    }
    my $month_and_file=$month_and_sfile;
    $month_and_file=~s/\.shtml$/.html/;
    #
    $file="$origlang/$month_and_sfile";
    foreach $k (@languages){
        # test if the file exists and if it is larger than 2K
        foreach $file ("$k/$month_and_sfile", "$k/$month_and_file"){
            if ( -f "$file"){
                $s=(stat("$file"))[7];
                if ($s > 2100){
                    if ($availtxt){
                        print "$availtxt ";
                        $availtxt=0;
                    }
                    print "<A href=\"../../$file\">".$k."</a> &nbsp;";
                    # take either shtml or html but not both:
                    last; 
                }
            }
        }
    }
    print "</FONT></TD></TR></TABLE><br>\n";
}else{
    print "<!-- Lfdynahead error: DOCUMENT_URI not defined -->\n";
}
__END__ 

