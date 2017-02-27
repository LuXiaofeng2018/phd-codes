% simulate Correlated Random Walk (One step)
% Input:
%   RMpp: 1*n array, empirical data of MPP migration distance distance
%   ThetaMPP: 1*n array, empirical data of MPP shifting angle
%   ThetaLobe: 1*n array, empirical data of Lobe Orientation shifting angle
%   PTheta: 1*4 matrix, vector of previous flow orientation [x0, y0, x1,y1]
%   (x0,y0): previous node; (x1,y1): current node
%   orientation
% Output:
%   Pt: simulated NSteps * 2 pionts sequence: Pt(i,:) = [xi, yi];
%   dMPP,tMPP,tLobe: NSteps * 1 arrays, recording MPP migrating ditance(D), MPP
%   shifting angles(T), Lobe orientation shifting angle(L)
%   VThetaMPP: sequence of MPP migrating direction vectors
function [SimDMPP,SimTLobe] = ...
    Seq_Priors(dRMPP,dThetaLobe)

    % draw a MPP migrating distance
        d = emprand(dRMPP);
        SimDMPP = d(1);
    % draw a lobe shifting angle
        tlobe = MyEmprand(dThetaLobe,1);
        SimTLobe = tlobe(1);
end