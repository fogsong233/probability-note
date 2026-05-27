#import "../util.typ": *

= Moments and Deviations

== Markov Inequality
Let $X$ be a _nonnegative-valued_ random variable. Then,
$
  forall a > 0, Pr(X >= a) <= EE[X] / a
$
#coroll[
  $
    forall c > 1, Pr(X >= c EE[X]) <= 1 / c
  $
]
#term("Tight in the worst case")[
  $
    forall c > 1, exists mu in RR, ∃ X > 0 s.t. EE[X] = μ
    "such that" \
    Pr(X ≥ c mu) = 1/c
  $
]
Lower tail variant (sometimes called _reverse Markov’s inequality_):

If $X$ has bounded range $X <= u$, then
$
  Pr(X <= a) <= (u - EE[X]) / (u - a)
$

== Generalized Markov's Inequality
$
  Pr(f(x) >= a) <= EE[f(x)] / a
$

#notebox[
  $
    mu = EE[X],
    Pr(|X - mu| >= a) <= ? \
    Pr(|X - mu| >= a) = Pr((X - mu)^2 >= a^2) <= blu(EE[(X-mu)^2])/a^2, blu("variance")
  $
]

== Variance and Moments
$EE[X^k]$: $k$th moment. \
$EE[(X-EE[X])^k]$: $k$th central moment. \
$Var[X] = EE[(X-EE[X])^2]$ \
standard deviation $sigma = sqrt(Var[X])$



== Median and Mean
The median of _RV_ $X$ is defined to be any value $M$ s.t.
$
  Pr(X <= m) >= 1/2 "and" Pr(X >= m) >= 1/2
$
$mu = EE[X]$ is the value that minimizes
$
  EE[(X - mu)^2]
$

#term("proof")[
  $
    f(x) = EE[(X-x)^2] = EE[X^2] - 2 x EE[X] + x^2 "is convex" \
    f'(mu) = 0
  $
]

The median $m$ is the value that minimizes
$
  Ep(abs(X-m))
$

#term[proof][
  $
       & y > m => Pr(X >= y) < 1/2 \
       & Ep(abs(X - y) - abs(X-m)) \
     = & (y-m) Pr(X <= m) + blu(
           sum_(m < x < y)
           (m + y - 2 x) Pr(X = x) + (m - y)Pr(X >= y)
         ) \
    >= & 1/2 (y - m) + blu(sum_(m < x < y) (m - y) Pr(X = x) + (m - y)Pr(X >= y)) \
    >= & 1/2(y-m) + blu(1/2(m - y)) = 0
  $
]

$X$ is a _RV_, $m$ is median, $mu$ is #EX, standard deviation is $sigma$ then
$
  abs(mu - m) <= sigma
$
#term[proof][
  $
    abs(mu - m) & = |EX - m| \
                & < Ep(|X - m|), "Jensen's Ineq" \
                & <= E[|X - mu|] \
                & = Ep(sqrt((X - mu)^2)) \
                & <= sqrt(E[(X - mu)^2]), "Jensen's Ineq" \
                & = sigma
  $
]

== Variance of Linear Function
$
  Var[X] = Ep((X - EX)^2) = Ep(X^2) - (EX)^2
$
$
  Var[X + Y] = Var[X] + Var[Y] + blu(2(Ep(X Y) - EX Ep(Y))),
  blu(Cov(X, Y))
$

== Covariance
$
  Cov(X, Y) = Ep((X - EX) (Y - Ep(Y))) = Ep(X Y) - EX Ep(Y)
$
Properties:
$
  Var[X] = Cov(X, X)
$
*symmetric* \ $ Cov(X, Y) = Cov(Y, X) $
*Distributive* \
$
  Cov(X + Y, Z) = Cov(X, Z) + Cov(Y, Z) \
  Cov(a X, Y) = a Cov(X, Y)
$

If $X$, $Y$ are *independent* then
$
  Cov(X, Y) = 0 <=> EX Ep(Y) = Ep(X Y)
$
If
_RV_ $X$ and $Y$ are independent, then
$
  Ep(X Y) = EX Ep(Y)
$
#term[proof][
  $
    Ep(X Y) & = sum_(x, y) x y Pr(X = x and Y = y)
              = sum_(x, y) x y Pr(X = x) Pr(Y = y) \
            & = sum_x x Pr(X = x) sum_y y Pr(Y = y) \
            & = EE[X] EE[Y]
  $
]

