% We want to calculate the area of a circle (r = 1)
% by summing the area of internal mesh triangles

% Generate the triangular mesh
oldpath = addpath('./vendor', './vendor/distmesh');
h = 1/10;
[p, t, I, B] = triangular_mesh('circle', h);
close(1);
path(oldpath);

% We can also define a function as a weight
% to evaluate at the barycenter of each triangle
f = @(x, y) 1;

area = 0;
for tIdx = 1:length(t)
    % Get the indexes & coordinates of the vertices of this triangle
    tDef = t(tIdx, :);
    tCoords = p(tDef, :);

    % Calculate the barycenter: mean value of the vertices
    bary = sum(tCoords) / 3;

    % Then add this triangle to the total area
    area = area + triarea(tCoords) * f(bary(1), bary(2));
end

fprintf('Area (~ pi): %.3f\n\n', area);
