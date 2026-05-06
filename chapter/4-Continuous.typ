#import "../util.typ": *

= Continuous Random Variable

== Continuous Random Variable and Density
#defn[continuous random variable][
  A random variable $X$ is *continuous* if there exists an integrable function
  $
    f_X: RR -> [0, oo)
  $
  such that for every $x in RR$,
  $
    F_X(x) = Pr(X <= x) = integral_(-oo)^x f_X(t) dif t
  $

  The function $f_X$ is called a *probability density function* (pdf) of $X$.
]

#note[
  Once $X$ has a density, the CDF $F_X$ is automatically continuous. In particular,
  $
    Pr(X = x) = F_X(x) - lim_(t -> x^-) F_X(t) = 0
  $
  for every $x in RR$.
]

#theorem[
  A function $f: RR -> RR$ is a density of some continuous random variable iff
  $
    f(x) >= 0 "for all" x, quad integral_(-oo)^oo f(x) dif x = 1
  $

  In that case, if $X$ has density $f_X = f$, then for every $a < b$,
  $
    Pr(a < X <= b) = integral_a^b f_X(x) dif x
  $
]

#proofblock[
  If $X$ is continuous with density $f_X$, then clearly $f_X(x) >= 0$ and
  $
    integral_(-oo)^oo f_X(x) dif x = lim_(b -> oo) F_X(b) - lim_(a -> -oo) F_X(a) = 1
  $

  Conversely, if $f >= 0$ and $integral_(-oo)^oo f(x) dif x = 1$, define
  $
    F(x) = integral_(-oo)^x f(t) dif t
  $
  Then $F$ is nondecreasing, right-continuous, and satisfies
  $
    lim_(x -> -oo) F(x) = 0, quad lim_(x -> oo) F(x) = 1
  $
  so $F$ is a valid CDF.

  For the interval formula,
  $
    Pr(a < X <= b) = F_X(b) - F_X(a) = integral_a^b f_X(x) dif x
  $
]

#note[
  The density is not uniquely determined pointwise. If two functions agree except on a set of Lebesgue measure $0$, then they define the same interval probabilities, hence the same distribution.

  If $F_X$ happens to be differentiable, one usually chooses
  $
    f_X(x) = F'_X(x)
  $
]

#example[
  If
  $
    f(x) = c x^2 I_(0 <= x <= 1)
  $
  is to be a density, then we must have
  $
    1 = integral_0^1 c x^2 dif x = c / 3
  $
  hence $c = 3$.

  For the corresponding random variable $X$,
  $
    F_X(x) = 0 quad "for" x < 0
  $
  $
    F_X(x) = integral_0^x 3 t^2 dif t = x^3 quad "for" 0 <= x <= 1
  $
  and
  $
    F_X(x) = 1 quad "for" x > 1
  $
]

== Density and Integration
#panel([Probability Density Function], [
  For a continuous random variable, the density value $f_X(x)$ is *not* itself a probability. What is meaningful is the probability of a short interval:
  $
    Pr(x < X <= x + h) = integral_x^(x+h) f_X(t) dif t approx f_X(x) h
  $
  when $h$ is small.

  So the density tells us how probability mass is distributed locally, not the probability of a single point.
])

#panel([Riemann vs. Lebesgue], [
  The Dirichlet function
  $
    f(x) = I_(x in QQ)
  $
  on $[0, 1]$ is the standard warning sign for Riemann integration. Every interval contains both rationals and irrationals, so upper and lower sums never settle down to one value.

  From the probabilistic point of view, however, what matters is not the height of the graph at each point, but the size of the set on which a given value is taken. This is exactly what Lebesgue integration is designed to measure.
])

#defn[Borel sigma-field][
  The *Borel sigma-field* on $RR$, denoted $cal(B)(RR)$, is the smallest sigma-field containing all open intervals.

  Elements of $cal(B)(RR)$ are called *Borel sets*.
]

#note[
  In continuous probability, we usually work on a Borel probability space
  $
    (RR, cal(B)(RR), Pr)
  $
  or on a measurable space that carries the same kind of interval information. This is the natural setting for CDFs, densities, and change-of-variable formulas.
]

#panel([Lebesgue Integral], [
  Let $(Omega, Sigma, mu)$ be a measure space and let $f: Omega -> [0, oo]$ be measurable. One convenient way to define the Lebesgue integral is the layer-cake formula
  $
    integral_Omega f dif mu = integral_0^oo mu({omega in Omega : f(omega) > t}) dif t
  $

  For a general real-valued measurable function, write
  $
    f = f^+ - f^-
  $
  where
  $
    f^+ = max(f, 0), quad f^- = max(-f, 0)
  $
  and define the integral whenever at least one of
  $
    integral f^+ dif mu, quad integral f^- dif mu
  $
  is finite.
])

