# [[[ HEADER ]]]
use RPerl;

package rperlReListMatcher;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
# RPerl base class, no inheritance; replace with parent class as needed
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ INCLUDES ]]]

# [[[ CONSTANTS ]]]

# [[[ OO PROPERTIES ]]]

# [[[ SUBROUTINES & OO METHODS ]]]

sub match {
    { my void::method $RETURN_TYPE };
    (
        my rperlReListMatcher $self,
        my string_arrayref $expressions,
        my string_arrayref $strings
    ) = @ARG;

    my string_arrayref_arrayref $result = [];
    my integer $max_expression_index    = scalar( @{$expressions} ) - 1;
  PARALLEL: for ( my integer $i = 0 ; $i <= $max_expression_index ; $i++ ) {
        my string $expression = $expressions->[$i];
        my $compiled_re = qr/$expression/xmsi;

        my string_arrayref $matches   = [$expression];
        my integer $max_strings_index = scalar( @{$strings} ) - 1;
        for ( my integer $j = 0 ; $j <= $max_strings_index ; $j++ ) {
            my string $string = $strings->[$j];
            if ( $string =~ $compiled_re ) {
                push @{$matches}, $string;
            }
        }

        push @{$result}, $matches;
    }

    return $result;
}

1;    # end of class

__END__

perltidy -b lib/rperlReListMatcher.pm && rm -rf _Inline/ && prove -I lib t/02-basic.t -v