#panel[Cauchy-Schwarz][
  $
    EE[X Y]^2 <= Ep(X^2) Ep(Y^2)
  $
  proof.
  $
    EE[X^2] & = EE[EE[X^2] | Y^2] \
            & = sum_(i, j)x^2 Pr(X^2 = i inter Y^2 = j) \
            & := sum_(i, j) x^2 p_(i j)
  $
  $
    EE[Y^2] & = EE[EE[Y^2] | X^2] \
            & = sum_(i, j)y^2 Pr(X^2 = i inter Y^2 = j) \
            & := sum_(i, j) y^2 p_(i j)
  $
  $
    Ep(X^2) Ep(Y^2) & = sum_(i, j) x^2 p_(i j) sum_(i, j) y^2 p_(i j) \
                    & >=^("cauchy") (sum_(i j) (p_(i j) x y))^2 \
                    & = EE[X Y]^2
  $
]
#panel[Holder][
  $
    EE[X Y] <= E[|X|^p]^(1/p) E[|Y|^q]^(1/q), "when" 1/p + 1/q = 1
  $
]

== Correlation
The *correlation coefficient* of $X$ and $Y$ is
$
  rho(X, Y) = Cov(X, Y) / sqrt(Var[X] dot Var[Y]) in [-1, 1], \ "by Cauchy-Schwarz"(U = (X - EX) / sigma(X), V = (Y - Ep(Y)) / sigma(Y))
$

Two _RV_ are uncorrelated if $Cov(X, Y) = 0$ \
Uncorrelated but not independent, e.g. $X ~ U[-1, 1], Y = X^2, EE[X] = 0, EE[X Y] = EE[X^3] = 0$

== Variance of Sum
$
  Var[sum_i X_i] & = sum_i Var[X_i] + sum_(i != j) Cov(X_i, X_j) \
                 & blu(=^("if pairwise independent") sum_i Var[X_i])
$

== Variances of Basic Distributions
#panel[Bernoulli Variance][
  Let $X ~ "Bern"(p)$, so $Pr(X = 1) = p$ and $Pr(X = 0) = 1 - p$.
  Since $X^2 = X$,
  $
    EE[X] = p, quad EE[X^2] = p
  $
  Hence
  $
    Var[X] = EE[X^2] - EE[X]^2 = p - p^2 = p(1-p)
  $
]

#panel[Binomial Variance][
  Let $X ~ "Bin"(n, p)$ and write
  $
    X = X_1 + dots + X_n
  $
  where $X_i$ are i.i.d. $"Bern"(p)$. By independence,
  $
    Var[X] = sum_(i=1)^n Var[X_i] = sum_(i=1)^n p(1-p) = n p(1-p)
  $
]

#panel[Geometric Variance][
  Let $X ~ "Geo"(p)$ count the number of trials until the first success, and set $q = 1-p$.
  $
    EE[X] = sum_(k >= 1) k p q^(k-1) = 1 / p
  $
  Use the factorial moment:
  $
    EE[X(X-1)] & = sum_(k >= 1) k(k-1) p q^(k-1) \
               & = p dot (2 q) / (1-q)^3 = (2 q) / p^2
  $
  Therefore
  $
    EE[X^2] = EE[X(X-1)] + EE[X] = (2q) / p^2 + 1/p = (2-p) / p^2
  $
  and
  $
    Var[X] = EE[X^2] - EE[X]^2 = (2-p) / p^2 - 1 / p^2 = (1-p) / p^2
  $
]

#panel[Negative Binomial Variance][
  Let $X$ be the number of failures before the $r$-th success. Then
  $
    X = (G_1 - 1) + dots + (G_r - 1)
  $
  where $G_i$ are i.i.d. $"Geo"(p)$. Constants do not change variance, so
  $
    Var[X] = sum_(i=1)^r Var[G_i - 1] = r dot (1-p) / p^2
  $
]

#panel[Poisson Variance][
  Let $X ~ "Pois"(lambda)$. Its first factorial moment is
  $
    EE[X] = sum_(k >= 1) k e^(-lambda) lambda^k / k! = lambda
  $
  and its second factorial moment is
  $
    EE[X(X-1)] & = sum_(k >= 2) k(k-1) e^(-lambda) lambda^k / k! \
               & = lambda^2 sum_(j >= 0) e^(-lambda) lambda^j / j! = lambda^2
  $
  Hence
  $
    EE[X^2] = EE[X(X-1)] + EE[X] = lambda^2 + lambda
  $
  and
  $
    Var[X] = EE[X^2] - EE[X]^2 = lambda
  $
]

