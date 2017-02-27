% Example 13.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load gascons
% Put all of the observations into one data matrix.
% Center the data first.
x1 = dispinc;
x2 = pricegas;
x3 = pricecars;
X = [x1(:),x2(:),x3(:)];
[n,d] = size(X);
yc = gascons - mean(gascons);
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
col = [1 0 0;0 1 0; 0 0 1];
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
        fnew = csloess(X(:,i),r(:,i),X(:,i),2/3,1);
        % Now subtract the mean of the smooth.
        fnew = fnew - mean(fnew);
        fcng(:,i) = abs(fnew(:) - fold(:,i));
        fold(:,i) = fnew(:);
    end
    % Now check for convergence.
    delta = max(max(fcng));
    disp(['Max error is ', num2str(delta)]);
end


% Construct the plots.
% Get a loess smooth of the price index and
% consumption.
figure
[inds, ind] = sort(pricegas);
pricegas = pricegas(ind);
gascons = gascons(ind);
yhatloess = csloess(pricegas,gascons,pricegas,0.6,2);
plot(pricegas,gascons,'.',pricegas,yhatloess)
% Plot the partial residuals from the additive model.
figure
[xs,ind] = sort(X(:,1));
ys = fold(ind,1);
plot(X(:,1),r(:,1),'o',xs,ys)
axt = axis;
xlabel('Disposable Income')
ylabel('Partial Residuals')
[xs,ind] = sort(X(:,2));
ys = fold(ind,2);
figure,plot(X(:,2),r(:,2),'o',xs,ys)
xlabel('Gasoline Price Index')
ylabel('Partial Residuals')
axp = axis;
axis([axp(1:2) axt(3:4)])
[xs,ind] = sort(X(:,3));
ys = fold(ind,3);
figure,plot(X(:,3),r(:,3),'o',xs,ys)
xlabel('Used Cars Price Index')
ylabel('Partial Residuals')
axp = axis;
axis([axp(1:2) axt(3:4)])

