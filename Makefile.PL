use strict;
use warnings;

use ExtUtils::MakeMaker;

my %required_for_test = (
    'Test::SharedFork' => 0,
);

WriteMakefile(
    NAME              => 'Log::Dispatch::ZeroMQ',
    VERSION_FROM      => 'lib/Log/Dispatch/ZeroMQ.pm',
    ABSTRACT          => 'ZMQ backend for Log::Dispatch',
    PREREQ_PM         => {
        parent             => 0,
        ZMQ                => 0,
        'Log::Dispatch'    => 0,
        Carp               => 0,
        ($] < 5.005 ? (%required_for_test) : ()),
    },
    ($] >= 5.005 ?
      (
      TEST_REQUIRES => \%required_for_test,
      AUTHOR         => 'Tomasz Czepiel <tjmc@cpan.org>') : ()),
    LICENSE           => 'perl',
    META_MERGE => {
        resources => {
            repository => 'git://github.com/tczepiel/Log-Dispatch-ZeroMQ.git',
        },
    },
);
