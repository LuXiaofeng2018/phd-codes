% combine the prior orientation vector to the steepest orientation vector

function [muMPPTheta,MPPTheta] = WMeanTheta(b, PTheta, TopoTheta, Pt, d, kai,range)
MinT = range(1); MaxT = range(2);

    % normalize both vectors
    V1 = PTheta(3:4)-PTheta(1:2);
    V1 = V1/norm(V1,2);
    V2 = TopoTheta(3:4)-TopoTheta(1:2);
    V2 = V2/norm(V2,2);

    % combine both vectors
    if ~isnan(V2)
        V = V1*b + (1-b)*V2;
        V = V/norm(V,2);
        V = V*d;
    else
        V = V1*d;
    end
        
    % New Pt
    NewPt = Pt + V;
    muMPPTheta = [Pt NewPt];
    % from vector to radius and sample from cauchy distribution

    [muTheta,Rho] = cart2pol(NewPt(1)-Pt(1),NewPt(2)-Pt(2));
    NewTheta = rand_generator_2(@WrappedCauchy,kai,muTheta,MinT,MaxT,1);

    [NewPt(1) NewPt(2)] = pol2cart(NewTheta,Rho);
    % New MPPTheta
    NewPt = NewPt + Pt;
    MPPTheta = [Pt NewPt];
end