#import "../util.typ": *

= Limit Theorems
设 $X_1, X_2, dots.c$ 是 i.i.d. random variables (独立同分布随机变量)，并且
$
  mu = EE[X_1], quad Var[X_1] = sigma^2
$
记
$
  overline(X)_n = 1/n sum_(i=1)^n X_i
$
为 *sample mean* (样本均值).

#theoremof[Law of Large Numbers (LLN), 大数定律][
  *Law of Large Numbers* 的核心结论是：sample mean 会收敛到 expectation (期望).
  $
    overline(X)_n -> mu quad "as" n -> oo
  $
  根据收敛意义不同，它分成两个常见版本：
  $
    "weak LLN:" overline(X)_n ->^P mu,
    quad
    "strong LLN:" overline(X)_n ->^("a.s.") mu
  $
]

#theoremof[Central Limit Theorem (CLT), 中心极限定理][
  *Central Limit Theorem* 说的是：把 sample mean 去中心化、再按标准差尺度放大后，
  极限分布是 standard normal distribution (标准正态分布).
  $
    Z_n = (overline(X)_n - mu)/(sigma / sqrt(n))
    ->^D N(0, 1)
    quad "as" n -> oo
  $
]


== Convergence 收敛

对 ordinary sequence (普通数列) $a_1, a_2, dots.c in RR$,
$
      & a_n -> a \
  <=> & forall epsilon > 0, exists N, "s.t." forall n >= N,
        abs(a_n - a) < epsilon
$
这只是说：给定任意误差尺度 $epsilon$, 从某个 $N$ 之后所有项都落在
$(a - epsilon, a + epsilon)$ 内。

对 function sequence (函数列) $f_1, f_2, dots.c : Omega -> RR$,
*pointwise convergence* (逐点收敛) 到 $f$ 指
$
  forall omega in Omega, quad lim_(n -> oo) f_n(omega) = f(omega)
$

random variable (随机变量) 本身也是函数：
$
  X_n: Omega -> RR, quad X: Omega -> RR
$
但它还诱导一个 CDF (cumulative distribution function, 分布函数)：
$
  F_(X_n): RR -> [0, 1], quad F_X: RR -> [0, 1]
$
因此讨论 $X_n -> X$ 时有两条路线：
$
  "比较样本点上的函数值" X_n(omega)
  quad "或比较分布函数" F_(X_n)(x)
$
这正是多种 convergence modes (收敛模式) 的来源。

#example[
  *Coin bits to uniform* (硬币二进制展开到均匀分布). 设 $B_1, B_2, dots.c$
  是 i.i.d. $"Bern"(1/2)$, 定义
  $
    U_n = sum_(j=1)^n B_j / 2^j,
    quad
    U = sum_(j=1)^oo B_j / 2^j
  $
  则
  $
    abs(U - U_n) <= sum_(j=n+1)^oo 2^(-j) = 2^(-n),
  $
  所以 $U_n ->^("a.s.") U$.

  对任意长度为 $2^(-m)$ 的 dyadic interval (二进区间), 前 $m$ 个 bit 必须等于某个
  固定二进制串，概率正好是 $2^(-m)$. 因此 $U$ 的分布是 $U[0,1]$.
  唯一要小心的是 dyadic endpoints (二进端点) 有两种展开，但这些点是 countable set,
  概率为 $0$.
]

=== Modes of Convergence

以下都假设 $X, X_1, X_2, dots.c$ 是同一 probability space (概率空间)
$(Omega, cal(F), Pr)$ 上的 random variables.

#defn[convergence in distribution / in law, 依分布收敛][
  $
        & X_n ->^D X \
    <=> & F_(X_n)(x) -> F_X(x)
          quad "for every continuity point (连续点)" x "of" F_X
  $
  它也叫 *weak convergence of measures* (测度弱收敛). 重点是：这里只看 distribution (分布)，
  不关心 $X_n$ 和 $X$ 在同一个样本点 $omega$ 上是否接近。
]

#defn[convergence in probability, 依概率收敛][
  $
        & X_n ->^P X \
    <=> & forall epsilon > 0,
          quad Pr(abs(X_n - X) > epsilon) -> 0
  $
  也就是说：对任意固定误差 $epsilon$, “偏差超过 $epsilon$” 的概率趋于 $0$.
  从函数角度看，它是 convergence in measure (依测度收敛).
]

#defn[almost sure convergence, 几乎必然收敛][
  $
        & X_n ->^("a.s.") X \
    <=> & exists A in cal(F), Pr(A) = 1,
          "and" forall omega in A,
          lim_(n -> oo) X_n(omega) = X(omega)
  $
  等价地，
  $
    Pr(lim_(n -> oo) X_n = X) = 1
  $
  它是“除去一个 probability $0$ 的坏集合后，逐点收敛”。
]

