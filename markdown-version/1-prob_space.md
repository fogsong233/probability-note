# 概率空间

## 样本空间与事件
样本空间 $\Omega$ 是实验所有可能结果组成的集合。

事件是 $\Omega$ 的一个子集 $A \subseteq \Omega$。

**定义 $\sigma$-代数**

若集合族 $\Sigma \subseteq 2^\Omega$ 满足下列条件，则称其为 $\sigma$-代数：
  $$
\begin{aligned}
& \emptyset \in \Sigma \\
& A \in \Sigma \Rightarrow A^c \in \Sigma \\
& A_1, A_2, \dots \in \Sigma \Rightarrow \bigcup_i A_i \in \Sigma, \text{可数个}
\end{aligned}
$$

对离散概率空间，概率质量函数（pmf）是映射
$$
p: \Omega \to [0, 1], \quad \sum_{\omega \in \Omega} p(\omega) = 1
$$
相应地，事件的概率定义为
$$
\Pr(A) = \sum_{\omega \in A} p(\omega)
$$

## 概率测度
**定义 概率测度**

概率测度是映射 $\Pr: \Sigma \to [0, 1]$，满足
  $$
\Pr(\Omega) = 1
$$
  并且对两两不交的事件 $A_1, A_2, \dots \in \Sigma$，
  $$
\Pr(\bigcup_i A_i) = \sum_i \Pr(A_i)
$$

三元组 $(\Omega, \Sigma, \Pr)$ 称为概率空间。

在有限均匀样本空间上，古典概率满足
$$
\Pr(A) = \lvert A \rvert / \lvert \Omega \rvert
$$
几何概率满足
$$
\Pr(A) = \operatorname{Vol}(A) / \operatorname{Vol}(\Omega)
$$

**例**

蒲丰投针问题。
  ![image](assets/image.png)

  若长度为 $\ell < d$ 的针被随机投到间距为 $d$ 的平行线上。
  $$
\begin{aligned}
& x \in [0, \pi]: \text{针与下方平行线的夹角} \\
& y \in [0, d/2]: \text{针的中心到最近平行线的距离}
\end{aligned}
$$
  取
  $$
\Omega = [0, \pi] \times [0, d / 2]
$$
  以及
  $$
A = \{ (x, y) \in \Omega : y \le \ell / 2 \sin x \}
$$
  可得
  $$
\Pr(A) = \operatorname{Vol}(A) / \operatorname{Vol}(\Omega) = 2 / (d \pi) \int_0^\pi \ell / 2 \sin x \, dx = 2 \ell / (d \pi)
$$

## 基本性质
下列结论都可由概率公理直接推出：
$$
\Pr(A^c) = 1 - \Pr(A)
$$
$$
\Pr(\emptyset) = 0
$$
$$
\Pr(A \setminus B) = \Pr(A) - \Pr(A \cap B)
$$
$$
A \subseteq B \Rightarrow \Pr(A) \le \Pr(B)
$$
$$
\Pr(A \cup B) = \Pr(A) + \Pr(B) - \Pr(A \cap B)
$$

**注**

“自然数是偶数的概率为 $1/2$”这一说法并不成立，因为这里无法先定义合适的 $\sigma$-field。
  但在 $[0, 1]$ 中，“有理数的概率为 $0$”是良定义的。

## 并集界
对事件 $A_1, \dots, A_n$，
$$
\Pr(\bigcup_{i=1}^n A_i) \le \sum_{i=1}^n \Pr(A_i)
$$

**例**

若一个算法有 $n$ 类错误，且每类错误发生的概率都不超过 $p$，则
  $$
\Pr(\text{无错误}) = 1 - \Pr(\bigcup_{i=1}^n A_i) \ge 1 - n p
$$

**Ramsey 理论**

若
  $$
\binom{n}{k} 2^{1 - \binom{n}{2}} < 1
$$
  则存在一个 $K_n$ 的 $2$-染色，使得其中没有单色 $K_k$。因此 $R(k, k) > n$。

**证明**

