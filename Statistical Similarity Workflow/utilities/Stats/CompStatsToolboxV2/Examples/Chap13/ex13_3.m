% Example 13.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


load environ
% Do a scatterplot of the data to see the relationship.
plot(wind,ozone,'k.')
xlabel('Wind Speed (MPH)'),ylabel('Ozone (PPB)')

n = length(wind); % Find the number of data points
x0 = 10; % Find the estimate at this point
alpha = 2/3;
lambda = 1;		
k = floor(alpha*n);

% First step is to get the neighborhood. 
dist = abs(x0 - wind);
[sdist,ind] = sort(dist);
% Fet the points in the neighborhood.
Nx = wind(ind(1:k));							
Ny = ozone(ind(1:k));
delxo = sdist(k);  % Maximum distance of neighborhood

% Delete the ones outside the neighborhood.
sdist((k+1):n) = []; 								
% These are the arguments to the weight function.
u = sdist/delxo;
% Get the weights for all points in the neighborhood.
w = (1 - u.^3).^3;

% Now using only those points in the neighborhood,
% do a weighted least squares fit of degree 1.
% We will follow the procedure in 'polyfit'.
x = Nx(:); y = Ny(:); w = w(:);
W = diag(w);					% get weight matrix
A = vander(x);						% get right matrix for X
A(:,1:length(x)-lambda-1) = [];
V = A'*W*A;
Y = A'*W*y;
[Q,R] = qr(V,0); 
p = R\(Q'*Y); 
p = p';				% to fit MATLAB convention
% This is the polynomial model for the local fit.
% To get the value at that point, use polyval.
yhat0 = polyval(p,x0);

% Now call the loess procedure and plot the result.
% Get a domain over which to evaluate the curve.
x0 = linspace(min(wind),max(wind),50);
yhat = csloess(wind,ozone,x0,alpha,lambda);
% Plot the results.
plot(wind,ozone,'k.',x0,yhat,'k')
xlabel('Wind Speed (MPH)'),ylabel('Ozone (PPB)')
