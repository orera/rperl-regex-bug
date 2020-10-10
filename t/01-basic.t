#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

use Const::Fast qw();
use Data::Dumper;
use Test::Most;

use_ok 'ReListMatcher';         # Regular perl implementation
use_ok 'rperlReListMatcher';    # rperl implementation

my $max_num             = 25_000;
my @big_list_of_strings = map { 'x' . $_ } 1 .. $max_num;      #  x1,   x2,   x3
my @small_list_of_re    = map { '^x' . $_ . '$' } 1 .. 1_000,
  $max_num;    # ^x1$, ^x2$, ^x3$
push @big_list_of_strings,
  map { uc $_ } @big_list_of_strings;    # x1, x2 x3, X1, X2, X3

Const::Fast::const @big_list_of_strings => @big_list_of_strings;
Const::Fast::const @small_list_of_re    => @small_list_of_re;

foreach my $class (qw(ReListMatcher rperlReListMatcher)) {
    my $list_of_regexes = [ '^a',  '^c',  '[ae]' ];
    my $list_of_strings = [ 'abc', 'def', 'xxx' ];
    is_deeply $class->match( $list_of_regexes, $list_of_strings ),
      [ [ '^a', 'abc' ], ['^c'], [ '[ae]', 'abc', 'def' ] ],
      $class . ' match() basic param';

    my $time   = time;
    my $result = $class->match( \@small_list_of_re, \@big_list_of_strings );
    diag $class . ' match time was: ' . ( time - $time );

    is_deeply [ map { $_->[0] } @{$result} ], \@small_list_of_re,
      $class . ' match() biglist';
}

done_testing;

__END__

rm -rf _Inline/ && prove -I lib/ t/01-basic.t -v

