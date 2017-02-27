% Example 9.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First get the constants.
bin0 = [-4 -4];
n = 1000;
% Normal Reference Rule with sigma = 1. 
h=3*n^(-1/4)*ones(1,2);  
% Generate bivariate standard normal variables.
x = randn(n,2);
% Find the number of bins.
nb1 = ceil((max(x(:,1))-bin0(1))/h(1));
nb2 = ceil((max(x(:,2))-bin0(2))/h(2));
% Find the mesh or bin edges.
t1 = bin0(1):h(1):(nb1*h(1)+bin0(1));
t2 = bin0(2):h(2):(nb2*h(2)+bin0(2));
[X,Y] = meshgrid(t1,t2);

% Find bin frequencies. 
[nr,nc]=size(X);
vu = zeros(nr-1,nc-1);
for i=1:(nr-1)
		for j=1:(nc-1)
			xv = [X(i,j) X(i,j+1) X(i+1,j+1) X(i+1,j)];
			yv = [Y(i,j) Y(i,j+1) Y(i+1,j+1) Y(i+1,j)];
			in = inpolygon(x(:,1),x(:,2),xv,yv);
			vu(i,j) = sum(in(:));
		end
end
fhat = vu/(n*h(1)*h(2));
% Now get the bin centers for the frequency polygon.
% We add bins at the edges with zero height.
t1=(bin0(1)-h(1)/2):h(1):(max(t1)+h(1)/2);
t2=(bin0(2)-h(2)/2):h(2):(max(t2)+h(2)/2);
[bcx,bcy]=meshgrid(t1,t2);
[nr,nc]=size(fhat);
binh = zeros(nr+2,nc+2);  % add zero bin heights
binh(2:(1+nr),2:(1+nc))=fhat;
% Get points where we want to interpolate to get
% the frequency polygon.
[xint,yint]=meshgrid(linspace(min(t1),max(t1),30),...
   linspace(min(t2),max(t2),30));
fp = interp2(bcx,bcy,binh,xint,yint,'linear');
df1 = xint(1,2)-xint(1,1);
df2 = yint(2,1)-yint(1,1);
area = sum(sum(fp))*df1*df2;
