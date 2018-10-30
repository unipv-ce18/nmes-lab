function [ area ] = triarea( verts )
%TRIAREA Calculates the area of a triangle given its vertices
%   TRIAREA(AREA) calculates the area of a triangle, the result is
%   negative is the triangle is oriented clockwise.
%
%   See also POLYAREA

% Triangle area: det([v' w'])/2
% v = v2 - v1 and w = v3 - v1 are vectors defining the triangle
area = det([ diff(verts([1 2],:)); diff(verts([1 3],:)) ]') / 2;

end

