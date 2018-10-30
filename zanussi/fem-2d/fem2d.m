oldpath = addpath('./vendor', './vendor/distmesh');

% We need Symbolic Math to compute the exact laplacian for reference
syms x y;
UgenSym(x, y) = sin(4*pi*sqrt(x^2+y^2))/sqrt(x^2+y^2);
Ugen = matlabFunction(UgenSym);
Fgen = matlabFunction(-laplacian(UgenSym, [x y]));

% Generate the mesh (and close that popup)
[p, t, I, B] = triangular_mesh('circle', .05);
close(1);

% Allocate A and F and initialize to zero
% (statistically nnz(A)/length(A) ~ 6.6)
A = spalloc(length(I), length(I), 7*length(I));
F = zeros(length(I), 1);

bh = waitbar(0, ...
    sprintf('Evaluating on mesh... 0.00% (%d/%d polys)', 0, length(t)), ...
    'WindowStyle', 'modal');

% Iterate over all the triangles
for tIdx = 1:length(t)

    % Get the indexes of the vertices of this triangle
    tDef = t(tIdx, :);

    % And then get their coordinates
    tCoords = p(tDef, :);

    if ispolycws(tCoords)
       warning('Encountered a clockwise-defined triangle');
    end

    % Calculate the area of the triangle
    area = triarea(tCoords);

    % Since we are here, calculate also F contribution for this triangle,
    % the value is const. for each vertex since the barycenter is the same.
    %   Find the barycenter > Evaluate Fgen in it > Integrate (mul. area)
    bary = sum(tCoords) / 3;
    fVal = 1/3 * double(Fgen(bary(1), bary(2))) * area;

    % We need to iterate only on the vertices *inside* the mesh
    innerVerts = intersect(tDef, I, 'stable');

    for i = innerVerts
        % Opposite edge length: rotate the triangle array until the current
        % vertex is first, then take the difference between the last 2 pts.
        iIdx = find(tDef == i);
        iCoordsSort = circshift(tCoords, -iIdx+1);
        ei = diff(iCoordsSort(2:end,:));

        for j = innerVerts
            jIdx = find(tDef == j);
            jCoordsSort = circshift(tCoords, -jIdx+1);
            ej = diff(jCoordsSort(2:end,:));

            A(i,j) = A(i,j) + dot(ei, ej)/(4*area);
        end

        % Apply also F contribution to this vertex
        F(i) = F(i) + fVal;
    end

    if ~mod(tIdx, 200)
        perc = tIdx/length(t);
        waitbar(perc, bh, ...
            sprintf('Evaluating on mesh... %.2f%% (%d/%d polys)', ...
            100*perc, tIdx, length(t)));
    end
end

U = A \ F;

close(bh);

% -- Start plotting --
figure('Name', '2D FEM Plot');
hold on
camproj('perspective');
view(35, 30);

% Plot function outline and circle boundary
trimesh(t, p(:,1), p(:,2), Ugen(p(:,1), p(:,2)), 'FaceAlpha', .8);
fplot3(@(x) sin(pi*x), @(y) cos(pi*y), @(z) zeros(size(z)), ...
    'k', 'LineWidth', 2);

% Plot computed U on inner mesh points
innerPts = p(I,:);
plot3(innerPts(:,1), innerPts(:,2), U, 'x', 'LineWidth', 2);

path(oldpath);
