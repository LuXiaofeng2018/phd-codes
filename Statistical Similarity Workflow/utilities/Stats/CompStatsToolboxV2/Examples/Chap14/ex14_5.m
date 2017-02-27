% Example 14.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up the preliminaries.
z1 = 125;
z2 = 18;
z3 = 20;
z4 = 34;
n = 1100;
	% Step size for the proposal distribution.
a = 0.1;	
% Set up the space to store values.
theta = zeros(1,n);
% Get an inline function to evaluate probability.
strg = '((2+th).^z1).*((1-th).^(z2+z3)).*(th.^z4)';
ptheta = inline(strg,'th','z1','z2','z3','z4');
% Use Metropolis-Hastings random-walk 
% where y = theta(i-1) + z
% and z is uniform(-a,a).
% Get initial value for theta.
theta(1) = rand(1);
for i = 2:n
		% Generate from proposal distribution.
		y = theta(i-1) - a + 2*a*rand(1);
		% Generate from uniform .
		u = rand(1);
		alpha = min([ ptheta(y,z1,z2,z3,z4)/...
				ptheta(theta(i-1),z1,z2,z3,z4),1]);
		if u <= alpha
			theta(i) = y;
		else
			theta(i) = theta(i-1);
		end
end
