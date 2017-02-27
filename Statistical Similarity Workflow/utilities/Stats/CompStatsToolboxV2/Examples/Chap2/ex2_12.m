% Example 2.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First set up a correlation matrix with high
% negative correlation.
Rneg = [1, -0.8; -0.8, 1];
nu = 5;
% Get the domain for the pdf.
x = -4:.1:4; 
y = -4:.1:4;
[X,Y] = meshgrid(x,y);
% Evaluate the pdf.
z = mvtpdf([X(:) Y(:)],Rneg,nu);
% Reshape to a matrix and plot.
z = reshape(z,length(x),length(y));
surf(x,y,z);
xlabel('x'); 
ylabel('y'); 
zlabel('f(x,y)');
title('Bivariate t')
axis tight
