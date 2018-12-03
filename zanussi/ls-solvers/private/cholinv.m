function [ invA ] = cholinv( A )

R = chol(A); % R' R = A

invA = zeros(size(A));
for c=1:length(A)
    I = eye(size(A));
    invA(:,c) = substsolve(R, substsolve(R', I(:,c)));
end

%{
A A^-1 = I
R' (R A^-1) = I

R' \ I -> R A^-1
R \ R A^-1 -> A^-1
%}

end
