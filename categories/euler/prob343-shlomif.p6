use v6;

=begin pod

=TITLE Fractional Sequences

=AUTHOR Shlomi Fish

L<https://projecteuler.net/problem=343>

For any positive integer k, a finite sequence ai of fractions xi/yi is defined by:
a1 = 1/k and
ai = (xi-1+1)/(yi-1-1) reduced to lowest terms for i>1.
When ai reaches some integer n, the sequence stops. (That is, when yi=1.)
Define f(k) = n.
For example, for k = 20:

1/20 → 2/19 → 3/18 = 1/6 → 2/5 → 3/4 → 4/3 → 5/2 → 6/1 = 6

So f(20) = 6.

Also f(1) = 1, f(2) = 2, f(3) = 1 and Σf(k**3) = 118937 for 1 ≤ k ≤ 100.

Find Σf(k**3) for 1 ≤ k ≤ 2×106.

=CREDITS

Based on prob003-lanny.pl by Lanny Ripple .

=end pod

my %C = (1 => 1);
my int sub factor(int $n is copy, int $dd is copy) {
    # Can never happen in our case:
    # if n == 1:
    #    return []
    my Bool $f = False;
    while ( ($n +& 1) == 0)
    {
        $f = True;
        $n +>= 1;
    }
    if ($f and $n == 1)
    {
        return 2;
    }
    return %C{$n} //= sub {
        my int $l = $n.sqrt.Int;
        my int $d = $dd;
        while ($d <= $l)
        {
            if ($n % $d == 0)
            {
                return factor($n div $d, $d);
            }
            $d += 2;
        }
        $n > 1 ?? $n !! $d
    }.();
}

sub MAIN($n?) {
    # my Primes $p .= new;

    my Int $s = 1;
    # for 2 .. 20_000 -> Int $k {
    for 2 .. 2_000_000 -> int $k {
        $s += max map { factor($_, 3) }, $k+1, ($k*$k-$k+1);
        say "$k : $s" if $k % 1_000 == 0;
    }
    say "Result = $s"
}

# vim: expandtab shiftwidth=4 ft=perl6