#panel[Three modes, 三种模式][
  $
    X_n ->^D X:
    "分布形状收敛"
    quad
    F_(X_n) -> F_X
  $
  $
    X_n ->^P X:
    "绝大多数样本点上接近"
    quad
    Pr(abs(X_n-X)>epsilon) -> 0
  $
  $
    X_n ->^("a.s.") X:
    "几乎每条样本路径最终都接近"
  $
]

=== Convergence in Distribution

definition 中只要求在 $F_X$ 的 continuity points (连续点) 上收敛，这是必要的。
考虑 $X_n ~ U(0, 1/n)$, 令 $X = 0$ 以概率 $1$ 成立。则
$
  F_(X_n)(x) =
  cases(
    0 quad x <= 0,
    n x quad 0 < x < 1/n,
    1 quad x >= 1/n,
  )
$
而
$
  F_X(x) =
  cases(
    0 quad x < 0,
    1 quad x >= 0.
  )
$
对每个 $x != 0$, 都有 $F_(X_n)(x) -> F_X(x)$, 因而 $X_n ->^D X$.
但在 $x=0$ 处，
$
  F_(X_n)(0) = 0 " while " F_X(0) = 1
$
所以如果强行要求所有点都收敛，依分布收敛就会被错误排除。

#panel[Distribution only][
  convergence in distribution 只依赖 distribution:
  $
    X_n ->^D X " 且 " F_X = F_Y
    quad => quad
    X_n ->^D Y
  $
  换句话说，只要 $X$ 和 $Y$ 同分布，它们作为极限在 $->^D$ 下没有区别。
]

#example[
  依分布收敛不推出依概率收敛。设 $X ~ U[0,1]$, 且对所有 $n$ 令
  $
    X_n = 1 - X
  $
  因为 $1-X ~ U[0,1]$, 所以
  $
    F_(X_n) = F_X quad "for all" n,
  $
  从而 $X_n ->^D X$. 但是
  $
    Pr(abs(X_n - X) > 1/4)
    = Pr(abs(1 - 2X) > 1/4)
    = 3/4
  $
  对所有 $n$ 都不变，因此不可能 $X_n ->^P X$.
]

=== Convergence in Probability

#theoremof[$X_n ->^P X$ implies $X_n ->^D X$][
  convergence in probability 比 convergence in distribution 更强：
  $
    X_n ->^P X quad => quad X_n ->^D X
  $
]

#proofblock[
  固定 $epsilon > 0$. 对任意 $x in RR$,
  $
    {X_n <= x} subset.eq {X <= x + epsilon} union {abs(X_n-X) > epsilon}
  $
  原因是：若 $X_n <= x$ 且 $abs(X_n-X) <= epsilon$, 则 $X <= x + epsilon$.
  因此
  $
    F_(X_n)(x) <= F_X(x + epsilon) + Pr(abs(X_n-X) > epsilon)
  $
  同理，
  $
    {X <= x - epsilon} subset.eq {X_n <= x} union {abs(X_n-X) > epsilon},
  $
  所以
  $
    F_X(x - epsilon) - Pr(abs(X_n-X) > epsilon)
    <= F_(X_n)(x)
  $
  令 $n -> oo$, 由于 $X_n ->^P X$,
  $
    F_X(x - epsilon)
    <= liminf_(n -> oo) F_(X_n)(x)
    <= limsup_(n -> oo) F_(X_n)(x)
    <= F_X(x + epsilon)
  $
  如果 $F_X$ 在 $x$ 连续，再令 $epsilon -> 0^+$, 得
  $
    F_X(x - epsilon) -> F_X(x),
    quad
    F_X(x + epsilon) -> F_X(x)
  $
  夹逼即得 $F_(X_n)(x) -> F_X(x)$.
]

#theoremof[Convergence to a constant, 常数极限][
  如果极限是常数 $c in RR$, 那么
  $
    X_n ->^D c quad => quad X_n ->^P c
  $
]

#proofblock[
  常数 $c$ 的 CDF 是
  $
    F_c(x) =
    cases(
      0 quad x < c,
      1 quad x >= c.
    )
  $
  对任意 $epsilon > 0$, $c - epsilon$ 和 $c + epsilon$ 都是 $F_c$ 的连续点，
  所以
  $
    F_(X_n)(c - epsilon) -> 0,
    quad
    F_(X_n)(c + epsilon) -> 1
  $
  因而
  $
    Pr(abs(X_n-c) > epsilon)
    <= Pr(X_n <= c - epsilon) + Pr(X_n > c + epsilon)
  $
  $
    = F_(X_n)(c - epsilon) + 1 - F_(X_n)(c + epsilon)
    -> 0
  $
  这正是 $X_n ->^P c$.
]

