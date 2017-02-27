% Example 15.6
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez
clear;close all;clc;
load cardiff
% Loads data in x and y and region in cardpoly.
% Get the scales or distances for K_hat.
d = 1:30;
X = [x,y];
% Get the estimate of K_hat.
khat = cskhat(X, cardpoly, d);

% Plot the khat function along with the K-function
% under CSR. Shows clustering because
% khat is above the curve.
plot(d,pi*d.^2,'k',d,khat,'k.')
xlabel('Distances - d')
ylabel('K Function')

% Get the lhat function.
% Positive peaks - clustering at all of these scales.
% Clustering shown at d = 10, showing possible 
% clustering at that scale.
lhat = sqrt(khat/pi) - d;
plot(d,lhat,'k')
xlabel('Distances - d')
ylabel('Lhat')
