#import "../util.typ": *
= Probability Space

== Sample Space and Events
*Sample space* $Omega$ is the set of all possible outcomes of an experiment.

*An event* is a subset $A ⊆ Omega$.

#defn[$sigma$-algebra][
  A family $Sigma ⊆ 2^Omega$ is a *$sigma$-algebra* if
  $
    & emptyset in Sigma \
    & A in Sigma => A^c in Sigma \
    & A_1, A_2, dots in Sigma => blu(⋃_i) A_i in Sigma, blu("countably many")
  $
]

For a discrete probability space, a *probability mass function*,_pmf_, is a map
$
  p: Omega -> [0, 1], quad sum_(omega in Omega) p(omega) = 1
$
and the *probability of an event* is
$
  Pr(A) = sum_(omega in A) p(omega)
$

== Probability Measure
#defn[probability measure][
  A probability measure is a map $Pr: Sigma -> [0, 1]$ such that
  $
    Pr(Omega) = 1
  $
  and for pairwise disjoint events $A_1, A_2, dots in Sigma$,
  $
    Pr(⋃_i A_i) = sum_i Pr(A_i)
  $
]
The triple *$(Omega, Sigma, Pr)$* is called a *probability space*.

*Classical probability* on a _finite uniform sample space_ satisfies
$
  Pr(A) = abs(A) / abs(Omega)
$
and *geometric probability* satisfies
$
  Pr(A) = Vol(A) / Vol(Omega)
$

#example[
  Buffon's needle problem. \
  #align(center)[#image(width: 40%, "assets/image.png")]
  If a needle of length $ell < d$ is dropped onto ruled paper with gap $d$.
  $
    & x in [0, pi]: "angle between the needle & line below" \
    & y in [0, d/2]: "the distance between center of needle & closest line"
  $
  then with
  $
    Omega = [0, pi] times [0, d / 2]
  $
  and
  $
    A = { (x, y) in Omega : y <= ell / 2 sin x }
  $
  one gets
  $
    Pr(A) = Vol(A) / Vol(Omega) = 2 / (d pi) integral_0^pi ell / 2 sin x dif x = 2 ell / (d pi)
  $
]

== Basic Properties
All of the following are consequences of the axioms:
$
  Pr(A^c) = 1 - Pr(A)
$
$
  Pr(emptyset) = 0
$
$
  Pr(A ∖ B) = Pr(A) - Pr(A ∩ B)
$
$
  A ⊆ B => Pr(A) <= Pr(B)
$
$
  Pr(A ∪ B) = Pr(A) + Pr(B) - Pr(A ∩ B)
$

#note[
  自然数是偶数的概率是$1/2$: Not even wrong(无法定义一个$sigma$-field).
  但是$[0, 1]$中有理数概率是$0$是 well defined 的.
]

== Union Bound
For events $A_1, dots, A_n$,
$
  Pr(⋃_(i=1)^n A_i) <= sum_(i=1)^n Pr(A_i)
$

#example[
  If an algorithm has $n$ types of errors and each type occurs with probability at most $p$, then
  $
    Pr("no error") = 1 - Pr(⋃_(i=1)^n A_i) >= 1 - n p
  $
]

#panel[Ramsey Theory][
  If
  $
    binom(n, k) 2^(1 - binom(n, 2)) < 1
  $
  then there exists a $2$-coloring of $K_n$ with no monochromatic $K_k$. Hence $R(k, k) > n$.
]

#proofblock[
  Color each edge of $K_n$ independently red or blue with probability $1 / 2$. For each $k$-subset $S$ of the vertices, let $A_S$ be the event that the induced $K_S$ is monochromatic. Then
  $
    Pr(A_S) =^("two type of monochromatic") 2^(1 - k (k - 1) / 2)
  $
  and by the union bound
  $
    Pr(⋃_S A_S) <= n! / (k! (n - k)!) 2^(1 - k (k - 1) / 2) < 1
  $
  so with positive probability there is no monochromatic $K_k$.
]

