% update the DMap with Cauchy-Lorentzian Equation
function [NewD] = Cauchy(DMap,Gamma)
    NewD = Gamma^2./(Gamma^2+DMap.^2);
end