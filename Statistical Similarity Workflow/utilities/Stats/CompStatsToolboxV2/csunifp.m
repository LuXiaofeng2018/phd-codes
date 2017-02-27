function y = csunifp(x,a,b)
% CSUNIFP Uniform probability density function.
%
%	Y = CSUNIFP(X,A,B) Returns the value of the
%	probability density function for the uniform
%	distribution with parameters A and B at the
% 	domain locations given in X.
%
%	See also CSUNIFC, CSUNIFQ, CSUNIPAR

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


if a > b
   error('a represents the lower end of the interval')
   return
end

y=zeros(size(x));
ind = find(x>=a & x<=b);
y(ind) = 1/(b-a);