#example[
  Some standard pathological examples:

  1. A Vitali set is non-measurable, so it cannot be assigned a sensible translation-invariant probability.

  2. The Dirichlet function $I_(QQ)$ is Lebesgue integrable on $[0, 1]$ with value $0$, because $QQ inter [0, 1]$ is countable.

  3. The Cantor set is uncountable but has Lebesgue measure $0$.

  These examples explain why measure-theoretic language is not optional decoration here; it is what keeps the theory correct.
]

== Jointly Continuous Random Variables
#defn[joint CDF and joint density][
  For random variables $X$ and $Y$, their joint distribution function is
  $
    F_(X,Y)(x, y) = Pr(X <= x and Y <= y)
  $

  They are *jointly continuous* if there exists a function
  $
    f_(X,Y): RR^2 -> [0, oo)
  $
  such that
  $
    F_(X,Y)(x, y) = integral_(-oo)^y integral_(-oo)^x f_(X,Y)(u, v) dif u dif v
  $
  for all $x, y in RR$.
]

#note[
  If $F_(X,Y)$ is sufficiently differentiable, then one recovers the joint density by
  $
    f_(X,Y)(x, y) = (diff^2 F_(X,Y)(x, y)) / (diff x dif y)
  $
]

== Marginal Distribution
If $(X, Y)$ has joint density $f_(X,Y)$, then the marginals are obtained by integrating out the other coordinate:
$
  f_X(x) = integral_(-oo)^oo f_(X,Y)(x, y) dif y
$
$
  f_Y(y) = integral_(-oo)^oo f_(X,Y)(x, y) dif x
$

Similarly,
$
  F_X(x) = F_(X,Y)(x, oo), quad F_Y(y) = F_(X,Y)(oo, y)
$

#proofblock[
  For example,
  $
    F_X(x) = Pr(X <= x) = Pr(X <= x and Y in RR)
  $
  so
  $
    F_X(x) = integral_(-oo)^oo integral_(-oo)^x f_(X,Y)(u, y) dif u dif y
  $
  Differentiating with respect to $x$ gives
  $
    f_X(x) = integral_(-oo)^oo f_(X,Y)(x, y) dif y
  $
]

== Independence
Two random variables $X$ and $Y$ are independent iff for all $x, y in RR$,
$
  F_(X,Y)(x, y) = F_X(x) F_Y(y)
$

If $X$ and $Y$ are jointly continuous, this is equivalent to
$
  f_(X,Y)(x, y) = f_X(x) f_Y(y)
$
for all $x, y$.

#proofblock[
  If
  $
    f_(X,Y)(x, y) = f_X(x) f_Y(y)
  $
  then
  $
    F_(X,Y)(x, y)
    = integral_(-oo)^y integral_(-oo)^x f_X(u) f_Y(v) dif u dif v
    = F_X(x) F_Y(y)
  $

  Conversely, if
  $
    F_(X,Y)(x, y) = F_X(x) F_Y(y)
  $
  and the functions are differentiable enough, differentiating in $x$ and $y$ yields
  $
    f_(X,Y)(x, y) = f_X(x) f_Y(y)
  $
]

#note[
  If $X$ and $Y$ are independent and $g, h$ are Borel-measurable, then $g(X)$ and $h(Y)$ are also independent.
]

== Conditional Distribution
#defn[conditioning on an event][
  Let $X$ be continuous and let $A$ be an event with $Pr(A) > 0$. The conditional CDF of $X$ given $A$ is
  $
    F_(X|A)(x) = Pr(X <= x | A)
  $

  If this conditional law has a density, we denote it by $f_(X|A)$, so that
  $
    F_(X|A)(x) = integral_(-oo)^x f_(X|A)(u) dif u
  $
]

#panel([Law of Total Probability for Densities], [
  If $B_1, dots, B_n$ is a partition of $Omega$ and each $Pr(B_i) > 0$, then
  $
    f_X(x) = sum_(i=1)^n Pr(B_i) f_(X|B_i)(x)
  $

  Proof. For each $x$,
  $
    Pr(X <= x) = sum_(i=1)^n Pr(B_i) Pr(X <= x | B_i)
  $
  Differentiating with respect to $x$ gives the density identity.
])

