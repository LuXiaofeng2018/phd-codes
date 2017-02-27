function csexpoplot(x)
% CSEXPOPLOT Exponential probability plot.
%
%   CSEXPOPLOT(X) Constructs an exponential probability plot
%   based on the sample given in X. A line is also drawn
%   that is obtained from the first and third sample quartiles.
%
%   EXAMPLES:
%
%   csbinoplot(csexprnd(100,1))
%   csbinoplot(rand(100,1))
%   csbinoplot(randn(100,1))
%
%   See also CSEXPOP, CSEXPOC, CSEXPOQ, CSEXPAR, CSEXPRND

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


n = length(x);

% Sort the x to plot versus the exponential quantiles.
sx= sort(x);

% Get some range information to construct the axes for plotting.
minx  = min(x);
maxx  = max(x);
range = maxx-minx;
minxaxis  = minx-0.025*range;
maxxaxis  = maxx+0.025*range;

% Get the associated exponential quantiles.
prob = [0.5./n:1./n:(n - 0.5)./n];
y  = csexpoq(prob,1)';

% Get some stuff for plotting purposes.
p     = [0.001 0.003 0.01 0.02 0.05 0.10 0.25 0.5...
         0.75 0.90 0.95 0.98 0.99 0.997 0.999];
label1= str2mat('0.001','', '','','','','0.25 ','0.50');
label2= str2mat('0.75','0.90','0.95','0.98','0.99','0.997', '0.999');
label = [label1;label2];
tick  = csexpoq(p,1);

% Get the information to do the line between the outer quartiles.
qx1 = csquantiles(x,.25);
qx3 = csquantiles(x,.75);
qy1 = csquantiles(y,.25);
qy3 = csquantiles(y,.75);
qx = [qx1, qx3];
qy = [qy1, qy3];

% fit the line.
qfit = polyfit(qx,qy, 1);

% Get the points of the line to plot.
xL = [minx, maxx];
qval = polyval(qfit, xL);

% Plot the points and the line.
plot(sx,y,'+',xL,qval);

% Do a little bit of Handle Graphics.
minyaxis  = csexpoq(0.25 ./n,1);
maxyaxis  = csexpoq((n-0.25) ./n,1);
set(gca,'YTick',tick,'YTickLabel',label);
set(gca,'YLim',[minyaxis maxyaxis],'XLim',[minxaxis maxxaxis]);
xlabel('Data');
ylabel('Probability');
title('Exponential Probability Plot');


