% Example 14.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up some constants and arrays to store things.
n = 6000;
xar = zeros(n,2);						 % to store samples 
mu = [1;2];						% Parameters - target distribution.
covm = [1 0.9; 0.9 1];

% Set up the function to evaluate alpha 
% for this problem. Note that the constant
% has been canceled.
strg = 'exp(-0.5*(x-mu)''*inv(covm)*(x-mu))';
norm = inline(strg,'x','mu','covm');

% Generate starting point.
xar(1,:) = randn(1,2);
	for i = 2:n
        i
		% Get the next variate in the chain.
		% y is a col vector.
		y = mu - (xar(i-1,:)'-mu) + (-1+2*rand(2,1)); 	
		u = rand(1);
		% Uses inline function ‘norm’ from above.
		alpha=min([1,norm(y,mu,covm)/...
					norm(xar(i-1,:)',mu,covm)]);
		if u <= alpha
			xar(i,:) = y';
		else
			xar(i,:) = xar(i-1,:);
		end
end