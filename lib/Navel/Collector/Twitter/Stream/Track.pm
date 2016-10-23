# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-collector-twitter-stream-track is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Collector::Twitter::Stream::Track;

use Navel::Base;

use AnyEvent::Twitter::Stream;

use Navel::Logger::Message;

#-> class variables

my $watcher;

#-> methods

sub new_watcher {
    $watcher = AnyEvent::Twitter::Stream->new(
        token => W::collector()->{backend_input}->{token},
        token_secret => W::collector()->{backend_input}->{token_secret},
        consumer_key => W::collector()->{backend_input}->{consumer_key},
        consumer_secret => W::collector()->{backend_input}->{consumer_secret},
        method => 'filter',
        track => W::collector()->{backend_input}->{track},
        on_connect => sub {
            W::log(
                [
                    'notice',
                    'connected to Twitter.'
                ]
            );
        },
        on_error => sub {
            W::log(
                [
                    'err',
                    Navel::Logger::Message->stepped_message('an error occured with Twitter.',
                        [
                            shift
                        ]
                    )
                ]
            );

            undef $watcher;

            new_watcher();
        },
        on_tweet => sub {
            W::queue()->enqueue(
                W::event(shift)
            );
        }
    );
}

sub init {
    new_watcher();
}

sub enable {
    new_watcher() unless defined $watcher;

    shift->(1);
}

sub disable {
    undef $watcher;

    shift->(1);
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Collector::Twitter::Stream::Track

=head1 COPYRIGHT

Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-collector-twitter-stream-track is licensed under the Apache License, Version 2.0

=cut
