# NAME

Check::GlobalPhase - Check::GlobalPhase fast XS checker for GlobalPhase

# VERSION

version 0.001

# SYNOPSIS

```perl
#!perl

use strict;
use warnings;

use Test::More;    # just used for illustration purpose

use Check::GlobalPhase;

# instead of doing a string comparison
${^GLOBAL_PHASE} eq 'START';

# you can use the boolean helpers 
#   to check if you are in one of the current Perl Phase
INIT {
    ok Check::GlobalPhase::in_global_phase_init();

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

# using one ore more of the constant available
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

Check::GlobalPhase provides some naive additional B helpers to check the COW status of one SvPV.

## COW or Copy On Write introduction

A COWed SvPV is sharing its string (the PV) with other SvPVs.
It's a (kind of) Read Only C string, that would be Copied On Write (COW).

More than one SV can share the same PV, but when one PV need to alter it,
it would perform a copy of it, decrease the COWREFCNT counter.

One SV can then drop the COW flag when it's the only one holding a pointer
to the PV.

The COWREFCNT is stored at the end of the PV, after the the "\\0".

That value is limited to 255, when we reach 255, a new PV would be created,

4983:    PERL\_PHASE\_CONSTRUCT      = 0,
4984:    PERL\_PHASE\_START          = 1,
4985:    PERL\_PHASE\_CHECK          = 2,
4986:    PERL\_PHASE\_INIT           = 3,
4987:    PERL\_PHASE\_RUN            = 4,
4988:    PERL\_PHASE\_END            = 5,
4989:    PERL\_PHASE\_DESTRUCT               = 6

# FUNCTIONS

## can\_cow()

Return a boolean value. True if your Perl version support Copy On Write for SvPVs

## is\_cow( PV )

Return a boolean value. True if the SV is cowed SvPV. (check the SV FLAGS)

## cowrefcnt( PV )

Return one integer representing the COW RefCount value.
If the string is not COW, then it will return undef.

## cowrefcnt\_max()

Will return the SV\_COW\_REFCNT\_MAX of your Perl. (if COW is supported, this should
be 255 unless customized).

# AUTHOR

Nicolas R. <atoomic@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by cPanel L.L.C.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
