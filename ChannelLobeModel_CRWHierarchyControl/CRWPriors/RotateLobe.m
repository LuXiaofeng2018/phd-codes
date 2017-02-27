% rotate lobe orientation for dTheta round the MPP
function [VThetaLobe,SimdTheta] = RotateLobe(PVThetaLobe, dTheta, MPP, L)
    % calculating angle vector
        V0 = PVThetaLobe(3:4)-PVThetaLobe(1:2);
        V1 = V0/norm(V0,2)*L;
        [vr, pt] = PtCoorFromRotation(V1,dTheta,MPP);
        VThetaLobe = [MPP pt];
    % check rotation    
        v = V1;
        v = [v 0];
        u = VThetaLobe(3:4)-VThetaLobe(1:2);
        u = [u 0];
        SimdTheta = VecAngMinusPI(u,v);
end