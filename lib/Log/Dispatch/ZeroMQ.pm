package Log::Dispatch::ZeroMQ;

use strict;
use warnings;

our $VERSION = '0.01';

# ABSTRACT: ZMQ backend for Log::Dispatch

use parent 'Log::Dispatch::Output';
use ZMQ ();
use ZMQ::Constants ":all";
use Carp qw(croak);

sub new {
    my ( $class, %params ) = @_;

    my $sock_type = do {
        no strict 'refs';
        &{ "ZMQ::Constants::$params{zmq_sock_type}" };
    };
    
    unless ( defined $sock_type ) {
        croak "ZMQ::Constants doesn't export '$params{zmq_sock_type}'";
    }

    bless {
       _zmq_sock_type => $sock_type,
       _zmq_bind      => $params{zmq_bind},
    } => $class;
}

my ($_zmq_sock,$_zmq_ctx);
sub _zmq {
    my $self = shift;

    return $_zmq_sock if defined $_zmq_sock;

    $_zmq_ctx     = ZMQ::Context->new();
    my $_zmq_sock = $_zmq_ctx->socket($self->{_zmq_sock_type});
    $_zmq_sock->connect($self->{_zmq_bind});
    return $_zmq_sock;

}

sub log_message {
    my $self   = shift;
    my %params = @_;

    $self->_zmq->send($params{message});
    return;
}

=cut

=head1 NAME

Log::Dispatch::ZeroMQ

=head1 SYNOPSIS

    use Log::Dispatch;

    my $log = Log::Dispatch->new(
        outputs => [[
           'ZeroMQ',
            zmq_sock_type => 'ZMQ_REQ',
            zmq_bind      => "tcp://127.0.0.1:8881",
            min_level     => 'info',
        ]],
    );

=head1 DESCRIPTION

Log::Dispatch plugin for ZeroMQ

=head1 EXPORT

Nothing.

=head1 BUGS

Please report any bugs on L<http://rt.cpan.org>

=head1 AUTHOR

Tomasz Czepiel E<lt>tjmc@cpan.org<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.4 or,
at your option, any later version of Perl 5 you may have available.

=cut


1;
