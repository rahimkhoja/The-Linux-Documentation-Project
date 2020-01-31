#!/usr/bin/perl -w
# vim: set sw=4 ts=4 si et:
# Copyright: GPL, Written by: Guido Socher <guido.socher at linuxfocus.org>
sub simpleflattenpath($);
my $ver="1.0";
#
# This program is executed from a serverside include to insert automatically
# links to the different languages an articel is availabe in.
# The link is inserted if the file exists.
#
my @languages=('English','Castellano','ChineseGB','Deutsch',
               'Francais','Italiano','Nederlands','Portugues','Indonesian',
               'Russian','Turkce','Polish');
my %langspell=('Francais'=>'Fran&ccedil;ais','Turkce'=>'T&uuml;rk&ccedil;e');
#
my ($k,$file);
my $foundcnt=0;
# Thake the path to the article as QUERY_STRING (call this prog with 
# file?September2004/articleXXX.shtml)

if ($ENV{'QUERY_STRING'}){
    print "<!-- addedByLfdynidx ver $ver -->";
    my $p=$ENV{'QUERY_STRING'};
    $p=~s/^\///;
    my @pcomp=split(/\//,$p);
    exit 0 if ($#pcomp != 1);
    # pwd is always the linuxfocus.org document root directory
    # however where we are in the web is a different story
    foreach $k (@languages){
        # test if the file exists 
        $file=$k.'/'.$p;
        if ( -f "$file"){
            if ($foundcnt){
                print '&nbsp;|&nbsp;';
            }
            $foundcnt++;
            $k=$langspell{$k} if ($langspell{$k});
            print "<A href=\"$file\">".$k."</a>";
        }
    }
}
if (! $foundcnt){
    print '[ERROR Lfdynidx, file not found]';
}
print "\n";
__END__ 