=== Almost Sure Convergence

事件“$X_n$ 收敛到 $X$”可以写成 countable set operations (可数集合运算)：
$
  {lim_(n -> oo) X_n = X}
  =
  inter_(m=1)^oo union_(n_0=1)^oo inter_(n=n_0)^oo
  {abs(X_n - X) <= 1/m}
$
含义是：对每个精度 $1/m$, 都存在某个时刻 $n_0$, 之后所有 $X_n$ 都在这个精度内。

== Borel-Cantelli Lemmas

设 $A_1, A_2, dots.c$ 是一列 events (事件). 定义
$
  {A_n " infinitely often"}
  =
  inter_(n=1)^oo union_(m=n)^oo A_m
$
记作 $A_n$ i.o. (infinitely often, 无穷多次发生).

#theoremof[Borel-Cantelli I, 第一引理][
  如果
  $
    sum_(n=1)^oo Pr(A_n) < oo,
  $
  那么
  $
    Pr(A_n " i.o.") = 0
  $
]

#proofblock[
  由 union bound (并集界),
  $
    Pr(union_(m=n)^oo A_m) <= sum_(m=n)^oo Pr(A_m)
  $
  若 $sum_n Pr(A_n)$ 收敛，则 tail sum (尾和) 满足
  $
    sum_(m=n)^oo Pr(A_m) -> 0
  $
  令 $B_n = union_(m=n)^oo A_m$. 这是一列 decreasing events (递减事件), 且
  $
    inter_(n=1)^oo B_n = {A_n " i.o."}
  $
  由 continuity from above,
  $
    Pr(A_n " i.o.")
    = lim_(n -> oo) Pr(B_n)
    <= lim_(n -> oo) sum_(m=n)^oo Pr(A_m)
    = 0
  $
]

#theoremof[Borel-Cantelli II, 第二引理][
  如果 $A_1, A_2, dots.c$ independent (相互独立), 且
  $
    sum_(n=1)^oo Pr(A_n) = oo,
  $
  那么
  $
    Pr(A_n " i.o.") = 1
  $
]

#proofblock[
  固定 $n$ 和 $N > n$. 由 independence,
  $
    Pr(inter_(m=n)^N A_m^c)
    = product_(m=n)^N (1 - Pr(A_m))
    <= exp(- sum_(m=n)^N Pr(A_m))
  $
  这里用到 $1-u <= e^(-u)$. 因为级数发散，令 $N -> oo$ 得
  $
    Pr(inter_(m=n)^oo A_m^c) = 0
  $
  又
  $
    {A_n " i.o."}^c
    =
    union_(n=1)^oo inter_(m=n)^oo A_m^c
  $
  是 countable union (可数并) 的 null events (零概率事件), 所以概率仍为 $0$.
  因而 $Pr(A_n " i.o.") = 1$.
]

#panel[Continuity of probability measures, 概率测度连续性][
  若 $B_1 subset.eq B_2 subset.eq dots.c$ 且 $B = union_(n=1)^oo B_n$, 则
  $
    Pr(B) = lim_(n -> oo) Pr(B_n)
  $
  证明思路是把 $B$ 写成 disjoint union (不交并)：
  $
    B = B_1 union (B_2 - B_1) union (B_3 - B_2) union dots.c
  $
  然后概率求和 telescope (望远镜相消).

  若 $C_1 supset.eq C_2 supset.eq dots.c$ 且 $C = inter_(n=1)^oo C_n$, 则
  $
    Pr(C) = lim_(n -> oo) Pr(C_n)
  $
  这是对 complements (补集) 使用递增情形得到的。
]

#theoremof[Lemma: a.s. convergence implies convergence in probability][
  almost sure convergence 比 convergence in probability 更强：
  $
    X_n ->^("a.s.") X quad => quad X_n ->^P X
  $
]

