% Example 10.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% This loads up three matrices: 
% setosa, virginica and versicolor
% We will use the product kernel to estimate densities. 
% To try this, get the kernel estimate for the first 
% two features and plot.
% The arguments of 0.1 indicate the grid size in
% each dimension. This creates the domain over 
% which we will estimate the density.
[xset,yset,pset]=cskern2d(setosa(:,1:2),0.1,0.1);
[xvir,yvir,pvir]=cskern2d(virginica(:,1:2),0.1,0.1);
[xver,yver,pver]=cskern2d(versicolor(:,1:2),0.1,0.1);
mesh(xvir,yvir,pvir)
colormap(gray(256))


% If one needs the value of the probability curve,
% then use this.
ps = cskernmd(setosa(1,1:2),setosa(:,1:2));
pver = cskernmd(setosa(1,1:2),versicolor(:,1:2));
pvir = cskernmd(setosa(1,1:2),virginica(:,1:2));