% -------------------------------------------------------------------------
% generating lobe-channel outline given a centerline determined by 5 center
% points
% Inputs:
%       cpx: array of the centerline x coordinates
%       cpy: array of the centerline y coordinates
%       OutLineControl.L: lobe length
%       OutLineControl.f_w: lobe width/length ratio
%       OutLineControl.f_LOffset: L backwarding coefficient, usually I fix it at 0.15;
%       OutLineControl.oval_control: oval control coefficient, usually I fix it at -0.5;
% -------------------------------------------------------------------------
function [b1,b2,cline,LobeSourceHalfWidth] = LobeOutline(cpx,cpy,OutLineControl)
    Px = [cpx(1);cpx(:);cpx(end)]; 
    Py = [cpy(1);cpy(:);cpy(end)]; 
    f_w = OutLineControl.f_w;
    f_LOffset = OutLineControl.f_LOffset;
    oval_control = OutLineControl.oval_control;
    % -------------------------------------------------------------------------
    % interpolate the centerline points with Cardinal spline
    % -------------------------------------------------------------------------
    % when Tension=0 the class of Cardinal spline is known as Catmull-Rom spline
    Tension= 0;
    % avoid artifacts in boundaries
    set1x=[];
    set1y=[];
    n=100;
    for k=1:length(Px)-3
        [xvec,yvec]=EvaluateCardinal2DAtNplusOneValues([Px(k),Py(k)],[Px(k+1),Py(k+1)],[Px(k+2),Py(k+2)],[Px(k+3),Py(k+3)],Tension,n);
        set1x=[set1x, xvec];
        set1y=[set1y, yvec];    
    end
    idx = find((diff(set1x)==0)&(diff(set1y)==0));
    set1x(idx)=[];set1y(idx)=[];
    % -------------------------------------------------------------------------
    % choose the channel part 
    % -------------------------------------------------------------------------
    SourceX = cpx(3); SourceY = cpy(3);
    LobeSourceIdx = find((set1x==SourceX)&(set1y==SourceY));
    % -------------------------------------------------------------------------
    % take lobe section of the centerline
    LobeCtrLineX = set1x(LobeSourceIdx:end);
    LobeCtrLineY = set1y(LobeSourceIdx:end);
    % -------------------------------------------------------------------------
    % calculate the straight distance from lobe source to lobe end
    % [sd,ld]=ProjectedDistance(set1x,set1y);
    [LobeCtrStraightDist,LobeCtrLineDist]=ProjectedDistance(LobeCtrLineX,LobeCtrLineY);
    % -------------------------------------------------------------------------
    % get the hald lobe width along lobe centerline
    [LobeHalfWidth]=OvalShapeBound(LobeCtrLineDist,f_w,f_LOffset,oval_control);
    LCLDist = LobeHalfWidth(:,1)';LHW = LobeHalfWidth(:,2)';
    % -------------------------------------------------------------------------
    % get lobe source width
    LobeSourceHalfWidth = LHW(1);
%     OutLineControl.CW = LobeSourceHalfWidth; 
    % -------------------------------------------------------------------------
    % take channel section of the centerline
    ChannelCtrLineX = set1x(1:LobeSourceIdx-1);
    ChannelCtrLineY = set1y(1:LobeSourceIdx-1);
    % -------------------------------------------------------------------------
    % calculate the channle width
%     CHW = ones(size(ChannelCtrLineX))*LobeSourceHalfWidth;
    CHW = zeros(size(ChannelCtrLineX));
    % -------------------------------------------------------------------------
    % form the width array for the whole event
    w = [CHW,LHW];
    % -------------------------------------------------------------------------
    % calculate boundary coordinates
    x = [set1x(2),set1x];y = [set1y(2),set1y];
    dx = diff(x);dy = diff(y);
    idx = dx >0; % idx(1)=1;
    if dx(1)< 0
        idx(1)=1;
    else
        idx(1)=0;
    end
    
    by1 = set1y + sqrt(w.^2.*dx.^2./(dy.^2+dx.^2));
    % in the case that the centerline is not vertical
    bx1 = (set1y-by1).*dy./dx+set1x;
    
    by2 = set1y - sqrt(w.^2.*dx.^2./(dy.^2+dx.^2));
    % in the case that the centerline is not vertical    
    bx2 = (set1y - by2).*dy./dx + set1x;

    tempbx = zeros(size(bx1)); tempbx(idx) = bx1(idx); bx1(idx)=bx2(idx); bx2(idx)=tempbx(idx);
    tempby = zeros(size(by1)); tempby(idx) = by1(idx); by1(idx)=by2(idx); by2(idx)=tempby(idx);
    % in the case that the centerline is vertical
    % index for vertical part
    idx2 = dx==0;    
    idx3 = dy<0;% downstream centerline
    idx4 = dy>0;% upstream centerline
    idxVerDown = idx2&idx3;
    idxVerUp = idx2&idx4;
    % in the case that the centerline is vertically downward
    bx1(idxVerDown) = set1x(idxVerDown)-w(idxVerDown);
    bx2(idxVerDown) = set1x(idxVerDown)+w(idxVerDown);
    % in the case that the centerline is vertically upward
    bx1(idxVerUp) = set1x(idxVerUp)+w(idxVerUp);
    bx2(idxVerUp) = set1x(idxVerUp)-w(idxVerUp);
    idxt = find(idx2,1,'first');
    if idxt==true
        tempbx = bx1(idxt);
        bx1(idxt) = bx2(idxt);
        bx2(idxt) = tempbx;
    end
    b1 = [bx1' by1'];
    b2 = [bx2' by2'];
    cline = [set1x' set1y'];
%     % smooth the boundary to eleminate bound artifacts
%     hh=10;nn=320;
%     sr1 = ksrlin(bx1(1:nn),by1(1:nn),hh,nn); sr2 = ksrlin(bx2(1:nn),by2(1:nn),hh,nn);
%     sx1 = [sr1.x bx1(nn+1:end)];sy1 = [sr1.f by1(nn+1:end)];
%     sx2 = [sr2.x bx2(nn+1:end)];sy2 = [sr2.f by2(nn+1:end)];
%     b1 = [sx1' sy1'];
%     b2 = [sx2' sy2'];
%     cline = [set1x' set1y'];
end