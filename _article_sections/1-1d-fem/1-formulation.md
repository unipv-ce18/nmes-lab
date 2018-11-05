---
article: Implementing 1D FEM
section: Initial formulation
---
We need to solve the following _ordinary differential equation_ in 1D:

$$
\begin{cases}
  - \epsilon u'' + \beta(x) u' = f(x) & \text{in } [a,b] \\
  u(a) = 0 \\
  u'(b) = \gamma
\end{cases}
$$

$$
\text{with}\enspace \epsilon \gt 0,\enspace \beta: [a,b] \rarr \reals
\quad \text{and}\enspace \gamma \in \reals
$$

As theory explains, we can transform this into a _weak form_ by multiplying
each side with a _test function_ $v(x)$ and then integrate over $[a,b]$:

$$
-\epsilon \greenhl{\int_a^b u''v\;dx} + \int_a^b {\beta}u'v\;dx =
\int_a^b fv\;dx
$$

The part in <span class="greenhl">green</span> can be rewritten
by using _integration by parts_:

$$
\greenhl{\int_a^b u''v\;dx} = -\int_a^b u'v'\;dx + \bluehl{u'v \Big|_a^b}
$$

We can expand the <span class="bluehl">blue</span> part and simplify by
substituting $u^\prime(b) = \gamma$ and $v(a) = 0$, the last chosen arbitrarily:

$$
\bluehl{u'v \Big|_a^b} =
\underbrace{u'(b)}_{\gamma}\,v(b) - u'(a)\underbrace{v(a)}_{v(a) = 0} =
\gamma v(b)
$$

$$
\greenhl{\int_a^b u''v\;dx} = -\int_a^b u'v'\;dx + \bluehl{\gamma v(b)}
$$

Let's now replace our simplifications back into our equation
in order to reach its final form:

$$
-\epsilon \bigg(\greenhl{-\int_a^b u'v'\;dx + \gamma v(b)}\bigg) +
\int_a^b {\beta}u'v\;dx = \int_a^b fv\;dx
$$

$$
\epsilon \int_a^b u'v'\;dx - \epsilon\gamma v(b) +
\int_a^b {\beta}u'v\;dx = \int_a^b fv\;dx
$$

$$
\boxed{\epsilon \int_a^b u'v'\;dx + \int_a^b {\beta}u'v\;dx =
\int_a^b fv\;dx + \epsilon\gamma v(b)}
$$
