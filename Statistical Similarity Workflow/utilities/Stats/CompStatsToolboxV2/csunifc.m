function y = csunifc(x,a,b)
% CSUNIFC Uniform cumulative distribution function.
%
%	Y = CSUNIFC(X,A,B) Returns the values of the uniform
% 	cumulative distribution function with parameters
%	A and B at the domain locations given in X.
%
%	See also CSUNIFP, CSUNIFQ, CSUNIPAR

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


if a > b
   error('A must be less than B.')
   return
end

y=zeros(size(x)); 
ind = find(x>=b);
y(ind)=1;
ind = find(x>=a & x<=b);
y(ind)=(x(ind)-a)/(b-a);
