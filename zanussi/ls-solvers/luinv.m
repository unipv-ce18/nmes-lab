function [ invA ] = luinv( A )

[L, U, P] = lu(A);

invA = zeros(size(A));
for c=1:length(A)
    invA(:,c) = substsolve(U, substsolve(L, P(:,c)));
end

%{
A * A^-1 = I

P' * L * U = A -> P*A = L*U

PA * A^-1 = P

LU * x = B
  where PA = LU
  X = A^-1
  B = P

L(U x) = B

prima L \ B -> U x
dopo U \ U x -> x   (U x = U x)

%}

% ex2.1 amy need pivoting
% MATLAB's L is P*L, permutation matrix P^-1 = P
% A = (P'L)U


%{
u' A u = int(norm(gradient(uh)))
u = (u1,  ... un) -> uk = sum(phii ui)

%}

end