#proofblock[
  固定任意 $epsilon > 0$, 令
  $
    A_n(epsilon)
    =
    {omega in Omega : abs(X_n(omega) - X(omega)) > epsilon}
  $
  这里 $A_n(epsilon)$ 是第 $n$ 步偏离超过 $epsilon$ 的 bad event (坏事件).

  若 $X_n(omega) -> X(omega)$, 这里的 $->$ 是 ordinary pointwise convergence
  (普通逐点收敛), 则对这个 $epsilon$ 存在 $n_0=n_0(omega,epsilon)$, 使得所有
  $m >= n_0$ 都满足 $omega in A_m(epsilon)^c$. 因此
  $
    {omega in Omega : lim_(n -> oo) X_n(omega) = X(omega)}
    subset.eq
    union_(n=1)^oo inter_(m=n)^oo A_m(epsilon)^c
  $

  假设 $X_n ->^("a.s.") X$, 即
  $
    Pr(lim_(n -> oo) X_n = X) = 1
  $
  由上面的包含关系，
  $
    1
    =
    Pr(lim_(n -> oo) X_n = X)
    <=
    Pr(union_(n=1)^oo inter_(m=n)^oo A_m(epsilon)^c)
    <= 1
  $
  所以
  $
    Pr(union_(n=1)^oo inter_(m=n)^oo A_m(epsilon)^c) = 1
  $
  取 complement (补集), 得
  $
    0
    =
    Pr(inter_(n=1)^oo union_(m=n)^oo A_m(epsilon))
  $
  令
  $
    B_n(epsilon) = union_(m=n)^oo A_m(epsilon)
  $
  则 $B_1(epsilon) supset.eq B_2(epsilon) supset.eq dots.c$. 由上面的
  probability continuity from above (概率测度上连续性),
  $
    0
    =
    Pr(inter_(n=1)^oo B_n(epsilon))
    =
    lim_(n -> oo) Pr(B_n(epsilon))
    =
    lim_(n -> oo) Pr(union_(m=n)^oo A_m(epsilon))
  $
  最后，
  $
    Pr(abs(X_n-X) > epsilon)
    =
    Pr(A_n(epsilon))
    <=
    Pr(union_(m=n)^oo A_m(epsilon))
    -> 0
  $
  因为 $epsilon > 0$ 任意，所以 $X_n ->^P X$.
]

#theoremof[A useful condition for a.s. convergence, 几乎必然收敛判别][
  如果
  $
    forall epsilon > 0,
    quad sum_(n=1)^oo Pr(abs(X_n-X) > epsilon) < oo,
  $
  那么
  $
    X_n ->^("a.s.") X
  $
]

#proofblock[
  对每个整数 $k >= 1$, 把 Borel-Cantelli I 用在
  $
    A_n(1/k) = {abs(X_n-X) > 1/k}
  $
  上，得到
  $
    Pr(A_n(1/k) " i.o.") = 0
  $
  对 $k$ 再做 countable union, 概率仍为 $0$. 在这个零概率坏集合之外，
  对每个 $k$ 都存在 $N_k$, 使得
  $
    n >= N_k => abs(X_n-X) <= 1/k
  $
  这就等价于 $X_n(omega) -> X(omega)$.
]

#example[
  *In probability does not imply a.s.* (依概率不推出几乎必然). 设
  $X_n ~ "Bern"(1/n)$ 且相互独立。对任意 $epsilon in (0,1)$,
  $
    Pr(abs(X_n-0) > epsilon) = Pr(X_n = 1) = 1/n -> 0,
  $
  所以 $X_n ->^P 0$. 但是
  $
    sum_(n=1)^oo Pr(X_n = 1) = sum_(n=1)^oo 1/n = oo
  $
  由 Borel-Cantelli II,
  $
    Pr(X_n = 1 " i.o.") = 1
  $
  因此几乎每条样本路径上都会出现无穷多个 $1$, 不可能几乎必然收敛到 $0$.
]

== Strength of Convergence

#panel[Main implication chain, 强弱关系][
  $
    X_n ->^("a.s.") X
    quad => quad
    X_n ->^P X
    quad => quad
    X_n ->^D X
  $
  一般来说两个箭头都不能反过来。唯一常用例外是 constant limit (常数极限)：
  $
    X_n ->^D c
    quad => quad
    X_n ->^P c
  $
]

=== Coupling and Continuous Mapping

#theoremof[Skorokhod representation, 斯科罗霍德表示][
  若 $X_n ->^D X$, 则可以在另一个 probability space 上构造
  $Y_1, Y_2, dots.c, Y$, 使得
  $
    F_(Y_n) = F_(X_n), quad F_Y = F_X,
    quad "and" quad
    Y_n ->^("a.s.") Y
  $
]

#proofblock[
  用 inverse transform sampling (反函数抽样). 取新空间为 $([0,1], cal(B), "Leb")$,
  对 $u in [0,1]$ 定义
  $
    Y_n(u) = inf {x in RR : u <= F_(X_n)(x)},
    quad
    Y(u) = inf {x in RR : u <= F_X(x)}
  $
  则 $Y_n$ 与 $X_n$ 同分布，$Y$ 与 $X$ 同分布。由 $F_(X_n) -> F_X$ 在连续点上的收敛，
  可以验证 $Y_n(u) -> Y(u)$ 在 $Y$ 的 quantile map (分位函数) 连续点成立。
  不连续点集合至多可数或为 null set, 因而得到 almost sure convergence.
]

