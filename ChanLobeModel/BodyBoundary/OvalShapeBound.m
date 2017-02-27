% -------------------------------------------------------------------------
% Given a centerline, generate half width corresponding to each point
% -------------------------------------------------------------------------
% Input: 
%       Centerline: a 1-D increasing array representing Euclidean distance from a
%       centerline point to the channel source
%       f_W: width/length ratio
%       f_LOffset: L backwarding coefficient
%       c: oval control coefficient
% Output:
%       HalfWidth: nx2 matrix, the 2nd column is the half width shape

function [HalfWidth]=OvalShapeBound(CenterLine, f_W, f_LOffset, c)
        % -------------------------------------------------------------------------
        % input geometric parameters
        LScale = CenterLine(end); 
        % settting up values
        d = CenterLine/LScale;        
        L = d(end);
        W = f_W*L;        
        % derived geometric coefficients
        a = (1 + f_LOffset)*L/2; % primary axis
        b = W/2; % minor axis
        % -------------------------------------------------------------------------
        LOffset = -a+f_LOffset*L;
        w = sqrt(b^2./(exp(c*(d+LOffset))).*(1-(d+LOffset).^2/a^2));
        w(w<1e-15)=0;
        HalfWidth = [d',w']*LScale;
end