将 $K_n$ 的每条边独立地以概率 $1/2$ 染成红色或蓝色。对每个大小为 $k$ 的顶点子集 $S$，记 $A_S$ 为诱导子图 $K_S$ 为单色的事件。则
  $$
\Pr(A_S) \overset{\text{两种单色情形}}{=} 2^{1 - k (k - 1) / 2}
$$
  再由并集界，
  $$
\Pr(\bigcup_S A_S) \le n! / (k! (n - k)!) 2^{1 - k (k - 1) / 2} < 1
$$
  因此以正概率不存在单色 $K_k$。

**例**

球入盒模型。将 $n$ 个球独立且均匀地投入 $n$ 个盒子。
  以高概率每个盒子至多接收 $O((\ln n) / (\ln \ln n))$ 个球
  也就是以至少 $1 - O(1/n)$ 的概率成立。

  证明。
  $A$：存在某个盒子收到 $k$ 个球（其中 $k$ 稍后选取）。

  $A_i$：第 $i$ 个盒子至少收到 $k$ 个球这一事件。
  记
  $$
\Pr(A) = \Pr(\bigcup_{i=1}^n A_i) \sum_i \Pr(A_i) \le 1/n \Rightarrow \Pr(A^c) \ge 1 - 1/n
$$
  对每个 $S \in \binom{[n]}{k} \in 2^[n]$，定义
  $A_{i,S}$：第 $i$ 个盒子恰好收到了集合 $S$ 中这些球。

  由并集界，
  $$
\begin{aligned}
\Pr(A_i) & = \Pr(\bigcup_{S \in \binom{[n]}{k}} A_{i, S}) \le \sum_{S \in \binom{[n]}{k}} \Pr(A_{i, S}) \\
& = \binom{n}{k} 1/n^k \le ((e n)/k)^k 1/n^k = (e/k)^k \le 1/n^2, \text{当} k = 3 (\ln n) / (\ln \ln n)
\end{aligned}
$$

## 容斥原理
容斥原理

对事件 $A_1, \dots, A_n$，
$$
\begin{aligned}
\Pr(\bigcup_{i=1}^n A_i) & = \sum_{i=1}^n \Pr(A_i) - \sum_{i < j} \Pr(A_i \cap A_j) + \sum_{i < j < k} \Pr(A_i \cap A_j \cap A_k) - \dots \\
& = \sum_{\emptyset \ne S \subseteq [n]} (-1)^{|S| - 1} \Pr(\bigcap_{i \in S} A_i)
\end{aligned}
$$

Boole-Bonferroni 不等式

对任意 $A_1, A_2, \dots, A_n \in \Sigma$ 以及任意 $k \ge 0$，
$$
\sum_{S \in \{1,2, \dots, n\},\ 1 \le |S| \le 2 k} (-1)^{|S| - 1} \Pr(\bigcap_{i \in S} A_i) \le \Pr(\bigcup_{i=1}^n A_i) \le \sum_{S \in \{1,2, \dots, n\},\ 1 \le |S| \le 2 k + 1} (-1)^{|S| - 1} \Pr(\bigcap_{i \in S} A_i)
$$

**例**

错排问题。记 $\pi: [n] \to [n]$ 为均匀随机排列，令 $A_i$ 为事件 $\pi(i) = i$。则
  $$
\begin{aligned}
\Pr(\text{无固定点}) & = 1 - \Pr(\bigcup_{i=1}^n A_i) \\
& = 1 - \sum_{k=1}^n \sum_{S \in \binom{\{1, 2, \dots, n\}}{k}} (-1)^{k-1} \Pr(\bigcap_{i \in S} A_i) \\
& = 1 + \sum_{k=1}^n \binom{n}{k} (-1)^{k} (n-k)! / n! \\
&= \sum_{k=0}^n (-1)^k 1/k! \to 1/e, n \to +\infty
\end{aligned}
$$
  因此
  $$
\Pr(\text{无固定点}) \to 1 / e
$$

