---
article: Implementing 1D FEM
section: Obtaining the A matrix
---
  Last time we left off with…

$$
  \sum_{j=1}^{N-1} u_j \bigg(
  \underbrace{\epsilon \int_a^b \phi_j'\,\phi_i'\;dx}_{\bm{A}} +
  \underbrace{\int_a^b \beta\,\phi_j'\,\phi_i\;dx}_{\bm{B}} \bigg) =
  \underbrace{\int_a^b f\,\phi_i\;dx + \epsilon\,\gamma\,\phi_i(N_{DOF})
  }_{\underline{F}}
$$

…and its matrix form:

$$(\bm{A}+\bm{B})\;\underline{U}=\underline{F}$$

Let's plot $\phi_i(x)$ and $\phi_i^\prime(x)$ so that we can calculate the
entries $A_{ij} = \epsilon \int_a^b \phi_j^\prime\phi_i^\prime\,dx$ graphically:

<div class="imgh">{% include 1d-fem/plot-phi-phi-prime.svg %}</div>

In the case $\dredhl{i} = \dredhl{j}$ we have (noting that we can limit
our integration to the interval $[x_i-h, x_i+h]$):

$$
\def\inth{\int_{x_i-h}^{x_i+h}}
\begin{aligned}
  A_{ii} & = \epsilon \inth \phi_i'\,\phi_i'\,dx =
  \epsilon \inth \dredhl{(\phi_i')^2}\,dx
\\
  & = \epsilon \inth \frac{1}{h^2}\,dx =
  \epsilon\,2h\frac{1}{h^2} = \boxed{\epsilon\frac{2}{h}}
\end{aligned}
$$

<div class="imgh">{% include 1d-fem/plot-phi-prime-sq.svg %}</div>

We can similarly proceed to solve for the case $\greenhl{i} = \bluehl{j}\pm1$,
knowing that the product is $\not=0$ only between $0$ and $h$…

$$
\begin{aligned}
  A_{ij} & = \epsilon \int_{x_i-h}^{x_i+h}
  \greenhl{\phi_i'}\,\bluehl{\phi_j'}\,dx =
  \epsilon \int_{x_i}^{x_i+h} \greenhl{-\frac{1}{h}} \bluehl{\frac{1}{h}}\,dx
\\
  & = \epsilon\, h \Big(-\frac{1}{h^2}\Big) = \boxed{-\epsilon\frac{1}{h}}
\end{aligned}
$$

<div class="imgh">{% include 1d-fem/plot-a-mul-ij.svg %}</div>

Safely assuming that $A_{ij} = 0$ for all the other cases,
we can now build the matrix:

$$
\bm{A} = \frac{\epsilon}{h} \begin{pmatrix}
   2 & -1 &    &    &        &    \\
  -1 &  2 & -1 &    &        &    \\
     & -1 &  2 & -1 &        &    \\
     &    &    &    & \ddots & -1 \\
     &    &    &    &     -1 &  2
\end{pmatrix}
$$

> Since we are dealing with a _Neumann condition_ on the right boundary,
> we need both to consider:
>
> - A number of degrees of freedom equal to the number of internal nodes plus
>   the right hand node, and;
> - The fact that only half of the last $\phi_i$ triangle is integrated;
>   so that **the last $2$ in the matrix is splitted in half, and becomes $1$**.