#defn[conditional density given a random variable][
  Suppose $(X, Y)$ is jointly continuous. For every $y$ with $f_Y(y) > 0$, define
  $
    F_(X|Y)(x | y) = Pr(X <= x | Y = y)
  $
  by
  $
    F_(X|Y)(x | y) = integral_(-oo)^x (f_(X,Y)(u, y)) / (f_Y(y)) dif u
  $

  Hence the conditional density is
  $
    f_(X|Y)(x | y) = (f_(X,Y)(x, y)) / (f_Y(y))
  $
]

#proofblock[
  Fix $y$ and a very short interval $(y, y + dif y]$. Then heuristically
  $
    Pr(X <= x | y < Y <= y + dif y)
    = (Pr(X <= x and y < Y <= y + dif y)) / (Pr(y < Y <= y + dif y))
  $

  Using the joint density,
  $
    Pr(X <= x and y < Y <= y + dif y)
    approx integral_(-oo)^x f_(X,Y)(u, y) dif u dot dif y
  $
  while
  $
    Pr(y < Y <= y + dif y) approx f_Y(y) dif y
  $

  Cancelling the common factor $dif y$ gives
  $
    F_(X|Y)(x | y) = integral_(-oo)^x (f_(X,Y)(u, y)) / (f_Y(y)) dif u
  $
]

#panel([Law of Total Probability Given a Continuous Variable], [
  Let $B subset.eq RR$ be a Borel set. Then
  $
    Pr(X in B) = integral_(-oo)^oo Pr(X in B | Y = y) f_Y(y) dif y
  $

  In density form, this is just
  $
    f_X(x) = integral_(-oo)^oo f_(X|Y)(x | y) f_Y(y) dif y
  $
])

== Expectation and Moments
#defn[expectation][
  Let $X$ be a continuous random variable with density $f_X$. Its expectation is
  $
    EE[X] = integral_(-oo)^oo x f_X(x) dif x = integral_(-oo)^oo x dif F_X(x)
  $
  whenever the integral exists absolutely.

  More generally, the $k$-th moment is
  $
    EE[X^k] = integral_(-oo)^oo x^k f_X(x) dif x
  $
]

#note[
  The integral notation
  $
    integral_(-oo)^oo x dif F_X(x)
  $
  is the Stieltjes form. For continuous random variables this agrees with the usual density formula.
]

== Tail Integral Formula
#theorem[
  If $X >= 0$ almost surely, then
  $
    EE[X] = integral_0^oo Pr(X > x) dif x = integral_0^oo (1 - F_X(x)) dif x
  $
]

#proofblock[
  Since $X >= 0$,
  $
    EE[X] = integral_0^oo x f_X(x) dif x
  $
  and
  $
    1 - F_X(x) = integral_x^oo f_X(u) dif u
  $

  Therefore
  $
    integral_0^oo (1 - F_X(x)) dif x
    = integral_0^oo integral_x^oo f_X(u) dif u dif x
  $

  The integration region is
  $
    {(x, u) : 0 <= x <= u < oo}
  $
  so switching the order gives
  $
    integral_0^oo integral_0^u f_X(u) dif x dif u
    = integral_0^oo u f_X(u) dif u
    = EE[X]
  $
]

== LOTUS
#panel([Law of the Unconscious Statistician], [
  If $X$ is continuous and $g(X)$ is integrable, then
  $
    EE[g(X)] = integral_(-oo)^oo g(x) f_X(x) dif x
  $
])

#proofblock[
  First assume $g >= 0$. By the tail-integral formula,
  $
    EE[g(X)] = integral_0^oo Pr(g(X) > y) dif y
  $

  Let
  $
    B_y = {x in RR : g(x) > y}
  $
  Then
  $
    Pr(g(X) > y) = integral_(B_y) f_X(x) dif x
  $
  so
  $
    EE[g(X)]
    = integral_0^oo integral_(B_y) f_X(x) dif x dif y
    = integral_(-oo)^oo f_X(x) integral_0^(g(x)) dif y dif x
    = integral_(-oo)^oo g(x) f_X(x) dif x
  $

  For a general $g$, write
  $
    g = g^+ - g^-
  $
  and apply the nonnegative case to $g^+$ and $g^-$ separately.
]

== Linearity, Monotonicity, and Total Expectation
For scalars $a, b$ and integrable random variables $X, Y$,
$
  EE[a X + b] = a EE[X] + b
$
$
  EE[X + Y] = EE[X] + EE[Y]
$

