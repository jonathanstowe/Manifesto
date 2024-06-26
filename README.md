# Manifesto

Make a supply of the results of Promises 

[![CI](https://github.com/jonathanstowe/Manifesto/actions/workflows/main.yml/badge.svg)](https://github.com/jonathanstowe/Manifesto/actions/workflows/main.yml)

## Synopsis

A different version of the old 'sleep sort'

```raku
use Manifesto;

my $manifesto = Manifesto.new;

for (^10).pick(*).map( -> $i { Promise.in($i + 0.5).then({ $i })}) -> $p {
    $manifesto.add-promise($p);
}

my $channel = Channel.new;

react {
    whenever $manifesto -> $v {
        $channel.send: $v;
    }
    whenever $manifesto.empty {
        $channel.close;
        done;
    }
}

say $channel.list;

```

## Description

This manages a collection of Promise objects and provides a Supply
of the result of the kept Promises.

This is useful to aggregate a number of Promises to a single stream
of results, which may then be used in, a _react_ or _supply_ block
or otherwise tapped.

## Installation

Assuming you have a working installation of Rakudo installed with *zef* you should be able to do either:

    zef install Manifesto

	# or from a local checkout

    zef install .

Other equally capable installers may become available in the future.

## Support

This is so simple I'm not sure there is much scope for many bugs, but
if you have any questions, suggestions, patches or whatever please send
them via [GitHub](https://github.com/jonathanstowe/Manifesto/issues)

## Copyright and Licence

© Jonathan Stowe 2016 - 2021

This is free software, the terms are described in the [LICENCE](LICENCE) file in this repository.