#theoremof[Continuous Mapping Theorem, 连续映射定理][
  若 $g: RR -> RR$ continuous (连续), 则
  $
    X_n ->^D X => g(X_n) ->^D g(X)
  $
  $
    X_n ->^P X => g(X_n) ->^P g(X)
  $
  $
    X_n ->^("a.s.") X => g(X_n) ->^("a.s.") g(X)
  $
]

#proofblock[
  a.s. 情形最直接：若 $X_n(omega) -> X(omega)$ 且 $g$ 连续，则
  $
    g(X_n(omega)) -> g(X(omega))
  $

  probability 情形可以理解为同一个思路加上 compact control (紧集控制)：
  固定 $M$, 在 $[-M,M]$ 上连续函数一致连续，所以存在 $delta$, 使
  $abs(x-y) < delta$ 推出 $abs(g(x)-g(y)) < epsilon$. 再把事件分成
  “$X$ 落在 $[-M,M]$ 内” 与 “$X_n$ 和 $X$ 足够接近” 两部分控制，最后令 $M -> oo$.

  distribution 情形用 Skorokhod representation：选取同分布的 $Y_n, Y$ 使
  $Y_n ->^("a.s.") Y$. 由 a.s. 情形得到 $g(Y_n) ->^("a.s.") g(Y)$, 于是
  $g(Y_n) ->^D g(Y)$. 因为分布一致，结论转回 $g(X_n)$.
]

=== Other Convergence Modes

#defn[convergence in mean and $L^r$, 均值收敛][
  $X_n ->^1 X$ 表示 convergence in mean (均值收敛)：
  $
    EE[abs(X_n-X)] -> 0
  $
  更一般地，对 $r >= 1$, $X_n ->^r X$ 表示 convergence in $L^r$ (按 $r$ 阶均值收敛)：
  $
    EE[abs(X_n-X)^r] -> 0
  $
]

#panel[$L^r$ implications, $L^r$ 收敛的推出关系][
  Markov's inequality (马尔可夫不等式) 给出
  $
    Pr(abs(X_n-X) > epsilon)
    <= EE[abs(X_n-X)^r] / epsilon^r
  $
  因此
  $
    X_n ->^r X => X_n ->^P X
  $
  若 $s >= r >= 1$, 则由 Jensen/Hölder inequality,
  $
    EE[abs(X_n-X)^r] <= EE[abs(X_n-X)^s]^(r/s)
  $
  所以
  $
    X_n ->^s X => X_n ->^r X
  $
]

== Characteristic Functions

*moment generating function* (MGF, 矩母函数) 定义为
$
  M_X(t) = EE[e^(t X)]
$
但它未必在 $t=0$ 附近有限。

*characteristic function* (特征函数) 定义为
$
  phi_X(t) = EE[e^(i t X)],
  quad i^2 = -1
$
它总是存在，因为 $abs(e^(i t X)) = 1$.

#panel[Fourier viewpoint, Fourier 视角][
  $
    phi_X(t)
    = integral_(-oo)^oo e^(i t x) dif F_X(x)
    = EE[cos(t X)] + i EE[sin(t X)]
  $
  如果 $X$ 有 density (密度) $f_X$, 则
  $
    phi_X(t) = integral_(-oo)^oo e^(i t x) f_X(x) dif x
  $
  也就是说 characteristic function 是 distribution 的 Fourier transform (傅里叶变换).
]

#theoremof[Basic bounds and Taylor expansion, 基本界与展开][
  对任意 random variable $X$,
  $
    abs(phi_X(t)) <= 1
  $
  如果 $EE[abs(X)^k] < oo$, 则当 $t -> 0$ 时
  $
    phi_X(t)
    =
    sum_(j=0)^k (EE[X^j] / j!) (i t)^j
    + o(t^k)
  $
  特别地，如果 $EE[abs(X)] < oo$,
  $
    phi_X(t) = 1 + i mu t + o(t)
  $
  如果 $EE[X^2] < oo$,
  $
    phi_X(t)
    = 1 + i mu t - (EE[X^2] / 2) t^2 + o(t^2)
  $
]

#proofblock[
  boundedness 来自 triangle inequality:
  $
    abs(phi_X(t))
    = abs(EE[e^(i t X)])
    <= EE[abs(e^(i t X))]
    = 1
  $
  对 expansion (展开), 使用 Taylor formula (泰勒公式):
  $
    e^(i t X)
    =
    sum_(j=0)^k (i t X)^j / j!
    + R_k(t X)
  $
  其中当 $u -> 0$ 时 $R_k(u) = o(abs(u)^k)$. 若 $EE[abs(X)^k] < oo$,
  dominated convergence (控制收敛) 允许对余项取期望：
  $
    EE[R_k(t X)] = o(t^k)
  $
]