#panel[Hypergeometric Variance][
  Let $X$ count successes in $n$ draws without replacement from $N$ objects with $M$ successes. Write
  $
    X = I_1 + dots + I_M
  $
  where $I_a$ indicates that the $a$-th successful object is selected. Then
  $
    EE[I_a] = n/N, quad Var[I_a] = n/N (1 - n/N)
  $
  For $a != b$,
  $
    EE[I_a I_b] = (n(n-1)) / (N(N-1))
  $
  Thus
  $
    Cov(I_a, I_b) & = (n(n-1)) / (N(N-1)) - n^2 / N^2 \
                  & = - (n(N-n)) / (N^2 (N-1))
  $
  Therefore
  $
    Var[X] & = M dot n/N (1 - n/N) + M(M-1) dot ( - (n(N-n)) / (N^2(N-1)) ) \
           & = n dot M/N dot (1 - M/N) dot (N-n)/(N-1)
  $
]

#panel[Multinomial Variance and Covariance][
  Let $(X_1, dots, X_m) ~ "Mult"(n; p_1, dots, p_m)$. For fixed $i$,
  $X_i ~ "Bin"(n, p_i)$, so
  $
    Var[X_i] = n p_i(1-p_i)
  $
  For $i != j$, write $X_i = sum_(t=1)^n I_(t,i)$ and $X_j = sum_(t=1)^n I_(t,j)$. Different trials are independent, while in the same trial bins $i$ and $j$ cannot both occur:
  $
    Cov(I_(t,i), I_(t,j)) = 0 - p_i p_j = -p_i p_j
  $
  Hence
  $
    Cov(X_i, X_j) = sum_(t=1)^n Cov(I_(t,i), I_(t,j)) = - n p_i p_j
  $
]

== Chebyshev's Inequality
$
  Pr(|X-EE[X]| >= a) <= Var[X] / a^2
$
#coroll[
  $Pr(|X-EE[X]| >= k sigma) <= 1/k^2$
]
Tight in the worst case: $forall k >= 1, forall mu in R, forall sigma > 0, exists X(EX = mu, Var[X] = sigma^2)$ such that $Pr(|X - mu| >= k sigma) = 1/k^2$

#panel[mean trick][
  - Let $X_1, ..., X_n$ be _i.i.d._ random variables with $E[X_i] = mu$ and $Var[X_i] = sigma^2$.

  - Empirical mean: $overline(X) = 1/n sum_(i=1)^n X_i$
    $
      E[overline(X)] = 1/n sum_(i=1)^n E[X_i] = mu quad "and" quad Var[overline(X)] = 1/n^2 sum_(i=1)^n Var[X_i] = sigma^2 / n
    $

  - Chebyshev's inequality:
    $
      Pr(|overline(X) - mu| >= epsilon mu) <= (Var[overline(X)]) / (epsilon^2 mu^2) = sigma^2 / (epsilon^2 mu^2 n) <= delta quad "if" n >= sigma^2 / (epsilon^2 mu^2 delta)
    $
]

#panel[Balls into Bins][
  Throwing $n$ balls into $n$ bins, the most heavily loaded
  bin receives $Theta((ln n) / (ln ln n))$ balls
  _a.a.s_ (asymptotically almost surely), with probability
  $1 - o(1)$.

  - upper bound, see above, union bound.
  - lower bound.
  Choose $k = 0.99 (ln n ) / (ln ln n)$.
  To proof $Pr("max-load" < k) = o(1)$
  Let $ I_i = I("bin-"i "receives extactly " k "balls"), X = sum_i I_i $
  $
    Pr("max-load" < k) & <= Pr(X = 0) blu(<= Pr(|X - EX| >= EX)) <= Var[X] / EX^2
  $
  $
    EX & = n p = n binom(n, k) (1/n)^k (1 - 1/n)^(n-k) >=_("use" binom(n, k) >= (n/k)^k)
         n / (e k^k) = omega(1)
  $
  $
    Var[X] & = sum_i Var[I_i] + sum_(i != j) Cov(I_i, I_j)
             = sum_(i, j) (E_[I_i I_j] - E[I_i]E[I_j]) \
         = & sum_(i, j) (E[I_i I_j] - p^2) = sum_i E[I_i^2] + sum_(i != j) E[I_i I_j] - n^2 p^2 \
           & = sum_i E[I_i] + sum_(i != j) E[I_i I_j] - n^2 p^2 = n p + Y - (n p)^2
  $
  $
    Var[X] / EX^2 <= o(1) + (Y - n^2 p^2) / (n^2 p^2)
  $
  $
    E[I_i I_j] & = Pr("both receive exactly" k "balls") \
               & =
                 binom(n, k, k, n - 2 k) n^(-2 k) (1 - 2/ n)^(n - 2k) \
               & <= (1 + o(1)) p^2 ("as" k << sqrt(n))
  $

]

