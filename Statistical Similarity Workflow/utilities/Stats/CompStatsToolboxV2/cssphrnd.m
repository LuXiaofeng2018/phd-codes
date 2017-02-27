function X = cssphrnd(n,d)
% CSSPHRND Generate random variables on the sphere.
%
%   R = CSSPHRND(N,D) Generates N random variables
%   that are distributed on the d-dimensional unit
%   sphere, where d >= 2. 

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if d < 2
   error('ERROR: d > = 2')
   return
end
% generate standard normal random variables
tmp = randn(d,n);
% find the magnitude of each row
% square each element, add and take the square root 
mag = sqrt(sum(tmp.^2));
% make a diagonal matrix of them - inverses
dm = diag(1./mag);
% multiply to scale properly
X = (tmp*dm)';