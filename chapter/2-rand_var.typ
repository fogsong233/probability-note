#import "../util.typ": *

= Random Variables

== Random Variable and Distribution
*A random variable* on a probability space $(Omega, Sigma, Pr)$ is a function
$
  X: Omega -> RR
$
satisfying
$
  forall x in RR, {omega in Omega : X(omega) <= x} in Sigma
$
that is, $X$ is $Sigma$-measurable.

For discrete random variables $X: Omega -> ZZ$, this implies that every event of the form
$
  {X in S}, quad S subset.eq ZZ
$
is measurable.

#example[
  Roll a die and let $X$ be the face value. Let $Y in {0, 1}$ indicate whether the outcome is odd. Then $X$ and $Y$ are both random variables on the same sample space, but they carry different amounts of information.
]

#defn[CDF][
  The *cumulative distribution function* of $X$ is
  $
    F_X(x) = Pr(X <= x)
  $
]

Two random variables $X$ and $Y$ are *identically distributed* if
$
  F_X = F_Y
$

Basic properties of the CDF:
$
  & x <= y => F_X(x) <= F_X(y) \
  & lim_(x -> -oo) F_X(x) = 0 \
  & lim_(x -> +oo) F_X(x) = 1
$

== Discrete and Continuous Random Variables
#defn[discrete random variable][
  $X$ is *discrete* if $X(Omega)$ is countable. Its *probability mass function* is
  $
    p_X(x) = Pr(X = x)
  $
  and
  $
    F_X(y) = sum_(x <= y) p_X(x)
  $
]

#defn[continuous random variable][
  $X$ is *continuous* if there exists an integrable density $f_X$ such that
  $
    F_X(y) = Pr(X <= y) = integral_(-oo)^y f_X(x) dif x
  $
]

#note[
  There exist random variables that are neither discrete nor continuous.
]

== Independence and Random Vector
Two random variables $X$ and $Y$ are *independent* if the events $X <= x$ and $Y <= y$ are independent for every $x, y in RR$.

For *discrete random variables*, this is equivalent to
$
  Pr(X = x inter Y = y) = Pr(X = x) Pr(Y = y)
$
for all $x, y$.

For random variables $X_1, dots, X_n$, *mutual independence* means
$
  Pr(X_1 = x_1 inter dots inter X_n = x_n) = p_(X_1)(x_1) dots p_(X_n)(x_n)
$
for every choice of values.

#defn[random vector][
  A random vector is an $n$-tuple
  $
    X = (X_1, dots, X_n)
  $
  where each $X_i$ is a random variable. Its *joint CDF* is
  $
    F_X(x_1, dots, x_n) = Pr(X_1 <= x_1 inter dots inter X_n <= x_n)
  $
]

For a discrete random vector, the joint pmf is
$
  p_X(x_1, dots, x_n) = Pr(X_1 = x_1 inter dots inter X_n = x_n)
$
and the marginal distribution is obtained by summing out the remaining coordinates.

#panel[Example of a pairwise independence][
  The construction of $2^n - 1$ pairwise independent random bits
  out of mutually independent random bits by XOR.

  That is, $n approx 2^k$, we want to generate $I_i in {0, 1}, i in [n]$, that is
  $
    Pr(I_i = 1) = 1/2
  $
  and
  $I_i$ is pairwise independent.  There's a $Theta(n)$ algorithm: \
  k-bits random bits generate one-by-one:
  $X := underbrace(000 dots 00, k "bits") -> 111...11$
  $B_(i, j)$ is the $j$-th bit of $i$ encoding into binary.
  $
    Pr(I_i = 1) := xor.big_(B_(i, j) = 1) B(X, j)
  $
]

#v(10%)
= Discrete Distributions

== Bernoulli Trial
#defn[Bernoulli distribution][
  A Bernoulli random variable takes values in ${0, 1}$ and satisfies
  $
    p_X(1) = p, quad p_X(0) = 1 - p
  $
  where $p in [0, 1]$.
]

For an event $A$, its indicator random variable is
$
  & I(A) = 1, "if" A "occurs" \
  & I(A) = 0, "otherwise"
$
which is a Bernoulli random variable with parameter $Pr(A)$.

== Binomial Distribution
#defn[binomial distribution][
  If $X$ is the number of successes in $n$ i.i.d. Bernoulli trials with parameter $p$, then
  $
    p_X(k) = Pr(X = k) = binom(n, k) p^k (1-p)^(n-k), quad k = 0, 1, dots, n
  $
  We write $X ~ "Bin"(n, p)$.
]

