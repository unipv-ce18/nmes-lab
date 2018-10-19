function [n, h] = ptsinfo( pts )
%PTSINFO Returns size of array and item spacing
%   [SZ,N] = PTSINFO(PTS), spacing is in SZ and size is N

[n, ~] = size(pts);
h = pts(2) - pts(1);  
end
