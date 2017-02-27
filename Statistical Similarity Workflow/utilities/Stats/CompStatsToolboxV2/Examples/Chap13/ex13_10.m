% Example 13.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load environmental
% Sort the x values.
[x,ind] = sort(Temperature);
y = Ozone(ind);
n = length(x);
B = 2000;

% Use arbitrary target values for the fit.
x0 = linspace(min(x),max(x),40);
yhat = csloess(x,y,x0,2/3,1);
% Create a matrix to keep the bootstrap
% regression fits. Each row will be a fit 
% evaluated at x_i. 
Bmat = zeros(B,length(x0));
for i = 1:B
    % Get the bootstrap sample.
    indB = unidrnd(n,1,n); % Statistics Toolbox
    yhatB = csloess(x(indB),y(indB),x0,2/3,1);
    Bmat(i,:) = yhatB;
end
% Sort the values in each column.
Bmats = sort(Bmat);
low = Bmats(0.025*B,:);
up = Bmats(0.975*B,:);

% Plot the smooth and the confidence bands
plot(x,y,'.',x0,yhat);
hold on
plot(x0,low,':',x0,up,':');
hold off
title('Local Polynomial Regression, alpha = 2/3')
xlabel('Temperature');
ylabel('Ozone');



