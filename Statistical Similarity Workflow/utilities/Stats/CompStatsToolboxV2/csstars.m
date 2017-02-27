function csstars(data,labels)
% CSSTARS Star plot.
%
%   CSSTARS(X,LABELS) Constructs a star plot for the data
%   given in X. X must be an n x d matrix, where each row
%   corresponds to an observation. 
%
%   The optional argument LABELS contains a cell array of 
%   strings where each element is a label for one observation.
%
%   See also CSPARALLEL, CSANDREWS

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

clf
[n,p]=size(data);
ncol=floor(sqrt(n));
nrow=ceil(n/ncol);

% translate data so there are no negatives. The data will
% go from 1 to 1+range of entire data set
md = min(data(:));
mmd = repmat(md,n,p);
data = 1 + data-mmd;

theta = linspace(0,2*pi,p+1); % get angles linearly spaced, do not use the last point
theta(end)=[];
k=0;
for i = 1:n
      k=k+1; 
      r=data(k,:); % get the observation for plotting
      [x,y]=pol2cart(theta,r);
      X=x(:);  % make col vectors
      Y=y(:);
      X = [zeros(p,1) X]; % add 0's to emanate from center
      Y = [zeros(p,1) Y];
      x = [x(:); x(1)];
      y = [y(:); y(1)];
      subplot(nrow,ncol,k),
      patch(x,y,'w')
      hold on
      plot(X(1,:),Y(1,:))
      for ii =2:p
   		plot(X(ii,:),Y(ii,:))
      end
      % goofy way to get the plots on a common axis.
      ax = axis;
      axX(k,:) = ax(1:2);
      axY(k,:) = ax(3:4);
      if nargin==2
         title(labels{k})
      end
      hold off
end
% NOw put all on the same axis scale.
% Get the values.
AXS = [min(axX(:)) max(axX(:)) min(axY(:)) max(axY(:))]; 
for k = 1:(nrow*ncol)
    subplot(nrow,ncol,k)
    axis(AXS)
    axis equal
    axis off
end


      