#proofblock[
  The first identity is immediate:
  $
    EE[a X + b]
    = integral_(-oo)^oo (a x + b) f_X(x) dif x
    = a integral_(-oo)^oo x f_X(x) dif x + b integral_(-oo)^oo f_X(x) dif x
    = a EE[X] + b
  $

  For the second, use the joint density:
  $
    EE[X + Y]
    = integral_(-oo)^oo integral_(-oo)^oo (x + y) f_(X,Y)(x, y) dif x dif y
  $
  $
    = integral_(-oo)^oo integral_(-oo)^oo x f_(X,Y)(x, y) dif x dif y
      + integral_(-oo)^oo integral_(-oo)^oo y f_(X,Y)(x, y) dif x dif y
    = EE[X] + EE[Y]
  $
]

If $X <= Y$ almost surely, then
$
  EE[X] <= EE[Y]
$

#proofblock[
  Let
  $
    Z = Y - X
  $
  Then $Z >= 0$ almost surely, so by nonnegativity of the integral,
  $
    EE[Z] >= 0
  $
  Hence
  $
    EE[Y] - EE[X] = EE[Z] >= 0
  $
]

#panel([Total Expectation], [
  If $B_1, dots, B_n$ is a partition of $Omega$ with $Pr(B_i) > 0$, then
  $
    EE[X] = sum_(i=1)^n EE[X | B_i] Pr(B_i)
  $

  If $(X, Y)$ is jointly continuous, then
  $
    EE[X] = integral_(-oo)^oo EE[X | Y = y] f_Y(y) dif y
  $
  and equivalently
  $
    EE[EE[X | Y]] = EE[X]
  $
])

== Expectation of Products
If $X$ and $Y$ are independent and integrable, then
$
  EE[X Y] = EE[X] EE[Y]
$

#proofblock[
  Independence gives
  $
    f_(X,Y)(x, y) = f_X(x) f_Y(y)
  $
  therefore
  $
    EE[X Y]
    = integral_(-oo)^oo integral_(-oo)^oo x y f_(X,Y)(x, y) dif x dif y
    = integral_(-oo)^oo integral_(-oo)^oo x y f_X(x) f_Y(y) dif x dif y
  $
  $
    = integral_(-oo)^oo x f_X(x) dif x dot integral_(-oo)^oo y f_Y(y) dif y
    = EE[X] EE[Y]
  $
]

#note[
  Consequently,
  $
    Cov(X, Y) = EE[X Y] - EE[X] EE[Y] = 0
  $
  whenever $X$ and $Y$ are independent.

  More generally, if $X_1, dots, X_n$ are pairwise independent, then
  $
    Var(sum_(i=1)^n X_i) = sum_(i=1)^n Var(X_i)
  $
]

== Uniform Distribution
#defn[uniform distribution][
  The random variable $X$ is *uniform on* $[a, b]$ with $a < b$ if it has density
  $
    f_X(x) = 1 / (b - a) quad "for" a <= x <= b
  $
  $
    f_X(x) = 0 quad "for" x < a "or" x > b
  $

  Its CDF is
  $
    F_X(x) = 0 quad "if" x < a
  $
  $
    F_X(x) = (x - a) / (b - a) quad "if" a <= x <= b
  $
  $
    F_X(x) = 1 quad "if" x > b
  $
]

#note[
  There is no uniform distribution on an infinite interval such as $[a, oo)$ or on the whole line $RR$, because a constant density over an infinite region cannot integrate to $1$.
]

#panel([Moments of the Uniform Law], [
  If $X$ is uniform on $[a, b]$, then
  $
    EE[X] = integral_a^b x / (b - a) dif x = (a + b) / 2
  $
  and
  $
    EE[X^2] = integral_a^b x^2 / (b - a) dif x = (a^2 + a b + b^2) / 3
  $
  Hence
  $
    Var(X) = EE[X^2] - EE[X]^2 = (b - a)^2 / 12
  $
])

#note[
  The mean is the midpoint of the interval, just as in the discrete uniform case, but the variance is different because the mass is spread continuously rather than sitting on finitely many atoms.
]

== Rejection Sampling as Conditioning
#panel([Uniform Law on a Subinterval], [
  Let $X$ be uniform on $[a, b]$, and let $[c, d] subset.eq [a, b]$. Then
  $
    Pr(X in [c, d]) = (d - c) / (b - a)
  $

  Conditioned on the event $X in [c, d]$, the random variable $X$ is uniform on $[c, d]$.
])

