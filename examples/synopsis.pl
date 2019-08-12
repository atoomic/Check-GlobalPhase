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