#example[
  Balls into bins. Throw $n$ balls independently and uniformly into $n$ bins.
  Every bin receives at most $O((ln n) / (ln ln n))$ bins
  _w.h.p._(with high probability), with probability $1 - O(1/n)$.

  Proof.
  $A$: Some bin receives $k$ balls ($k$ to be fixed).

  $A_i$: event that bin $i$ receives at least $k$ balls.
  Let
  $
    Pr(A) = Pr(⋃_(i=1)^n A_i) sum_i Pr(A_i) <= 1/n
    => Pr(A^c) >= 1 - 1/n
  $
  For each $S in binom([n], k) in 2^[n]$, define
  $A_(i,S)$: bin-$i$ receives the balls in $S$.

  By union bound,
  $
    Pr(A_i) & = Pr(union.big_(S in binom([n], k)) A_(i, S)) <= sum_(S in binom([n], k)) Pr(A_(i, S)) \
            & = binom(n, k) 1/n^k <= ((e n)/k)^k 1/n^k = (e/k)^k <= 1/n^2, "when" k = 3 (ln n) / (ln ln n)
  $
]

== Inclusion-Exclusion
*Principle of inclusion-exclusion*

For events $A_1, dots, A_n$,
$
  Pr(⋃_(i=1)^n A_i) & = sum_(i=1)^n Pr(A_i) - sum_(i < j) Pr(A_i ∩ A_j) + sum_(i < j < k) Pr(A_i ∩ A_j ∩ A_k) - dots \
                    & = sum_(emptyset != S subset.eq [n])
                      (-1)^(|S| - 1) Pr(inter.big_(i in S) A_i)
$

*The Boole-Bonferroni inequalities*

for every $A_1, A_2, dots, A_n in Sigma$, for any $k >= 0$
$
  sum_(S in {1,2, dots, n},\ 1 <= |S| <= 2 k)
  (-1)^(|S| - 1) Pr(inter.big_(i in S) A_i) <=
  Pr(union.big_(i=1)^n A_i) <= sum_(S in {1,2, dots, n},\ 1 <= |S| <= 2 k + 1)
  (-1)^(|S| - 1) Pr(inter.big_(i in S) A_i)
$

#example[
  Derangement. Let $pi: [n] -> [n]$ be a uniformly random permutation and let $A_i$ be the event $pi(i) = i$. Then
  $
    Pr("pi has no fixed point") & = 1 - Pr(⋃_(i=1)^n A_i) \
    & = 1 - sum_(k=1)^n sum_(S in binom({1, 2, dots, n}, k)) (-1)^(k-1) Pr(inter.big_(i in S) A_i) \
    & = 1 + sum_(k=1)^n binom(n, k) (-1)^(k) (n-k)! / n!\
    &= sum_(k=0)^n (-1)^k 1/k! -> 1/e, n -> +oo
  $
  hence
  $
    Pr("pi has no fixed point") -> 1 / e
  $
]

== Continuity and Null Events
If $A_1 ⊆ A_2 ⊆ dots$ and $A = ⋃_(i=1)^oo A_i$, then
$
  Pr(A) & = Pr(A_1) sum_(i=1)^oo Pr(A_(i+1) \\ A_i) \
        & = Pr(A_1) + lim_(i=1)^oo sum_(i=1)^(n-1) (Pr(A_i+1) - Pr(A_i)) \
        & = lim_(i -> oo) Pr(A_i)
$
If $B_1 ⊇ B_2 ⊇ dots$ and $B = ⋂_(i=1)^oo B_i$, then
$
  Pr(B) = lim_(i -> oo) Pr(B_i)
$

== Null and Almost Surely Events

An event is called *null* if $Pr(A) = 0$. \
An event occurs *almost surely* if $Pr(A) = 1$. \
A *complete* probability space contains every subset of every null event.

#v(10%)
= Conditional Probability

== Definition
For events $A, B$ with $Pr(B) > 0$, the *conditional probability* of $A$ given $B$ is
$
  Pr(A | B) = Pr(A ∩ B) / Pr(B)
$

The map $A => Pr(A | B)$ is itself a probability law on
$
  Sigma_B = { A ∩ B : A in Sigma }
$
The triple is *$(B, Sigma_B := {A inter B, A in Sigma}, Pr(dot | B))$*

== Basic Examples
#example[
  Fair coin from a biased one. Repeatedly toss the biased coin until either $"HT"$ or $"TH"$ appears; output $H$ in the first case and $T$ in the second. Since
  $
    Pr("HT" | {"HT", "TH"}) = Pr("TH" | {"HT", "TH"}) = 1 / 2
  $
  this produces a fair coin from an unknown biased coin.
]

