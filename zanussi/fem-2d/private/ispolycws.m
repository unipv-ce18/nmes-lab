function y = ispolycws( vs )
%ISPOLYCWS Is path clockwise, standalone
%   ISPOLYCWS(V) accepts an Nx2 matrix, each row representing a
%   point of the polygon; returns logical true if the given poly
%   is clockwise-oriented.
%
%   ISPOLYCWS should work similarly to ISPOLYCW, provided by the
%   MATLAB Mapping Toolbox.
%
%   See also ISPOLYCW

% https://stackoverflow.com/a/1165943
a = [vs(2:end,1); vs(1,1)];
b = vs(:,1);
c = [vs(2:end,2); vs(1,2)];
d = vs(:,2);

y = sum((a-b).*(c+d)) > 0; % if < 0 then is ccw
end
