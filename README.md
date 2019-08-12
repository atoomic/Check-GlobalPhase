# NAME

Check::GlobalPhase - Check::GlobalPhase fast XS checker for Perl GlobalPhase

# VERSION

version 0.001

# SYNOPSIS

```perl
#!perl

use strict;
use warnings;

use Test::More;    # just used for illustration purpose

use Check::GlobalPhase;

INIT {

    # instead of using a string comparison
    ok ${^GLOBAL_PHASE} eq 'INIT';

    # you can use the boolean helpers
    #   to check if you are in one of the current Perl Phase
    ok Check::GlobalPhase::in_global_phase_init();

    # other helpers
    ok !Check::GlobalPhase::in_global_phase_construct();
    ok !Check::GlobalPhase::in_global_phase_start();
    ok !Check::GlobalPhase::in_global_phase_check();
    ok !Check::GlobalPhase::in_global_phase_run();
    ok !Check::GlobalPhase::in_global_phase_end();
    ok !Check::GlobalPhase::in_global_phase_destruct();
}

# if you need to check more than one phase at the same time
#   you can use bitmask like this
ok Check::GlobalPhase::current_phase()
    & ( Check::GlobalPhase::PERL_PHASE_INIT | Check::GlobalPhase::PERL_PHASE_RUN );

# using one ore more of the available constants
Check::GlobalPhase::PERL_PHASE_CONSTRUCT;
Check::GlobalPhase::PERL_PHASE_START;
Check::GlobalPhase::PERL_PHASE_CHECK;
Check::GlobalPhase::PERL_PHASE_INIT;
Check::GlobalPhase::PERL_PHASE_RUN;
Check::GlobalPhase::PERL_PHASE_END;
Check::GlobalPhase::PERL_PHASE_DESTRUCT;

done_testing;
```

# DESCRIPTION

Check::GlobalPhase provides some fast helpers to check the current Perl Phase.
This is avoiding the creation of useless `SvPV` to perform a string comparison
using `${^GLOBAL_PHASE}`

View `${^GLOBAL_PHASE}` from [perlvar](https://metacpan.org/pod/perlvar) for more details.

# FUNCTIONS

## in\_global\_phase\_construct()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'CONSTRUCT'

## in\_global\_phase\_start()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'START'

## in\_global\_phase\_check()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'CHECK'

## in\_global\_phase\_init()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'INIT'

## in\_global\_phase\_run()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'RUN'

## in\_global\_phase\_end()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'END'

## in\_global\_phase\_destruct()

Return a boolean value. True if ${^GLOBAL\_PHASE} eq 'DESTRUCT'

# CONSTANTS

You can use this constant to perform some bitmask check with the current Perl\_Phase
returned from [current\_phase](https://metacpan.org/pod/current_phase). (view synopsis)

## PERL\_PHASE\_CONSTRUCT

## PERL\_PHASE\_START

## PERL\_PHASE\_CHECK

## PERL\_PHASE\_INIT

## PERL\_PHASE\_RUN

## PERL\_PHASE\_END

## PERL\_PHASE\_DESTRUCT

# AUTHOR

Nicolas R. <atoomic@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by cPanel L.L.C.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
