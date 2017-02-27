% Example 9.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate standard normal random variables.
n = 10;
data = randn(1,n);
% We will get the density estimate at these x values.
x = linspace(-4,4,50);
fhat = zeros(size(x));
h = 1.06*n^(-1/5);
hold on
for i=1:n
   % get each kernel function evaluated at x
			% centered 		at data
   f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
   plot(x,f/(n*h));
   fhat = fhat+f/(n);
end
plot(x,fhat);
hold off
