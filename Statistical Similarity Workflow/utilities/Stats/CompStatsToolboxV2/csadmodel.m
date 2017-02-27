function r = csadmodel(X,y,alpha,deg)

% CSADMODEL     Additive models using LOESS
%
%	R = CSADMODEL(X,Y,ALPHA,DEGREE) Returns the partial residuals in R, 
%   for the predictors X and response Y. The smoothing method used is
%   LOESS.
%
%	INPUTS:		X is an n x d data matrix of predictor values
%				Y is a vector of response values
%				ALPHA and DEGREE are the parameters for LOESS
%
%   The ouput of this function is a matrix R of partial residuals,
%   evaluated at the observed predictor values.
%
%   Plots of the individual partial residuals are also produced.
%
%   EXAMPLE:
%
%   load gascons
%   X = [dispinc(:), pricegas(:), pricecars(:)];
%   r = csadmodel(X,gascons,2/3,1);
%
%   See also CSLOESS, CSLOESSR


%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

% Center the data first.
[n,d] = size(X);
yc = y - mean(y);
% Initialize some other arrays.
fcng = zeros(n,d);
r = zeros(n,d);

% The following implements the backfitting algorithm.
% Get the initial estimate using least-squares.
bhat = X\yc;
% Now use these as starting points for the individual
% component functions in additive models.
b = repmat(bhat',n,1);
fold = b.*X;
% Now start the iteration.
delta = 1;
I = 0;
% col = [1 0 0; 0 1 0; 0 0 1];
while delta >= 0.001
    I = I + 1;
    disp(['Iteration number ', int2str(I)])
    % Loop through the component functions and
    % smooth the partial residuals.
    for i = 1:d
        J = 1:d;
        % Form the i-th partial residual.
        J(i) = [];
        r(:,i) = yc(:) - sum(fold(:,J),2);
        % Smooth r_i against x_i.
        fnew = csloess(X(:,i),r(:,i),X(:,i),alpha,deg);
        % Now subtract the mean of the smooth.
        fnew = fnew - mean(fnew);
        fcng(:,i) = abs(fnew(:) - fold(:,i));
        fold(:,i) = fnew(:);
    end
    % Now check for convergence.
    delta = max(max(fcng));
    disp(['Max error is ', num2str(delta)]);
end

% Plot the partial residuals from the additive model.
for i = 1:d
    
    [xs,ind] = sort(X(:,i));
    ys = fold(ind,i);
    figure,plot(X(:,i),r(:,i),'o',xs,ys)
    xlabel(['X ', int2str(i)])
    ylabel('Partial Residuals')
%     axp = axis;
%     axis([axp(1:2) axt(3:4)])

end