#proofblock[
  For $x in RR$,
  $
    Pr(X <= x | X in [c, d])
    = (Pr(X in [c, d] inter X <= x)) / (Pr(X in [c, d]))
  $

  This is
  $
    0 quad "if" x < c
  $
  $
    (x - c) / (d - c) quad "if" c <= x <= d
  $
  and
  $
    1 quad "if" x > d
  $
  which is exactly the CDF of the uniform law on $[c, d]$.
]

== Function of a Random Variable
#panel([Monotone Change of Variables], [
  Let $Y = g(X)$ where $X$ has density $f_X$.

  If $g$ is strictly increasing, then
  $
    F_Y(y) = Pr(Y <= y) = Pr(g(X) <= y) = Pr(X <= g^(-1)(y)) = F_X(g^(-1)(y))
  $
  Hence
  $
    f_Y(y) = f_X(g^(-1)(y)) (dif g^(-1)(y)) / (dif y)
  $

  If $g$ is strictly decreasing, the same computation gives the absolute-value form
  $
    f_Y(y) = f_X(g^(-1)(y)) abs((dif g^(-1)(y)) / (dif y))
  $
])

#example[
  If $X$ is continuous and $Y = a X + b$ with $a != 0$, then
  $
    f_Y(y) = 1 / abs(a) f_X((y - b) / a)
  $

  In particular, scaling stretches the density by the reciprocal factor $1 / abs(a)$.
]

== Inverse Transform Sampling
#panel([Simulation from a CDF], [
  Let $U$ be uniform on $[0, 1]$ and let $F$ be a continuous CDF. Define
  $
    X = F^(-1)(U)
  $
  Then $X$ has CDF $F$.
])

#proofblock[
  For every $x in RR$,
  $
    Pr(X <= x)
    = Pr(F^(-1)(U) <= x)
    = Pr(U <= F(x))
  $
  because $F^(-1)$ is increasing.

  Since $U$ is uniform on $[0, 1]$,
  $
    Pr(U <= F(x)) = F(x)
  $
  so indeed $X$ has CDF $F$.
]

#note[
  For an integer-valued discrete CDF $F$, the analogous construction is
  $
    X = k quad "iff" F(k - 1) < U <= F(k)
  $
  This is the quantile viewpoint: $F^(-1)(u)$ picks the $u$-th quantile.
]

== Stochastic Domination and Coupling
#defn[stochastic domination][
  Suppose $X$ and $Y$ are real-valued random variables. We say that $X$ *stochastically dominates* $Y$ if
  $
    F_X(t) <= F_Y(t) quad "for all" t in RR
  $
]

#theorem[
  The following are equivalent:

  1. $X$ stochastically dominates $Y$.

  2. There exists a coupling $(tilde X, tilde Y)$ with marginals distributed as $X$ and $Y$ respectively such that
     $
       tilde X >= tilde Y
     $
     almost surely.
]

#proofblock[
  The implication $2 => 1$ is immediate: if $tilde X >= tilde Y$ almost surely, then
  $
    {tilde X <= t} subset.eq {tilde Y <= t}
  $
  for every $t$, hence
  $
    F_X(t) = Pr(tilde X <= t) <= Pr(tilde Y <= t) = F_Y(t)
  $

  For $1 => 2$, let $U$ be uniform on $[0, 1]$ and define
  $
    tilde X = F_X^(-1)(U), quad tilde Y = F_Y^(-1)(U)
  $
  By inverse transform sampling, these have the correct marginals.

  Because $F_X(t) <= F_Y(t)$ for all $t$, the quantile function of $X$ lies above that of $Y$, hence
  $
    tilde X >= tilde Y
  $
  almost surely.
]

#note[
  Coupling is often the cleanest way to compare random variables. Instead of comparing formulas for their CDFs, one puts them on the same probability space and compares them pointwise.
]

== Exponential Distribution
#defn[exponential distribution][
  A random variable $X$ has the *exponential distribution* with parameter $lambda > 0$, written
  $
    X ~ "Exp"(lambda)
  $
  if its density is
  $
    f_X(x) = lambda exp(-lambda x) quad "for" x >= 0
  $
  $
    f_X(x) = 0 quad "for" x < 0
  $

  Its CDF is
  $
    F_X(x) = 0 quad "for" x < 0
  $
  $
    F_X(x) = 1 - exp(-lambda x) quad "for" x >= 0
  $
]