#example[
  Two-child problem. Under the uniform law on
  $
    Omega = {"BB", "BG", "GB", "GG"}
  $
  if we know that at least one child is a girl, then
  $
    Pr("GG" | {"BG", "GB", "GG"}) = 1 / 3
  $
]

== Fundamental Laws
For events $A_1, dots, A_n$ with positive intermediate probabilities, the chain rule is
$
  Pr(⋂_(i=1)^n A_i) = ∏_(i=1)^n Pr(A_i | ⋂_(j < i) A_j)
$

If $B_1, dots, B_n$ is a _partition_ of $Omega$, then *the law of total probability* is
$
  Pr(A) = sum_(i=1)^n Pr(A | B_i) Pr(B_i)
$

Under the same partition, Bayes' law is
$
  Pr(B_i | A) = (Pr(B_i) Pr(A | B_i)) / (sum_(j=1)^n Pr(B_j) Pr(A | B_j))
$

== Conditional Probability Examples
#panel[Birthday Paradox][
  For a uniform random map $f: [n] -> [m]$,
  $
    Pr(f "is 1-1") = (m! / ((m - n)!) 1 / m^n) = ∏_(i=1)^n (1 - (i - 1) / m)
  $
  and
  $
    ∏_(i=1)^n (1 - (i - 1) / m) & approx product_(i = 1)^n exp((i-1) / m) \
                                & approx exp(sum_(i=1)^n ((i - 1) / m))
                                  approx exp (-n^2 / (2 m))
  $
  Apply it to *Balls into bins*, throwing $n$ in $m$ one-by-one.
  $
    Pr("Every ball is thrown into an empty bin") = epsilon = exp(- n^2 / (2 m)) \
    =>sqrt(2 m ln (1/epsilon))
  $
]

#panel[Monty Hall Problem][
  Let $A$ be the event that you win the car in the end, and let $B$ be the event that your first choice is already the car.

  If you do not switch, then
  $
    Pr(A) = Pr(B) = 1 / 3
  $

  If you always switch, then by the law of total probability
  $
    Pr(A) & = Pr(A | B) Pr(B) + Pr(A | B^c) Pr(B^c) \
          & = 0 dot 1 / 3 + 1 dot 2 / 3 = 2 / 3
  $
  so switching doubles the success probability.
]

#panel[Gambler's Ruin][
  Let $A$ be the event that the gambler is ruined before reaching $n$, and let $Pr_k$ denote the law started from capital $k$.

  Conditioning on the first toss $B = {"the first toss is HEAD"}$,
  $
    Pr_k(A) & = Pr_k(A | B) Pr(B) + Pr_k(A | B^c) Pr(B^c) \
            & = 1 / 2 Pr_(k + 1)(A) + 1 / 2 Pr_(k - 1)(A)
  $
  for $0 < k < n$, with boundary conditions
  $
    Pr_0(A) = 1, quad Pr_n (A) = 0
  $

  Write $u_k = Pr_k (A)$. Then
  $
    u_(k + 1) - u_k = u_k - u_(k - 1)
  $
  so $(u_k)$ is arithmetic and therefore
  $
    u_k = alpha + beta k
  $
  Using $u_0 = 1$ and $u_n = 0$, we get $alpha = 1$ and $beta = -1 / n$. Hence
  $
    Pr_k(A) = u_k = 1 - k / n
  $
]

#panel[Dominating False Positives][
  Let $I$ be the event that the person is ill. We are given
  $
    Pr(I) = 0.001, quad Pr(+ | I) = 0.95, quad Pr(+ | I^c) = 0.05
  $

  By the law of total probability,
  $
    Pr(+) & = Pr(+ | I) Pr(I) + Pr(+ | I^c) Pr(I^c) \
          & = 0.95 dot 0.001 + 0.05 dot 0.999
  $

  Therefore, by Bayes' law,
  $
    Pr(I | +) & = (Pr(+ | I) Pr(I)) / Pr(+) \
              & = (0.95 dot 0.001) / (0.95 dot 0.001 + 0.05 dot 0.999) \
              & approx 1.87%
  $
  So even a positive test still leaves the disease unlikely, because false positives dominate the prior.
]

