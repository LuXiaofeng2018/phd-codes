% Example 4.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate multivariate normal random variables.
R = [1 -.8; -.8 1];  % Correlation matrix. 
df = 5;
d = 2;
n = 500;
% Generate n 2-D multivariate normal random
% variables, centered at 0, with covariance C. 
C = chol(R);
Xnorm = randn(n,d)*C;
% Generate chi-square random variables and
% divide by the degrees of freedom.
Xchi = sqrt(chi2rnd(df,n,1)./df);
% Divide to get the multivariate t random variables.
Xt = Xnorm./repmat(Xchi(:),1,d);
% Do a scatterplot.
plot(Xt(:,1),Xt(:,2),'.');
xlabel('X_1');ylabel('X_2');
title('Multivariate t Random Variables with \nu = 5')

% Check the correlation using the following:
corrcoef(Xt)

