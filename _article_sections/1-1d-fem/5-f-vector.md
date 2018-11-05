---
article: Implementing 1D FEM
section: The F vector
---
Now we have to deal with the right hand side of the equation — the
${\underline{F}}$ vector; as we know it is defined as:

$$
\def\fel#1{\int_a^b f\,\phi_{#1}\;dx + \epsilon\,\gamma\,\phi_{#1}(N_{DOF})}
\begin{gathered}
  F_i = \fel{i}
\\ \\ id\;est \\ \\
  \underline{F} = \begin{pmatrix}
    \fel{1} \\ \fel{2} \\ \vdots \\ \fel{N_{DOF}}
  \end{pmatrix}
\end{gathered}
$$

Since $\phi_i$ is $1$ only in $x_i$ and $0$ otherwise, we can be simplify the vector to this:

$$
\def\felb#1{\int_a^b f\,\phi_{#1}\;dx}
\underline{F} = \begin{pmatrix}
  \felb{1} \\ \felb{2} \\ \vdots \\ \felb{N_{DOF}} + \epsilon\,\gamma
\end{pmatrix}
$$

…resulting in the same $\underline{F}$ as in homogeneous <abbr title="Finite Element Method">FEM</abbr>,
with an extra part summed to the last element of the vector.
