%--------------------------------------------------------------------------
% sample 2D PDF
%--------------------------------------------------------------------------
function ksmp=RandPoint2D(P,Nsmp)

if(nargin<2) Nsmp=1; end

[Psrt,ksrt]=sort(P(:));
idx = Psrt>0;
i = find(Psrt>0,1);
% ksmp=ksrt(ceil(interp1(cumsum(Psrt),1:numel(P),rand(1,Nsmp),'linear','extrap')));
ksmp=ksrt(ceil(interp1(cumsum(Psrt(idx)),i:(i+sum(idx)-1),rand(1,Nsmp),'linear','extrap')));
