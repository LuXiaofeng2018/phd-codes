% ------------------------------------------------------------------------
% calculate generalized proximity:
% Source points, Orientation, Polygon, Shape
% Input: 
%       Thetas: 2x4 array of orientation vectors of the two polygon to
%       compare
%       Edges: 2*1 cell array, each row is an array of boundary vertices of
%       a polygon
% Ooutput:
%       D: 1x4 array D(1) - Source distance
%                    D(2) - Orientation distance
%                    D(3) - Polygon distance
%                    D(4) - Shape distance
function [D,Dp,Ds] = GenProxDemo(normSP,Thetas,Edges, AEdges)
Theta1=Thetas(1,:); 
Theta2=Thetas(2,:);

SP1=Theta1(1:2); SP2=Theta2(1:2); 
normSP1 = normSP(1,:); normSP2 = normSP(2,:);

Edge1 = cell2mat(Edges(1,:)); Edge2 = cell2mat(Edges(2,:));
% ------------------------------------------------------------------------
% calculate source point distance
D(1) = sqrt(sum((normSP1-normSP2).^2));
% ------------------------------------------------------------------------
% calculate orientation distance
v1 = [Theta1(3)-Theta1(1) Theta1(4)-Theta1(2) 0];
v2 = [Theta2(3)-Theta2(1) Theta2(4)-Theta2(2) 0];
D(2) = abs(VecAng(v1,v2));
% ------------------------------------------------------------------------
% calculate polygon distance
[D(3),Dp] = HausdorffDist(Edge1,Edge2);
% D(3) = hausdorff( Edge1,Edge2 );
% ------------------------------------------------------------------------
% calculate hausdorff shape distance
AEdge1 = cell2mat(AEdges(1,:)); AEdge2 = cell2mat(AEdges(2,:));
% D(4) = hausdorff(AEdge1,AEdge2);
[D(4) Ds] = HausdorffDist(AEdge1,AEdge2);
end