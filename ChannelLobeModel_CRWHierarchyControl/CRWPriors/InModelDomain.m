% test if a point is within the modeling domain
function [iflag] = InModelDomain(Pt, X, Y, dx)
    DMap = sqrt((X-Pt(1)).^2 + (Y-Pt(2)).^2);
    [MinD, iMinD] = min(DMap(:));
    iflag = MinD <= dx;
end