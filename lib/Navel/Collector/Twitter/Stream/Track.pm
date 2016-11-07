# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-collector-twitter-stream-track is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Collector::Twitter::Stream::Track 0.1;

use Navel::Base;

use constant EVENT_CLASS => 'tweet';

use AnyEvent::Twitter::Stream;

use Navel::Logger::Message;

#-> class variables

my $watcher;

#-> functions

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

            new_watcher();
        },
        on_tweet => sub {
            my $tweet = shift;

            W::queue()->enqueue(
                W::event(
                    {
                        message => $tweet->{full_text},
                        user => $tweet->{user}->{screen_name},
                        client => $tweet->{source},
                        retweeted => $tweet->{retweeted},
                        source => 'http://twitter.com/#' . $tweet->{user}->{screen_name} . '/status/' . $tweet->{id}
                    }
                )
            );
        }
    );
}

sub init {
    new_watcher;
}

sub enable {
    new_watcher unless defined $watcher;

    shift->(1);
}

sub disable {
    undef $watcher;

    shift->(1);
}

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
