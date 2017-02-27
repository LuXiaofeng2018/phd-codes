% Example 13.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% To smooth using the bin smoother, one sets the number of bins first,
% and then chooses the cutoff points so each region has approximately the
% same number of data points. So, the number of bins is the smoothing
% parameter, but this gives rise to the span - the proportion of points in
% each neighborhood. 


load vineyard
y = totlugcount;
x = row;
n = length(x);

% Set the number of bins and the number of 
% observations in each one.
K = 10;
nk = ones(1,K)*floor(n/K);
rm = rem(n,K);
if rm ~= 0
    nk(1:rm) = nk(1:rm) + 1;
end
nk = cumsum(nk);

% Sort the data.
[xsort,inds] = sort(x);
ys = y(inds);
% Find the c_k and the value of the smooth in each.
ck = xsort(1);
ck(K+1) = xsort(end);
smth = zeros(1,K+1);
smth(1) = mean(ys(1:nk(1)));
for i = 1:(K-1)
    ck(i+1) = mean(xsort(nk(i):nk(i)+1));
    smth(i+1) = mean(ys(nk(i)+1:nk(i+1)));
end
smth(end) = smth(end-1);

plot(x,y,'o');
xlabel('Row'),ylabel('Total Number of Lugs')
hold on
stairs(ck,smth)
hold off

