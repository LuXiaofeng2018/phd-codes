% Example 4.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

n = 1000;
t = 3;
lam = 2;
% Generate the uniforms needed. Each column
% contains the t uniforms for a realization of a
% gamma random variable.
U = rand(t,n);
% Transform according to Equation 4.13.
logU = -log(U)/lam;
X = sum(logU);

% now do the histogram
[N,h]=hist(X,10);
% change bar heights
N=N/(h(2)-h(1))/n;
% now get the theoretical pdf
x = 0:.1:6;
y = gampdf(x,t,1/lam);
bar(h,N,1,'w')
hold on
plot(x,y,'k')
hold off
