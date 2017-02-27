%--------------------------------------------------------------------------
%   generate theta difference map from a point to a orientation number
% inputs:
%   GridInfo: parameter structures, defined in LobeDefinitions.m
%   pt: one upstream point
%   theta: the overal flow direction
%--------------------------------------------------------------------------
function [d_map_theta,t_map]=GenDThetaMap(GridInfo,Pt,theta)
        if nargin<3; theta = 0; end
        a_map_X = GridInfo.X - Pt(1);
        a_map_Y = GridInfo.Y - Pt(2);
        d_map_Pt = p_dist(GridInfo.X,GridInfo.Y, Pt);        
        a_map_sin = a_map_Y./d_map_Pt;
        a_map_cos = a_map_X./d_map_Pt;
        % compute angles within 360
        idx1 = (a_map_sin>=0)&(a_map_cos>0);
        idx2 = (a_map_sin>0)&(a_map_cos<=0);
        idx3 = (a_map_sin<=0)&(a_map_cos<0);
        idx4 = (a_map_sin<0)&(a_map_cos>=0);
        t_map = zeros(size(a_map_sin));
        t_map(idx1) = -acosd(a_map_cos(idx1));
        t_map(idx2) = -acosd(a_map_cos(idx2));
        t_map(idx3) = acosd(a_map_cos(idx3));
        t_map(idx4) = acosd(a_map_cos(idx4));
        d_map_theta = abs(t_map-theta);
        idx = (d_map_theta<=45);
        d_map_theta(~idx) = 0;
        d_map_theta(idx) = 45-d_map_theta(idx);
end