#note[
  One may write
  $
    X = X_1 + dots + X_n
  $
  where $X_1, dots, X_n$ are i.i.d. Bernoulli random variables.
]

== Geometric Distribution
#defn[geometric distribution][
  If $X$ is the number of Bernoulli trials needed to get the first success, then
  $
    p_X(k) = Pr(X = k) = (1-p)^(k-1) p, quad k = 1, 2, dots
  $
  We write $X ~ "Geo"(p)$.
]

#panel[Memoryless Property][
  For $X ~ "Geo"(p)$, for every $k >= 1$ and $n >= 0$,
  $
    Pr(X = k + n | X > n) = Pr(X = k)
  $

  Proof.
  $
    Pr(X = k + n | X > n) & = Pr(X = k + n) / Pr(X > n) \
                          & = ((1-p)^(n+k-1) p) / ((1-p)^n) \
                          & = (1-p)^(k-1) p = Pr(X = k)
  $
]

#note[
  The geometric distribution is the only discrete memoryless distribution on ${1, 2, dots}$.
]

== Sum of Independent Random Variables
If discrete random variables $X$ and $Y$ are independent, then
$
  p_(X+Y)(z) = sum_x Pr(X = x inter Y = z - x) = sum_x p_X(x) p_Y(z - x)
$
This is the *convolution* of the two mass functions:
$
  p_(X+Y) = p_X * p_Y
$

#proofblock[
  For i.i.d. Bernoulli random variables $X_1, dots, X_n$,
  $
    p_(X_1 + dots + X_n)(k) & = p dot p_(X_1 + dots + X_(n-1))(k-1) + (1-p) dot p_(X_1 + dots + X_(n-1))(k) \
                            & = binom(n-1, k-1) p^k (1-p)^(n-k) + binom(n-1, k) p^k (1-p)^(n-k) \
                            & = binom(n, k) p^k (1-p)^(n-k)
  $
]

== Negative Binomial Distribution
#defn[negative binomial distribution][
  Let $X$ be the number of failures before the $r$-th success in i.i.d. Bernoulli trials. Then
  $
    p_X(k) = Pr(X = k) = binom(k + r - 1, k) (1-p)^k p^r, quad k = 0, 1, 2, dots
  $
]

Moreover,
$
  X = (X_1 - 1) + dots + (X_r - 1)
$
where $X_1, dots, X_r$ are i.i.d. geometric random variables with parameter $p$.

== Hypergeometric Distribution
#defn[hypergeometric distribution][
  Let $X$ be the number of successes in $n$ draws without replacement from a population of $N$ objects containing exactly $M$ successes. Then
  $
    p_X(k) = Pr(X = k) = (binom(M, k) binom(N-M, n-k)) / binom(N, n)
  $
]

== Multinomial Distribution
#defn[multinomial distribution][
  Throw $n$ balls independently into $m$ bins, where bin $i$ is chosen with probability $p_i$ and
  $
    p_1 + dots + p_m = 1
  $
  If $X_i$ is the number of balls in bin $i$, then
  $
    Pr(X_1 = k_1 inter dots inter X_m = k_m) = n! / (k_1! dots k_m!) p_1^(k_1) dots p_m^(k_m)
  $
  whenever $k_1 + dots + k_m = n$.
]

Each marginal satisfies
$
  X_i ~ "Bin"(n, p_i)
$

== Poisson Distribution
#defn[Poisson distribution][
  A Poisson random variable with parameter $lambda > 0$ satisfies
  $
    p_X(k) = Pr(X = k) = exp(-lambda) lambda^k / k!, quad k = 0, 1, 2, dots
  $
]

#panel[Poisson as Binomial Limit][
  If $n -> oo$ and $n p = lambda$, then
  $
    "Bin"(n, lambda / n)(k)
    = binom(n, k) (lambda / n)^k (1 - lambda / n)^(n-k)
    approx exp(-lambda) lambda^k / k!
  $
  so the Poisson law is the idealized binomial distribution in the sparse regime.
]

#panel[Sum of Poisson Variables][
  If $X ~ "Pois"(lambda_1)$ and $Y ~ "Pois"(lambda_2)$ are independent, then
  $
    p_(X+Y)(k) & = sum_(i=0)^k p_X(i) p_Y(k-i) \
               & = sum_(i=0)^k exp(-lambda_1) lambda_1^i / i! exp(-lambda_2) lambda_2^(k-i) / (k-i)! \
               & = exp(-(lambda_1 + lambda_2)) / k! sum_(i=0)^k binom(k, i) lambda_1^i lambda_2^(k-i) \
               & = exp(-(lambda_1 + lambda_2)) (lambda_1 + lambda_2)^k / k!
  $
  Hence
  $
    X + Y ~ "Pois"(lambda_1 + lambda_2)
  $
]

