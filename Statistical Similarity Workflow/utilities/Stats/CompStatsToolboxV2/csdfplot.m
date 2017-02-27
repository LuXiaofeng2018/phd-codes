function csdfplot(mu,var,mix_cof,minx,maxx)
% CSDFPLOT  Construct a dF plot for finite mixtures.
%
%   CSDFPLOT(MU,COVM,WGTS,MINX,MAXX)
%   This function will construct plots of mixtures in dF space
%   for univariate, bivariate and tri
%   
%   INPUTS: MU: array of d-dimensional means. Each column is a
%           mean for one component density. Thus, MU is a d x c
%           matrix, where c is the number of component densities.
%
%           COVM: For the 1-D case, this is a vector of c variances.
%           For 2-D and 3-D, COVM is a 3-D array of covariances, one
%           on each page. Thus, COVM is a d x d x c array.
%
%           WGTS: This is a c-dimensional vector of weights or
%           mixing coefficients.
%
%           MINX/MAXX: Needed only for the univariate case. These are 
%           typically 
%
%   EXAMPLES: 
%           % To plot a 2-component univariate mixture.
%           mu = [-3 3];
%           wts = [0.3, 0.7];
%           covm = [1, 1];
%           minx = -6;
%           maxx = 6;
%           csdfplot(mu,covm,wts,minx,maxx)
%
%           % To plot a 2-component bivariate mixture.
%           mu = [-3 3;
%                 -3 3];
%           wts = [0.3, 0.7];
%           covm(:,:,1) = 3*eye(2);
%           covm(:,:,2) = eye(2);
%           csdfplot(mu,covm,wts)
%
%           % To plot 2-component trivariate mixture.
%           mu = [-3 3;
%                -3 3;
%                -3 3];
%           wts = [0.3, 0.7];
%           covm(:,:,1) = 3*eye(3);
%           covm(:,:,2) = eye(3);
%           csdfplot(mu,covm,wts)

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

% get the dimensionality of the data
[d,c]=size(mu);	% each col of mu is a d-dimensional mean

if d==1	% then that is univariate case
   
   if nargin ~= 5
      error('You forgot the input arguments for the smallest x and the largest x')
   end
      
   % set up the axis
   ax=([minx maxx minx maxx]);
   scale=maxx-minx;
   clf
   hold on
   for i=1:c
      ycord=scale*mix_cof(i)+minx;
      circle(mu(i),ycord,sqrt(var(i)));
      plot(mu(i),ycord,'*')		%plot center
      drawnow
   end
   hold off
   axis equal
   axis(ax)
   grid on
   set(gca,'ytick',[linspace(minx,maxx,11)])
   set(gca,'YTickLabel',[' 0';'.1';'.2';'.3';'.4';'.5';'.6';'.7';'.8';'.9';' 1'])
   xlabel('Mean')
   ylabel('Mixing Coefficient')
   
elseif d==2		% bivariate case
   
   clf
   hold on
   for j=1:c
      [x,y]=emellip(mu(:,j),inv(var(:,:,j)));
      plot(x,y);  % tested
      plot(mu(1,j),mu(2,j),'*')
      text(mu(1,j),mu(2,j),num2str(mix_cof(j)))
      drawnow
   end   % for j loop
   set(gca,'Box','on')
   grid on
   xlabel('Mu_x')
   ylabel('Mu_y')
   hold off
   title('Bivariate df Plot')
   axis equal
   
elseif d==3
   col_map=jet(30);
   colormap(col_map)
   clf
   hacube= axes('units','normalized','position',[.1 .12 .8 .63]);
   axis vis3d
   axis equal
    view(3)
   hold on
   for j=1:c
      [x,y,z]=elipsoid(mu(:,j),inv(var(:,:,j)));
      h=surface(x,y,z,'FaceColor',col_map(fix(29*mix_cof(j))+1,:),'Parent',hacube);
   end   % for j loop
   xlabel('Mu_x'),ylabel('Mu_y'),zlabel('Mu_z')
   grid on
   box on
   hacol= axes('position',[.1 .85 .8 .1],'units','normalized');
   pcolor([1:30;1:30])
   set(hacol,'XTick',[15 30],'XTickLabel',['.5';' 1'])
   set(hacol,'YTick',[])
   ylabel('Mix Coefs')
   axes(hacube)

	
else
   
   error('Dimensionality of data must be 1, 2, or 3')
   
end

% It will draw a circle given
% center and the radius.
% function = circle(xc,yc,r)
function circle(xc,yc,r)
t=0:.05:2*pi+eps;
x=xc+r*cos(t);
y=yc+r*sin(t);
% plot(x,y,'m-')
line(x,y,'color','k')

% function [xout,yout]=emellip(mu,mat)
function [xout,yout]=emellip(mu,mat)
[v,d]=eig(mat);	% use to diagonalize 
t=0:.02:2.2*pi;
eigval=diag(d);
% this will be in regular coordinates
x=cos(t)/sqrt(eigval(1));
y=sin(t)/sqrt(eigval(2));
% now rotate values according to the cov matrix
data=zeros(length(x),2);
data(:,1)=x';
data(:,2)=y';
datarot=data*v';
xout=datarot(:,1)+mu(1);
yout=datarot(:,2)+mu(2);

% This file will return values to plot an
% ellipsoid surface in 3-dimensions
% the inputs are the location of the center
% (3 elements) and a 3x3 positive definite
% matrix denoting the covariance structure (usually)
% This was adapted from sphere.m provided with matlab.
% function [xout,yout,zout]=elipsoid(mu,var_mat)

function [xout,yout,zout]=elipsoid(mu,mat)
n=20;	% spacing
theta=(-n:2:n)/n*pi;
phi=(-n:2:n)'/n*pi/2;
cosphi=cos(phi);cosphi(1)=0;;cosphi(n+1)=0;
sintheta=sin(theta);sintheta(1)=0;sintheta(n+1)=0;
% get the axes of the ellipsoid
[v,d]=eig(mat);
eigval=diag(d);
xout=cosphi*cos(theta)/sqrt(eigval(1));
yout=cosphi*sintheta/sqrt(eigval(2));
zout=sin(phi)*ones(1,n+1)/sqrt(eigval(3));
%new code 10/13/94
lo=length(xout);
data=zeros(lo*lo,3);
data(:,1)=reshape(xout,lo*lo,1);
data(:,2)=reshape(yout,lo*lo,1);
data(:,3)=reshape(zout,lo*lo,1);
datarot=data*v';
xouttemp=datarot(:,1)+mu(1);
youttemp=datarot(:,2)+mu(2);
zouttemp=datarot(:,3)+mu(3);
xout=reshape(xouttemp,lo,lo);
yout=reshape(youttemp,lo,lo);
zout=reshape(zouttemp,lo,lo);
