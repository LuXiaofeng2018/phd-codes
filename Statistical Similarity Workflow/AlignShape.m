% ------------------------------------------------------------------------
% align and normalize shapes using
% Source points, Orientation, Edges
% Input: 
%       Source Points
%       Edges
%       Orientations
% Ooutput:
%       Aligned edge of shapes
function [NEdge] = AlignShape (SP,Theta,Edge)
% unit horizontal vector
uv = [0 1 0];
% source point
si = SP(1);sj = SP(2);
% centroid
c = mean(Edge,1);
% generate 
Theta = Theta(2,:)-Theta(1,:);
v = [Theta 0];
% uniform scaling
s = sqrt(mean((Edge(:,1)-si).^2 + (Edge(:,2)-sj).^2));
NEdge(:,1)= (Edge(:,1)-si)/s;NEdge(:,2)= (Edge(:,2)-sj)/s;

r = vrrotvec(v, uv);
R = vrrotvec2mat(r);

NEdge = [NEdge zeros(size(NEdge,1),1)];
NEdge = (R*NEdge')'; NEdge = NEdge(:,1:2);
end