## 连续性与零测事件
若 $A_1 \subseteq A_2 \subseteq \dots$ 且 $A = \bigcup_{i=1}^\infty A_i$，则
$$
\begin{aligned}
\Pr(A) & = \Pr(A_1) \sum_{i=1}^\infty \Pr(A_{i+1} \setminus A_i) \\
& = \Pr(A_1) + \lim_{i=1}^\infty \sum_{i=1}^{n-1} (\Pr(A_i+1) - \Pr(A_i)) \\
& = \lim_{i \to \infty} \Pr(A_i)
\end{aligned}
$$
若 $B_1 \supseteq B_2 \supseteq \dots$ 且 $B = \bigcap_{i=1}^\infty B_i$，则
$$
\Pr(B) = \lim_{i \to \infty} \Pr(B_i)
$$

## 零测事件与几乎必然事件

若 $\Pr(A) = 0$，则称 $A$ 为零测事件。
若 $\Pr(A) = 1$，则称 $A$ 几乎必然发生。
完备概率空间包含每个零测事件的任意子集。

# 条件概率

## 定义
对满足 $\Pr(B) > 0$ 的事件 $A, B$，定义 $A$ 在 $B$ 条件下的条件概率为
$$
\Pr(A | B) = \Pr(A \cap B) / \Pr(B)
$$

映射 $A \Rightarrow \Pr(A | B)$ 本身也是一个概率律，它定义在
$$
\Sigma_B = \{ A \cap B : A \in \Sigma \}
$$
对应的概率空间可写为 $(B, \Sigma_B := \{A \cap B, A \in \Sigma\}, \Pr(\cdot | B))$。

## 基本例子
**例**

用有偏硬币构造公平硬币。不断投掷这枚有偏硬币，直到首次出现 $\text{HT}$ 或 $\text{TH}$；前者输出 $H$，后者输出 $T$。由于
  $$
\Pr(\text{HT} | \{\text{HT}, \text{TH}\}) = \Pr(\text{TH} | \{\text{HT}, \text{TH}\}) = 1 / 2
$$
  因此这给出了一个由未知偏置硬币构造公平硬币的方法。

**例**

两孩问题。在如下均匀分布下
  $$
\Omega = \{\text{BB}, \text{BG}, \text{GB}, \text{GG}\}
$$
  若已知至少有一个孩子是女孩，则
  $$
\Pr(\text{GG} | \{\text{BG}, \text{GB}, \text{GG}\}) = 1 / 3
$$

## 基本公式
对具有正的中间条件概率的事件 $A_1, \dots, A_n$，链式法则为
$$
\Pr(\bigcap_{i=1}^n A_i) = \prod_{i=1}^n \Pr(A_i | \bigcap_{j < i} A_j)
$$

若 $B_1, \dots, B_n$ 构成 $\Omega$ 的一个划分，则全概率公式为
$$
\Pr(A) = \sum_{i=1}^n \Pr(A | B_i) \Pr(B_i)
$$

在同一划分下，Bayes 公式为
$$
\Pr(B_i | A) = (\Pr(B_i) \Pr(A | B_i)) / (\sum_{j=1}^n \Pr(B_j) \Pr(A | B_j))
$$

## 条件概率例题
**生日悖论**

对均匀随机映射 $f: [n] \to [m]$，
  $$
\Pr(f \text{是单射}) = (m! / ((m - n)!) 1 / m^n) = \prod_{i=1}^n (1 - (i - 1) / m)
$$
  以及
  $$
\begin{aligned}
\prod_{i=1}^n (1 - (i - 1) / m) & \approx \prod_{i = 1}^n \exp((i-1) / m) \\
& \approx \exp(\sum_{i=1}^n ((i - 1) / m)) \approx \exp (-n^2 / (2 m))
\end{aligned}
$$
  把它应用到球入盒模型，就是依次把 $n$ 个球投入 $m$ 个盒子。
  $$
\begin{aligned}
\Pr(\text{每个球都进入空盒子}) = \epsilon = \exp(- n^2 / (2 m)) \\
\Rightarrow\sqrt{2 m \ln (1/\epsilon)}
\end{aligned}
$$