#panel([Continuous Limit of the Geometric Law], [
  Think of Bernoulli trials being performed every $delta > 0$ units of time, with success probability
  $
    p = lambda delta
  $
  at each trial.

  Let $T_delta$ be the waiting time for the first success. Then for $x >= 0$,
  $
    Pr(T_delta > x)
    = (1 - lambda delta)^([x / delta])
    -> exp(-lambda x)
  $
  as $delta -> 0$.

  So the exponential law is the continuous-time analogue of the geometric law.
])

#panel([Moments of the Exponential Law], [
  If $X ~ "Exp"(lambda)$, then
  $
    EE[X] = integral_0^oo x lambda exp(-lambda x) dif x = 1 / lambda
  $

  One can also use the tail formula:
  $
    EE[X] = integral_0^oo Pr(X > x) dif x = integral_0^oo exp(-lambda x) dif x = 1 / lambda
  $

  Moreover,
  $
    EE[X^2] = integral_0^oo x^2 lambda exp(-lambda x) dif x = 2 / lambda^2
  $
  hence
  $
    Var(X) = EE[X^2] - EE[X]^2 = 1 / lambda^2
  $
])

#theorem[
  The exponential distribution is memoryless:
  for all $s, t >= 0$,
  $
    Pr(X > s + t | X > t) = Pr(X > s)
  $
]

#proofblock[
  Since
  $
    Pr(X > u) = exp(-lambda u)
  $
  for every $u >= 0$,
  $
    Pr(X > s + t | X > t)
    = (Pr(X > s + t)) / (Pr(X > t))
    = exp(-lambda(s+t)) / exp(-lambda t)
    = exp(-lambda s)
    = Pr(X > s)
  $
]

#note[
  In fact, the exponential law is the only continuous distribution on $[0, oo)$ with the memoryless property.
]

#panel([Minimum of Independent Exponentials], [
  If $X_1, dots, X_n$ are independent and
  $
    X_i ~ "Exp"(lambda_i)
  $
  then
  $
    min(X_1, dots, X_n) ~ "Exp"(lambda_1 + dots + lambda_n)
  $
])

#proofblock[
  For $x >= 0$,
  $
    Pr(min(X_1, dots, X_n) > x)
    = Pr(X_1 > x and dots and X_n > x)
  $
  By independence,
  $
    = product_(i=1)^n Pr(X_i > x)
    = product_(i=1)^n exp(-lambda_i x)
    = exp(-(lambda_1 + dots + lambda_n)x)
  $
  which is exactly the tail of an exponential distribution with parameter
  $
    lambda_1 + dots + lambda_n
  $
]

== Poisson Point Process
#panel([Poisson Process], [
  A *Poisson process* with rate $lambda > 0$ is a continuous-time counting process
  $
    {N(t) : t >= 0}
  $
  defined by the picture of a random clock:

  1. $N(t)$ counts how many times the clock has rung by time $t$, with
     $
       N(0) = 0
     $

  2. The interarrival times between consecutive rings, including the waiting time before the first ring, are i.i.d.
     $
       "Exp"(lambda)
     $
])

#note[
  The exponential memoryless property makes the process restart after every ring. That is why the Poisson process is the natural continuous-time analogue of repeated Bernoulli trials.
]

#panel([Superposition of Clocks], [
  If we have $k$ independent exponential clocks, each with rate $lambda$, then the first ring among all clocks occurs after an
  $
    "Exp"(k lambda)
  $
  waiting time.

  So the process obtained by superposing $k$ independent rate-$lambda$ clocks behaves like a single clock of rate $k lambda$.
])

#theorem[
  For every $s, t >= 0$ and integer $n >= 0$,
  $
    Pr(N(t + s) - N(s) = n) = exp(-lambda t) (lambda t)^n / n!
  $

  In particular,
  $
    N(t) ~ "Pois"(lambda t)
  $
]

#proofblock[
  Write
  $
    p_n(t) = Pr(N(t) = n)
  $
  For a very short time interval of length $h$, we have
  $
    Pr(N(h) = 0) = 1 - lambda h + o(h)
  $
  $
    Pr(N(h) = 1) = lambda h + o(h)
  $
  $
    Pr(N(h) >= 2) = o(h)
  $

  Therefore
  $
    p_0(t+h) = p_0(t)(1 - lambda h) + o(h)
  $
  so
  $
    p'_0(t) = -lambda p_0(t), quad p_0(0) = 1
  $
  and hence
  $
    p_0(t) = exp(-lambda t)
  $

  For $n >= 1$,
  $
    p_n(t+h) = p_n(t)(1 - lambda h) + p_(n-1)(t) lambda h + o(h)
  $
  which gives
  $
    p'_n(t) = -lambda p_n(t) + lambda p_(n-1)(t), quad p_n(0) = 0
  $

  One checks by induction that the solution is
  $
    p_n(t) = exp(-lambda t) (lambda t)^n / n!
  $

  By the memoryless property, after time $s$ the process restarts afresh, so the same formula holds for the increment
  $
    N(t+s) - N(s)
  $
]

