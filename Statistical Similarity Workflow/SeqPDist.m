
% X: the input for pdist

function [SeqPDist]=SeqPDist(X)
    [ny,nx]=size(X);
    if ny~=nx
        SqrPD = squareform(pdist(X));
    else 
        SqrPD = X;
    end
    n = length(X);
    m = n*(n-1)/2;
    SeqPDist = zeros(1,m);
    ind=1;
    while ind<=m
        for i=1:n
            TempD=0;
            for j=i:n-1
                TempD = TempD+SqrPD(j,j+1);
                SeqPDist(ind)=TempD;
                ind = ind+1;
            end
        end
    end
end