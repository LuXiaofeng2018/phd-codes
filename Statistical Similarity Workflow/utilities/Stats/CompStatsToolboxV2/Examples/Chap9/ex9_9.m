% Example 9.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Recall the model - normal components used.
mix = [0.3 0.3 0.4];  	% mixing coefficients
mus = [-3 0 2];			% term means
vars = [1 1 0.5];
nterm = 3;
t = 0:.05:2*pi+eps;  % values to create circle
% To get some scales right.
minx = -5;
maxx = 5;
scale = maxx-minx;
lim = [minx maxx minx maxx];
% Set up the axis limits.
figure
axis equal
axis(lim)
grid on
% Create and plot a circle for each term.
hold on
for i=1:nterm
   % rescale for plotting purposes
   ycord = scale*mix(i)+minx;  
   xc = mus(i)+sqrt(vars(i))*cos(t);
   yc = ycord+sqrt(vars(i))*sin(t);
   plot(xc,yc,mus(i),ycord,'*')
end
hold off
% Relabel the axis to show the right coefficient.
tick = (maxx-minx)/10;
set(gca,'Ytick',minx:tick:maxx)
set(gca,'XTick',minx:tick:maxx)
set(gca,'YTickLabel',... 
    '0|0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1')
xlabel('Means'),ylabel('Mixing Coefficients')
title('dF Plot for Univariate Finite Mixture')