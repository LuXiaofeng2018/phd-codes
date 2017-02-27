% L1norm-based bootstrap one tail hypothesis test for two samples
% H0: the two samples are from a same distribution
% input:
%      X1, X2: two samples
%      nRedraw: # of redraws in bootstrap
function [L1Norm, PVal, L1NRedraws] = BootstrapTest2(X1, X2, nRedraw)

% calculate the L1-norm between ecdfs of samples
    QtlIdx = [1:100]./100;    
    q1 = quantile(X1,QtlIdx);
    q2 = quantile(X2,QtlIdx);
    L1Norm = norm(q1-q2,1);
% bootstrap hypothesis test 
    N1 = length(X1);
    N2 = length(X2);
    L1NRedraws = zeros(nRedraw,1);
    
    pool = [X1;X2];
    for iter=1:nRedraw
        S1Redraw = randsample(N1+N2,N1);
        X1Redraw = pool(S1Redraw);
        q1 = quantile(X1Redraw,QtlIdx);
        
        S2Redraw = randsample(N1+N2,N2);
        X2Redraw = pool(S2Redraw);
        q2 = quantile(X2Redraw,QtlIdx);
        
        L1NRedraws(iter) = norm(q1-q2,1);
    end
% find the correlated P-value of the true L1Norm in the boostrap
% distribution
    [F,XVal] = ecdf(L1NRedraws);
    
    [YVal,IND] = min(abs(XVal - L1Norm));
    PVal = 1 - F(IND);
end