#panel[Cliques in Random Graph][
  - Fix a constant integer $k >= 3$. Let $X$ be the number of $k$-cliques ($K_k$) in $G tilde G(n, p)$.

  - For every distinct $S subset.eq [n]$ of size $|S| = k$, let $I_S = I(K_S subset.eq G)$. Then:
    $ X = sum_(S in binom([n], k)) I_S quad "and" quad bb(E)[I_S] = Pr(K_S subset.eq G) = p^binom(k, 2) $

  - *Linearity of expectation:* $ bb(E)[X] = binom(n, k) p^binom(k, 2) = Theta(n^k p^binom(k, 2)) $

  $
    EX = Theta(n^k p^binom(k, 2)) =
    cases(
      o(1) quad "if" p = o(n^(-2/(k-1))) blu(=>^("Markov") Pr(X >= 1) = o(1)),
      omega(1) quad"if" p = omega(n^(-2/(k-1))) blu(=>^("?") Pr(X >= 1) = 1 - o(1)),
    )
  $
  Same like previous balls into bins,- *Second Moment Method:* To prove $Pr(X >= 1) = 1 - o(1)$, we use Chebyshev's inequality on $X = 0$:
  $ Pr(X = 0) <= (Var[X]) / (bb(E)[X]^2) = (sum_(S, T) Cov(I_S, I_T)) / (bb(E)[X]^2) $

  - *Variance Decomposition:* We split the variance into the sum of individual variances and covariances of distinct pairs:
  $
    Var[X] & = sum_(S) Var[I_S] + sum_(S != T) Cov(I_S, I_T) \
           & <= bb(E)[X] + sum_(i=2)^(k-1) sum_(|S sect T|=i) bb(E)[I_S I_T]
  $

  - *Bounding the Variance Ratio:* Dividing by $bb(E)[X]^2$, the ratio is bounded by two parts:
    $ (Var[X]) / (bb(E)[X]^2) <= 1 / EX + sum_(i=2)^(k-1) Theta(1 / (n^i p^binom(i, 2))) $
    Since $p = omega(n^(-2/(k-1)))$, we know $bb(E)[X] -> infinity$, making the first term $1/EX = o(1)$. We now bound the sum.

  - *Applying the Threshold Rigorously:* Since $p = omega(n^(-2/(k-1)))$, there exists some function $c_n -> infinity$ such that $p = c_n n^(-2/(k-1))$. Let's examine the denominator of any term $i in [2, k-1]$:
    $
      n^i p^binom(i, 2) = n^i (c_n n^(-2/(k-1)))^((i(i-1))/2) = c_n^binom(i, 2) n^(i - (i(i-1))/(k-1)) = c_n^binom(i, 2) n^((i(k-i))/(k-1))
    $

    For $2 <= i <= k-1$:
    1. The exponent of $n$ is $(i(k-i))/(k-1) > 0$, so $n^((i(k-i))/(k-1)) >= 1$ (it strictly grows).
    2. Since $i >= 2$, the exponent of $c_n$ is $binom(i, 2) >= 1$. Because $c_n -> infinity$, we have $c_n^binom(i, 2) -> infinity$.

    Thus, the entire denominator $c_n^binom(i, 2) n^((i(k-i))/(k-1)) -> infinity$, meaning every term in the sum is $1 / omega(1) = o(1)$.

  - *Conclusion:* We are summing a finite number ($k-2$) of $o(1)$ terms, plus the $1/bb(E)[X]$ term which is also $o(1)$.
    $ (Var[X]) / (bb(E)[X]^2) = o(1) + sum_(i=2)^(k-1) o(1) = o(1) quad blu(=>) quad Pr(X = 0) = o(1) $

    *A "Threshold Behavior" in Random Graph*

    Use same method, we can conclude:

    For $H(V, E)$ with $k = |V|, m = |E|$ s.t. every subgraph
    of $H$ has density $<= m/k$.
    $
      Pr(G "contains a subgraph" H) = cases(o(1) quad "if" p = o(n^(-k/m)), 1 - o(1) quad "if" p = omega(n^(-k/m)))
    $

]

== Weierstrass Approximation Theorem
Let $f: [0, 1] -> [0, 1]$ be a continuous function. For
any $epsilon > 0$, there exists a polynominal $p$ such that
$
  sup_(x in [0, 1]) |p(x) - f(x)| <= epsilon