#panel[Standardized expansion, 标准化后的展开][
  若
  $
    Y = (X - mu) / sigma,
    quad EE[Y] = 0,
    quad EE[Y^2] = 1,
  $
  则
  $
    phi_Y(t) = 1 - t^2/2 + o(t^2)
  $
  这正是 CLT 证明中每个 summand (求和项) 需要的局部展开。
]

=== Normal Characteristic Function

#theoremof[Normal characteristic function, 正态特征函数][
  若 $Z ~ N(0,1)$, 则
  $
    phi_Z(t) = EE[e^(i t Z)] = e^(-t^2/2)
  $
]

#proofblock[
  因为 $Z$ 的 density 是 even function (偶函数), imaginary part 为 $0$:
  $
    phi_Z(t)
    = 1/sqrt(2 pi) integral_(-oo)^oo cos(t x) e^(-x^2/2) dif x
  $
  对 $t$ 求导：
  $
    phi'_Z(t)
    =
    - 1/sqrt(2 pi) integral_(-oo)^oo x sin(t x) e^(-x^2/2) dif x
  $
  又因为 $dif(e^(-x^2/2)) = - x e^(-x^2/2) dif x$, integration by parts (分部积分) 给出
  $
    integral_(-oo)^oo x sin(t x) e^(-x^2/2) dif x
    =
    t integral_(-oo)^oo cos(t x) e^(-x^2/2) dif x
  $
  因此
  $
    phi'_Z(t) = - t phi_Z(t)
  $
  解这个 ODE (常微分方程), 并用初值 $phi_Z(0) = 1$, 得
  $
    phi_Z(t) = e^(-t^2/2)
  $
]

#panel[Linear transformation and sums, 线性变换与独立和][
  如果 $Y = a X + b$, 则
  $
    phi_Y(t)
    = EE[e^(i t (a X + b))]
    = e^(i t b) phi_X(a t)
  $
  如果 $X$ 和 $Y$ independent, 则
  $
    phi_(X+Y)(t)
    = EE[e^(i t X) e^(i t Y)]
    = EE[e^(i t X)] EE[e^(i t Y)]
    = phi_X(t) phi_Y(t)
  $
]

#theoremof[Lévy Continuity Theorem, 连续性定理][
  对 random variables $X_n$ 和 $X$,
  $
    X_n ->^D X
    quad <=> quad
    forall t in RR, phi_(X_n)(t) -> phi_X(t)
  $
]

#note[
  更一般地，如果 $phi_(X_n)(t)$ pointwise converges (逐点收敛) 到某个 $phi(t)$,
  且 $phi$ 在 $0$ 连续，那么 $phi$ 是某个 distribution 的 characteristic function,
  并且 $X_n$ 依分布收敛到该 distribution.
]

#example[
  *Convolution of normal distributions* (正态分布卷积). 若
  $
    X ~ N(mu, sigma^2),
    quad
    Y ~ N(nu, tau^2)
  $
  independent, 则
  $
    X + Y ~ N(mu + nu, sigma^2 + tau^2)
  $
  证明只需要 characteristic function. 设 $Z ~ N(0,1)$, 则
  $
    phi_X(t)
    = e^(i t mu) phi_Z(sigma t)
    = e^(i t mu - sigma^2 t^2 / 2)
  $
  同理
  $
    phi_Y(t) = e^(i t nu - tau^2 t^2 / 2)
  $
  由 independence,
  $
    phi_(X+Y)(t)
    = phi_X(t) phi_Y(t)
    = e^(i t (mu+nu) - (sigma^2 + tau^2) t^2 / 2),
  $
  这正是 $N(mu+nu, sigma^2+tau^2)$ 的 characteristic function.
]

== Law of Large Numbers

=== Bernoulli's Law of Large Numbers

#theoremof[Bernoulli LLN, 伯努利大数定律][
  设 $X_1, X_2, dots.c$ 是 i.i.d. $"Bern"(p)$, 并令
  $
    overline(X)_n = (X_1 + dots.c + X_n)/n
  $
  则对任意 $epsilon > 0$,
  $
    Pr(abs(overline(X)_n - p) > epsilon) -> 0
  $
  即 $overline(X)_n ->^P p$.
]

#proofblock[
  因为 $EE[X_i] = p$ 且 $Var[X_i] = p(1-p)$,
  $
    EE[overline(X)_n] = p,
    quad
    Var[overline(X)_n]
    = 1/n^2 sum_(i=1)^n Var[X_i]
    = p(1-p)/n
  $
  由 Chebyshev's inequality (切比雪夫不等式),
  $
    Pr(abs(overline(X)_n-p) > epsilon)
    <= Var[overline(X)_n] / epsilon^2
    = p(1-p)/(n epsilon^2)
    -> 0
  $
]

