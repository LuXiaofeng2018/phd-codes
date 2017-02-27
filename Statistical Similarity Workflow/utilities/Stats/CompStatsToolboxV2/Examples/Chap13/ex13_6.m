% Example 13.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% Generate some data.
x = linspace(0, 4 * pi,100);
y = sin(x) + 0.75*randn(size(x));
h=1;
deg = 1;
% Set up inline function to get the weights.
mystrg = '(2*pi*h^2)^(-1/2)*exp(-0.5*((x - mu)/h).^2)';
wfun = inline(mystrg);
% Set up space to store the estimates.
yhatlin = zeros(size(x));
n = length(x);
% Find smooth at each value in x.
for i = 1:n
		w = wfun(h,x(i),x);
		xc = x-x(i);
		s2 = sum(xc.^2.*w)/n;
        
        s1 = sum(xc.*w)/n;
		s0 = sum(w)/n;
		yhatlin(i) = sum(((s2-s1*xc).*w.*y)/(s2*s0-s1^2))/n;
end

plot(x,y,'.',x,yhatlin)

