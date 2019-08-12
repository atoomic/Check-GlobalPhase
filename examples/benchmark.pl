#!perl

use Dumbbench;
use Check::GlobalPhase ();

my $bench = Dumbbench->new(
    target_rel_precision => 0.005,    # seek ~0.5%
    initial_runs         => 20,       # the higher the more reliable
);

use constant LOOP => 100_000;

$bench->add_instances(
    Dumbbench::Instance::PerlSub->new(
        name => 'str check',
        code => sub {
            ${^GLOBAL_PHASE} eq 'RUN' for 1 .. LOOP;
            return;
        }
    ),
    Dumbbench::Instance::PerlSub->new(
        name => 'Check::GlobalPhase',
        code => sub {
            Check::GlobalPhase::in_global_phase_run() for 1 .. LOOP;
            return;
        }
    ),
);

$bench->run;
$bench->report;

__END__
str check: Ran 75 iterations (9 outliers).
str check: Rounded run time per iteration: 7.096e-03 +/- 3.3e-05 (0.5%)
Check::GlobalPhase: Ran 27 iterations (5 outliers).
Check::GlobalPhase: Rounded run time per iteration: 3.318e-03 +/- 1.6e-05 (0.5%)