#panel[Simpson's Paradox][
  In the drug-trial example from the PPT:
  $
    Pr("success" | "Drug I", "women") & = 200 / 2000 = 1 / 10 > 10 / 200 \
                                      & = 1 / 20 = Pr("success" | "Drug II", "women")
  $
  $
    Pr("success" | "Drug I", "men") & = 19 / 20 \
                                    & > 1000 / 2000 = 1 / 2 = Pr("success" | "Drug II", "men")
  $

  But after aggregation,
  $
    Pr("success" | "Drug I") = 219 / 2020 < 1010 / 2200 = Pr("success" | "Drug II")
  $

  Abstractly, it is possible that for every block $C_i$ of a partition,
  $
    Pr(A | B ∩ C_i) > Pr(A | B^c ∩ C_i)
  $
  while overall one still has
  $
    Pr(A | B) < Pr(A | B^c)
  $
]

#v(10%)
= Independence

== Independence of Events
Two events $A$ and $B$ are *independent* if
$
  Pr(A ∩ B) = Pr(A) Pr(B)
$

If $Pr(B) > 0$, this is equivalent to
$
  Pr(A | B) = Pr(A)
$
and also equivalent to
$
  Pr(A ∩ B^c) = Pr(A) Pr(B^c)
$

For a family ${A_i : i in I}$, *mutual independence* means that for every finite $J ⊆ I$,
$
  Pr(⋂_(i in J) A_i) = ∏_(i in J) Pr(A_i)
$

An event $A$ is independent of a family ${B_i : i in I}$ if for all disjoint finite $J_+, J_- ⊆ I$,
$
  Pr(A | ⋂_(i in J_+) B_i ∩ ⋂_(i in J_-) B_i^c) = Pr(A)
$

== Product Probability Space
Given discrete probability spaces $(Omega_1, p_1), dots, (Omega_n, p_n)$, the product space is
$
  Omega = Omega_1 times dots times Omega_n
$
with product pmf
$
  p(omega_1, dots, omega_n) = p_1(omega_1) dots p_n(omega_n)
$

For measurable rectangles one has
$
  Pr(A_1 times dots times A_n) = Pr_1(A_1) dots Pr_n (A_n)
$
and for general probability spaces one similarly defines the product $sigma$-algebra and the corresponding product measure.

== Limited Independence
*Pairwise independence* only requires
$
  Pr(A_i ∩ A_j) = Pr(A_i) Pr(A_j) quad "for all distinct" i, j
$
Mutual independence implies pairwise independence, but the converse fails.

#panel[Pairwise But Not Mutually Independent][
  Toss three fair coins. Let
  $
    D = {X_1 != X_2}, quad E = {X_2 != X_3}, quad F = {X_3 != X_1}
  $

  Each event has probability $1 / 2$, and
  $
    Pr(D ∩ E) = Pr(D ∩ F) = Pr(E ∩ F) = 1 / 4 = (1 / 2)(1 / 2)
  $
  so they are pairwise independent.

  But
  $
    D ∩ E ∩ F = emptyset
  $
  because three bits cannot all be pairwise different. Hence
  $
    Pr(D ∩ E ∩ F) = 0 != 1 / 8 = Pr(D) Pr(E) Pr(F)
  $
  so they are not mutually independent.
]

#panel[Triple Product Without Pairwise Independence][
  The condition
  $
    Pr(A ∩ B ∩ C) = Pr(A) Pr(B) Pr(C)
  $
  by itself is much weaker than mutual independence.

  For example, on $Omega = {000, 010, 101, 111}$ with probabilities
  $
    Pr(000) = 1 / 8, quad Pr(010) = 3 / 8, quad Pr(101) = 3 / 8, quad Pr(111) = 1 / 8
  $
  let $A$, $B$, $C$ be the events that the first, second, third bit is $1$.
  Then
  $
    Pr(A) = Pr(B) = Pr(C) = 1 / 2
  $
  and
  $
    Pr(A ∩ B ∩ C) = Pr(111) = 1 / 8 = Pr(A) Pr(B) Pr(C)
  $
  but
  $
    Pr(A ∩ B) = 1 / 8 != 1 / 4 = Pr(A) Pr(B)
  $
  so no pair is independent.
]

