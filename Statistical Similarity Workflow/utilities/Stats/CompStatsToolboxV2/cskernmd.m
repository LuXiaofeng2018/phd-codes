function prob = cskernmd(x,data,h)
% CSKERNMD	Product kernel.
%
%	PROB = CSKERNMD(X,DATA,H)
%	This returns the product kernel probability density estimate for a d-dimensional 
%	point x based on the data. Here, d >= 2.
%
%	X represents the point(s) in the domain where you want to get the value of the probability.
%	Thus, X is nn x d, where d is the dimensionality.
%	DATA is the n x d data matrix, where each row is an observation.
%	H is an optional vector of window widths, one for each dimension. The default is the
%	value obtained from the Normal Reference Rule.
%
%	See also CSKERN2D

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


[n,d]=size(data);
[nn,p] = size(x);
if d~=p
	error('Dimensionality of data must match dimensionality of x.')
	return
end
prob = zeros(1,nn);
arg = zeros(n,d);

if nargin == 2
	% Get the window widths using Scott's rule.
	tmp = (4/(n(d+2)))^(1/(d+4));
	h = zeros(1,d);
	s = cov(data);
	for i = 1:d
		h(i) = s(i,i)*tmp;
	end
end

for i=1:nn	% note that const done at end
	for j = 1:d
		xx = x(i,j)*ones(n,1);
		arg(:,j) = ((xx-data(:,j))/h(j)).^2;
	end
	prob(i)=sum(exp(-.5*sum(arg,2)))/(n*prod(h)*2*pi);
end