=== Weak LLN Assuming Bounded Variance

#theoremof[Weak LLN with bounded variance, 有界方差弱大数][
  设 $X_1, X_2, dots.c$ independent, 且
  $
    EE[X_i] = mu,
    quad
    Var[X_i] <= sigma^2 < oo
  $
  令 $overline(X)_n = 1/n sum_(i=1)^n X_i$. 则
  $
    overline(X)_n ->^P mu
  $
]

#proofblock[
  先算 expectation:
  $
    EE[overline(X)_n] = 1/n sum_(i=1)^n EE[X_i] = mu
  $
  independence 使 covariance terms 消失：
  $
    Var[overline(X)_n]
    = 1/n^2 sum_(i=1)^n Var[X_i]
    <= sigma^2 / n
  $
  因此由 Chebyshev,
  $
    Pr(abs(overline(X)_n-mu) > epsilon)
    <= Var[overline(X)_n] / epsilon^2
    <= sigma^2/(n epsilon^2)
    -> 0
  $
]

=== Khinchin Weak LLN

#theoremof[Khinchin's Weak LLN, 辛钦弱大数定律][
  设 $X_1, X_2, dots.c$ i.i.d., 且只有 finite mean (有限均值)
  $EE[X_1] = mu$. 不要求 finite variance. 则
  $
    overline(X)_n ->^P mu
  $
]

#proofblock[
  因为 $EE[abs(X_1)] < oo$, characteristic function 有一阶展开：
  $
    phi_X(t) = 1 + i mu t + o(t)
    quad "as" t -> 0
  $
  对 sample mean,
  $
    phi_(overline(X)_n)(t)
    =
    phi_(X_1 + dots.c + X_n)(t/n)
    =
    product_(j=1)^n phi_X(t/n)
  $
  这里使用了 independence 和 identical distribution. 于是
  $
    phi_(overline(X)_n)(t)
    =
    (1 + i mu t/n + o(1/n))^n
    -> e^(i mu t)
  $
  右边是常数 random variable $mu$ 的 characteristic function. 由 Lévy theorem,
  $
    overline(X)_n ->^D mu
  $
  又因为极限是常数，所以
  $
    overline(X)_n ->^P mu
  $
]

=== Strong LLN

#theoremof[Kolmogorov Strong LLN, 柯尔莫哥洛夫强大数定律][
  设 $X_1, X_2, dots.c$ i.i.d., $EE[abs(X_1)] < oo$, 且
  $EE[X_1] = mu$. 则
  $
    overline(X)_n ->^("a.s.") mu
  $
]

#note[
  完整证明比 weak LLN 深：通常要 truncate (截断) 大值，用 maximal inequality (最大不等式)
  控制截断后的中心化和，再配合 Borel-Cantelli.

  直观差别是：
  $
    "weak LLN:" "每个固定的大" n "上偏差概率很小"
  $
  $
    "strong LLN:" "几乎每条样本路径上只发生有限次大偏差"
  $
]

#panel[A simple strong-law proof under a fourth moment, 四阶矩条件下的简单证明][
  额外假设 $EE[(X_1-mu)^4] < oo$. 令
  $
    Y_i = X_i - mu,
    quad
    S_n = sum_(i=1)^n Y_i
  $
  则 $EE[Y_i] = 0$ 且
  $
    overline(X)_n - mu = S_n/n
  $
  展开 $S_n^4$ 时，任何含有未配对 mean-zero 因子的项，期望都为 $0$. 因此只剩：
  $
    EE[S_n^4]
    =
    n EE[Y_1^4] + 6 binom(n, 2) EE[Y_1^2]^2
    = O(n^2)
  $
  由 Markov inequality,
  $
    Pr(abs(overline(X)_n-mu) > epsilon)
    =
    Pr(abs(S_n) > n epsilon)
    <= EE[S_n^4] / (n^4 epsilon^4)
    = O(1/n^2)
  $
  所以对每个 $epsilon > 0$,
  $
    sum_(n=1)^oo Pr(abs(overline(X)_n-mu) > epsilon) < oo
  $
  由前面的 a.s. convergence 判别法，得到
  $
    overline(X)_n ->^("a.s.") mu
  $
]

== De Moivre-Laplace Theorem

#theoremof[De Moivre-Laplace, 棣莫弗-拉普拉斯定理][
  设 $p in (0,1)$, $q = 1-p$, 且 $X_n ~ "Bin"(n,p)$. 则
  $
    (X_n - n p)/sqrt(n p q) ->^D N(0,1)
  $
]

