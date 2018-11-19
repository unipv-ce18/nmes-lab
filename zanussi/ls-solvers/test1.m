%% Backslash operator implementation example
% We want to implement the 'x = A \ b' as used in FEM exercise,
% i.e. solve the linear system 'A x = b' for the vector 'x = inv(A) b'.

% Let's start by an A, B pair to work on...

A = [ 1  2  4
      3  8 14
      2  6 13 ];

B = [ -1
      -5
      -4 ];

% Now we want to triangularize A, why?
% - det(A) is necessary to calculate inv(A);
% - det(.) is much faster to calculate on a triangular matrix since
%   it is the product of the elements on its diagonal;
% - and more, on a triangular matrix we can even use a backsubstitution
%   algorithm to compute 'x'.
[An, Bn] = gem(A, B);

% ...only making sure that det(A) equals det(An); since An is a triangular
% matrix, det(An) is the product of the elements on its diagonal.
assert(det(A) == prod(diag(An)), ...
    'det(A) should be equal to equiv. triangular matrix diagonal product');

% Note: prod(diag(An)) computes faster than det(A), especially for large N

% Then calculate A / B using backsubstitution on the equivalent system
x = backsubst(An, Bn);

% Ensure that the result is the same as doing A \ B
assert(isequal(A \ B, x), ...
    'A \ B should be equal to using backsubst on eqiv. triangular system');

disp('Math is still working in this universe');
