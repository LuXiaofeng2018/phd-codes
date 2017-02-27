% Example 10.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This illustrates the 1-D case for two classes.
% We will shade in the area where there can be 
% misclassified observations.
% Get the domain for the densities.
dom = -6:.1:8;
dom = dom';
% Note: could use csnormp or normpdf.
pxg1 = csevalnorm(dom,-1,1);
pxg2 = csevalnorm(dom,1,1);
plot(dom,pxg1,dom,pxg2)
% Find decision regions - multiply by priors
ppxg1 = pxg1*0.6;
ppxg2 = pxg2*0.4;
plot(dom,ppxg1,'k',dom,ppxg2,'k')
xlabel('x')

x = -0.75;
% Evaluate each un-normalizd posterior.
po1 = csevalnorm(x,-1,1)*0.6;
po2 = csevalnorm(x,1,1)*0.4;

% To get estimates of the error, we can 
% estimate the integral as follows
% Note that 0.1 is the step size and we 
% are approximating the integral using a sum.
% The decision boundary is where the two curves meet.
ind1 = find(ppxg1 >= ppxg2);
% Now find the other part.
ind2 = find(ppxg1<ppxg2);
pmis1 = sum(ppxg1(ind2))*.1;
pmis2 = sum(ppxg2(ind1))*.1;
errorhat = pmis1 + pmis2;