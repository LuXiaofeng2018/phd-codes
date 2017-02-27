function com = cscomb(n,r)
% CSCOMB Combination: n choose r
%   
%   COM = CSCOMB(N,R) Returns the number of combinations of N things
%   taken R at a time.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

% Both n and r must be positive integers.
if n < 0
    error('N must be a positive integer.')
end
if r < 0
    error('R must be a positive integer.')
end
if floor(n) ~= n
    error('N must be an integer.')
end
if floor(r) ~= r
    error('R must be an integer.')
end

if r > n
    error('R must be between 0 and n')
end

if n == 0
    com = 1;
    return
end
if r == 0
    com = 1;
    return
end

df = n-r;
tmp = max([df,r])+1;
num = prod(n:-1:tmp) ;
den = prod(2:min([df, r]));
com = num/den;
