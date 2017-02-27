% Example 12.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load longley
bhat1 = inv(X'*X)*X'*Y;
bhat = X\Y;
