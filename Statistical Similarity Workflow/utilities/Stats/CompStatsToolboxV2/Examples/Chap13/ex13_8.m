% Example 13.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


load vineyard
x = row;
y = totlugcount;
% Set some possible values for alpha.
alpha = 0.5:0.25:10;
CV = zeros(1,length(alpha));
for i = 1:length(CV);
    [x0,fhat,S] = cssplinesmth(x,y,alpha(i));
    num = y - fhat;
    den = 1 - diag(S);
    CV(i) = mean((num./den).^2);
end
% Find the minimum value of CV(alpha).
[m,ind] = min(CV);
% Find the corresponding alpha.
cvalpha = alpha(ind);

% Plot the CV function.
plot(alpha,CV)