#panel[Poisson Approximation for Balls into Bins][
  If $(X_1, dots, X_m)$ is multinomial with parameters $(m, n, p_1, dots, p_m)$ and $Y_i ~ "Pois"(lambda_i)$ are independent with $lambda_i = n p_i$, then
  $(X_1, dots, X_m)$ has the same distribution as $(Y_1, dots, Y_m)$ conditioned on $sum_i Y_i = n$

  Proof.
  $
    sum_i Y_i ~ Pois(sum_i lambda_i) = Pois(n)
  $
  $
    & Pr(Y_i = y_i | sum_i Y_i = n) \
    & = exp(sum_i lambda_i) product_i lambda_i^y_i/(y_i !) dot
      (e^n n^n / n!)^(-1) \
    & = n!/(product_i y_i !) product_i p_i^k \
    & = Pr((X_1, X_2, dots, X_n) = (y_1, y_2, dots, y_n))
  $
]

== Random Objects
#example[
  In the balls-into-bins model, $(X_1, dots, X_m)$ follows a multinomial distribution with parameters $(m, n, (1/m, dots, 1/m))$.
]

#example[
  In the Erdős-Rényi random graph $G(n, p)$, the number of edges is
  $
    "Bin"(binom(n, 2), p)
  $
]

#example[
  In the Galton-Watson branching process,
  $
    X_(n+1) = sum_(j=1)^(X_n) xi_j^(n)
  $
  where the offspring variables are i.i.d. nonnegative integer-valued random variables.
]

#v(8%)
== Expectation

== Definition
For a discrete random variable $X$, the *expectation* of $X$ is
$
  EE[X] = sum_x x p_X(x)
$
assuming $EX < oo$.

#panel[The St. Petersburg paradox][
  $
    p_(X)(2^k) = 2^(-k), k = 1, 2, 3...
    => EX = oo
  $
]

== Expectation of Indicators
For a Bernoulli random variable with parameter $p$,
$
  EE[X] = p
$
In particular, for an indicator variable,
$
  EE[I(A)] = Pr(A)
$

== Expectation of Poisson
For $X ~ "Pois"(lambda)$,
$
  EE[X] & = sum_(k >= 0) k exp(-lambda) lambda^k / k! \
        & = lambda sum_(k >= 1) exp(-lambda) lambda^(k-1) / (k-1)! \
        & = lambda
$

== Change of Variables
#panel[Law of The Unconscious Statistician, LOTUS][
  For a function $f: RR -> RR$ and a discrete random variable $X$,
  $
    EE[f(X)] = sum_x f(x) p_X(x)
  $

  More generally, for a discrete random vector $X = (X_1, dots, X_n)$,
  $
    EE[f(X_1, dots, X_n)] = sum_(x_1, dots, x_n) f(x_1, dots, x_n) p_X(x_1, dots, x_n)
  $
]

== Linearity of Expectation
For random variables $X$, $Y$ and scalars $a$, $b$,
$
  EE[a X + b] = a EE[X] + b
$
$
  EE[X + Y] = EE[X] + EE[Y]
$

#note[
  This holds whether or not $X$ and $Y$ are independent.
]

For any affine(or linear) function $f$,
$
  EE[f(X_1, dots, X_n)] = f(EE[X_1], dots, EE[X_n])
$

== Expectations of Basic Distributions
#panel[Binomial Expectation][
  If $X ~ "Bin"(n, p)$ and
  $
    X = X_1 + dots + X_n
  $
  with i.i.d. Bernoulli variables $X_i$, then by linearity
  $
    EE[X] = EE[X_1] + dots + EE[X_n] = n p
  $
]

#panel[Geometric Expectation][
  For $X ~ "Geo"(p)$, write
  $
    X = sum_(k >= 1) I_k
  $
  where $I_k$ indicates that the first $k-1$ trials all fail. Then
  $
    EE[X] = sum_(k >= 1) EE[I_k] = sum_(k >= 1) (1-p)^(k-1) = 1 / p
  $
]