== Normal Distribution
#defn[normal distribution][
  A continuous random variable $X$ has the *normal* or *Gaussian* distribution with parameters $mu in RR$ and $sigma^2 > 0$, written
  $
    X ~ "N"(mu, sigma^2)
  $
  if
  $
    f_X(x) = 1 / (sqrt(2 pi) sigma) exp(-(x - mu)^2 / (2 sigma^2)), quad -oo < x < oo
  $
]

#panel([Standard Normal], [
  The case
  $
    mu = 0, quad sigma = 1
  $
  is called the *standard normal distribution*, denoted
  $
    "N"(0, 1)
  $
  with density
  $
    phi(x) = 1 / sqrt(2 pi) exp(-x^2 / 2)
  $
  and CDF
  $
    Phi(z) = integral_(-oo)^z phi(x) dif x
  $
])

#note[
  The CDF $Phi$ has no elementary closed form. One often uses numerical tables or the error function
  $
    "erf"(z) = 2 / sqrt(pi) integral_0^z exp(-x^2) dif x
  $
  and then
  $
    Phi(z) = 1 / 2 + 1 / 2 "erf"(z / sqrt(2))
  $
]

#panel([Why This Is a Probability Distribution], [
  The normal density integrates to $1$ because of the Gaussian integral
  $
    integral_(-oo)^oo exp(-x^2 / 2) dif x = sqrt(2 pi)
  $

  This is the normalization constant behind
  $
    1 / sqrt(2 pi)
  $
  in the standard normal density.
])

#note[
  The normal law is central because it appears as a continuous limit of the binomial law and, much more generally, through the central limit theorem: sums of many independent random contributions are approximately normal.
]

#theorem[
  If
  $
    X ~ "N"(mu, sigma^2)
  $
  then
  $
    EE[X] = mu, quad Var(X) = sigma^2
  $
]

#proofblock[
  Because the density is symmetric around $mu$, the odd part of
  $
    x - mu
  $
  integrates to $0$, so
  $
    EE[X] = mu
  $

  For the variance, substitute
  $
    y = (x - mu) / sigma
  $
  Then
  $
    Var(X) = EE[(X - mu)^2]
    = integral_(-oo)^oo (x - mu)^2 1 / (sqrt(2 pi) sigma) exp(-(x - mu)^2 / (2 sigma^2)) dif x
  $
  $
    = sigma^2 integral_(-oo)^oo y^2 1 / sqrt(2 pi) exp(-y^2 / 2) dif y
  $

  Integrating by parts gives
  $
    integral_(-oo)^oo y^2 1 / sqrt(2 pi) exp(-y^2 / 2) dif y = 1
  $
  so
  $
    Var(X) = sigma^2
  $
]

== Linear Transformation of a Normal Variable
#theorem[
  If
  $
    X ~ "N"(mu, sigma^2)
  $
  and $a != 0$, then for every $b in RR$,
  $
    a X + b ~ "N"(a mu + b, a^2 sigma^2)
  $
]

#proofblock[
  Let
  $
    Y = a X + b
  $
  Since $y = a x + b$ is monotone, the change-of-variable formula gives
  $
    f_Y(y) = 1 / abs(a) f_X((y - b) / a)
  $
  Hence
  $
    f_Y(y)
    = 1 / (sqrt(2 pi) abs(a) sigma)
      exp(-(((y - b) / a) - mu)^2 / (2 sigma^2))
  $
  $
    = 1 / (sqrt(2 pi) sqrt(a^2 sigma^2))
      exp(-(y - (a mu + b))^2 / (2 a^2 sigma^2))
  $
  which is exactly the density of
  $
    "N"(a mu + b, a^2 sigma^2)
  $
]

#note[
  In particular:
  $
    X ~ "N"(mu, sigma^2) => (X - mu) / sigma ~ "N"(0, 1)
  $
  and conversely, if $Z ~ "N"(0, 1)$, then
  $
    sigma Z + mu ~ "N"(mu, sigma^2)
  $
]

== Sum of Independent Normal Variables
#panel([Convolution], [
  For continuous independent random variables $X$ and $Y$,
  $
    f_(X+Y)(z) = integral_(-oo)^oo f_X(x) f_Y(z - x) dif x
  $
  This is the continuous analogue of convolution from the discrete case.
])

