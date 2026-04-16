#import "util.typ": *
#set page(
  paper: "a4",
  margin: (x: 28mm, top: 26mm, bottom: 24mm),
  fill: paper,
  footer: context align(center)[
    #text(font: "Baskerville", size: 9pt, fill: muted)[#counter(page).display("1")]
  ],
)
#set text(
  font: ("Libertinus Serif", "New Computer Modern Math", "Songti SC"),
  size: 12pt,
  fill: ink,
  lang: "en",
)
#set par(justify: true, leading: 0.72em)
#set heading(numbering: none)

#show heading.where(level: 1): it => block(above: 0pt, below: 1.6em)[
  #text(font: "Cochin", size: 20pt, fill: ink, tracking: 0.04em)[#it.body]
  #v(0.45em)
  #line(length: 100%, stroke: (paint: rule, thickness: 0.7pt))
]
#set heading(numbering: "1.1")

#show heading.where(level: 2): it => {
  counter(math.equation).update(0)
  let h = counter(heading).at(it.location())
  block(above: 2em, below: 1.25em)[
    #text(font: "Baskerville", size: 12pt, fill: muted, tracking: 0.08em)[#h.at(0).#h.at(1)]
    #text(font: "Baskerville", size: 14pt, weight: "semibold", fill: ink, tracking: 0.04em)[#it.body]
  ]
}


#show math.equation.where(block: true): set math.equation(numbering: eq-numbering)

#text(size: 24pt, weight: "bold", font: "Snell Roundhand")[
  Probability Theory &  \
  Mathematical Statistics
  #text(size: 12pt, font: "Songti TC")[
    概率论和数理统计
  ]
]
#v(20%)

#include "chapter/1-prob_space.typ"
#include "chapter/2-rand_var.typ"

#v(10%)
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

== Chebyshev's Inequality
$
  Pr(|X-EE[X]| >= a) <= Var[X] / a^2
$
#coroll[
  $Pr(|X-EE[X]| >= k sigma) <= 1/k^2$
]

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