#panel[Negative Binomial Expectation][
  For negative binomial expectation
  $
    X = sum_(k>=1) k binom(k+r-1, k) (1-p)^k p^r
  $
  $
    X = (X_1 - 1) + dots + (X_r - 1), X_i ~ Geo(p)
  $
  with i.i.d. $X_i ~ "Geo"(p)$, then
  $
    EE[X] = r EE[X_1] - r = r (1-p) / p
  $
]

#panel[Hypergeometric Expectation][
  Let $X$ count the red balls drawn. If $X_i$ indicates whether the $i$-th red ball is drawn, then
  $
    X = X_1 + dots + X_M
  $
  and each red ball is drawn with probability $n / N$. Hence
  $
    EE[X] = EE[X_1] + dots + EE[X_M] = n M / N
  $
]

== Pattern Matching and Coupon Collector
#panel[Pattern Matching][
  Let $s = (s_1, dots, s_n) in Q^n$ be a uniform random string over an alphabet $Q$ with $abs(Q) = q$. For a fixed pattern $pi in Q^k$, let $X$ be the number of appearances of $pi$ as a substring.

  If $I_i$ indicates that
  $
    pi = (s_i, s_(i+1), dots, s_(i+k-1))
  $
  then
  $
    X = sum_(i=1)^(n-k+1) I_i
  $
  and therefore
  $
    EE[X] = sum_(i=1)^(n-k+1) EE[I_i] = (n-k+1) q^(-k)
  $
]

#panel[Coupon Collector][
  Let $X$ be the number of boxes opened until all $n$ coupon types are collected. Decompose
  $
    X = X_1 + dots + X_n
  $
  where $X_i$ is the waiting time while there are exactly $i-1$ collected types.

  Then $X_i$ is geometric with parameter
  $
    p_i = (n-i+1) / n
  $
  so
  $
    EE[X] = sum_(i=1)^n EE[X_i] = sum_(i=1)^n n / (n-i+1) = n sum_(i=1)^n 1 / i approx n ln n
  $
]

== Double Counting Identity
For every nonnegative integer-valued random variable $X$, that $X$ takes the value in ${0, 1, 2, 3 dots}$,
$
  EE[X] = sum_(k >= 0) Pr(X > k)
$

#proofblock[
  Method 1:

  Let $I_k$ indicate the event $X > k$. Then
  $
    X = sum_(k >= 0) I_k
  $
  and by linearity,
  $
    EE[X] = sum_(k >= 0) EE[I_k] = sum_(k >= 0) Pr(X > k)
  $

  Method 2:
  $
    EX & = sum_(x>=0) blu(x) Pr(X = x) =
         sum_(x>=0) blu(sum_(k=0)^(x-1)) Pr(X = x) \
       & = sum_(k >= 0) sum_(x > k) Pr(X = x) = sum_(k>0) Pr(X > k)
  $
]

== Applications of Linearity
#panel[Unsuccessful Search in Open Addressing][
  #image("/assets/image.png")
  *Hash Function* $h: U -> [m]$, $n$ keys from the
  universe $U$ are mapped into $m$ slots.

  *Open Addressing* hash collision is resolved by a probing strategy.
  When searching for a a key $x in U$, the $i$-th probed
  slot is given by $h(x, i)$.
  - Linear probing: $h(x, i) = h(x) + i (mod m)$
  - Quadratic probing: $h(x, i) = h(x) + c_1 i + c_2 i^2 (mod m)$
  - Double hashing: $h(x, i) = h_1(x) + i h_2(x) (mod m)$
  - Uniform hashing: $h(x, i) = pi(i)$ where $pi$ is a uniform random permutation of $[m]$.


  In a hash table with load factor $alpha = n / m$, under uniform hashing, let $X$ be the number of probes in an unsuccessful search. Then
  $
    EE[X] = 1 + sum_(k >= 1) Pr(X > k)
  $

  Let $A_i$ be the event that the $i$-th probed slot is occupied. By the chain rule,
  $
    Pr(X > k) = Pr(inter.big_(i=1)^k A_i) = ∏_(i=1)^k Pr(A_i | inter.big_(j < i) A_j)
  $
  and
  $
    Pr(A_i | inter.big_(j < i) A_j) = (n - i + 1) / (m - i + 1) <= alpha
  $
  so
  $
    EE[X] <= 1 + sum_(k >= 1) alpha^k = 1 / (1 - alpha)
  $
]

