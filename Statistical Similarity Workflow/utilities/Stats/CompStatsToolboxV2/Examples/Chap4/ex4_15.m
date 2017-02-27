% Example 4.15
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

N = 5;
n = 500;
x = csdunrnd(N,n);
% Determine the estimated relative frequencies
relf = zeros(1,N);
for i = 1:N
   relf(i) = length(find(x==i))/n;
end
