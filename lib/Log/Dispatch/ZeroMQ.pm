package Log::Dispatch::ZeroMQ;

use strict;
use warnings;

use parent 'Log::Dispatch::Output';
use ZeroMQ qw(:all);
use Carp qw(croak);

sub new {
    my ( $class, %params ) = @_;

    bless {
       _zmq_sock_type => $params{zmq_sock_type},
       _zmq_bind      => $params{zmq_bind},
    } => $class;
}

my ($_zmq_sock,$_zmq_ctx);
sub _zmq {
    my $self = shift;

    return $_zmq_sock if defined $_zmq_sock;

    $_zmq_ctx     = ZeroMQ::Context->new();
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


1;
