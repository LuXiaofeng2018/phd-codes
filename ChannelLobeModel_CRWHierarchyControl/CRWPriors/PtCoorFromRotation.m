function [vr, newpt] = PtCoorFromRotation(v, angle, pt)
%ROTATEVECTOR Rotate a vector by a given angle
%
%   VR = rotateVector(V, THETA)
%   Rotate the vector V by an angle THETA, given in radians.

% precomputes angles
cot = cosd(angle);
sit = sind(angle);

% compute rotated coordinates
vr = [cot * v(:,1) + sit * v(:,2) , -sit * v(:,1) + cot * v(:,2)];

% compute new point location
newpt = pt + vr;