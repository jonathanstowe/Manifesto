use v6;

class Manifesto {
    has Supplier $!supplier;
    has Promise  %!promises;

    
    submethod BUILD() {
        $!supplier = Supplier.new;
    }

    method Supply() returns Supply {
        $!supplier.Supply;
    }

    method add-promise(Promise $promise) returns Bool {
        my Bool $rc;
        my $which = $promise.WHICH;
        if  $promise.status ~~ Planned {
            $promise.then(sub ($p ) {
                $!supplier.emit: $p.result;
                $p;
            }).then( {
                %!promises{$which}:delete;
            });
            %!promises{$which} = $promise;
            $rc = True;
        }
        $rc;
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
