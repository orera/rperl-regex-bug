#!/usr/bin/env perl

# Program Name
# Program Description

# [[[ PREPROCESSOR ]]]
# ...

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitCStyleForLoops)

# [[[ INCLUDES ]]]
# ...

# [[[ CONSTANTS ]]]
# ...

# [[[ SUBROUTINES ]]]
# ...

# [[[ OPERATIONS ]]]
my string_arrayref $expressions = [ '^a',  '^c',  '[ae]' ];
my string_arrayref $strings     = [ 'abc', 'def', 'xxx', '$expression' ];
my string_arrayref_arrayref $results = [];
my integer $num_of_matches           = 0;

my integer $max_expression_index = scalar @{$expressions};
for ( my integer $i = 0 ; $i <= $max_expression_index - 1 ; $i++ ) {
    my string $expression      = $expressions->[$i];
    my string_arrayref $result = [$expression];

    my integer $max_strings_index = scalar @{$strings};
    for ( my integer $j = 0 ; $j <= $max_strings_index - 1 ; $j++ ) {
        my string $string = $strings->[$j];
        if ( $string =~ m/$expression/xmsi ) {
            $num_of_matches++;
            push @{$result}, $string;
        }
    }
    push @{$results}, $result;
}

my integer $num_of_result = scalar @{$results};
print 'num of results: ', $num_of_result, ', num of matches total:',
  $num_of_matches, "\n";

foreach my string_arrayref $result_final ( @{$results} ) {
    print string_arrayref_to_string($result_final), "\n";
}

#rm -rf _Inline/ && perl bin/rperl-re-list-matcher.pl

#Expected output:
#num_of_results: 3, num of matches total:4
#[ '^a', 'abc' ]
#[ '^c' ]
#[ '[ae]', 'abc', 'def', '$expression' ]

# rperl output:
# num of results: 0, num of matches total:0
