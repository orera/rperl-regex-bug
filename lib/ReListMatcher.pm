package ReListMatcher;

use strict;
use warnings;

our $VERSION = 0.001_000;

sub match {
    my ( $self, $expressions, $strings ) = @_;

    my $result               = [];
    my $max_expression_index = scalar( @{$expressions} ) - 1;
    for ( my $i = 0 ; $i <= $max_expression_index ; $i++ ) {
        my $expression  = $expressions->[$i];
        my $compiled_re = qr/$expression/xmsi;

        my $matches           = [$expression];
        my $max_strings_index = scalar( @{$strings} ) - 1;
        for ( my $j = 0 ; $j <= $max_strings_index ; $j++ ) {
            my $string = $strings->[$j];
            if ( $string =~ $compiled_re ) {
                push @{$matches}, $string;
            }
        }

        push @{$result}, $matches;
    }

    return $result;
}

1;
