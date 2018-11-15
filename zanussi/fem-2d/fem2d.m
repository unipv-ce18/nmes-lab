%% 2D FEM algorithm implementation

% Generate the mesh (and close that popup)
oldpath = addpath('./vendor', './vendor/distmesh');
[p, t, I, B] = triangular_mesh('circle', .05);
close(1);
path(oldpath);

% Select a function to plot, it would be ideal to extract the
% real fem2d algorithm to a function but it adds complexity/I am lazy
if ~exist('FUN_SEL', 'var'); FUN_SEL = 'default'; end
switch FUN_SEL
    case 'exercise'
        % Functions as given by the exercise
        Ugen = @(x,y) -1/4*(x.^2+y.^2)+1/4;
        Fgen = @(x,y) 1;
        homo = true;

    case 'not_homo'
        % Use exercise function with non-zero boundary condition,
        % we can simply sum a linear component to that U in order to
        % test our method without altering F.
        % (laplacian ~ 2nd derivative, of linear = 0)
        Ugen = @(x,y) -1/4*(x.^2+y.^2)+1/4+1/4*x;
        Fgen = @(x,y) 1;
        homo = false;

    otherwise
        % Use my default function, we need symbolic math
        % to compute the exact laplacian for reference
        syms x y;
        UgenSym(x, y) = sin(4*pi*sqrt(x^2+y^2))/sqrt(x^2+y^2);

        Ugen = matlabFunction(UgenSym);
        Fgen = matlabFunction(-laplacian(UgenSym, [x y]));
        homo = true;

end

% Allocate A and F and initialize to zero
% (statistically nnz(A)/length(A) ~ 6.6)
% If we are working with zero boundary (homogeneous),
% we can exclude calculation on these points.
if homo; dof = length(I); else; dof = length(p); end
A = spalloc(dof, dof, 7*dof);
F = zeros(dof, 1);

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
    fVal = 1/3 * Fgen(bary(1), bary(2)) * area;

    % If boundary = 0, we can iterate only on the points *inside* the mesh
    if homo
        verts = intersect(tDef, I, 'stable');
    else
        verts = tDef;
    end

    for i = verts
        % Opposite edge length: rotate the triangle array until the current
        % vertex is first, then take the difference between the last 2 pts.
        iIdx = find(tDef == i);
        iCoordsSort = circshift(tCoords, -iIdx+1);
        ei = diff(iCoordsSort(2:end,:));

        for j = verts
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

% In case of non-homogeneous system,
% we need to update A and F with boundary information
if ~homo
    for v = B
        A(v,:) = 0;
        A(v,v) = 1;
        F(v) = Ugen(p(v,1), p(v,2));
    end
end

% See course slides on how to recover symmetry on the last step,
% thus giving a faster calculation of U.
U = A \ F;

close(bh);

% -- Start plotting --
figure('Name', '2D FEM Plot');
hold on
camproj('perspective');
view(35, 30);

% Plot function outline and circle boundary
trimesh(t, p(:,1), p(:,2), Ugen(p(:,1), p(:,2)), 'FaceAlpha', .8);

ordB = [fixpoly(p, B) B(1)];
plot3(p(ordB,1), p(ordB,2), Ugen(p(ordB,1), p(ordB,2)), ...
    'k', 'LineWidth', 2);

% Plot computed U on used mesh points
if homo; pts = p(I,:); else; pts = p; end
plot3(pts(:,1), pts(:,2), U, 'x', 'LineWidth', 2);

% That's all folks!

