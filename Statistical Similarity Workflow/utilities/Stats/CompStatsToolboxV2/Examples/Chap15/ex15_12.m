% Example 15.12
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

npar = 15;
% Get the vertices for the regions.
rx = [0 1 1 0 0];
ry = [0 0 1 1 0];
rxp = [-.05 1.05 1.05 -.05 -.05];
ryp = [-.05 -.05 1.05 1.05 -.05];
% Get all of the parents.
[xp,yp] = csbinproc(rxp, ryp, npar);

lam = 15;
% Get the number of children per parent.
nchild = poissrnd(lam,1,npar);
X = [];
r = 0.05;
sig = r*eye(2);
% Locate the children.
for i = 1:npar
			xc = randn(nchild(i),2)*sig + ...
				repmat([xp(i) yp(i)],nchild(i),1);
			X = [X; xc];
end
% Find the ones that are in the region of interest.
ind = find(inpolygon(X(:,1), X(:,2), rx, ry));
% Those are the children for the sample.
x = X(ind,1);
y = X(ind,2);
