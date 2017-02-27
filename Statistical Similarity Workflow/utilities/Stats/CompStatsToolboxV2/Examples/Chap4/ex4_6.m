% Example 4.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set up the parameters.
lam = 2;
n = 1000;
% Generate the random variables.
uni = rand(1,n);
X = -log(uni)/lam;

% Get the values to draw the theoretical curve.
x=0:.1:5;
% This is a function in the Statistics Toolbox.
y=exppdf(x,1/2);
% Get the information for the histogram.
[N,h]=hist(X,10);
% Change bar heights to make it correspond to
% the theoretical density - see Chapter 5.
N=N/(h(2)-h(1))/n;
% Do the plots.
bar(h,N,1,'w')
hold on
plot(x,y)
hold off
xlabel('X')
ylabel('f(x) - Exponential')