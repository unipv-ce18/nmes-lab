function [ A, B ] = gem( A, B, noPivoting )
%GEM Triangulates a matrix using the Gaussian Elimination Method (GEM)
%   GEM(A,B) returns an equivalent system AT, BT having AT \ BT = A \ B
%   where AT is an upper-triangular matrix.
%
%   GEM(A,B,NOPIVOTING) can be used to disable column swaps (for learning
%   purposes). Doing this may cause the algorithm to fail with certain
%   combinations of A, B in which an element on the diagonal may go to
%   zero during an iteration and be required as a denominator (giving
%   infinity) in calculations for the next cycle, thus erroring out.

if ~exist('noPivoting', 'var')
    noPivoting = false;
end

swapCount = 0;

for c = 1:length(A)-1

    % Swap columns to avoid coeff = Inf (pivoting)
    if ~noPivoting
        m = max(abs(A(c:length(A), c)));
        colIdx = find(A(:,c) == m);
        if c ~= colIdx
            A([c colIdx],:) = A([colIdx c],:);
            B([c colIdx],:) = B([colIdx c],:);
            swapCount = swapCount + 1;
        end
    end

    pivot = A(c,c);
    if pivot == 0
        % This fails if, *while processing*, we alter the matrix in such
        % a way that we encounter a 0 on the diagonal in the next step.
        warning('Row coefficient = infinity, pivoted gem must be used');
    end

    for r = c+1:length(A)
        coeff = A(r,c) / pivot;

        A(r,:) = A(r,:) - A(c,:) * coeff;
        B(r) = B(r) - B(c) * coeff;
    end
end

% When swapping is used, this is to
% preserve det(.) sign, which is inverted at each swap operation.
if ~noPivoting && mod(swapCount, 2)
   A = -A;
   B = -B;
end

end
