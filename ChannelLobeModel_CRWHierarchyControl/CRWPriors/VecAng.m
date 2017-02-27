% ------------------------------------------------------------------------
% compute the angle
% Input:
%       u,v: two 3d vectors 
% Output:
%       dtheta = the angle between u,v
function [dtheta] = VecAng(u,v)
   dtheta = rad2deg(atan2(norm(cross(u,v)),dot(u,v)));
end