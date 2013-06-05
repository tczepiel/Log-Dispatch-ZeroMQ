use strict;
use warnings;

use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Log::Dispatch::ZeroMQ',
    VERSION_FROM      => 'lib/Log/Dispatch/ZeroMQ.pm',
    PREREQ_PM         => {
        parent             => 0,
        ZMQ                => 0,
        'Log::Dispatch'    => 0,
        Carp               => 0,
    },
    TEST_REQUIRES => {
        'Test::SharedFork' => 0,
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Log/Dispatch/ZeroMQ.pm',
       AUTHOR         => 'Tomasz Czepiel <tjmc@cpan.org>') : ()),
    LICENSE           => 'perl',
    META_MERGE => {
        resources => {
            repository => 'git://github.com/tczepiel/Log-Dispatch-ZeroMQ.git',
        },
    },
);
