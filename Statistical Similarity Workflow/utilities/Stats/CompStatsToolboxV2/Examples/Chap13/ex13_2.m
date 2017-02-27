% Example 13.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load vineyard
n = length(row);
y = totlugcount;
% Set the number of data points in each window.
% Use symmetric neighborhoods of size 2N+1.
N = 3;
smth = zeros(1,n);
smth(1) = mean(y(1:1+N));
smth(end) = mean(y(n-N:n));
for i = (N+1):(n-N)
    smth(i) = mean(y(i-N:i+N));
end
% Find the lower end of the smooth, 
% using as many to the left as possible.
for i = 2:N
    smth(i) = mean(y(1:i+N));
end
% Find the upper end of the smooth,
% using as many to the right as possible.
for i = (n-N+1):(n-1)
    smth(i) = mean(y(i-N:end));
end


figure
plot(row,totlugcount,'o',row,smth)
xlabel('Row'),ylabel('Total Number of Lugs')

