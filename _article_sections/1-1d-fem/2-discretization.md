---
article: Implementing 1D FEM
section: Discretization
---
In the previous step we arrived to the following weak formulation of our
differential equation:

$$
\boxed{\epsilon \int_a^b u'v'\;dx + \int_a^b {\beta}u'v\;dx =
\int_a^b fv\;dx + \epsilon\,\gamma\,v(b)}
$$

Without digging deep into the underlying theory we can rewrite this expression
into a discrete form; this allows us to calculate it numerically with a computer
without being troubled by the fact otherwise we would have had $\infty$ numbers
in the $[0,1]$ interval alone.

$$
\epsilon \int_a^b u_h' v_h'\;dx + \int_a^b {\beta}u_h'v_h\;dx =
\int_a^b fv_h\;dx + \epsilon\gamma v_h(b)
$$

Where $h$ is the width of a single interval. Having both
$u_h,v_h \in V \coloneqq span(\phi_1, \phi_2, \mathellipsis, \phi_{N_{DOF}})$,
we can represent
<span class="bluehl">$u$ and $v$ in terms of the basis functions $\phi_i$</span>
of $V$; for example:

$$
\redhl{u_h(x)} =
\sum_{j=1}^{N-1} u_j \phi_j(x),\qquad \text{with }\; u_j=u_h(x)
$$

In fact we can substitute <span class="redhl">this</span> into our previous
equation and obtain:

$$
\def\sumuj{\sum_{j=1}^{N-1} u_j}
\epsilon \redhl{\sumuj} \int_a^b \redhl{\phi_j'}\,\bluehl{\phi_i'}\;dx +
\redhl{\sumuj} \int_a^b \beta\,\redhl{\phi_j'}\,\bluehl{\phi_i}\;dx =
\mathellipsis
$$

$$
\boxed{
  \sum_{j=1}^{N-1} u_j \bigg(
  \underbrace{\epsilon \int_a^b \phi_j'\,\phi_i'\;dx}_{\bm{A}} +
  \underbrace{\int_a^b \beta\,\phi_j'\,\phi_i\;dx}_{\bm{B}} \bigg) =
  \underbrace{\int_a^b f\,\phi_i\;dx + \epsilon\,\gamma\,\phi_i(N_{DOF})
  }_{\underline{F}}
}
$$

Which is a linear system and can be written in matrix form:

$$
\boxed{(\bm{A}+\bm{B})\;\underline{U}=\underline{F}}
$$