**Monty Hall 问题**

令 $A$ 为最终赢得汽车的事件，$B$ 为第一次选择就选中汽车的事件。

  若你不换门，则
  $$
\Pr(A) = \Pr(B) = 1 / 3
$$

  若你总是换门，则由全概率公式
  $$
\begin{aligned}
\Pr(A) & = \Pr(A | B) \Pr(B) + \Pr(A | B^c) \Pr(B^c) \\
& = 0 \cdot 1 / 3 + 1 \cdot 2 / 3 = 2 / 3
\end{aligned}
$$
  所以换门会使成功概率翻倍。

**赌徒破产问题**

令 $A$ 为赌徒在到达 $n$ 之前先破产的事件，$\Pr_k$ 表示初始资金为 $k$ 时的概率律。

  对第一次抛硬币的结果 $B = \{\text{第一次抛出正面}\}$ 分情况讨论，
  $$
\begin{aligned}
\Pr_k(A) & = \Pr_k(A | B) \Pr(B) + \Pr_k(A | B^c) \Pr(B^c) \\
& = 1 / 2 \Pr_{k + 1}(A) + 1 / 2 \Pr_{k - 1}(A)
\end{aligned}
$$
  对 $0 < k < n$，并配合边界条件
  $$
\Pr_0(A) = 1, \quad \Pr_n (A) = 0
$$

  记 $u_k = \Pr_k (A)$。则
  $$
u_{k + 1} - u_k = u_k - u_{k - 1}
$$
  因此 $(u_k)$ 构成等差数列，从而
  $$
u_k = \alpha + \beta k
$$
  由 $u_0 = 1$ 和 $u_n = 0$ 可得 $\alpha = 1$、$\beta = -1 / n$。因此
  $$
\Pr_k(A) = u_k = 1 - k / n
$$

**假阳性的主导效应**

令 $I$ 表示“此人患病”事件。已知
  $$
\Pr(I) = 0.001, \quad \Pr(+ | I) = 0.95, \quad \Pr(+ | I^c) = 0.05
$$

  由全概率公式，
  $$
\begin{aligned}
\Pr(+) & = \Pr(+ | I) \Pr(I) + \Pr(+ | I^c) \Pr(I^c) \\
& = 0.95 \cdot 0.001 + 0.05 \cdot 0.999
\end{aligned}
$$

  因此，由 Bayes 公式，
  $$
\begin{aligned}
\Pr(I | +) & = (\Pr(+ | I) \Pr(I)) / \Pr(+) \\
& = (0.95 \cdot 0.001) / (0.95 \cdot 0.001 + 0.05 \cdot 0.999) \\
& \approx 1.87%
\end{aligned}
$$
  所以即便检测结果为阳性，患病仍然不太可能，因为在极低先验下假阳性会占主导。

**Simpson 悖论**

在 PPT 的药物试验例子中：
  $$
\begin{aligned}
\Pr(\text{成功} | \text{药物 I}, \text{女性}) & = 200 / 2000 = 1 / 10 > 10 / 200 \\
& = 1 / 20 = \Pr(\text{成功} | \text{药物 II}, \text{女性})
\end{aligned}
$$
  $$
\begin{aligned}
\Pr(\text{成功} | \text{药物 I}, \text{男性}) & = 19 / 20 \\
& > 1000 / 2000 = 1 / 2 = \Pr(\text{成功} | \text{药物 II}, \text{男性})
\end{aligned}
$$

  但汇总后，
  $$
\Pr(\text{成功} | \text{药物 I}) = 219 / 2020 < 1010 / 2200 = \Pr(\text{成功} | \text{药物 II})
$$

  抽象地说，完全可能对划分中的每个块 $C_i$ 都有
  $$
\Pr(A | B \cap C_i) > \Pr(A | B^c \cap C_i)
$$
  但整体上仍然可能满足
  $$
\Pr(A | B) < \Pr(A | B^c)
$$

# 独立性

## 事件的独立性
若事件 $A$ 与 $B$ 满足
$$
\Pr(A \cap B) = \Pr(A) \Pr(B)
$$

