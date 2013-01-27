use 5.012004;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Log::Dispatch::ZeroMQ',
    VERSION_FROM      => 'lib/Log/Dispatch/ZeroMQ.pm',
    PREREQ_PM         => {
        parent  => 0,
        ZeroMQ  => 0,
        'Log::Dispatch' => 0,
        Carp => 0,
        'Test::SharedFork' => 0,
        'Package::Stash' => 0,
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Log/Dispatch/ZeroMQ.pm',
       AUTHOR         => 'Tomasz Czepiel <tjmc@cpan.org>') : ()),
);