#panel[Indicator Proof of Inclusion-Exclusion][
  Since
  $
    I(A^c) = 1 - I(A), quad I(A inter B) = I(A) I(B)
  $
  one gets
  $
    I(union.big_(i=1)^n A_i) = 1 - ∏_(i=1)^n (1 - I(A_i))
  $
  Expanding the product yields
  $
    I(union.big_(i=1)^n A_i) = sum_(emptyset != S subset.eq [n]) (-1)^(|S|-1) I(inter.big_(i in S) A_i)
  $
  and taking *expectations* gives the usual inclusion-exclusion formula.
]

== Boole-Bonferroni Inequality
For events $A_1, A_2, dots, A_n$
$
  I(union.big_(i=1)^n A_i) & = 1 - ∏_(i=1)^n (1 - I(A_i)) \
                           & =
                             sum_(emptyset != S subset.eq [n]) (-1)^(|S|-1) I(inter.big_(i in S) A_i) \
                           & = sum_(k=1)^n (-1)^(k-1) sum_(S in binom({1, dots, n}, k)) I(inter.big_(i in S) A_i)
$
Observation:
$
  X_k & := binom(sum_(i = 1)^n I(A_i), k) \
      & =
        sum_(S in binom({1, dots, n}, k))
        product_(i in S) I(A_i) \
      & = sum_(S in binom({1, dots, n}, k)) I(inter.big_(i in S) A_i)
$
$X_k$在每个$sum_i I(A_i) = m$下都是$binom(m, k)$,利用杨辉三角, 组合数可以被分解为上一行的两个, 偶数最终是上一行头减去尾, 奇数是加上尾.
$
  sum_(k <= 2 t) (-1)^(k-1) X_k <= sum_(k=1)^n (-1)^(k-1) X_k <= sum_(k <= 2t + 1) (-1)^(k-1) X_k
$
求均值证毕.

== Limitations of Linearity
#note[
  For infinite sums,
  $
    EE[sum_(i=1)^oo X_i] = sum_(i=1)^oo EE[X_i]
  $
  requires absolute convergence.

  For a random number of random variables,
  $
    EE[sum_(i=1)^N X_i] = EE[N] EE[X_1]
  $
  is not true in general without further hypotheses.
]

== Conditional Expectation

For a discrete random variable $X$ and an event $A$ with $Pr(A) > 0$, define
$
  EE[X | A] = sum_x x Pr(X = x | A)
$
assuming absolute convergence.

The conditional pmf is
$
  p_(X|A)(x) = Pr(X = x | A)
$
and $EE[X | A]$ satisfies the usual linearity properties.

== Law of Total Expectation
If $B_1, dots, B_n$ is a partition of $Omega$, then
$
  EE[X] = sum_(i=1)^n EE[X | B_i] Pr(B_i)
$

#proofblock[
  By the law of total probability,
  $
    Pr(X = x) = sum_(i=1)^n Pr(X = x | B_i) Pr(B_i)
  $
  Therefore
  $
    EE[X] & = sum_x x Pr(X = x) \
          & = sum_x x sum_(i=1)^n Pr(X = x | B_i) Pr(B_i) \
          & = sum_(i=1)^n Pr(B_i) sum_x x Pr(X = x | B_i) \
          & = sum_(i=1)^n EE[X | B_i] Pr(B_i)
  $
]

== Conditional Expectation Given a Random Variable
For random variables $X$ and $Y$, the conditional expectation $EE[X | Y]$ is the random variable $f(Y)$ where
$
  f(y) = EE[X | Y = y]
$

This extends naturally to $EE[X | Y, Z]$ and satisfies the *tower property*
$
  EE[EE[X | Y]] = EE[X]
$

== Conditional Expectation Applications
#panel[QuickSort][
  #align(center, image("/assets/image-1.png", width: 70%))
  Let $X_n$ be the number of comparisons used by QuickSort on a uniform random permutation of $n$ distinct elements, and let
  $
    t(n) = EE[X_n]
  $
  If $B_i$ is the event that the first element is the $i$-th smallest, then
  $
    t(n) & = sum_(i=1)^n EE[X_n | B_i] Pr(B_i) \
         & = 1 / n sum_(i=1)^n EE[n - 1 + X_(i-1) + X_(n-i)] \
         & = n - 1 + 2 / n sum_(i=0)^(n-1) t(i)
  $
  with $t(0) = t(1) = 0$.
]