若 $\Pr(B) > 0$，这等价于
$$
\Pr(A | B) = \Pr(A)
$$
也等价于
$$
\Pr(A \cap B^c) = \Pr(A) \Pr(B^c)
$$

对事件族 $\{A_i : i \in I\}$，若对每个有限 $J \subseteq I$ 都有下式，则称其相互独立：
$$
\Pr(\bigcap_{i \in J} A_i) = \prod_{i \in J} \Pr(A_i)
$$

若对任意不交有限集 $J_+, J_- \subseteq I$ 都有下式，则称事件 $A$ 与族 $\{B_i : i \in I\}$ 独立：
$$
\Pr(A | \bigcap_{i \in J_+} B_i \cap \bigcap_{i \in J_-} B_i^c) = \Pr(A)
$$

## 乘积概率空间
给定离散概率空间 $(\Omega_1, p_1), \dots, (\Omega_n, p_n)$，其乘积空间为
$$
\Omega = \Omega_1 \times \dots \times \Omega_n
$$
对应的乘积 pmf 为
$$
p(\omega_1, \dots, \omega_n) = p_1(\omega_1) \dots p_n(\omega_n)
$$

对可测矩形有
$$
\Pr(A_1 \times \dots \times A_n) = \Pr_1(A_1) \dots \Pr_n (A_n)
$$
对一般概率空间，也可类似定义乘积 $\sigma$-代数及相应的乘积测度。

## 有限阶独立
两两独立只要求
$$
\Pr(A_i \cap A_j) = \Pr(A_i) \Pr(A_j) \qquad \text{对任意 } i \ne j
$$
相互独立蕴含两两独立，但反之不成立。

**两两独立但不相互独立**

抛三枚公平硬币。令
  $$
D = \{X_1 \ne X_2\}, \quad E = \{X_2 \ne X_3\}, \quad F = \{X_3 \ne X_1\}
$$

  每个事件的概率都是 $1 / 2$，并且
  $$
\Pr(D \cap E) = \Pr(D \cap F) = \Pr(E \cap F) = 1 / 4 = (1 / 2)(1 / 2)
$$
  因此它们两两独立。

  但是
  $$
D \cap E \cap F = \emptyset
$$
  因为三个比特不可能做到两两都不同。因此
  $$
\Pr(D \cap E \cap F) = 0 \ne 1 / 8 = \Pr(D) \Pr(E) \Pr(F)
$$
  所以它们并不相互独立。

**三重乘积成立但两两不独立**

条件
  $$
\Pr(A \cap B \cap C) = \Pr(A) \Pr(B) \Pr(C)
$$
  本身远弱于相互独立。

  例如，在 $\Omega = \{000, 010, 101, 111\}$ 上取如下概率：
  $$
\Pr(000) = 1 / 8, \quad \Pr(010) = 3 / 8, \quad \Pr(101) = 3 / 8, \quad \Pr(111) = 1 / 8
$$
  令 $A, B, C$ 分别表示第一、第二、第三位为 $1$ 的事件。
  此时
  $$
\Pr(A) = \Pr(B) = \Pr(C) = 1 / 2
$$
  以及
  $$
\Pr(A \cap B \cap C) = \Pr(111) = 1 / 8 = \Pr(A) \Pr(B) \Pr(C)
$$
  但
  $$
\Pr(A \cap B) = 1 / 8 \ne 1 / 4 = \Pr(A) \Pr(B)
$$
  所以任意一对都不独立。

## 独立重复
**单边错误缩减**

设随机算法 $\mathcal{A}$ 具有单边错误：
  $$
f(x) = 1 \Rightarrow \mathcal{A}(x) = 1, \quad f(x) = 0 \Rightarrow \Pr(\mathcal{A}(x) = 0) \ge p
$$

  将算法独立运行 $n$ 次并返回所有输出的合取。在负例上，只有每次都出错时才会出错，因此由独立性
  $$
\Pr(\text{出错}) \le (1 - p)^n
$$
  因此只需取
  $$
