% Example 13.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate some noisy data.
x = linspace(0, 4 * pi,100);
y = sin(x) + 0.75*randn(size(x));

% Create an inline function to evaluate the weights.
mystrg='(2*pi*h^2)^(-1/2)*exp(-0.5*((x - mu)/h).^2)';
wfun = inline(mystrg);

% Set up the space to store the estimated values.
% We will get the estimate at all values of x.
yhatnw = zeros(size(x));
n = length(x);
% Set the window width.
h = 1;
% find smooth at each value in x
for i = 1:n
		w = wfun(h,x(i),x);
		yhatnw(i) = sum(w.*y)/sum(w);
end

% Plot the observations and the smooth.
plot(x,y,'.',x,yhatnw)