#panel[Local normal approximation, 局部正态近似][
  对任意固定 $r > 0$, 当整数 $k$ 满足
  $
    abs(k - n p) / sqrt(n p q) <= r
  $
  时，有 uniform approximation (一致近似)
  $
    binom(n, k) p^k q^(n-k)
    =
    (1 + o(1))
    1/sqrt(2 pi n p q)
    exp(- (k - n p)^2 / (2 n p q))
  $
]

#proofblock[
  写
  $
    k = n p + x sqrt(n p q)
  $
  其中 $x$ bounded. 用 Stirling formula (斯特林公式)：
  $
    binom(n, k) p^k q^(n-k)
    =
    (n^n)/(k^k (n-k)^(n-k))
    p^k q^(n-k)
    dot
    sqrt(n/(2 pi k(n-k)))
    (1 + o(1))
  $
  取 logarithm (对数), 并代入
  $
    k/n = p + x sqrt(p q / n)
  $
  在最大点 $k = n p$ 附近，一阶项抵消，二阶项给出
  $
    - x^2 / 2
    =
    - (k - n p)^2 / (2 n p q)
  $
  前面的 square-root prefactor (平方根因子) 收敛到
  $1/sqrt(2 pi n p q)$. 这得到局部近似；再对标准化区间内的 $k$ 求和，
  就得到 distributional convergence 到 $N(0,1)$.
]

== Central Limit Theorem

#theoremof[Lindeberg-Levy CLT, 林德伯格-列维中心极限定理][
  设 $X_1, X_2, dots.c$ i.i.d., 且
  $
    EE[X_1] = mu,
    quad
    Var[X_1] = sigma^2 in (0, oo)
  $
  令
  $
    Z_n = (overline(X)_n - mu)/(sigma / sqrt(n))
    = 1/sqrt(n) sum_(j=1)^n (X_j - mu)/sigma
  $
  则
  $
    Z_n ->^D Z,
    quad Z ~ N(0,1)
  $
]

#proofblock[
  先把每个 summand (求和项) 标准化：
  $
    Y_j = (X_j - mu)/sigma,
    quad EE[Y_j] = 0,
    quad EE[Y_j^2] = 1
  $
  则
  $
    Z_n = (Y_1 + dots.c + Y_n)/sqrt(n)
  $
  $Y_j$ 的 characteristic function 满足
  $
    phi_Y(t) = 1 - t^2/2 + o(t^2)
    quad "as" t -> 0
  $
  由 independence,
  $
    phi_(Z_n)(t)
    =
    phi_(Y_1 + dots.c + Y_n)(t/sqrt(n))
    =
    product_(j=1)^n phi_Y(t/sqrt(n))
  $
  因为所有因子相同，
  $
    phi_(Z_n)(t)
    =
    (1 - t^2/(2n) + o(1/n))^n
    -> e^(-t^2/2)
  $
  而 $e^(-t^2/2)$ 正是 $N(0,1)$ 的 characteristic function. 由 Lévy continuity theorem,
  $
    Z_n ->^D N(0,1)
  $
]

#panel[Reading the normalization, 为什么这样标准化][
  总和的 expectation 和 variance 是
  $
    EE[sum_(i=1)^n X_i] = n mu,
    quad
    Var[sum_(i=1)^n X_i] = n sigma^2
  $
  因此自然的 centered and unit-variance variable (中心化且单位方差变量) 是
  $
    (sum_(i=1)^n X_i - n mu)/(sigma sqrt(n))
    =
    (overline(X)_n - mu)/(sigma / sqrt(n))
  $
  CLT 的意思是：这个标准化变量的极限分布是 standard normal.
]

=== Berry-Esseen Theorem

#theoremof[Berry-Esseen, 收敛速度][
  设 $X_1, X_2, dots.c$ i.i.d., 且
  $
    EE[X_1] = mu,
    quad
    Var[X_1] = sigma^2 > 0,
    quad
    rho = EE[abs(X_1-mu)^3] < oo
  $
  如果
  $
    Z_n = (overline(X)_n - mu)/(sigma/sqrt(n)),
  $
  则存在 absolute constant (绝对常数) $C$, 使得
  $
    sup_(z in RR) abs(Pr(Z_n <= z) - Phi(z))
    <= C rho / (sigma^3 sqrt(n))
  $
  其中 $Phi$ 是 $N(0,1)$ 的 CDF.
]

#note[
  CLT 只给出 asymptotic convergence (渐近收敛), Berry-Esseen theorem 给出误差速度。
  在 third absolute moment (三阶绝对矩) 有限时，典型误差阶是 $1/sqrt(n)$.
]