$

_Proof._ Let $n$ be sufficiently large(to be fixed later).

For $x in [0, 1]$, let $X ~ 1/n "Bin"(n, x)$. Define polynominal $p$ on $x in [0, 1]$ to be
$
  p(x) = E[f(X)] = sum_(k = 0)^n f(k/n) binom(n, k) x^k (1 - x)^(n-k)
$
$
  |p(x) - f(x)| = |E[f(X) - f(x)]| <= E[|f(X) - f(x)|]
$
$f$ is continuous on $[0, 1] =>$ $exists delta > 0 s.t.
|f(x) - f(y)| <= epsilon / 2$ for all $|x - y| <= delta$, therefore
$
  & E[|f(X) - f(x)|] \
  = & E[abs(f(X) - f(x)) | abs(X - x) <= delta] dot Pr(|X - x| <= delta)
  + \
  & E[abs(f(X) - f(x)) | abs(X - x) > delta] + dot blu(Pr(|X - x| > delta)) \
  <= & E[epsilon / 2] + |1 - 0| blu(Pr(|X - x| > delta)) \
  <= & epsilon / 2 + blu((x (1-x)) / (n delta^2)) <= epsilon / 2 + 1 / (4 n epsilon^2) <= epsilon, "if we choose" n >= 1/(2 epsilon delta^2)
$


== The Moment Problem
*Question:* Do moments $m_k = E[X^k] < oo$ for all $k >= 1$, uniquely identify the distribution of $X$?
In other words, if $E[X^k] = E[Y^k]$ for all $k >= 1$, are $X$ and $Y$ always identically distributed?

- *If $X$ takes values from a finite set: YES.*
  We can solve this by setting up a linear system (using the Vandermonde matrix):
  $
    mat(
      x_1, x_2, dots, x_n;
      x_1^2, x_2^2, dots, x_n^2;
      dots.v, dots.v, dots.down, dots.v;
      x_1^n, x_2^n, dots, x_n^n
    ) vec(p_1, p_2, dots.v, p_n) = vec(m_1, m_2, dots.v, m_n)
  $
  Since all $x_i$ are distinct, the matrix is invertible, yielding a unique probability vector $p$.

- *Moment Generating Function (MGF):* To address the general case, we define the MGF of a random variable $X$ as:
  $ M_X (t) = E[e^(t X)] $

  By expanding $e^(t X)$ using the Maclaurin series, we can connect the MGF to the moments:
  $ M_X (t) = E[e^(t X)] = sum_(k>=0) (t^k E[X^k]) / k! $

  - *Convergence:* The MGF $M_X (t)$ is convergent if the moment sequence $E[X^k]$ does not grow too fast.
  - *Moment Extraction:* The $k$-th moment is given by $E[X^k] = M_X^((k))(0)$, where $M_X^((k))$ is the $k$-th derivative of $M_X$ evaluated at $t = 0$.

- *Uniqueness Theorem:* If $X$ and $Y$ have the same moment generating function, specifically if $M_X (t) = M_Y (t)$ for all $t in (-epsilon, epsilon)$ for some $epsilon > 0$, then $X$ and $Y$ are identically distributed.

== Poisson Tails
$X ~ Pois(lambda)$.
Tail inequalites for $X ~ Pois(lambda)$
$
  k > lambda => Pr(X >= k) <= e^(-lambda) ((e lambda) / k)^k \
  k < lambda => Pr(X <= k) <= e^(-lambda) ((e lambda) / k)^k
$
- But use Chebyshev
$
  Pr[abs(X - lambda) >= abs(k - lambda)] <= Var[X] / (k - lambda)^2 = lambda / (k - lambda)^2
$
- use MGF
$
  M_X (t) = E[e^(t X)] = sum_(k=o)^oo e^(t k) (e^lambda lambda^k) / k! = e^(lambda(e^t - 1)) sum e^(-lambda e^t) (lambda e^t)^k / k! = e^(lambda(e^t - 1))
$

== Cramer-Chernoff Method (Chernoff Bound)
$
  M_X (t)= e^(lambda(e^t - 1))
$
$
  Pr(X >= k) & = Pr(e^(t X) >= e^(t k)) blu((forall t > 0)) > <=^("Markov") E[e^(t X)] / e^(t k ) \
           = & e^(lambda (e^t - 1) - t k) <=^(f'(t) = 0) e^(-lambda) ((e lambda) / k)^k
$
Same, $Pr(X < k)$, let $t < 0$.