n \ge \ln(1 / \epsilon) / p
$$
  即可把错误率降到至多 $\epsilon$。

**二项分布概率**

对 $n$ 次独立 Bernoulli 试验，恰好成功 $k$ 次的概率为
  $$
\begin{aligned}
p(k) & \\
& = \sum_{S \in \binom{[n]}{k}} \Pr(\text{集合 } S \text{ 中的试验成功}) \Pr(\text{其余试验失败}) \\
& = \sum_{S \in \binom{[n]}{k}} p^k (1 - p)^{n - k} \\
& = n! / (k! (n - k)!) p^k (1 - p)^{n - k}
\end{aligned}
$$

  因此 $p(k)$ 是定义在 $\{0, 1, \dots, n\}$ 上的 pmf，并且
  $$
\sum_{k=0}^n p(k) = 1
$$

**公平投票**

令 $X$ 为 $n$ 次独立公平抛硬币中出现正面的次数，则
  $$
\begin{aligned}
\Pr(|2 X - n| \ge t) & = \Pr(X \le (n - t) / 2) + \Pr(X \ge (n + t) / 2) \\
& = 2^{1 - n} \sum_{k \le (n - t) / 2} n! / (k! (n - k)!)
\end{aligned}
$$

  利用 Hamming 球体积的熵估计，
  $$
\Pr(|2 X - n| \ge t) \le 2^{1 - n + n H(1 / 2 - t / (2 n))} \approx 2 \exp(- t^2 / n)
$$
  因此要使该概率不超过 $0.05$，只需要求
  $$
t \ge 2 \sqrt{n}
$$

**双边错误缩减**

设
  $$
\Pr(\mathcal{A}(x) = f(x)) \ge 1 / 2 + p
$$
  对每个输入 $x$ 都成立。独立运行算法 $n$ 次并返回多数结果。若最终出错，则意味着正确次数少于一半，因此
  $$
\Pr(\text{多数结果错误}) \le \sum_{k < n / 2} n! / (k! (n - k)!) (1 / 2 + p)^k (1 / 2 - p)^{n - k}
$$
  再由集中不等式可得上界
  $$
\Pr(\text{多数结果错误}) \le \exp(- p^2 n)
$$
  因此只需取
  $$
n \ge \ln(1 / \epsilon) / p^2
$$

## 网络可靠性与条件独立
**串并联网络可靠性**

若每条边都独立存在，且存在概率分别为 $p_1, \dots, p_5$，则
  $$
P_{A B} = 1 - (1 - p_1)(1 - p_2)(1 - p_3)
$$
  因为 $A$ 与 $B$ 连通，当且仅当三条并联边中至少有一条存在。

  此时
  $$
P_{A C} = P_{A B} p_5, \quad P_{D E} = p_4
$$
  而从 $s$ 到 $t$ 的两条分支彼此独立，因此
  $$
P_{s t} = 1 - (1 - P_{A C})(1 - P_{D E})
$$
  即
  $$
P_{s t} = 1 - (1 - P_{A B} p_5)(1 - p_4)
$$

## 条件独立
对满足 $\Pr(C) > 0$ 的事件 $A, B, C$，若
$$
\Pr(A \cap B | C) = \Pr(A | C) \Pr(B | C)
$$
若进一步有 $\Pr(B \cap C) > 0$，则这等价于
$$
\Pr(A | B \cap C) = \Pr(A | C)
$$

**条件独立例子**

抛两枚公平硬币。令
  $$
A = \{X_1 = H\}, \quad B = \{X_2 = H\}, \quad C = \{X_1 \ne X_2\}
$$
  此时 $A$ 与 $B$ 独立，因为
  $$
\Pr(A \cap B) = 1 / 4 = \Pr(A) \Pr(B)
$$

  但在给定 $C$ 的条件下，它们不再独立：
  $$
\Pr(A \cap B | C) = 0
$$
  而
  $$
\Pr(A | C) \Pr(B | C) = 1 / 2 \cdot 1 / 2 = 1 / 4
$$

  所以独立性并不推出条件独立性。