== Independent Repetition
#panel[One-Sided Error Reduction][
  Suppose a randomized algorithm $cal(A)$ has one-sided error:
  $
    f(x) = 1 => cal(A)(x) = 1, quad f(x) = 0 => Pr(cal(A)(x) = 0) >= p
  $

  Run the algorithm independently $n$ times and return the conjunction of the outputs. On a no-instance, an error occurs only if every run is wrong, so by independence
  $
    Pr("wrong") <= (1 - p)^n
  $
  Therefore it is enough to take
  $
    n >= ln(1 / epsilon) / p
  $
  to reduce the error to at most $epsilon$.
]

#panel[Binomial Probability][
  For $n$ independent Bernoulli trials with success probability $p$, the probability of exactly $k$ successes is
  $
    p(k) & \
         & = sum_(S in binom([n], k))
           Pr("trials in" S "succeed") Pr("trials in" ([n] \\ S) "fail") \
         & = sum_(S in binom([n], k)) p^k (1 - p)^(n - k) \
         & = n! / (k! (n - k)!) p^k (1 - p)^(n - k)
  $

  Hence $p(k)$ is a pmf on ${0, 1, dots, n}$, and
  $
    sum_(k=0)^n p(k) = 1
  $
]

#panel[Fair Voting][
  Let $X$ be the number of heads in $n$ independent tosses of a fair coin. Then
  $
    Pr(|2 X - n| >= t) & = Pr(X <= (n - t) / 2) + Pr(X >= (n + t) / 2) \
                       & = 2^(1 - n) sum_(k <= (n - t) / 2) n! / (k! (n - k)!)
  $

  Using the entropy bound on the volume of a Hamming ball,
  $
    Pr(|2 X - n| >= t) <= 2^(1 - n + n H(1 / 2 - t / (2 n))) approx 2 exp(- t^2 / n)
  $
  Thus to make this probability at most $0.05$, it is enough to require
  $
    t >= 2 sqrt(n)
  $
]

#panel[Two-Sided Error Reduction][
  Suppose
  $
    Pr(cal(A)(x) = f(x)) >= 1 / 2 + p
  $
  for every input $x$. Run the algorithm independently $n$ times and return the majority answer. Then an error means that fewer than half of the runs are correct, so
  $
    Pr("majority is wrong") <= sum_(k < n / 2) n! / (k! (n - k)!) (1 / 2 + p)^k (1 / 2 - p)^(n - k)
  $
  and the *concentration inequalities* gives the upper bound
  $
    Pr("majority is wrong") <= exp(- p^2 n)
  $
  Hence it is enough to take
  $
    n >= ln(1 / epsilon) / p^2
  $
]

== Network Reliability and Conditional Independence
#panel[Serial-Parallel(串并联) Network Reliability][
  If each edge is present independently with probabilities $p_1, dots, p_5$, then
  $
    P_(A B) = 1 - (1 - p_1)(1 - p_2)(1 - p_3)
  $
  because $A$ and $B$ are connected iff at least one of the three parallel edges is present.

  Then
  $
    P_(A C) = P_(A B) p_5, quad P_(D E) = p_4
  $
  and the two branches from $s$ to $t$ work independently, so
  $
    P_(s t) = 1 - (1 - P_(A C))(1 - P_(D E))
  $
  that is,
  $
    P_(s t) = 1 - (1 - P_(A B) p_5)(1 - p_4)
  $
]
== Conditional independence
For events $A$, $B$, $C$ with $Pr(C) > 0$, we say that $A$ and $B$ are conditionally independent given $C$ if
$
  Pr(A ∩ B | C) = Pr(A | C) Pr(B | C)
$
If also $Pr(B ∩ C) > 0$, this is equivalent to
$
  Pr(A | B ∩ C) = Pr(A | C)
$

#panel[Conditional Independence Example][
  Toss two fair coins. Let
  $
    A = {X_1 = H}, quad B = {X_2 = H}, quad C = {X_1 != X_2}
  $
  Then $A$ and $B$ are independent, because
  $
    Pr(A ∩ B) = 1 / 4 = Pr(A) Pr(B)
  $

  But conditioned on $C$, they are no longer independent:
  $
    Pr(A ∩ B | C) = 0
  $
  while
  $
    Pr(A | C) Pr(B | C) = 1 / 2 dot 1 / 2 = 1 / 4
  $

  So *independence does not imply conditional independence*.
]

#v(10%)

