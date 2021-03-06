#!/usr/bin/env perl

use strict;
use warnings;


my $ALLOWED_DELTA_PCT = 5;

main: {
    &verify("DESeq2_outdir/diffExpr.P0.001_C2.matrix", 1784);
    &verify("edgeR_outdir/diffExpr.P0.001_C2.matrix", 2063);
    &verify("voom_outdir/diffExpr.P0.001_C2.matrix", 1818);

    exit(0);
}

####
sub verify {
    my ($filename, $target_count, $optional_upper_bound) = @_;
    my $count = `cat $filename | wc -l`;
    $count =~ s/\s+//g;

    my $delta = abs($count - $target_count);
    my $pct_delta = $delta / $target_count * 100;
    
    if (defined($optional_upper_bound)) {
        if ($count < $target_count || $count > $optional_upper_bound) {
            die "Error, count $count of features is out of bounds ($target_count, $optional_upper_bound) ";
        }
    }
    else {
        if ($pct_delta <= $ALLOWED_DELTA_PCT) {
            print STDERR "$filename, count: $count DE features OK.\n";
        }
        else {
            die "Error, $filename has count: $count, $pct_delta % different from expected: $target_count";
        }
    }
    
    return;
}
