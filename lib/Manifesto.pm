use v6;

class Manifesto {
    has Supplier $!supplier;
    has Promise  %!promises;

    has Supplier $!empty;

    
    
    submethod BUILD() {
        $!supplier = Supplier.new;
        $!empty = Supplier.new;
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
                if %!promises.values.elems == 0 {
                    $!empty.emit: True;
                }
            });
            %!promises{$which} = $promise;
            $rc = True;
        }
        $rc;
    }

    method empty() {
        $!empty.Supply;
    }

    method promises() {
        %!promises.values;
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
