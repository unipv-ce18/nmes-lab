---
article: Implementing 1D FEM
section: Obtaining the B matrix
---
As we have seen the elements of the $\bm{B}$ matrix can be defined as:

$$
B_{ij} = \int_a^b \beta\,\phi_j'\,\phi_i\;dx
$$

> In order to simplify our calculations
> *we will consider only the case $\bold{\beta = 1}$*, since it is
> the only case required by the course exercises for now.

Remembering the shapes of $\bluehl{\phi(x)}$ and $\redhl{\phi^\prime(x)}$…

<div class="imgh">{% include 1d-fem/plot-phi-phi-prime.svg %}</div>

…we can start to calculate $\bm{B}$ for the case $\dredhl{i} = \dredhl{j}$:

$$
\def\inth{\int_{x_i-h}^{x_i+h}}
B_{ii} = \inth \redhl{\phi_i'}\,\bluehl{\phi_i}\,dx = 0
$$

<div class="imgh">{% include 1d-fem/plot-b-mul-ij.svg %}</div>

For the case $\dredhl{i} = \dredhl{j}\pm1$ instead we have:

$$
\def\inth{\int_{x_i-h}^{x_i+h}}
B_{ij} = \inth \redhl{\phi_i'}\,\bluehl{\phi_j}\,dx =
\frac{1}{\cancel{h}} \cancel{h} \cdot
\begin{cases}
  \tealhl{+\frac{1}{2}} & \text{for } \tealhl{j = i + 1}
\\
  \purplehl{-\frac{1}{2}} & \text{for } \purplehl{j = i - 1}
\end{cases}
$$

<div class="imgh">{% include 1d-fem/plot-b-mul-ij-plus.svg %}</div>
<div class="imgh">{% include 1d-fem/plot-b-mul-ij-minus.svg %}</div>

We can finally determine the structure of the $\bm{B}$ matrix — stating easily
that $B_{ij} = 0$ for any other value of $i$ and $j$.

$$
\bm{B} = \frac{1}{2} \begin{pmatrix}
   0 &  1 &   &   &        &    \\
  -1 &  0 & 1 &   &        &    \\
     & -1 & 0 & 1 &        &    \\
     &    &   &   & \ddots & -1 \\
     &    &   &   &    -1  &  0
\end{pmatrix}
\quad \text{for } \beta = 1
$$
