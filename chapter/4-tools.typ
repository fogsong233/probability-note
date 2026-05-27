#import "../util.typ": *

= Tools

== Factorial Approximation
#panel[Stirling Formula][
  For large $n$,
  $
    n! tilde sqrt(2 pi n) (n/e)^n
  $
  A useful two-sided estimate is
  $
    sqrt(2 pi n) (n/e)^n e^(1/(12n+1)) < n! < sqrt(2 pi n) (n/e)^n e^(1/(12n))
  $
  In logarithmic form,
  $
    log(n!) = n log n - n + 1/2 log(2 pi n) + O(1/n)
  $
]

#panel[Crude Factorial Bounds][
  Often the following are enough:
  $
    (n/e)^n <= n! <= n^n
  $
  and, from Stirling,
  $
    n! = Theta(sqrt(n) (n/e)^n)
  $
]

== Binomial Coefficient Inequalities
#panel[Single Coefficient Bounds][
  For $1 <= k <= n$,
  $
    (n/k)^k <= binom(n, k) <= n^k / k! <= (e n / k)^k
  $
  The left bound follows from
  $
    binom(n,k) = product_(i=1)^k (n-k+i)/i >= product_(i=1)^k n/k = (n/k)^k
  $
  since $(n-k+i)/i >= n/k$. The upper bound uses $k! >= (k/e)^k$.
]

#panel[Binomial Tail Count][
  For $1 <= k <= n$,
  $
    sum_(i=0)^k binom(n, i) <= (e n / k)^k
  $
  A quick proof is to use $binom(n,i) <= n^i / i!$ and
  $
    sum_(i=0)^k n^i / i! <= (e n / k)^k
  $
  This bound is especially useful for union bounds over all subsets of size at most $k$.
]

#panel[Central and Symmetry Bounds][
  $
    binom(n,k) = binom(n,n-k), quad binom(n,k) <= 2^n
  $
  Also,
  $
    binom(n, floor(n/2)) = Theta(2^n / sqrt(n))
  $
  by Stirling's formula.
]

== Binomial Coefficient Sums
#panel[Basic Identities][
  Binomial theorem:
  $
    sum_(k=0)^n binom(n,k) x^k y^(n-k) = (x+y)^n
  $
  In particular,
  $
    sum_(k=0)^n binom(n,k) = 2^n, quad sum_(k=0)^n (-1)^k binom(n,k) = 0
  $
]

#panel[Weighted Sums][
  Differentiate the binomial theorem:
  $
    sum_(k=0)^n k binom(n,k) = n 2^(n-1)
  $
  and
  $
    sum_(k=0)^n k(k-1) binom(n,k) = n(n-1) 2^(n-2)
  $
  Hence
  $
    sum_(k=0)^n k^2 binom(n,k) = n(n+1) 2^(n-2)
  $
]

#panel[Hockey-stick and Vandermonde][
  Hockey-stick identity:
  $
    sum_(i=r)^n binom(i,r) = binom(n+1,r+1)
  $
  Vandermonde's identity:
  $
    sum_i binom(r,i) binom(s,n-i) = binom(r+s,n)
  $
]

== Power-Geometric Sums
For $abs(q) < 1$, let
$
  S_t(q) = sum_(k >= 0) k^t q^k
$
and define the operator $D = q dif/q dif q$. Since $D(q^k) = k q^k$,
$
  S_t(q) = D^t (1/(1-q))
$

#panel[First Orders][
  $
    S_0(q) & = sum_(k >= 0) q^k = 1/(1-q) \
    S_1(q) & = sum_(k >= 0) k q^k = q/(1-q)^2 \
    S_2(q) & = sum_(k >= 0) k^2 q^k = q(1+q)/(1-q)^3 \
    S_3(q) & = sum_(k >= 0) k^3 q^k = q(1+4q+q^2)/(1-q)^4 \
    S_4(q) & = sum_(k >= 0) k^4 q^k = q(1+11q+11q^2+q^3)/(1-q)^5
  $
]

#panel[Shifted Geometric Sums][
  For sums starting at $k = 1$, the same formulas hold because the $k=0$ term is $0$ for $t >= 1$:
  $
    sum_(k >= 1) k^t q^k = S_t(q), quad t >= 1
  $
  If the exponent is shifted,
  $
    sum_(k >= 1) k^t q^(k-1) = S_t(q) / q, quad q != 0
  $
]
