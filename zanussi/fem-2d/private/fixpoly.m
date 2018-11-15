function [ nB ] = fixpoly( p, B )
%FIXPOLY Reorder polygon points by minimum distance path
%   FIXPOLY(P,B) reorders the array of point indexes B such that,
%   from B(1), a path is followed to the next nearest point,
%   iterating until all the points of the vector are consumed.
%   P is a matrix of coordinates of the points of B.

% Initialize the result matrix
nB = zeros(size(B));

% Start from the first point
curP = B(1);

% We need to calculate the distance to these points
remPts = B(2:end);

% Perform length(B) iterations
for iter = 1:length(B)

    % Add this point to the result array
    nB(iter) = curP;

    % Calculate an array of distances from this to remaining points
    dist = sum((p(curP, :) - p(remPts, :)).^2, 2);

    % Get the index of the minimum distance, it will be our next point
    sel = find(dist == min(dist));
    curP = remPts(sel);

    % Pop the selected point from the remaining points array
    remPts(sel) = [];

end

end
