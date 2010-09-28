use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name => 'DateTime::Format::W3CDTF',
    license     => 'perl',
    requires    => {
        'DateTime' => '0',
    },
    build_requires => {
        'Test::More' => '0',
    },
    create_readme      => 1,
    sign               => 1,
    create_makefile_pl => 'traditional',
    meta_merge         => {
        resources => {
            bugtracker =>
                'http://rt.cpan.org/NoAuth/Bugs.html?Dist=DateTime-Format-W3CDTF',
            repository =>
                'http://github.com/kasei/datetime-format-w3cdtf',
        },
    },
);

$builder->create_build_script();