#panel[Another QuickSort Proof][
  $A$ is a permutation of $a_1 < a_2 < dots < a_n$.

  Let $X_(i j)$ indicate whether $a_i$ and $a_j$ are compared during QuickSort.

  *Observation 1* Each pair are compared at most once. Then
  $
    X = sum_(i<j) X_(i j)
  $
  *Observation 2* If $a_i, a_j$ are still in the same array, then so are all $a_k$ for $i < k < j$.

  Therefore two keys are compared iff iff one of them is chosen as pivot when they are in the same array.
  $
    {a_i, a_(i+1), dots, a_j}
  $
  Hence
  $
    EE[X_(i j)] = 2 / (j - i + 1)
  $
  so by linearity
  $
    EE[X] = sum_(i<j) 2 / (j - i + 1) = sum_(i = 1)^n
    sum_(k=2)^(n-i+1) 2 / k<= 2 n sum_(k=1)^n 1 / k = 2 n ln n + O(n)
  $
]

#panel[Random Family Tree][
  In a Galton-Watson process with offspring mean
  $
    mu = EE[xi_j^(n)]
  $
  one has
  $
    EE[X_n | X_(n-1) = k] = EE[sum_(j=1)^k xi_j^(n-1)] = k mu
  $
  so
  $
    EE[X_n | X_(n-1)] = mu X_(n-1)
  $
  and therefore by the tower property
  $
    EE[X_n] = mu EE[X_(n-1)] = dots = mu^n
  $

  Consequently,
  $
    EE[sum_(n=0)^oo X_n] = sum_(n=0)^oo mu^n
  $
  which equals $1 / (1 - mu)$ if $0 < mu < 1$, and diverges to $+oo$ if $mu >= 1$.
]


== Jensen's Inequality
If $f$ is convex(下凸, 如绝对值函数), then
$
  EE[f(X)] >= f(EE[X])
$
If $f$ is concave(凹的, 如对数函数), then
$
  EE[f(X)] <= f(EE[X])
$

== Monotonicity of Expectation
If $X <= Y$ almost surely, then
$
  EE[X] <= EE[Y]
$

#proofblock[
  Since $X <= Y$ almost surely, we have
  $
    Pr(X <= Y) = 1
  $
  Hence
  $
    Pr((X, Y) = (x, y)) = 0, "whenever" x > y
  $

  Therefore
  $
    EE[X] & = sum_x x Pr(X = x) \
          & = sum_x x sum_y Pr((X, Y) = (x, y)) \
          & = sum_x x sum_(y >= x) Pr((X, Y) = (x, y))
  $

  Since $x <= y$ whenever $y >= x$, we get
  $
    EE[X] & <= sum_y y sum_(x <= y) Pr((X, Y) = (x, y)) \
          & = sum_y y Pr(Y = y) \
          & = EE[Y]
  $
]

In particular, if $X <= c$ almost surely, then
$
  EE[X] <= c
$
and if $X >= c$ almost surely, then
$
  EE[X] >= c
$

Also, since
$
  -abs(X) <= X <= abs(X)
$
almost surely, monotonicity gives
$
  -EE[abs(X)] <= EE[X] <= EE[abs(X)]
$
and therefore
$
  abs(EE[X]) <= EE[abs(X)]
$
In particular,
$
  EE[abs(X)] >= abs(EE[X]) >= 0
$

== Averaging Principle
If $Pr(X < c) = 1$, then $EE[X] < c$.

#proofblock[
  The assumption $Pr(X < c) = 1$ means that
  $
    X < c
  $
  almost surely. In particular,
  $
    X <= c
  $
  almost surely, so by monotonicity
  $
    EE[X] <= c
  $
]

Contrapositively,
$
  Pr(X >= EE[X]) > 0
$
Similarly,
$
  Pr(X <= EE[X]) > 0
$

#note[
  This is the probabilistic method in its simplest form: if there were no outcome with
  $
    X(omega) >= EE[X]
  $
  then $X < EE[X]$ almost surely, contradicting the previous statement.

  Therefore there exists an outcome $omega in Omega$ such that
  $
    X(omega) >= EE[X]
  $
  and similarly there exists an outcome such that
  $
    X(omega) <= EE[X]
  $
]

== Maximum Cut
#panel[Randomized Existence Proof][
  For an undirected graph $G(V, E)$, let each vertex independently join $S$ with probability $1 / 2$. For each edge ${u, v} in E$, let
  $
    I_(u v) = I(Y_u != Y_v)
  $
  indicate whether the edge crosses the cut. Then
  $
    abs(delta S) = sum_({u, v} in E) I_(u v)
  $
  and
  $
    EE[abs(delta S)] = sum_({u, v} in E) Pr(Y_u != Y_v) = abs(E) / 2
  $
  Therefore there exists a cut with size at least $abs(E) / 2$.
]
