# Manifesto

Make a supply of the results of Promises 

## Synopsis

A different version of the old 'sleep sort'

```perl6

use Manifesto;

my $manifesto = Manifesto.new;

for (^10).pick(*).map({ start { sleep $_; $_ } }) -> $p {
    $manifesto.add-promise($p);
}

react {
    whenever $manifesto -> $v {
        say $v;
    }
    whenever $manifesto.empty {
        done;
    }
}

```

## Description

This manages a collection of Promise objects and a Supply which emits
the result of any when they are kept.


## Copyright and Licence

© Jonathan Stowe 2016

This is free software, the terms are described in the [LICENCE](LICENCE) file
in this repository.
