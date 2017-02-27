% Example 6.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First load up a synthetic data set. 
% This has structure
% in two planes - clusters.
% Note that the data is in 
% ppdata.mat
load ppdata
% For mrandom starts, find the best projection plane
% using N structure removal procedures.
% Two structures.
N = 2;	
% Four random starts.
m = 4;	
c = tan(80*pi/180);
% number of steps with no increase
half = 30;
[n,d] = size(X);

% To store the N structures:
astar = zeros(d,N);
bstar = zeros(d,N);
ppmax = zeros(1,N);

% Sphere the data.
muhat=mean(X);
[V,D]=eig(cov(X));
Xc=X-ones(n,1)*muhat;
Z=((D)^(-1/2)*V'*Xc')';

% Now do the PPEDA.
% Find a structure, remove it,
% and look for another one.
Zt = Z;
for i=1:N
			[astar(:,i),bstar(:,i),ppmax(i)] =...
        csppeda(Zt,c,half,m);
   % Now remove the structure.
   Zt = csppstrtrem(Zt,astar(:,i),bstar(:,i));
end

% Now project and see the structure.
proj1 = [astar(:,1), bstar(:,1)];
proj2 = [astar(:,2), bstar(:,2)];
Zp1 = Z*proj1;
Zp2 = Z*proj2;
figure
plot(Zp1(:,1),Zp1(:,2),'k.'),title('Structure 1')
xlabel('\alpha^*'),ylabel('\beta^*')
figure
plot(Zp2(:,1),Zp2(:,2),'k.'),title('Structure 2')
xlabel('\alpha^*'),ylabel('\beta^*')
