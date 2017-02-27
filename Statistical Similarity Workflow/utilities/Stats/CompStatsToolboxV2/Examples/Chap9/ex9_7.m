% Example 9.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% create a bivariate data matrix with all three species
data=[setosa(:,1:2)];
data(51:100,:)=versicolor(:,1:2);
data(101:150,:)=virginica(:,1:2);
% Get the window width using the Normal Ref Rule.
[n,p] = size(data);
s = sqrt(var(data));
hx = s(1)*n^(-1/6);
hy = s(2)*n^(-1/6);
% Get the ranges for x and y & construct grid.
num_pts = 30;
minx = min(data(:,1));
maxx = max(data(:,1));
miny = min(data(:,2));
maxy = max(data(:,2));
gridx = ((maxx+2*hx)-(minx-2*hx))/num_pts
gridy = ((maxy+2*hy)-(miny-2*hy))/num_pts
[X,Y]=meshgrid((minx-2*hx):gridx:(maxx+2*hx),...
				(miny-2*hy):gridy:(maxy+2*hy));
x = X(:);   %put into col vectors
y = Y(:);
z = zeros(size(x));									
for i=1:length(x)									
			xloc = x(i)*ones(n,1);
			yloc = y(i)*ones(n,1);
			argx = ((xloc-data(:,1))/hx).^2;
			argy = ((yloc-data(:,2))/hy).^2;
			z(i) = (sum(exp(-.5*(argx+argy))))/(n*hx*hy*2*pi);
end
[mm,nn] = size(X);
Z = reshape(z,mm,nn);

area = sum(sum(Z))*gridx*gridy;
