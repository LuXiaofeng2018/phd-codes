% ------------------------------------------------------------------------
% compute the angle in range [0, 2PI]
% Input:
%       u,v: two 3d vectors (from v clockwise to u)
% Output:
%       dtheta = the angle between u,v
function [dtheta] = VecAng2PI(u,v)
%    dtheta = rad2deg(atan2(norm(cross(u,v)),dot(u,v)));
   x1 = u(1); y1 = u(2);
   x2 = v(1); y2 = v(2);
   dtheta = rad2deg(mod(atan2(x1*y2-x2*y1,x1*x2+y1*y2),2*pi)); % Range: 0 to 2*pi radians
%    dtheta = mod(atan2(x1*y2-x2*y1,x1*x2+y1*y2),2*pi); % Range: 0 to 2*pi radians
end