#theorem[
  If
  $
    X ~ "N"(mu, sigma^2), quad Y ~ "N"(nu, tau^2)
  $
  are independent, then
  $
    X + Y ~ "N"(mu + nu, sigma^2 + tau^2)
  $
]

#proofblock[
  One way is by convolution: substituting the two Gaussian densities and completing the square shows that
  $
    f_(X+Y)(z)
  $
  is again Gaussian with mean $mu + nu$ and variance $sigma^2 + tau^2$.

  A quicker route is via moment generating functions, which we derive next.
]

== Moment Generating Function
#defn[moment generating function][
  The *moment generating function* of a random variable $X$ is
  $
    M_X(t) = EE[exp(t X)]
  $
  whenever this expectation is finite.
]

#note[
  Expanding $exp(t X)$ into its Maclaurin series suggests
  $
    M_X(t) = sum_(k >= 0) EE[X^k] t^k / k!
  $
  so the moments are recovered by differentiation:
  $
    EE[X^k] = M_X^(k)(0)
  $

  If two random variables have the same MGF on an open interval around $0$, then they have the same distribution.
]

#panel([MGF of the Standard Normal], [
  If $Z ~ "N"(0, 1)$, then
  $
    M_Z(t) = exp(t^2 / 2)
  $
])

#proofblock[
  Compute directly:
  $
    M_Z(t)
    = 1 / sqrt(2 pi) integral_(-oo)^oo exp(t x) exp(-x^2 / 2) dif x
  $
  $
    = 1 / sqrt(2 pi) integral_(-oo)^oo exp(-(x^2 - 2 t x) / 2) dif x
  $
  Complete the square:
  $
    x^2 - 2 t x = (x - t)^2 - t^2
  $
  Therefore
  $
    M_Z(t)
    = exp(t^2 / 2) 1 / sqrt(2 pi) integral_(-oo)^oo exp(-(x - t)^2 / 2) dif x
    = exp(t^2 / 2)
  $
]

#panel([MGF of a General Normal Variable], [
  If
  $
    X ~ "N"(mu, sigma^2)
  $
  then
  $
    M_X(t) = exp(mu t + sigma^2 t^2 / 2)
  $
])

#proofblock[
  Write
  $
    X = sigma Z + mu
  $
  with $Z ~ "N"(0, 1)$. Then
  $
    M_X(t) = EE[exp(t(sigma Z + mu))]
    = exp(mu t) EE[exp((sigma t) Z)]
    = exp(mu t) M_Z(sigma t)
  $
  Hence
  $
    M_X(t) = exp(mu t) exp(sigma^2 t^2 / 2) = exp(mu t + sigma^2 t^2 / 2)
  $
]

#proofblock[
  This also gives another proof of closure under independent sums. If $X$ and $Y$ are independent normals, then
  $
    M_(X+Y)(t) = M_X(t) M_Y(t)
  $
  $
    = exp((mu + nu)t + (sigma^2 + tau^2)t^2 / 2)
  $
  which is the MGF of
  $
    "N"(mu + nu, sigma^2 + tau^2)
  $
]

== Gaussian Concentration
#theorem[
  If
  $
    X ~ "N"(mu, sigma^2)
  $
  then for every $a > 0$,
  $
    Pr(abs(X - mu) >= a sigma) <= 2 exp(-a^2 / 2)
  $
]

#proofblock[
  Standardize
  $
    Z = (X - mu) / sigma ~ "N"(0, 1)
  $

  For any $t > 0$, Markov's inequality gives
  $
    Pr(Z >= a) = Pr(exp(t Z) >= exp(t a)) <= EE[exp(t Z)] / exp(t a)
  $
  Using the MGF of the standard normal,
  $
    Pr(Z >= a) <= exp(t^2 / 2 - t a)
  $
  The right-hand side is minimized at $t = a$, giving
  $
    Pr(Z >= a) <= exp(-a^2 / 2)
  $

  By symmetry,
  $
    Pr(abs(Z) >= a) <= 2 exp(-a^2 / 2)
  $
  and therefore
  $
    Pr(abs(X - mu) >= a sigma) = Pr(abs(Z) >= a) <= 2 exp(-a^2 / 2)
  $
]

#note[
  Numerically this is weaker than the empirical $68$-$95$-$99.7$ rule, but it is much sharper than Chebyshev's inequality and has the advantage of being a clean closed-form bound.
]
