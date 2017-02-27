% Example 2.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% get the mean and covariance
mu = zeros(1,2);
cov_mat = eye(2);% Identity matrix
% get the domain
% should range (-4,4) in both directions
[x,y]=meshgrid(-4:.2:4,-4:.2:4);
% reshape into the proper format for the function
X=[x(:),y(:)];
Z = csevalnorm(X,mu,cov_mat);
% now reshape the matrix for plotting
z=reshape(Z,size(x));
subplot(1,2,1) % plot the surface
surf(x,y,z),axis square, axis tight
title('BIVARIATE STANDARD NORMAL')
subplot(1,2,2) % look down on the surface
pcolor(x,y,z),axis square
title('BIVARIATE STANDARD NORMAL')

% now do the same thing for a covariance matrix
% with non-zero off-diagonal elements
cov_mat = [1 0.7 ; 0.7 1];
Z=csevalnorm(X,mu,cov_mat);
z=reshape(Z,size(x));
subplot(1,2,1)
surf(x,y,z),axis square, axis tight
title('BIVARIATE NORMAL')
subplot(1,2,2)
pcolor(x,y,z),axis square
title('BIVARIATE NORMAL')

