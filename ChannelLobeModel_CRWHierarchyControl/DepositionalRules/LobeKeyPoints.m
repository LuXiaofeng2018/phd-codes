% ---------------------------------------------------------------------
%       Input:
%           Line: A line defined by two points
%           VTheta: range of the orientation
%           L: Lobe length
%       Output:
%           p: Lobe end and intermediate points
function [P] = LobeKeyPoints(Line,VTheta, L)
    vx = Line(2,1)-Line(1,1);
    vy = Line(2,2)-Line(1,2);
    [Theta_avg,rho] = cart2pol(vx,vy);
    Theta_avg = radtodeg(Theta_avg);
    Theta = Theta_avg + VTheta*randn;
    endpoint = Line(2,:) + L*[cosd(Theta),sind(Theta)];
%     midpoint = (Line(2,:)+endpoint)/2;
%     P = round([midpoint;endpoint]);
    P = round(endpoint);
end