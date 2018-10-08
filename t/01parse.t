#!/usr/bin/perl -w
use Test::More tests => 35;
use strict;
use vars qw( $class );

BEGIN {
    $class = 'DateTime::Format::W3CDTF';
    use_ok $class;
}

my $strict = $class->new(strict => 1);

my @strict_tests = (
    '2002-05-12'                   => '2002-05-12T00:00:00',
    '1985-06'                      => '1985-06-01T00:00:00',
    '1988'                         => '1988-01-01T00:00:00',
    '2005-03-10T20:14:34+09:30'    => '2005-03-10T10:44:34',
    '2000-06-12T14:12:33Z'         => '2000-06-12T14:12:33',
    '1994-11-05T08:15:30-05:00'    => '1994-11-05T13:15:30',
    '2004-07-01T15:00:13.17-05:00' => '2004-07-01T20:00:13',
);

my @loose_tests = (
    '2003-02-10T15:23:45' => '2003-02-10T15:23:45',
    '1997-04-11T09:34'    => '1997-04-11T09:34:00',
);

my @tests = (@loose_tests, @strict_tests);

while (@tests) {
    my ( $given, $expected ) = splice @tests, 0, 2;
    my $dt   = $class->parse_datetime($given)->set_time_zone('UTC');
    my $form = $dt->iso8601;
    is( $form => $expected, "Loose parsing of $given => $expected." );
}

while (@strict_tests) {
    my ( $given, $expected ) = splice @strict_tests, 0, 2;
    my $dt   = $strict->parse_datetime($given)->set_time_zone('UTC');
    my $form = $dt->iso8601;
    is( $form => $expected, "Strict parsing of $given => $expected." );
}

my @noparse = (
    'fnord',
    '2003.03.10',
    '2003-02-10X15:45:56',
    '2005-03-10T20:14:34+09',
    '2003-04-15T14',
    '2000-06-12T4:12:33Z',
    '15:45',
    '06:34:18',
);

for (@noparse) {
    my $dt = eval { $class->parse_datetime($_) };
    ok( $@ && !( defined $dt && $dt->isa('DateTime') ),
        "Loose parsing failed: $_" );
}

push @noparse, @loose_tests[grep $_ % 2 == 0, 0..$#loose_tests];

for (@noparse) {
    my $dt = eval { $strict->parse_datetime($_) };
    ok( $@ && !( defined $dt && $dt->isa('DateTime') ),
        "Strict parsing failed: $_" );
}

